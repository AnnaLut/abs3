
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms_acc.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SMS_ACC is
----
--  Package BARS_SMS_ACC - ����� �������� ��� ���������� SMS-��������� �� ����� ��������� �������� �� ������
--

g_header_version  constant varchar2(64)  := 'version 2.4 03/09/2015';

g_awk_header_defs constant varchar2(512) := '';

----
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2;

----
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2;

----
-- init - ������������� ������
--
procedure init;

--
-- �-��� ��������� ���� �����
--
function get_acc_type (p_acc accounts.acc%type)
  return char;
--
-- �-��� ��������� NBS �����
--
function get_acc_nbs (p_acc accounts.acc%type)
  return char;

--
-- �-��� ��������� KV �����
--
function get_acc_kv (p_acc accounts.acc%type)
  return number;

----
-- prepare_submit_data - �������������� ������ ��� ������� SMS
--
procedure prepare_submit_data;

----
-- prepare_everyday_sms - ��������� ����� ��� ������� SMS ��������
--
procedure prepare_everyday_sms;

----
---- set_acc_phones - ������������ ������  ��� SMS ������������
--
procedure set_acc_phones(p_acc in accounts.acc%type,
   p_phone in ACC_SMS_PHONES.PHONE%type,
   p_encode in ACC_SMS_PHONES.ENCODE%type default 'lat',
   p_phone1 in ACC_SMS_PHONES.PHONE%type default null,
   p_encode1 in ACC_SMS_PHONES.ENCODE%type default 'lat',
   p_phone2 in ACC_SMS_PHONES.PHONE%type default null,
   p_encode2 in ACC_SMS_PHONES.ENCODE%type default 'lat'
    );

 ----
   -- change_acc_phones - ���� ������  ��� SMS ������������ ���� ���� � ������ �볺���
   --


  PROCEDURE change_acc_phones (p_old_phone    ACC_SMS_PHONES.PHONE%TYPE,
                                p_new_phone   ACC_SMS_PHONES.PHONE%TYPE,
                                p_rnk         ACCOUNTS.RNK%TYPE);




