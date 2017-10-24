
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/ibank_accounts.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.IBANK_ACCOUNTS is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 07.10.2008
  -- Purpose    : Пакет процедур для синхронизации по счетам для IBANK

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.18 19/01/2012';

  G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''
	||'KF - схема с полем ''kf''' || chr(10)
    ||'ZAY - заявки на покупку/продажу валюты' || chr(10)
  ;

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


end ibank_accounts;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.IBANK_ACCOUNTS is

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.46 17/08/2015';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''
	||'KF - схема с полем ''kf''' || chr(10)
	||'ZAY - заявки на покупку/продажу валюты' || chr(10)
  ;

  -- делитель для национальной валюты
  g_base_val      bars.tabval.kv%type := 980;
  g_base_denom    bars.tabval.denom%type := 100;

  type t_narrative_record is record(
    nazn    bars.oper.nazn%type,
    d_rec   bars.oper.d_rec%type,
    bis     bars.oper.bis%type
  );

  type t_narrative_array is table of t_narrative_record index by pls_integer;

  type t_operw_record is record(
    row_num      integer,
    row_value    varchar2(32767)
  );

  type t_operw_array is table of t_operw_record index by pls_integer;
  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION||'awk: '||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
  end body_version;

  ----
  -- init - инициализация пакета
  --
  procedure init is
  begin
	if sys_context('userenv','client_identifier') is null or sys_context('bars_global', 'user_id') is null
    then
        declare
            l_userid    integer;
        begin
            -- регистрируем сессию от имени BARSAQ, т.к. STREAMS запускаются от имени SYS
            select id
              into l_userid
              from bars.staff$base
             where logname='BARSAQ';
            --
            bars.bars_login.login_user(SYS_GUID(), l_userid, null, 'STREAMS');
        end;
        logger.trace('ibank_accounts.init() new session');
    else
        logger.trace('ibank_accounts.init() existing session');
    end if;
    logger.trace('ibank_accounts.init(), proxy_user=%s, bars_global.user_id=%s',
                  nvl(sys_context('userenv', 'proxy_user'),'null'),
                  nvl(sys_context('bars_global', 'user_id'),'null')
                );
    --
  end init;

  ----
  -- возвращает флаг включенной трассировки
  function trace_enabled return boolean is
  begin
    if logger.get_log_level>=logger.LOG_LEVEL_TRACE then
        return true;
    else
        return false;
    end if;
  end trace_enabled;

    ----
    -- trim_spaces - заменяет несколько подряд идущих пробелов на один
    --
    function trim_spaces(p_source varchar2) return varchar2 is
        l_target  varchar2(32767) := '';
        l_trims   varchar2(32767);
        i         integer := 1;
        l_length  integer := length(p_source);
        l_char    char;
    begin
        while i<=l_length loop
            l_char := substr(p_source,i,1);
            l_target := l_target || l_char;
            i := i + 1;
            while l_char = ' ' and substr(p_source,i,1) = ' ' loop
                i := i + 1;
            end loop;
        end loop;
        loop
            l_trims  := l_target;
            l_target := replace(l_target, ' '||chr(13)||chr(10), chr(13)||chr(10));
            exit when l_trims=l_target;
        end loop;
        return l_target;
    end trim_spaces;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из ARC_RRP
  --  для внешнего документа
  --
  function extract_bis_external(p_ref in number, p_scn in number default null) return varchar2 is
    l_narrative_array   t_narrative_array;
    l_result            varchar2(32767);
    l_scn				number;
  begin
    l_scn := nvl(p_scn, dbms_flashback.get_system_change_number());
    select nazn, d_rec, bis bulk collect into l_narrative_array
    from bars.arc_rrp where ref=p_ref order by bis;
    l_result := l_narrative_array(1).d_rec;
    if l_narrative_array(1).bis = 1 then
        for i in 2..l_narrative_array.count
        loop
            l_result := l_result || chr(10) || l_narrative_array(i).nazn || l_narrative_array(i).d_rec;
        end loop;
    end if;
    return l_result;
  end extract_bis_external;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из ARC_RRP
  --  для внешнего документа
  --
  function extract_bis_external_clob(p_ref in number, p_scn in number default null) return clob is
    l_clob              clob;
  begin
    l_clob := extract_bis_external(p_ref, p_scn);
    return l_clob;
  end extract_bis_external_clob;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из OPERW
  --  для внутреннего документа
  --
  function extract_bis_internal(p_ref in number, p_scn in number default null) return varchar2 is
    l_operw_array       t_operw_array;
    l_result            varchar2(32767);
    l_temp              varchar2(32767);
    l_scn				number;
  begin
    l_scn := nvl(p_scn, dbms_flashback.get_system_change_number());
    -- читаем доп.реквизиты из oper
    select d_rec into l_result from bars.oper as of scn l_scn where ref=p_ref;
    -- читаем реквизиты для дополнительных строк БИС
    select rownum row_num,
       '#'||f.vspo_char||decode(f.vspo_char,'F',trim(w.tag)||':',null)||
            replace(trim_spaces(value),chr(13)||chr(10),'#'||chr(10)||'#'||f.vspo_char||decode(f.vspo_char,'F',trim(w.tag)||':',null))
          ||'#' row_value
    bulk collect into l_operw_array
    from bars.operw w, bars.op_field f
    where w.ref=p_ref and w.tag=f.tag and f.vspo_char is not null and f.vspo_char in ('C','П','F')
    order by w.tag;
    if l_operw_array.count>0 then
        for i in 1..l_operw_array.count loop
            l_temp := l_temp || chr(10) || l_operw_array(i).row_value;
        end loop;
        if l_result is null or l_result not like '#B%' then
            l_result := '#B'||lpad(to_char(
                                             -- вычисляем кол-во строк, разделенных chr(10)
                                             -- когда все перейдут на 11g, заменить на
                                             -- nvl(regexp_count(l_temp,chr(10)),0)+1
                                             nvl(length(l_temp),0)-nvl(length(replace(l_temp,chr(10),null)),0)+1
					   ),2,'0')||nvl(l_result,'#');
        end if;
        l_result := l_result || l_temp;
    end if;
    return l_result;
  end extract_bis_internal;

  ----
  --  Извлекает БИС(Блок Информационных Строк) по референсу из OPERW
  --  для внутреннего документа
  --
  function extract_bis_internal_clob(p_ref in number, p_scn in number default null) return clob is
    l_clob clob;
  begin
    l_clob := extract_bis_internal(p_ref, p_scn);
    return l_clob;
  end extract_bis_internal_clob;

  ----
  -- lock_account - блокируем счет
  -- @param p_acc - асс счета
  --
  procedure lock_account(p_acc in integer) is
  	l_acc  bars.accounts.acc%type;
  begin
    -- блокируем счет(с ожиданием 10 сек), чтобы по нему не было никаких операций (т.е. изменений по saldoa и opldok)
  	select acc into l_acc from bars.accounts where acc=p_acc for update wait 10;
  end lock_account;

  --
  --  Преобразование BARS.SALDOA
  --
  function transform_saldoa(p_anydata in sys.anydata) return sys.anydata is
    l_label         constant varchar2(128) := 'ibank_accounts.transform_saldoa';
    l_source 		sys.lcr$_row_record;
    l_target 		sys.lcr$_row_record;
    l_rc  			number;
    l_command       varchar2(9);
    l_value         sys.anydata;
    l_vt            varchar2(3);
    l_denom         bars.tabval.denom%type;
    l_acc			bars.saldoa.acc%type;
    l_fdat			bars.saldoa.fdat%type;
    l_kv            bars.accounts.kv%type;
    l_row           acc_turnovers%rowtype;
  begin
    logger.trace('%s : invoked', l_label);
    if p_anydata.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        return p_anydata;
    end if;
    -- преобразуем ANYDATA в LCR
    l_rc := p_anydata.getobject(l_source);
    if l_rc<>dbms_types.success then
        return p_anydata;
    end if;
    if trace_enabled() then
        logger.trace('%s :'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)), l_label);
    end if;
    -- конструируем LCR для применения к таблице
    l_command := l_source.get_command_type();
    l_target := sys.lcr$_row_record.construct(
                 source_database_name => l_source.get_source_database_name(),
                 command_type         => l_command,
                 object_owner         => 'BARSAQ',
                 object_name          => 'ACC_TURNOVERS',
                 tag                  => l_source.get_tag(),
                 transaction_id       => l_source.get_transaction_id(),
                 scn                  => l_source.get_scn()
               );
    -- формируем поля целевой таблицы
    for i in 1..2 loop
        -- старые/новые значения
        l_vt := case when i=1 then 'old' else 'new' end;
        -- обнуляем для контроля полей первичного ключа
        l_acc := null;
        -- acc, fdat
        l_value := l_source.get_value(l_vt,'ACC');
        if l_value is not null then
            -- acc присутствует, значит есть остальные ключевые поля
            l_acc  := l_value.AccessNumber();
            l_fdat := l_source.get_value(l_vt,'FDAT').AccessDate();
            l_row.turns_date := l_fdat;
            -- на случай, если очистили наш контекст
            init;
            -- получаем значения для целевого ключа
            select kf, nls, kv into l_row.bank_id, l_row.acc_num, l_row.cur_id
            from v_kf_accounts where acc=l_acc;
            -- добавляем поля целевой таблицы
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'BANK_ID',
                    column_value   => sys.anydata.ConvertVarchar2(l_row.bank_id)
            );
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'ACC_NUM',
                    column_value   => sys.anydata.ConvertVarchar2(l_row.acc_num)
            );
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'CUR_ID',
                    column_value   => sys.anydata.ConvertNumber(l_row.cur_id)
            );
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'TURNS_DATE',
                    column_value   => sys.anydata.ConvertDate(l_fdat)
            );
        end if;
        -- pdat
        l_value := l_source.get_value(l_vt,'PDAT','N');
        if l_value is not null then
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'PREV_TURNS_DATE',
                    column_value   => l_value
            );
        end if;
        -- узнаем делитель валюты
        if l_acc is not null then
            select denom into l_denom from bars.tabval where kv=l_row.cur_id;
        else
            l_denom := g_base_denom;
        end if;
        -- ostf
        l_value := l_source.get_value(l_vt,'OSTF','N');
        if l_value is not null then
            l_row.balance := l_value.AccessNumber()/l_denom;
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'BALANCE',
                    column_value   => sys.anydata.ConvertNumber(l_row.balance)
            );
        end if;
        -- dos
        l_value := l_source.get_value(l_vt,'DOS','N');
        if l_value is not null then
            l_row.debit_turns := l_value.AccessNumber()/l_denom;
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'DEBIT_TURNS',
                    column_value   => sys.anydata.ConvertNumber(l_row.debit_turns)
            );
        end if;
        -- kos
        l_value := l_source.get_value(l_vt,'KOS','N');
        if l_value is not null then
            l_row.credit_turns := l_value.AccessNumber()/l_denom;
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'CREDIT_TURNS',
                    column_value   => sys.anydata.ConvertNumber(l_row.credit_turns)
            );
        end if;
        -- эквиваленты(всегда расчетные) пишем только для валютных счетов
        if l_acc is not null and l_row.cur_id is not null and l_row.cur_id<>g_base_val then
            begin
                -- обращения к пакету GL выполняем внутри МФО
                bars_sync.subst_mfo(l_row.bank_id);
                -- ostf(eq)
                l_value := l_source.get_value(l_vt,'OSTF','N');
                if l_value is not null then
                    l_row.balance_eq := bars.gl.p_icurval(l_row.cur_id, l_value.AccessNumber(), l_row.turns_date)/g_base_denom;
                    l_target.add_column(l_vt, 'BALANCE_EQ', sys.anydata.ConvertNumber(l_row.balance_eq));
                end if;
                -- dos(eq)
                l_value := l_source.get_value(l_vt,'DOS','N');
                if l_value is not null then
                    l_row.debit_turns_eq := bars.gl.p_icurval(l_row.cur_id, l_value.AccessNumber(), l_row.turns_date)/g_base_denom;
                    l_target.add_column(l_vt, 'DEBIT_TURNS_EQ', sys.anydata.ConvertNumber(l_row.debit_turns_eq));
                end if;
                -- kos(eq)
                l_value := l_source.get_value(l_vt,'KOS','N');
                if l_value is not null then
                    l_row.credit_turns_eq := bars.gl.p_icurval(l_row.cur_id, l_value.AccessNumber(), l_row.turns_date)/g_base_denom;
                    l_target.add_column(l_vt, 'CREDIT_TURNS_EQ', sys.anydata.ConvertNumber(l_row.credit_turns_eq));
                end if;
                -- возвращаемся в свой контекст
                bars_sync.set_context();
            exception when others then
                -- возвращаемся в свой контекст
                bars_sync.set_context();
                raise;
            end;
        end if;
    end loop;
    -- возвращаем объект
    return anydata.ConvertObject(l_target);
  end transform_saldoa;

  --
  --  Преобразование BARS.OPLDOK
  --
  function transform_opldok(p_anydata in sys.anydata) return sys.anydata is
    l_label         constant varchar2(128) := 'ibank_accounts.transform_opldok';
    l_source        sys.lcr$_row_record;
    l_target        sys.lcr$_row_record;
    l_rc            number;
    l_command       varchar2(9);
    l_value         sys.anydata;
    l_vt            varchar2(3);
    l_denom         bars.tabval.denom%type;
    l_opla          bars.opldok%rowtype;
    l_oplb          bars.opldok%rowtype;
    l_oper          bars.oper%rowtype;
    l_trans         acc_transactions%rowtype;
    l_kv            bars.accounts.kv%type;
    l_opldok_exists boolean;
    l_rnk           integer;
    l_ref92         bars.operw.value%type;
  begin
    logger.trace('%s : invoked', l_label);
    -- на случай, если очистили наш контекст
    init;

    if p_anydata.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        return p_anydata;
    end if;
    -- преобразуем ANYDATA в LCR
    l_rc := p_anydata.getobject(l_source);
    if l_rc<>dbms_types.success then
        return p_anydata;
    end if;
    if trace_enabled() then
        logger.trace('%s :'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)), l_label);
    end if;
    -- конструируем LCR для применения к таблице
    l_command := case when l_source.get_command_type()='DELETE' then 'DELETE' else 'INSERT' end;
    l_target := sys.lcr$_row_record.construct(
                 source_database_name => l_source.get_source_database_name(),
                 command_type         => l_command,
                 object_owner         => 'BARSAQ',
                 object_name          => 'ACC_TRANSACTIONS',
                 tag                  => l_source.get_tag(),
                 transaction_id       => l_source.get_transaction_id(),
                 scn                  => l_source.get_scn()
               );
    --
    l_vt := case when l_command='DELETE' then 'old' else 'new' end;
    -- формируем поля целевой таблицы
    l_opla.stmt := l_source.get_value(l_vt,'STMT').AccessNumber();
    l_opla.acc  := l_source.get_value(l_vt,'ACC').AccessNumber();
    -- определяемся с первичным ключем для acc_transactions
    select kf, nls, kv into l_trans.bank_id, l_trans.acc_num, l_trans.cur_id
    from v_kf_accounts where acc=l_opla.acc;
    l_trans.trans_id := to_char(l_opla.stmt);
    -- формируем ключевые поля
    -- BANK_ID
    l_target.add_column(l_vt, 'BANK_ID',  sys.anydata.ConvertVarchar2(l_trans.bank_id)  );
    -- ACC_NUM
    l_target.add_column(l_vt, 'ACC_NUM',  sys.anydata.ConvertVarchar2(l_trans.acc_num)  );
    -- CUR_ID
    l_target.add_column(l_vt, 'CUR_ID',   sys.anydata.ConvertNumber(l_trans.cur_id)     );
    -- TRANS_ID
    l_target.add_column(l_vt, 'TRANS_ID', sys.anydata.ConvertVarchar2(l_trans.trans_id) );
    --
    if l_command='INSERT' then
        -- для вставки наполняем неключевые значения
        -- дочитываем неключевые значения
        l_opla.ref  := l_source.get_value(l_vt,'REF').AccessNumber();
        l_opla.dk   := l_source.get_value(l_vt,'DK').AccessNumber();
        l_opla.tt   := l_source.get_value(l_vt,'TT').AccessChar();
        l_opla.fdat := l_source.get_value(l_vt,'FDAT').AccessDate();
        l_opla.s    := l_source.get_value(l_vt,'S').AccessNumber();
        l_opla.sq   := l_source.get_value(l_vt,'SQ').AccessNumber();
        l_opla.txt  := l_source.get_value(l_vt,'TXT').AccessVarchar2();
        l_opla.sos  := l_source.get_value(l_vt,'SOS').AccessNumber();

         if l_opla.tt in ('902','901') then
            begin
            select value into l_ref92 from bars.operw where ref=l_opla.ref and tag='REF92';
            select mfoa, id_a,  nlsa, nam_a
             into l_trans.ref92_bank_id, l_trans.ref92_cust_code, l_trans.ref92_acc_num, l_trans.ref92_acc_name
            from bars.oper where ref= l_ref92;
            select b.nb into l_trans.ref92_bank_name from bars.BANKS$BASE b where b.Mfo = l_trans.ref92_bank_id;
            exception
             when NO_DATA_FOUND then null;
            end;
         end if;

        -- узнаем валюту счета и ее делитель
        select kv into l_kv from bars.accounts where acc=l_opla.acc;
        select denom into l_denom from bars.tabval where kv=l_kv;
	-- получим запись из oper
        begin
            select * into l_oper from bars.oper where ref=l_opla.ref;
        exception when no_data_found then
            raise_application_error(-20000, 'No data found: select from oper where ref='||l_opla.ref);
        end;
        -- номер и дату документа всегда берем из OPER'a, больше неоткуда
        l_trans.doc_number      := l_oper.nd;
        l_trans.doc_date        := l_oper.pdat;

		begin
            select dat into l_trans.doc_date from bars.oper_visa where ref=l_opla.ref and groupid not in (77, 80, 81, 30) and status = 2;
        exception when no_data_found then
            null;
        end;
        --
        l_trans.doc_id          := to_char(l_opla.ref);
        l_trans.trans_date      := l_opla.fdat;
        l_trans.type_id         := case when l_opla.dk=0 then 'D' else 'C' end;
        --
        l_trans.trans_sum       := l_opla.s/l_denom;
        l_trans.trans_sum_eq    := l_opla.sq/g_base_denom;
        -- получаем вторую половину проводки
        begin
            select * into l_oplb from bars.opldok where ref=l_opla.ref and stmt=l_opla.stmt and dk=1-l_opla.dk;
            l_opldok_exists := true;
        exception when no_data_found then
            l_opldok_exists := false;
        end;
        -- определяемся откуда брать вторую половину проводки: из oper или opldok
        if (-- разновалютная операция
            l_oper.kv is not null and l_oper.kv2 is not null and l_oper.kv<>l_oper.kv2
            -- отличается тип операции в oper и opldok
        or  l_oper.tt<>l_opla.tt
            -- отличается сумма операции в oper и opldok
        or  l_oper.s<>l_opla.s)
        --  и записи в OPLDOK еще существуют
        and l_opldok_exists
        --  и операция <> R01 (все проводки R01 трактуем как родительские)
        and l_opla.tt<>'R01'
        then
            -- в этих случаях трактуем проводку как дочернюю и реквизиты ищем в accounts и customer
            -- по acc счета корреспондента получим его номер и наименование + rnk клиента-владельца счета
            select kf, nls, substr(nms,1,38), rnk into l_trans.corr_bank_id, l_trans.corr_acc_num, l_trans.corr_name, l_rnk
            from v_kf_accounts where acc=l_oplb.acc;
            -- по rnk владельца получим его идент. код
            select okpo into l_trans.corr_ident_code from bars.customer where rnk=l_rnk;
            -- банк корреспондента - наш
            select nb into l_trans.corr_bank_name from bars.banks where mfo=l_trans.corr_bank_id;
            -- назначение платежа клеим с двух частей
            l_trans.narrative := trim(l_oplb.txt)||' '||trim(l_oper.nazn);
            -- БИС строк для дочерних проводок не пишем
            l_trans.narrative_extra := null;
        else
            -- иначе, трактуем проводку как основную и реквизиты берем из oper
            if l_opla.dk=0 and l_oper.dk=1 or l_opla.dk=1 and l_oper.dk=0 then
                -- в даном случае берем строну B из oper
                select nb into l_trans.corr_bank_name from bars.banks where mfo=l_oper.mfob;
                -- заполняем поля строки
                l_trans.corr_bank_id    := l_oper.mfob;
                l_trans.corr_ident_code := l_oper.id_b;
                l_trans.corr_acc_num    := l_oper.nlsb;
                l_trans.corr_name       := l_oper.nam_b;
				l_trans.name       		:= l_oper.nam_a;
            else
                -- в даном случае берем строну A из oper
                select nb into l_trans.corr_bank_name from bars.banks where mfo=l_oper.mfoa;
                -- заполняем поля строки
                l_trans.corr_bank_id    := l_oper.mfoa;
                l_trans.corr_ident_code := l_oper.id_a;
                l_trans.corr_acc_num    := l_oper.nlsa;
                l_trans.corr_name       := l_oper.nam_a;
				l_trans.name       		:= l_oper.nam_b;
            end if;
            -- заполняем назначение платежа
            l_trans.narrative       := l_oper.nazn;
            -- заполняем дополнительные строки БИС
            l_trans.narrative_extra := case when l_oper.mfoa<>l_oper.mfob or l_opla.tt='R01' then
                                            ibank_accounts.extract_bis_external(l_oper.ref)
                                       else
                                            ibank_accounts.extract_bis_internal(l_oper.ref)
                                       end;
        end if;
        -- ищем id документа интернет-банкинга
        begin
            select to_number(value) into l_trans.ibank_docid
            from bars.operw where ref=l_opla.ref and tag='EXREF';
        exception when no_data_found then
            l_trans.ibank_docid := null;
        end;
        -- формируем поля в target lcr
        -- TRANS_DATE
        l_target.add_column(l_vt, 'TRANS_DATE',        sys.anydata.ConvertDate(l_trans.trans_date)          );
        -- DOC_ID
        l_target.add_column(l_vt, 'DOC_ID',            sys.anydata.ConvertVarchar2(l_trans.doc_id)          );
        -- DOC_NUMBER
        l_target.add_column(l_vt, 'DOC_NUMBER',        sys.anydata.ConvertVarchar2(l_trans.doc_number)      );
        -- DOC_DATE
        l_target.add_column(l_vt, 'DOC_DATE',          sys.anydata.ConvertDate(l_trans.doc_date)            );
        -- TYPE_ID
        l_target.add_column(l_vt, 'TYPE_ID',           sys.anydata.ConvertVarchar2(l_trans.type_id)         );
        -- TRANS_SUM
        l_target.add_column(l_vt, 'TRANS_SUM',         sys.anydata.ConvertNumber(l_trans.trans_sum)         );
        -- TRANS_SUM_EQ
        l_target.add_column(l_vt, 'TRANS_SUM_EQ',      sys.anydata.ConvertNumber(l_trans.trans_sum_eq)      );
        -- CORR_BANK_ID
        l_target.add_column(l_vt, 'CORR_BANK_ID',      sys.anydata.ConvertVarchar2(l_trans.corr_bank_id)    );
        -- CORR_BANK_NAME
        l_target.add_column(l_vt, 'CORR_BANK_NAME',    sys.anydata.ConvertVarchar2(l_trans.corr_bank_name)  );
        -- CORR_IDENT_CODE
        l_target.add_column(l_vt, 'CORR_IDENT_CODE',   sys.anydata.ConvertVarchar2(l_trans.corr_ident_code) );
        -- CORR_ACC_NUM
        l_target.add_column(l_vt, 'CORR_ACC_NUM',      sys.anydata.ConvertVarchar2(l_trans.corr_acc_num)    );
        -- CORR_NAME
        l_target.add_column(l_vt, 'CORR_NAME',         sys.anydata.ConvertVarchar2(l_trans.corr_name)       );
        -- NARRATIVE
        l_target.add_column(l_vt, 'NARRATIVE',         sys.anydata.ConvertVarchar2(l_trans.narrative)       );
        -- NARRATIVE_EXTRA
        -- Здесь внимание! CLOB нельзя запихнуть в конструируемый LCR,
        -- поэтому вставляем его как Varchar2, т.к. он гарантировано меньше 32K
        l_target.add_column(l_vt, 'NARRATIVE_EXTRA',   sys.anydata.ConvertVarchar2(l_trans.narrative_extra) );
        -- IBANK_DOCID
        l_target.add_column(l_vt, 'IBANK_DOCID',       sys.anydata.ConvertNumber(l_trans.ibank_docid)       );
        -- REF92_BANK_ID
        l_target.add_column(l_vt, 'REF92_BANK_ID',     sys.anydata.ConvertVarchar2(l_trans.ref92_bank_id)       );
        -- REF92_CUST_CODE
        l_target.add_column(l_vt, 'REF92_CUST_CODE',   sys.anydata.ConvertVarchar2(l_trans.ref92_cust_code)       );
        -- REF92_ACC_NUM
        l_target.add_column(l_vt, 'REF92_ACC_NUM',     sys.anydata.ConvertVarchar2(l_trans.ref92_acc_num)       );
        -- REF92_ACC_NAME
        l_target.add_column(l_vt, 'REF92_ACC_NAME',    sys.anydata.ConvertVarchar2(l_trans.ref92_acc_name)       );
        -- REF92_BANK_NAME
        l_target.add_column(l_vt, 'REF92_BANK_NAME',   sys.anydata.ConvertVarchar2(l_trans.ref92_bank_name)       );

    end if;
    -- возвращаем объект
    return anydata.ConvertObject(l_target);
  end transform_opldok;

  ----
  -- update_transaction_clob - модифицирует поле narrative_extra типа clob
  -- т.к. lcr.execute() его не трогает
  --
  procedure update_transaction_clob(p_obj in sys.anydata)
  is
    l_tran          acc_transactions%rowtype;
    l_command       varchar2(9);
    l_vt            varchar2(3);
    l_source        sys.lcr$_row_record;
    l_value         sys.anydata;
    l_rc            number;
  begin
    -- преобразуем ANYDATA в LCR
    l_rc := p_obj.getobject(l_source);
    --
    l_command := case when l_source.get_command_type()='DELETE' then 'DELETE' else 'INSERT' end;
    l_vt := case when l_command='DELETE' then 'old' else 'new' end;
    --
    l_value := l_source.get_value(l_vt, 'NARRATIVE_EXTRA');
    --
    if l_value is not null
    then
        l_tran.narrative_extra  := l_value.AccessVarchar2();
        --
        if l_tran.narrative_extra is not null
        then
            --
            l_tran.bank_id          := l_source.get_value(l_vt, 'BANK_ID').AccessVarchar2();
            l_tran.acc_num          := l_source.get_value(l_vt, 'ACC_NUM').AccessVarchar2();
            l_tran.cur_id           := l_source.get_value(l_vt, 'CUR_ID').AccessNumber();
            l_tran.trans_id         := l_source.get_value(l_vt, 'TRANS_ID').AccessVarchar2();
            --
            update acc_transactions
               set narrative_extra = l_tran.narrative_extra
             where bank_id  = l_tran.bank_id
               and acc_num  = l_tran.acc_num
               and cur_id   = l_tran.cur_id
               and trans_id = l_tran.trans_id;
        end if;
    end if;
    --
  end update_transaction_clob;

  ----
  -- subscribe - подпысывает на изменения по счету p_acc
  --
  procedure subscribe(p_acc in integer) is
  begin
    insert into ibank_acc(kf,acc) select kf,acc from v_kf_accounts where acc=p_acc;
    bars.bars_audit.info('IBANK подписан на изменения по счету ACC='||p_acc);
  exception when others then
    raise_application_error(-20000, 'Помилка вставки в ibank_acc, acc='||p_acc||chr(10)||SQLERRM, true);
  end subscribe;

  ---------------------------
  --  UNSUBSCRIBE
  --
  --  удаляет подписку на изменения по счету p_acc
  --
  --
  procedure unsubscribe(p_acc  in integer) is
  begin
    -- на случай, если очистили наш контекст
    init;
    delete from ibank_acc where (kf,acc)=(select kf,acc from v_kf_accounts where acc=p_acc);
    bars.bars_audit.info('Удалена подписка IBANK на изменения по счету ACC='||p_acc);
  end unsubscribe;

  ------------------------------------
  -- IS_SUBSCRIBED
  --
  -- проверяет подписан ли счет на захват изменений
  --
  function is_subscribed(p_acc in integer) return integer is
    l_acc  ibank_acc.acc%type;
  begin
    -- на случай, если очистили наш контекст
    init;
    select acc into l_acc from ibank_acc where (kf,acc)=(select kf,acc from v_kf_accounts where acc=p_acc);
    return 1;
  exception when no_data_found then
    return 0;
  end is_subscribed;

  ------------------------------------
  -- IS_CUST_SUBSCRIBED
  --
  -- проверяет подписан ли клиент на захват изменений
  --
  function is_cust_subscribed(p_rnk in integer) return integer is
    l_rnk  ibank_rnk.rnk%type;
  begin
    select rnk into l_rnk from ibank_rnk where rnk=p_rnk and rownum=1;
    return 1;
  exception when no_data_found then
    return 0;
  end is_cust_subscribed;

  ------------------------------------
  -- IS_DOC_IMPORTED
  --
  -- проверяет был ли документ импортирован из клиент-банка
  --
  function is_doc_imported(p_ref in integer) return integer is
    l_ref  integer;
  begin
    select ref into l_ref from doc_import where ref=p_ref;
    return 1;
  exception when no_data_found then
    return 0;
  end is_doc_imported;

  ---------------------------------------------------
  --
  -- handler_contracts - обработчик для contracts
  --
  --  @p_obj - исходный LCR
  --
  procedure handler_contracts(p_obj in sys.anydata) is
    l_source 		sys.lcr$_row_record;
    l_target		sys.lcr$_row_record;
    l_rc  			number;
    l_value_type    varchar2(3);
    l_value         sys.anydata;
    l_row           ibank_contracts%rowtype;
    l_rowid         rowid;
  begin
    bars.bars_audit.trace('handler_contracts start');
    if p_obj.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        raise_application_error(-20000, 'Неожидаемый тип объекта: '||p_obj.gettypename(), true);
    end if;
    -- Преобразуем ANYDATA в LCR
    l_rc := p_obj.getobject(l_source);
    if l_rc<>dbms_types.success then
        raise_application_error(-20000, 'Ошибка преобразования ANYDATA в LCR$_ROW_RECORD: '||l_rc, true);
    end if;
    if trace_enabled() then
        bars.bars_audit.trace('handler_contracts() LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
    end if;
    -- устанавливаем тип операции
    l_row.operation  := l_source.get_command_type();
    -- удаление не обрабатываем
    if l_row.operation='DELETE' then
		return;
    end if;
    -- для вставки и модификации берем новые значения, для удаления - старые
    l_value_type     := case when l_row.operation='DELETE' then 'OLD' else 'NEW' end;
    -- наполняем ключевые поля
    l_row.pid := l_source.get_value(l_value_type, 'PID').AccessNumber();
	select kf into l_row.kf from v_kf_contracts where pid=l_row.pid;
    -- наполняем неключевые поля
    if l_row.operation in ('INSERT','UPDATE') then
        -- IMPEXP
        l_value := l_source.get_value('NEW', 'IMPEXP');
        if l_value is not null then
            l_row.impexp := l_value.AccessNumber();
            l_row.exist_impexp := 'Y';
        end if;
		-- RNK
        l_value := l_source.get_value('NEW', 'RNK');
        if l_value is not null then
            l_row.rnk := l_value.AccessNumber();
            l_row.exist_rnk := 'Y';
        end if;
        -- NAME
        l_value := l_source.get_value('NEW', 'NAME');
        if l_value is not null then
            l_row.name := l_value.AccessVarchar2();
            l_row.exist_name := 'Y';
        end if;
        -- DATEOPEN
        l_value := l_source.get_value('NEW', 'DATEOPEN');
        if l_value is not null then
            l_row.dateopen := l_value.AccessDate();
            l_row.exist_dateopen := 'Y';
        end if;
        -- DATECLOSE
        l_value := l_source.get_value('NEW', 'DATECLOSE');
        if l_value is not null then
            l_row.dateclose := l_value.AccessDate();
            l_row.exist_dateclose := 'Y';
        end if;
        -- S
        l_value := l_source.get_value('NEW', 'S');
        if l_value is not null then
            l_row.s := l_value.AccessNumber();
            l_row.exist_s := 'Y';
        end if;
        -- KV
        l_value := l_source.get_value('NEW', 'KV');
        if l_value is not null then
            l_row.kv := l_value.AccessNumber();
            l_row.exist_kv := 'Y';
        end if;
        -- ID_OPER
        l_value := l_source.get_value('NEW', 'ID_OPER');
        if l_value is not null then
            l_row.id_oper := l_value.AccessNumber();
            l_row.exist_id_oper := 'Y';
        end if;
        -- BENEFCOUNTRY
        l_value := l_source.get_value('NEW', 'BENEFCOUNTRY');
        if l_value is not null then
            l_row.benefcountry := l_value.AccessNumber();
            l_row.exist_benefcountry := 'Y';
        end if;
        -- BENEFNAME
        l_value := l_source.get_value('NEW', 'BENEFNAME');
        if l_value is not null then
            l_row.benefname := l_value.AccessVarchar2();
            l_row.exist_benefname := 'Y';
        end if;
        -- BENEFBANK
        l_value := l_source.get_value('NEW', 'BENEFBANK');
        if l_value is not null then
            l_row.benefbank := l_value.AccessVarchar2();
            l_row.exist_benefbank := 'Y';
        end if;
        -- BENEFACC
        l_value := l_source.get_value('NEW', 'BENEFACC');
        if l_value is not null then
            l_row.benefacc := l_value.AccessVarchar2();
            l_row.exist_benefacc := 'Y';
        end if;
        -- AIM
        l_value := l_source.get_value('NEW', 'AIM');
        if l_value is not null then
            l_row.aim := l_value.AccessVarchar2();
            l_row.exist_aim := 'Y';
        end if;
        -- CONTINUED
        l_value := l_source.get_value('NEW', 'CONTINUED');
        if l_value is not null then
            l_row.continued := l_value.AccessVarchar2();
            l_row.exist_continued := 'Y';
        end if;
        -- COND
        l_value := l_source.get_value('NEW', 'COND');
        if l_value is not null then
            l_row.cond := l_value.AccessVarchar2();
            l_row.exist_cond := 'Y';
        end if;
        -- DETAILS
        l_value := l_source.get_value('NEW', 'DETAILS');
        if l_value is not null then
            l_row.details := l_value.AccessVarchar2();
            l_row.exist_details := 'Y';
        end if;
        -- BANKCOUNTRY
        l_value := l_source.get_value('NEW', 'BANKCOUNTRY');
        if l_value is not null then
            l_row.bankcountry := l_value.AccessNumber();
            l_row.exist_bankcountry := 'Y';
        end if;
    end if;
    -- вставляем запись в acc_turnovers
    insert into ibank_contracts values l_row returning rowid into l_rowid;
    -- тут же удаляем
    delete from ibank_contracts where rowid=l_rowid;
    bars.bars_audit.trace('handler_contracts finish');
  end handler_contracts;


  --
  --  Преобразование BARS.PARAMS --> BARSAQ.BANKDATES
  --
  function bankdates(p_anydata in sys.anydata) return sys.anydata is
    l_source 		sys.lcr$_row_record;
    l_target     	sys.lcr$_row_record;
    l_rc  			number;
    l_value         sys.anydata;
    l_bankid        varchar2(11);
  begin
      logger.trace('ibank_acounts.bankdates(...) invoked');
      if p_anydata.gettypename='SYS.LCR$_ROW_RECORD' then
        -- преобразуем ANYDATA в LCR
        l_rc := p_anydata.getobject(l_source);
        if l_rc<>dbms_types.success then
        	return p_anydata;
        end if;
        if trace_enabled() then
            logger.trace('bankdates LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
        end if;
        -- конструируем LCR для применения к таблице
        l_target := sys.lcr$_row_record.construct(
                     source_database_name => l_source.get_source_database_name(),
                     command_type         => l_source.get_command_type(),
                     object_owner         => 'BARSAQ',
                     object_name          => 'BANKDATES',
                     tag                  => l_source.get_tag(),
                     transaction_id       => l_source.get_transaction_id(),
                     scn                  => l_source.get_scn()
                   );
        -- получаем код банка
        l_bankid := l_source.get_value('old','KF').accessVarchar2();
        -- добавляем отдельные колонки
        --
        -- BANK_ID
        l_target.add_column(
                value_type     => 'old',
                column_name    => 'BANK_ID',
                column_value   => anydata.convertVarchar2(l_bankid)
        );
        -- BANKDATE
        l_value := l_source.get_value('new','VAL');
        l_target.add_column(
                value_type     => 'new',
                column_name    => 'BANKDATE',
                column_value   => anydata.convertDate(to_date(l_value.accessVarchar2(),'MM/DD/YYYY'))
        );
        --
        return anydata.convertobject(l_target);
      end if;
    return p_anydata;
  end bankdates;

  --
  --  Преобразование BARS.CUR_RATES(CUR_RATES$BASE) --> BARSAQ.CURRENCY_RATES
  --
  function currency_rates(p_anydata in sys.anydata) return sys.anydata is
    l_source 		sys.lcr$_row_record;
    l_target     	sys.lcr$_row_record;
    l_rc  			number;
    l_value         sys.anydata;
    l_value_type    varchar2(3);
    l_bankid        varchar2(11);
    l_branch        varchar2(30);
    l_command       varchar2(9);
    l_vt            varchar2(3);
  begin
      logger.trace('ibank_acounts.currency_rates(...) invoked');
      if p_anydata.gettypename='SYS.LCR$_ROW_RECORD' then
        -- преобразуем ANYDATA в LCR
        l_rc := p_anydata.getobject(l_source);
        if l_rc<>dbms_types.success then
        	return p_anydata;
        end if;
        if trace_enabled() then
            logger.trace('currency_rates LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
        end if;
        -- конструируем LCR для применения к таблице
        l_command := l_source.get_command_type();
        l_target := sys.lcr$_row_record.construct(
                     source_database_name => l_source.get_source_database_name(),
                     command_type         => l_command,
                     object_owner         => 'BARSAQ',
                     object_name          => 'CURRENCY_RATES',
                     tag                  => l_source.get_tag(),
                     transaction_id       => l_source.get_transaction_id(),
                     scn                  => l_source.get_scn()
                   );
        -- для вставки и модификации берем новые значения, для удаления - старые
        l_value_type := case when l_source.get_command_type()='DELETE' then 'OLD' else 'NEW' end;
        -- получаем код банка
        l_branch := l_source.get_value(l_value_type,'BRANCH').accessVarchar2();
        l_bankid := bars.bc.extract_mfo(l_branch);
        -- добавляем отдельные колонки
        --
        if l_command in ('DELETE','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- RATE_DATE
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'RATE_DATE',
                    column_value   => l_source.get_value('old','VDATE')
            );
            -- CUR_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'CUR_ID',
                    column_value   => l_source.get_value('old','KV')
            );
        end if;
        if l_command in ('INSERT','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- RATE_DATE
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'RATE_DATE',
                    column_value   => l_source.get_value('new','VDATE')
            );
            -- CUR_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'CUR_ID',
                    column_value   => l_source.get_value('new','KV')
            );
            -- BASE_SUM
            l_value := l_source.get_value('new','BSUM');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'BASE_SUM',
                        column_value   => l_value
                );
            end if;
            -- RATE_OFFICIAL
            l_value := l_source.get_value('new','RATE_O');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'RATE_OFFICIAL',
                        column_value   => l_value
                );
            end if;
            -- RATE_BUYING
            l_value := l_source.get_value('new','RATE_B');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'RATE_BUYING',
                        column_value   => l_value
                );
            end if;
            -- RATE_SELLING
            l_value := l_source.get_value('new','RATE_S');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'RATE_SELLING',
                        column_value   => l_value
                );
            end if;
        end if;
        --
        return anydata.convertobject(l_target);
      end if;
    return p_anydata;
  end currency_rates;

  --
  --  Преобразование BARS.TOBO(BRANCH) --> BARSAQ.BRANCHES
  --
  function branches(p_anydata in sys.anydata) return sys.anydata is
    l_source 		sys.lcr$_row_record;
    l_target     	sys.lcr$_row_record;
    l_rc  			number;
    l_value         sys.anydata;
    l_value_type    varchar2(3);
    l_bankid        varchar2(11);
    l_branch        varchar2(30);
    l_command       varchar2(9);
  begin
      logger.trace('ibank_acounts.branches(...) invoked');
      if p_anydata.gettypename='SYS.LCR$_ROW_RECORD' then
        -- преобразуем ANYDATA в LCR
        l_rc := p_anydata.getobject(l_source);
        if l_rc<>dbms_types.success then
        	return p_anydata;
        end if;
        if trace_enabled() then
            logger.trace('branches LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
        end if;
        -- конструируем LCR для применения к таблице
        l_command := l_source.get_command_type();
        l_target := sys.lcr$_row_record.construct(
                     source_database_name => l_source.get_source_database_name(),
                     command_type         => l_command,
                     object_owner         => 'BARSAQ',
                     object_name          => 'BRANCHES',
                     tag                  => l_source.get_tag(),
                     transaction_id       => l_source.get_transaction_id(),
                     scn                  => l_source.get_scn()
                   );
        -- для вставки и модификации берем новые значения, для удаления - старые
        l_value_type := case when l_source.get_command_type()='DELETE' then 'OLD' else 'NEW' end;
        -- получаем код банка
        l_branch := l_source.get_value(l_value_type,'BRANCH').accessVarchar2();
        l_bankid := bars.bc.extract_mfo(l_branch);
        -- добавляем отдельные колонки
        --
        if l_command in ('DELETE','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- BRANCH_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'BRANCH_ID',
                    column_value   => anydata.convertVarchar2(l_branch)
            );
        end if;
        if l_command in ('INSERT','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- BRANCH_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'BRANCH_ID',
                    column_value   => anydata.convertVarchar2(l_branch)
            );
            -- NAME
            l_value := l_source.get_value('new','NAME');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'NAME',
                        column_value   => l_value
                );
            end if;
            -- DATE_OPENED
            l_value := l_source.get_value('new','DATE_OPENED');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'DATE_OPENED',
                        column_value   => l_value
                );
            end if;
            -- DATE_CLOSED
            l_value := l_source.get_value('new','DATE_CLOSED');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'DATE_CLOSED',
                        column_value   => l_value
                );
            end if;
            -- DESCRIPTION
            l_value := l_source.get_value('new','DESCRIPTION');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'DESCRIPTION',
                        column_value   => l_value
                );
            end if;
            -- NBU_CODE
            l_value := l_source.get_value('new','B040');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'NBU_CODE',
                        column_value   => l_value
                );
            end if;
        end if;
        return anydata.convertobject(l_target);
      end if;
      return p_anydata;
  end branches;

  --
  --  Преобразование BARS.HOLIDAY --> BARSAQ.HOLIDAYS
  --
  function holidays(p_anydata in sys.anydata) return sys.anydata is
    l_label         constant varchar2(128) := 'ibank_accounts.holidays';
    l_source        sys.lcr$_row_record;
    l_target        sys.lcr$_row_record;
    l_rc            number;
    l_command       varchar2(9);
    l_value         sys.anydata;
    l_vt            varchar2(3);
  begin
    logger.trace('%s : invoked', l_label);
    if p_anydata.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        return p_anydata;
    end if;
    -- преобразуем ANYDATA в LCR
    l_rc := p_anydata.getobject(l_source);
    if l_rc<>dbms_types.success then
        return p_anydata;
    end if;
    if trace_enabled() then
        logger.trace('%s :'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)), l_label);
    end if;
    -- конструируем LCR для применения к таблице
    l_command := l_source.get_command_type();
    l_target := sys.lcr$_row_record.construct(
                 source_database_name => l_source.get_source_database_name(),
                 command_type         => l_command,
                 object_owner         => 'BARSAQ',
                 object_name          => 'HOLIDAYS',
                 tag                  => l_source.get_tag(),
                 transaction_id       => l_source.get_transaction_id(),
                 scn                  => l_source.get_scn()
               );
    -- формируем поля целевой таблицы
    for i in 1..2 loop
        -- старые/новые значения
        l_vt := case when i=1 then 'old' else 'new' end;
        -- KV --> CUR_ID
        l_value := l_source.get_value(l_vt,'KV','N');
        if l_value is not null then
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'CUR_ID',
                    column_value   => l_value
            );
        end if;
        -- HOLIDAY --> HOLIDAY
        l_value := l_source.get_value(l_vt,'HOLIDAY','N');
        if l_value is not null then
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'HOLIDAY',
                    column_value   => l_value
            );
        end if;
    end loop;
    -- возвращаем объект
    return anydata.ConvertObject(l_target);
  end holidays;

  --
  --  Преобразование BARS.BANKS(BANKS$BASE) --> BARSAQ.BANKS
  --
  function banks(p_anydata in sys.anydata) return sys.anydata is
    l_label         constant varchar2(128) := 'ibank_accounts.banks';
    l_source        sys.lcr$_row_record;
    l_target        sys.lcr$_row_record;
    l_rc            number;
    l_command       varchar2(9);
    l_value         sys.anydata;
    l_vt            varchar2(3);
    l_closing_date  date;
    l_blk           number;
  begin
    logger.trace('%s : invoked', l_label);
    if p_anydata.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        return p_anydata;
    end if;
    -- преобразуем ANYDATA в LCR
    l_rc := p_anydata.getobject(l_source);
    if l_rc<>dbms_types.success then
        return p_anydata;
    end if;
    if trace_enabled() then
        logger.trace('%s :'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)), l_label);
    end if;
    -- конструируем LCR для применения к таблице
    l_command := l_source.get_command_type();
    l_target := sys.lcr$_row_record.construct(
                 source_database_name => l_source.get_source_database_name(),
                 command_type         => l_command,
                 object_owner         => 'BARSAQ',
                 object_name          => 'BANKS',
                 tag                  => l_source.get_tag(),
                 transaction_id       => l_source.get_transaction_id(),
                 scn                  => l_source.get_scn()
               );
    -- формируем поля целевой таблицы
    for i in 1..2 loop
        -- старые/новые значения
        l_vt := case when i=1 then 'old' else 'new' end;
        -- MFO --> BANK_ID
        l_value := l_source.get_value(l_vt,'MFO','N');
        if l_value is not null then
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'BANK_ID',
                    column_value   => l_value
            );
        end if;
        -- NB --> NAME
        l_value := l_source.get_value(l_vt,'NB','N');
        if l_value is not null then
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'NAME',
                    column_value   => l_value
            );
        end if;
        -- BLK --> CLOSING_DATE
        if l_vt='new' and l_command in ('INSERT','UPDATE') then
            l_value := l_source.get_value(l_vt,'BLK','N');
            if l_value is not null then
                l_blk := l_value.AccessNumber();
                l_closing_date := case when l_blk=4 then trunc(sysdate) else null end;
                l_target.add_column(
                        value_type     => l_vt,
                        column_name    => 'CLOSING_DATE',
                        column_value   => sys.anydata.ConvertDate(l_closing_date)
                );
            end if;
        end if;
    end loop;
    -- возвращаем объект
    return anydata.ConvertObject(l_target);
  end banks;

  --
  --  Преобразование BARS.SW_BANKS --> BARSAQ.SWIFT_BANKS
  --
  function swift_banks(p_anydata in sys.anydata) return sys.anydata is
    l_label         constant varchar2(128) := 'ibank_accounts.swift_banks';
    l_source        sys.lcr$_row_record;
    l_target        sys.lcr$_row_record;
    l_rc            number;
    l_command       varchar2(9);
    l_value         sys.anydata;
    l_vt            varchar2(3);
    l_bicid         BARSAQ.swift_banks.bic_id%type;
    l_str           varchar2(4000);
  begin
    logger.trace('%s : invoked', l_label);
    if p_anydata.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        return p_anydata;
    end if;
    -- преобразуем ANYDATA в LCR
    l_rc := p_anydata.getobject(l_source);
    if l_rc<>dbms_types.success then
        return p_anydata;
    end if;
    if trace_enabled() then
        logger.trace('%s :'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)), l_label);
    end if;
    -- конструируем LCR для применения к таблице
    l_command := l_source.get_command_type();
    l_target := sys.lcr$_row_record.construct(
                 source_database_name => l_source.get_source_database_name(),
                 command_type         => l_command,
                 object_owner         => 'BARSAQ',
                 object_name          => 'SWIFT_BANKS',
                 tag                  => l_source.get_tag(),
                 transaction_id       => l_source.get_transaction_id(),
                 scn                  => l_source.get_scn()
               );
    -- формируем поля целевой таблицы
    for i in 1..2 loop
        -- старые/новые значения
        l_vt := case when i=1 then 'old' else 'new' end;
        -- BIC --> BIC_ID
        l_value := l_source.get_value(l_vt,'BIC','N');
        if l_value is not null then
            l_bicid := l_value.AccessChar();
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'BIC_ID',
                    column_value   => sys.anydata.ConvertVarchar2(l_bicid)
            );
        end if;
        -- NAME --> NAME
        l_value := l_source.get_value(l_vt,'NAME','N');
        if l_value is not null then
            l_str := rtrim(l_value.AccessVarchar2());
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'NAME',
                    column_value   => sys.anydata.ConvertVarchar2(l_str)
            );
        end if;
        -- OFFICE --> OFFICE
        l_value := l_source.get_value(l_vt,'OFFICE','N');
        if l_value is not null then
            l_str := rtrim(l_value.AccessVarchar2());
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'OFFICE',
                    column_value   => sys.anydata.ConvertVarchar2(l_str)
            );
        end if;
        -- CITY --> CITY
        l_value := l_source.get_value(l_vt,'CITY','N');
        if l_value is not null then
            l_str := rtrim(l_value.AccessVarchar2());
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'CITY',
                    column_value   => sys.anydata.ConvertVarchar2(l_str)
            );
        end if;
        -- COUNTRY --> COUNTRY
        l_value := l_source.get_value(l_vt,'COUNTRY','N');
        if l_value is not null then
            l_str := rtrim(l_value.AccessVarchar2());
            l_target.add_column(
                    value_type     => l_vt,
                    column_name    => 'COUNTRY',
                    column_value   => sys.anydata.ConvertVarchar2(l_str)
            );
        end if;
    end loop;
    -- возвращаем объект
    return anydata.ConvertObject(l_target);
  end swift_banks;

  --
  --  Преобразование BARS.SOS_TRACK --> BARSAQ.DOC_EXPORT
  --
  function doc_export(p_anydata in sys.anydata) return sys.anydata is
    l_label         constant varchar2(128) := 'ibank_accounts.doc_export';
    l_source        sys.lcr$_row_record;
    l_target        sys.lcr$_row_record;
    l_rc            number;
    l_value         sys.anydata;
    l_ds            BARSAQ.doc_export%rowtype;
    l_ref           integer;
    l_sos           integer;
  begin
    logger.trace('%s : invoked', l_label);
    if p_anydata.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        return p_anydata;
    end if;
    -- преобразуем ANYDATA в LCR
    l_rc := p_anydata.getobject(l_source);
    if l_rc<>dbms_types.success then
        return p_anydata;
    end if;
    if trace_enabled() then
        logger.trace('%s :'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)), l_label);
    end if;
    -- конструируем LCR для применения к таблице
    l_target := sys.lcr$_row_record.construct(
                 source_database_name => l_source.get_source_database_name(),
                 command_type         => 'UPDATE',
                 object_owner         => 'BARSAQ',
                 object_name          => 'DOC_EXPORT',
                 tag                  => l_source.get_tag(),
                 transaction_id       => l_source.get_transaction_id(),
                 scn                  => l_source.get_scn()
               );
    -- нас интересуют ref и sos
    l_ref   := l_source.get_value('new','REF').AccessNumber();
    l_sos   := l_source.get_value('new','NEW_SOS').AccessNumber();
    --
    l_ds.bank_ref := to_char(l_ref);
    -- doc_id читаем по референсу
    select to_number(ext_ref) into l_ds.doc_id from doc_import where ref=l_ref;
    -- мапим статус
    l_ds.status_id  := case
                       when l_sos<0 then -20
                       when l_sos>=5 then 50
                       else 45
                       end;
    -- время изменения статуса определяем по SCN из LCR
    l_ds.status_change_time := l_source.get_value('new','CHANGE_TIME').AccessDate();
    if l_ds.status_id=50 then
        -- ставим дату проведения банком
        l_ds.bank_accept_date := l_ds.status_change_time;
    elsif l_ds.status_id<0 then
        -- ставим дату отказа банком
        l_ds.bank_back_date := l_ds.status_change_time;
        -- ставим причину отказа банком
        begin
            select trim(value) into l_ds.bank_back_reason from bars.operw where ref=l_ref and tag='BACKR';
        exception when no_data_found then
            l_ds.bank_back_reason := 'Причину сторнування не вказано';
        end;
    end if;
    -- добавляем колонки в LCR
    l_target.add_column('old', 'DOC_ID',                sys.anydata.ConvertNumber(l_ds.doc_id)              );
    l_target.add_column('new', 'STATUS_ID',             sys.anydata.ConvertNumber(l_ds.status_id)           );
    l_target.add_column('new', 'STATUS_CHANGE_TIME',    sys.anydata.ConvertDate(l_ds.status_change_time)    );
    l_target.add_column('new', 'BANK_ACCEPT_DATE',      sys.anydata.ConvertDate(l_ds.bank_accept_date)      );
    l_target.add_column('new', 'BANK_REF',              sys.anydata.ConvertVarchar2(l_ds.bank_ref)          );
    l_target.add_column('new', 'BANK_BACK_DATE',        sys.anydata.ConvertDate(l_ds.bank_back_date)        );
    l_target.add_column('new', 'BANK_BACK_REASON',      sys.anydata.ConvertVarchar2(l_ds.bank_back_reason)  );
    -- возвращаем объект
    return anydata.ConvertObject(l_target);
  end doc_export;

  ---------------------------------------------------
  --
  -- handler_sync - обработчик для sync_-процессов
  --
  --  @p_obj - исходный LCR
  --
  procedure handler_sync(p_obj in sys.anydata) is
	l_source 		sys.lcr$_row_record;
    l_rc  			number;
    l_xml           xmltype;
  begin
    if trace_enabled() then
    	logger.trace('entry point of handler_sync()');
    end if;
    if p_obj.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        raise_application_error(-20000, 'Неожидаемый тип объекта: '||p_obj.gettypename(), true);
    end if;
    -- Преобразуем ANYDATA в LCR
    l_rc := p_obj.getobject(l_source);
    if l_rc<>dbms_types.success then
        raise_application_error(-20000, 'Ошибка преобразования ANYDATA в LCR$_ROW_RECORD: '||l_rc, true);
    end if;
    if trace_enabled() then
        logger.trace('handler_sync() LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
    end if;
    -- выполняем локально
    l_source.execute(true);


    if trace_enabled() then
    	logger.trace('final point of handler_sync()');
    end if;
  exception when others then
    declare
      l_errmsg varchar2(4000);
    begin
      l_errmsg := substr('handler_sync error: '
        ||dbms_utility.format_error_stack()||chr(10)
        ||dbms_utility.format_error_backtrace()||chr(10)
        ||'LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)),1,4000);
      bars.bars_audit.error(l_errmsg);
      raise_application_error(-20000, l_errmsg);
    end;
  end handler_sync;

  ---------------------------------------------------
  --
  -- acc_transactions_handler - обработчик для acc_transactions
  --
  --  @p_obj - исходный LCR
  --
  procedure acc_transactions_handler(p_obj in sys.anydata) is
    l_obj   sys.anydata;
  begin
    l_obj := transform_opldok(p_obj);
    --
    handler_sync(l_obj);
    --
    update_transaction_clob(l_obj);
    --
  end acc_transactions_handler;

  --
  --  Преобразование BARS.BIRJA --> BARSAQ.DOC_CUREX_PARAMS
  --
  function doc_curex_params(p_anydata in sys.anydata) return sys.anydata is
    l_source 		sys.lcr$_row_record;
    l_target     	sys.lcr$_row_record;
    l_rc  			number;
    l_value         sys.anydata;
    l_bankid        varchar2(11);
    l_command       varchar2(9);
  begin
    logger.trace('ibank_acounts.doc_curex_params(...) invoked');
    if p_anydata.gettypename='SYS.LCR$_ROW_RECORD' then
        -- преобразуем ANYDATA в LCR
        l_rc := p_anydata.getobject(l_source);
        if l_rc<>dbms_types.success then
        	return p_anydata;
        end if;
        if trace_enabled() then
            logger.trace('doc_curex_params LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
        end if;
        -- конструируем LCR для применения к таблице
        l_command := l_source.get_command_type();
        l_target := sys.lcr$_row_record.construct(
                     source_database_name => l_source.get_source_database_name(),
                     command_type         => l_command,
                     object_owner         => 'BARSAQ',
                     object_name          => 'DOC_CUREX_PARAMS',
                     tag                  => l_source.get_tag(),
                     transaction_id       => l_source.get_transaction_id(),
                     scn                  => l_source.get_scn()
                   );
        -- получаем код банка
        select val
		  into l_bankid
		  from bars.params
		 where par = 'GLB-MFO';

        -- добавляем отдельные колонки
        --
        if l_command in ('DELETE','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- PAR_ID
            l_value := l_source.get_value('old','PAR');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'old',
                        column_name    => 'PAR_ID',
                        column_value   => l_value
                );
			end if;
        end if;
        if l_command in ('INSERT','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- PAR_ID
            l_value := l_source.get_value('new','PAR');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'PAR_ID',
                        column_value   => l_value
                );
            end if;
            -- PAR_VALUE
            l_value := l_source.get_value('new','VAL');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'PAR_VALUE',
                        column_value   => l_value
                );
            end if;
            -- PAR_COMMENT
            l_value := l_source.get_value('new','COMM');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'PAR_COMMENT',
                        column_value   => l_value
                );
            end if;
        end if;

        return anydata.convertobject(l_target);

    end if;

    return p_anydata;

  end doc_curex_params;

  --
  --  Преобразование BARS.CUST_ZAY --> BARSAQ.DOC_CUREX_CUSTCOMMISSIONS
  --
  function doc_curex_custcommissions(p_anydata in sys.anydata) return sys.anydata is
    l_source 		sys.lcr$_row_record;
    l_target     	sys.lcr$_row_record;
    l_rc  			number;
    l_value         sys.anydata;
    l_bankid        varchar2(11);
    l_command       varchar2(9);
  begin
      logger.trace('ibank_acounts.doc_curex_custcommissions(...) invoked');
      if p_anydata.gettypename='SYS.LCR$_ROW_RECORD' then
        -- преобразуем ANYDATA в LCR
        l_rc := p_anydata.getobject(l_source);
        if l_rc<>dbms_types.success then
        	return p_anydata;
        end if;
        if trace_enabled() then
            logger.trace('ibank_acounts.doc_curex_custcommissions LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
        end if;
        -- конструируем LCR для применения к таблице
        l_command := l_source.get_command_type();
        l_target := sys.lcr$_row_record.construct(
                     source_database_name => l_source.get_source_database_name(),
                     command_type         => l_command,
                     object_owner         => 'BARSAQ',
                     object_name          => 'DOC_CUREX_CUSTCOMMISSIONS',
                     tag                  => l_source.get_tag(),
                     transaction_id       => l_source.get_transaction_id(),
                     scn                  => l_source.get_scn()
                   );
        -- получаем код банка
        select val
		  into l_bankid
		  from bars.params
		 where par = 'GLB-MFO';

        -- добавляем отдельные колонки
        --
        if l_command in ('DELETE','UPDATE') then
            -- CUST_ID
            l_value := l_source.get_value('old','RNK');

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

            if l_value is not null then
                l_target.add_column(
                        value_type     => 'old',
                        column_name    => 'RNK',
                        column_value   => l_value
                );
            end if;

            -- BANK_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );

        end if;
        if l_command in ('INSERT','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- CUST_ID
            l_value := l_source.get_value('new','RNK');

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

            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'RNK',
                        column_value   => l_value
                );
            end if;

            -- BUY_COMMISSION
            l_value := l_source.get_value('new','KOM');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'BUY_COMMISSION',
                        column_value   => l_value
                );
            end if;

            -- SELL_COMMISSION
            l_value := l_source.get_value('new','KOM2');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'SELL_COMMISSION',
                        column_value   => l_value
                );
            end if;

            -- SELL_COMMISSION
            l_value := l_source.get_value('new','KOM3');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'CONV_COMMISSION',
                        column_value   => l_value
                );
            end if;

        end if;
        return anydata.convertobject(l_target);
      end if;
      return p_anydata;
  end doc_curex_custcommissions;

  --
  --  Преобразование BARS.ZAY_COMISS --> BARSAQ.DOC_CUREX_EXCLUSIVE
  --
  function doc_curex_exclusive(p_anydata in sys.anydata) return sys.anydata is
    l_source 		sys.lcr$_row_record;
    l_target     	sys.lcr$_row_record;
    l_rc  			number;
    l_value         sys.anydata;
    l_bankid        varchar2(11);
    l_command       varchar2(9);
  begin
      logger.trace('ibank_acounts.doc_curex_exclusive(...) invoked');
      if p_anydata.gettypename='SYS.LCR$_ROW_RECORD' then
        -- преобразуем ANYDATA в LCR
        l_rc := p_anydata.getobject(l_source);
        if l_rc<>dbms_types.success then
        	return p_anydata;
        end if;
        if trace_enabled() then
            logger.trace('ibank_acounts.doc_curex_exclusive LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
        end if;
        -- конструируем LCR для применения к таблице
        l_command := l_source.get_command_type();
        l_target := sys.lcr$_row_record.construct(
                     source_database_name => l_source.get_source_database_name(),
                     command_type         => l_command,
                     object_owner         => 'BARSAQ',
                     object_name          => 'DOC_CUREX_EXCLUSIVE',
                     tag                  => l_source.get_tag(),
                     transaction_id       => l_source.get_transaction_id(),
                     scn                  => l_source.get_scn()
                   );
        -- получаем код банка
        select val
		  into l_bankid
		  from bars.params
		 where par = 'GLB-MFO';

        -- добавляем отдельные колонки
        --
        if l_command in ('DELETE','UPDATE') then
            -- RATE_ID
            l_value := l_source.get_value('old','ID');

			if l_value is not null then
                l_target.add_column(
                        value_type     => 'old',
                        column_name    => 'RATE_ID',
                        column_value   => l_value
                );
            end if;
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
        end if;
        if l_command in ('INSERT','UPDATE') then
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
            -- CUST_ID
            l_value := l_source.get_value('new','RNK');

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

            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'RNK',
                        column_value   => l_value
                );
            end if;

            -- RATE_ID
            l_value := l_source.get_value('new','ID');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'RATE_ID',
                        column_value   => l_value
                );
            end if;

            -- BUY_SELL_FLAG
            l_value := l_source.get_value('new','DK');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'BUY_SELL_FLAG',
                        column_value   => l_value
                );
            end if;

            -- CUR_GROUP
            l_value := l_source.get_value('new','KV_GRP');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'CUR_GROUP',
                        column_value   => l_value
                );
            end if;

            -- CUR_ID
            l_value := l_source.get_value('new','KV');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'CUR_ID',
                        column_value   => l_value
                );
            end if;

            -- LIMIT
            l_value := l_source.get_value('new','LIMIT');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'LIMIT',
                        column_value   => l_value
                );
            end if;

            -- COMMISSION_RATE
            l_value := l_source.get_value('new','RATE');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'COMMISSION_RATE',
                        column_value   => l_value
                );
            end if;

            -- COMMISSION_SUM
            l_value := l_source.get_value('new','FIX_SUM');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'COMMISSION_SUM',
                        column_value   => l_value
                );
            end if;

            -- DATE_ON
            l_value := l_source.get_value('new','DATE_ON');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'DATE_ON',
                        column_value   => l_value
                );
            end if;

            -- DATE_OFF
            l_value := l_source.get_value('new','DATE_OFF');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'DATE_OFF',
                        column_value   => l_value
                );
            end if;

		end if;
        return anydata.convertobject(l_target);
      end if;
      return p_anydata;
  end doc_curex_exclusive;

  --
  --  Преобразование BARS.CUSTOMER_ADDRESS --> BARSAQ.CUST_ADDRESSES
  --
  function cust_addresses(p_anydata in sys.anydata) return sys.anydata is
    l_source 		sys.lcr$_row_record;
    l_target     	sys.lcr$_row_record;
    l_rc  			number;
    l_value         sys.anydata;
    l_bankid        varchar2(11);
    l_command       varchar2(9);
  begin
      logger.trace('ibank_acounts.cust_addresses(...) invoked');
      if p_anydata.gettypename='SYS.LCR$_ROW_RECORD' then
        -- преобразуем ANYDATA в LCR
        l_rc := p_anydata.getobject(l_source);
        if l_rc<>dbms_types.success then
        	return p_anydata;
        end if;
        if trace_enabled() then
            logger.trace('ibank_acounts.cust_addresses LCR:'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)));
        end if;
        -- конструируем LCR для применения к таблице
        l_command := l_source.get_command_type();
        l_target := sys.lcr$_row_record.construct(
                     source_database_name => l_source.get_source_database_name(),
                     command_type         => l_command,
                     object_owner         => 'BARSAQ',
                     object_name          => 'CUST_ADDRESSES',
                     tag                  => l_source.get_tag(),
                     transaction_id       => l_source.get_transaction_id(),
                     scn                  => l_source.get_scn()
                   );
        -- получаем код банка
        select val
		  into l_bankid
		  from bars.params
		 where par = 'GLB-MFO';

        -- добавляем отдельные колонки
        --
        if l_command in ('DELETE','UPDATE') then
            -- RNK
            l_value := l_source.get_value('old','RNK');

			if l_value is not null then
                l_target.add_column(
                        value_type     => 'old',
                        column_name    => 'RNK',
                        column_value   => l_value
                );
            end if;
            -- TYPE_ID
			l_value := l_source.get_value('old','TYPE_ID');

			if l_value is not null then
				l_target.add_column(
						value_type     => 'old',
						column_name    => 'TYPE_ID',
						column_value   => l_value
				);
            end if;
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'old',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );
        end if;
        if l_command in ('INSERT','UPDATE') then
            -- RNK
            l_value := l_source.get_value('new','RNK');

			if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'RNK',
                        column_value   => l_value
                );
            end if;
            -- TYPE_ID
			l_value := l_source.get_value('new','TYPE_ID');

			if l_value is not null then
				l_target.add_column(
						value_type     => 'new',
						column_name    => 'TYPE_ID',
						column_value   => l_value
				);
            end if;
            -- BANK_ID
            l_target.add_column(
                    value_type     => 'new',
                    column_name    => 'BANK_ID',
                    column_value   => anydata.convertVarchar2(l_bankid)
            );

            -- COUNTRY
            l_value := l_source.get_value('new','COUNTRY');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'COUNTRY_ID',
                        column_value   => l_value
                );
            end if;

            -- ZIP
            l_value := l_source.get_value('new','ZIP');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'ZIP',
                        column_value   => l_value
                );
            end if;

            -- DOMAIN
            l_value := l_source.get_value('new','DOMAIN');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'REGION',
                        column_value   => l_value
                );
            end if;

            -- REGION
            l_value := l_source.get_value('new','REGION');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'DISTRICT',
                        column_value   => l_value
                );
            end if;

            -- LOCALITY
            l_value := l_source.get_value('new','LOCALITY');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'CITY',
                        column_value   => l_value
                );
            end if;

            -- ADDRESS
            l_value := l_source.get_value('new','ADDRESS');
            if l_value is not null then
                l_target.add_column(
                        value_type     => 'new',
                        column_name    => 'ADDRESS',
                        column_value   => l_value
                );
            end if;

		end if;
        return anydata.convertobject(l_target);
      end if;
      return p_anydata;
  end cust_addresses;


  ------------------------------------
  -- IS_CLIENT_ZAYAVKA
  --
  -- проверяет была ли заявка импортирована из клиент-банка
  --
  function is_client_zayavka(p_id in integer)
    return integer
  is
    l_result integer;
  begin
    select 1
      into l_result
      from zayavka_id_map
     where idz=p_id;
    return 1;
  exception
    when no_data_found then
      return 0;
  end is_client_zayavka;

