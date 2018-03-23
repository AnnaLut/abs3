
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms_acc.sql =========*** Run **
PROMPT ===================================================================================== 

CREATE OR REPLACE PACKAGE BARS.BARS_SMS_ACC
is
----
--  Package BARS_SMS_ACC - пакет процедур для подготовки SMS-сообщений по факту изменения остатков по счетам
--

g_header_version  constant varchar2(64)  := 'version 2.4 03/09/2015';

g_awk_header_defs constant varchar2(512) := '';

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

----
-- init - инициализация пакета
--
procedure init;

--
-- ф-ция получения типа счета
--
function get_acc_type (p_acc accounts.acc%type)
  return char;
--
-- ф-ция получения NBS счета
--
function get_acc_nbs (p_acc accounts.acc%type)
  return char;

--
-- ф-ция получения KV счета
--
function get_acc_kv (p_acc accounts.acc%type)
  return number;

----
-- prepare_submit_data - подготавливает данные для посылки SMS
--
procedure prepare_submit_data;

----
-- prepare_everyday_sms - підготовка даних для щоденної SMS розсилки
--
procedure PREPARE_EVERYDAY_SMS;

----
-- set_acc_phones - встановлення номерів  для SMS інформування
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
  -- change_acc_phones - зміна номерів  для SMS інформування після зміни в картці клієнта
  --
  PROCEDURE change_acc_phones (p_old_phone    ACC_SMS_PHONES.PHONE%TYPE,
                                p_new_phone   ACC_SMS_PHONES.PHONE%TYPE,
                                p_rnk         ACCOUNTS.RNK%TYPE);

end bars_sms_acc;
/

show errors;