end bars_sms_acc;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SMS_ACC 
IS
   ----
   --  Package BARS_SMS_ACC - ����� �������� ��� ���������� SMS-��������� �� ����� ��������� �������� �� ������
   --

   g_body_version      CONSTANT VARCHAR2 (64)  := 'version 2.10 31/05/2017';
   g_awk_body_defs     CONSTANT VARCHAR2 (512) := '';
   title               constant varchar2 (14)  := 'BARS_SMS_ACC:';

   -- ����� ������� ��� �������������� char <--> number
   g_number_format     CONSTANT VARCHAR2 (128) := 'FM999999999999999999990D00';
   -- ��������� �������������� char <--> number
   g_number_nlsparam   CONSTANT VARCHAR2 (30)
                                   := 'NLS_NUMERIC_CHARACTERS = ''. ''' ;
   -- ����� ������� ��� �������������� char <--> date
   g_date_format       CONSTANT VARCHAR2 (30) := 'YYYY.MM.DD HH24:MI:SS';
   ------------------------------------------------------------------------------

   G_SMS_ACT                    INTEGER;    -- �����(� �����) ������������ SMS
   G_SMS_CHAR                   VARCHAR2 (3); -- ��������� SMS (�cyr� ��� �lat�)

   -- ������� ���������
   TYPE t_sms_msg IS TABLE OF VARCHAR2 (160)
      INDEX BY VARCHAR2 (3);

   g_sms_msg                    t_sms_msg;

   -- ����� ��������� (������� � ������� <NLS>,<KV> � �.�.)
   TYPE t_msg_flag IS RECORD
   (
      nls         BOOLEAN,
      kv          BOOLEAN,
      ostc        BOOLEAN,
      dat         BOOLEAN,
      dos_delta   BOOLEAN,
      kos_delta   BOOLEAN,
      nlsb        BOOLEAN,
      dep_num     BOOLEAN
   );

   TYPE t_msg_flags IS TABLE OF t_msg_flag
      INDEX BY VARCHAR2 (3);

   g_msg_flags                  t_msg_flags;

   TYPE t_cyr_lat IS TABLE OF VARCHAR2 (3)
      INDEX BY PLS_INTEGER;

   g_cyr_lat                    t_cyr_lat;

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
      --
      SELECT TO_NUMBER (val)
        INTO G_SMS_ACT
        FROM params$base
       WHERE par = 'SMS_ACT' and rownum = 1;

      SELECT val
        INTO G_SMS_CHAR
        FROM params$base
       WHERE par = 'SMS_CHAR' and rownum = 1;
   --

   END init;

   --
   -- �-��� ��������� ���� �����
   --
   FUNCTION get_acc_type (p_acc accounts.acc%TYPE)
      RETURN CHAR
   IS
      l_tip   accounts.tip%TYPE;
   BEGIN
      BEGIN
         SELECT tip
           INTO l_tip
           FROM accounts
          WHERE acc = p_acc;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            /*raise_application_error (
               -20000,
                  '�� ��������� ��� ����� ��� ���='
               || p_acc);*/
               l_tip := 'ODB';
      END;

      RETURN l_tip;
   END;

   --
   -- �-��� ��������� NBS �����
   --
   FUNCTION get_acc_nbs (p_acc accounts.acc%TYPE)
      RETURN CHAR
   IS
      l_nbs   accounts.nbs%TYPE;
   BEGIN
      BEGIN
         SELECT nbs
           INTO l_nbs
           FROM accounts
          WHERE acc = p_acc;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            raise_application_error (
               -20000,
                  '�� ��������� ���������� ���� ��� ���='
               || p_acc);
      END;

      RETURN l_nbs;
   END;

   --
   -- �-��� ��������� KV �����
   --
   FUNCTION get_acc_kv (p_acc accounts.acc%TYPE)
      RETURN NUMBER
   IS
      l_kv   accounts.kv%TYPE;
   BEGIN
      BEGIN
         SELECT kv
           INTO l_kv
           FROM accounts
          WHERE acc = p_acc;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            raise_application_error (
               -20000,
                  '�� ���������� ������ ��� ���='
               || p_acc);
      END;

      RETURN l_kv;
   END;


   ----
   -- prepare_acc_msg - ������� ������ ��� ������� SMS �� ����������� ��������� �������
   --
   PROCEDURE prepare_acc_msg (
      p_phone         IN msg_submit_data.phone%TYPE,
      p_encode        IN msg_submit_data.encode%TYPE,
      p_change_time   IN acc_msg.change_time%TYPE,
      p_rnk           IN acc_msg.rnk%TYPE,
      p_acc           IN acc_msg.acc%TYPE,
      p_dos           IN acc_msg.dos_delta%TYPE,
      p_kos           IN acc_msg.kos_delta%TYPE,
      p_ostc          IN acc_msg.ostc%TYPE,
      p_ref           IN acc_balance_changes.REF%TYPE,
      p_tt            IN acc_balance_changes.tt%TYPE,
      p_nlsb          IN acc_balance_changes.nlsb%TYPE,
      p_nlsa          IN acc_balance_changes.nlsa%TYPE)
   IS
      l_encode              VARCHAR2 (3);
      l_ostc                NUMBER;
      l_dos                 NUMBER;
      l_kos                 NUMBER;
      l_ostc_str            VARCHAR2 (100);
      l_dos_str             VARCHAR2 (100);
      l_kos_str             VARCHAR2 (100);
      l_time_str            VARCHAR2 (20);
      l_msg                 VARCHAR2 (160);
      l_kf                  VARCHAR2 (6);
      l_nls                 accounts.nls%TYPE;
      l_kv                  accounts.kv%TYPE;
      l_nbs                 accounts.nbs%TYPE;
      l_tip                 ACCOUNTS.TIP%TYPE;
      l_lcv                 tabval.lcv%TYPE;
      l_msgid               msg_submit_data.msg_id%TYPE := NULL;
      l_crtime              DATE := SYSDATE;
      l_SMS_ACC_TEMPLATES   SMS_ACC_TEMPLATES%ROWTYPE;
      l_nd                  VARCHAR2 (50);
      l_cnt number;
      l_warm_nls            accounts.nls%type;


   BEGIN
      g_cyr_lat (1) := 'cyr';
      g_cyr_lat (2) := 'lat';
      bc.go('/');
      select  get_acc_type (p_acc) , get_acc_nbs (p_acc), kf
      into l_tip, l_nbs, l_kf from accounts where acc = p_acc;

      BEGIN
           SELECT t3.ID,
              t3.ACC_TIP,
              t3.ACC_NBS,
              t3.OPER_TT,
              t3.TEXT_CYR,
              t3.TEXT_LAT,
              t3.DK,
              t3.TT,
              t3.REF,
              t3.NLSB,
              t3.NOT_SEND,
              t3.NBSA,
              t3.NBSB
         INTO l_SMS_ACC_TEMPLATES
         FROM (  SELECT T1.*,
                          DECODE (T1.ACC_TIP, t2.tip, 1, 0)
                        + DECODE (T1.acc_nbs, t2.nbs, 1, 0)
                        + DECODE (T1.oper_tt, t2.tt, 1, 0)
                        + DECODE (T1.nbsa, t2.nbsa, 1, 0)
                           AS cnt_total
                   FROM sms_acc_templates t1,
                        (SELECT l_tip AS tip,
                                l_nbs AS nbs,
                                p_tt AS tt,
                                SUBSTR (p_nlsa, 0, 4) AS nbsa
                           FROM DUAL) t2
                  WHERE t1.dk = CASE WHEN p_dos > p_kos THEN 0 ELSE 1 END
               ORDER BY cnt_total DESC) t3
        WHERE ROWNUM = 1 AND t3.cnt_total > 1;


          logger.trace (title || 'SELECT t3.ID,
              t3.ACC_TIP,
              t3.ACC_NBS,
              t3.OPER_TT,
              t3.TEXT_CYR,
              t3.TEXT_LAT,
              t3.DK,
              t3.TT,
              t3.REF,
              t3.NLSB,
              t3.NOT_SEND,
              t3.NBSA,
              t3.NBSB
         INTO l_SMS_ACC_TEMPLATES
         FROM (  SELECT T1.*,
                          DECODE (T1.ACC_TIP, t2.tip, 1, 0)
                        + DECODE (T1.acc_nbs, t2.nbs, 1, 0)
                        + DECODE (T1.oper_tt, t2.tt, 1, 0)
                        + DECODE (T1.nbsa, t2.nbsa, 1, 0)
                           AS cnt_total
                   FROM sms_acc_templates t1,
                        (SELECT '|| l_tip ||' AS tip,
                                '||l_nbs ||' AS nbs,
                                '||p_tt ||' AS tt,
                                SUBSTR ('||p_nlsa||', 0, 4) AS nbsa
                           FROM DUAL) t2
                  WHERE t1.dk = CASE WHEN '||p_dos||' > '||p_kos||' THEN 0 ELSE 1 END
               ORDER BY cnt_total DESC) t3
        WHERE ROWNUM = 1 AND t3.cnt_total > 1');

        EXCEPTION
             WHEN NO_DATA_FOUND
THEN
                logger.trace ( title ||
                      '�� ��������� ������ ��� ���������� ���� ��� ���='
                   || p_acc
                   || ' ��� �������� = '
                   || p_tt
                   || ' ��� ���� = '
                   || l_tip
                   || ' ��� nbsa = '
                   || p_nlsa
                   || ' ��� dk = '
                   || CASE WHEN p_dos > p_kos THEN 0 ELSE 1 END )
                  ;
                RETURN;

          END;

      --���� ��������
      IF l_SMS_ACC_TEMPLATES.NOT_SEND IS NOT NULL
      THEN
         RETURN;        -- ���� �� ������� ���������� ��� ������ �� ��������
      END IF;                                                               --


     if (l_SMS_ACC_TEMPLATES.ID = 8)  -- ���� ��� ������ �� ������� ������� �� ���������� �� � ������� ������������ ������� �����
       THEN
               --��������� �������� ������� ������������ � ���������� ����������
               select val
               into l_warm_nls
                 from params$base
                    where par = 'WARM_CREDIT_NLS' and kf = l_kf;

         if  (l_warm_nls = p_nlsa )
            THEN
            logger.trace (title || 'warm_credit_sms for acc:' || to_char(p_acc) );--�������� �� ������: ���� ���� ������������ �� ������� ������� - ��� �� ������ ������� ���������
            /*update accounts t1
            set T1.SEND_SMS = null
            where t1.acc = p_acc;
        */
            ELSE
             RETURN;
             end if;
      ELSE
      null;
      end if;

      --����� ��������

      BEGIN
         g_sms_msg ('cyr') := l_SMS_ACC_TEMPLATES.Text_Cyr;
         g_sms_msg ('lat') := l_SMS_ACC_TEMPLATES.Text_Lat;

         g_sms_msg ('cyr') := REPLACE (g_sms_msg ('cyr'), '<\n>', CHR (10));
         g_sms_msg ('lat') := REPLACE (g_sms_msg ('lat'), '<\n>', CHR (10));

         --

         FOR i IN 1 .. 2
         LOOP
            g_msg_flags (g_cyr_lat (i)).nls :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<NLS>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
            g_msg_flags (g_cyr_lat (i)).kv :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<KV>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
            g_msg_flags (g_cyr_lat (i)).dat :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<DAT>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
            g_msg_flags (g_cyr_lat (i)).ostc :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<OSTC>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
            g_msg_flags (g_cyr_lat (i)).dos_delta :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<DOS>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
            g_msg_flags (g_cyr_lat (i)).kos_delta :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<KOS>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
            g_msg_flags (g_cyr_lat (i)).nlsb :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<NLSB>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
            g_msg_flags (g_cyr_lat (i)).dep_num :=
               CASE
                  WHEN INSTR (g_sms_msg (g_cyr_lat (i)), '<DEP_NUM>') > 0
                  THEN
                     TRUE
                  ELSE
                     FALSE
               END;
         END LOOP;
      END;

      --


      -- ����������� ��������������
      l_encode := CASE WHEN p_encode IS NULL THEN G_SMS_CHAR ELSE p_encode END;
      l_ostc := p_ostc / 100;
      l_ostc_str := TO_CHAR (l_ostc, g_number_format, g_number_nlsparam);
      l_dos := p_dos / 100;
      l_dos_str := TO_CHAR (l_dos, g_number_format, g_number_nlsparam);
      l_kos := p_kos / 100;
      l_kos_str := TO_CHAR (l_kos, g_number_format, g_number_nlsparam);
      l_time_str := TO_CHAR (p_change_time, 'DD.MM.YYYY HH24:MI');
      l_msg := g_sms_msg (l_encode);
      l_kv := get_acc_kv (p_acc);

      IF    (l_SMS_ACC_TEMPLATES.Acc_Nbs IN ('2620',
                                             '2630',
                                             '2635', -- TODO : �� ������ ����� ������� ������ ����������� ����� �� ����, �� ���������� ����� ����� ����������
                                             '2628',
                                             '2638'))
         OR (l_SMS_ACC_TEMPLATES.id = 3)
      THEN
         BEGIN
            SELECT DT.deposit_id
              INTO l_nd
              FROM dpt_accounts d, dpt_deposit dt, accounts a
             WHERE     D.DPTID = DT.DEPOSIT_ID
                   AND D.ACCID = a.acc
                   AND a.acc = p_acc;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_nd := NULL;
         END;
      END IF;
      begin
         SELECT kf
           INTO l_kf
           FROM accounts
          WHERE acc = p_acc;
      exception when no_data_found then  l_kf := '300465';
      END;
      -- ��������� ������� � �������
      IF g_msg_flags (l_encode).nls
      THEN
         SELECT nls
           INTO l_nls
           FROM accounts
          WHERE acc = p_acc;

         l_msg := SUBSTR (REPLACE (l_msg, '<NLS>', l_nls), 1, 160);
      END IF;

      IF g_msg_flags (l_encode).kv
      THEN
         SELECT lcv
           INTO l_lcv
           FROM tabval
          WHERE kv = l_kv;

         l_msg := SUBSTR (REPLACE (l_msg, '<KV>', l_lcv), 1, 160);
      END IF;

      IF g_msg_flags (l_encode).dat
      THEN
         l_msg := SUBSTR (REPLACE (l_msg, '<DAT>', l_time_str), 1, 160);
      END IF;

      IF g_msg_flags (l_encode).ostc
      THEN
         l_msg := SUBSTR (REPLACE (l_msg, '<OSTC>', l_ostc_str), 1, 160);
      END IF;

      IF g_msg_flags (l_encode).dos_delta
      THEN
         l_msg := SUBSTR (REPLACE (l_msg, '<DOS>', l_dos_str), 1, 160);
      END IF;

      IF g_msg_flags (l_encode).kos_delta
      THEN
         l_msg := SUBSTR (REPLACE (l_msg, '<KOS>', l_kos_str), 1, 160);
      END IF;

      IF g_msg_flags (l_encode).nlsb
      THEN
         l_msg :=
            SUBSTR (
               REPLACE (
                  l_msg,
                  '<NLSB>',
                  SUBSTR (p_nlsb, 1, 6) || '******' || SUBSTR (p_nlsb, -2)),
               1,
               160);
      END IF;

      IF g_msg_flags (l_encode).dep_num
      THEN
         l_msg :=
            SUBSTR (REPLACE (l_msg, '<DEP_NUM>', NVL (l_nd, ' ')), 1, 160);
      END IF;

      -- ������� ���� ���������
      bars_sms.create_msg (l_msgid,
                           l_crtime,
                           l_crtime + G_SMS_ACT / 24,
                           p_phone,
                           l_encode,
                           l_msg,
                           l_kf);

      -- ��������� ���. ���������� �� ���������
      INSERT INTO acc_msg (msg_id,
                           change_time,
                           rnk,
                           acc,
                           dos_delta,
                           kos_delta,
                           ostc)
           VALUES (l_msgid,
                   p_change_time,
                   p_rnk,
                   p_acc,
                   p_dos,
                   p_kos,
                   p_ostc);
   END prepare_acc_msg;

   ----
   -- prepare_submit_data - �������������� ������ ��� ������� SMS
   --
   PROCEDURE prepare_submit_data
   IS
      l_phones   acc_sms_phones%ROWTYPE;
   BEGIN
      FOR c IN (SELECT ROWID,
                       b.*,
                       MAX (id) OVER (PARTITION BY acc,ref ) max_id,
                       SUM (dos_delta) OVER (PARTITION BY acc,ref) sum_dos,
                       SUM (kos_delta) OVER (PARTITION BY acc,ref) sum_kos
                  FROM acc_balance_changes b
                FOR UPDATE
                   SKIP LOCKED)
      LOOP
         -- ������� ������ ��� ������� SMS �� ����������� ��������� �������
         IF c.id = c.max_id
         THEN                             -- ������ ��� ����� ������ ���������
            BEGIN
               SELECT *
                 INTO l_phones
                 FROM acc_sms_phones
                WHERE acc = c.acc;
                logger.trace (title||'l_phones.phone ='|| l_phones.phone ||
                             ' l_phones.encode='|| l_phones.encode ||
                             ' c.change_time='|| c.change_time ||
                             ' c.rnk='|| c.rnk ||
                             ' c.acc='|| c.acc ||
                             ' c.sum_dos='|| c.sum_dos ||
                             ' c.sum_kos='|| c.sum_kos ||
                             ' c.ostc='|| c.ostc ||
                             ' c.REF='|| c.REF ||
                             ' c.tt='|| c.tt ||
                             ' c.nlsb='|| c.nlsb ||
                             ' c.nlsa'|| c.nlsa
                                   )
                                                  ;
               IF l_phones.phone IS NOT NULL
               THEN
                  prepare_acc_msg (l_phones.phone,
                                   l_phones.encode,
                                   c.change_time,
                                   c.rnk,
                                   c.acc,
                                   c.sum_dos,
                                   c.sum_kos,
                                   c.ostc,
                                   c.REF,
                                   c.tt,
                                   c.nlsb,
                                   c.nlsa);
               END IF;

               IF l_phones.phone1 IS NOT NULL
               THEN
                  prepare_acc_msg (l_phones.phone1,
                                   l_phones.encode1,
                                   c.change_time,
                                   c.rnk,
                                   c.acc,
                                   c.sum_dos,
                                   c.sum_kos,
                                   c.ostc,
                                   c.REF,
                                   c.tt,
                                   c.nlsb,
                                   c.nlsa);
               END IF;

               IF l_phones.phone2 IS NOT NULL
               THEN
                  prepare_acc_msg (l_phones.phone2,
                                   l_phones.encode2,
                                   c.change_time,
                                   c.rnk,
                                   c.acc,
                                   c.sum_dos,
                                   c.sum_kos,
                                   c.ostc,
                                   c.REF,
                                   c.tt,
                                   c.nlsb,
                                   c.nlsa);
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  logger.trace (title||
                        'SMS. ��� ����� ACC='
                     || c.acc
                     || ' �� ������� ������ ��������� ���������');
            END;
         END IF;

         -- ������� ������������ ������ �� ��������� �������
         DELETE FROM acc_balance_changes
               WHERE ROWID = c.ROWID;
      END LOOP;
   --
   END prepare_submit_data;

   ----
   -- prepare_submit_data - �������������� ������ ��� ������� SMS
   --
   PROCEDURE prepare_everyday_sms
   IS
      l_phones   acc_sms_phones%ROWTYPE;
   BEGIN
      logger.trace ( title ||
                           'EVERYDAY SMS. start time='
                        || to_char(sysdate,'DD-MON-YYYY HH24:MI:SS'));
      FOR cur_phones
         IN (SELECT t1.*
               FROM acc_sms_phones t1, accounts t2
              WHERE     t1.acc = t2.acc
                    AND (   (    (T1.PHONE IS NOT NULL)
                             AND LENGTH (T1.PHONE) > 9)
                         OR (    (T1.PHONE1 IS NOT NULL)
                             AND LENGTH (T1.PHONE1) > 9)
                         OR (    (T1.PHONE2 IS NOT NULL)
                             AND LENGTH (T1.PHONE2) > 9))
                    AND T1.DAILYREPORT = 'Y'
                    )
      LOOP
         FOR c IN (SELECT ROWID,
                          b.*,
                          MAX (id) OVER (PARTITION BY acc) max_id,
                          SUM (dos_delta) OVER (PARTITION BY acc) sum_dos,
                          SUM (kos_delta) OVER (PARTITION BY acc) sum_kos
                     FROM acc_balance_changes_update b
                    WHERE TRUNC (B.CHANGE_TIME) = trunc(sysdate)
                    and b.acc = cur_phones.acc )
         LOOP
            -- ������� ������ ��� ������� SMS �� ����������� ��������� �������
            IF c.id = c.max_id
            THEN                          -- ������ ��� ����� ������ ���������
               BEGIN
                logger.trace ( title ||
                           'EVERYDAY SMS. ��� ����� ACC='
                        || c.acc);
                  IF cur_phones.phone IS NOT NULL
                  THEN
                     prepare_acc_msg (cur_phones.phone,
                                      cur_phones.encode,
                                      sysdate,
                                      c.rnk,
                                      c.acc,
                                      c.sum_dos,
                                      c.sum_kos,
                                      c.ostc,
                                      c.REF,
                                      'EDR',
                                      c.nlsb,
                                      c.nlsa);
                  END IF;

                  IF cur_phones.phone1 IS NOT NULL
                  THEN
                     prepare_acc_msg (cur_phones.phone1,
                                      cur_phones.encode1,
                                      sysdate,
                                      c.rnk,
                                      c.acc,
                                      c.sum_dos,
                                      c.sum_kos,
                                      c.ostc,
                                      'EDR',
                                      c.tt,
                                      c.nlsb,
                                      c.nlsa);
                  END IF;

                  IF cur_phones.phone2 IS NOT NULL
                  THEN
                     prepare_acc_msg (cur_phones.phone2,
                                      cur_phones.encode2,
                                      sysdate,
                                      c.rnk,
                                      c.acc,
                                      c.sum_dos,
                                      c.sum_kos,
                                      c.ostc,
                                      c.REF,
                                      'EDR',
                                      c.nlsb,
                                      c.nlsa);
                  END IF;
               EXCEPTION
                  WHEN others
                  THEN
                     logger.trace (title||
                           'EVERYDAY SMS. ��� ����� ACC='
                        || c.acc
                        || ' �� ������� ������ ��������� ��������� ��� ���������� ����������');
               END;
            END IF;
         END LOOP;
      --

      END LOOP;
      logger.trace (Title||
                           'EVERYDAY SMS. stop time'
                        || to_char(sysdate, 'DD-MON-YYYY HH24:MI:SS'));
   END prepare_everyday_sms;

 ----
   -- set_acc_phones - ������������ ������  ��� SMS ������������
   --
   PROCEDURE set_acc_phones
   (p_acc in accounts.acc%type,
   p_phone in ACC_SMS_PHONES.PHONE%type,
   p_encode in ACC_SMS_PHONES.ENCODE%type default 'lat',
   p_phone1 in ACC_SMS_PHONES.PHONE%type default null,
   p_encode1 in ACC_SMS_PHONES.ENCODE%type default 'lat',
   p_phone2 in ACC_SMS_PHONES.PHONE%type default null,
   p_encode2 in ACC_SMS_PHONES.ENCODE%type default 'lat'
    )
   IS
      l_phones   acc_sms_phones%ROWTYPE;
   BEGIN
   null;
   END set_acc_phones;

 ----
   -- change_acc_phones - ���� ������  ��� SMS ������������ ���� ���� � ������ �볺���
   --


  PROCEDURE change_acc_phones (p_old_phone    ACC_SMS_PHONES.PHONE%TYPE,
                                p_new_phone    ACC_SMS_PHONES.PHONE%TYPE,
                                p_rnk         ACCOUNTS.RNK%TYPE)
   IS
   BEGIN
      if (p_old_phone<>p_new_phone) THEN
      UPDATE ACC_SMS_PHONES t1
         SET t1.phone = p_new_phone
       WHERE t1.phone = p_old_phone
              and exists (select 1 from accounts t2 where t2.acc = t1.acc and t2.rnk = p_rnk );

      UPDATE ACC_SMS_PHONES t1
         SET t1.phone1 = p_new_phone
       WHERE t1.phone1 = p_old_phone AND t1.phone1 IS NOT NULL
         and exists (select 1 from accounts t2 where t2.acc = t1.acc and t2.rnk = p_rnk );

      UPDATE ACC_SMS_PHONES t1
         SET t1.phone2 = p_new_phone
       WHERE t1.phone2 = p_old_phone AND t1.phone2 IS NOT NULL
         and exists (select 1 from accounts t2 where t2.acc = t1.acc and t2.rnk = p_rnk );

      end if;
   END change_acc_phones;



BEGIN
   init;
END bars_sms_acc;
/
 show err;
 
PROMPT *** Create  grants  BARS_SMS_ACC ***
grant EXECUTE                                                                on BARS_SMS_ACC    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_SMS_ACC    to CUST001;
grant EXECUTE                                                                on BARS_SMS_ACC    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sms_acc.sql =========*** End **
 PROMPT ===================================================================================== 
 