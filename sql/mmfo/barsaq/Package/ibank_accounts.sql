
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/ibank_accounts.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.IBANK_ACCOUNTS is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 07.10.2008
  -- Purpose    : Пакет процедур для синхронизации по счетам для IBANK

  -- global consts
  G_HEADER_VERSION constant varchar2(64) := 'version 1.2 13/05/2017';

  G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := 'KF - схема с полем ''kf''' || chr(10) || chr(13) || 'ZAY - заявки на покупку/продажу валюты' || chr(10) || chr(13);

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- trim_spaces - заменяет несколько подряд идущих пробелов на один
  --
  function trim_spaces(p_source varchar2) return varchar2;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из ARC_RRP
  --  для внешнего документа
  --
  function extract_bis_external(p_ref in number, p_scn in number default null) return varchar2;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из ARC_RRP
  --  для внешнего документа
  --
  function extract_bis_external_clob(p_ref in number, p_scn in number default null) return clob;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из OPERW
  --  для внутреннего документа
  --
  function extract_bis_internal(p_ref in number, p_scn in number default null) return varchar2;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из OPERW
  --  для внутреннего документа
  --
  function extract_bis_internal_clob(p_ref in number, p_scn in number default null) return clob;


  ----
  -- lock_account - блокируем счет
  -- @param p_acc - асс счета
  --
  procedure lock_account(p_acc in integer);

  --
  --  Преобразование BARS.SALDOA
  --
  function transform_saldoa(p_anydata in sys.anydata) return sys.anydata;
  function transform_saldoa_test(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.OPLDOK
  --
  function transform_opldok(p_anydata in sys.anydata) return sys.anydata;

  ----
  -- subscribe - подпысывает на изменения по счету p_acc
  --
  procedure subscribe(p_acc in integer);


  ------------------------------------
  --  UNSUBSCRIBE
  --
  -- удаляет подписку на изменения по счету p_acc
  --
  procedure unsubscribe(p_acc in integer);

  ------------------------------------
  -- IS_SUBSCRIBED
  --
  -- проверяет подписан ли счет на захват изменений
  --
  function is_subscribed(p_acc in integer) return integer;

  ------------------------------------
  -- IS_CUST_SUBSCRIBED
  --
  -- проверяет подписан ли клиент на захват изменений
  --
  function is_cust_subscribed(p_rnk in integer) return integer;

  ------------------------------------
  -- IS_DOC_IMPORTED
  --
  -- проверяет был ли документ импортирован из клиент-банка
  --
  function is_doc_imported(p_ref in integer) return integer;

  ---------------------------------------------------
  --
  -- handler_contracts - обработчик для top_contracts
  --
  --  @p_obj - исходный LCR
  --
  procedure handler_contracts(p_obj in sys.anydata);

  --
  --  Преобразование BARS.PARAMS --> BARSAQ.BANKDATES
  --
  function bankdates(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.CUR_RATES(CUR_RATES$BASE) --> BARSAQ.CURRENCY_RATES
  --
  function currency_rates(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.TOBO(BRANCH) --> BARSAQ.BRANCHES
  --
  function branches(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.HOLIDAY --> BARSAQ.HOLIDAYS
  --
  function holidays(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.BANKS(BANKS$BASE) --> BARSAQ.BANKS
  --
  function banks(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.SW_BANKS --> BARSAQ.SWIFT_BANKS
  --
  function swift_banks(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.SOS_TRACK --> BARSAQ.DOC_EXPORT
  --
  function doc_export(p_anydata in sys.anydata) return sys.anydata;

  ---------------------------------------------------
  --
  -- handler_sync - обработчик для sync_-процессов
  --
  --  @p_obj - исходный LCR
  --
  procedure handler_sync(p_obj in sys.anydata);

  ---------------------------------------------------
  --
  -- acc_transactions_handler - обработчик для acc_transactions
  --
  --  @p_obj - исходный LCR
  --
  procedure acc_transactions_handler(p_obj in sys.anydata);
   PROCEDURE acc_transactions_test_handler (p_obj IN SYS.ANYDATA);

  --
  --  Преобразование BARS.BIRJA --> BARSAQ.DOC_CUREX_PARAMS
  --
  function doc_curex_params(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.CUST_ZAY --> BARSAQ.DOC_CUREX_CUSTCOMMISSIONS
  --
  function doc_curex_custcommissions(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.ZAY_COMISS --> BARSAQ.DOC_CUREX_EXCLUSIVE
  --
  function doc_curex_exclusive(p_anydata in sys.anydata) return sys.anydata;

  --
  --  Преобразование BARS.CUSTOMER_ADDRESS --> BARSAQ.CUST_ADDRESSES
  --
  function cust_addresses(p_anydata in sys.anydata) return sys.anydata;

  ------------------------------------
  -- IS_CLIENT_ZAYAVKA
  --
  -- проверяет была ли заявка импортирована из клиент-банка
  --
  function is_client_zayavka(p_id in integer) return integer;

  ---------------------------------------------------
  --
  -- zay_handler - обработчик для заявок на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure zay_handler(p_obj in sys.anydata);

  ---------------------------------------------------
  --
  -- doccurexparams_handler - обработчик параметров на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure doccurexparams_handler(p_obj in sys.anydata);

  ---------------------------------------------------
  --
  -- doccurexcustcomm_handler - обработчик параметров на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure doccurexcustcomm_handler(p_obj in sys.anydata);

  ---------------------------------------------------
  --
  -- doccurexexclusive_handler - обработчик параметров на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure doccurexexclusive_handler(p_obj in sys.anydata);

  procedure SetTransform_CutRUKey;
  FUNCTION CutRUKey (p_anydata IN SYS.ANYDATA)    RETURN SYS.ANYDATA;

end ibank_accounts;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.IBANK_ACCOUNTS 
IS
   -- global consts
   G_BODY_VERSION    CONSTANT VARCHAR2 (64) := 'version 1.5 13/05/2017';

   G_AWK_BODY_DEFS   CONSTANT VARCHAR2 (512)
      :=    ''
         || 'KF - схема с полем ''kf'''
         || CHR (10)
         || 'ZAY - заявки на покупку/продажу валюты'
         || CHR (10) ;

   -- делитель для национальной валюты
   g_base_val                 bars.tabval.kv%TYPE := 980;
   g_base_denom               bars.tabval.denom%TYPE := 100;
   g_errmsg   VARCHAR2 (4000);

   TYPE t_narrative_record IS RECORD
   (
      nazn    bars.oper.nazn%TYPE,
      d_rec   bars.oper.d_rec%TYPE,
      bis     bars.oper.bis%TYPE
   );

   TYPE t_narrative_array IS TABLE OF t_narrative_record
      INDEX BY PLS_INTEGER;

   TYPE t_operw_record IS RECORD
   (
      row_num     INTEGER,
      row_value   VARCHAR2 (32767)
   );

   TYPE t_operw_array IS TABLE OF t_operw_record
      INDEX BY PLS_INTEGER;

   ----
   -- header_version - возвращает версию заголовка пакета
   --
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package header '
             || G_HEADER_VERSION
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || G_AWK_HEADER_DEFS;
   END header_version;

   ----
   -- body_version - возвращает версию тела пакета
   --
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN    'Package body '
             || G_BODY_VERSION
             || 'awk: '
             || '.'
             || CHR (10)
             || 'AWK definition: '
             || CHR (10)
             || G_AWK_BODY_DEFS;
   END body_version;

   ----
   -- init - инициализация пакета
   --
   PROCEDURE init
   IS
   BEGIN
      IF    SYS_CONTEXT ('userenv', 'client_identifier') IS NULL
         OR SYS_CONTEXT ('bars_global', 'user_id') IS NULL
      THEN
         DECLARE
            l_userid   INTEGER;
         BEGIN
            -- регистрируем сессию от имени BARSAQ, т.к. STREAMS запускаются от имени SYS
            SELECT id
              INTO l_userid
              FROM bars.staff$base
             WHERE logname = 'BARSAQ';

            --
            bars.bars_login.login_user (SYS_GUID (),
                                        l_userid,
                                        NULL,
                                        'STREAMS');
         END;

         logger.trace ('ibank_accounts.init() new session');
      ELSE
         logger.trace ('ibank_accounts.init() existing session');
      END IF;

      logger.trace (
         'ibank_accounts.init(), proxy_user=%s, bars_global.user_id=%s',
         NVL (SYS_CONTEXT ('userenv', 'proxy_user'), 'null'),
         NVL (SYS_CONTEXT ('bars_global', 'user_id'), 'null'));
   --
   END init;

   ----
   -- возвращает флаг включенной трассировки
   FUNCTION trace_enabled
      RETURN BOOLEAN
   IS
   BEGIN
      IF logger.get_log_level >= logger.LOG_LEVEL_TRACE
      THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   END trace_enabled;

   ----
   -- trim_spaces - заменяет несколько подряд идущих пробелов на один
   --
   FUNCTION trim_spaces (p_source VARCHAR2)
      RETURN VARCHAR2
   IS
      l_target   VARCHAR2 (32767) := '';
      l_trims    VARCHAR2 (32767);
      i          INTEGER := 1;
      l_length   INTEGER := LENGTH (p_source);
      l_char     CHAR;
   BEGIN
      WHILE i <= l_length
      LOOP
         l_char := SUBSTR (p_source, i, 1);
         l_target := l_target || l_char;
         i := i + 1;

         WHILE l_char = ' ' AND SUBSTR (p_source, i, 1) = ' '
         LOOP
            i := i + 1;
         END LOOP;
      END LOOP;

      LOOP
         l_trims := l_target;
         l_target :=
            REPLACE (l_target,
                     ' ' || CHR (13) || CHR (10),
                     CHR (13) || CHR (10));
         EXIT WHEN l_trims = l_target;
      END LOOP;

      RETURN l_target;
   END trim_spaces;

   ----
   --  Извлекает БИС(Блок Информационных Строк) по референсу из ARC_RRP
   --  для внешнего документа
   --
   FUNCTION extract_bis_external (p_ref   IN NUMBER,
                                  p_scn   IN NUMBER DEFAULT NULL)
      RETURN VARCHAR2
   IS
      l_narrative_array   t_narrative_array;
      l_result            VARCHAR2 (32767);
      l_scn               NUMBER;
   BEGIN
      l_scn := NVL (p_scn, sys.DBMS_FLASHBACK.get_system_change_number ());

        SELECT nazn, d_rec, bis
          BULK COLLECT INTO l_narrative_array
          FROM bars.arc_rrp
         WHERE REF = p_ref
      ORDER BY bis;

      if l_narrative_array.count() = 0 then
         return null;
      end if;
      l_result := l_narrative_array (1).d_rec;

      IF l_narrative_array (1).bis = 1
      THEN
         FOR i IN 2 .. l_narrative_array.COUNT
         LOOP
            l_result :=
                  l_result
               || CHR (10)
               || l_narrative_array (i).nazn
               || l_narrative_array (i).d_rec;
         END LOOP;
      END IF;

      RETURN l_result;
   END extract_bis_external;

   ----
   --  Извлекает БИС(Блок Информационных Строк) по референсу из ARC_RRP
   --  для внешнего документа
   --
   FUNCTION extract_bis_external_clob (p_ref   IN NUMBER,
                                       p_scn   IN NUMBER DEFAULT NULL)
      RETURN CLOB
   IS
      l_clob   CLOB;
   BEGIN

      l_clob := extract_bis_external (p_ref, p_scn);
      RETURN l_clob;
   END extract_bis_external_clob;

   ----
   --  Извлекает БИС(Блок Информационных Строк) по референсу из OPERW
   --  для внутреннего документа
   --
   FUNCTION extract_bis_internal (p_ref   IN NUMBER,
                                  p_scn   IN NUMBER DEFAULT NULL)
      RETURN VARCHAR2
   IS
      l_operw_array   t_operw_array;
      l_result        VARCHAR2 (32767);
      l_temp          VARCHAR2 (32767);
      l_scn           NUMBER;
   BEGIN
      l_scn := NVL (p_scn, sys.DBMS_FLASHBACK.get_system_change_number ());

      -- читаем доп.реквизиты из oper
      SELECT d_rec
        INTO l_result
        FROM bars.oper AS OF SCN l_scn
       WHERE REF = p_ref;

        -- читаем реквизиты для дополнительных строк БИС
        SELECT ROWNUM row_num,
                  '#'
               || f.vspo_char
               || DECODE (f.vspo_char, 'F', TRIM (w.tag) || ':', NULL)
               || REPLACE (
                     trim_spaces (VALUE),
                     CHR (13) || CHR (10),
                        '#'
                     || CHR (10)
                     || '#'
                     || f.vspo_char
                     || DECODE (f.vspo_char, 'F', TRIM (w.tag) || ':', NULL))
               || '#'
                  row_value
          BULK COLLECT INTO l_operw_array
          FROM bars.operw w, bars.op_field f
         WHERE     w.REF = p_ref
               AND w.tag = f.tag and w.value is not null
               AND f.vspo_char IS NOT NULL
               AND f.vspo_char IN ('C', 'П', 'F')
      ORDER BY w.tag;

      IF l_operw_array.COUNT > 0
      THEN
         FOR i IN 1 .. l_operw_array.COUNT
         LOOP
            l_temp := l_temp || CHR (10) || l_operw_array (i).row_value;
         END LOOP;

         IF l_result IS NULL OR l_result NOT LIKE '#B%'
         THEN
            l_result :=
                  '#B'
               || LPAD (
                     TO_CHAR (
                          -- вычисляем кол-во строк, разделенных chr(10)
                          -- когда все перейдут на 11g, заменить на
                          -- nvl(regexp_count(l_temp,chr(10)),0)+1
                          NVL (LENGTH (l_temp), 0)
                        - NVL (LENGTH (REPLACE (l_temp, CHR (10), NULL)), 0)
                        + 1),
                     2,
                     '0')
               || NVL (l_result, '#');
         END IF;

         l_result := l_result || l_temp;
      END IF;

      RETURN l_result;
   END extract_bis_internal;

   ----
   --  Извлекает БИС(Блок Информационных Строк) по референсу из OPERW
   --  для внутреннего документа
   --
   FUNCTION extract_bis_internal_clob (p_ref   IN NUMBER,
                                       p_scn   IN NUMBER DEFAULT NULL)
      RETURN CLOB
   IS
      l_clob   CLOB;
   BEGIN
      l_clob := extract_bis_internal (p_ref, p_scn);
      RETURN l_clob;
   END extract_bis_internal_clob;

   ----
   -- lock_account - блокируем счет
   -- @param p_acc - асс счета
   --
   PROCEDURE lock_account (p_acc IN INTEGER)
   IS
      l_acc   bars.accounts.acc%TYPE;
   BEGIN
          -- блокируем счет(с ожиданием 10 сек), чтобы по нему не было никаких операций (т.е. изменений по saldoa и opldok)
          SELECT acc
            INTO l_acc
            FROM bars.accounts
           WHERE acc = p_acc
      FOR UPDATE WAIT 10;
   END lock_account;

   --
   --  Преобразование BARS.SALDOA
   --
   FUNCTION transform_saldoa (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.transform_saldoa';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_command          VARCHAR2 (9);
      l_value            SYS.ANYDATA;
      l_vt               VARCHAR2 (3);
      l_denom            bars.tabval.denom%TYPE;
      l_acc              bars.saldoa.acc%TYPE;
      l_fdat             bars.saldoa.fdat%TYPE;
      l_kv               bars.accounts.kv%TYPE;
      l_row              acc_turnovers%ROWTYPE;
   BEGIN
      logger.trace ('%s : invoked', l_label);

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_command := l_source.get_command_type ();
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => l_command,
            object_owner           => 'BARSAQ',
            object_name            => 'ACC_TURNOVERS',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());

      -- формируем поля целевой таблицы
      FOR i IN 1 .. 2
      LOOP
         -- старые/новые значения
         l_vt := CASE WHEN i = 1 THEN 'old' ELSE 'new' END;
         -- обнуляем для контроля полей первичного ключа
         l_acc := NULL;
         -- acc, fdat
         l_value := l_source.get_value (l_vt, 'ACC');

         IF l_value IS NOT NULL
         THEN
            -- acc присутствует, значит есть остальные ключевые поля
            l_acc := l_value.AccessNumber ();
            l_fdat := l_source.get_value (l_vt, 'FDAT').AccessDate ();
            l_row.turns_date := l_fdat;
            -- на случай, если очистили наш контекст
            init;

            -- получаем значения для целевого ключа
            BEGIN
            SELECT kf, nls, kv
              INTO l_row.bank_id, l_row.acc_num, l_row.cur_id
              FROM v_kf_accounts
             WHERE acc = l_acc;
            EXCEPTION
               WHEN OTHERS
               THEN
               raise_application_error (
                  -20000,
                  'No data found: SELECT kf, nls, kv FROM v_kf_accounts WHERE acc = ' || l_acc);
            end;

            -- добавляем поля целевой таблицы
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_row.bank_id));
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'ACC_NUM',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_row.acc_num));
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'CUR_ID',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (l_row.cur_id));
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'TURNS_DATE',
               COLUMN_VALUE   => sys.anydata.ConvertDate (l_fdat));
         END IF;

         -- pdat
         l_value := l_source.get_value (l_vt, 'PDAT', 'N');

         IF l_value IS NOT NULL
         THEN
            l_target.add_column (value_type     => l_vt,
                                 column_name    => 'PREV_TURNS_DATE',
                                 COLUMN_VALUE   => l_value);
         END IF;

         -- узнаем делитель валюты
         IF l_acc IS NOT NULL
         THEN
            SELECT denom
              INTO l_denom
              FROM bars.tabval
             WHERE kv = l_row.cur_id;
         ELSE
            l_denom := g_base_denom;
         END IF;

         -- ostf
         l_value := l_source.get_value (l_vt, 'OSTF', 'N');

         IF l_value IS NOT NULL
         THEN
            l_row.balance := l_value.AccessNumber () / l_denom;
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'BALANCE',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (l_row.balance));
         END IF;

         -- dos
         l_value := l_source.get_value (l_vt, 'DOS', 'N');

         IF l_value IS NOT NULL
         THEN
            l_row.debit_turns := l_value.AccessNumber () / l_denom;
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'DEBIT_TURNS',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (l_row.debit_turns));
         END IF;

         -- kos
         l_value := l_source.get_value (l_vt, 'KOS', 'N');

         IF l_value IS NOT NULL
         THEN
            l_row.credit_turns := l_value.AccessNumber () / l_denom;
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'CREDIT_TURNS',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (
                                   l_row.credit_turns));
         END IF;

         -- эквиваленты(всегда расчетные) пишем только для валютных счетов
         IF     l_acc IS NOT NULL
            AND l_row.cur_id IS NOT NULL
            AND l_row.cur_id <> g_base_val
         THEN
            BEGIN
               -- обращения к пакету GL выполняем внутри МФО
               bars_sync.subst_mfo (l_row.bank_id);
               -- ostf(eq)
               l_value := l_source.get_value (l_vt, 'OSTF', 'N');

               IF l_value IS NOT NULL
               THEN
                  l_row.balance_eq :=
                       bars.gl.p_icurval (l_row.cur_id,
                                          l_value.AccessNumber (),
                                          l_row.turns_date)
                     / g_base_denom;
                  l_target.add_column (
                     l_vt,
                     'BALANCE_EQ',
                     sys.anydata.ConvertNumber (l_row.balance_eq));
               END IF;

               -- dos(eq)
               l_value := l_source.get_value (l_vt, 'DOS', 'N');

               IF l_value IS NOT NULL
               THEN
                  l_row.debit_turns_eq :=
                       bars.gl.p_icurval (l_row.cur_id,
                                          l_value.AccessNumber (),
                                          l_row.turns_date)
                     / g_base_denom;
                  l_target.add_column (
                     l_vt,
                     'DEBIT_TURNS_EQ',
                     sys.anydata.ConvertNumber (l_row.debit_turns_eq));
               END IF;

               -- kos(eq)
               l_value := l_source.get_value (l_vt, 'KOS', 'N');

               IF l_value IS NOT NULL
               THEN
                  l_row.credit_turns_eq :=
                       bars.gl.p_icurval (l_row.cur_id,
                                          l_value.AccessNumber (),
                                          l_row.turns_date)
                     / g_base_denom;
                  l_target.add_column (
                     l_vt,
                     'CREDIT_TURNS_EQ',
                     sys.anydata.ConvertNumber (l_row.credit_turns_eq));
               END IF;

               -- возвращаемся в свой контекст
               bars_sync.set_context ();
            EXCEPTION
               WHEN OTHERS
               THEN
                  -- возвращаемся в свой контекст
                  bars_sync.set_context ();
                  RAISE;
            END;
         END IF;
      END LOOP;

      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END transform_saldoa;

