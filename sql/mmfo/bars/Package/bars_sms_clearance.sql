
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms_clearance.sql =========*** 
 PROMPT ===================================================================================== 
 
 CREATE OR REPLACE PACKAGE BODY bars_sms_clearance
IS
   ----
   --  Package bars_sms_clearance - пакет процедур для подготовки дебиторской задолженности за  SMS-сообщения
   --

   g_body_version      CONSTANT VARCHAR2 (64) := 'version 1.03 23/08/2015';

   g_awk_body_defs     CONSTANT VARCHAR2 (512) := '';

   -- маска формата для преобразования char <--> number
   g_number_format     CONSTANT VARCHAR2 (128) := 'FM999999999999999999990D00';
   -- параметры преобразования char <--> number
   g_number_nlsparam   CONSTANT VARCHAR2 (30)
                                   := 'NLS_NUMERIC_CHARACTERS = ''. ''' ;
   -- маска формата для преобразования char <--> date
   g_date_format       CONSTANT VARCHAR2 (30) := 'YYYY.MM.DD HH24:MI:SS';

   --глобальний параметрт ОВ22 для рахунків 3570
   g_ob22              CONSTANT VARCHAR2 (2) := '33';

   --глобальний параметрт ОВ22 для рахунків 3579
   g_ob22_exp          CONSTANT VARCHAR2 (2) := '88';

   --глобальний параметрт ОВ22 для рахунків 6110
   g_ob22_6110          CONSTANT VARCHAR2 (2) := 'E8';

   --глобальний параметрт код валюти
   g_kv                 CONSTANT NUMBER(3) := 980;

   --глобальний параметрт ОВ22 для рахунків 3570
   g_tt                CONSTANT VARCHAR2 (3) := 'SMS';

   --глобальна ознака YES на відправку смс, тощо
   g_yes               CONSTANT VARCHAR2 (1) := 'Y';

   --к-во сообщений за период
   TYPE r_sms IS RECORD
   (
      msg_id    NUMBER,
      sms_cnt   NUMBER
   );

   -- table of records
   TYPE t_sms IS TABLE OF r_sms;

   --init table
   sms_table                    t_sms;
   --error block
   g_erm                        VARCHAR2 (2000);
   g_err                        EXCEPTION;
   g_err_num                    NUMBER;

   ------------------------------------------------------------------------------

   ----
   -- header_version - возвращает версию заголовка пакета
   --
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package header BARS_SMS_ACC '
             || g_header_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_header_defs;
   END header_version;

   ----
   -- body_version - возвращает версию тела пакета
   --
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package body BARS_SMS_ACC '
             || g_body_version
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || g_awk_body_defs;
   END body_version;

   ----
   -- init - инициализация пакета
   --
   PROCEDURE init
   IS
   BEGIN
      NULL;
   END init;



   ---
   -- open_3579 -відкриття рахунку 3579 для виставлення простроченої заборгованості за СМС по рахунку.
   --

   PROCEDURE open_3579 (p_acc_parent          accounts.acc%TYPE,
                        p_acc_clearance_exp   OUT accounts.acc%TYPE)
   IS
      acc_       NUMBER;                                          --  ACC 2600
      nls_       VARCHAR2 (15);                                   --  NLS 2600
      acc1_      NUMBER;                                          --  ACC 3579
      nls_3579   VARCHAR2 (15);                                   --  NLS 3579
      nms_       VARCHAR2 (70);                                        --  NMS
      isp_       NUMBER;                                               --  ISP
      i          INT;
      tmp_3579   VARCHAR2 (15);
      tobo_      VARCHAR2 (30);
      grp_       NUMBER;
      tmp_       NUMBER;
      rnk_       NUMBER;
   BEGIN
      logger.info ('open_3579. Для счета ACC=' || p_acc_parent);

      SELECT NLS,
             ACC,
             ISP,
             NMS,
             TOBO,
             GRP,
             rnk
        INTO nls_,
             acc_,
             isp_,
             nms_,
             tobo_,
             grp_,
             rnk_
        FROM Accounts
       WHERE acc = p_acc_parent;

      BEGIN
         logger.debug ('gl.aMFO=' || gl.aMFO || ' nls_ = ' || nls_);
         nls_3579 :=
            VKRZN (SUBSTR (gl.aMFO, 1, 5), '3579' || SUBSTR (nls_, 5));

         SELECT NLS
           INTO tmp_3579
           FROM accounts
          WHERE     NLS = nls_3579
                AND KV = g_kv
                AND (RNK <> rnk_ OR OB22 <> g_ob22_exp OR DAZS IS NOT NULL);

         --   Cчет 3579<хвост 35XX> уже есть:
         --        --  НА ДРУГОМ RNK   или
         --        --  с OB22<>'88'    или
         --        --  он ЗАКРЫТ !
         --   Подбираем другой счет по маске:  3579 k S NN RRRRRR
         --   где:  S  - 6-ая цифра из 35XX*

         i := 1;

         LOOP
            nls_3579 :=
               vkrzn (
                  SUBSTR (gl.aMFO, 1, 5),
                     '3579'
                  || '0'
                  || SUBSTR (nls_, 6, 1)
                  || LPAD (TO_CHAR (i), 2, '0')
                  || LPAD (TO_CHAR (rnk_), 6, '0'));

            BEGIN                                      -- Есть ли такой счет ?
               SELECT NLS
                 INTO tmp_3579
                 FROM accounts
                WHERE     NLS = nls_3579
                      AND KV = g_kv
                      AND (RNK <> rnk_ OR OB22 <> g_ob22_exp OR DAZS IS NOT NULL);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  EXIT;                   -- такого счета еще нет, - открываем
            END;

            i := i + 1;

            IF i = 100
            THEN
               EXIT;
            END IF;
         END LOOP;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;                          ---------- END подбора номера 3579*  -----

      logger.info ('open_3579. g_tt=' || g_tt);


      OP_REG (99,
              0,
              0,
              grp_,
              tmp_,
              rnk_,
              nls_3579,
              g_kv,
              SUBSTR ('Нар.дох.SMS за прострочення до 31g' || nms_, 1, 70),
              'ODB',
              isp_,
              acc1_);

      ----  Наследование Доступа из 3570:
      p_setAccessByAccmask (acc1_, acc_);

      ----  Добавление Доступа по GROUPS_NBS:
      FOR n IN (SELECT ID
                  FROM GROUPS_NBS
                 WHERE NBS = '3579')
      LOOP
         sec.addAgrp (acc1_, n.ID);
      END LOOP;

      UPDATE accounts
         SET TOBO = tobo_
       WHERE ACC = acc1_;


               BEGIN
                 INSERT INTO Specparam (ACC,S240,S270)  VALUES (acc1_,'C','01');
               EXCEPTION WHEN OTHERS THEN
                 if SQLCODE =-20000
                 then RAISE;
                 else
                 UPDATE Specparam SET S240='C', S270='01' WHERE  ACC=acc1_;
                 end if;
               END;

               BEGIN
                 INSERT INTO Specparam_INT (ACC,OB22)  VALUES (acc1_,g_ob22_exp);
               EXCEPTION WHEN OTHERS THEN
                 if SQLCODE =-20000
                 then RAISE;
                 else
                 UPDATE Specparam_INT SET OB22 = g_ob22_exp  WHERE  ACC=acc1_;
                 end if;
               END;

      p_acc_clearance_exp := acc1_;

      --заносимо дані в таблицю зв'язку рахунок=рахунок оплати за СМС
      INSERT INTO SMS_ACC_CLEARANCE_EXP (ACC_CLEARANCE, ACC_CLEARANCE_EXP)
           VALUES (p_acc_parent, p_acc_clearance_exp);


      logger.info (
            'open_3579. для счета ACC='
         || p_acc_parent
         || 'відкрито 3579 = '
         || p_acc_clearance_exp );
   END open_3579;

   -- знаходить рахунок для переносу заборгованост на прострочкуі, при відсутності рахунку створює його
   --

   PROCEDURE find_clearance_acc_exp
                                (p_acc_clearance      IN     accounts.acc%TYPE,
                                 p_acc_clearance_exp  OUT accounts.acc%TYPE)
   IS
   BEGIN
      --шукаємо рахунок абонплати за СМС для даного рахунку
      BEGIN
         SELECT ACC_CLEARANCE_EXP
           INTO p_acc_clearance_exp
           FROM SMS_ACC_CLEARANCE_EXP
          WHERE acc_clearance = p_acc_clearance;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            --якщо не знайшли - відкриваємо
            open_3579 (p_acc_clearance, p_acc_clearance_exp);
         when others
         then raise;
      END;

      logger.info (
            'find_clearance_acc_exp. Для счета ACC='
         || p_acc_clearance
         || ' знайдено рахунок = '
         || p_acc_clearance_exp);
   END find_clearance_acc_exp;

   ---
   -- open_3570 -відкриття рахунку 3570 для виставлення заборгованості за СМС по рахунку.
   --

   PROCEDURE open_3570 (p_acc_parent          accounts.acc%TYPE,
                        p_acc_clearance   OUT accounts.acc%TYPE)
   IS
      acc_       NUMBER;                                          --  ACC 2600
      nls_       VARCHAR2 (15);                                   --  NLS 2600
      acc1_      NUMBER;                                          --  ACC 3570
      nls_3570   VARCHAR2 (15);                                   --  NLS 3570
      nms_       VARCHAR2 (70);                                        --  NMS
      isp_       NUMBER;                                               --  ISP
      i          INT;
      tmp_3570   VARCHAR2 (15);
      tobo_      VARCHAR2 (30);
      grp_       NUMBER;
      tmp_       NUMBER;
      rnk_       NUMBER;
      l_acc_clearance_exp NUMBER;                                 --  ACC 3579

   BEGIN
      logger.info ('open_3570. Для счета ACC=' || p_acc_parent);

      SELECT NLS,
             ACC,
             ISP,
             NMS,
             TOBO,
             GRP,
             rnk
        INTO nls_,
             acc_,
             isp_,
             nms_,
             tobo_,
             grp_,
             rnk_
        FROM Accounts
       WHERE acc = p_acc_parent;

      BEGIN
         logger.debug ('gl.aMFO=' || gl.aMFO || ' nls_ = ' || nls_);
         nls_3570 :=
            VKRZN (SUBSTR (gl.aMFO, 1, 5), '3570' || SUBSTR (nls_, 5));

         SELECT NLS
           INTO tmp_3570
           FROM accounts
          WHERE     NLS = nls_3570
                AND KV = g_kv
                AND (RNK <> rnk_ OR OB22 <> g_ob22 OR DAZS IS NOT NULL);

         --   Cчет 3570<хвост 26XX> уже есть:
         --        --  НА ДРУГОМ RNK   или
         --        --  с OB22<>'33'    или
         --        --  он ЗАКРЫТ !
         --   Подбираем другой счет по маске:  3570 k S NN RRRRRR
         --   где:  S  - 6-ая цифра из 26XX*

         i := 1;

         LOOP
            nls_3570 :=
               vkrzn (
                  SUBSTR (gl.aMFO, 1, 5),
                     '3570'
                  || '0'
                  || SUBSTR (nls_, 6, 1)
                  || LPAD (TO_CHAR (i), 2, '0')
                  || LPAD (TO_CHAR (rnk_), 6, '0'));

            BEGIN                                      -- Есть ли такой счет ?
               SELECT NLS
                 INTO tmp_3570
                 FROM accounts
                WHERE     NLS = nls_3570
                      AND KV = g_kv
                      AND (RNK <> rnk_ OR OB22 <> g_ob22 OR DAZS IS NOT NULL);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  EXIT;                   -- такого счета еще нет, - открываем
            END;

            i := i + 1;

            IF i = 100
            THEN
               EXIT;
            END IF;
         END LOOP;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;                          ---------- END подбора номера 3570*  -----

      logger.info ('open_3570. g_tt=' || g_tt);


      OP_REG (99,
              0,
              0,
              grp_,
              tmp_,
              rnk_,
              nls_3570,
              g_kv,
              SUBSTR ('Нар.дох.SMS ' || nms_, 1, 70),
              'ODB',
              isp_,
              acc1_);

      ----  Наследование Доступа из 2600:
      p_setAccessByAccmask (acc1_, acc_);

      ----  Добавление Доступа по GROUPS_NBS:
      FOR n IN (SELECT ID
                  FROM GROUPS_NBS
                 WHERE NBS = '3570')
      LOOP
         sec.addAgrp (acc1_, n.ID);
      END LOOP;

      UPDATE accounts
         SET TOBO = tobo_
       WHERE ACC = acc1_;

      BEGIN
         INSERT INTO Specparam (ACC, R013, S240)
              VALUES (acc1_, '3', '1');
      EXCEPTION
         WHEN OTHERS
         THEN
        if SQLCODE =-20000
                 then RAISE;
                 else

            UPDATE Specparam
               SET R013 = '3', S240 = '1'
             WHERE ACC = acc1_;
             end if;
      END;

      BEGIN
         INSERT INTO Specparam_INT (ACC, OB22)
              VALUES (acc1_, g_ob22);
      EXCEPTION
         WHEN OTHERS
         THEN
         if SQLCODE =-20000
                 then RAISE;
                 else

            UPDATE Specparam_INT
               SET OB22 = g_ob22
             WHERE ACC = acc1_;
             end if;
      END;

      p_acc_clearance := acc1_;

      --заносимо дані в таблицю зв'язку рахунок=рахунок оплати за СМС
      INSERT INTO SMS_ACC_CLEARANCE (acc, ACC_CLEARANCE)
           VALUES (p_acc_parent, p_acc_clearance);


      logger.info (
            'open_3570. для счета ACC='
         || p_acc_parent
         || 'відкрито 3570 = '
         || p_acc_clearance);

   --відкриваємо 3579,оскільки він 100% ще не відкритий немає сенсу його шукати
    open_3579(p_acc_clearance,l_acc_clearance_exp);

   END open_3570;
   ----
   -- знаходить рахунок для виставлення заборгованості, при відсутності рахунку створює його
   --

   PROCEDURE find_clearance_acc (p_acc_parent      IN     accounts.acc%TYPE,
                                 p_rnk             IN     customer.rnk%TYPE,
                                 p_acc_clearance      OUT accounts.acc%TYPE)
   IS
   BEGIN
      --шукаємо рахунок абонплати за СМС для даного рахунку
      BEGIN
         SELECT ACC_CLEARANCE
           INTO p_acc_clearance
           FROM SMS_ACC_CLEARANCE
          WHERE acc = P_ACC_PARENT;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            --якщо не знайшли - відкриваємо
            open_3570 (P_ACC_PARENT, p_acc_clearance);
         when others
         then raise;
      END;

      logger.info (
            'find_clearance_acc. Для счета ACC='
         || p_acc_parent
         || ' знайдено рахунок = '
         || p_acc_clearance);
   END;


   ----
   -- знаходить рахунок для виставлення заборгованості для клієнта(для одного 3570 на всі рахунки клієнта)
   --, при відсутності рахунку створює його
   --

   PROCEDURE set_clearance_acc (p_acc_parent IN accounts.acc%TYPE)
   IS
      l_acc_clearance   accounts.acc%TYPE;
   BEGIN
      --шукаємо рахунок абонплати за СМС для рахунків даного клієнта
      BEGIN
         SELECT MAX (ACC_CLEARANCE)
           INTO l_acc_clearance
           FROM SMS_ACC_CLEARANCE t1, accounts t2, accounts t3
          WHERE     T1.ACC_CLEARANCE = t2.acc
                AND T2.DAZS IS NULL
                AND t3.acc = p_acc_parent
                AND T3.rnk = t2.rnk;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            --якщо не знайшли - відкриваємо
            --open_3570 (P_ACC_PARENT, l_acc_clearance);
            NULL;
      END;

      IF (l_acc_clearance IS NULL)
      THEN
         open_3570 (P_ACC_PARENT, l_acc_clearance);
      ELSE
         BEGIN
            INSERT INTO SMS_ACC_CLEARANCE (acc, ACC_CLEARANCE)
                 VALUES (p_acc_parent, l_acc_clearance);
         EXCEPTION
            WHEN OTHERS
            THEN
               raise_application_error (
                  -20011,
                  'Error insert into SMS_ACC_CLEARANCE');
         END;
      END IF;



      logger.info (
            'find_clearance_acc. Для счета ACC='
         || p_acc_parent
         || ' знайдено рахунок = '
         || l_acc_clearance);
   END;

   ----
   -- проставляє ознаку, що смс оплачено
   --

   PROCEDURE set_sms_payed (p_msg_id   IN MSG_SUBMIT_DATA.msg_id%TYPE,
                            p_ref      IN oper.REF%TYPE)
   IS
   BEGIN
      logger.info (
         'set_sms_payed  p_msg_id=' || p_msg_id || ' p_ref =  ' || p_ref);

      UPDATE msg_submit_data t1
         SET T1.PAYEDREF = p_ref
       WHERE T1.MSG_ID = p_msg_id;
   END;


   ----
   --створює фінансовий документ на оплату
   --

   PROCEDURE create_paydoc (p_acc_parent      IN     accounts.acc%TYPE,
                            p_acc_clearance   IN     accounts.acc%TYPE,
                            p_sms_cnt         IN     NUMBER,
                            p_ref                OUT oper.REF%TYPE)
   IS
      l_sum_to_pay   NUMBER;
      l_nls_parent   ACCOUNTS.NLS%TYPE;
      l_ref          oper.REF%TYPE;
      l_tt           OPER.TT%TYPE;
      l_nmsa         ACCOUNTS.NMS%TYPE;                  --рахунок оплати 3570
      l_nlsa         ACCOUNTS.NLS%TYPE;
      l_okpoa        CUSTOMER.OKPO%TYPE;
      l_toboa        accounts.tobo%TYPE;
      l_nmsb         ACCOUNTS.NMS%TYPE;
      l_nlsb         ACCOUNTS.NLS%TYPE;
      l_okpob        CUSTOMER.OKPO%TYPE;
      l_tobob        accounts.tobo%TYPE;
      l_flg          TTS.FLAGS%TYPE;
   BEGIN
      logger.info ('create_paydoc Для счета ACC=' || p_acc_clearance);

      --операція для оплати СМС, РКО тимчасово, поки банк не визначить постановку задачі
      l_tt := g_tt;

      ----------  Проверяем:  насторена ли операция  ?  ------------
      BEGIN
         SELECT SUBSTR (flags, 38, 1)
           INTO l_flg
           FROM tts
          WHERE tt = l_tt;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20001;
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Не настроена операция SMS !';
            raise_application_error (g_err_num, g_erm);
      END;


      --шукаємо тариф за смс
      BEGIN
         SELECT   (f_tarif (260,
                            g_kv,
                            t1.nls,
                            1))
                * p_sms_cnt,
                t1.nls
           INTO l_sum_to_pay, l_nls_parent
           FROM accounts t1
          WHERE t1.acc = p_acc_parent;

         IF (l_sum_to_pay IS NULL)
         THEN
            g_err_num := -20002;
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Не настроена тариф для SMS !';
            raise_application_error (g_err_num, g_erm);
         END IF;
      END;


      SELECT T2.NLS,
             SUBSTR (t2.NMS, 1, 38),
             T3.OKPO,
             T2.TOBO
        INTO l_nlsa,
             l_nmsa,
             l_okpoa,
             l_toboa
        FROM accounts t2, customer t3
       WHERE t2.acc = p_acc_clearance AND t3.rnk = t2.rnk;

      --шукаємо рахунок оплати 6110
      BEGIN
         l_nlsb := NBS_OB22_NULL ('6110', g_ob22_6110, l_toboa);

         SELECT SUBSTR (t4.NMS, 1, 38), T5.OKPO, T4.TOBO
           INTO l_nmsb, l_okpob, l_tobob
           FROM accounts t4, customer t5
          WHERE t4.nls = l_nlsb AND t4.rnk = t5.rnk AND t4.kv = g_kv;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20003;
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Не найден счет оплаты 6110!';
            raise_application_error (g_err_num, g_erm);
      END;

      --оплачиваем
      BEGIN
         gl.REF (l_ref);
         logger.info ('l_ref=' || l_ref);




    gl.in_doc3 (l_ref,l_tt,6, l_ref,SYSDATE,gl.bDATE,1,g_kv,l_sum_to_pay,g_kv,l_sum_to_pay,null,gl.bDATE,gl.bDATE,l_nmsa,l_nlsa,gl.aMFO,l_tobob,l_nlsb,
                gl.aMFO, 'За SMS інформування рах. '|| l_nls_parent,null,l_okpoa,gl.aOKPO,null,null,null,null,gl.aUID);



         paytt                                                    /* GL.PAYV*/
               (l_flg,
                l_ref,
                gl.bDATE,
                l_tt,
                1,
                g_kv,
                l_nlsa,
                l_sum_to_pay,
                g_kv,
                l_nlsb,
                l_sum_to_pay);

         INSERT INTO oper_visa (REF,
                                dat,
                                userid,
                                status)
              VALUES (l_ref,
                      SYSDATE,
                      user_id,
                      0);

         p_ref := l_ref;
      EXCEPTION
         WHEN OTHERS
         THEN
            g_err_num := -20004;
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Ошибка при оплате СМC!';
            --RAISE;
            raise_application_error (g_err_num, g_erm);
      END;
   END;



   ----
   --розраховує заборгованість на рахунку
   --

   PROCEDURE calculate_clearance (p_acc_parent      IN     accounts.acc%TYPE,
                                  p_acc_clearance   IN     accounts.acc%TYPE,
                                  p_cnt                OUT NUMBER)
   IS
      l_ref   oper.REF%TYPE;
   BEGIN
      logger.info (
         'calculate_clearance. Для счета ACC=' || p_acc_parent);
      p_cnt := 0;

      SELECT msg_id, SUM (CEIL (len / 160)) OVER ()
        BULK COLLECT INTO sms_table
        FROM (SELECT t3.msg_id, LENGTH (T3.MSG_TEXT) AS len
                FROM acc_sms_phones t1, acc_msg t2, msg_submit_data t3
               WHERE     t1.acc = p_acc_parent
                     AND t1.acc = t2.acc
                     AND T3.MSG_ID = T2.MSG_ID
                     AND T3.PAYEDREF IS NULL           ---лише не оплачені смс
                                            /*UNION ALL
                                            SELECT t5.msg_id, LENGTH (T5.MSG_TEXT) AS len
                                              FROM acc_msg t4, msg_submit_data t5
                                             WHERE     T4.MSG_ID = T5.MSG_ID
                                                   AND T4.ACC IS NULL
                                                   AND T4.RNK = p_rnk*/
             );

      FOR i IN 1 .. sms_table.COUNT
      LOOP
         IF (i = 1)
         THEN
            create_paydoc (p_acc_parent,
                           p_acc_clearance,
                           sms_table (1).sms_cnt,
                           l_ref);
         END IF;

         set_sms_payed (sms_table (i).msg_id, l_ref);
         p_cnt := sms_table (i).sms_cnt;
      END LOOP;

      logger.info (sms_table.COUNT);
      logger.info ('calculate_clearance end');
   END;

   ----
   -- встановлює дебіторську заборгованість на рахунку
   --

   PROCEDURE set_clearance (p_acc_parent   IN accounts.acc%TYPE,
                            p_rnk          IN customer.rnk%TYPE)
   IS
      l_acc_clearance   accounts.acc%TYPE;
      l_cnt_sms         NUMBER;
   BEGIN
      logger.info (
         'set_clearance_acc. Для счета ACC=' || p_acc_parent);
      find_clearance_acc (p_acc_parent, p_rnk, l_acc_clearance); --шукаємо рахунок для заборгованості
      calculate_clearance (p_acc_parent, l_acc_clearance, l_cnt_sms); --розраховуємо заборгованість, оплачуємо, ставимо ознаку на смс"оплачно"

      logger.info (
            'set_clearance_acc. Для счета ACC='
         || p_acc_parent
         || ' відправлено '
         || l_cnt_sms
         || ' SMS');
   END;


   ----
   -- виставляє дебіторську заборгованість за СМС по конкретному рахунку клієнта. якщо  асс = null - по всіх
   --

   PROCEDURE pay_for_sms_by_acc (p_acc IN accounts.acc%TYPE DEFAULT 0)
   IS
   BEGIN
      FOR cur
         IN (SELECT t1.rnk, t1.acc
               FROM accounts t1, acc_sms_phones t2
              WHERE     t1.acc = t2.acc
                    AND T2.PAYFORSMS = g_yes
                    AND t1.acc = DECODE (p_acc, 0, t1.acc, p_acc))
      LOOP
         logger.info (
            'SMS. Для счета ACC=' || cur.acc || ' rnk= ' || cur.rnk);
         set_clearance (cur.acc, cur.rnk);
      END LOOP;
   END;

   ----
   -- виставляє дебіторську заборгованість за СМС по конкретному клієнту. якщо  rnk = null - по всіх клієнтах
   --

   PROCEDURE pay_for_sms_by_rnk (p_rnk IN customer.rnk%TYPE DEFAULT 0)
   IS
   BEGIN
      FOR cur
         IN (SELECT t1.rnk, t1.acc
               FROM accounts t1, acc_sms_phones t2
              WHERE     t1.acc = t2.acc
                    AND T2.PAYFORSMS = g_yes
                    AND t1.rnk = DECODE (p_rnk, 0, t1.rnk, p_rnk))
      LOOP
         logger.info (
            'SMS. Для счета ACC=' || cur.acc || ' rnk= ' || cur.rnk);
      -- set_clearance (cur.acc, cur.rnk);
      END LOOP;
   END;


   ----
   --створює фінансовий документ на оплату
   --

   PROCEDURE create_paydoc_clearance (p_acc_parent      IN accounts.acc%TYPE,
                                      p_acc_clearance   IN accounts.acc%TYPE,
                                      p_sum_to_pay      IN NUMBER)
   IS
      l_sum_to_pay   NUMBER;
      l_nls_parent   ACCOUNTS.NLS%TYPE;
      l_ref          oper.REF%TYPE;
      l_tt           OPER.TT%TYPE;
      l_nmsa         ACCOUNTS.NMS%TYPE;                  --рахунок оплати 3570
      l_nlsa         ACCOUNTS.NLS%TYPE;
      l_okpoa        CUSTOMER.OKPO%TYPE;
      l_toboa        accounts.tobo%TYPE;
      l_nmsb         ACCOUNTS.NMS%TYPE;
      l_nlsb         ACCOUNTS.NLS%TYPE;
      l_okpob        CUSTOMER.OKPO%TYPE;
      l_tobob        accounts.tobo%TYPE;
      l_ostc         ACCOUNTS.OSTC%TYPE;
      l_ostb         ACCOUNTS.OSTB%TYPE;

      l_flg          TTS.FLAGS%TYPE;
   BEGIN
      logger.info (
            'create_paydoc_clearance Для счета ACC='
         || p_acc_parent
         || ' p_sum_to_pay = '
         || p_sum_to_pay);
      logger.info (
            'create_paydoc_clearance Для счета ACC_clearance='
         || p_acc_clearance
         || ' p_sum_to_pay = '
         || p_sum_to_pay);

      --операція для оплати СМС, РКО тимчасово, поки банк не визначить постановку задачі
      l_tt := g_tt;                                                   --'RKO';
      l_sum_to_pay := p_sum_to_pay;

      ----------  Проверяем:  насторена ли операция  ?  ------------
      BEGIN
         SELECT SUBSTR (flags, 38, 1)
           INTO l_flg
           FROM tts
          WHERE tt = l_tt;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20012;
          g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Не настроена операция для погашения задолжености по SMS !';
            raise_application_error (g_err_num, g_erm);
      END;


      BEGIN
         --рахунок оплати <>  основний рахунок
         SELECT T1.NLS,
                SUBSTR (t1.NMS, 1, 38),
                T3.OKPO,
                T1.TOBO
           INTO l_nlsa,
                l_nmsa,
                l_okpoa,
                l_toboa
           FROM accounts t1, accountsw t2, customer t3
          WHERE     t2.acc = p_acc_parent
                AND t2.tag = 'SMSCLRNC'
                AND T1.NLS = t2.VALUE
                AND t3.rnk = t1.rnk;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            --рахунок оплати = основний рахунок
            SELECT T2.NLS,
                   SUBSTR (t2.NMS, 1, 38),
                   T3.OKPO,
                   T2.TOBO
              INTO l_nlsa,
                   l_nmsa,
                   l_okpoa,
                   l_toboa
              FROM accounts t2, customer t3
             WHERE t2.acc = p_acc_parent AND t3.rnk = t2.rnk AND t2.kv = g_kv;
      END;

      --шукаємо рахунок заборгованості
      BEGIN
         SELECT SUBSTR (t4.NMS, 1, 38),
                T5.OKPO,
                T4.TOBO,
                T4.NLS,
                T4.OSTC,
                T4.OSTB
           INTO l_nmsb,
                l_okpob,
                l_tobob,
                l_nlsb,
                l_ostc,
                l_ostb
           FROM accounts t4, customer t5
          WHERE t4.acc = p_acc_clearance AND t4.rnk = t5.rnk;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20003;
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Не найден счет заборгованості';  
            raise_application_error (g_err_num, g_erm);
      END;

      --перевірка незавізованих документів(для неможливості генерити багато проводок)
      BEGIN
         IF (l_ostc <> l_ostb)
         THEN
            g_err_num := -20005;
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Рахунок заборгованості має незавізовані документи!';
            raise_application_error (g_err_num, g_erm);
         END IF;
      END;


      --оплачиваем
      BEGIN
         gl.REF (l_ref);
         logger.info ('l_ref=' || l_ref);
               
   gl.in_doc3 (l_ref,l_tt,6, l_ref,SYSDATE,gl.bDATE,1,g_kv,l_sum_to_pay,g_kv,l_sum_to_pay,null,gl.bDATE,gl.bDATE,l_nmsa,l_nlsa,gl.aMFO,l_tobob,l_nlsb,
                gl.aMFO, 'За SMS інформування рах. '|| l_nls_parent,null,l_okpoa,gl.aOKPO,null,null,null,null,gl.aUID);

         paytt (l_flg,
                l_ref,
                gl.bDATE,
                l_tt,
                1,
                g_kv,
                l_nlsa,
                l_sum_to_pay,
                g_kv,
                l_nlsb,
                l_sum_to_pay);

         INSERT INTO oper_visa (REF,
                                dat,
                                userid,
                                status)
              VALUES (l_ref,
                      SYSDATE,
                      user_id,
                      0);
      --p_ref := l_ref;
      EXCEPTION
         WHEN OTHERS
         THEN
            g_err_num := -20004;
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Ошибка при погашении задолжености за СМC!';            
            --RAISE;
            raise_application_error (g_err_num, g_erm);
      END;
   END create_paydoc_clearance;

   ----
   --пошук заборгованості за СМС по конкретному рахунку клієнта
   --

   PROCEDURE find_clearance (p_acc_parent      IN     accounts.acc%TYPE,
                             p_acc_clearance      OUT accounts.acc%TYPE,
                             p_clearance          OUT NUMBER)
   IS
   BEGIN
      logger.info ('find_clearance. Для счета ACC=' || p_acc_parent);

      BEGIN
         SELECT t1.acc, NVL (fost (t1.acc, SYSDATE), 0)
           INTO p_acc_clearance, p_clearance
           FROM accounts t1, SMS_ACC_CLEARANCE t2
          WHERE t1.acc = T2.ACC_CLEARANCE AND t2.acc = p_acc_parent;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20010;
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - Не найден счет задолжености';
            raise_application_error (g_err_num, g_erm);
      END;
   END find_clearance;

   ----
   --пошук простроченої заборгованості за СМС по конкретному рахунку клієнта
   --

   PROCEDURE find_clearance_exp (p_acc_parent      IN     accounts.acc%TYPE,
                                 p_acc_clearance_exp      OUT accounts.acc%TYPE,
                                 p_clearance_exp          OUT NUMBER)
   IS
   BEGIN
      logger.info ('find_clearance_exp. Для счета ACC=' || p_acc_parent);

      BEGIN
         SELECT t1.acc, NVL (fost (t1.acc, SYSDATE), 0)
           INTO p_acc_clearance_exp, p_clearance_exp
          FROM accounts t1, SMS_ACC_CLEARANCE t2, sms_acc_clearance_exp t3
          WHERE t1.acc = T2.ACC_CLEARANCE AND T3.ACC_CLEARANCE = T2.ACC_CLEARANCE and t2.acc = p_acc_parent;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            /*g_err_num := -20010;
            g_erm :=
                  g_erm
               || ' - Не найден счет простроченой задолжености';
            raise_application_error (g_err_num, g_erm);*/
            p_acc_clearance_exp :=0;
            p_clearance_exp :=0;
      END;
   END find_clearance_exp;

   ----
   --пошук залишку на рахунку для оплати заборгованості по конкретному рахунку клієнта
   --

   PROCEDURE find_fost_parent_acc (p_acc_parent   IN     accounts.acc%TYPE,
                                   p_fost            OUT NUMBER)
   IS
   BEGIN
      logger.info (
         'find_fost_parent_acc. Для счета ACC=' || p_acc_parent);

      BEGIN
         SELECT NVL (fost (t1.acc, SYSDATE), 0)
           INTO p_fost
           FROM accounts t1
          WHERE t1.acc = p_acc_parent;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20011;
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE())|| ' - Не найден счет для оплаты задолжености';
            raise_application_error (g_err_num, g_erm);
      END;
   END find_fost_parent_acc;


   ----
   --переносить заборгованість на рахунок прострочки
   --

   PROCEDURE transfer_clearance (p_acc   IN     accounts.acc%TYPE)
   IS
      l_ref   oper.REF%TYPE;
      l_acc_clearance_exp accounts.acc%type;
      l_acc_clearance accounts.acc%type;
      l_fost  number;
   BEGIN
      logger.info (
         'transfer_clearance. Для счета ACC=' || p_acc);

      --пошук рахунку 3570 для p_acc
       find_clearance (p_acc, l_acc_clearance, l_fost);

      IF (l_fost = 0)
      THEN
         logger.info (
               'transfer_clearance. Для счета ACC='
            || l_acc_clearance
            || ' немає заборгованості');
         RETURN;
      ELSE -- якщо є заборгованість то кидаємо її на прострочку
      logger.info (
            'transfer_clearance. Для счета ACC='
         || l_acc_clearance
         || ' l_fost ='
         || l_fost);

      --пошук рахунку 3579 для 3570
       find_clearance_acc_exp(l_acc_clearance , l_acc_clearance_exp);

        create_paydoc_clearance (l_acc_clearance_exp,
                                    l_acc_clearance,
                                     ABS (l_fost));                --платимо
               logger.info (
               'transfer_clearance. Для счета ACC='
            || l_acc_clearance
            || ' перенесено на прострочку ');
      END IF;
     logger.info ('transfer_clearance end');
   END transfer_clearance;


   ----
   --оплачує дебіторську прострочену заборгованість за СМС по рахунку клієнта
   --

   PROCEDURE pay_clearance_exp (p_acc_parent IN accounts.acc%TYPE)
   IS
      l_acc_clearance_exp   accounts.acc%TYPE;
      l_clearance_exp       NUMBER;
      l_fost            NUMBER;
   BEGIN
      logger.info ('pay_clearance_exp. Для счета ACC=' || p_acc_parent);
      find_clearance_exp (p_acc_parent, l_acc_clearance_exp, l_clearance_exp); --шукаємо рахунок заборгованості та заборгованість
      find_fost_parent_acc (p_acc_parent, l_fost); --шукаємо залишок на рахунку для оплати заборгованості

      IF (l_fost = 0)
      THEN
         logger.info (
               'pay_clearance_exp. Для счета ACC='
            || p_acc_parent
            || ' немає коштів для погашення заборгованості');
         RETURN;
      END IF;

      IF (l_clearance_exp = 0)
      THEN
         logger.info (
               'pay_clearance_exp. Для счета ACC='
            || p_acc_parent
            || ' немає заборгованості для погашення ');
         RETURN;
      END IF;

      logger.info (
            'pay_clearance_exp. Для счета ACC='
         || p_acc_parent
         || ' l_fost ='
         || l_fost
         || ' l_clearance_exp ='
         || l_clearance_exp);

      IF ( (l_fost > ABS (l_clearance_exp)) AND l_clearance_exp < 0)
      THEN --якщо э заборгованість і на рахунку більше грошей ніж заборгованість то платимо все
         create_paydoc_clearance (p_acc_parent,
                                  l_acc_clearance_exp,
                                  ABS (l_clearance_exp));                --платимо
         logger.info (
               'pay_clearance_exp. Для счета ACC='
            || p_acc_parent
            || ' погашено ');
      END IF;

      IF ( (l_fost < ABS (l_clearance_exp)) AND l_clearance_exp < 0)
      THEN --якщо э заборгованість і на рахунку менше грошей ніж заборгованість то платимо все що є
         create_paydoc_clearance (p_acc_parent, l_acc_clearance_exp, l_fost); --платимо
         logger.info (
               'pay_clearance_exp. Для счета ACC='
            || p_acc_parent
            || ' погашено частково');
      END IF;
   END pay_clearance_exp;

   ----
   --оплачує дебіторську заборгованість за СМС по конкретному рахунку клієнта
   --

   PROCEDURE pay_clearance (p_acc_parent IN accounts.acc%TYPE)
   IS
      l_acc_clearance   accounts.acc%TYPE;
      l_cnt_sms         NUMBER;
      l_clearance       NUMBER;
      l_fost            NUMBER;
   BEGIN
      logger.info ('pay_clearance. Для счета ACC=' || p_acc_parent);

      --спочатку платимо прострочку
      pay_clearance_exp(p_acc_parent);

      --потім шукаємо заборгованість і платимо
      find_clearance (p_acc_parent, l_acc_clearance, l_clearance); --шукаємо рахунок заборгованості та заборгованість
      find_fost_parent_acc (p_acc_parent, l_fost); --шукаємо залишок на рахунку для оплати заборгованості


      IF (l_fost = 0)
      THEN
         logger.info (
               'pay_clearance. Для счета ACC='
            || p_acc_parent
            || ' немає коштів для погашення заборгованості');
         RETURN;
      END IF;

      IF (l_clearance = 0)
      THEN
         logger.info (
               'pay_clearance. Для счета ACC='
            || p_acc_parent
            || ' немає заборгованості для погашення ');
         RETURN;
      END IF;


      logger.info (
            'pay_clearance. Для счета ACC='
         || p_acc_parent
         || ' l_fost ='
         || l_fost
         || ' l_clearance ='
         || l_clearance);

      IF ( (l_fost > ABS (l_clearance)) AND l_clearance < 0)
      THEN --якщо э заборгованість і на рахунку більше грошей ніж заборгованість то платимо все
         create_paydoc_clearance (p_acc_parent,
                                  l_acc_clearance,
                                  ABS (l_clearance));                --платимо
         logger.info (
               'pay_clearance. Для счета ACC='
            || p_acc_parent
            || ' погашено ');
      END IF;

      IF ( (l_fost < ABS (l_clearance)) AND l_clearance < 0)
      THEN --якщо э заборгованість і на рахунку менше грошей ніж заборгованість то платимо все що є
         create_paydoc_clearance (p_acc_parent, l_acc_clearance, l_fost); --платимо
         logger.info (
               'pay_clearance. Для счета ACC='
            || p_acc_parent
            || ' погашено частково');
      END IF;
   END pay_clearance;
BEGIN
   init;
END bars_sms_clearance;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sms_clearance.sql =========*** 
 PROMPT ===================================================================================== 
 