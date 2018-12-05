

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_CHECKBLK ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK 
   BEFORE UPDATE OF blkd
   ON accounts
   FOR EACH ROW
DECLARE
   l_acc_blkid   NUMBER;
   l_dpa_blk     NUMBER;
   l_nbs         VARCHAR2 (4);
   l_fnr         lines_f.fn_r%TYPE;
   l_idpr        lines_f.id_pr%TYPE;
   l_err         lines_f.err%TYPE;
   l_dat         lines_f.dat%TYPE;
   i             NUMBER;
BEGIN
   -- "Рахунок не введено в дію"
   l_acc_blkid := NVL (TO_NUMBER (getglobaloption ('ACC_BLKID')), 0);
   -- "Заблоковано до отримання повідомлення про реєстрацію рахунку в ДПА"
   l_dpa_blk := NVL (TO_NUMBER (getglobaloption ('DPA_BLK')), 0);

   -- Проверка на блокировку "Рахунок не введено в дію"
   --    (устанавливается автоматически при открытии счета для проверки параметров).
   --    Пока счет заблокирован, в ДПА информация не отсылается.
   --    Изменить код блокировки может пользователь, которому дан такой доступ.
   IF l_acc_blkid > 0
   THEN
      -- изменение блокировки
      IF     (:new.blkd <> :old.blkd)
         AND (:new.blkd = l_acc_blkid OR :old.blkd = l_acc_blkid)
      THEN
         -- проверка на пользователя
         -- если пользователю выдана функция, значит ему можно менять
         BEGIN
            SELECT 1
              INTO i
              FROM v_mainmenu_list
             WHERE     id = user_id
                   AND UPPER (funcname) LIKE
                          'FUNNSIEDITF%V_ACC_BLK_ACT%P_ACC_UNBLOCKACT%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               -- 14_06_17 получение инфо по причине появления ошибки
               bars_audit.info('DPA before err - user_id: ' || user_id );
               -- Запрещено блокировать/разблокировать счет кодом 'Не введен в действие'
               bars_error.raise_nerror ('CAC', 'ACCOUNT_BLK_ACT_ERROR');
         END;

         -- если счет отправляется в ДПА, ставим код блокировки "Заблоковано до отримання повідомлення про реєстрацію рахунку в ДПА"
         IF l_dpa_blk > 0
         THEN
            IF     :old.blkd = l_acc_blkid
               AND :new.blkd <> l_acc_blkid
               AND NVL (:new.vid, 0) > 0
            THEN
               -- балансовые счета только из табл. dpa_nbs
               BEGIN
                  SELECT UNIQUE nbs
                    INTO l_nbs
                    FROM dpa_nbs
                   WHERE TYPE IN ('DPA', 'DPK', 'DPP') AND nbs = :new.nbs;

                  :new.blkd := l_dpa_blk;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               END;
            END IF;
         END IF;
      END IF;
   END IF;

   -- Проверка на блокировку "Заблоковано до отримання повідомлення про реєстрацію рахунку в ДПА"
   --    (устанавливается автоматически при открытии счета).
   --    Блокировка снимается автоматически при получении сообщения из ДПА.
   --    При ручном разблокировании нужна проверка.
   -- код блокировки указан
   IF l_dpa_blk > 0
   THEN
      IF :old.blkd >= l_dpa_blk AND :new.blkd < l_dpa_blk AND :new.vid <> 0
      THEN
         -- счет ДПА?
         BEGIN
            SELECT 1
              INTO i
              FROM dpa_nbs
             WHERE     TYPE IN ('DPA', 'DPK', 'DPP')
                   AND nbs = :new.nbs
                   AND taxotype IN (1, 6)
                   AND ROWNUM = 1;

            -- была отправка в ДПА?
            BEGIN
               SELECT distinct
			          fn_r,
                      id_pr,
                      err,
                      dat
                 INTO l_fnr,
                      l_idpr,
                      l_err,
                      l_dat
                 FROM lines_f f
                WHERE     nls = :new.nls
                      AND kv = :new.kv
                      AND otype IN (1, 6)
                      AND dat =
                             (SELECT MAX (dat)
                                FROM lines_f
                               WHERE     nls = f.nls
                                     AND kv = f.kv
                                     AND otype IN (1, 6));

               IF    (                                -- получена квитанция @R
                       (  l_fnr LIKE '@R%' OR l_fnr LIKE '@I%')
                      AND -- 0-без помилок
                          -- 5-Рахунок вже перебуває на обліку
                          NVL (l_idpr, 0) IN (0, 5)
                      AND --  0000-без помилок
                          NVL (l_err, '0000') = '0000')
                  OR (                               -- получена квитанция @F2
                      l_fnr LIKE '@F2%' AND -- не пізніше наступного робочого дня при наявності квитанцій @F1 та @F2 забезпечити розблокування рахунку
                                            TRUNC (l_dat) < bankdate)
               THEN
                  -- все нормально
                  NULL;
               ELSE
                  -- 28_09_17 убираем временно запрет на разбокировку, если не получен ответ от ДПА
                  -- в связи с потребностью принимать квитанции, которые отправлялись по почте, сохраняем инфомацию по изменениям блокировки
                  IF :old.blkd = 26 and :new.blkd = 0 THEN
                    bars_audit.info('DPA ручная разблокировка счёта по квитанции из налоговой, для счёта: ' || :new.nls
                                    || ' валюты: ' || :new.kv
                                    || ' выполнил пользователь: ' || sys_context('userenv', 'session_user')
                                    || ' отделение: ' || sys_context('bars_context','user_branch')
                                    || ' отделение: ' || sys_context('bars_context','user_branch')
                                    || ' старая блокировка: ' || :old.blkd
                                    || ' новая блокировка: ' || :new.blkd
                                    || ' дата: ' || sysdate
                                    );
                  ELSE
                   -- Запрещено разблокировать счет до получения сообщения о регистации счета из ДПА
                   bars_error.raise_nerror ('CAC', 'ACCOUNT_BLK_DPA_ERROR');
                  END IF;
               END IF;
            -- счет в ДПА не отправлялся (м.б. старый счет)
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;
   END IF;
END;



/
ALTER TRIGGER BARS.TBU_ACCOUNTS_CHECKBLK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_CHECKBLK.sql =========*
PROMPT ===================================================================================== 