CREATE OR REPLACE PACKAGE BODY BARS.BARS_SMS_ACC 
IS
   ----
   --  Package BARS_SMS_ACC - пакет процедур для подготовки SMS-сообщений по факту изменения остатков по счетам
   --

   g_body_version      CONSTANT VARCHAR2 (64)  := 'version 2.11 23/03/2018';
   g_awk_body_defs     CONSTANT VARCHAR2 (512) := '';
   title               constant varchar2 (14)  := 'BARS_SMS_ACC:';

   -- маска формата для преобразования char <--> number
   g_number_format     CONSTANT VARCHAR2(128) := 'FM999999999999999999990D00';
   -- параметры преобразования char <--> number
   g_number_nlsparam   CONSTANT VARCHAR2(30)  := 'NLS_NUMERIC_CHARACTERS = ''. ''' ;
   -- маска формата для преобразования char <--> date
   g_tm_fmt            CONSTANT VARCHAR2(21)  := 'YYYY.MM.DD HH24:MI:SS';
   g_dt_fmt            CONSTANT VARCHAR2(10)  := 'DD.MM.YYYY';
   ------------------------------------------------------------------------------

   G_SMS_ACT                    INTEGER;      -- Время(в часах) актуальности SMS
   G_SMS_CHAR                   VARCHAR2 (3); -- Кодировка SMS («cyr» или «lat»)

   -- шаблоны сообщений
   TYPE t_sms_msg IS TABLE OF VARCHAR2 (160)
      INDEX BY VARCHAR2 (3);

   g_sms_msg                    t_sms_msg;

   -- флаги сообщений (наличие в шаблоне <NLS>,<KV> и т.д.)
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
   -- ф-ция получения типа счета
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
                  'Не определен тип счета для АСС='
               || p_acc);*/
               l_tip := 'ODB';
      END;

      RETURN l_tip;
   END;

   --
   -- ф-ция получения NBS счета
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
                  'Не определен балансовый счет для АСС='
               || p_acc);
      END;

      RETURN l_nbs;
   END;

   --
   -- ф-ция получения KV счета
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
                  'Не определена валюта для АСС='
               || p_acc);
      END;

      RETURN l_kv;
   END;


   ----
   -- prepare_acc_msg - готовим данные для посылки SMS по конкретному изменению остатка
   --
   procedure PREPARE_ACC_MSG
   ( p_phone         IN msg_submit_data.phone%TYPE,
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
     p_nlsa          IN acc_balance_changes.nlsa%TYPE
   ) IS
     l_encode              VARCHAR2 (3);
     l_ost                 NUMBER;
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
     l_tip                 accounts.tip%type;
     l_rnk                 accounts.rnk%type;
     l_lcv                 tabval.lcv%TYPE;
     l_msgid               msg_submit_data.msg_id%TYPE := NULL;
     l_crtime              DATE := SYSDATE;
     l_SMS_ACC_TEMPLATES   SMS_ACC_TEMPLATES%ROWTYPE;
     l_nd                  VARCHAR2 (50);
     l_cnt                 number;
     l_warm_nls            accounts.nls%type;
   BEGIN

     bars_audit.trace ( '%s.PREPARE_ACC_MSG: Entry with ( p_acc=%s ).', title, to_char(p_acc) );

     g_cyr_lat(1) := 'cyr';
     g_cyr_lat(2) := 'lat';

     bc.go('/');

     select a.TIP, a.NBS, a.KV, a.KF, a.NLS, a.RNK
       into l_tip, l_nbs, l_kv, l_kf, l_nls, l_rnk
       from ACCOUNTS a
      where a.ACC = p_acc;

     bars_audit.trace( title||'.PREPARE_ACC_MSG: ( l_tip, l_nbs, l_kv, l_kf).' );

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
         FROM (  SELECT T1.*
                      , DECODE (T1.ACC_TIP, t2.tip,  1, 0)
                      + DECODE (T1.acc_nbs, t2.nbs,  1, 0)
                      + DECODE (T1.oper_tt, t2.tt,   1, 0)
                      + DECODE (T1.nbsa,    t2.nbsa, 1, 0) AS cnt_total
                   FROM sms_acc_templates t1,
                        (SELECT l_tip AS tip,
                                l_nbs AS nbs,
                                p_tt  AS tt,
                                SUBSTR (p_nlsa, 0, 4) AS nbsa
                           FROM DUAL) t2
                  WHERE t1.dk = CASE WHEN p_dos > p_kos THEN 0 ELSE 1 END
                  ORDER BY cnt_total DESC
              ) t3
        WHERE ROWNUM = 1 AND t3.cnt_total > 1;

     EXCEPTION
       WHEN NO_DATA_FOUND THEN 
         bars_audit.error( title||'.PREPARE_ACC_MSG: Не определен шаблон для балансовый счет для АСС='||p_acc
                                ||', операции='|| p_tt
                                ||', типа='    || l_tip
                                ||', nbsa='    || p_nlsa
                                ||', dk='      || CASE WHEN p_dos > p_kos THEN 0 ELSE 1 END );
         RETURN;
     END;

     -- блок перевірок

     IF l_SMS_ACC_TEMPLATES.NOT_SEND IS NOT NULL
     THEN -- якщо не потрібно відправляти смс шаблон то виходимо
       RETURN;
     END IF;

      if ( l_SMS_ACC_TEMPLATES.ID = 8 )
      THEN -- якщо смс шаблон по теплому кредиту то перевіряємо чи з рахунку відшкодування прийшли кошти
          -- знаходимо параметр рахунку відшкодування в глобальних параметрах
        select val
          into l_warm_nls
          from PARAMS$BASE
         where par = 'WARM_CREDIT_NLS'
           and kf = l_kf;

        if ( l_warm_nls = p_nlsa )
        then -- відповідно до заявки: якщо було відшкодування по теплому кредиту - смс по даному рахунку відключаємо
          logger.trace (title || 'warm_credit_sms for acc:' || to_char(p_acc) );