--
  --  Преобразование BARS.ZAY_QUEUE(BARSAQ.ZAYAVKA_ID_MAP) --> BARSAQ.DOC_EXPORT
  --
  function transform_zay(p_anydata in sys.anydata) return sys.anydata is
    l_label         constant varchar2(128) := 'ibank_accounts.transform_zay';
    l_source        sys.lcr$_row_record;
    l_target        sys.lcr$_row_record;
    l_rc            number;
    l_value         sys.anydata;
    l_ds            BARSAQ.doc_export%rowtype;
    l_idz           bars.zayavka.id%type;
    l_sos           bars.zayavka.sos%type;
    l_idback        bars.zay_back.id%type;
    l_reason        bars.zay_back.reason%type;
  begin
    logger.trace('%s : invoked', l_label);
    if p_anydata.gettypename()<>'SYS.LCR$_ROW_RECORD' then
        return p_anydata;
    end if;
    -- преобразуем ANYDATA в LCR
    l_rc := p_anydata.getobject(l_source);
    if l_rc<>dbms_types.success then
        return p_anydata;
    end if;
    if trace_enabled() then
        logger.trace('%s :'||chr(10)||rtrim(dbms_lob.substr(f_row_lcr_to_char(l_source),3900)), l_label);
    end if;
    -- конструируем LCR для применения к таблице
    l_target := sys.lcr$_row_record.construct(
                 source_database_name => l_source.get_source_database_name(),
                 command_type         => 'UPDATE',
                 object_owner         => 'BARSAQ',
                 object_name          => 'DOC_EXPORT',
                 tag                  => l_source.get_tag(),
                 transaction_id       => l_source.get_transaction_id(),
                 scn                  => l_source.get_scn()
               );
    --
    l_idz   := l_source.get_value('new','ID').AccessNumber();
    -- референсом для заявки будет ее ID
    l_ds.bank_ref := to_char(l_idz);
    -- doc_id читаем по id заявки
    select doc_id
      into l_ds.doc_id
      from zayavka_id_map
     where idz = l_idz;
    -- получаем статус заявки и код причины отказа
    select sos,   idback
      into l_sos, l_idback
      from bars.zayavka
     where id = l_idz;
    -- получаем описание причины отказа
    if l_sos=-1 and l_idback is not null
    then
        select reason
          into l_reason
          from bars.zay_back
         where id = l_idback;
    end if;
    -- мапим статус
    l_ds.status_id  := case
                       when l_sos =-1 then -20
                       when l_sos = 2 then  50
                       else 45
                       end;
    -- время изменения статуса определяем по SCN из LCR
    l_ds.status_change_time := l_source.get_value('new','CHANGE_TIME').AccessDate();
    if l_ds.status_id=50 then
        -- ставим дату проведения банком
        l_ds.bank_accept_date := l_ds.status_change_time;
    elsif l_ds.status_id<0 then
        -- ставим дату отказа банком
        l_ds.bank_back_date := l_ds.status_change_time;
        -- ставим причину отказа банком
        if l_reason is not null
        then
            l_ds.bank_back_reason := l_reason;
        else
            l_ds.bank_back_reason := 'Причину відхилення не вказано';
        end if;
    end if;
    -- добавляем колонки в LCR
    l_target.add_column('old', 'DOC_ID',                sys.anydata.ConvertNumber   (l_ds.doc_id)               );
    l_target.add_column('new', 'STATUS_ID',             sys.anydata.ConvertNumber   (l_ds.status_id)            );
    l_target.add_column('new', 'STATUS_CHANGE_TIME',    sys.anydata.ConvertDate     (l_ds.status_change_time)   );
    l_target.add_column('new', 'BANK_ACCEPT_DATE',      sys.anydata.ConvertDate     (l_ds.bank_accept_date)     );
    l_target.add_column('new', 'BANK_REF',              sys.anydata.ConvertVarchar2 (l_ds.bank_ref)             );
    l_target.add_column('new', 'BANK_BACK_DATE',        sys.anydata.ConvertDate     (l_ds.bank_back_date)       );
    l_target.add_column('new', 'BANK_BACK_REASON',      sys.anydata.ConvertVarchar2 (l_ds.bank_back_reason)     );
    -- возвращаем объект
    return anydata.ConvertObject(l_target);
  end transform_zay;

  ---------------------------------------------------
  --
  -- zay_handler - обработчик для заявок на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure zay_handler(p_obj in sys.anydata)
  is
  begin
    --
    handler_sync(transform_zay(p_obj));
    --
  end zay_handler;

  ---------------------------------------------------
  --
  -- doccurexparams_handler - обработчик параметров на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure doccurexparams_handler(p_obj in sys.anydata)
  is
  begin
    --
    handler_sync(p_obj);
    --
  end doccurexparams_handler;

  ---------------------------------------------------
  --
  -- doccurexcustcomm_handler - обработчик параметров на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure doccurexcustcomm_handler(p_obj in sys.anydata)
  is
  begin
    --
    handler_sync(p_obj);
    --
  end doccurexcustcomm_handler;

  ---------------------------------------------------
  --
  -- doccurexexclusive_handler - обработчик параметров на покупку/продажу валюты
  --
  --  @p_obj - исходный LCR
  --
  procedure doccurexexclusive_handler(p_obj in sys.anydata)
  is
  begin
    --
    handler_sync(p_obj);
    --
  end doccurexexclusive_handler;


begin
	init;
end ibank_accounts;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/ibank_accounts.sql =========*** En
 PROMPT ===================================================================================== 
 