
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_BLKD11.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_BLKD11 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_BLKD11 
   BEFORE INSERT OR UPDATE OF blkd
   ON accounts
   FOR EACH ROW
     WHEN (NEW.blkd in (11, 19, 40) OR (OLD.blkd in (11, 19, 40) AND NEW.blkd = 0)) DECLARE
   /* 03/08/2015 Евгений Сошко, Инга Павленко Заявка http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3507
      В картці рахунку на вкладці «Фінансові» в полі «Блокування по дебету» передбачити параметр
      «Заарештувати частково» та водночас забезпечити при виборі цього параметру обов’язковий
      контроль введення значення в поле «мінімальний залишок» з метою забезпечення можливості
      здійснювати виплату коштів з рахунків, на які накладено арешт, в межах суми коштів,
      що складають надлишок понад суму накладеного арешту.


      Сокіл Олена Анатолівна added a comment - 17/Jul/15 2:44 PM
      Зверніть, будь ласка, увагу, що умовами типового депозитного договору передбачено наступне
      : «...У разі накладення арешту на Депозит/ його частину Банк припиняє нарахування процентів
      по Рахунку з дня надходження до Банку документів про арешт. Поновлення нарахування процентів
      здійснюється з дня, наступного за днем зняття арешту...»

      Тому прошу при здійсненні часткового арешту рахунку вкладу
      (після встановлення в картці рахунку на вкладці «Фінансові» в полі «Блокування по дебету»
      параметру «Заарештувати частково» та заповнення поля «мінімальний залишок») забезпечити припинення
      нарахування відсотків по депозиту з дати накладення арешту.
      Нарахування відсотків має відновитися лише після зняття арешту з дня,
      наступного за днем зняття арешту.
      При цьому відсотки не повинні нараховуватися за період
      дії арешту (з дати накладення арешту до дати зняття арешту включно).
      
      02/11/2018 В рамках COBUMMFO-9697 добавлены коды блокировки 40 и 19 для 2630
   */
   is_dp   INT := 0;      -- признак, относится к депозитным портфелям или нет
   l_id    int_ratn.id%TYPE;
   l_ir    int_ratn.ir%TYPE;
   l_br    int_ratn.br%TYPE;
   l_op    int_ratn.op%TYPE;

   FUNCTION f_is_dp (p_acc accounts.nbs%TYPE, p_nbs accounts.nbs%TYPE)
      RETURN INT
   IS
   BEGIN
      IF :OLD.TIP NOT LIKE 'W4%' THEN
        BEGIN
           SELECT 1
             INTO is_dp
             FROM dpt_accounts
            WHERE accid = p_acc;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              IF p_nbs IN ('2620',
                           '2628',
                           '2630',
                           '2635',
                           '2638',
                           '2610',
                           '2618',
                           '2615',
                           '2650',
                           '2658')
              THEN
                 is_dp := 1;
              ELSE
                 is_dp := 0;
              END IF;
        END;
      END IF;
      RETURN is_dp;
   END;
BEGIN
   IF :NEW.BLKD = 11 AND NVL (COALESCE (:NEW.LIM, :OLD.LIM), 0) = 0
   THEN
      bars_error.raise_nerror ('CAC', 'ERR_BLKD11');
   ELSE
      IF :NEW.blkd in (11, 19, 40)
      THEN
         BEGIN
            -- 1. Проверим, относится ли частично блокируемый счет к депозитному портфелю
            is_dp := f_is_dp (p_acc => :old.acc, p_nbs => :old.nbs);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN;
         END;
         
         IF :NEW.blkd in (19, 40) AND :old.nbs <> '2630' --COBUMMFO-9697
           THEN is_dp := 0;
         END IF;  

         -- 1.a Вычитаем параметры действующей процентной карточки счета
         IF NVL (IS_DP, 0) = 1
         THEN
            BEGIN
               SELECT ia.id, 0
                 INTO l_id, l_ir
                 FROM int_ratn it, int_accn ia
                WHERE     it.acc = ia.acc
                      AND it.acc = :old.acc
                      AND it.bdat = (SELECT MAX (bdat)
                                       FROM int_ratn
                                      WHERE acc = it.acc AND id = ia.id);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BARS_ERROR.RAISE_NERROR ('CAC', 'ERR_BLKD11_DPT');
            END;

            -- 2. Устанавливаем в процентной карточке значение ставки = 0
            BEGIN
               INSERT INTO int_ratn (ACC,
                                     ID,
                                     BDAT,
                                     IR,
                                     BR,
                                     OP,
                                     IDU)
                    VALUES (:old.acc,
                            l_id,
                            gl.bd,
                            l_ir,
                            NULL,
                            NULL,
                            user_id); -- инд проц ставка = 0 с момента начала ареста
            EXCEPTION
               WHEN DUP_VAL_ON_INDEX
               THEN
                  RETURN;
            END;
         END IF;
      ELSIF (:OLD.blkd in (11, 19, 40) AND :NEW.blkd = '0')
      THEN
         -- 1. Проверим, относится ли частично блокируемый счет к депозитному портфелю
         BEGIN
            -- 1. Проверим, относится ли частично блокируемый счет к депозитному портфелю
            is_dp := f_is_dp (p_acc => :old.acc, p_nbs => :old.nbs);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN;
         END;

         IF :OLD.blkd in (19, 40) and :old.nbs <> '2630' --COBUMMFO-9697
           THEN is_dp := 0;
         END IF;
         
         IF NVL (is_dp, 0) = 1
         THEN
            -- 1.a Вычитаем параметры действующей процентной карточки счета
            BEGIN
               SELECT ir0.id,
                      ir0.ir,
                      ir0.br,
                      ir0.op
                 INTO l_id,
                      l_ir,
                      l_br,
                      l_op
                 FROM int_ratn ir0
                WHERE     acc = :old.acc
                      AND bdat =
                             (SELECT MAX (bdat)
                                FROM (SELECT it.acc,
                                             it.id,
                                             it.bdat,
                                             LEAD (it.bdat)
                                                OVER (ORDER BY it.acc)
                                                bdat2,
                                             it.ir
                                        FROM int_ratn it, int_accn ia
                                       WHERE     it.acc = ia.acc
                                             AND it.acc = :old.acc)
                               WHERE bdat2 IS NOT NULL);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BARS_ERROR.RAISE_NERROR ('CAC', 'ERR_BLKD11_DPT_PR');
            END;

            -- 2. Восстанавливаем в процентной карточке значение ставки = предыдущее значение перед 0
            BEGIN
               INSERT INTO int_ratn (ACC,
                                     ID,
                                     BDAT,
                                     IR,
                                     BR,
                                     OP,
                                     IDU)
                    VALUES (:old.acc,
                            l_id,
                            gl.bd + 1,
                            l_ir,
                            l_br,
                            l_op,
                            user_id); -- инд проц ставка = 0 с момента начала ареста
            EXCEPTION
               WHEN DUP_VAL_ON_INDEX
               THEN
                  DELETE FROM int_ratn
                        WHERE acc = :old.acc AND bdat = gl.bd;
            END;
         END IF;
      END IF;
   END IF;
END TIU_BLKD11;



/
ALTER TRIGGER BARS.TIU_BLKD11 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_BLKD11.sql =========*** End *** 
PROMPT ===================================================================================== 