/*        update accounts t1
             set T1.SEND_SMS = null
           where t1.acc = p_acc;
*/
        else
          return;
        end if;

      end if;

      --кінець перевірок

      BEGIN

        g_sms_msg('cyr') := l_SMS_ACC_TEMPLATES.Text_Cyr;
        g_sms_msg('lat') := l_SMS_ACC_TEMPLATES.Text_Lat;

        g_sms_msg('cyr') := REPLACE( g_sms_msg ('cyr'), '<\n>', CHR (10) );
        g_sms_msg('lat') := REPLACE( g_sms_msg ('lat'), '<\n>', CHR (10) );

        FOR i IN 1 .. 2
        LOOP
          g_msg_flags( g_cyr_lat(i) ).nls       := case when instr( g_sms_msg( g_cyr_lat(i) ), '<NLS>'    ) > 0 then TRUE else FALSE end;
          g_msg_flags( g_cyr_lat(i) ).kv        := case when instr( g_sms_msg( g_cyr_lat(i) ), '<KV>'     ) > 0 then TRUE else FALSE end;
          g_msg_flags( g_cyr_lat(i) ).dat       := case when instr( g_sms_msg( g_cyr_lat(i) ), '<DAT>'    ) > 0 then TRUE else FALSE end;
          g_msg_flags( g_cyr_lat(i) ).ostc      := case when instr( g_sms_msg( g_cyr_lat(i) ), '<OSTC>'   ) > 0 then TRUE else FALSE end;
          g_msg_flags( g_cyr_lat(i) ).dos_delta := case when instr( g_sms_msg( g_cyr_lat(i) ), '<DOS>'    ) > 0 then TRUE else FALSE end;
          g_msg_flags( g_cyr_lat(i) ).kos_delta := case when instr( g_sms_msg( g_cyr_lat(i) ), '<KOS>'    ) > 0 then TRUE else FALSE end;
          g_msg_flags( g_cyr_lat(i) ).nlsb      := case when instr( g_sms_msg( g_cyr_lat(i) ), '<NLSB>'   ) > 0 then TRUE else FALSE end;
          g_msg_flags( g_cyr_lat(i) ).dep_num   := case when instr( g_sms_msg( g_cyr_lat(i) ), '<DEP_NUM>') > 0 then TRUE else FALSE end;
        END LOOP;

      END;

      -- необходимые преобразования
      l_encode   := CASE WHEN p_encode IS NULL THEN G_SMS_CHAR ELSE p_encode END;
      l_ost      := p_ostc / 100;
      l_ostc_str := TO_CHAR( l_ost, g_number_format, g_number_nlsparam );
      l_dos      := p_dos / 100;
      l_dos_str  := TO_CHAR( l_dos, g_number_format, g_number_nlsparam );
      l_kos      := p_kos / 100;
      l_kos_str  := TO_CHAR( l_kos, g_number_format, g_number_nlsparam );
      l_time_str := TO_CHAR( p_change_time, g_tm_fmt );
      l_msg      := g_sms_msg( l_encode );

      IF ( l_SMS_ACC_TEMPLATES.Acc_Nbs IN ('2620','2630','2628','2638') )
      OR ( l_SMS_ACC_TEMPLATES.id = 3 )
      THEN
        BEGIN
          SELECT DT.deposit_id
            INTO l_nd
            FROM dpt_accounts d, dpt_deposit dt, accounts a
           WHERE D.DPTID = DT.DEPOSIT_ID
             AND D.ACCID = a.acc
             AND a.acc = p_acc;
         EXCEPTION
           WHEN NO_DATA_FOUND
           THEN l_nd := NULL;
         END;
      END IF;

      -- выполняем подмены в шаблоне
      IF g_msg_flags(l_encode).nls
      THEN
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
         l_msg := SUBSTR( REPLACE( l_msg, '<KOS>', l_kos_str), 1, 160);
      END IF;

      IF g_msg_flags (l_encode).nlsb
      THEN
         l_msg := SUBSTR( REPLACE( l_msg, '<NLSB>', SUBSTR(p_nlsb,1,6)||'******'||SUBSTR(p_nlsb, -2) ), 1, 160 );
      END IF;

      IF g_msg_flags (l_encode).dep_num
      THEN
         l_msg := SUBSTR (REPLACE (l_msg, '<DEP_NUM>', NVL (l_nd, ' ')), 1, 160);
      END IF;

    -- создаем само сообщение
    BARS_SMS.CREATE_MSG( l_msgid,
                         l_crtime,
                         l_crtime + G_SMS_ACT / 24,
                         p_phone,
                         l_encode,
                         l_msg,
                         l_kf );

    -- добавляем доп. информацию по сообщению
    insert
      into ACC_MSG
         ( MSG_ID,CHANGE_TIME, RNK, ACC, DOS_DELTA, KOS_DELTA, OSTC )
    values
         ( l_msgid, p_change_time, l_rnk, p_acc, p_dos, p_kos, p_ostc );

  END prepare_acc_msg;

   ----
   -- prepare_submit_data - подготавливает данные для посылки SMS
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
         -- готовим данные для посылки SMS по конкретному изменению остатка
         IF c.id = c.max_id
         THEN                             -- только для самых свежих изменений
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
                        'SMS. Для счета ACC='
                     || c.acc
                     || ' не указаны номера мобильных телефонов');
            END;
         END IF;

         -- удаляем обработанную запись об изменении остатка
         DELETE FROM acc_balance_changes
               WHERE ROWID = c.ROWID;
      END LOOP;
   --
   END prepare_submit_data;

  ----
  -- PREPARE_SUBMIT_DATA - подготавливает данные для посылки SMS
  --
  procedure PREPARE_EVERYDAY_SMS
  is
    l_sys_dt   date;
    l_bnk_dt   date;
  begin

    l_sys_dt := sysdate;
    l_bnk_dt := trunc(l_sys_dt);

    bars_audit.trace ( '%s.PREPARE_EVERYDAY_SMS: Entry ( l_bnk_dt=%s ).', title, to_char(l_bnk_dt,g_dt_fmt) );

    for cur
     in ( select t.ACC, PHONE, PHONE1, PHONE2, ENCODE, ENCODE1, ENCODE2
               , s.DOS, s.KOS, s.OSTF+s.KOS-s.DOS as OST
            from ( select ACC, PHONE, PHONE1, PHONE2, ENCODE, ENCODE1, ENCODE2
                     from ACC_SMS_PHONES
                    where DAILYREPORT = 'Y'
                      and ( ( PHONE  IS NOT NULL and LENGTH(PHONE ) > 9 )
                         or ( PHONE1 IS NOT NULL and LENGTH(PHONE1) > 9 )
                         or ( PHONE2 IS NOT NULL and LENGTH(PHONE2) > 9 )
                          )
                 ) t
            join SALDOA s
              on ( s.ACC = t.ACC and s.FDAT = l_bnk_dt )
        )
    loop

      bars_audit.trace ( '%s.PREPARE_EVERYDAY_SMS: acc=%s ).', title, to_char(cur.ACC) );

      begin

        if ( cur.PHONE is not null )
        then
          PREPARE_ACC_MSG
          ( p_phone       => cur.PHONE
          , p_encode      => cur.ENCODE
          , p_change_time => l_sys_dt
          , p_rnk         => null
          , p_acc         => cur.ACC
          , p_dos         => cur.DOS
          , p_kos         => cur.KOS
          , p_ostc        => cur.OST
          , p_ref         => null
          , p_tt          => null
          , p_nlsb        => null
          , p_nlsa        => null
          );
        end if;

        if ( cur.PHONE1 is not null )
        then
          PREPARE_ACC_MSG
          ( p_phone       => cur.PHONE1
          , p_encode      => cur.ENCODE1
          , p_change_time => l_sys_dt
          , p_rnk         => null
          , p_acc         => cur.ACC
          , p_dos         => cur.DOS
          , p_kos         => cur.KOS
          , p_ostc        => cur.OST
          , p_ref         => null
          , p_tt          => null
          , p_nlsb        => null
          , p_nlsa        => null
          );
        end if;

        if ( cur.PHONE2 is not null )
        then
          PREPARE_ACC_MSG
          ( p_phone       => cur.PHONE2
          , p_encode      => cur.ENCODE2
          , p_change_time => l_sys_dt
          , p_rnk         => null
          , p_acc         => cur.ACC
          , p_dos         => cur.DOS
          , p_kos         => cur.KOS
          , p_ostc        => cur.OST
          , p_ref         => null
          , p_tt          => null
          , p_nlsb        => null
          , p_nlsa        => null
          );
        end if;

      exception
        when OTHERS
        then bars_audit.error( title||'.PREPARE_EVERYDAY_SMS: ( acc='||to_char(cur.ACC)||', errmsg='||sqlerrm||' ).' );
      end;

    end loop;

    bars_audit.trace( '%s.PREPARE_EVERYDAY_SMS: Exit.', title );

  END PREPARE_EVERYDAY_SMS;

   ----
   -- set_acc_phones - встановлення номерів  для SMS інформування
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
   -- change_acc_phones - зміна номерів  для SMS інформування після зміни в картці клієнта
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
END BARS_SMS_ACC;
/

show errors;

grant EXECUTE on BARS_SMS_ACC to BARS_ACCESS_DEFROLE;
grant EXECUTE on BARS_SMS_ACC to CUST001;
grant EXECUTE on BARS_SMS_ACC to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sms_acc.sql =========*** End **
PROMPT ===================================================================================== 