FUNCTION transform_saldoa_test (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.transform_saldoa_test';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_command          VARCHAR2 (9);
      l_value            SYS.ANYDATA;
      l_vt               VARCHAR2 (3);
      l_denom            bars.tabval.denom%TYPE;
      l_acc              bars.saldoa.acc%TYPE;
      l_fdat             bars.saldoa.fdat%TYPE;
      l_kv               bars.accounts.kv%TYPE;
      l_row              acc_turnovers_test%ROWTYPE;
   BEGIN
      logger.trace ('%s : invoked', l_label);

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_command := l_source.get_command_type ();
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => l_command,
            object_owner           => 'BARSAQ',
            object_name            => 'ACC_TURNOVERS_TEST',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());

      -- формируем поля целевой таблицы
      FOR i IN 1 .. 2
      LOOP
         -- старые/новые значения
         l_vt := CASE WHEN i = 1 THEN 'old' ELSE 'new' END;
         -- обнуляем для контроля полей первичного ключа
         l_acc := NULL;
         -- acc, fdat
         l_value := l_source.get_value (l_vt, 'ACC');

         IF l_value IS NOT NULL
         THEN
            -- acc присутствует, значит есть остальные ключевые поля
            l_acc := l_value.AccessNumber ();
            l_fdat := l_source.get_value (l_vt, 'FDAT').AccessDate ();
            l_row.turns_date := l_fdat;
            -- на случай, если очистили наш контекст
            init;

            -- получаем значения для целевого ключа
            BEGIN
            SELECT kf, nls, kv
              INTO l_row.bank_id, l_row.acc_num, l_row.cur_id
              FROM v_kf_accounts saldoatest
             WHERE acc = l_acc;
            EXCEPTION
               WHEN OTHERS
               THEN
               raise_application_error (
                  -20000,
                  'No data found: SELECT kf, nls, kv FROM v_kf_accounts WHERE acc = ' || l_acc);
            end;

            -- добавляем поля целевой таблицы
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_row.bank_id));
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'ACC_NUM',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_row.acc_num));
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'CUR_ID',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (l_row.cur_id));
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'TURNS_DATE',
               COLUMN_VALUE   => sys.anydata.ConvertDate (l_fdat));
         END IF;

         -- pdat
         l_value := l_source.get_value (l_vt, 'PDAT', 'N');

         IF l_value IS NOT NULL
         THEN
            l_target.add_column (value_type     => l_vt,
                                 column_name    => 'PREV_TURNS_DATE',
                                 COLUMN_VALUE   => l_value);
         END IF;

         -- узнаем делитель валюты
         IF l_acc IS NOT NULL
         THEN
            SELECT denom
              INTO l_denom
              FROM bars.tabval
             WHERE kv = l_row.cur_id;
         ELSE
            l_denom := g_base_denom;
         END IF;

         -- ostf
         l_value := l_source.get_value (l_vt, 'OSTF', 'N');

         IF l_value IS NOT NULL
         THEN
            l_row.balance := l_value.AccessNumber () / l_denom;
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'BALANCE',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (l_row.balance));
         END IF;

         -- dos
         l_value := l_source.get_value (l_vt, 'DOS', 'N');

         IF l_value IS NOT NULL
         THEN
            l_row.debit_turns := l_value.AccessNumber () / l_denom;
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'DEBIT_TURNS',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (l_row.debit_turns));
         END IF;

         -- kos
         l_value := l_source.get_value (l_vt, 'KOS', 'N');

         IF l_value IS NOT NULL
         THEN
            l_row.credit_turns := l_value.AccessNumber () / l_denom;
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'CREDIT_TURNS',
               COLUMN_VALUE   => sys.anydata.ConvertNumber (
                                   l_row.credit_turns));
         END IF;

         -- эквиваленты(всегда расчетные) пишем только для валютных счетов
         IF     l_acc IS NOT NULL
            AND l_row.cur_id IS NOT NULL
            AND l_row.cur_id <> g_base_val
         THEN
            BEGIN
               -- обращения к пакету GL выполняем внутри МФО
               bars_sync.subst_mfo (l_row.bank_id);
               -- ostf(eq)
               l_value := l_source.get_value (l_vt, 'OSTF', 'N');

               IF l_value IS NOT NULL
               THEN
                  l_row.balance_eq :=
                       bars.gl.p_icurval (l_row.cur_id,
                                          l_value.AccessNumber (),
                                          l_row.turns_date)
                     / g_base_denom;
                  l_target.add_column (
                     l_vt,
                     'BALANCE_EQ',
                     sys.anydata.ConvertNumber (l_row.balance_eq));
               END IF;

               -- dos(eq)
               l_value := l_source.get_value (l_vt, 'DOS', 'N');

               IF l_value IS NOT NULL
               THEN
                  l_row.debit_turns_eq :=
                       bars.gl.p_icurval (l_row.cur_id,
                                          l_value.AccessNumber (),
                                          l_row.turns_date)
                     / g_base_denom;
                  l_target.add_column (
                     l_vt,
                     'DEBIT_TURNS_EQ',
                     sys.anydata.ConvertNumber (l_row.debit_turns_eq));
               END IF;

               -- kos(eq)
               l_value := l_source.get_value (l_vt, 'KOS', 'N');

               IF l_value IS NOT NULL
               THEN
                  l_row.credit_turns_eq :=
                       bars.gl.p_icurval (l_row.cur_id,
                                          l_value.AccessNumber (),
                                          l_row.turns_date)
                     / g_base_denom;
                  l_target.add_column (
                     l_vt,
                     'CREDIT_TURNS_EQ',
                     sys.anydata.ConvertNumber (l_row.credit_turns_eq));
               END IF;

               -- возвращаемся в свой контекст
               bars_sync.set_context ();
            EXCEPTION
               WHEN OTHERS
               THEN
                  -- возвращаемся в свой контекст
                  bars_sync.set_context ();
                  RAISE;
            END;
         END IF;
      END LOOP;

      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END transform_saldoa_test;


      --
   --  Преобразование BARS.OPLDOK
   --
   FUNCTION transform_opldok (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.transform_opldok';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_command          VARCHAR2 (9);
      l_value            SYS.ANYDATA;
      l_vt               VARCHAR2 (3);
      l_denom            bars.tabval.denom%TYPE;
      l_opla             bars.opldok%ROWTYPE;
      l_oplb             bars.opldok%ROWTYPE;
      l_oper             bars.oper%ROWTYPE;
      l_trans            acc_transactions%ROWTYPE;
      l_kv               bars.accounts.kv%TYPE;
      l_opldok_exists    BOOLEAN;
      l_rnk              INTEGER;
      l_ref92            bars.operw.VALUE%TYPE;
   BEGIN
      logger.trace ('%s : invoked', l_label);
      -- на случай, если очистили наш контекст
      init;

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)||chr(13)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_command :=
         CASE
            WHEN l_source.get_command_type () = 'DELETE' THEN 'DELETE'
            ELSE 'INSERT'
         END;
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => l_command,
            object_owner           => 'BARSAQ',
            object_name            => 'ACC_TRANSACTIONS',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());
      --
      l_vt := CASE WHEN l_command = 'DELETE' THEN 'old' ELSE 'new' END;
      -- формируем поля целевой таблицы
      l_opla.stmt := l_source.get_value (l_vt, 'STMT').AccessNumber ();
      l_opla.acc := l_source.get_value (l_vt, 'ACC').AccessNumber ();
      logger.trace ('l_vt=%s, l_opla.stmt=%s, l_opla.acc=%s',  p_arg1 =>  l_vt, p_arg2 =>  l_opla.stmt, p_arg3 =>  l_opla.acc);

      -- определяемся с первичным ключем для acc_transactions
      SELECT kf, nls, kv
        INTO l_trans.bank_id, l_trans.acc_num, l_trans.cur_id
        FROM v_kf_accounts
       WHERE acc = l_opla.acc;
      logger.trace ('l_trans.bank_id=%s, l_trans.acc_num=%s, l_trans.cur_id=%s', p_arg1 =>  l_trans.bank_id, p_arg2 =>  l_trans.acc_num, p_arg3 =>  l_trans.cur_id);

      l_trans.trans_id := TO_CHAR (l_opla.stmt);
      -- формируем ключевые поля
      -- BANK_ID
      l_target.add_column (l_vt,
                           'BANK_ID',
                           sys.anydata.ConvertVarchar2 (l_trans.bank_id));
      -- ACC_NUM
      l_target.add_column (l_vt,
                           'ACC_NUM',
                           sys.anydata.ConvertVarchar2 (l_trans.acc_num));
      -- CUR_ID
      l_target.add_column (l_vt,
                           'CUR_ID',
                           sys.anydata.ConvertNumber (l_trans.cur_id));
      -- TRANS_ID
      l_target.add_column (l_vt,
                           'TRANS_ID',
                           sys.anydata.ConvertVarchar2 (l_trans.trans_id));

      --
      IF l_command = 'INSERT'
      THEN
         -- для вставки наполняем неключевые значения
         -- дочитываем неключевые значения
         l_opla.REF := l_source.get_value (l_vt, 'REF').AccessNumber ();
         l_opla.dk := l_source.get_value (l_vt, 'DK').AccessNumber ();
         l_opla.tt := l_source.get_value (l_vt, 'TT').AccessChar ();
         l_opla.fdat := l_source.get_value (l_vt, 'FDAT').AccessDate ();
         l_opla.s := l_source.get_value (l_vt, 'S').AccessNumber ();
         l_opla.sq := l_source.get_value (l_vt, 'SQ').AccessNumber ();
         l_opla.txt := l_source.get_value (l_vt, 'TXT').AccessVarchar2 ();
         l_opla.sos := l_source.get_value (l_vt, 'SOS').AccessNumber ();

         logger.trace ('INSERT Stage 1');
         IF l_opla.tt IN ('902', '901')
         THEN
            BEGIN
               SELECT VALUE
                 INTO l_ref92
                 FROM bars.operw
                WHERE REF = l_opla.REF AND tag = 'REF92';

               SELECT mfoa,
                      id_a,
                      nlsa,
                      nam_a
                 INTO l_trans.ref92_bank_id,
                      l_trans.ref92_cust_code,
                      l_trans.ref92_acc_num,
                      l_trans.ref92_acc_name
                 FROM bars.oper
                WHERE REF = l_ref92;

               SELECT b.nb
                 INTO l_trans.ref92_bank_name
                 FROM bars.BANKS$BASE b
                WHERE b.Mfo = l_trans.ref92_bank_id;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;

         -- узнаем валюту счета и ее делитель
         SELECT kv
           INTO l_kv
           FROM bars.accounts
          WHERE acc = l_opla.acc;

         SELECT denom
           INTO l_denom
           FROM bars.tabval
          WHERE kv = l_kv;

         logger.trace ('INSERT Stage 2: l_kv=%s, l_denom=%s', p_arg1 => l_kv, p_arg2 => l_denom);
         -- получим запись из oper
         BEGIN
            SELECT *
              INTO l_oper
              FROM bars.oper
             WHERE REF = l_opla.REF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               logger.trace ('INSERT Stage 3: no data found');
               l_source.set_tag(utl_raw.cast_to_raw('CANCEL'));
               RETURN anydata.ConvertObject(l_source);
               --raise_application_error (
               --   -20000,
               --  'No data found: select from oper where ref=' || l_opla.REF || ', l_opla.acc=' || l_opla.acc);
         END;

         -- номер и дату документа всегда берем из OPER'a, больше неоткуда
         l_trans.doc_number := l_oper.nd;
         l_trans.doc_date := l_oper.pdat;

         logger.trace ('INSERT Stage 4: l_oper.nd=%s, l_oper.pdat=%s', p_arg1 => l_oper.nd, p_arg2 => l_oper.pdat);
         BEGIN
            SELECT dat
              INTO l_trans.doc_date
              FROM bars.oper_visa
             WHERE     REF = l_opla.REF
                   AND groupid NOT IN (77, 80, 81, 30)
                   AND status = 2;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         --
         l_trans.doc_id := TO_CHAR (l_opla.REF);
         l_trans.trans_date := l_opla.fdat;
         l_trans.type_id := CASE WHEN l_opla.dk = 0 THEN 'D' ELSE 'C' END;
         --
         l_trans.trans_sum := l_opla.s / l_denom;
         l_trans.trans_sum_eq := l_opla.sq / g_base_denom;

         -- получаем вторую половину проводки
         BEGIN
            SELECT *
              INTO l_oplb
              FROM bars.opldok
             WHERE     REF = l_opla.REF
                   AND stmt = l_opla.stmt
                   AND dk = 1 - l_opla.dk;

            l_opldok_exists := TRUE;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_opldok_exists := FALSE;
         END;

         logger.trace ('INSERT Stage 5');
         -- определяемся откуда брать вторую половину проводки: из oper или opldok
         IF     (                                    -- разновалютная операция
                 l_oper .kv IS NOT NULL
                    AND l_oper.kv2 IS NOT NULL
                    AND l_oper.kv <> l_oper.kv2
                 -- отличается тип операции в oper и opldok
                 OR l_oper.tt <> l_opla.tt
                 -- отличается сумма операции в oper и opldok
                 OR l_oper.s <> l_opla.s)
            --  и записи в OPLDOK еще существуют
            AND l_opldok_exists
            --  и операция <> R01 (все проводки R01 трактуем как родительские)
            AND l_opla.tt <> 'R01'
         THEN
            -- в этих случаях трактуем проводку как дочернюю и реквизиты ищем в accounts и customer
            -- по acc счета корреспондента получим его номер и наименование + rnk клиента-владельца счета
            SELECT kf,
                   nls,
                   SUBSTR (nms, 1, 38),
                   rnk
              INTO l_trans.corr_bank_id,
                   l_trans.corr_acc_num,
                   l_trans.corr_name,
                   l_rnk
              FROM v_kf_accounts
             WHERE acc = l_oplb.acc;

            -- по rnk владельца получим его идент. код
            SELECT okpo
              INTO l_trans.corr_ident_code
              FROM bars.customer
             WHERE rnk = l_rnk;

            -- банк корреспондента - наш
            SELECT nb
              INTO l_trans.corr_bank_name
              FROM bars.banks
             WHERE mfo = l_trans.corr_bank_id;

            -- назначение платежа клеим с двух частей
            l_trans.narrative :=
               TRIM (l_oplb.txt) || ' ' || TRIM (l_oper.nazn);
            -- БИС строк для дочерних проводок не пишем
            l_trans.narrative_extra := NULL;
         ELSE
            -- иначе, трактуем проводку как основную и реквизиты берем из oper
            IF    l_opla.dk = 0 AND l_oper.dk = 1
               OR l_opla.dk = 1 AND l_oper.dk = 0
            THEN
               -- в даном случае берем строну B из oper
               SELECT nb
                 INTO l_trans.corr_bank_name
                 FROM bars.banks
                WHERE mfo = l_oper.mfob;

               -- заполняем поля строки
               l_trans.corr_bank_id := l_oper.mfob;
               l_trans.corr_ident_code := l_oper.id_b;
               l_trans.corr_acc_num := l_oper.nlsb;
               l_trans.corr_name := l_oper.nam_b;
               l_trans.name := l_oper.nam_a;
            ELSE
               -- в даном случае берем строну A из oper
               SELECT nb
                 INTO l_trans.corr_bank_name
                 FROM bars.banks
                WHERE mfo = l_oper.mfoa;

               -- заполняем поля строки
               l_trans.corr_bank_id := l_oper.mfoa;
               l_trans.corr_ident_code := l_oper.id_a;
               l_trans.corr_acc_num := l_oper.nlsa;
               l_trans.corr_name := l_oper.nam_a;
               l_trans.name := l_oper.nam_b;
            END IF;

            -- заполняем назначение платежа
            l_trans.narrative := nvl(l_oper.nazn,' ');
            -- заполняем дополнительные строки БИС
            l_trans.narrative_extra :=
               CASE
                  WHEN l_oper.mfoa <> l_oper.mfob OR l_opla.tt = 'R01'
                  THEN
                     ibank_accounts.extract_bis_external (l_oper.REF)
                  ELSE
                     ibank_accounts.extract_bis_internal (l_oper.REF)
               END;
         END IF;

         -- ищем id документа интернет-банкинга
         BEGIN
            SELECT TO_NUMBER (VALUE)
              INTO l_trans.ibank_docid
              FROM bars.operw
             WHERE REF = l_opla.REF AND tag = 'EXREF';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_trans.ibank_docid := NULL;
         END;

         -- формируем поля в target lcr
         -- TRANS_DATE
         l_target.add_column (l_vt,
                              'TRANS_DATE',
                              sys.anydata.ConvertDate (l_trans.trans_date));
         -- DOC_ID
         l_target.add_column (l_vt,
                              'DOC_ID',
                              sys.anydata.ConvertVarchar2 (l_trans.doc_id));
         -- DOC_NUMBER
         l_target.add_column (
            l_vt,
            'DOC_NUMBER',
            sys.anydata.ConvertVarchar2 (l_trans.doc_number));
         -- DOC_DATE
         l_target.add_column (l_vt,
                              'DOC_DATE',
                              sys.anydata.ConvertDate (l_trans.doc_date));
         -- TYPE_ID
         l_target.add_column (l_vt,
                              'TYPE_ID',
                              sys.anydata.ConvertVarchar2 (l_trans.type_id));
         -- TRANS_SUM
         l_target.add_column (l_vt,
                              'TRANS_SUM',
                              sys.anydata.ConvertNumber (l_trans.trans_sum));
         -- TRANS_SUM_EQ
         l_target.add_column (
            l_vt,
            'TRANS_SUM_EQ',
            sys.anydata.ConvertNumber (l_trans.trans_sum_eq));
         -- CORR_BANK_ID
         l_target.add_column (
            l_vt,
            'CORR_BANK_ID',
            sys.anydata.ConvertVarchar2 (l_trans.corr_bank_id));
         -- CORR_BANK_NAME
         l_target.add_column (
            l_vt,
            'CORR_BANK_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.corr_bank_name));
         -- CORR_IDENT_CODE
         l_target.add_column (
            l_vt,
            'CORR_IDENT_CODE',
            sys.anydata.ConvertVarchar2 (l_trans.corr_ident_code));
         -- CORR_ACC_NUM
         l_target.add_column (
            l_vt,
            'CORR_ACC_NUM',
            sys.anydata.ConvertVarchar2 (l_trans.corr_acc_num));
         -- CORR_NAME
         l_target.add_column (
            l_vt,
            'CORR_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.corr_name));
         -- NARRATIVE
         l_target.add_column (
            l_vt,
            'NARRATIVE',
            sys.anydata.ConvertVarchar2 (l_trans.narrative));

         -- NARRATIVE_EXTRA
         -- Здесь внимание! CLOB нельзя запихнуть в конструируемый LCR,
         -- поэтому вставляем его как Varchar2, т.к. он гарантировано меньше 32K
         l_target.add_column (
            l_vt,
            'NARRATIVE_EXTRA',
            sys.anydata.ConvertVarchar2 (l_trans.narrative_extra));
         -- IBANK_DOCID
         l_target.add_column (
            l_vt,
            'IBANK_DOCID',
            sys.anydata.ConvertNumber (l_trans.ibank_docid));
         -- REF92_BANK_ID
         l_target.add_column (
            l_vt,
            'REF92_BANK_ID',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_bank_id));
         -- REF92_CUST_CODE
         l_target.add_column (
            l_vt,
            'REF92_CUST_CODE',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_cust_code));
         -- REF92_ACC_NUM
         l_target.add_column (
            l_vt,
            'REF92_ACC_NUM',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_acc_num));
         -- REF92_ACC_NAME
         l_target.add_column (
            l_vt,
            'REF92_ACC_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_acc_name));
         -- REF92_BANK_NAME
         l_target.add_column (
            l_vt,
            'REF92_BANK_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_bank_name));
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)||chr(13)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_target), 3900)),
            l_label||' (OUT)');
      END IF;

      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END transform_opldok;

   ----
   -- update_transaction_clob - модифицирует поле narrative_extra типа clob
   -- т.к. lcr.execute() его не трогает
   --
   PROCEDURE update_transaction_clob (p_obj IN SYS.ANYDATA)
   IS
      l_tran      acc_transactions%ROWTYPE;
      l_command   VARCHAR2 (9);
      l_vt        VARCHAR2 (3);
      l_source    SYS.lcr$_row_record;
      l_value     SYS.ANYDATA;
      l_rc        NUMBER;
   BEGIN
      -- преобразуем ANYDATA в LCR
      l_rc := p_obj.getobject (l_source);
      --
      l_command :=
         CASE
            WHEN l_source.get_command_type () = 'DELETE' THEN 'DELETE'
            ELSE 'INSERT'
         END;
      l_vt := CASE WHEN l_command = 'DELETE' THEN 'old' ELSE 'new' END;
      --
      l_value := l_source.get_value (l_vt, 'NARRATIVE_EXTRA');

      --
      IF l_value IS NOT NULL
      THEN
         l_tran.narrative_extra := l_value.AccessVarchar2 ();

         --
         IF l_tran.narrative_extra IS NOT NULL
         THEN
            --
            l_tran.bank_id :=
               l_source.get_value (l_vt, 'BANK_ID').AccessVarchar2 ();
            l_tran.acc_num :=
               l_source.get_value (l_vt, 'ACC_NUM').AccessVarchar2 ();
            l_tran.cur_id :=
               l_source.get_value (l_vt, 'CUR_ID').AccessNumber ();
            l_tran.trans_id :=
               l_source.get_value (l_vt, 'TRANS_ID').AccessVarchar2 ();

            --
            UPDATE acc_transactions
               SET narrative_extra = l_tran.narrative_extra
             WHERE     bank_id = l_tran.bank_id
                   AND acc_num = l_tran.acc_num
                   AND cur_id = l_tran.cur_id
                   AND trans_id = l_tran.trans_id;
         END IF;
      END IF;
   --
   END update_transaction_clob;

