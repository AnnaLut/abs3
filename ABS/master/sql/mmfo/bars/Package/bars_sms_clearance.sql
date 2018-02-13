
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms_clearance.sql =========*** 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BODY bars_sms_clearance
IS
   ----
   --  Package bars_sms_clearance - ����� �������� ��� ���������� ����������� ������������� ��  SMS-���������
   --

   g_body_version      CONSTANT VARCHAR2 (64) := 'version 1.03 23/08/2015';

   g_awk_body_defs     CONSTANT VARCHAR2 (512) := '';

   -- ����� ������� ��� �������������� char <--> number
   g_number_format     CONSTANT VARCHAR2 (128) := 'FM999999999999999999990D00';
   -- ��������� �������������� char <--> number
   g_number_nlsparam   CONSTANT VARCHAR2 (30)
                                   := 'NLS_NUMERIC_CHARACTERS = ''. ''' ;
   -- ����� ������� ��� �������������� char <--> date
   g_date_format       CONSTANT VARCHAR2 (30) := 'YYYY.MM.DD HH24:MI:SS';

  --���������� ��������� ��22 ��� ������� 3570
   g_ob22              CONSTANT VARCHAR2 (2) := '33';

   --���������� ��������� ��22 ��� ������� 3579/--����� ���� 3570(47)
   g_ob22_exp          CONSTANT VARCHAR2 (2) := '47';

   --���������� ��������� ��22 ��� ������� 6110/--����� ���� 6510 (E8)
   g_ob22_6510          CONSTANT VARCHAR2 (2) := 'E8';

   --���������� ��������� ��� ������
   g_kv                 CONSTANT NUMBER(3) := 980;

   --���������� ��������� ��22 ��� ������� 3570
   g_tt                CONSTANT VARCHAR2 (3) := 'SMS';

   --��������� ������ YES �� �������� ���, ����
   g_yes               CONSTANT VARCHAR2 (1) := 'Y';

   --�-�� ��������� �� ������
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
   -- header_version - ���������� ������ ��������� ������
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
   -- body_version - ���������� ������ ���� ������
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
   -- init - ������������� ������
   --
   PROCEDURE init
   IS
   BEGIN
      NULL;
   END init;


 ---
   -- open_3579 -�������� ������� 3579 ��� ����������� ����������� ������������� �� ��� �� �������. OLD
   --
   --!!!����� ���� (3570_ob47)!!!
   --open_3570_ob47

   PROCEDURE open_3570_ob47 (p_acc_parent          accounts.acc%TYPE,
                        p_acc_clearance_exp   OUT accounts.acc%TYPE)
   IS
      acc_       NUMBER;                                          --  ACC 2600
      nls_       VARCHAR2 (15);                                   --  NLS 2600
      acc1_      NUMBER;                                          --  ACC 3579
      nls_3570_ob47   VARCHAR2 (15);                                   --  NLS 3570_ob47
      nms_       VARCHAR2 (70);                                        --  NMS
      isp_       NUMBER;                                               --  ISP
      i          INT;
      tmp_3570_ob47   VARCHAR2 (15);
      tobo_      VARCHAR2 (30);
      grp_       NUMBER;
      tmp_       NUMBER;
      rnk_       NUMBER;
   BEGIN
      logger.info ('open_3570_ob47. ��� ����� ACC=' || p_acc_parent);

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
         nls_3570_ob47 :=
            VKRZN (SUBSTR (gl.aMFO, 1, 5), '3570' || SUBSTR (nls_, 5));

         SELECT NLS
           INTO tmp_3570_ob47
           FROM accounts
          WHERE     NLS = nls_3570_ob47
                AND KV = g_kv
                AND (RNK <> rnk_ OR OB22 <> g_ob22_exp OR DAZS IS NOT NULL);

         --   C��� 3579<����� 35XX> ��� ����:
         --        --  �� ������ RNK   ���
         --        --  � OB22<>'88'    ���
         --        --  �� ������ !
         --   ��������� ������ ���� �� �����:  3579 k S NN RRRRRR
         --   ���:  S  - 6-�� ����� �� 35XX*

         i := 1;

         LOOP
            nls_3570_ob47 :=
               vkrzn (
                  SUBSTR (gl.aMFO, 1, 5),
                     '3570'
                  || '0'
                  || SUBSTR (nls_, 6, 1)
                  || LPAD (TO_CHAR (i), 2, '0')
                  || LPAD (TO_CHAR (rnk_), 6, '0'));

            BEGIN                                      -- ���� �� ����� ���� ?
               SELECT NLS
                 INTO tmp_3570_ob47
                 FROM accounts
                WHERE     NLS = nls_3570_ob47
                      AND KV = g_kv
                      AND (RNK <> rnk_ OR OB22 <> g_ob22_exp OR DAZS IS NOT NULL);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  EXIT;                   -- ������ ����� ��� ���, - ���������
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
      END;                          ---------- END ������� ������ 3579*  -----

      logger.info ('open_3570_ob47. g_tt=' || g_tt);


      OP_REG (99,
              0,
              0,
              grp_,
              tmp_,
              rnk_,
              nls_3570_ob47,
              g_kv,
              SUBSTR ('���.���.SMS �� ������������ �� 31g' || nms_, 1, 70),
              'ODB',
              isp_,
              acc1_);

      ----  ������������ ������� �� 3570:
      p_setAccessByAccmask (acc1_, acc_);

      ----  ���������� ������� �� GROUPS_NBS:
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

    --�������� ��� � ������� ��'���� �������=������� ������ �� ���
      INSERT INTO SMS_ACC_CLEARANCE_EXP (ACC_CLEARANCE, ACC_CLEARANCE_EXP)
           VALUES (p_acc_parent, p_acc_clearance_exp);
		  Exception when dup_val_on_index then null;


      logger.info (
            'open_3570_ob47. ��� ����� ACC='
         || p_acc_parent
         || '������� 3570_ob47 = '
         || p_acc_clearance_exp);
   END open_3570_ob47;

   -- ��������� ������� ��� �������� ������������� �� ����������, ��� ��������� ������� ������� ����
   --

   PROCEDURE find_clearance_acc_exp
                                (p_acc_clearance      IN     accounts.acc%TYPE,
                                 p_acc_clearance_exp  OUT accounts.acc%TYPE)
   IS
   BEGIN
      --������ ������� ��������� �� ��� ��� ������ �������
      BEGIN
         SELECT ACC_CLEARANCE_EXP
           INTO p_acc_clearance_exp
           FROM SMS_ACC_CLEARANCE_EXP
          WHERE acc_clearance = p_acc_clearance;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            --���� �� ������� - ���������
            open_3570_ob47 (p_acc_clearance, p_acc_clearance_exp);
         when others
         then raise;
      END;

      logger.info (
            'find_clearance_acc_exp. ��� ����� ACC='
         || p_acc_clearance
         || ' �������� ������� = '
         || p_acc_clearance_exp);
   END find_clearance_acc_exp;

   ---
   -- open_3570 -�������� ������� 3570 ��� ����������� ������������� �� ��� �� �������.
   --

   PROCEDURE open_3570 (p_acc_parent          accounts.acc%TYPE,
                        p_acc_clearance   OUT accounts.acc%TYPE)
   IS
      acc_       NUMBER;                                          --  ACC 2600
      nls_       VARCHAR2 (15);                                   --  NLS 2600
      acc1_      NUMBER;                                          --  ACC 3570
      nls_3570   VARCHAR2 (15);                                   --  NLS 3570
      nms_       VARCHAR2 (70);                                        --  NMS
      isp_       NUMBER;                                                --  ISP
      i          INT;
      tmp_3570   VARCHAR2 (15);
      tobo_      VARCHAR2 (30);
      grp_       NUMBER;
      tmp_       NUMBER;
      rnk_       NUMBER;
      l_acc_clearance_exp NUMBER;                                 --  ACC 3579

   BEGIN
      logger.info ('open_3570. ��� ����� ACC=' || p_acc_parent);

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

         --   C��� 3570<����� 26XX> ��� ����:
         --        --  �� ������ RNK   ���
         --        --  � OB22<>'33'    ���
         --        --  �� ������ !
         --   ��������� ������ ���� �� �����:  3570 k S NN RRRRRR
         --   ���:  S  - 6-�� ����� �� 26XX*

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

            BEGIN                                      -- ���� �� ����� ���� ?
               SELECT NLS
                 INTO tmp_3570
                 FROM accounts
                WHERE     NLS = nls_3570
                      AND KV = g_kv
                      AND (RNK <> rnk_ OR OB22 <> g_ob22 OR DAZS IS NOT NULL);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  EXIT;                   -- ������ ����� ��� ���, - ���������
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
      END;                          ---------- END ������� ������ 3570*  -----

      logger.info ('open_3570. g_tt=' || g_tt);


      OP_REG (99,
              0,
              0,
              grp_,
              tmp_,
              rnk_,
              nls_3570,
              g_kv,
              SUBSTR ('���.���.SMS ' || nms_, 1, 70),
              'ODB',
              isp_,
              acc1_);

      ----  ������������ ������� �� 2600:
      p_setAccessByAccmask (acc1_, acc_);

      ----  ���������� ������� �� GROUPS_NBS:
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
      
      
    

      --�������� ��� � ������� ��'���� �������=������� ������ �� ���
      INSERT INTO SMS_ACC_CLEARANCE (acc, ACC_CLEARANCE)
           VALUES (p_acc_parent, p_acc_clearance);
      Exception when dup_val_on_index then null;     

      logger.info (
            'open_3570. ��� ����� ACC='
         || p_acc_parent
         || '������� 3570 = '
         || p_acc_clearance);

   --��������� 3579,������� �� 100% �� �� �������� ���� ����� ���� ������ !!! NEW open_3570_ob47!!!
    open_3570_ob47(p_acc_clearance,l_acc_clearance_exp);

   END open_3570;
   ----
   -- ��������� ������� ��� ����������� �������������, ��� ��������� ������� ������� ����
   --

   PROCEDURE find_clearance_acc (p_acc_parent      IN     accounts.acc%TYPE,
                                 p_rnk             IN     customer.rnk%TYPE,
                                 p_acc_clearance      OUT accounts.acc%TYPE)
   IS
   BEGIN
      --������ ������� ��������� �� ��� ��� ������ �������
      BEGIN
         SELECT ACC_CLEARANCE
           INTO p_acc_clearance
           FROM SMS_ACC_CLEARANCE
          WHERE acc = P_ACC_PARENT;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            --���� �� ������� - ���������
            open_3570 (P_ACC_PARENT, p_acc_clearance);
         when others
         then raise;
      END;

      logger.info (
            'find_clearance_acc. ��� ����� ACC='
         || p_acc_parent
         || ' �������� ������� = '
         || p_acc_clearance);
   END;


   ----
   -- ��������� ������� ��� ����������� ������������� ��� �볺���(��� ������ 3570 �� �� ������� �볺���)
   --, ��� ��������� ������� ������� ����
   --

   PROCEDURE set_clearance_acc (p_acc_parent IN accounts.acc%TYPE)
   IS
      l_acc_clearance   accounts.acc%TYPE;
   BEGIN
      --������ ������� ��������� �� ��� ��� ������� ������ �볺���
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
            --���� �� ������� - ���������
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
            'find_clearance_acc. ��� ����� ACC='
         || p_acc_parent
         || ' �������� ������� = '
         || l_acc_clearance);
   END;

   ----
   -- ���������� ������, �� ��� ��������
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
   --������� ���������� �������� �� ������
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
      l_nmsa         ACCOUNTS.NMS%TYPE;                  --������� ������ 3570
      l_nlsa         ACCOUNTS.NLS%TYPE;
      l_okpoa        CUSTOMER.OKPO%TYPE;
      l_toboa        accounts.tobo%TYPE;
      l_nmsb         ACCOUNTS.NMS%TYPE;
      l_nlsb         ACCOUNTS.NLS%TYPE;
      l_okpob        CUSTOMER.OKPO%TYPE;
      l_tobob        accounts.tobo%TYPE;
      l_flg          TTS.FLAGS%TYPE;
   BEGIN
      logger.info ('create_paydoc ��� ����� ACC=' || p_acc_clearance);

      --�������� ��� ������ ���, ��� ���������, ���� ���� �� ��������� ���������� ������
      l_tt := g_tt;

      ----------  ���������:  ��������� �� ��������  ?  ------------
      BEGIN
         SELECT SUBSTR (flags, 38, 1)
           INTO l_flg
           FROM tts
          WHERE tt = l_tt;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20001;
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - �� ��������� �������� SMS !';
            raise_application_error (g_err_num, g_erm);
      END;


      --������ ����� �� ���
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
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - �� ��������� ����� ��� SMS !';
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

      --������ ������� ������ 6110 !!!NEW 6510 !!
      BEGIN
         l_nlsb := NBS_OB22_NULL ('6510', g_ob22_6510, l_toboa);

         SELECT SUBSTR (t4.NMS, 1, 38), T5.OKPO, T4.TOBO
           INTO l_nmsb, l_okpob, l_tobob
           FROM accounts t4, customer t5
          WHERE t4.nls = l_nlsb AND t4.rnk = t5.rnk AND t4.kv = g_kv;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20003;
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - �� ������ ���� ������ 6510!';
            raise_application_error (g_err_num, g_erm);
      END;

      --����������
      BEGIN
         gl.REF (l_ref);
         logger.info ('l_ref=' || l_ref);




    gl.in_doc3 (l_ref,l_tt,6, l_ref,SYSDATE,gl.bDATE,1,g_kv,l_sum_to_pay,g_kv,l_sum_to_pay,null,gl.bDATE,gl.bDATE,l_nmsa,l_nlsa,gl.aMFO,l_tobob,l_nlsb,
                gl.aMFO, '�� SMS ������������ ���. '|| l_nls_parent,null,l_okpoa,gl.aOKPO,null,null,null,null,gl.aUID);



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
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - ������ ��� ������ ��C!';
            --RAISE;
            raise_application_error (g_err_num, g_erm);
      END;
   END;



   ----
   --��������� ������������� �� �������
   --

   PROCEDURE calculate_clearance (p_acc_parent      IN     accounts.acc%TYPE,
                                  p_acc_clearance   IN     accounts.acc%TYPE,
                                  p_cnt                OUT NUMBER)
   IS
      l_ref   oper.REF%TYPE;
   BEGIN
      logger.info (
         'calculate_clearance. ��� ����� ACC=' || p_acc_parent);
      p_cnt := 0;

      SELECT msg_id, SUM (CEIL (len / 160)) OVER ()
        BULK COLLECT INTO sms_table
        FROM (SELECT t3.msg_id, LENGTH (T3.MSG_TEXT) AS len
                FROM acc_sms_phones t1, acc_msg t2, msg_submit_data t3
               WHERE     t1.acc = p_acc_parent
                     AND t1.acc = t2.acc
                     AND T3.MSG_ID = T2.MSG_ID
                     AND T3.PAYEDREF IS NULL           ---���� �� ������� ���
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
   -- ���������� ���������� ������������� �� �������
   --

   PROCEDURE set_clearance (p_acc_parent   IN accounts.acc%TYPE,
                            p_rnk          IN customer.rnk%TYPE)
   IS
      l_acc_clearance   accounts.acc%TYPE;
      l_cnt_sms         NUMBER;
   BEGIN
      logger.info (
         'set_clearance_acc. ��� ����� ACC=' || p_acc_parent);
      find_clearance_acc (p_acc_parent, p_rnk, l_acc_clearance); --������ ������� ��� �������������
      calculate_clearance (p_acc_parent, l_acc_clearance, l_cnt_sms); --����������� �������������, ��������, ������� ������ �� ���"�������"

      logger.info (
            'set_clearance_acc. ��� ����� ACC='
         || p_acc_parent
         || ' ���������� '
         || l_cnt_sms
         || ' SMS');
   END;


   ----
   -- ��������� ���������� ������������� �� ��� �� ����������� ������� �볺���. ����  ��� = null - �� ���
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
            'SMS. ��� ����� ACC=' || cur.acc || ' rnk= ' || cur.rnk);
         set_clearance (cur.acc, cur.rnk);
      END LOOP;
   END;

   ----
   -- ��������� ���������� ������������� �� ��� �� ����������� �볺���. ����  rnk = null - �� ��� �볺����
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
            'SMS. ��� ����� ACC=' || cur.acc || ' rnk= ' || cur.rnk);
      -- set_clearance (cur.acc, cur.rnk);
      END LOOP;
   END;


   ----
   --������� ���������� �������� �� ������
   --

   PROCEDURE create_paydoc_clearance (p_acc_parent      IN accounts.acc%TYPE,
                                      p_acc_clearance   IN accounts.acc%TYPE,
                                      p_sum_to_pay      IN NUMBER)
   IS
      l_sum_to_pay   NUMBER;
      l_nls_parent   ACCOUNTS.NLS%TYPE;
      l_ref          oper.REF%TYPE;
      l_tt           OPER.TT%TYPE;
      l_nmsa         ACCOUNTS.NMS%TYPE;                  --������� ������ 3570
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
            'create_paydoc_clearance ��� ����� ACC='
         || p_acc_parent
         || ' p_sum_to_pay = '
         || p_sum_to_pay);
      logger.info (
            'create_paydoc_clearance ��� ����� ACC_clearance='
         || p_acc_clearance
         || ' p_sum_to_pay = '
         || p_sum_to_pay);

      --�������� ��� ������ ���, ��� ���������, ���� ���� �� ��������� ���������� ������
      l_tt := g_tt;                                                   --'RKO';
      l_sum_to_pay := p_sum_to_pay;

      ----------  ���������:  ��������� �� ��������  ?  ------------
      BEGIN
         SELECT SUBSTR (flags, 38, 1)
           INTO l_flg
           FROM tts
          WHERE tt = l_tt;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20012;
          g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - �� ��������� �������� ��� ��������� ������������ �� SMS !';
            raise_application_error (g_err_num, g_erm);
      END;


      BEGIN
         --������� ������ <>  �������� �������
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
            --������� ������ = �������� �������
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

      --������ ������� �������������
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
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - �� ������ ���� �������������';
            raise_application_error (g_err_num, g_erm);
      END;

      --�������� ������������ ���������(��� ����������� �������� ������ ��������)
      BEGIN
         IF (l_ostc <> l_ostb)
         THEN
           /*  g_err_num := -20005;
            g_erm :=
                  g_erm
               || ' - ������� ������������� �� ���������� ���������!'||to_char(l_ostc)||' '||to_char(l_ostb)||' '||to_char(l_nmsb);
            raise_application_error (g_err_num, g_erm);*/
             null;  --  ����� � ��
         END IF;
      END;


      --����������
      BEGIN
         gl.REF (l_ref);
         logger.info ('l_ref=' || l_ref);

   gl.in_doc3 (l_ref,l_tt,6, l_ref,SYSDATE,gl.bDATE,1,g_kv,l_sum_to_pay,g_kv,l_sum_to_pay,null,gl.bDATE,gl.bDATE,l_nmsa,l_nlsa,gl.aMFO,l_tobob,l_nlsb,
                gl.aMFO, '�� SMS ������������ ���. '|| l_nls_parent,null,l_okpoa,gl.aOKPO,null,null,null,null,gl.aUID);

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
            g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - ������ ��� ��������� ������������ �� ��C!';
            --RAISE;
            raise_application_error (g_err_num, g_erm);
      END;
   END create_paydoc_clearance;

   ----
   --����� ������������� �� ��� �� ����������� ������� �볺���
   --

   PROCEDURE find_clearance (p_acc_parent      IN     accounts.acc%TYPE,
                             p_acc_clearance      OUT accounts.acc%TYPE,
                             p_clearance          OUT NUMBER)
   IS
   BEGIN
      logger.info ('find_clearance. ��� ����� ACC=' || p_acc_parent);

      BEGIN
         SELECT t1.acc, NVL (fost (t1.acc, SYSDATE), 0)
           INTO p_acc_clearance, p_clearance
           FROM accounts t1, SMS_ACC_CLEARANCE t2
          WHERE t1.acc = T2.ACC_CLEARANCE AND t2.acc = p_acc_parent;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20010;
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE()) || ' - �� ������ ���� ������������';
            raise_application_error (g_err_num, g_erm);
      END;
   END find_clearance;

   ----
   --����� ����������� ������������� �� ��� �� ����������� ������� �볺���
   --

   PROCEDURE find_clearance_exp (p_acc_parent      IN     accounts.acc%TYPE,
                                 p_acc_clearance_exp      OUT accounts.acc%TYPE,
                                 p_clearance_exp          OUT NUMBER)
   IS
   BEGIN
      logger.info ('find_clearance_exp. ��� ����� ACC=' || p_acc_parent);

      BEGIN
		 SELECT t3.ACC_CLEARANCE_EXP, NVL (fost (t3.ACC_CLEARANCE_EXP, SYSDATE), 0)
           INTO p_acc_clearance_exp, p_clearance_exp
          FROM accounts t1, SMS_ACC_CLEARANCE t2, sms_acc_clearance_exp t3
          WHERE t1.acc = T2.ACC_CLEARANCE AND T3.ACC_CLEARANCE = T2.ACC_CLEARANCE and t2.acc = p_acc_parent;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            /*g_err_num := -20010;
            g_erm :=
                  g_erm
               || ' - �� ������ ���� ������������ ������������';
            raise_application_error (g_err_num, g_erm);*/
            p_acc_clearance_exp :=0;
            p_clearance_exp :=0;
      END;
   END find_clearance_exp;

   ----
   --����� ������� �� ������� ��� ������ ������������� �� ����������� ������� �볺���
   --

   PROCEDURE find_fost_parent_acc (p_acc_parent   IN     accounts.acc%TYPE,
                                   p_fost            OUT NUMBER)
   IS
   BEGIN
      logger.info (
         'find_fost_parent_acc. ��� ����� ACC=' || p_acc_parent);

      BEGIN
         SELECT NVL (fost (t1.acc, SYSDATE), 0)
           INTO p_fost
           FROM accounts t1
          WHERE t1.acc = p_acc_parent;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            g_err_num := -20011;
           g_erm :=nvl(g_erm, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE())|| ' - �� ������ ���� ��� ������ ������������';
            raise_application_error (g_err_num, g_erm);
      END;
   END find_fost_parent_acc;


   ----
   --���������� ������������� �� ������� ����������
   --

   PROCEDURE transfer_clearance (p_acc   IN     accounts.acc%TYPE)
   IS
      l_ref   oper.REF%TYPE;
      l_acc_clearance_exp accounts.acc%type;
      l_acc_clearance accounts.acc%type;
      l_fost  number;
   BEGIN
      logger.info (
         'transfer_clearance. ��� ����� ACC=' || p_acc);

      --����� ������� 3570 ��� p_acc
       find_clearance (p_acc, l_acc_clearance, l_fost);

      IF (l_fost = 0)
      THEN
         logger.info (
               'transfer_clearance. ��� ����� ACC='
            || l_acc_clearance
            || ' ���� �������������');
         RETURN;
      ELSE -- ���� � ������������� �� ������ �� �� ����������
      logger.info (
            'transfer_clearance. ��� ����� ACC='
         || l_acc_clearance
         || ' l_fost ='
         || l_fost);

      --����� ������� 3579 ��� 3570
       find_clearance_acc_exp(l_acc_clearance , l_acc_clearance_exp);

        create_paydoc_clearance (l_acc_clearance_exp,
                                    l_acc_clearance,
                                     ABS (l_fost));                --�������
               logger.info (
               'transfer_clearance. ��� ����� ACC='
            || l_acc_clearance
            || ' ���������� �� ���������� ');
      END IF;
     logger.info ('transfer_clearance end');
   END transfer_clearance;


   ----
   --������ ���������� ����������� ������������� �� ��� �� ������� �볺���
   --

   PROCEDURE pay_clearance_exp (p_acc_parent IN accounts.acc%TYPE)
   IS
      l_acc_clearance_exp   accounts.acc%TYPE;
      l_clearance_exp       NUMBER;
      l_fost            NUMBER;
   BEGIN
      logger.info ('pay_clearance_exp. ��� ����� ACC=' || p_acc_parent);
      find_clearance_exp (p_acc_parent, l_acc_clearance_exp, l_clearance_exp); --������ ������� ������������� �� �������������
      find_fost_parent_acc (p_acc_parent, l_fost); --������ ������� �� ������� ��� ������ �������������

      IF (l_fost = 0)
      THEN
         logger.info (
               'pay_clearance_exp. ��� ����� ACC='
            || p_acc_parent
            || ' ���� ����� ��� ��������� �������������');
         RETURN;
      END IF;

      IF (l_clearance_exp = 0)
      THEN
         logger.info (
               'pay_clearance_exp. ��� ����� ACC='
            || p_acc_parent
            || ' ���� ������������� ��� ��������� ');
         RETURN;
      END IF;

      logger.info (
            'pay_clearance_exp. ��� ����� ACC='
         || p_acc_parent
         || ' l_fost ='
         || l_fost
         || ' l_clearance_exp ='
         || l_clearance_exp);

      IF ( (l_fost > ABS (l_clearance_exp)) AND l_clearance_exp < 0)
      THEN --���� � ������������� � �� ������� ����� ������ �� ������������� �� ������� ���
         create_paydoc_clearance (p_acc_parent,
                                  l_acc_clearance_exp,
                                  ABS (l_clearance_exp));                --�������
         logger.info (
               'pay_clearance_exp. ��� ����� ACC='
            || p_acc_parent
            || ' �������� ');
      END IF;

      IF ( (l_fost < ABS (l_clearance_exp)) AND l_clearance_exp < 0)
      THEN --���� � ������������� � �� ������� ����� ������ �� ������������� �� ������� ��� �� �
         create_paydoc_clearance (p_acc_parent, l_acc_clearance_exp, l_fost); --�������
         logger.info (
               'pay_clearance_exp. ��� ����� ACC='
            || p_acc_parent
            || ' �������� ��������');
      END IF;
   END pay_clearance_exp;

   ----
   --������ ���������� ������������� �� ��� �� ����������� ������� �볺���
   --

   PROCEDURE pay_clearance (p_acc_parent IN accounts.acc%TYPE)
   IS
      l_acc_clearance   accounts.acc%TYPE;
      l_cnt_sms         NUMBER;
      l_clearance       NUMBER;
      l_fost            NUMBER;
   BEGIN
      logger.info ('pay_clearance. ��� ����� ACC=' || p_acc_parent);

      --�������� ������� ����������
      pay_clearance_exp(p_acc_parent);

      --���� ������ ������������� � �������
      find_clearance (p_acc_parent, l_acc_clearance, l_clearance); --������ ������� ������������� �� �������������
      find_fost_parent_acc (p_acc_parent, l_fost); --������ ������� �� ������� ��� ������ �������������


      IF (l_fost = 0)
      THEN
         logger.info (
               'pay_clearance. ��� ����� ACC='
            || p_acc_parent
            || ' ���� ����� ��� ��������� �������������');
         RETURN;
      END IF;

      IF (l_clearance = 0)
      THEN
         logger.info (
               'pay_clearance. ��� ����� ACC='
            || p_acc_parent
            || ' ���� ������������� ��� ��������� ');
         RETURN;
      END IF;


      logger.info (
            'pay_clearance. ��� ����� ACC='
         || p_acc_parent
         || ' l_fost ='
         || l_fost
         || ' l_clearance ='
         || l_clearance);

      IF ( (l_fost > ABS (l_clearance)) AND l_clearance < 0)
      THEN --���� � ������������� � �� ������� ����� ������ �� ������������� �� ������� ���
         create_paydoc_clearance (p_acc_parent,
                                  l_acc_clearance,
                                  ABS (l_clearance));                --�������
         logger.info (
               'pay_clearance. ��� ����� ACC='
            || p_acc_parent
            || ' �������� ');
      END IF;

      IF ( (l_fost < ABS (l_clearance)) AND l_clearance < 0)
      THEN --���� � ������������� � �� ������� ����� ������ �� ������������� �� ������� ��� �� �
         create_paydoc_clearance (p_acc_parent, l_acc_clearance, l_fost); --�������
         logger.info (
               'pay_clearance. ��� ����� ACC='
            || p_acc_parent
            || ' �������� ��������');
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
 