FUNCTION transform_opldok_test (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.transform_opldok_test';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_command          VARCHAR2 (9);
      l_value            SYS.ANYDATA;
      l_vt               VARCHAR2 (3);
      l_denom            bars.tabval.denom%TYPE;
      l_opla             bars.opldok%ROWTYPE;
      l_oplb             bars.opldok%ROWTYPE;
      l_oper             bars.oper%ROWTYPE;
      l_trans            acc_transactions_test%ROWTYPE;
      l_kv               bars.accounts.kv%TYPE;
      l_opldok_exists    BOOLEAN;
      l_rnk              INTEGER;
      l_ref92            bars.operw.VALUE%TYPE;
   BEGIN
      logger.trace ('%s : invoked', l_label);
      -- на случай, если очистили наш контекст
      init;

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)||chr(13)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_command := l_source.get_command_type ();
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => l_command,
            object_owner           => 'BARSAQ',
            object_name            => 'ACC_TRANSACTIONS_TEST',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());


      -- формируем поля целевой таблицы
      FOR i IN 1 .. 2 LOOP
         -- старые/новые значения
         l_vt := CASE WHEN i = 1 THEN 'OLD' ELSE 'NEW' END;
         -- обнуляем для контроля полей первичного ключа
         -- REF
         l_value := l_source.get_value (l_vt, 'REF', 'N');

         IF l_value IS NOT NULL THEN
            -- формируем поля целевой таблицы
            l_opla.stmt := l_source.get_value (l_vt, 'STMT', 'N').AccessNumber ();
            l_opla.acc := l_source.get_value (l_vt, 'ACC', 'N').AccessNumber ();
            logger.trace ('l_vt=%s, l_opla.stmt=%s, l_opla.acc=%s',  p_arg1 =>  l_vt, p_arg2 =>  l_opla.stmt, p_arg3 =>  l_opla.acc);

            -- определяемся с первичным ключем для acc_transactions_test
            SELECT kf, nls, kv
              INTO l_trans.bank_id, l_trans.acc_num, l_trans.cur_id
              FROM v_kf_accounts
             WHERE acc = l_opla.acc;
            logger.trace ('l_trans.bank_id=%s, l_trans.acc_num=%s, l_trans.cur_id=%s', p_arg1 =>  l_trans.bank_id, p_arg2 =>  l_trans.acc_num, p_arg3 =>  l_trans.cur_id);

            l_trans.trans_id :=  (l_opla.stmt);
            -- формируем ключевые поля
            -- BANK_ID
            l_target.add_column (l_vt,
                                 'BANK_ID',
                                 sys.anydata.ConvertVarchar2 (l_trans.bank_id));
            -- ACC_NUM
            l_target.add_column (l_vt,
                                 'ACC_NUM',
                                 sys.anydata.ConvertVarchar2 (l_trans.acc_num));
            -- CUR_ID
            l_target.add_column (l_vt,
                                 'CUR_ID',
                                 sys.anydata.ConvertNumber (l_trans.cur_id));
            -- TRANS_ID
            l_target.add_column (l_vt,
                                 'TRANS_ID',
                                 sys.anydata.ConvertNumber (l_trans.trans_id));
         end if;
      end loop;

      --
      IF (l_command = 'INSERT') or (l_command = 'UPDATE' and l_vt = 'NEW')
      THEN
         -- для вставки наполняем неключевые значения
         -- дочитываем неключевые значения
         l_opla.REF := l_source.get_value (l_vt, 'REF', 'N').AccessNumber ();
         l_opla.dk := l_source.get_value (l_vt, 'DK', 'N').AccessNumber ();
         l_opla.tt := l_source.get_value (l_vt, 'TT', 'N').AccessChar ();
         l_opla.fdat := l_source.get_value (l_vt, 'FDAT', 'N').AccessDate ();
         l_opla.s := l_source.get_value (l_vt, 'S', 'N').AccessNumber ();
         l_opla.sq := l_source.get_value (l_vt, 'SQ', 'N').AccessNumber ();
         l_opla.txt := l_source.get_value (l_vt, 'TXT', 'N').AccessVarchar2 ();
         l_opla.sos := l_source.get_value (l_vt, 'SOS', 'N').AccessNumber ();

         logger.trace ('INSERT Stage 1');
         IF l_opla.tt IN ('902', '901')
         THEN
            BEGIN
               SELECT VALUE
                 INTO l_ref92
                 FROM bars.operw
                WHERE REF = l_opla.REF AND tag = 'REF92';

               SELECT mfoa,
                      id_a,
                      nlsa,
                      nam_a
                 INTO l_trans.ref92_bank_id,
                      l_trans.ref92_cust_code,
                      l_trans.ref92_acc_num,
                      l_trans.ref92_acc_name
                 FROM bars.oper
                WHERE REF = l_ref92;

               SELECT b.nb
                 INTO l_trans.ref92_bank_name
                 FROM bars.BANKS$BASE b
                WHERE b.Mfo = l_trans.ref92_bank_id;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;

         -- узнаем валюту счета и ее делитель
         SELECT kv
           INTO l_kv
           FROM bars.accounts
          WHERE acc = l_opla.acc;

         SELECT denom
           INTO l_denom
           FROM bars.tabval
          WHERE kv = l_kv;

         logger.trace ('INSERT Stage 2: l_kv=%s, l_denom=%s', p_arg1 => l_kv, p_arg2 => l_denom);
         -- получим запись из oper
         BEGIN
            SELECT *
              INTO l_oper
              FROM bars.oper
             WHERE REF = l_opla.REF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               logger.trace ('INSERT Stage 3: no data found');
               l_source.set_tag(utl_raw.cast_to_raw('CANCEL'));
               RETURN anydata.ConvertObject(l_source);
               --raise_application_error (
               --   -20000,
               --  'No data found: select from oper where ref=' || l_opla.REF || ', l_opla.acc=' || l_opla.acc);
         END;

         -- номер и дату документа всегда берем из OPER'a, больше неоткуда
         l_trans.doc_number := l_oper.nd;
         l_trans.doc_date := l_oper.pdat;

         logger.trace ('INSERT Stage 4: l_oper.nd=%s, l_oper.pdat=%s', p_arg1 => l_oper.nd, p_arg2 => l_oper.pdat);
         BEGIN
            SELECT dat
              INTO l_trans.doc_date
              FROM bars.oper_visa
             WHERE     REF = l_opla.REF
                   AND groupid NOT IN (77, 80, 81, 30)
                   AND status = 2;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         --
         l_trans.doc_id := TO_CHAR (l_opla.REF);
         l_trans.trans_date := l_opla.fdat;
         l_trans.type_id := CASE WHEN l_opla.dk = 0 THEN 'D' ELSE 'C' END;
         --
         l_trans.trans_sum := l_opla.s / l_denom;
         l_trans.trans_sum_eq := l_opla.sq / g_base_denom;

         -- получаем вторую половину проводки
         BEGIN
            SELECT *
              INTO l_oplb
              FROM bars.opldok
             WHERE     REF = l_opla.REF
                   AND stmt = l_opla.stmt
                   AND dk = 1 - l_opla.dk;

            l_opldok_exists := TRUE;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_opldok_exists := FALSE;
         END;

         logger.trace ('INSERT Stage 5');
         -- определяемся откуда брать вторую половину проводки: из oper или opldok
         IF     (                                    -- разновалютная операция
                 l_oper .kv IS NOT NULL
                    AND l_oper.kv2 IS NOT NULL
                    AND l_oper.kv <> l_oper.kv2
                 -- отличается тип операции в oper и opldok
                 OR l_oper.tt <> l_opla.tt
                 -- отличается сумма операции в oper и opldok
                 OR l_oper.s <> l_opla.s)
            --  и записи в OPLDOK еще существуют
            AND l_opldok_exists
            --  и операция <> R01 (все проводки R01 трактуем как родительские)
            AND l_opla.tt <> 'R01'
         THEN
            -- в этих случаях трактуем проводку как дочернюю и реквизиты ищем в accounts и customer
            -- по acc счета корреспондента получим его номер и наименование + rnk клиента-владельца счета
            SELECT kf,
                   nls,
                   SUBSTR (nms, 1, 38),
                   rnk
              INTO l_trans.corr_bank_id,
                   l_trans.corr_acc_num,
                   l_trans.corr_name,
                   l_rnk
              FROM v_kf_accounts
             WHERE acc = l_oplb.acc;

            -- по rnk владельца получим его идент. код
            SELECT okpo
              INTO l_trans.corr_ident_code
              FROM bars.customer
             WHERE rnk = l_rnk;

            -- банк корреспондента - наш
            SELECT nb
              INTO l_trans.corr_bank_name
              FROM bars.banks
             WHERE mfo = l_trans.corr_bank_id;

            -- назначение платежа клеим с двух частей
            l_trans.narrative :=
               TRIM (l_oplb.txt) || ' ' || TRIM (l_oper.nazn);
            -- БИС строк для дочерних проводок не пишем
            l_trans.narrative_extra := NULL;
         ELSE
            -- иначе, трактуем проводку как основную и реквизиты берем из oper
            IF    l_opla.dk = 0 AND l_oper.dk = 1
               OR l_opla.dk = 1 AND l_oper.dk = 0
            THEN
               -- в даном случае берем строну B из oper
               SELECT nb
                 INTO l_trans.corr_bank_name
                 FROM bars.banks
                WHERE mfo = l_oper.mfob;

               -- заполняем поля строки
               l_trans.corr_bank_id := l_oper.mfob;
               l_trans.corr_ident_code := l_oper.id_b;
               l_trans.corr_acc_num := l_oper.nlsb;
               l_trans.corr_name := l_oper.nam_b;
               l_trans.name := l_oper.nam_a;
            ELSE
               -- в даном случае берем строну A из oper
               SELECT nb
                 INTO l_trans.corr_bank_name
                 FROM bars.banks
                WHERE mfo = l_oper.mfoa;

               -- заполняем поля строки
               l_trans.corr_bank_id := l_oper.mfoa;
               l_trans.corr_ident_code := l_oper.id_a;
               l_trans.corr_acc_num := l_oper.nlsa;
               l_trans.corr_name := l_oper.nam_a;
               l_trans.name := l_oper.nam_b;
            END IF;

            -- заполняем назначение платежа
            l_trans.narrative := nvl(l_oper.nazn,' ');
            -- заполняем дополнительные строки БИС
            l_trans.narrative_extra :=
               CASE
                  WHEN l_oper.mfoa <> l_oper.mfob OR l_opla.tt = 'R01'
                  THEN
                     ibank_accounts.extract_bis_external (l_oper.REF)
                  ELSE
                     ibank_accounts.extract_bis_internal (l_oper.REF)
               END;
         END IF;

         -- ищем id документа интернет-банкинга
         BEGIN
            SELECT TO_NUMBER (VALUE)
              INTO l_trans.ibank_docid
              FROM bars.operw
             WHERE REF = l_opla.REF AND tag = 'EXREF';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_trans.ibank_docid := NULL;
         END;

         -- формируем поля в target lcr
         -- TRANS_DATE
         l_target.add_column (l_vt,
                              'TRANS_DATE',
                              sys.anydata.ConvertDate (l_trans.trans_date));
         -- DOC_ID
         l_target.add_column (l_vt,
                              'DOC_ID',
                              sys.anydata.ConvertVarchar2 (l_trans.doc_id));
         -- DOC_NUMBER
         l_target.add_column (
            l_vt,
            'DOC_NUMBER',
            sys.anydata.ConvertVarchar2 (l_trans.doc_number));
         -- DOC_DATE
         l_target.add_column (l_vt,
                              'DOC_DATE',
                              sys.anydata.ConvertDate (l_trans.doc_date));
         -- TYPE_ID
         l_target.add_column (l_vt,
                              'TYPE_ID',
                              sys.anydata.ConvertVarchar2 (l_trans.type_id));
         -- TRANS_SUM
         l_target.add_column (l_vt,
                              'TRANS_SUM',
                              sys.anydata.ConvertNumber (l_trans.trans_sum));
         -- TRANS_SUM_EQ
         l_target.add_column (
            l_vt,
            'TRANS_SUM_EQ',
            sys.anydata.ConvertNumber (l_trans.trans_sum_eq));
         -- CORR_BANK_ID
         l_target.add_column (
            l_vt,
            'CORR_BANK_ID',
            sys.anydata.ConvertVarchar2 (l_trans.corr_bank_id));
         -- CORR_BANK_NAME
         l_target.add_column (
            l_vt,
            'CORR_BANK_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.corr_bank_name));
         -- CORR_IDENT_CODE
         l_target.add_column (
            l_vt,
            'CORR_IDENT_CODE',
            sys.anydata.ConvertVarchar2 (l_trans.corr_ident_code));
         -- CORR_ACC_NUM
         l_target.add_column (
            l_vt,
            'CORR_ACC_NUM',
            sys.anydata.ConvertVarchar2 (l_trans.corr_acc_num));
         -- CORR_NAME
         l_target.add_column (
            l_vt,
            'CORR_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.corr_name));
         -- NARRATIVE
         l_target.add_column (
            l_vt,
            'NARRATIVE',
            sys.anydata.ConvertVarchar2 (l_trans.narrative));

         -- NARRATIVE_EXTRA
         -- Здесь внимание! CLOB нельзя запихнуть в конструируемый LCR,
         -- поэтому вставляем его как Varchar2, т.к. он гарантировано меньше 32K
         l_target.add_column (
            l_vt,
            'NARRATIVE_EXTRA',
            sys.anydata.ConvertVarchar2 (l_trans.narrative_extra));
         -- IBANK_DOCID
         l_target.add_column (
            l_vt,
            'IBANK_DOCID',
            sys.anydata.ConvertNumber (l_trans.ibank_docid));
         -- REF92_BANK_ID
         l_target.add_column (
            l_vt,
            'REF92_BANK_ID',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_bank_id));
         -- REF92_CUST_CODE
         l_target.add_column (
            l_vt,
            'REF92_CUST_CODE',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_cust_code));
         -- REF92_ACC_NUM
         l_target.add_column (
            l_vt,
            'REF92_ACC_NUM',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_acc_num));
         -- REF92_ACC_NAME
         l_target.add_column (
            l_vt,
            'REF92_ACC_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_acc_name));
         -- REF92_BANK_NAME
         l_target.add_column (
            l_vt,
            'REF92_BANK_NAME',
            sys.anydata.ConvertVarchar2 (l_trans.ref92_bank_name));
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)||chr(13)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_target), 3900)),
            l_label||' (OUT)');
      END IF;

      -- возвращаем объект
      bars.bars_audit.info('StreamsLCR:'||chr(13)||chr(10)||sys.dbms_streams.convert_lcr_to_xml(anydata.ConvertObject (l_target)).GetClobVal());
      RETURN anydata.ConvertObject (l_target);
   END transform_opldok_test;


PROCEDURE update_transaction_clob_test (p_obj IN SYS.ANYDATA)
   IS
      l_tran      acc_transactions_test%ROWTYPE;
      l_command   VARCHAR2 (9);
      l_vt        VARCHAR2 (3);
      l_source    SYS.lcr$_row_record;
      l_value     SYS.ANYDATA;
      l_rc        NUMBER;
   BEGIN
      -- преобразуем ANYDATA в LCR
      l_rc := p_obj.getobject (l_source);
      --
      l_command :=
         CASE
            WHEN l_source.get_command_type () = 'DELETE' THEN 'DELETE'
            ELSE 'INSERT'
         END;
      l_vt := CASE WHEN l_command = 'DELETE' THEN 'old' ELSE 'new' END;
      --
      l_value := l_source.get_value (l_vt, 'NARRATIVE_EXTRA');

      --
      IF l_value IS NOT NULL
      THEN
         l_tran.narrative_extra := l_value.AccessVarchar2 ();

         --
         IF l_tran.narrative_extra IS NOT NULL
         THEN
            --
            l_tran.bank_id :=
               l_source.get_value (l_vt, 'BANK_ID').AccessVarchar2 ();
            l_tran.acc_num :=
               l_source.get_value (l_vt, 'ACC_NUM').AccessVarchar2 ();
            l_tran.cur_id :=
               l_source.get_value (l_vt, 'CUR_ID').AccessNumber ();
            l_tran.trans_id :=
               l_source.get_value (l_vt, 'TRANS_ID').AccessNumber ();

            --
            UPDATE acc_transactions_test
               SET narrative_extra = l_tran.narrative_extra
             WHERE     bank_id = l_tran.bank_id
                   AND acc_num = l_tran.acc_num
                   AND cur_id = l_tran.cur_id
                   AND trans_id = l_tran.trans_id;
         END IF;
      END IF;
   --
   END update_transaction_clob_test;

         ----
   -- subscribe - подпысывает на изменения по счету p_acc
   --
   PROCEDURE subscribe (p_acc IN INTEGER)
   IS
   BEGIN
      INSERT INTO ibank_acc (kf, acc)
         SELECT kf, acc
           FROM v_kf_accounts
          WHERE acc = p_acc;

      bars.bars_audit.info (
            'IBANK подписан на изменения по счету ACC='
         || p_acc);
   EXCEPTION
      WHEN OTHERS
      THEN
            g_errmsg :=
               SUBSTR (
                     'handler_sync error:20000: '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace (),
                  1,
                  4000);
            bars.bars_audit.error (g_errmsg);
              raise_application_error (
            -20000,
               'Помилка вставки в ibank_acc, acc='
            || p_acc
            || CHR (10)
            || SQLERRM,
            TRUE);
   END subscribe;

   ---------------------------
   --  UNSUBSCRIBE
   --
   --  удаляет подписку на изменения по счету p_acc
   --
   --
   PROCEDURE unsubscribe (p_acc IN INTEGER)
   IS
   BEGIN
      -- на случай, если очистили наш контекст
      init;

      DELETE FROM ibank_acc
            WHERE (kf, acc) = (SELECT kf, acc
                                 FROM v_kf_accounts
                                WHERE acc = p_acc);

      bars.bars_audit.info (
            'Удалена подписка IBANK на изменения по счету ACC='
         || p_acc);
   END unsubscribe;

   ------------------------------------
   -- IS_SUBSCRIBED
   --
   -- проверяет подписан ли счет на захват изменений
   --
   FUNCTION is_subscribed (p_acc IN INTEGER)
      RETURN INTEGER
   IS
      l_acc   ibank_acc.acc%TYPE;
   BEGIN
      -- на случай, если очистили наш контекст
      init;

      SELECT acc
        INTO l_acc
        FROM ibank_acc
       WHERE (kf, acc) = (SELECT kf, acc
                            FROM v_kf_accounts
                           WHERE acc = p_acc);

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 0;
   END is_subscribed;

   ------------------------------------
   -- IS_CUST_SUBSCRIBED
   --
   -- проверяет подписан ли клиент на захват изменений
   --
   FUNCTION is_cust_subscribed (p_rnk IN INTEGER)
      RETURN INTEGER
   IS
      l_rnk   ibank_rnk.rnk%TYPE;
   BEGIN
      SELECT rnk
        INTO l_rnk
        FROM ibank_rnk
       WHERE rnk = p_rnk AND ROWNUM = 1;

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 0;
   END is_cust_subscribed;

   ------------------------------------
   -- IS_DOC_IMPORTED
   --
   -- проверяет был ли документ импортирован из клиент-банка
   --
   FUNCTION is_doc_imported (p_ref IN INTEGER)
      RETURN INTEGER
   IS
      l_ref   INTEGER;
   BEGIN
      SELECT REF
        INTO l_ref
        FROM doc_import
       WHERE REF = p_ref;

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 0;
   END is_doc_imported;

   ---------------------------------------------------
   --
   -- handler_contracts - обработчик для contracts
   --
   --  @p_obj - исходный LCR
   --
   PROCEDURE handler_contracts (p_obj IN SYS.ANYDATA)
   IS
      l_source       SYS.lcr$_row_record;
      l_target       SYS.lcr$_row_record;
      l_rc           NUMBER;
      l_value_type   VARCHAR2 (3);
      l_value        SYS.ANYDATA;
      l_row          ibank_contracts%ROWTYPE;
      l_rowid        ROWID;
   BEGIN
      bars.bars_audit.trace ('handler_contracts start');

      IF p_obj.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
            g_errmsg :=
               SUBSTR (
                     'handler_sync error:20001: '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace (),
                  1,
                  4000);
            bars.bars_audit.error (g_errmsg);
         raise_application_error (
            -20001,
               'Неожидаемый тип объекта: '
            || p_obj.gettypename (),
            TRUE);
      END IF;

      -- Преобразуем ANYDATA в LCR
      l_rc := p_obj.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
            g_errmsg :=
               SUBSTR (
                     'handler_sync error:20002: '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace (),
                  1,
                  4000);
            bars.bars_audit.error (g_errmsg);
         raise_application_error (
            -20002,
               'Ошибка преобразования ANYDATA в LCR$_ROW_RECORD: '
            || l_rc,
            TRUE);
      END IF;

      IF trace_enabled ()
      THEN
         bars.bars_audit.trace (
               'handler_contracts() LCR:'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
      END IF;

      -- устанавливаем тип операции
      l_row.operation := l_source.get_command_type ();

      -- удаление не обрабатываем
      IF l_row.operation = 'DELETE'
      THEN
         RETURN;
      END IF;

      -- для вставки и модификации берем новые значения, для удаления - старые
      l_value_type :=
         CASE WHEN l_row.operation = 'DELETE' THEN 'OLD' ELSE 'NEW' END;
      -- наполняем ключевые поля
      l_row.pid := l_source.get_value (l_value_type, 'PID').AccessNumber ();

      SELECT kf
        INTO l_row.kf
        FROM v_kf_contracts
       WHERE pid = l_row.pid;

      -- наполняем неключевые поля
      IF l_row.operation IN ('INSERT', 'UPDATE')
      THEN
         -- IMPEXP
         l_value := l_source.get_value ('NEW', 'IMPEXP');

         IF l_value IS NOT NULL
         THEN
            l_row.impexp := l_value.AccessNumber ();
            l_row.exist_impexp := 'Y';
         END IF;

         -- RNK
         l_value := l_source.get_value ('NEW', 'RNK');

         IF l_value IS NOT NULL
         THEN
            l_row.rnk := l_value.AccessNumber ();
            l_row.exist_rnk := 'Y';
         END IF;

         -- NAME
         l_value := l_source.get_value ('NEW', 'NAME');

         IF l_value IS NOT NULL
         THEN
            l_row.name := l_value.AccessVarchar2 ();
            l_row.exist_name := 'Y';
         END IF;

         -- DATEOPEN
         l_value := l_source.get_value ('NEW', 'DATEOPEN');

         IF l_value IS NOT NULL
         THEN
            l_row.dateopen := l_value.AccessDate ();
            l_row.exist_dateopen := 'Y';
         END IF;

         -- DATECLOSE
         l_value := l_source.get_value ('NEW', 'DATECLOSE');

         IF l_value IS NOT NULL
         THEN
            l_row.dateclose := l_value.AccessDate ();
            l_row.exist_dateclose := 'Y';
         END IF;

         -- S
         l_value := l_source.get_value ('NEW', 'S');

         IF l_value IS NOT NULL
         THEN
            l_row.s := l_value.AccessNumber ();
            l_row.exist_s := 'Y';
         END IF;

         -- KV
         l_value := l_source.get_value ('NEW', 'KV');

         IF l_value IS NOT NULL
         THEN
            l_row.kv := l_value.AccessNumber ();
            l_row.exist_kv := 'Y';
         END IF;

         -- ID_OPER
         l_value := l_source.get_value ('NEW', 'ID_OPER');

         IF l_value IS NOT NULL
         THEN
            l_row.id_oper := l_value.AccessNumber ();
            l_row.exist_id_oper := 'Y';
         END IF;

         -- BENEFCOUNTRY
         l_value := l_source.get_value ('NEW', 'BENEFCOUNTRY');

         IF l_value IS NOT NULL
         THEN
            l_row.benefcountry := l_value.AccessNumber ();
            l_row.exist_benefcountry := 'Y';
         END IF;

         -- BENEFNAME
         l_value := l_source.get_value ('NEW', 'BENEFNAME');

         IF l_value IS NOT NULL
         THEN
            l_row.benefname := l_value.AccessVarchar2 ();
            l_row.exist_benefname := 'Y';
         END IF;

         -- BENEFBANK
         l_value := l_source.get_value ('NEW', 'BENEFBANK');

         IF l_value IS NOT NULL
         THEN
            l_row.benefbank := l_value.AccessVarchar2 ();
            l_row.exist_benefbank := 'Y';
         END IF;

         -- BENEFACC
         l_value := l_source.get_value ('NEW', 'BENEFACC');

         IF l_value IS NOT NULL
         THEN
            l_row.benefacc := l_value.AccessVarchar2 ();
            l_row.exist_benefacc := 'Y';
         END IF;

         -- AIM
         l_value := l_source.get_value ('NEW', 'AIM');

         IF l_value IS NOT NULL
         THEN
            l_row.aim := l_value.AccessVarchar2 ();
            l_row.exist_aim := 'Y';
         END IF;

         -- CONTINUED
         l_value := l_source.get_value ('NEW', 'CONTINUED');

         IF l_value IS NOT NULL
         THEN
            l_row.continued := l_value.AccessVarchar2 ();
            l_row.exist_continued := 'Y';
         END IF;

         -- COND
         l_value := l_source.get_value ('NEW', 'COND');

         IF l_value IS NOT NULL
         THEN
            l_row.cond := l_value.AccessVarchar2 ();
            l_row.exist_cond := 'Y';
         END IF;

         -- DETAILS
         l_value := l_source.get_value ('NEW', 'DETAILS');

         IF l_value IS NOT NULL
         THEN
            l_row.details := l_value.AccessVarchar2 ();
            l_row.exist_details := 'Y';
         END IF;

         -- BANKCOUNTRY
         l_value := l_source.get_value ('NEW', 'BANKCOUNTRY');

         IF l_value IS NOT NULL
         THEN
            l_row.bankcountry := l_value.AccessNumber ();
            l_row.exist_bankcountry := 'Y';
         END IF;
      END IF;

      -- вставляем запись в acc_turnovers
      INSERT INTO ibank_contracts
           VALUES l_row
        RETURNING ROWID
             INTO l_rowid;

      -- тут же удаляем
      DELETE FROM ibank_contracts
            WHERE ROWID = l_rowid;

      bars.bars_audit.trace ('handler_contracts finish');
   END handler_contracts;


   --
   --  Преобразование BARS.PARAMS --> BARSAQ.BANKDATES
   --
   FUNCTION bankdates (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_source   SYS.lcr$_row_record;
      l_target   SYS.lcr$_row_record;
      l_rc       NUMBER;
      l_value    SYS.ANYDATA;
      l_bankid   VARCHAR2 (11);
   BEGIN
      logger.trace ('ibank_acounts.bankdates(...) invoked');

      IF p_anydata.gettypename = 'SYS.LCR$_ROW_RECORD'
      THEN
         -- преобразуем ANYDATA в LCR
         l_rc := p_anydata.getobject (l_source);

         IF l_rc <> DBMS_TYPES.success
         THEN
            RETURN p_anydata;
         END IF;

         IF trace_enabled ()
         THEN
            logger.trace (
                  'bankdates LCR:'
               || CHR (10)
               || RTRIM (
                     DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
         END IF;

         -- конструируем LCR для применения к таблице
         l_target :=
            sys.lcr$_row_record.construct (
               source_database_name   => l_source.get_source_database_name (),
               command_type           => l_source.get_command_type (),
               object_owner           => 'BARSAQ',
               object_name            => 'BANKDATES',
               tag                    => l_source.get_tag (),
               transaction_id         => l_source.get_transaction_id (),
               scn                    => l_source.get_scn ());
         -- получаем код банка
         l_bankid := l_source.get_value ('old', 'KF').accessVarchar2 ();
         -- добавляем отдельные колонки
         --
         -- BANK_ID
         l_target.add_column (
            value_type     => 'old',
            column_name    => 'BANK_ID',
            COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
         -- BANKDATE
         l_value := l_source.get_value ('new', 'VAL');
         if l_value is null then
          l_target.add_column (
            value_type     => 'new',
            column_name    => 'BANKDATE',
            COLUMN_VALUE   => anydata.convertDate (
                                TO_DATE ('12/29/2015',
                                         'MM/DD/YYYY')));
         else
          l_target.add_column (
            value_type     => 'new',
            column_name    => 'BANKDATE',
            COLUMN_VALUE   => anydata.convertDate (
                                TO_DATE (l_value.accessVarchar2 (),
                                         'MM/DD/YYYY')));
         end if;
         --
         RETURN anydata.convertobject (l_target);
      END IF;

      RETURN p_anydata;
   END bankdates;

   --
   --  Преобразование BARS.CUR_RATES(CUR_RATES$BASE) --> BARSAQ.CURRENCY_RATES
   --
   FUNCTION currency_rates (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_source       SYS.lcr$_row_record;
      l_target       SYS.lcr$_row_record;
      l_rc           NUMBER;
      l_value        SYS.ANYDATA;
      l_value_type   VARCHAR2 (3);
      l_bankid       VARCHAR2 (11);
      l_branch       VARCHAR2 (30);
      l_command      VARCHAR2 (9);
      l_vt           VARCHAR2 (3);
   BEGIN
      logger.trace ('ibank_acounts.currency_rates(...) invoked');

      IF p_anydata.gettypename = 'SYS.LCR$_ROW_RECORD'
      THEN
         -- преобразуем ANYDATA в LCR
         l_rc := p_anydata.getobject (l_source);

         IF l_rc <> DBMS_TYPES.success
         THEN
            RETURN p_anydata;
         END IF;

         IF trace_enabled ()
         THEN
            logger.trace (
                  'currency_rates LCR:'
               || CHR (10)
               || RTRIM (
                     DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
         END IF;

         -- конструируем LCR для применения к таблице
         l_command := l_source.get_command_type ();
         l_target :=
            sys.lcr$_row_record.construct (
               source_database_name   => l_source.get_source_database_name (),
               command_type           => l_command,
               object_owner           => 'BARSAQ',
               object_name            => 'CURRENCY_RATES',
               tag                    => l_source.get_tag (),
               transaction_id         => l_source.get_transaction_id (),
               scn                    => l_source.get_scn ());
         -- для вставки и модификации берем новые значения, для удаления - старые
         l_value_type :=
            CASE
               WHEN l_source.get_command_type () = 'DELETE' THEN 'OLD'
               ELSE 'NEW'
            END;
         -- получаем код банка
         l_branch :=
            l_source.get_value (l_value_type, 'BRANCH').accessVarchar2 ();
         l_bankid := bars.bc.extract_mfo (l_branch);

         -- добавляем отдельные колонки
         --
         IF l_command IN ('DELETE', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- RATE_DATE
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'RATE_DATE',
               COLUMN_VALUE   => l_source.get_value ('old', 'VDATE'));
            -- CUR_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'CUR_ID',
               COLUMN_VALUE   => l_source.get_value ('old', 'KV'));
         END IF;

         IF l_command IN ('INSERT', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- RATE_DATE
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'RATE_DATE',
               COLUMN_VALUE   => l_source.get_value ('new', 'VDATE'));
            -- CUR_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'CUR_ID',
               COLUMN_VALUE   => l_source.get_value ('new', 'KV'));
            -- BASE_SUM
            l_value := l_source.get_value ('new', 'BSUM');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'BASE_SUM',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- RATE_OFFICIAL
            l_value := l_source.get_value ('new', 'RATE_O');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'RATE_OFFICIAL',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- RATE_BUYING
            l_value := l_source.get_value ('new', 'RATE_B');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'RATE_BUYING',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- RATE_SELLING
            l_value := l_source.get_value ('new', 'RATE_S');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'RATE_SELLING',
                                    COLUMN_VALUE   => l_value);
            END IF;
         END IF;

         --
         RETURN anydata.convertobject (l_target);
      END IF;

      RETURN p_anydata;
   END currency_rates;

   --
   --  Преобразование BARS.TOBO(BRANCH) --> BARSAQ.BRANCHES
   --
   FUNCTION branches (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_source       SYS.lcr$_row_record;
      l_target       SYS.lcr$_row_record;
      l_rc           NUMBER;
      l_value        SYS.ANYDATA;
      l_value_type   VARCHAR2 (3);
      l_bankid       VARCHAR2 (11);
      l_branch       VARCHAR2 (30);
      l_command      VARCHAR2 (9);
   BEGIN
      logger.trace ('ibank_acounts.branches(...) invoked');

      IF p_anydata.gettypename = 'SYS.LCR$_ROW_RECORD'
      THEN
         -- преобразуем ANYDATA в LCR
         l_rc := p_anydata.getobject (l_source);

         IF l_rc <> DBMS_TYPES.success
         THEN
            RETURN p_anydata;
         END IF;

         IF trace_enabled ()
         THEN
            logger.trace (
                  'branches LCR:'
               || CHR (10)
               || RTRIM (
                     DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
         END IF;

         -- конструируем LCR для применения к таблице
         l_command := l_source.get_command_type ();
         l_target :=
            sys.lcr$_row_record.construct (
               source_database_name   => l_source.get_source_database_name (),
               command_type           => l_command,
               object_owner           => 'BARSAQ',
               object_name            => 'BRANCHES',
               tag                    => l_source.get_tag (),
               transaction_id         => l_source.get_transaction_id (),
               scn                    => l_source.get_scn ());
         -- для вставки и модификации берем новые значения, для удаления - старые
         l_value_type :=
            CASE
               WHEN l_source.get_command_type () = 'DELETE' THEN 'OLD'
               ELSE 'NEW'
            END;
         -- получаем код банка
         l_branch :=
            l_source.get_value (l_value_type, 'BRANCH').accessVarchar2 ();
         l_bankid := bars.bc.extract_mfo (l_branch);

         -- добавляем отдельные колонки
         --
         IF l_command IN ('DELETE', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- BRANCH_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'BRANCH_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_branch));
         END IF;

         IF l_command IN ('INSERT', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- BRANCH_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'BRANCH_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_branch));
            -- NAME
            l_value := l_source.get_value ('new', 'NAME');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'NAME',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- DATE_OPENED
            l_value := l_source.get_value ('new', 'DATE_OPENED');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'DATE_OPENED',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- DATE_CLOSED
            l_value := l_source.get_value ('new', 'DATE_CLOSED');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'DATE_CLOSED',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- DESCRIPTION
            l_value := l_source.get_value ('new', 'DESCRIPTION');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'DESCRIPTION',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- NBU_CODE
            l_value := l_source.get_value ('new', 'B040');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'NBU_CODE',
                                    COLUMN_VALUE   => l_value);
            END IF;
         END IF;

         RETURN anydata.convertobject (l_target);
      END IF;

      RETURN p_anydata;
   END branches;

   --
   --  Преобразование BARS.HOLIDAY --> BARSAQ.HOLIDAYS
   --
   FUNCTION holidays (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.holidays';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_command          VARCHAR2 (9);
      l_value            SYS.ANYDATA;
      l_vt               VARCHAR2 (3);
   BEGIN
      logger.trace ('%s : invoked', l_label);

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_command := l_source.get_command_type ();
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => l_command,
            object_owner           => 'BARSAQ',
            object_name            => 'HOLIDAYS',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());

      -- формируем поля целевой таблицы
      FOR i IN 1 .. 2
      LOOP
         -- старые/новые значения
         l_vt := CASE WHEN i = 1 THEN 'old' ELSE 'new' END;
         -- KV --> CUR_ID
         l_value := l_source.get_value (l_vt, 'KV', 'N');

         IF l_value IS NOT NULL
         THEN
            l_target.add_column (value_type     => l_vt,
                                 column_name    => 'CUR_ID',
                                 COLUMN_VALUE   => l_value);
         END IF;

         -- HOLIDAY --> HOLIDAY
         l_value := l_source.get_value (l_vt, 'HOLIDAY', 'N');

         IF l_value IS NOT NULL
         THEN
            l_target.add_column (value_type     => l_vt,
                                 column_name    => 'HOLIDAY',
                                 COLUMN_VALUE   => l_value);
         END IF;
      END LOOP;

      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END holidays;

   --
   --  Преобразование BARS.BANKS(BANKS$BASE) --> BARSAQ.BANKS
   --
   FUNCTION banks (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.banks';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_command          VARCHAR2 (9);
      l_value            SYS.ANYDATA;
      l_vt               VARCHAR2 (3);
      l_closing_date     DATE;
      l_blk              NUMBER;
   BEGIN
      logger.trace ('%s : invoked', l_label);

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_command := l_source.get_command_type ();
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => l_command,
            object_owner           => 'BARSAQ',
            object_name            => 'BANKS',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());

      -- формируем поля целевой таблицы
      FOR i IN 1 .. 2
      LOOP
         -- старые/новые значения
         l_vt := CASE WHEN i = 1 THEN 'old' ELSE 'new' END;
         -- MFO --> BANK_ID
         l_value := l_source.get_value (l_vt, 'MFO', 'N');

         IF l_value IS NOT NULL
         THEN
            l_target.add_column (value_type     => l_vt,
                                 column_name    => 'BANK_ID',
                                 COLUMN_VALUE   => l_value);
         END IF;

         -- NB --> NAME
         l_value := l_source.get_value (l_vt, 'NB', 'N');

         IF l_value IS NOT NULL
         THEN
            l_target.add_column (value_type     => l_vt,
                                 column_name    => 'NAME',
                                 COLUMN_VALUE   => l_value);
         END IF;

         -- BLK --> CLOSING_DATE
         IF l_vt = 'new' AND l_command IN ('INSERT', 'UPDATE')
         THEN
            l_value := l_source.get_value (l_vt, 'BLK', 'N');

            IF l_value IS NOT NULL
            THEN
               l_blk := l_value.AccessNumber ();
               l_closing_date :=
                  CASE WHEN l_blk = 4 THEN TRUNC (SYSDATE) ELSE NULL END;
               l_target.add_column (
                  value_type     => l_vt,
                  column_name    => 'CLOSING_DATE',
                  COLUMN_VALUE   => sys.anydata.ConvertDate (l_closing_date));
            END IF;
         END IF;
      END LOOP;

      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END banks;

   --
   --  Преобразование BARS.SW_BANKS --> BARSAQ.SWIFT_BANKS
   --
   FUNCTION swift_banks (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.swift_banks';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_command          VARCHAR2 (9);
      l_value            SYS.ANYDATA;
      l_vt               VARCHAR2 (3);
      l_bicid            BARSAQ.swift_banks.bic_id%TYPE;
      l_str              VARCHAR2 (4000);
   BEGIN
      logger.trace ('%s : invoked', l_label);

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_command := l_source.get_command_type ();
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => l_command,
            object_owner           => 'BARSAQ',
            object_name            => 'SWIFT_BANKS',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());

      -- формируем поля целевой таблицы
      FOR i IN 1 .. 2
      LOOP
         -- старые/новые значения
         l_vt := CASE WHEN i = 1 THEN 'old' ELSE 'new' END;
         -- BIC --> BIC_ID
         l_value := l_source.get_value (l_vt, 'BIC', 'N');

         IF l_value IS NOT NULL
         THEN
            l_bicid := l_value.AccessChar ();
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'BIC_ID',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_bicid));
         END IF;

         -- NAME --> NAME
         l_value := l_source.get_value (l_vt, 'NAME', 'N');

         IF l_value IS NOT NULL
         THEN
            l_str := RTRIM (l_value.AccessVarchar2 ());
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'NAME',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_str));
         END IF;

         -- OFFICE --> OFFICE
         l_value := l_source.get_value (l_vt, 'OFFICE', 'N');

         IF l_value IS NOT NULL
         THEN
            l_str := RTRIM (l_value.AccessVarchar2 ());
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'OFFICE',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_str));
         END IF;

         -- CITY --> CITY
         l_value := l_source.get_value (l_vt, 'CITY', 'N');

         IF l_value IS NOT NULL
         THEN
            l_str := RTRIM (l_value.AccessVarchar2 ());
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'CITY',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_str));
         END IF;

         -- COUNTRY --> COUNTRY
         l_value := l_source.get_value (l_vt, 'COUNTRY', 'N');

         IF l_value IS NOT NULL
         THEN
            l_str := RTRIM (l_value.AccessVarchar2 ());
            l_target.add_column (
               value_type     => l_vt,
               column_name    => 'COUNTRY',
               COLUMN_VALUE   => sys.anydata.ConvertVarchar2 (l_str));
         END IF;
      END LOOP;

      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END swift_banks;

   --
   --  Преобразование BARS.SOS_TRACK --> BARSAQ.DOC_EXPORT
   --
   FUNCTION doc_export (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.doc_export';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_value            SYS.ANYDATA;
      l_ds               BARSAQ.doc_export%ROWTYPE;
      l_ref              INTEGER;
      l_sos              INTEGER;
   BEGIN
      logger.trace ('%s : invoked', l_label);

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => 'UPDATE',
            object_owner           => 'BARSAQ',
            object_name            => 'DOC_EXPORT',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());
      -- нас интересуют ref и sos
      l_ref := l_source.get_value ('new', 'REF').AccessNumber ();
      l_sos := l_source.get_value ('new', 'NEW_SOS').AccessNumber ();
      --
      l_ds.bank_ref := TO_CHAR (l_ref);

      -- doc_id читаем по референсу
      SELECT TO_NUMBER (ext_ref)
        INTO l_ds.doc_id
        FROM doc_import
       WHERE REF = l_ref;

      -- мапим статус
      l_ds.status_id :=
         CASE WHEN l_sos < 0 THEN -20 WHEN l_sos >= 5 THEN 50 ELSE 45 END;
      -- время изменения статуса определяем по SCN из LCR
      l_ds.status_change_time :=
         l_source.get_value ('new', 'CHANGE_TIME').AccessDate ();

      IF l_ds.status_id = 50
      THEN
         -- ставим дату проведения банком
         l_ds.bank_accept_date := l_ds.status_change_time;
      ELSIF l_ds.status_id < 0
      THEN
         -- ставим дату отказа банком
         l_ds.bank_back_date := l_ds.status_change_time;

         -- ставим причину отказа банком
         BEGIN
            SELECT TRIM (VALUE)
              INTO l_ds.bank_back_reason
              FROM bars.operw
             WHERE REF = l_ref AND tag = 'BACKR';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_ds.bank_back_reason :=
                  'Причину сторнування не вказано';
         END;
      END IF;

      -- добавляем колонки в LCR
      l_target.add_column ('old',
                           'DOC_ID',
                           sys.anydata.ConvertNumber (l_ds.doc_id));
      l_target.add_column ('new',
                           'STATUS_ID',
                           sys.anydata.ConvertNumber (l_ds.status_id));
      l_target.add_column ('new',
                           'STATUS_CHANGE_TIME',
                           sys.anydata.ConvertDate (l_ds.status_change_time));
      l_target.add_column ('new',
                           'BANK_ACCEPT_DATE',
                           sys.anydata.ConvertDate (l_ds.bank_accept_date));
      l_target.add_column ('new',
                           'BANK_REF',
                           sys.anydata.ConvertVarchar2 (l_ds.bank_ref));
      l_target.add_column ('new',
                           'BANK_BACK_DATE',
                           sys.anydata.ConvertDate (l_ds.bank_back_date));
      l_target.add_column (
         'new',
         'BANK_BACK_REASON',
         sys.anydata.ConvertVarchar2 (l_ds.bank_back_reason));
      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END doc_export;

   ---------------------------------------------------
   --
   -- handler_sync - обработчик для sync_-процессов
   --
   --  @p_obj - исходный LCR
   --
   PROCEDURE handler_sync (p_obj IN SYS.ANYDATA)
   IS
      l_source   SYS.lcr$_row_record;
      l_rc       NUMBER;
      l_xml      XMLTYPE;
   BEGIN
      IF trace_enabled ()
      THEN
         logger.trace ('entry point of handler_sync()');
      END IF;

      IF p_obj.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
            g_errmsg :=
               SUBSTR (
                     'handler_sync error:20003: '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace (),
                  1,
                  4000);
            bars.bars_audit.error (g_errmsg);
         raise_application_error (
            -20003,
               'Неожидаемый тип объекта: '
            || p_obj.gettypename (),
            TRUE);
      END IF;

      -- Преобразуем ANYDATA в LCR
      l_rc := p_obj.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
            g_errmsg :=
               SUBSTR (
                     'handler_sync error:20004: '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace (),
                  1,
                  4000);
            bars.bars_audit.error (g_errmsg);
         raise_application_error (
            -20004,
               'Ошибка преобразования ANYDATA в LCR$_ROW_RECORD: '
            || l_rc,
            TRUE);
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               'handler_sync() LCR:'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
      END IF;

      -- выполняем локально
      -- CANCEL 29.03.2017 16:10
      if utl_raw.cast_to_varchar2(l_source.get_tag) = 'CANCEL' then
         logger.trace ('handler_sync() LCR: CANCEL');
      else
         logger.trace ('handler_sync() LCR: EXECUTE');
        l_source.execute (TRUE);
      end if;


      IF trace_enabled ()
      THEN
         logger.trace ('final point of handler_sync()');
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         DECLARE
            l_errmsg   VARCHAR2 (4000);
         BEGIN
            l_errmsg :=
               SUBSTR (
                     'handler_sync error:20005: '
                  || DBMS_UTILITY.format_error_stack ()
                  || CHR (10)
                  || DBMS_UTILITY.format_error_backtrace (),
                  1,
                  4000);
            bars.bars_audit.error (l_errmsg);
            raise_application_error (-20005, l_errmsg);
         END;
   END handler_sync;

   ---------------------------------------------------
   --
   -- acc_transactions_handler - обработчик для acc_transactions
   --
   --  @p_obj - исходный LCR
   --
   PROCEDURE acc_transactions_handler (p_obj IN SYS.ANYDATA)
   IS
      l_obj   SYS.ANYDATA;
   BEGIN
      l_obj := transform_opldok (p_obj);
      --
      handler_sync (l_obj);
      --
      update_transaction_clob (l_obj);
   --
   END acc_transactions_handler;

   PROCEDURE acc_transactions_test_handler (p_obj IN SYS.ANYDATA)
   IS
      l_obj   SYS.ANYDATA;
   BEGIN
      l_obj := transform_opldok_test (p_obj);
      --
      handler_sync (l_obj);
      --
      update_transaction_clob_test (l_obj);
   --
   END acc_transactions_test_handler;
   --
   --  Преобразование BARS.BIRJA --> BARSAQ.DOC_CUREX_PARAMS
   --
   FUNCTION doc_curex_params (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_source    SYS.lcr$_row_record;
      l_target    SYS.lcr$_row_record;
      l_rc        NUMBER;
      l_value     SYS.ANYDATA;
      l_bankid    VARCHAR2 (11);
      l_command   VARCHAR2 (9);
   BEGIN
      logger.trace ('ibank_acounts.doc_curex_params(...) invoked');

      IF p_anydata.gettypename = 'SYS.LCR$_ROW_RECORD'
      THEN
         -- преобразуем ANYDATA в LCR
         l_rc := p_anydata.getobject (l_source);

         IF l_rc <> DBMS_TYPES.success
         THEN
            RETURN p_anydata;
         END IF;

         IF trace_enabled ()
         THEN
            logger.trace (
                  'doc_curex_params LCR:'
               || CHR (10)
               || RTRIM (
                     DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
         END IF;

         -- конструируем LCR для применения к таблице
         l_command := l_source.get_command_type ();
         l_target :=
            sys.lcr$_row_record.construct (
               source_database_name   => l_source.get_source_database_name (),
               command_type           => l_command,
               object_owner           => 'BARSAQ',
               object_name            => 'DOC_CUREX_PARAMS',
               tag                    => l_source.get_tag (),
               transaction_id         => l_source.get_transaction_id (),
               scn                    => l_source.get_scn ());

         -- получаем код банка
         SELECT val
           INTO l_bankid
           FROM bars.params
          WHERE par = 'GLB-MFO';

         -- добавляем отдельные колонки
         --
         IF l_command IN ('DELETE', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- PAR_ID
            l_value := l_source.get_value ('old', 'PAR');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'old',
                                    column_name    => 'PAR_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;
         END IF;

         IF l_command IN ('INSERT', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- PAR_ID
            l_value := l_source.get_value ('new', 'PAR');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'PAR_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- PAR_VALUE
            l_value := l_source.get_value ('new', 'VAL');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'PAR_VALUE',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- PAR_COMMENT
            l_value := l_source.get_value ('new', 'COMM');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'PAR_COMMENT',
                                    COLUMN_VALUE   => l_value);
            END IF;
         END IF;

         RETURN anydata.convertobject (l_target);
      END IF;

      RETURN p_anydata;
   END doc_curex_params;

   --
   --  Преобразование BARS.CUST_ZAY --> BARSAQ.DOC_CUREX_CUSTCOMMISSIONS
   --
   FUNCTION doc_curex_custcommissions (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_source    SYS.lcr$_row_record;
      l_target    SYS.lcr$_row_record;
      l_rc        NUMBER;
      l_value     SYS.ANYDATA;
      l_bankid    VARCHAR2 (11);
      l_command   VARCHAR2 (9);
   BEGIN
      logger.trace ('ibank_acounts.doc_curex_custcommissions(...) invoked');

      IF p_anydata.gettypename = 'SYS.LCR$_ROW_RECORD'
      THEN
         -- преобразуем ANYDATA в LCR
         l_rc := p_anydata.getobject (l_source);

         IF l_rc <> DBMS_TYPES.success
         THEN
            RETURN p_anydata;
         END IF;

         IF trace_enabled ()
         THEN
            logger.trace (
                  'ibank_acounts.doc_curex_custcommissions LCR:'
               || CHR (10)
               || RTRIM (
                     DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
         END IF;

         -- конструируем LCR для применения к таблице
         l_command := l_source.get_command_type ();
         l_target :=
            sys.lcr$_row_record.construct (
               source_database_name   => l_source.get_source_database_name (),
               command_type           => l_command,
               object_owner           => 'BARSAQ',
               object_name            => 'DOC_CUREX_CUSTCOMMISSIONS',
               tag                    => l_source.get_tag (),
               transaction_id         => l_source.get_transaction_id (),
               scn                    => l_source.get_scn ());

         -- получаем код банка
         SELECT val
           INTO l_bankid
           FROM bars.params
          WHERE par = 'GLB-MFO';

         -- добавляем отдельные колонки
         --
         IF l_command IN ('DELETE', 'UPDATE')
         THEN
            -- CUST_ID
            l_value := l_source.get_value ('old', 'RNK');

            /*
            begin
             select sys.anydata.convertNumber(cust_id)
               into l_value
               from barsaq.v_custrnk
              where rnk = l_value.AccessNumber();
            exception when no_data_found then
             logger.error('ibank_acounts.doc_curex_custcommissions: не знайдено імпортованого клієнта з рнк=' || to_char(l_value.AccessNumber()));
             l_value := null;
            end;
            */

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'old',
                                    column_name    => 'RNK',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- BANK_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
         END IF;

         IF l_command IN ('INSERT', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- CUST_ID
            l_value := l_source.get_value ('new', 'RNK');

            /*
            begin
             select sys.anydata.convertNumber(cust_id)
               into l_value
               from barsaq.v_custrnk
              where rnk = l_value.AccessNumber();
            exception when no_data_found then
             logger.error('ibank_acounts.doc_curex_custcommissions: не знайдено імпортованого клієнта з рнк=' || to_char(l_value.AccessNumber()));
             l_value := null;
            end;
            */

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'RNK',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- BUY_COMMISSION
            l_value := l_source.get_value ('new', 'KOM');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'BUY_COMMISSION',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- SELL_COMMISSION
            l_value := l_source.get_value ('new', 'KOM2');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'SELL_COMMISSION',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- SELL_COMMISSION
            l_value := l_source.get_value ('new', 'KOM3');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'CONV_COMMISSION',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- PENS_ACCOUNT
            l_value := l_source.get_value ('new', 'NLS_PF');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'NLS_PF',
                                    COLUMN_VALUE   => l_value);
            END IF;
         END IF;

         RETURN anydata.convertobject (l_target);
      END IF;

      RETURN p_anydata;
   END doc_curex_custcommissions;

   --
   --  Преобразование BARS.ZAY_COMISS --> BARSAQ.DOC_CUREX_EXCLUSIVE
   --
   FUNCTION doc_curex_exclusive (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_source    SYS.lcr$_row_record;
      l_target    SYS.lcr$_row_record;
      l_rc        NUMBER;
      l_value     SYS.ANYDATA;
      l_bankid    VARCHAR2 (11);
      l_command   VARCHAR2 (9);
   BEGIN
      logger.trace ('ibank_acounts.doc_curex_exclusive(...) invoked');

      IF p_anydata.gettypename = 'SYS.LCR$_ROW_RECORD'
      THEN
         -- преобразуем ANYDATA в LCR
         l_rc := p_anydata.getobject (l_source);

         IF l_rc <> DBMS_TYPES.success
         THEN
            RETURN p_anydata;
         END IF;

         IF trace_enabled ()
         THEN
            logger.trace (
                  'ibank_acounts.doc_curex_exclusive LCR:'
               || CHR (10)
               || RTRIM (
                     DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
         END IF;

         -- конструируем LCR для применения к таблице
         l_command := l_source.get_command_type ();
         l_target :=
            sys.lcr$_row_record.construct (
               source_database_name   => l_source.get_source_database_name (),
               command_type           => l_command,
               object_owner           => 'BARSAQ',
               object_name            => 'DOC_CUREX_EXCLUSIVE',
               tag                    => l_source.get_tag (),
               transaction_id         => l_source.get_transaction_id (),
               scn                    => l_source.get_scn ());

         -- получаем код банка
         SELECT val
           INTO l_bankid
           FROM bars.params
          WHERE par = 'GLB-MFO';

         -- добавляем отдельные колонки
         --
         IF l_command IN ('DELETE', 'UPDATE')
         THEN
            -- RATE_ID
            l_value := l_source.get_value ('old', 'ID');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'old',
                                    column_name    => 'RATE_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- BANK_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
         END IF;

         IF l_command IN ('INSERT', 'UPDATE')
         THEN
            -- BANK_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
            -- CUST_ID
            l_value := l_source.get_value ('new', 'RNK');

            /*
            if l_value is not null then
             begin
              select sys.anydata.convertNumber(cust_id)
                into l_value
                from barsaq.v_custrnk
               where rnk = l_value.AccessNumber();
             exception when no_data_found then
              logger.error('ibank_acounts.doc_curex_exclusive: не знайдено імпортованого клієнта з рнк=' || to_char(l_value.AccessNumber()));
              l_value := null;
             end;
            end if;
            */

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'RNK',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- RATE_ID
            l_value := l_source.get_value ('new', 'ID');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'RATE_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- BUY_SELL_FLAG
            l_value := l_source.get_value ('new', 'DK');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'BUY_SELL_FLAG',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- CUR_GROUP
            l_value := l_source.get_value ('new', 'KV_GRP');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'CUR_GROUP',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- CUR_ID
            l_value := l_source.get_value ('new', 'KV');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'CUR_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- LIMIT
            l_value := l_source.get_value ('new', 'LIMIT');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'LIMIT',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- COMMISSION_RATE
            l_value := l_source.get_value ('new', 'RATE');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'COMMISSION_RATE',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- COMMISSION_SUM
            l_value := l_source.get_value ('new', 'FIX_SUM');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'COMMISSION_SUM',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- DATE_ON
            l_value := l_source.get_value ('new', 'DATE_ON');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'DATE_ON',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- DATE_OFF
            l_value := l_source.get_value ('new', 'DATE_OFF');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'DATE_OFF',
                                    COLUMN_VALUE   => l_value);
            END IF;
         END IF;

         RETURN anydata.convertobject (l_target);
      END IF;

      RETURN p_anydata;
   END doc_curex_exclusive;

   --
   --  Преобразование BARS.CUSTOMER_ADDRESS --> BARSAQ.CUST_ADDRESSES
   --
   FUNCTION cust_addresses (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_source    SYS.lcr$_row_record;
      l_target    SYS.lcr$_row_record;
      l_rc        NUMBER;
      l_value     SYS.ANYDATA;
      l_bankid    VARCHAR2 (11);
      l_command   VARCHAR2 (9);
   BEGIN
      logger.trace ('ibank_acounts.cust_addresses(...) invoked');

      IF p_anydata.gettypename = 'SYS.LCR$_ROW_RECORD'
      THEN
         -- преобразуем ANYDATA в LCR
         l_rc := p_anydata.getobject (l_source);

         IF l_rc <> DBMS_TYPES.success
         THEN
            RETURN p_anydata;
         END IF;

         IF trace_enabled ()
         THEN
            logger.trace (
                  'ibank_acounts.cust_addresses LCR:'
               || CHR (10)
               || RTRIM (
                     DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)));
         END IF;

         -- конструируем LCR для применения к таблице
         l_command := l_source.get_command_type ();
         l_target :=
            sys.lcr$_row_record.construct (
               source_database_name   => l_source.get_source_database_name (),
               command_type           => l_command,
               object_owner           => 'BARSAQ',
               object_name            => 'CUST_ADDRESSES',
               tag                    => l_source.get_tag (),
               transaction_id         => l_source.get_transaction_id (),
               scn                    => l_source.get_scn ());

         -- получаем код банка (через РНК)
         -- SELECT val INTO l_bankid FROM bars.params WHERE par = 'GLB-MFO';

         -- добавляем отдельные колонки
         --
         IF l_command IN ('DELETE', 'UPDATE')
         THEN
            -- RNK
            l_value := l_source.get_value ('old', 'RNK');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'old',
                                    column_name    => 'RNK',
                                    COLUMN_VALUE   => l_value);
            END IF;

            SELECT kf INTO l_bankid FROM ibank_rnk WHERE rnk = l_value.AccessNumber();

            -- TYPE_ID
            l_value := l_source.get_value ('old', 'TYPE_ID');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'old',
                                    column_name    => 'TYPE_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- BANK_ID
            l_target.add_column (
               value_type     => 'old',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));
         END IF;

         IF l_command IN ('INSERT', 'UPDATE')
         THEN
            -- RNK
            l_value := l_source.get_value ('new', 'RNK');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'RNK',
                                    COLUMN_VALUE   => l_value);
            END IF;

            SELECT kf INTO l_bankid FROM ibank_rnk WHERE rnk = l_value.AccessNumber();

            -- TYPE_ID
            l_value := l_source.get_value ('new', 'TYPE_ID');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'TYPE_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- BANK_ID
            l_target.add_column (
               value_type     => 'new',
               column_name    => 'BANK_ID',
               COLUMN_VALUE   => anydata.convertVarchar2 (l_bankid));

            -- COUNTRY
            l_value := l_source.get_value ('new', 'COUNTRY');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'COUNTRY_ID',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- ZIP
            l_value := l_source.get_value ('new', 'ZIP');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'ZIP',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- DOMAIN
            l_value := l_source.get_value ('new', 'DOMAIN');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'REGION',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- REGION
            l_value := l_source.get_value ('new', 'REGION');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'DISTRICT',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- LOCALITY
            l_value := l_source.get_value ('new', 'LOCALITY');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'CITY',
                                    COLUMN_VALUE   => l_value);
            END IF;

            -- ADDRESS
            l_value := l_source.get_value ('new', 'ADDRESS');

            IF l_value IS NOT NULL
            THEN
               l_target.add_column (value_type     => 'new',
                                    column_name    => 'ADDRESS',
                                    COLUMN_VALUE   => l_value);
            END IF;
         END IF;

         RETURN anydata.convertobject (l_target);
      END IF;

      RETURN p_anydata;
   END cust_addresses;


   ------------------------------------
   -- IS_CLIENT_ZAYAVKA
   --
   -- проверяет была ли заявка импортирована из клиент-банка
   --
   FUNCTION is_client_zayavka (p_id IN INTEGER)
      RETURN INTEGER
   IS
      l_result   INTEGER;
   BEGIN
      SELECT 1
        INTO l_result
        FROM zayavka_id_map
       WHERE idz = p_id;

      RETURN 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 0;
   END is_client_zayavka;

   --
   --  Преобразование BARS.ZAY_QUEUE(BARSAQ.ZAYAVKA_ID_MAP) --> BARSAQ.DOC_EXPORT
   --
   FUNCTION transform_zay (p_anydata IN SYS.ANYDATA)
      RETURN SYS.ANYDATA
   IS
      l_label   CONSTANT VARCHAR2 (128) := 'ibank_accounts.transform_zay';
      l_source           SYS.lcr$_row_record;
      l_target           SYS.lcr$_row_record;
      l_rc               NUMBER;
      l_value            SYS.ANYDATA;
      l_ds               BARSAQ.doc_export%ROWTYPE;
      l_idz              bars.zayavka.id%TYPE;
      l_sos              bars.zayavka.sos%TYPE;
      l_idback           bars.zay_back.id%TYPE;
      l_reason           bars.zay_back.reason%TYPE;
   BEGIN
      logger.trace ('%s : invoked', l_label);

      IF p_anydata.gettypename () <> 'SYS.LCR$_ROW_RECORD'
      THEN
         RETURN p_anydata;
      END IF;

      -- преобразуем ANYDATA в LCR
      l_rc := p_anydata.getobject (l_source);

      IF l_rc <> DBMS_TYPES.success
      THEN
         RETURN p_anydata;
      END IF;

      IF trace_enabled ()
      THEN
         logger.trace (
               '%s :'
            || CHR (10)
            || RTRIM (DBMS_LOB.SUBSTR (f_row_lcr_to_char (l_source), 3900)),
            l_label);
      END IF;

      -- конструируем LCR для применения к таблице
      l_target :=
         sys.lcr$_row_record.construct (
            source_database_name   => l_source.get_source_database_name (),
            command_type           => 'UPDATE',
            object_owner           => 'BARSAQ',
            object_name            => 'DOC_EXPORT',
            tag                    => l_source.get_tag (),
            transaction_id         => l_source.get_transaction_id (),
            scn                    => l_source.get_scn ());
      --
      l_idz := l_source.get_value ('new', 'ID').AccessNumber ();
      -- референсом для заявки будет ее ID
      l_ds.bank_ref := TO_CHAR (l_idz);

      -- doc_id читаем по id заявки
      SELECT doc_id
        INTO l_ds.doc_id
        FROM zayavka_id_map
       WHERE idz = l_idz;

      -- получаем статус заявки и код причины отказа
      SELECT sos, idback
        INTO l_sos, l_idback
        FROM bars.zayavka
       WHERE id = l_idz;

      -- получаем описание причины отказа
      IF l_sos = -1 AND l_idback IS NOT NULL
      THEN
         SELECT reason
           INTO l_reason
           FROM bars.zay_back
          WHERE id = l_idback;
      END IF;

      -- мапим статус
      l_ds.status_id :=
         CASE WHEN l_sos = -1 THEN -20 WHEN l_sos = 2 THEN 50 ELSE 45 END;
      -- время изменения статуса определяем по SCN из LCR
      l_ds.status_change_time :=
         l_source.get_value ('new', 'CHANGE_TIME').AccessDate ();

      IF l_ds.status_id = 50
      THEN
         -- ставим дату проведения банком
         l_ds.bank_accept_date := l_ds.status_change_time;
      ELSIF l_ds.status_id < 0
      THEN
         -- ставим дату отказа банком
         l_ds.bank_back_date := l_ds.status_change_time;

         -- ставим причину отказа банком
         IF l_reason IS NOT NULL
         THEN
            l_ds.bank_back_reason := l_reason;
         ELSE
            l_ds.bank_back_reason :=
               'Причину відхилення не вказано';
         END IF;
      END IF;

      -- добавляем колонки в LCR
      l_target.add_column ('old',
                           'DOC_ID',
                           sys.anydata.ConvertNumber (l_ds.doc_id));
      l_target.add_column ('new',
                           'STATUS_ID',
                           sys.anydata.ConvertNumber (l_ds.status_id));
      l_target.add_column ('new',
                           'STATUS_CHANGE_TIME',
                           sys.anydata.ConvertDate (l_ds.status_change_time));
      l_target.add_column ('new',
                           'BANK_ACCEPT_DATE',
                           sys.anydata.ConvertDate (l_ds.bank_accept_date));
      l_target.add_column ('new',
                           'BANK_REF',
                           sys.anydata.ConvertVarchar2 (l_ds.bank_ref));
      l_target.add_column ('new',
                           'BANK_BACK_DATE',
                           sys.anydata.ConvertDate (l_ds.bank_back_date));
      l_target.add_column (
         'new',
         'BANK_BACK_REASON',
         sys.anydata.ConvertVarchar2 (l_ds.bank_back_reason));
      -- возвращаем объект
      RETURN anydata.ConvertObject (l_target);
   END transform_zay;

   ---------------------------------------------------
   --
   -- zay_handler - обработчик для заявок на покупку/продажу валюты
   --
   --  @p_obj - исходный LCR
   --
   PROCEDURE zay_handler (p_obj IN SYS.ANYDATA)
   IS
   BEGIN
      --
      handler_sync (transform_zay (p_obj));
   --
   END zay_handler;

   ---------------------------------------------------
   --
   -- doccurexparams_handler - обработчик параметров на покупку/продажу валюты
   --
   --  @p_obj - исходный LCR
   --
   PROCEDURE doccurexparams_handler (p_obj IN SYS.ANYDATA)
   IS
   BEGIN
      --
      handler_sync (p_obj);
   --
   END doccurexparams_handler;

   ---------------------------------------------------
   --
   -- doccurexcustcomm_handler - обработчик параметров на покупку/продажу валюты
   --
   --  @p_obj - исходный LCR
   --
   PROCEDURE doccurexcustcomm_handler (p_obj IN SYS.ANYDATA)
   IS
   BEGIN
      --
      handler_sync (p_obj);
   --
   END doccurexcustcomm_handler;

   ---------------------------------------------------
   --
   -- doccurexexclusive_handler - обработчик параметров на покупку/продажу валюты
   --
   --  @p_obj - исходный LCR
   --
   PROCEDURE doccurexexclusive_handler (p_obj IN SYS.ANYDATA)
   IS
   BEGIN
      --
      handler_sync (p_obj);
   --
   END doccurexexclusive_handler;

  procedure SetTransform_CutRUKey is
  begin
   for i in (select rule_name
               from dba_streams_rules r
               join user_tab_cols t
                 on r.object_name = t.TABLE_NAME
              where streams_name = 'TR_CAPTURE'
                and t.COLUMN_NAME = 'RNK') loop
     sys.dbms_streams_adm.set_rule_transform_function(i.rule_name, 'ibank_accounts.CutRUKey');
   end loop;
  end;

  FUNCTION CutRUKey (p_anydata IN SYS.ANYDATA)    RETURN SYS.ANYDATA
  IS
    lcr           SYS.lcr$_row_record;
    l_rc               NUMBER;
    l_value            ANYDATA;

  function fCutRUKey(p_rnk in anydata) return anydata is
   l_rnk string(100);
  begin
   l_rnk := p_rnk.AccessNumber;
  --     raise_application_error(-20000, 'l_rnk='||l_rnk);
   l_rnk := substr(l_rnk, 1, length(l_rnk) - 2);
   return anydata.ConvertNumber(to_number(l_rnk));
  exception
   when others then
     return p_rnk;
  end fCutRUKey;

  BEGIN
    l_rc := p_anydata.getobject (lcr);

   l_value := lcr.get_value ('OLD', 'RNK');
   if l_value is not null then
     lcr.set_value('OLD', 'RNK', fCutRUKey(l_value));
   end if;

   l_value := lcr.get_value ('NEW', 'RNK');
   if l_value is not null then
     lcr.set_value('NEW', 'RNK', fCutRUKey(l_value));
   end if;

    RETURN anydata.ConvertObject (lcr);
  END CutRUKey;

BEGIN
   init;
END ibank_accounts;
/
 show err;
 
PROMPT *** Create  grants  IBANK_ACCOUNTS ***
grant EXECUTE                                                                on IBANK_ACCOUNTS  to BARS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/ibank_accounts.sql =========*** En
 PROMPT ===================================================================================== 
 