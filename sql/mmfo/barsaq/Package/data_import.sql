 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/data_import.sql =========*** Run *
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARSAQ.data_import is

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.32 15/07/2015';

  G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''
	||'KF - схема с полем ''kf''' || chr(10)
	||'ZAY - обработка заявок на покупку/продажу валюты' || chr(10)
  ;

  --
  -- Статуси документів
  --
  STATUS_SERR_BANK    constant number := -30; -- Системна помилка
  STATUS_RJCT_BANK    constant number := -20; -- Відхилений Банком
  STATUS_DELETED	  constant number := -10; -- Видалений
  STATUS_NEW	      constant number :=   0; -- Новий
  STATUS_VISA_REQ     constant number :=  10; -- Потребує візи
  STATUS_VISA_SET     constant number :=  20; -- Завізований
  STATUS_SEND_BANK    constant number :=  30; -- Відправлений в Банк
  STATUS_RESIGNED     constant number :=  35; -- Перепідписаний
  STATUS_RECV_BANK    constant number :=  40; -- Отриманий Банком
  STATUS_VISA_BANK    constant number :=  45; -- Очікує візи Банка
  STATUS_PAID_BANK    constant number :=  50; -- Проведений Банком
  STATUS_PROC_BANK    constant number :=  60; -- Оброблений Банком

    --
  -- Типи
  --
  type acc_t   is table of integer index by binary_integer;


  -- массив мфо для Ощадного банка
  type t_osch_mfo_list is table of smallint  index by varchar2(6);
  g_osch_mfo_list      t_osch_mfo_list;




  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  --  Преобразование кода TOBO в код BRANCH
  --
  function tobo_to_branch(p_kf in varchar2, p_tobo in varchar2) return varchar2;

  ----
  -- add_individual - добавляет клиента физлицо
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_individual(p_kf in varchar2, p_rnk in integer);

  ----
  -- add_company - добавляет клиента юрлицо
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_company(p_kf in varchar2, p_rnk in integer);

  ----
  -- add_client - добавляет клиента юрлицо
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_client(p_kf in varchar2, p_rnk in integer);

  ----
  -- reload_customers - загрузка клиентов
  --
  procedure reload_customers;

  ----
  -- reload_accounts - загрузка счетов
  --
  procedure reload_accounts;

  ----
  -- get_acc_type - возвращает тип счета по его балансовому
  --
  function get_acc_type(p_nbs in varchar2) return varchar2;

  ----
  -- add_account - добавляет счет в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account(p_acc in integer);

  ----
  -- add_account - добавляет счет в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей

  procedure add_account_new(p_acc in integer);

  ----
  -- add_account_and_sync - добавляет счет в систему и синхронизирует обороты и счета
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account_and_sync(p_acc in integer);

  ----
  -- add_account_and_sync2909 - добавляет неклиентский счет 2909 в систему для клиента и синхронизирует обороты и счета
  --
  -- @p_acc [in] - id счета в АБС
  -- @p_rnk [in] - id клиента в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account_and_sync2909(p_acc in integer, p_rnk in integer);

  ----
  -- add_account_and_sync_group - додає масив рахунків та синхронізує по них виписку
  --
  -- @p_acc [in] - масив id рахунків в АБС
  --
  procedure add_account_and_sync_group(p_acc in acc_t);

  ----
  -- import_cust_accounts_and_sync - Додає всі рахунки клієнта та виконує синхронізацію
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  --
  procedure import_cust_accounts_and_sync(p_kf in varchar2, p_rnk in integer);

  ----
  -- get_doc_xml - возвращает xml-представление документа из интернет-банкинга
  --               (путем вызова через dblink)
  -- @p_docid        - id документа
  --
  function get_doc_xml(p_docid in number) return xmltype;

  ----
  -- import_documents - выполняет импорт документов
  --
  procedure import_documents;

  ----
  -- import_documents - выполняет импорт документов по конкретному подразделению
  --
  -- @p_kf        - id документа
  --
  procedure import_documents_kf(p_kf  bars.mv_kf.kf%type);

  ----
  -- import_document - выполняет импорт 1-го документа
  -- @p_docid        - id документа
  --
  procedure import_document(p_docid in number);

  ----
  -- switch_logfile - выполняет переключение текущего лога
  --
  procedure switch_logfile;

  ----
  -- notify_ibank - уведомляет интернет-банкинг об оплате документов
  --
  procedure notify_ibank;

  ----
  -- notify_ibank - уведомляет интернет-банкинг об оплате документов
  -- p_kf
  --
  procedure notify_ibank_kf(p_kf  bars.mv_kf.kf%type);

  ----
  -- full_import - выполняет полный цикл по импорту документов
  --
  procedure full_import;

  ---------------------------------------------------------------------------------------
  --
  --  SYNC_* - procedures
  --
  ---------------------------------------------------------------------------------------

  ----
  -- sync_swift_banks - синхронизация swift_banks
  --
  procedure sync_swift_banks;

  ----
  -- sync_banks - синхронизация banks
  --
  procedure sync_banks;

  ----
  -- sync_holidays - синхронизация holidays
  --
  procedure sync_holidays(p_startdate in date default trunc(sysdate-1));

  ----
  -- sync_currency_rates - синхронизация cur_rates
  --
  procedure sync_currency_rates(p_startdate in date default trunc(sysdate-1));

  ----
  -- sync_account_stmt2 - синхронизирует историю движения по счетам
  -- @param p_acc - acc счета, null - по всем
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_account_stmt2(
    p_acc       in number default null,
    p_startdate in date default trunc(sysdate-1));

  ----
  -- sync_account_stmt - синхронизирует историю движения по счету
  --
  -- @p_acc [in] - id счета в АБС
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_account_stmt(p_acc in integer, p_startdate in date default trunc(sysdate-1));

  ----
  -- sync_account_period_stmt - синхронизирует историю движения по счету за период
  --
  -- @p_acc [in] - id счета в АБС
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  -- @param p_finishdate - банковская дата, конечная
  --
  procedure sync_account_period_stmt(p_acc in integer, p_startdate in date default trunc(sysdate-1), p_finishdate in date default trunc(sysdate));

  ----
  -- sync_account_stmt - синхронизирует историю движения по счету
  --
  -- @p_kf - код банка/филиала(МФО)
  -- @p_nls - номер лицевого счета
  -- @p_kv  - код валюты
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_account_stmt(
        p_kf  in varchar2,
        p_nls in varchar2,
        p_kv  in integer,
        p_startdate in date default trunc(sysdate-1));

  ----
  -- sync_all_account_stmt - синхронизирует историю движения по всем счетам
  --
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_all_account_stmt(p_startdate in date default trunc(sysdate-1));

  ----
  -- sync_bankdates - синхронизирует банковские даты
  --
  procedure sync_bankdates;

  ----
  -- sync_bankdates_job - синхронизирует банковские даты job-ом
  --
  procedure sync_bankdates_job;

  ----
  -- sync_branches - синхронизирует бранчи
  --
  procedure sync_branches;

  ----
  -- sync_streams_heartbeat - синхронизирует streams_heartbeat
  --
  procedure sync_streams_heartbeat;

  ----
  -- sync_doc_export - синхронизирует документы
  --
  procedure sync_doc_export(p_startdate in date default trunc(sysdate-1));

   ----
  -- sync_doc_export - синхронизирует зависшие документы
  --
  procedure sync_doc_export_open;

  ----
  -- sync_doc_export_mod - синхронизирует документы (модифицированнная версия)
  --
  procedure sync_doc_export_mod(p_startdate in date default trunc(sysdate-1));

  ---------------------------------------------------------------------------------------
  --
  --  JOB_SYNC_* - procedures
  --
  ---------------------------------------------------------------------------------------

  ----
  -- job_sync_doc_export - синхронизирует документы
  --
  procedure job_sync_doc_export(p_startdate in date default trunc(sysdate-1));

  ----
  -- job_sync_doc_export_mod - синхронизирует документы (модифицированная версия)
  --
  procedure job_sync_doc_export_mod(p_startdate in date default trunc(sysdate-1));

  ----
  -- job_sync_banks - синхронизация banks
  --
  procedure job_sync_banks;

  ----
  -- job_sync_swift_banks - синхронизация swift_banks
  --
  procedure job_sync_swift_banks;

  ----
  -- job_sync_branches - синхронизирует бранчи
  --
  procedure job_sync_branches;

  ----
  -- job_sync_streams_heartbeat - синхронизирует streams_heartbeat
  --
  procedure job_sync_streams_heartbeat;

  ----
  -- job_sync_bankdates - синхронизирует банковские даты
  --
  procedure job_sync_bankdates;

  ----
  -- job_sync_holidays - синхронизация holidays
  --
  procedure job_sync_holidays(p_startdate in date default trunc(sysdate-1));

  ----
  -- job_sync_currency_rates - синхронизация cur_rates
  --
  procedure job_sync_currency_rates(p_startdate in date default trunc(sysdate-1));

  ----
  -- job_sync_account_stmt - запускает процедуру sync_account_stmt в виде задания
  --
  -- @p_acc [in] - id счета в АБС
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure job_sync_account_stmt(p_acc in integer, p_startdate in date default trunc(sysdate-1));

  ----
  -- job_sync_account_stmt - запускает процедуру sync_account_stmt в виде задания
  --
  -- @p_kf  - код банка/филиала(МФО)
  -- @p_nls - номер лицевого счета
  -- @p_kv  - код валюты
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure job_sync_account_stmt(
        p_kf  in varchar2,
        p_nls in varchar2,
        p_kv  in integer,
        p_startdate in date default trunc(sysdate-1));

  ----
  -- job_sync_all_account_stmt - запускает процедуру sync_all_account_stmt в виде задания
  --
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure job_sync_all_account_stmt(p_startdate in date default trunc(sysdate-1));

  ----
  -- start_capture - запускає capture process
  --
  -- @param p_capture_name - ім'я capture process-у
  --
  procedure start_capture(p_capture_name in varchar2);

  ----
  -- stop_capture - зупиняє capture process
  --
  -- @param p_capture_name - ім'я capture process-у
  --
  procedure stop_capture(p_capture_name in varchar2);

  ----
  -- start_apply - запускає apply process
  --
  -- @param p_apply_name - ім'я apply process-у
  --
  procedure start_apply(p_apply_name in varchar2);

  ----
  -- stop_apply - зупиняє apply process
  --
  -- @param p_apply_name - ім'я apply process-у
  --
  procedure stop_apply(p_apply_name in varchar2);

  ----
  -- migrate_offline - переводит офлайновых клиентов в онлайновые, а также их счета
  --
  procedure migrate_offline;

  ----
  -- migrate_offline_aux - переводит офлайновых клиентов в онлайновые, а также их счета
  --                       для конкретного кода банка
  --
  procedure migrate_offline_aux(p_bankid in varchar2);

  ----
  -- sync_cust_address - синхронізація адрес контрагентів
  --
  procedure sync_cust_address;

  ----
  -- job_sync_cust_address - job для синхронізація адрес контрагентів
  --
  procedure job_sync_cust_address;


  --
  -- sync_contracts - синхронизирует импортно/экспортные контракты клиента
  --
  procedure sync_contracts(p_kf in varchar2, p_rnk in integer);

  --
  -- sync_contracts - синхронизирует импортно/экспортные контракты клиента
  --
  procedure sync_all_contracts;

  ----
  -- sync_exchange_params - синхронизация exchange_params
  --
  procedure sync_exchange_params;

  ----
  -- job_sync_exchange_params - синхронизация exchange_params
  --
  procedure job_sync_exchange_params;

  ----
  -- sync_curexch_params - синхронізація параметрів купівлі/продажу валют
  --
  procedure sync_curexch_params;

  ----
  -- job_sync_curexch_params - синхронізація параметрів купівлі/продажу валют
  --
  procedure job_sync_curexch_params;

  ----
  -- sync_curexch_custcomm - синхронізація параметрів купівлі/продажу валют
  --
  procedure sync_curexch_custcomm;

  ----
  -- job_sync_curexch_custcomm - синхронізація параметрів купівлі/продажу валют
  --
  procedure job_sync_curexch_custcomm;

  ----
  -- sync_curexch_exclusive - синхронізація параметрів купівлі/продажу валют
  --
  procedure sync_curexch_exclusive;

  ----
  -- job_sync_curexch_exclusive - синхронізація параметрів купівлі/продажу валют
  --
  procedure job_sync_curexch_exclusive;


  ----
  -- sync_customers - синхронизация клиентов
  --
  procedure sync_customers;

  ----
  -- sync_customers - синхронизация клиентов
  --
  procedure job_sync_customers;

  ----
  -- sync_acctariffs - Синхронизация тарифов между схемами BANK -> CORE
  --
  procedure sync_acctariffs;

procedure sync_acc_transactions2_TEST(
    p_startdate in date    default null,
    p_scn       in number  default null);
  ----
  -- sync_acctariffs - синхронизация клиентов
  --
  procedure job_sync_acctariffs;

end data_import;
/
CREATE OR REPLACE PACKAGE BODY barsaq.data_import is

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.98 07/06/2018';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''
    ||'KF - схема с полем ''kf''' || chr(10)
    ||'GOU - ГОУ Ощадбанка' || chr(10)
    ||'ZAY - обработка заявок на покупку/продажу валюты' || chr(10)
  ;

  G_PACKAGE_NAME      constant varchar2(30) := 'DATA_IMPORT';
  -- маска формата для преобразования char <--> number
  g_number_format     constant varchar2(128) := 'FM999999999999999999999999999999.9999999999999999999999999999999';
  -- параметры преобразования char <--> number
  g_number_nlsparam   constant varchar2(30)  := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  -- маска формата для преобразования char <--> date
  g_date_format       constant varchar2(30)  := 'YYYY.MM.DD HH24:MI:SS';
  ------------------------------------------------------------------------------
  --
  g_sync_tag          constant raw(1) := hextoraw('01');
  -- виды документов
  g_vob_national      constant integer := 1;  -- Гривневое платежное поручение
  g_vob_foreign       constant integer := 20; -- Загран перевод клиента

  -- делитель для национальной валюты
  g_base_val      constant bars.tabval.kv%type    := 980;
  g_base_denom    constant number(4)              := 100;

  --
  CB_APPLY          constant sys.dba_apply.apply_name%type        := 'CB_APPLY';
  CB_CAPTURE        constant sys.dba_capture.capture_name%type    := 'CB_CAPTURE';

  G_STREAM_ENABLED   constant sys.dba_apply.status%type := 'ENABLED';
  G_STREAM_DISABLED  constant sys.dba_apply.status%type := 'DISABLED';

  JOB_STATUS_ENQUEUED       constant varchar2(30) := 'ENQUEUED';
  JOB_STATUS_STARTED        constant varchar2(30) := 'STARTED';
  JOB_STATUS_INPROGRESS     constant varchar2(30) := 'IN PROGRESS';
  JOB_STATUS_SUCCEEDED      constant varchar2(30) := 'SUCCEEDED';
  JOB_STATUS_FAILED         constant varchar2(30) := 'FAILED';

  -- source tables for capture process
  SRCTAB_BANKS              constant varchar2(61) := 'BARS.BANKS$BASE';
  SRCTAB_PARAMS             constant varchar2(61) := 'BARS.PARAMS$BASE';
  SRCTAB_CUR_RATES          constant varchar2(61) := 'BARS.CUR_RATES$BASE';
  SRCTAB_BRANCH             constant varchar2(61) := 'BARS.BRANCH';
  SRCTAB_SW_BANKS           constant varchar2(61) := 'BARS.SW_BANKS';
  SRCTAB_HOLIDAY            constant varchar2(61) := 'BARS.HOLIDAY';
  SRCTAB_SALDOA             constant varchar2(61) := 'BARS.SALDOA';
  SRCTAB_OPLDOK             constant varchar2(61) := 'BARS.OPLDOK';
  SRCTAB_SOS_TRACK          constant varchar2(61) := 'BARS.SOS_TRACK';
  SRCTAB_ZAY_TRACK          constant varchar2(61) := 'BARS.ZAY_TRACK';
  SRCTAB_BIRJA              constant varchar2(61) := 'BARS.BIRJA';
  SRCTAB_CUSTZAY            constant varchar2(61) := 'BARS.CUST_ZAY';
  SRCTAB_ZAYCOMISS          constant varchar2(61) := 'BARS.ZAY_COMISS';
  SRCTAB_STREAMS_HEARTBEAT  constant varchar2(61) := 'BARS.STREAMS_HEARTBEAT';
  SRCTAB_CUST_ADDRESSES     constant varchar2(61) := 'BARS.CUSTOMER_ADDRESS';
  SYNC_SCHEMA               constant varchar2(30) := 'BARSAQ';
  -- target tables for apply process
  TAB_BANKS                 constant varchar2(30) := 'BANKS';
  TAB_SWIFT_BANKS           constant varchar2(30) := 'SWIFT_BANKS';
  TAB_BRANCHES              constant varchar2(30) := 'BRANCHES';
  TAB_BANKDATES             constant varchar2(30) := 'BANKDATES';
  TAB_CURRENCY_RATES        constant varchar2(30) := 'CURRENCY_RATES';
  TAB_HOLIDAYS              constant varchar2(30) := 'HOLIDAYS';
  TAB_ACC_TURNOVERS         constant varchar2(30) := 'ACC_TURNOVERS';
  TAB_ACC_TRANSACTIONS      constant varchar2(30) := 'ACC_TRANSACTIONS';
  TAB_DOC_EXPORT            constant varchar2(30) := 'DOC_EXPORT';
  TAB_EXCHANGE_PARAMS       constant varchar2(30) := 'EXCHANGE_PARAMS';
  TAB_DOC_CUREX_PARAMS      constant varchar2(30) := 'DOC_CUREX_PARAMS';
  TAB_DOC_CUREX_CUSTCOMMISSIONS    constant varchar2(30) := 'DOC_CUREX_CUSTCOMMISSIONS';
  TAB_DOC_CUREX_EXCLUSIVE          constant varchar2(30) := 'DOC_CUREX_EXCLUSIVE';
  TAB_CUST_ADDRESSES             constant varchar2(30) := 'CUST_ADDRESSES';
  TAB_STREAMS_HEARTBEAT     constant varchar2(30) := 'STREAMS_HEARTBEAT';
  TAB_CUSTOMERS             constant varchar2(30) := 'CUSTOMERS';
  TAB_ACCOUNT_TARIFF           constant varchar2(30) := 'ACCOUNT_TARIFF';


  --
  g_global_name       varchar2(128);

  g_syncadm           varchar2(256);

  -- параметры для свифтовых операций
  g_c2sw_bnk      varchar2(6);  -- 'C2SW.BNK', '300465', 'corp2 SWIFT МФО головного Банку'
  g_c2sw_nls      varchar2(14); -- 'C2SW.NLS', '191992', 'corp2 SWIFT Транзитний рахунок'
  g_c2sw_nam      varchar2(38); -- 'C2SW.NAM', 'Транзит для закордонних переказiв', 'corp2 SWIFT Назва транзитного рахунку'
  g_c2sw_cod      varchar2(14); -- 'C2SW.COD', '00032129', 'corp2 SWIFT ЗКПО головного Банку'

  -- sid и serial# собственной сессии
  g_own_sid       number;
  g_own_serial#   number;

  g_sync_job_timeout    integer;    -- Максимальное время работы задания по синхронизации таблиц в минутах

  g_docs_count integer;  -- К-во документов для импорта (за одну итерацию full_import)
  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header DATA_IMPORT '||G_HEADER_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_HEADER_DEFS;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body DATA_IMPORT '||G_BODY_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_BODY_DEFS;
  end body_version;

  ----
  -- get_error_msg - возвращает описание ошибки со стеком
  --
  function get_error_msg
    return varchar2
  is
  begin
    return dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace();
  end get_error_msg;

  procedure check_package_state is
  begin
    if rawtohex(g_sync_tag)<>'01' then
        raise_application_error(-20000, 'Переменная ''g_sync_tag'' не инициализирована', true);
    end if;
  end check_package_state;

  ----
  -- write_sync_status - запись статуса синхронизации
  --
  procedure write_sync_status(
    p_table_name        in sync_activity.table_name%type,
    p_status            in sync_activity.status%type,
    p_status_comment    in sync_activity.status_comment%type default null,
    p_error_number      in sync_activity.error_number%type   default null,
    p_error_message     in sync_activity.error_message%type  default null,
    p_in_parallel       in boolean default false
    )
  is
  pragma autonomous_transaction;
    l_info     sync_activity%rowtype;
    l_num       number;
    p   varchar2(61) := 'data_import.write_sync_status';
  --
  procedure remove_job(p_job in binary_integer, p_table_name in varchar2)
  is
  pragma autonomous_transaction;
  begin
    dbms_job.remove(l_info.job_id);
    commit;
    logger.warning('Удалено задание синхронизации таблицы '||p_table_name
    ||'. Истекло '||to_char(g_sync_job_timeout)||' минут с момента старта.');
  exception
      when others then
          logger.error(p||': ошибка удаления задания синхронизации таблицы '||p_table_name||': '
          ||dbms_utility.format_error_stack()
          );
  end remove_job;
  --
  procedure disconnect_session(p_sid number, p_serial# number, p_table_name varchar2)
  is
  pragma autonomous_transaction;
  begin
      execute immediate 'alter system disconnect session '''||to_char(p_sid)||', '||to_char(p_serial#)||''' immediate';
      logger.warning('Удалена сессия синхронизации таблицы '||p_table_name
    ||'. Истекло '||to_char(g_sync_job_timeout)||' минут с момента старта.');
  exception
      when others then
          logger.error(p||': ошибка удаления сессии, sid='||to_char(p_sid)||', serial#='||to_char(p_serial#)
          ||dbms_utility.format_error_stack()
          );
  end disconnect_session;
  --
  begin
    -- при необходимости инициализируем sid и serial# для своей сессии
    if g_own_sid is null or g_own_serial# is null
    then
        select sid
          into g_own_sid
          from v$mystat
         where rownum=1;
        --
        select serial#
          into g_own_serial#
          from v$session
         where sid = g_own_sid;
    end if;
    if logger.trace_enabled()
    then
        logger.trace('%s: own_sid=%s, own_serial#=%s', p, to_char(g_own_sid), to_char(g_own_serial#));
    end if;
    --
    begin
        select *
          into l_info
          from sync_activity
         where table_name = p_table_name
        for update nowait;
        -- если задание не в финальном статусе, проверим, жива ли сессия
        if l_info.status not in (JOB_STATUS_SUCCEEDED, JOB_STATUS_FAILED)
        then
            begin
                select 1
                  into l_num
                  from v$session
                 where sid = l_info.sid
                   and serial# = l_info.serial#;
                --
                -- свою сессию не трогаем, по таймауту отбиваем только чужие сессии
                --
                if not (l_info.sid=g_own_sid and l_info.serial#=g_own_serial#)
                then
                    -- сессия существует, посмотрим как долго она уже работает
                    if g_sync_job_timeout is null
                    then
                        -- читаем значение макс. времени работы задания
                        begin
                            select param_value
                              into g_sync_job_timeout
                              from sync_parameters
                             where param_name = 'SYNC_JOB_TIMEOUT';
                             --
                             logger.trace('%s: SYNC_JOB_TIMEOUT=%s(user-defined value)', p, to_char(g_sync_job_timeout));
                        exception
                            when no_data_found then
                                g_sync_job_timeout := 20; -- по-умолчанию 20 минут
                                logger.trace('%s: SYNC_JOB_TIMEOUT=%s(default value)', p, to_char(g_sync_job_timeout));
                        end;
                    else
                        if logger.trace_enabled()
                        then
                            logger.trace('%s: SYNC_JOB_TIMEOUT=%s', p, to_char(g_sync_job_timeout));
                        end if;
                    end if;
                    --
                    if (sysdate-l_info.start_time)*24*60 > g_sync_job_timeout
                    then
                        -- время работы задания превышено, убиваем его
                        if l_info.job_id is not null
                        then
                            remove_job(l_info.job_id, l_info.table_name);
                        end if;
                        -- также убиваем работающую сессию
                        disconnect_session(l_info.sid, l_info.serial#, l_info.table_name);
                        -- меняем статус удаленному заданию
                        update sync_activity
                           set status           = JOB_STATUS_FAILED,
                               status_comment   = 'Сесія знищена(killed) за таймаутом '||g_sync_job_timeout||' хвилин',
                               start_time       = start_time,
                               finish_time      = sysdate,
                               error_number     = -7777,
                               error_message    = 'Сесія знищена(killed) за таймаутом '||g_sync_job_timeout||' хвилин'
                         where table_name = p_table_name
                         returning table_name, status, status_comment, start_time, finish_time, error_number,
                                   error_message, job_id, sid, serial#
                              into l_info;
                         --
                         if logger.trace_enabled()
                         then
                            logger.trace('%s: job killed by timeout, table %s', p, p_table_name);
                         end if;
                     end if;
                end if;
            exception
                when no_data_found then
                    -- если сессия, заблокировавшая таблицу, уже не существует, снимаем блокировку
                    update sync_activity
                       set status           = JOB_STATUS_FAILED,
                           status_comment   = 'Сесія завдання вже не існує',
                           start_time       = start_time,
                           finish_time      = sysdate,
                           error_number     = -9999,
                           error_message    = 'Сесія завдання вже не існує'
                     where table_name = p_table_name
                     returning table_name, status, status_comment, start_time, finish_time, error_number,
                               error_message, job_id, sid, serial#
                          into l_info;
                     --
                     if logger.trace_enabled()
                     then
                        logger.trace('%s: orphan lock released, table %s', p, p_table_name);
                     end if;
            end;
        end if;
        --
        -- если параллельный запуск запрещен
        if not p_in_parallel
        then
            -- то статусы должны меняться в правильном порядке
            if p_status=JOB_STATUS_ENQUEUED and l_info.status not in (JOB_STATUS_SUCCEEDED, JOB_STATUS_FAILED)
            then
                raise_application_error(-20000,
                'Синхронізація таблиці '||p_table_name||' виконується вже '
                ||to_char(trunc((sysdate-l_info.start_time)*24*60))||' хв. '
                ||to_char(trunc((sysdate-l_info.start_time)*24*60*60)-trunc((sysdate-l_info.start_time)*24*60)*60)||' сек.'
                ||' Повторний запуск заборонено.'
                );
            end if;
        end if;
        --
        update sync_activity
           set status           = p_status,
               status_comment   = case
                                    when p_status = JOB_STATUS_ENQUEUED
                                    then
                                        nvl(p_status_comment,'В черзі на виконання')
                                    else
                                        p_status_comment
                                  end,
               start_time       = case
                                    when p_status in (JOB_STATUS_ENQUEUED, JOB_STATUS_STARTED)
                                    then
                                        sysdate
                                    else
                                        start_time
                                  end,
               finish_time      = case
                                    when p_status in (JOB_STATUS_SUCCEEDED, JOB_STATUS_FAILED)
                                      then
                                          sysdate
                                      else
                                          null
                                  end,
               error_number     = p_error_number,
               error_message    = substr(p_error_message,1,4000),
               job_id           = to_number(sys_context('userenv', 'bg_job_id')),
               sid              = g_own_sid,
               serial#          = g_own_serial#
         where table_name = p_table_name;
        --
    exception
        when no_data_found then
            if p_status<>JOB_STATUS_ENQUEUED
            then
                raise_application_error(-20000, 'Запис статусу синхронізації неможливий. Зверніться до розробника.');
            end if;
            insert
              into sync_activity(
                    table_name, status, status_comment,
                    start_time, finish_time, error_number, error_message, job_id, sid, serial#)
            values (p_table_name, p_status, nvl(p_status_comment,'В черзі на виконання'),
                    sysdate, null, p_error_number, substr(p_error_message,1,4000),
                    to_number(sys_context('userenv', 'bg_job_id')), g_own_sid, g_own_serial#
                   );
    end;
    --
    commit;
    --
    if p_status=JOB_STATUS_FAILED
    then
        bars.bars_audit.error('Синхронізація таблиці '||p_table_name||'. Статус: '||p_status||'. '
            ||'Помилка: '||substr(p_error_message,1,3900)||'.');
    else
        bars.bars_audit.info('Синхронізація таблиці '||p_table_name||'. Статус: '||p_status||'.');
    end if;
  end;

  ----
  -- check_requirements - проверяет остановлен ли процесс CB_APPLY
  -- если нет, выбрасывает ошибку
  --
  procedure check_requirements(p_table in varchar2, p_check_capture in boolean default false)
  is
    l_status    varchar2(30);
  begin
    return; -- 31.05.2017  на время
    begin
        select status
          into l_status
          from dba_apply
         where apply_name=CB_APPLY;
        if l_status = G_STREAM_ENABLED
        then
            raise_application_error(-20000, 'Для виконання ручної синхронізації процес '||CB_APPLY||' повинен бути зупинений', true);
        end if;
    exception
        when no_data_found then
            null; -- не обижаемся если apply-процесс отсутсвует
    end;
    if p_check_capture
    then
        begin
            select status
              into l_status
              from dba_capture
             where capture_name=CB_CAPTURE;
            if l_status = G_STREAM_ENABLED
            then
                raise_application_error(-20000, 'Для виконання ручної синхронізації даних таблиці '||p_table
                ||' процес '||CB_CAPTURE||' повинен бути зупинений', true);
            end if;
        exception
            when no_data_found then
                null; -- не обижаемся если capture-процесс отсутсвует
        end;
    end if;
  end check_requirements;

  ----
  -- replace_tags - заменяем таги сессии на новые для синхронизации
  --                возвращает старые таги
  --
  procedure replace_tags(p_local_tag out raw, p_remote_tag out raw)
  is
  begin
    -- устанавливаем специальный таг локально, чтобы стримсы не читали изменяемые таблицы
    p_local_tag := bars_sync.get_tag(); bars_sync.set_tag(g_sync_tag);
    -- устанавливаем специальный таг удаленно, чтобы стримсы не читали изменяемые таблицы
    p_remote_tag := rpc_sync.get_tag(); rpc_sync.set_tag(g_sync_tag);
    -- переводим ограничения целостности в режим отложенной проверки
    rpc_sync.set_constraints_deferred();
    --
  end replace_tags;

  ----
  -- restore_tags - восстанавливает таги для сессии
  --
  procedure restore_tags(p_local_tag in raw, p_remote_tag in raw)
  is
  begin
    -- восстанавливаем таг локально
    bars_sync.set_tag(p_local_tag);
    -- восстанавливаем таг удаленно
    rpc_sync.set_tag(p_remote_tag);
    -- переводим удаленные ограничения целостности в режим немедленной проверки
    rpc_sync.set_constraints_immediate();
    --
  exception when others then
    --
    bars.bars_audit.error(get_error_msg());
    --
  end restore_tags;

  ----
  -- get_customer_attr - возвращает атрибут клиента из bars.customerw
  --
  function get_customer_attr(p_rnk in integer, p_tag in varchar2) return varchar2 is
        l_value varchar2(4000);
  begin
      select value into l_value from bars.customerw where rnk=p_rnk and tag=p_tag;
      return l_value;
  exception when no_data_found then
      return null;
  end get_customer_attr;

  ----
  -- get_customer - возвращает строку для core.customers
  --
  function get_customer(p_kf in varchar2, p_rnk in integer) return customers%rowtype is
      l_customer  customers%rowtype;
  begin
    begin
        select
            p_kf   bank_id,
            rnk,
            custtype         type_id,
            trim(nmk)             name,
            nvl(nmkv,substr(nmk,1,70))                 english_name,
            nvl(substr(nmkk,1,35),substr(nmk,1,35)) short_name,
            okpo            cust_code,
            nvl(tgr,decode(custtype,1,2,1)) prt_id,
            country         country_id,
            codcagent       cov_id,
            prinsider       insider_id,
            trunc(date_on)  opened,
            trunc(date_off) closed,
            null            notes,
            null            cust_limit
        into l_customer.bank_id,
              l_customer.rnk,
              l_customer.type_id,
              l_customer.name,
              l_customer.english_name,
              l_customer.short_name,
              l_customer.cust_code,
              l_customer.prt_id,
              l_customer.country_id,
              l_customer.cov_id,
              l_customer.insider_id,
              l_customer.opened,
              l_customer.closed,
              l_customer.notes,
              l_customer.cust_limit
        from bars.customer where rnk=p_rnk;

        l_customer.russian_name := substr(get_customer_attr(p_rnk, 'SW_RN'),1,70);

        if l_customer.type_id is null then
            raise_application_error(-20000, 'Тип клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.name is null then
            raise_application_error(-20000, 'Найменування клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.english_name is null then
            raise_application_error(-20000, 'Найменування клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.short_name is null then
            raise_application_error(-20000, 'Коротке найменування клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.cust_code is null then
            raise_application_error(-20000, 'Ідентифікаційний код клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.prt_id is null then
            raise_application_error(-20000, 'Тип державного реєстру клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.country_id is null then
            raise_application_error(-20000, 'Код країни клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.cov_id is null then
            raise_application_error(-20000, 'Код характеристики контрагента клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.insider_id is null then
            raise_application_error(-20000, 'Код інсайдера клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;
        if l_customer.opened is null then
            raise_application_error(-20000, 'Дата відкриття клієнта(customer) не знайдено. RNK='||p_rnk, true);
        end if;

    exception when no_data_found then
        raise_application_error(-20000, 'Клієнта(customer) не знайдено. RNK='||p_rnk, true);
    end;
    return l_customer;
  end get_customer;

  ----
  -- get_customer_address - возвращает строку для core.cust_addresses
  --
  function get_customer_address(p_rnk in integer) return cust_addresses%rowtype is
      l_customer_address  cust_addresses%rowtype;
  begin
    begin
        select
           null rnk,
           1 type_id,
           c.country country_id,
           (select substr(value,1,20) from bars.customerw where rnk=c.rnk and tag='FGIDX') zip,
           (select substr(value,1,30) from bars.customerw where rnk=c.rnk and tag='FGOBL') region,
           (select substr(value,1,30) from bars.customerw where rnk=c.rnk and tag='FGDST') district,
           (select substr(value,1,30) from bars.customerw where rnk=c.rnk and tag='FGTWN') city,
           (select substr(value,1,100) from bars.customerw where rnk=c.rnk and tag='FGADR') address,
           (select val from bars.params where par = 'GLB-MFO') bank_id
        into l_customer_address
        from bars.customer c where c.rnk=p_rnk;

    exception when no_data_found then
        raise_application_error(-20000, 'Клієнта(customer) не знайдено. RNK='||p_rnk, true);
    end;
    return l_customer_address;
  end get_customer_address;

  ----
  -- get_individual - возвращает строку для core.cust_individuals
  --
  function get_individual(p_kf in varchar2, p_rnk in integer) return cust_individuals%rowtype is
      l_individual      cust_individuals%rowtype;
  begin
    begin
        select
            p_kf        bank_id,
            rnk,
            passp            id_id,
            ser             id_serial,
            numdoc            id_number,
            pdate            id_date,
            substr(organ,1,70) id_issuer,
            bday            birthday,
            bplace            birthplace,
            teld            phone_home,
            telw            phone_work,
            null            phone_mobile,
            null            email,
            actual_date        id_date_valid
        into l_individual.bank_id,
            l_individual.rnk,
            l_individual.id_id,
            l_individual.id_serial,
            l_individual.id_number,
            l_individual.id_date,
            l_individual.id_issuer,
            l_individual.birthday,
            l_individual.birthplace,
            l_individual.phone_home,
            l_individual.phone_work,
            l_individual.phone_mobile,
            l_individual.email,
            l_individual.id_date_valid
        from bars.person where rnk=p_rnk;
    exception when no_data_found then
        raise_application_error(-20000, 'Клієнта(person) не знайдено. RNK='||p_rnk, true);
    end;
    -- отдельно читаем e-mail
    l_individual.email := substr(get_customer_attr(p_rnk, 'EMAIL'),1,128);

    if l_individual.id_id is null then
        raise_application_error(-20000, 'Код документа клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_individual.id_serial is null and l_individual.id_id <> 7 then
        raise_application_error(-20000, 'Серія документа клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_individual.id_number is null then
        raise_application_error(-20000, 'Номер документа клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_individual.id_date is null then
        raise_application_error(-20000, 'Дата документа клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_individual.id_issuer is null then
        raise_application_error(-20000, 'Ким виданий документ клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_individual.birthday is null then
        raise_application_error(-20000, 'Дата народження клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_individual.birthplace is null then
        raise_application_error(-20000, 'Місце народження клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_individual.id_date_valid is null and l_individual.id_id = 7 then
        raise_application_error(-20000, 'Термін дії документу клієнта(person) не знайдено. RNK='||p_rnk, true);
    end if;

    --
    return l_individual;
  end get_individual;

  ----
  -- get_company - возвращает строку для core.cust_companies
  --
  function get_company(p_kf in varchar2, p_rnk in integer) return cust_companies%rowtype is
      l_company          cust_companies%rowtype;
  begin
    begin
        select
            p_kf    bank_id,
            rnk,
            nvl(nmku,'пусто')    article_name,
            nvl(ruk, 'пусто')    head_name,
            nvl(telr,'пусто')    head_phone,
            buh            accountant_name,
            telb        accountant_phone,
            tel_fax        fax,
            null        email
        into l_company.bank_id,
            l_company.rnk,
            l_company.article_name,
            l_company.head_name,
            l_company.head_phone,
            l_company.accountant_name,
            l_company.accountant_phone,
            l_company.fax,
            l_company.email
        from bars.corps where rnk=p_rnk;
    exception when no_data_found then
        --raise_application_error(-20000, 'Клієнта(corps) не знайдено. RNK='||p_rnk, true);
        -- вместо исключения формируем пустую запись
        l_company.bank_id           := p_kf;
        l_company.rnk                 := p_rnk;
        l_company.article_name      := 'пусто';
        l_company.head_name         := 'пусто';
        l_company.head_phone        := 'пусто';
        l_company.accountant_name   := null;
        l_company.accountant_phone  := null;
        l_company.fax               := null;
    end;

    -- отдельно читаем e-mail
    l_company.email := substr(get_customer_attr(p_rnk, 'EMAIL'),1,128);

    if l_company.article_name is null then
        raise_application_error(-20000, 'Найменування по уставу клієнта(corps) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_company.head_name is null then
        raise_application_error(-20000, 'Ім''я керівника клієнта(corps) не знайдено. RNK='||p_rnk, true);
    end if;
    if l_company.head_phone is null then
        raise_application_error(-20000, 'Телефон керівника клієнта(corps) не знайдено. RNK='||p_rnk, true);
    end if;

    return l_company;
  end get_company;

  function get_origin_rnk(p_rnk in number) return number is
  begin
    return round(p_rnk / 100, 0);
  end;
  ----
  -- add_individual_int - добавляет клиента физлицо
  --
  -- @p_kf [in] - код банка клиента
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_individual_int(p_kf in varchar2, p_rnk in integer) is
    l_customer      customers%rowtype;
    l_individual    cust_individuals%rowtype;
  begin
    --
    savepoint sp;
    --
    rpc_sync.set_constraints_deferred();
    --
    -- получаем данные из АБС
    l_customer    := get_customer(p_kf, p_rnk);
    l_individual  := get_individual(p_kf, p_rnk);
    --
    -- сохраняем запись в ibank_rnk пока для совместимости
    insert
      into ibank_rnk(kf, rnk)
    values (p_kf, p_rnk);
    -- сохраняем данные локально
    insert
      into customers
    values l_customer;
    insert
      into cust_individuals
    values l_individual;
    -- сохраняем данные в IBANK

    -- убираем "хвост" RNK (два последних символа)
    l_customer.rnk := get_origin_rnk(l_customer.rnk);
    rpc_sync.add_customer(l_customer);
    l_individual.rnk := l_customer.rnk;
    rpc_sync.add_individual(l_individual);
    -- синхронизируем схемы BANK и CORE в IBANK
    rpc_sync.sync_customer(p_kf, l_customer.rnk);
    rpc_sync.sync_individual(p_kf, l_customer.rnk);
    --
    rpc_sync.set_constraints_immediate();
    --
  exception
    when others then
        --
        rollback to sp;
        --
        rpc_sync.set_constraints_immediate();
        --
        raise_application_error(-20000, get_error_msg());
        --
  end add_individual_int;

  ----
  -- add_company_int - добавляет клиента юрлицо
  --
  -- @p_kf [in] - код банка клиента
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_company_int(p_kf in varchar2, p_rnk in integer) is
    l_customer      customers%rowtype;
    l_company       cust_companies%rowtype;
  begin
    --
    savepoint sp;
    --
    rpc_sync.set_constraints_deferred();
    --
    -- получаем данные из АБС
    l_customer         := get_customer(p_kf, p_rnk);
    l_company        := get_company(p_kf, p_rnk);
    -- сохраняем запись в ibank_rnk пока для совместимости
    insert
      into ibank_rnk(kf, rnk)
    values (p_kf, p_rnk);
    -- сохраняем данные локально
    insert
      into customers
    values l_customer;
    insert
      into cust_companies
    values l_company;
    -- сохраняем данные в IBANK

    -- убираем "хвост" RNK (два последних символа)
    l_customer.rnk := get_origin_rnk(l_customer.rnk);
    rpc_sync.add_customer(l_customer);
    l_company.rnk := l_customer.rnk;
    rpc_sync.add_company(l_company);
    -- синхронизируем схемы BANK и CORE в IBANK
    rpc_sync.sync_customer(p_kf, l_company.rnk);
    rpc_sync.sync_company(p_kf, l_company.rnk);
    --
    rpc_sync.set_constraints_immediate();
    --
  exception
    when others then
        --
        rollback to sp;
        --
        rpc_sync.set_constraints_immediate();
        --
        raise_application_error(-20000, get_error_msg());
        --
  end add_company_int;

  ----
  -- add_individual - добавляет клиента физлицо
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_individual(p_kf in varchar2, p_rnk in integer)
  is
  begin
    add_individual_int(p_kf, p_rnk);
    --
    commit;
    --
  end add_individual;

  ----
  -- add_company - добавляет клиента юрлицо
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_company(p_kf in varchar2, p_rnk in integer)
  is
  begin
    add_company_int(p_kf, p_rnk);
    --
    commit;
    --
  end add_company;

  ----
  -- add_client - добавляет клиента юрлицо
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  -- работа по RNK позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_client(p_kf in varchar2, p_rnk in integer)
  is
    l_custtype bars.customer.custtype%type;
  begin
    if (barsaq.ibank_accounts.is_cust_subscribed(p_rnk) = 0) then
      select c.custtype
        into l_custtype
        from bars.customer c
       where c.rnk = p_rnk
         and c.kf = p_kf;
      if (l_custtype = 2) then
        add_company( p_kf, p_rnk);
      elsif (l_custtype = 3) then
        add_individual( p_kf, p_rnk);
      end if;
    end if;
    --
    commit;
    --
  end add_client;

  ----
  -- sync_customers - синхронизация клиентов
  --
  procedure sync_customers
  is
    c  customers%rowtype;
    f  cust_individuals%rowtype;
    u  cust_companies%rowtype;
  begin
    -- тупо идем по таблице и построчно модифицируем
    for t in (select * from customers)
    loop
        c := get_customer(t.bank_id, t.rnk);
        if t.type_id <> c.type_id
        or t.name <> c.name
        or t.english_name <> c.english_name
        or t.short_name <> c.short_name
        or nvl(t.russian_name,'n/a') <> nvl(c.russian_name,'n/a')
        or t.cust_code <> c.cust_code
        or t.prt_id <> c.prt_id
        or t.country_id <> c.country_id
        or t.cov_id <> c.cov_id
        or t.insider_id <> c.insider_id
        or t.opened <> c.opened
        or t.closed <> c.closed
        or nvl(t.notes,'null') <> nvl(c.notes,'null')
        or nvl(t.cust_limit,0) <> nvl(c.cust_limit,0)
        then
            update customers
               set type_id = c.type_id,
                   name = c.name,
                   english_name = c.english_name,
                   short_name = c.short_name,
                   russian_name = c.russian_name,
                   cust_code = c.cust_code,
                   prt_id = c.prt_id,
                   country_id = c.country_id,
                   cov_id = c.cov_id,
                   insider_id = c.insider_id,
                   opened = c.opened,
                   closed = c.closed,
                   notes = c.notes,
                   cust_limit = c.cust_limit
             where rnk = t.rnk
               and bank_id = t.bank_id;
            --
            c.rnk := get_origin_rnk(c.rnk);
            rpc_sync.update_customer(c);
        end if;
    end loop;
    --
    for t in (select * from cust_individuals)
    loop
        f := get_individual(t.bank_id, t.rnk);
        --
        if  t.id_id <> f.id_id
        or  nvl(t.id_serial,'null') <> nvl(f.id_serial,'null')
        or  t.id_number <> f.id_number
        or  t.id_date <> f.id_date
        or  t.id_issuer <> f.id_issuer
        or  t.birthday <> f.birthday
        or  t.birthplace <> f.birthplace
        or  nvl(t.phone_home,'null') <> nvl(f.phone_home,'null')
        or  nvl(t.phone_work,'null') <> nvl(f.phone_work,'null')
        or  nvl(t.phone_mobile,'null') <> nvl(f.phone_mobile,'null')
        or  nvl(t.email,'null') <> nvl(f.email,'null')
        or  nvl(t.id_date_valid,to_date('01.01.1900','dd.mm.yyyy')) <> nvl(f.id_date_valid,to_date('01.01.1900','dd.mm.yyyy'))
        then
            update cust_individuals
               set id_id = f.id_id,
                   id_serial = f.id_serial,
                   id_number = f.id_number,
                   id_date = f.id_date,
                   id_issuer = f.id_issuer,
                   birthday = f.birthday,
                   birthplace = f.birthplace,
                   phone_home = f.phone_home,
                   phone_work = f.phone_work,
                   phone_mobile = f.phone_mobile,
                   email = f.email,
                   id_date_valid = f.id_date_valid
             where rnk = t.rnk
               and bank_id = t.bank_id;
            --
            f.rnk := get_origin_rnk(f.rnk);
            rpc_sync.update_individual(f);
        end if;
    end loop;
    --
    for t in (select * from cust_companies)
    loop
        u := get_company(t.bank_id, t.rnk);
        --
        if  t.article_name <> u.article_name
        or  t.head_name <> u.head_name
        or  t.head_phone <> u.head_phone
        or  nvl(t.accountant_name,'null') <> nvl(u.accountant_name,'null')
        or  nvl(t.accountant_phone,'null') <> nvl(u.accountant_phone,'null')
        or  nvl(t.fax,'null') <> nvl(u.fax,'null')
        or  nvl(t.email,'null') <> nvl(u.email,'null')
        then
            update cust_companies
               set article_name = u.article_name,
                   head_name = u.head_name,
                   head_phone = u.head_phone,
                   accountant_name = u.accountant_name,
                   accountant_phone = u.accountant_phone,
                   fax = u.fax,
                   email = u.email
             where rnk = t.rnk
               and bank_id = t.bank_id;
            --
            u.rnk := get_origin_rnk(u.rnk);
            rpc_sync.update_company(u);
        end if;
    end loop;
    --
    for t in (select * from v_kf)
    loop
        rpc_sync.sync_customers(t.kf);
    end loop;
    --
  end sync_customers;

  ----
  -- reload_customers - загрузка клиентов
  --
  procedure reload_customers
  is
    l_customer  customers%rowtype;
    l_company   cust_companies%rowtype;
    l_individ   cust_individuals%rowtype;
  begin
    for c in (select * from ibank_rnk  where rnk not in (select rnk from customers))
    loop
        l_customer := get_customer(c.kf, c.rnk);
        --
        insert
          into customers
        values l_customer;
        --
    begin
            rpc_sync.add_customer(l_customer);
        exception when dup_val_on_index then null;
        end;
        --
        if l_customer.type_id=3
        then
            -- физлицо
            l_individ := get_individual(c.kf, c.rnk);
            --
            insert
              into cust_individuals
            values l_individ;
            --
            begin
                rpc_sync.add_individual(l_individ);
            exception when dup_val_on_index then null;
            end;
            --
        else
            -- юрлицо
            l_company := get_company(c.kf, c.rnk);
            --
            insert
              into cust_companies
            values l_company;
            --
            begin
                rpc_sync.add_company(l_company);
            exception when dup_val_on_index then null;
            end;
            --
        end if;
    end loop;
  end reload_customers;

  --
  -- get_acc_type - возвращает тип счета по его балансовому
  --
  function get_acc_type(p_nbs in varchar2) return varchar2 is
    l_typeid   varchar2(30) := 'OTHER';
    l_nbs      varchar2(4) := p_nbs;
  begin
    while length(l_nbs)>0 and l_typeid='OTHER' loop
        begin
            l_typeid := rpc_sync.get_acc_type(l_nbs);
        exception
            when no_data_found then
                null;
        end;
        l_nbs := substr(l_nbs, 1, length(l_nbs)-1);
    end loop;
    return l_typeid;
  end get_acc_type;

  ----
  --  Преобразование кода TOBO в код BRANCH
  --
  function tobo_to_branch(p_kf in varchar2, p_tobo in varchar2) return varchar2 is
  begin
    return
        case
        when p_tobo like '/'||p_kf||'/%' then p_tobo
        else '/'||p_kf||'/'||
                case
                    when p_tobo='0' then ''
                    when p_tobo is null then ''
                    else p_tobo||'/'
                end
        end;
  end tobo_to_branch;

  ----
  -- get_account - возвращает строку для core.accounts
  --
  -- @p_acc [in] - id счета в АБС
  --
  function get_account(p_acc in integer) return accounts%rowtype is
    l_account   accounts%rowtype;
    l_rnk        integer;
    l_acc       integer;
    l_tobo      varchar2(30);
  begin
    -- читаем основные данные
    begin
        select
            a.kf              kf,
            nls                acc_num,
            a.kv                cur_id,
            rnk             rnk,
            trim(nms)                name,
            data_import.tobo_to_branch(a.kf, a.tobo) branch_id,
            daos            opening_date,
            dazs            closing_date,
            pap                paf_id,
            data_import.get_acc_type(substr(nls,1,4)) type_id,
            nvl(blkd,0)                lock_debit,
            nvl(blkk,0)                lock_credit,
            a.lim/t.denom  limit,
            nvl(dapp, daos) fin_date,
            ostc/t.denom    fin_balance,
            dos/t.denom     debit_turns,
            kos/t.denom     credit_turns,
            nvl(dappq, daos) eq_date,
            ostq/100    eq_balance,
            dosq/100    eq_debit_turns,
            kosq/100    eq_credit_turns
         into
            l_account.bank_id,
            l_account.acc_num,
            l_account.cur_id,
            l_account.rnk,
            l_account.name,
            l_account.branch_id,
            l_account.opening_date,
            l_account.closing_date,
            l_account.paf_id,
            l_account.type_id,
            l_account.lock_debit,
            l_account.lock_credit,
            l_account.limit,
            l_account.fin_date,
            l_account.fin_balance,
            l_account.debit_turns,
            l_account.credit_turns,
            l_account.eq_date,
            l_account.eq_balance,
            l_account.eq_debit_turns,
            l_account.eq_credit_turns
         from v_kf_accounts a, bars.tabval t
       where acc=p_acc
          and a.kv=t.kv;
    exception when no_data_found then
        raise_application_error(-20000, 'Рахунок(accounts) не знайдено. ACC='||p_acc, true);
    end;
    -- возвращаем строку счета
    return l_account;
  end get_account;

  ----
  -- subscribe_for_account_changes - подписываемся на получение изменений(остатки, обороты, проводки) по счету в АБС
  --
  procedure subscribe_for_account_changes(p_acc in integer) is
  begin
      ibank_accounts.subscribe(p_acc);
  end subscribe_for_account_changes;

  ----
  -- add_account_int - добавляет счет в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account_int(p_acc in integer, p_rnk in integer default null) is
      l_account         accounts%rowtype;
    p               constant varchar2(30) := G_PACKAGE_NAME||'.ADD_ACCOUNT_AUX';
    l_acc_corp2 ibank_acc.acc_corp2%type;
  begin
    logger.trace('%s: p_acc=>%s', p, to_char(p_acc));
    --
    savepoint sp;
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    -- и добавления нового счета
    -- и capture-процесс тоже
    -- check_requirements(TAB_ACC_TRANSACTIONS, p_check_capture => true);
    --
    -- получаем данные из АБС
    l_account            := get_account(p_acc);

    -- only for 2909
    if p_rnk is not null
    then
        l_account.rnk := p_rnk;
    end if;

    --
    -- сохраняем счет локально
    insert
       into accounts
     values l_account;

    -- сохраняем счет в corp2
    l_account.rnk := get_origin_rnk(l_account.rnk);
    rpc_sync.add_account(l_account);
    -- синхронизируем схемы BANK и CORE в IBANK
    rpc_sync.sync_account(l_account.bank_id, l_account.acc_num, l_account.cur_id);
    rpc_sync.get_corp2_acc(l_account.bank_id, l_account.acc_num, l_account.cur_id, l_acc_corp2);

    --
    -- подписываемся на получение изменений по счету в АБС
    subscribe_for_account_changes(p_acc);
    update barsaq.ibank_acc ia
       set ia.acc_corp2 = l_acc_corp2
     where ia.acc = p_acc
       and ia.kf = l_account.bank_id;

    --
    bars.bars_audit.info('Рахунок acc='||p_acc||' експортовано в IBANK');
    --
  exception
    when others then
        --
        rollback to sp;
        --
        raise_application_error(-20000, get_error_msg());
        --
  end add_account_int;

  ----
  -- add_account - добавляет счет в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account(p_acc in integer)
  is
  begin
    add_account_int(p_acc);
    --
    commit;
    --
  end add_account;

    ----
  -- add_account - добавляет счет в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account_new(p_acc in integer)
  is
    l_rnk  bars.customer.rnk%type;
    l_kf   bars.customer.kf%type;
    l_custtype bars.customer.custtype%type;
  begin
    select a.rnk
      into l_rnk
      from bars.accounts a
     where a.acc = p_acc;
    if (barsaq.ibank_accounts.is_cust_subscribed(l_rnk) = 0) then
      select c.custtype,
             c.kf
        into l_custtype,
             l_kf
        from bars.customer c
       where c.rnk = l_rnk;
      if (l_custtype = 2) then
        add_company(l_kf, l_rnk);
      elsif (l_custtype = 3) then
        add_individual(l_kf, l_rnk);
      end if;
    end if;
    add_account_int(p_acc);
    --
    commit;
    --
  end add_account_new;

  ----
  -- add_account2909 - добавляет счет в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account2909(p_acc in integer, p_rnk in integer)
  is
  begin
    add_account_int(p_acc, p_rnk);
    --
    commit;
    --
  end add_account2909;

  ----
  -- reload_accounts - загрузка счетов
  --
  procedure reload_accounts
  is
    l_account   accounts%rowtype;
  begin
    for c in (select * from ibank_acc)
    loop
    begin
        savepoint sp;
        --
            l_account := get_account(c.acc);
            --
            insert
                into accounts
            values l_account;
            --
            rpc_sync.add_account(l_account);
            --
    exception when others then
        rollback to sp;
        raise_application_error(-20000, 'acc='||c.acc||', '||dbms_utility.format_error_stack()
        ||chr(10)||dbms_utility.format_error_backtrace());
    end;
    end loop;
  end reload_accounts;

  ----
  -- add_account_and_sync - добавляет счет в систему и синхронизирует обороты и счета
  --
  -- @p_acc [in] - id счета в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account_and_sync(p_acc in integer) is
  begin
    -- добавляем счет
    add_account(p_acc);
    -- синхронизируем оброты и проводки
    job_sync_account_stmt(p_acc);  -- commit внутри
  end add_account_and_sync;

  ----
  -- add_account_and_sync2909 - добавляет неклиентский счет 2909 в систему для клиента и синхронизирует обороты и счета
  --
  -- @p_acc [in] - id счета в АБС
  -- @p_rnk [in] - id клиента в АБС
  -- работа по ACC позволит скрыть реализацию и расширять, при необходимости,
  -- перечень импортируемых полей
  --
  procedure add_account_and_sync2909(p_acc in integer, p_rnk in integer) is
  begin
    -- добавляем счет
    add_account2909(p_acc, p_rnk);
    -- синхронизируем оброты и проводки
    job_sync_account_stmt(p_acc);  -- commit внутри
  end add_account_and_sync2909;

  ----
  -- add_account_and_sync_group - додає масив рахунків та синхронізує по них виписку
  --
  -- @p_acc [in] - масив id рахунків в АБС
  --
  procedure add_account_and_sync_group(p_acc in acc_t) is
  begin
    for i in 1..p_acc.count
    loop
        add_account_and_sync(p_acc(i));
    end loop;
  end add_account_and_sync_group;

  ----
  -- import_cust_accounts_and_sync - Додає всі рахунки клієнта та виконує синхронізацію
  --
  -- @p_rnk [in] - регистрационный номер клиента в АБС
  --
  procedure import_cust_accounts_and_sync(p_kf in varchar2, p_rnk in integer) is
  begin
    for k in (select acc from v_sync_accounts where kf=p_kf and cust_id = p_rnk and imported = 0)
    loop
        -- добавляем счет
        add_account(k.acc);
        -- синхронизируем оброты и проводки
        job_sync_account_stmt(k.acc);  -- commit внутри
    end loop;
  end import_cust_accounts_and_sync;

  ---------------------------------------------------------------------------------------
  --
  --  SYNC_* - procedures
  --
  ---------------------------------------------------------------------------------------

  ----
  -- sync_acc_turnovers2 - синхронизиреут историю остатков и оборотов в АБС для передачи в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- @p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  -- @p_scn - точка синхронизации
  --
  procedure sync_acc_turnovers2(
    p_acc       in integer  default null,
    p_startdate in date     default null,
    p_scn       in number   default null)
  is
    l_startdate date;
    l_bankdate  date;
    l_scn       number;
    --
    l_bankid    acc_turnovers.bank_id%type;
    l_accnum    acc_turnovers.acc_num%type;
    l_curid     acc_turnovers.cur_id%type;
    --
    l_info_msg  varchar2(512);
    l_cnt       integer;
  begin
    -- точка отката
    savepoint sp;
    --
    l_scn := nvl(p_scn, dbms_flashback.get_system_change_number());
    --
    if p_acc is not null
    then
      select kf, nls, kv
        into l_bankid, l_accnum, l_curid
        from v_kf_accounts
       where acc = p_acc;
    else
      l_bankid := null;
      l_accnum := null;
      l_curid  := null;
    end if;
    -- по филиалам для мульти-мфо базы
    for f in (select kf from v_kf)
    loop
        -- действия выполняем внутри МФО
        begin
            bars_sync.subst_mfo(f.kf);
            l_bankdate := bars.gl.bd();
            l_startdate := nvl(p_startdate, l_bankdate);
            --
            -- населяем временную таблицу счетов
            delete
              from tmp_acc;
            --
            insert
              into tmp_acc(acc, bank_id, acc_num, cur_id, dapp)
            select a.acc, f.kf, a.nls, a.kv, nvl(a.dapp, a.daos)
              from v_kf_accounts a, ibank_acc c
             where a.acc = c.acc
               and c.kf  = f.kf
               and c.acc = case when p_acc is null then c.acc else p_acc end;
            --
            l_cnt := sql%rowcount;
            --
            logger.trace('наповнено таблицю tmp_acc, к-сть рядків = %s', to_char(l_cnt));
            --
            write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'видалення старих оборотів з АБС БАРС');
            -- удаляем старые значения локально
            if p_acc is null
            then
                -- удаляем данные по всем счетам
                delete
                  from acc_turnovers
                 where turns_date >= l_startdate
                   and bank_id = f.kf;
                l_cnt := sql%rowcount;
            else
                if l_bankid = f.kf then
                -- удаляем данные по одному счету
                delete
                  from acc_turnovers
                 where bank_id = l_bankid
                   and acc_num = l_accnum
                   and cur_id  = l_curid
                   and turns_date >= l_startdate;
                l_cnt := sql%rowcount;
              end if;
            end if;
            --
            logger.trace('видалено старі обороти з локальної таблиці, к-сть рядків = %s', to_char(l_cnt));
            --
            write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'вставка нових оборотів в АБС БАРС');
            -- вставляем новые в локальную таблицу
            if p_acc is null
            then
                -- по всем счетам
                insert
                  into acc_turnovers (
                          bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                          balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
                select *
                  from (select c.bank_id, c.acc_num, c.cur_id, s.fdat, s.pdat,
                               s.ostf/t.denom, s.dos/t.denom, s.kos/t.denom,
                               bars.gl.p_icurval(t.kv, s.ostf, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.dos, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.kos, s.fdat)/g_base_denom
                          from tmp_acc c,
                               bars.saldoa as of scn l_scn s,
                               bars.tabval as of scn l_scn t
                         where c.acc     = s.acc
                           and c.cur_id  = t.kv
                           and c.bank_id = f.kf
                           and s.fdat   >= l_startdate
                        );
                l_cnt := sql%rowcount;
            else
                if l_bankid = f.kf then
                -- по одному счету
                insert
                  into acc_turnovers (
                          bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                          balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
                select *
                  from (select l_bankid, l_accnum, l_curid, s.fdat, s.pdat,
                               s.ostf/t.denom, s.dos/t.denom, s.kos/t.denom,
                               bars.gl.p_icurval(t.kv, s.ostf, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.dos, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.kos, s.fdat)/g_base_denom
                              from bars.saldoa s,
                                   bars.tabval t
                         where t.kv      = l_curid
                           and s.acc     = p_acc
                           and s.fdat   >= l_startdate
                        );
                l_cnt := sql%rowcount;
            end if;
            end if;
            --
            logger.trace('наповнено нові обороти в локальній таблиці, к-сть рядків = %s', to_char(l_cnt));
            --
            bars_sync.set_context();
            --
        exception when others then
            bars_sync.set_context();
            raise_application_error(-20000, get_error_msg());
        end;
        --
    end loop;
    --
    if p_acc is null
    then
        l_info_msg := 'по всіх рахунках';
    else
        select 'по рахунку '||nls||'('||to_char(kv)||')'
          into l_info_msg
          from v_kf_accounts
         where acc=p_acc;
    end if;
    bars.bars_audit.info('Наповнено локальну таблицю оборотів '
                       ||l_info_msg
                       ||' починаючи з дати '||to_char(l_startdate,'DD.MM.YYYY'));
  exception when others then
    --
    rollback to sp;
    --
    raise_application_error(-20000, get_error_msg());
    --
  end sync_acc_turnovers2;


  ----
  -- sync_acc_period_turnovers2 - синхронизиреут историю остатков и оборотов в АБС для передачи в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- @p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  -- @p_finishdate - конечная банковская дата
  -- @p_scn - точка синхронизации
  --
  procedure sync_acc_period_turnovers2(
    p_acc       in integer  default null,
    p_startdate in date     default null,
    p_finishdate in date     default null,
    p_scn       in number   default null)
  is
    l_startdate  date;
    l_finishdate date := p_finishdate;
    l_bankdate   date;
    l_scn        number;
    --
    l_bankid    acc_turnovers.bank_id%type;
    l_accnum    acc_turnovers.acc_num%type;
    l_curid     acc_turnovers.cur_id%type;
    --
    l_info_msg  varchar2(512);
    l_cnt       integer;
  begin
    -- точка отката
    savepoint sp;
    --
    l_scn := nvl(p_scn, dbms_flashback.get_system_change_number());
    --
    if p_acc is not null
    then
      select kf, nls, kv
        into l_bankid, l_accnum, l_curid
        from v_kf_accounts
       where acc = p_acc;
    else
      l_bankid := null;
      l_accnum := null;
      l_curid  := null;
    end if;
    -- по филиалам для мульти-мфо базы
    for f in (select kf from v_kf)
    loop
        -- действия выполняем внутри МФО
        begin
            bars_sync.subst_mfo(f.kf);
            l_bankdate := bars.gl.bd();
            l_startdate := nvl(p_startdate, l_bankdate);
            --
            -- населяем временную таблицу счетов
            delete
              from tmp_acc;
            --
            insert
              into tmp_acc(acc, bank_id, acc_num, cur_id, dapp)
            select a.acc, f.kf, a.nls, a.kv, nvl(a.dapp, a.daos)
              from v_kf_accounts a, ibank_acc c
             where a.acc = c.acc
               and c.kf  = f.kf
               and c.acc = case when p_acc is null then c.acc else p_acc end;
            --
            l_cnt := sql%rowcount;
            --
            logger.trace('наповнено таблицю tmp_acc, к-сть рядків = %s', to_char(l_cnt));
            --
            write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'видалення старих оборотів з АБС БАРС');
            -- удаляем старые значения локально
            if p_acc is null
            then
                -- удаляем данные по всем счетам
                delete
                  from acc_turnovers
                 where turns_date between l_startdate and l_finishdate
                   and bank_id = f.kf;
                l_cnt := sql%rowcount;
            else
                -- удаляем данные по одному счету
                if l_bankid = f.kf then
                delete
                  from acc_turnovers
                 where bank_id = l_bankid
                   and acc_num = l_accnum
                   and cur_id  = l_curid
                   and turns_date between l_startdate and l_finishdate;
                l_cnt := sql%rowcount;
            end if;
            end if;
            --
            logger.trace('видалено старі обороти з локальної таблиці, к-сть рядків = %s', to_char(l_cnt));
            --
            write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'вставка нових оборотів в АБС БАРС');
            -- вставляем новые в локальную таблицу
            if p_acc is null
            then
                -- по всем счетам
                insert
                  into acc_turnovers (
                          bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                          balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
                select *
                  from (select c.bank_id, c.acc_num, c.cur_id, s.fdat, s.pdat,
                               s.ostf/t.denom, s.dos/t.denom, s.kos/t.denom,
                               bars.gl.p_icurval(t.kv, s.ostf, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.dos, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.kos, s.fdat)/g_base_denom
                          from tmp_acc c,
                               bars.saldoa as of scn l_scn s,
                               bars.tabval as of scn l_scn t
                         where c.acc     = s.acc
                           and c.cur_id  = t.kv
                           and c.bank_id = f.kf
                           and s.fdat between l_startdate and l_finishdate
                        );
                l_cnt := sql%rowcount;
            else
                -- по одному счету
                if l_bankid = f.kf then
                insert
                  into acc_turnovers (
                          bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                          balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
                select *
                  from (select l_bankid, l_accnum, l_curid, s.fdat, s.pdat,
                               s.ostf/t.denom, s.dos/t.denom, s.kos/t.denom,
                               bars.gl.p_icurval(t.kv, s.ostf, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.dos, s.fdat)/g_base_denom,
                               bars.gl.p_icurval(t.kv, s.kos, s.fdat)/g_base_denom
                              from bars.saldoa s,
                                   bars.tabval t
                         where t.kv      = l_curid
                           and s.acc     = p_acc
                           and s.fdat   between l_startdate and l_finishdate
                        );
                l_cnt := sql%rowcount;
            end if;
            end if;
            --
            logger.trace('наповнено нові обороти в локальній таблиці, к-сть рядків = %s', to_char(l_cnt));
            --
            bars_sync.set_context();
            --
        exception when others then
            bars_sync.set_context();
            raise_application_error(-20000, get_error_msg());
        end;
        --
    end loop;
    --
    if p_acc is null
    then
        l_info_msg := 'по всіх рахунках';
    else
        select 'по рахунку '||nls||'('||to_char(kv)||')'
          into l_info_msg
          from v_kf_accounts
         where acc=p_acc;
    end if;
    bars.bars_audit.info('Наповнено локальну таблицю оборотів '
                       ||l_info_msg
                       ||' з дати '||to_char(l_startdate,'DD.MM.YYYY') || ' по дату '||to_char(l_finishdate,'DD.MM.YYYY'));
  exception when others then
    --
    rollback to sp;
    --
    raise_application_error(-20000, get_error_msg());
    --
  end sync_acc_period_turnovers2;

  ----
  -- sync_acc_transactions2 - синхронизиреут проводки в АБС для передачи в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- @p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  -- @p_scn - точка синхронизации
  --
  procedure sync_acc_transactions2(
    p_acc       in integer default null,
    p_startdate in date    default null,
    p_scn       in number  default null)
  is
    l_startdate date;
    l_bankdate  date;
    l_scn       number;
    --
    l_bankid    acc_transactions.bank_id%type;
    l_accnum    acc_transactions.acc_num%type;
    l_curid     acc_transactions.cur_id%type;
    l_cnt       integer;
    l_ref92     bars.operw.value%type;
    l_ref92_bank_id acc_transactions.ref92_bank_id%type;
    l_ref92_cust_code acc_transactions.ref92_cust_code%type;
    l_ref92_acc_num acc_transactions.ref92_acc_num%type;
    l_ref92_acc_name acc_transactions.ref92_acc_name%type;
    l_ref92_bank_name acc_transactions.ref92_bank_name%type;
  begin
    -- точка отката
    savepoint sp;
    --
    l_scn := nvl(p_scn, dbms_flashback.get_system_change_number());
    --
    if p_acc is not null
    then
      select kf, nls, kv
        into l_bankid, l_accnum, l_curid
        from v_kf_accounts
       where acc = p_acc;
    else
      l_bankid := null;
      l_accnum := null;
      l_curid  := null;
    end if;
    -- по филиалам для мульти-мфо базы
    for f in (select kf from v_kf)
    loop
        bars_sync.subst_mfo(f.kf);
        l_bankdate := bars.gl.bd();
        l_startdate := nvl(p_startdate, l_bankdate);
        -- населяем временную таблицу счетов
        delete from tmp_acc;
        --
        insert
          into tmp_acc(acc, bank_id, acc_num, cur_id)
        select a.acc, f.kf, a.nls, a.kv
          from v_kf_accounts a, ibank_acc c
         where a.acc = c.acc
           and c.kf  = f.kf
           and c.acc = case when p_acc is null then c.acc else p_acc end;
        --
        l_cnt := sql%rowcount;
        --
        logger.trace('наповнено таблицю tmp_acc, к-сть рядків = %s', to_char(l_cnt));
        --
        write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'видалення старих проводок з АБС БАРС');
        -- удаляем старые значения локально
        if p_acc is null
        then
            delete
              from acc_transactions
             where trans_date >= l_startdate
               and bank_id = f.kf;
            l_cnt := sql%rowcount;
        else
            if l_bankid = f.kf then
            delete
              from acc_transactions
             where bank_id = l_bankid
               and acc_num = l_accnum
               and cur_id = l_curid
               and trans_date >= l_startdate;
            l_cnt := sql%rowcount;
        end if;
        end if;
        --
        logger.trace('видалено старі проводки з локальної таблиці, к-сть рядків = %s', to_char(l_cnt));
        --
        write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'вставка нових батьківських проводок в АБС БАРС');
        -- вставляем новые в локальную таблицу
        -- сначала родительские транзакции
        for cur_r in (
          select c.bank_id, c.acc_num,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_a
               else d.nam_b
               end
               as name,
               c.cur_id, p.fdat, to_char(p.stmt) stmt, to_char(p.ref) ref, nvl(d.nd, substr(to_char(p.ref),1,10)) nd,
               (select nvl(max(dat), d.pdat) from bars.oper_visa where ref=d.ref and status = 2 and groupid not in (80, 81, 30, 130))  dat,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom as trans_sum, p.sq/g_base_denom as trans_sum_eq,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.mfob
               else d.mfoa
               end
               as corr_bank_id,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then
                    (select nb from bars.banks where mfo=d.mfob)
               else
                    (select nb from bars.banks where mfo=d.mfoa)
               end
               as corr_bank_name,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.id_b
               else d.id_a
               end
               as corr_ident_code,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nlsb
               else d.nlsa
               end
               as corr_acc_num,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_b
               else d.nam_a
               end
               as corr_name,
               d.nazn,
               case when d.mfoa<>d.mfob or p.tt='R01' then
                    ibank_accounts.extract_bis_external_clob(d.ref, l_scn)
               else
                    ibank_accounts.extract_bis_internal_clob(d.ref, l_scn)
               end as narrative_extra,
               (select to_number(value) from bars.operw as of scn l_scn where tag='EXREF' and ref=d.ref)
               as ibank_docid,
               p.tt
          from tmp_acc c,
               bars.opldok  as of scn l_scn p,
               bars.oper    as of scn l_scn d,
               bars.tabval  as of scn l_scn t,
               bars.oper_visa as of scn l_scn v
         where c.bank_id  = f.kf
           and p.acc = c.acc
           and p.fdat >= l_startdate
           and p.sos = 5
           and p.ref = d.ref
           and c.cur_id = t.kv
           and (  not (d.kv is not null and d.kv2 is not null and d.kv<>d.kv2) -- не разновалютные
                  and p.tt=d.tt and p.s=d.s -- код операции и сумма совпадают
                  or p.tt='R01' -- или проводка типа R01
               )
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30, 130)
           and v.status (+) = 2)
           loop

        l_ref92_bank_id := null;
        l_ref92_cust_code := null;
        l_ref92_acc_num := null;
        l_ref92_acc_name := null;
        l_ref92_bank_name := null;

        if cur_r.tt in ('902','901') then
          begin
         select value into l_ref92 from bars.operw where ref=cur_r.ref and tag='REF92';
            select mfoa, id_a,  nlsa, nam_a
             into l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name
            from bars.oper where ref= l_ref92;
         select b.nb into l_ref92_bank_name from bars.BANKS$BASE b where b.Mfo = l_ref92_bank_id;
           exception
             when NO_DATA_FOUND then null;
           end;
         end if;

        insert
          into acc_transactions (
                   bank_id, acc_num, name, cur_id, trans_date, trans_id, doc_id, doc_number, doc_date,
                   type_id, trans_sum, trans_sum_eq,
                   corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num, corr_name,
                   narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        values (cur_r.bank_id, cur_r.acc_num, cur_r.name, cur_r.cur_id, cur_r.fdat, cur_r.stmt, cur_r.ref, cur_r.nd, cur_r.dat,
                   cur_r.type_id,  cur_r.trans_sum, cur_r.trans_sum_eq,
                   cur_r.corr_bank_id, cur_r.corr_bank_name, cur_r.corr_ident_code, cur_r.corr_acc_num, cur_r.corr_name,
                   cur_r.nazn, cur_r.narrative_extra, cur_r.ibank_docid, l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name, l_ref92_bank_name);
            end loop;
        --
        l_cnt := sql%rowcount;
        --
        logger.trace('вставлено батьківські проводки в локальну таблицю, к-сть рядків = %s', to_char(l_cnt));
        --
        write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'вставка нових дочірніх проводок в АБС БАРС');
        -- теперь дочерние
        for cur_d in (
          select c.bank_id, c.acc_num, c.cur_id,
               p.fdat as trans_date,
               to_char(p.stmt) as trans_id,
               to_char(p.ref) as doc_id,
               nvl(d.nd, substr(to_char(p.ref),1,10)) as doc_number,
               nvl(v.dat,d.pdat) as doc_date,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom as trans_sum, p.sq/g_base_denom as trans_sum_eq,
               a2.kf as corr_bank_id,
               b2.nb as corr_bank_name,
               c2.okpo as corr_ident_code,
               a2.nls as corr_acc_num,
               substr(a2.nms,1,38) as corr_name,
               trim(p.txt)||' '||trim(d.nazn) as narrative,
               null as narrative_extra,
               null as ibank_docid,
               p.tt
          from tmp_acc c,
               bars.opldok          as of scn l_scn p,
               bars.oper            as of scn l_scn d,
               bars.tabval          as of scn l_scn t,
               bars.opldok          as of scn l_scn p2,
               v_kf_accounts         a2,
               bars.banks            b2,
               bars.customer        as of scn l_scn c2,
               bars.oper_visa         as of scn l_scn v
         where c.bank_id  = f.kf
           and p.acc = c.acc
           and p.fdat >= l_startdate
           and p.sos = 5
           and p.ref = d.ref
           and c.cur_id = t.kv
           and (  d.kv is not null and d.kv2 is not null and d.kv<>d.kv2 -- разновалютные
               or p.tt<>d.tt or p.s<>d.s -- код операции или сумма не совпадают
             )
           and p.tt<>'R01' -- и проводка не R01
           and p.ref=p2.ref and p.stmt=p2.stmt and p.dk=1-p2.dk -- правая сторона проводки
           and p2.acc=a2.acc and a2.kf=b2.mfo and a2.rnk=c2.rnk
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30)
           and v.status (+) = 2
          )
          loop

        l_ref92_bank_id := null;
        l_ref92_cust_code := null;
        l_ref92_acc_num := null;
        l_ref92_acc_name := null;
        l_ref92_bank_name := null;

        if cur_d.tt in ('902','901') then
          begin
         select value into l_ref92 from bars.operw where ref=cur_d.doc_id and tag='REF92';
            select mfoa, id_a,  nlsa, nam_a
             into l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name
            from bars.oper where ref= l_ref92;
         select b.nb into l_ref92_bank_name from bars.BANKS$BASE b where b.Mfo = l_ref92_bank_id;
           exception
             when NO_DATA_FOUND then null;
           end;
         end if;

        insert
          into acc_transactions (
               bank_id, acc_num, cur_id, trans_date, trans_id, doc_id, doc_number, doc_date,
               type_id, trans_sum, trans_sum_eq,
               corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num, corr_name,
               narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
           values
               (cur_d.bank_id, cur_d.acc_num, cur_d.cur_id, cur_d.trans_date, cur_d.trans_id, cur_d.doc_id, cur_d.doc_number, cur_d.doc_date,
               cur_d.type_id, cur_d.trans_sum, cur_d.trans_sum_eq,
               cur_d.corr_bank_id, cur_d.corr_bank_name, cur_d.corr_ident_code, cur_d.corr_acc_num, cur_d.corr_name,
               cur_d.narrative, cur_d.narrative_extra, cur_d.ibank_docid, l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name, l_ref92_bank_name);
           end loop;
        --
        l_cnt := sql%rowcount;
        --
        logger.trace('вставлено дочірні проводки в локальну таблицю, к-сть рядків = %s', to_char(l_cnt));
        --
    end loop;
    --
    bars.bars_audit.info('Наповнено локальну таблицю проводок '
                       ||case when p_acc is null then 'по всіх рахунках' else 'по рахунку acc='||p_acc end
                       ||' починаючи з дати '||to_char(l_startdate,'DD.MM.YYYY'));
  exception when others then
    --
    rollback to sp;
    --
    raise_application_error(-20000, get_error_msg());
    --
  end sync_acc_transactions2;


procedure sync_acc_transactions2_TEST(
    p_startdate in date    default null,
    p_scn       in number  default null)
  is
    p_acc        integer default null;
    l_startdate date;
    l_bankdate  date;
    l_scn       number;
    --
    l_bankid    acc_transactions_test.bank_id%type;
    l_accnum    acc_transactions_test.acc_num%type;
    l_curid     acc_transactions_test.cur_id%type;
    l_cnt       integer;
    l_ref92     bars.operw.value%type;
    l_ref92_bank_id acc_transactions_test.ref92_bank_id%type;
    l_ref92_cust_code acc_transactions_test.ref92_cust_code%type;
    l_ref92_acc_num acc_transactions_test.ref92_acc_num%type;
    l_ref92_acc_name acc_transactions_test.ref92_acc_name%type;
    l_ref92_bank_name acc_transactions_test.ref92_bank_name%type;
  begin
    -- точка отката
    savepoint sp;
    --
    l_scn := nvl(p_scn, dbms_flashback.get_system_change_number());
    --
    if p_acc is not null
    then
      select kf, nls, kv
        into l_bankid, l_accnum, l_curid
        from v_kf_accounts
       where acc = p_acc;
    else
      l_bankid := null;
      l_accnum := null;
      l_curid  := null;
    end if;
    -- по филиалам для мульти-мфо базы
    for f in (select kf from v_kf)
    loop
        bars_sync.subst_mfo(f.kf);
        l_bankdate := bars.gl.bd();
        l_startdate := nvl(p_startdate, l_bankdate);
        -- населяем временную таблицу счетов
        delete from tmp_acc;
        --
        insert
          into tmp_acc(acc, bank_id, acc_num, cur_id)
        select a.acc, f.kf, a.nls, a.kv
          from v_kf_accounts a, ibank_acc c
         where a.acc = c.acc
           and c.kf  = f.kf
           and c.acc = case when p_acc is null then c.acc else p_acc end;
        --
        l_cnt := sql%rowcount;
        --
        -- удаляем старые значения локально
        if p_acc is null
        then
            delete
              from acc_transactions_test
             where trans_date >= l_startdate
               and bank_id = f.kf;
            l_cnt := sql%rowcount;
        else
            delete
              from acc_transactions_test
             where bank_id = l_bankid
               and acc_num = l_accnum
               and cur_id = l_curid
               and trans_date >= l_startdate;
            l_cnt := sql%rowcount;
        end if;
        --
        -- вставляем новые в локальную таблицу
        -- сначала родительские транзакции
        for cur_r in (
          select  rownum rn, count(all 1) over () cnt,
               c.bank_id, c.acc_num,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_a
               else d.nam_b
               end
               as name,
               c.cur_id, p.fdat, p.stmt, to_char(p.ref) ref, nvl(d.nd, substr(to_char(p.ref),1,10)) nd,
               (select nvl(max(dat), d.pdat) from bars.oper_visa where ref=d.ref and status = 2 and groupid not in (80, 81, 30, 130))  dat,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom as trans_sum, p.sq/g_base_denom as trans_sum_eq,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.mfob
               else d.mfoa
               end
               as corr_bank_id,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then
                    (select nb from bars.banks where mfo=d.mfob)
               else
                    (select nb from bars.banks where mfo=d.mfoa)
               end
               as corr_bank_name,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.id_b
               else d.id_a
               end
               as corr_ident_code,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nlsb
               else d.nlsa
               end
               as corr_acc_num,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_b
               else d.nam_a
               end
               as corr_name,
               d.nazn,
               case when d.mfoa<>d.mfob or p.tt='R01' then
                    ibank_accounts.extract_bis_external_clob(d.ref, l_scn)
               else
                    ibank_accounts.extract_bis_internal_clob(d.ref, l_scn)
               end as narrative_extra,
               (select to_number(value) from bars.operw as of scn l_scn where tag='EXREF' and ref=d.ref)
               as ibank_docid,
               p.tt
          from tmp_acc c,
               bars.opldok  as of scn l_scn p,
               bars.oper    as of scn l_scn d,
               bars.tabval  as of scn l_scn t,
               bars.oper_visa as of scn l_scn v
         where c.bank_id  = f.kf
           and p.acc = c.acc
           and p.fdat >= l_startdate
--           and p.sos = 5
           and p.ref = d.ref
           and c.cur_id = t.kv
           and (  not (d.kv is not null and d.kv2 is not null and d.kv<>d.kv2) -- не разновалютные
                  and p.tt=d.tt and p.s=d.s -- код операции и сумма совпадают
                  or p.tt='R01' -- или проводка типа R01
               )
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30, 130)
           and v.status (+) = 2)
           loop
dbms_application_info.set_action(cur_r.rn||'/'||cur_r.cnt||' Parent');
        l_ref92_bank_id := null;
        l_ref92_cust_code := null;
        l_ref92_acc_num := null;
        l_ref92_acc_name := null;
        l_ref92_bank_name := null;

        if cur_r.tt in ('902','901') then
          begin
         select value into l_ref92 from bars.operw where ref=cur_r.ref and tag='REF92';
            select mfoa, id_a,  nlsa, nam_a
             into l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name
            from bars.oper where ref= l_ref92;
         select b.nb into l_ref92_bank_name from bars.BANKS$BASE b where b.Mfo = l_ref92_bank_id;
           exception
             when NO_DATA_FOUND then null;
           end;
         end if;

        insert
          into acc_transactions_test (
                   bank_id, acc_num, name, cur_id, trans_date, trans_id, doc_id, doc_number, doc_date,
                   type_id, trans_sum, trans_sum_eq,
                   corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num, corr_name,
                   narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        values (cur_r.bank_id, cur_r.acc_num, cur_r.name, cur_r.cur_id, cur_r.fdat, cur_r.stmt, cur_r.ref, cur_r.nd, cur_r.dat,
                   cur_r.type_id,  cur_r.trans_sum, cur_r.trans_sum_eq,
                   cur_r.corr_bank_id, cur_r.corr_bank_name, cur_r.corr_ident_code, cur_r.corr_acc_num, cur_r.corr_name,
                   cur_r.nazn, cur_r.narrative_extra, cur_r.ibank_docid, l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name, l_ref92_bank_name);
            end loop;
        --
        l_cnt := sql%rowcount;
        --
        -- теперь дочерние
        for cur_d in (
          select rownum rn, count(all 1) over () cnt,
           c.bank_id, c.acc_num, c.cur_id,
               p.fdat as trans_date,
               p.stmt as trans_id,
               to_char(p.ref) as doc_id,
               nvl(d.nd, substr(to_char(p.ref),1,10)) as doc_number,
               nvl(v.dat,d.pdat) as doc_date,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom as trans_sum, p.sq/g_base_denom as trans_sum_eq,
               a2.kf as corr_bank_id,
               b2.nb as corr_bank_name,
               c2.okpo as corr_ident_code,
               a2.nls as corr_acc_num,
               substr(a2.nms,1,38) as corr_name,
               trim(p.txt)||' '||trim(d.nazn) as narrative,
               null as narrative_extra,
               null as ibank_docid,
               p.tt
          from tmp_acc c,
               bars.opldok          as of scn l_scn p,
               bars.oper            as of scn l_scn d,
               bars.tabval          as of scn l_scn t,
               bars.opldok          as of scn l_scn p2,
               v_kf_accounts         a2,
               bars.banks            b2,
               bars.customer        as of scn l_scn c2,
               bars.oper_visa         as of scn l_scn v
         where c.bank_id  = f.kf
           and p.acc = c.acc
           and p.fdat >= l_startdate
--           and p.sos = 5
           and p.ref = d.ref
           and c.cur_id = t.kv
           and (  d.kv is not null and d.kv2 is not null and d.kv<>d.kv2 -- разновалютные
               or p.tt<>d.tt or p.s<>d.s -- код операции или сумма не совпадают
             )
           and p.tt<>'R01' -- и проводка не R01
           and p.ref=p2.ref and p.stmt=p2.stmt and p.dk=1-p2.dk -- правая сторона проводки
           and p2.acc=a2.acc and a2.kf=b2.mfo and a2.rnk=c2.rnk
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30)
           and v.status (+) = 2
          )
          loop

dbms_application_info.set_action(cur_d.rn||'/'||cur_d.cnt||' Chld');
        l_ref92_bank_id := null;
        l_ref92_cust_code := null;
        l_ref92_acc_num := null;
        l_ref92_acc_name := null;
        l_ref92_bank_name := null;

        if cur_d.tt in ('902','901') then
          begin
         select value into l_ref92 from bars.operw where ref=cur_d.doc_id and tag='REF92';
            select mfoa, id_a,  nlsa, nam_a
             into l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name
            from bars.oper where ref= l_ref92;
         select b.nb into l_ref92_bank_name from bars.BANKS$BASE b where b.Mfo = l_ref92_bank_id;
           exception
             when NO_DATA_FOUND then null;
           end;
         end if;

        insert
          into acc_transactions_test (
               bank_id, acc_num, cur_id, trans_date, trans_id, doc_id, doc_number, doc_date,
               type_id, trans_sum, trans_sum_eq,
               corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num, corr_name,
               narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
           values
               (cur_d.bank_id, cur_d.acc_num, cur_d.cur_id, cur_d.trans_date, cur_d.trans_id, cur_d.doc_id, cur_d.doc_number, cur_d.doc_date,
               cur_d.type_id, cur_d.trans_sum, cur_d.trans_sum_eq,
               cur_d.corr_bank_id, cur_d.corr_bank_name, cur_d.corr_ident_code, cur_d.corr_acc_num, cur_d.corr_name,
               cur_d.narrative, cur_d.narrative_extra, cur_d.ibank_docid, l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name, l_ref92_bank_name);
           end loop;
        --
        l_cnt := sql%rowcount;
        --
    end loop;
    --
  exception when others then
    --
    rollback to sp;
    --
    raise_application_error(-20000, get_error_msg());
    --
  end sync_acc_transactions2_TEST;


    ----
  -- sync_acc_period_transactions2 - синхронизиреут проводки в АБС для передачи в систему
  --
  -- @p_acc [in] - id счета в АБС
  -- @p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  -- @p_scn - точка синхронизации
  --
  procedure sync_acc_period_transactions2(
    p_acc       in integer default null,
    p_startdate in date    default null,
    p_finishdate in date    default null,
    p_scn       in number  default null)
  is
    l_startdate  date;
    l_finishdate date := p_finishdate;
    l_bankdate   date;
    l_scn        number;
    --
    l_bankid    acc_transactions.bank_id%type;
    l_accnum    acc_transactions.acc_num%type;
    l_curid     acc_transactions.cur_id%type;
    l_cnt       integer;
    l_ref92     bars.operw.value%type;
    l_ref92_bank_id acc_transactions.ref92_bank_id%type;
    l_ref92_cust_code acc_transactions.ref92_cust_code%type;
    l_ref92_acc_num acc_transactions.ref92_acc_num%type;
    l_ref92_acc_name acc_transactions.ref92_acc_name%type;
    l_ref92_bank_name acc_transactions.ref92_bank_name%type;
  begin
    -- точка отката
    savepoint sp;
    --
    l_scn := nvl(p_scn, dbms_flashback.get_system_change_number());
    --
    if p_acc is not null
    then
      select kf, nls, kv
        into l_bankid, l_accnum, l_curid
        from v_kf_accounts
       where acc = p_acc;
    else
      l_bankid := null;
      l_accnum := null;
      l_curid  := null;
    end if;
    -- по филиалам для мульти-мфо базы
    for f in (select kf from v_kf)
    loop
        bars_sync.subst_mfo(f.kf);
        l_bankdate := bars.gl.bd();
        l_startdate := nvl(p_startdate, l_bankdate);
        -- населяем временную таблицу счетов
        delete from tmp_acc;
        --
        insert
          into tmp_acc(acc, bank_id, acc_num, cur_id)
        select a.acc, f.kf, a.nls, a.kv
          from v_kf_accounts a, ibank_acc c
         where a.acc = c.acc
           and c.kf  = f.kf
           and c.acc = case when p_acc is null then c.acc else p_acc end;
        --
        l_cnt := sql%rowcount;
        --
        logger.trace('наповнено таблицю tmp_acc, к-сть рядків = %s', to_char(l_cnt));
        --
        write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'видалення старих проводок з АБС БАРС');
        -- удаляем старые значения локально
        if p_acc is null
        then
            delete
              from acc_transactions
             where trans_date between l_startdate and l_finishdate
               and bank_id = f.kf;
            l_cnt := sql%rowcount;
        else
            if l_bankid = f.kf then
            delete
              from acc_transactions
             where bank_id = l_bankid
               and acc_num = l_accnum
               and cur_id = l_curid
               and trans_date between l_startdate and l_finishdate;
            l_cnt := sql%rowcount;
        end if;
        end if;
        --
        logger.trace('видалено старі проводки з локальної таблиці, к-сть рядків = %s', to_char(l_cnt));
        --
        write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'вставка нових батьківських проводок в АБС БАРС');
        -- вставляем новые в локальную таблицу
        -- сначала родительские транзакции
        for cur_r in (
          select c.bank_id, c.acc_num,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_a
               else d.nam_b
               end
               as name,
               c.cur_id, p.fdat, to_char(p.stmt) stmt, to_char(p.ref) ref, nvl(d.nd, substr(to_char(p.ref),1,10)) nd,
               (select nvl(max(dat), d.pdat) from bars.oper_visa where ref=d.ref and status = 2 and groupid not in (80, 81, 30, 130))  dat,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom as trans_sum, p.sq/g_base_denom as trans_sum_eq,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.mfob
               else d.mfoa
               end
               as corr_bank_id,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then
                    (select nb from bars.banks as of scn l_scn where mfo=d.mfob)
               else
                    (select nb from bars.banks as of scn l_scn where mfo=d.mfoa)
               end
               as corr_bank_name,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.id_b
               else d.id_a
               end
               as corr_ident_code,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nlsb
               else d.nlsa
               end
               as corr_acc_num,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_b
               else d.nam_a
               end
               as corr_name,
               d.nazn,
               case when d.mfoa<>d.mfob or p.tt='R01' then
                    ibank_accounts.extract_bis_external_clob(d.ref, l_scn)
               else
                    ibank_accounts.extract_bis_internal_clob(d.ref, l_scn)
               end as narrative_extra,
               (select to_number(value) from bars.operw as of scn l_scn where tag='EXREF' and ref=d.ref)
               as ibank_docid,
               p.tt
          from tmp_acc c,
               bars.opldok  as of scn l_scn p,
               bars.oper    as of scn l_scn d,
               bars.tabval  as of scn l_scn t,
               bars.oper_visa as of scn l_scn v
         where c.bank_id  = f.kf
           and p.acc = c.acc
           and p.fdat between l_startdate and l_finishdate
           and p.sos = 5
           and p.ref = d.ref
           and c.cur_id = t.kv
           and (  not (d.kv is not null and d.kv2 is not null and d.kv<>d.kv2) -- не разновалютные
                  and p.tt=d.tt and p.s=d.s -- код операции и сумма совпадают
                  or p.tt='R01' -- или проводка типа R01
               )
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30, 130)
           and v.status (+) = 2)
           loop

        l_ref92_bank_id := null;
        l_ref92_cust_code := null;
        l_ref92_acc_num := null;
        l_ref92_acc_name := null;
        l_ref92_bank_name := null;

        if cur_r.tt in ('902','901') then
          begin
         select value into l_ref92 from bars.operw where ref=cur_r.ref and tag='REF92';
            select mfoa, id_a,  nlsa, nam_a
             into l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name
            from bars.oper where ref= l_ref92;
         select b.nb into l_ref92_bank_name from bars.BANKS$BASE b where b.Mfo = l_ref92_bank_id;
           exception
             when NO_DATA_FOUND then null;
           end;
         end if;

        insert
          into acc_transactions (
                   bank_id, acc_num, name, cur_id, trans_date, trans_id, doc_id, doc_number, doc_date,
                   type_id, trans_sum, trans_sum_eq,
                   corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num, corr_name,
                   narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        values (cur_r.bank_id, cur_r.acc_num, cur_r.name, cur_r.cur_id, cur_r.fdat, cur_r.stmt, cur_r.ref, cur_r.nd, cur_r.dat,
                   cur_r.type_id,  cur_r.trans_sum, cur_r.trans_sum_eq,
                   cur_r.corr_bank_id, cur_r.corr_bank_name, cur_r.corr_ident_code, cur_r.corr_acc_num, cur_r.corr_name,
                   cur_r.nazn, cur_r.narrative_extra, cur_r.ibank_docid, l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name, l_ref92_bank_name);
            end loop;
        --
        l_cnt := sql%rowcount;
        --
        logger.trace('вставлено батьківські проводки в локальну таблицю, к-сть рядків = %s', to_char(l_cnt));
        --
        write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_INPROGRESS, 'вставка нових дочірніх проводок в АБС БАРС');
        -- теперь дочерние
        for cur_d in (
          select c.bank_id, c.acc_num, c.cur_id,
               p.fdat as trans_date,
               to_char(p.stmt) as trans_id,
               to_char(p.ref) as doc_id,
               nvl(d.nd, substr(to_char(p.ref),1,10)) as doc_number,
               nvl(v.dat,d.pdat) as doc_date,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom as trans_sum, p.sq/g_base_denom as trans_sum_eq,
               a2.kf as corr_bank_id,
               b2.nb as corr_bank_name,
               c2.okpo as corr_ident_code,
               a2.nls as corr_acc_num,
               substr(a2.nms,1,38) as corr_name,
               trim(p.txt)||' '||trim(d.nazn) as narrative,
               null as narrative_extra,
               null as ibank_docid,
               p.tt
          from tmp_acc c,
               bars.opldok          as of scn l_scn p,
               bars.oper            as of scn l_scn d,
               bars.tabval          as of scn l_scn t,
               bars.opldok          as of scn l_scn p2,
               v_kf_accounts         a2,
               bars.banks           as of scn l_scn b2,
               bars.customer        as of scn l_scn c2,
               bars.oper_visa         as of scn l_scn v
         where c.bank_id  = f.kf
           and p.acc = c.acc
           and p.fdat between l_startdate and l_finishdate
           and p.sos = 5
           and p.ref = d.ref
           and c.cur_id = t.kv
           and (  d.kv is not null and d.kv2 is not null and d.kv<>d.kv2 -- разновалютные
               or p.tt<>d.tt or p.s<>d.s -- код операции или сумма не совпадают
             )
           and p.tt<>'R01' -- и проводка не R01
           and p.ref=p2.ref and p.stmt=p2.stmt and p.dk=1-p2.dk -- правая сторона проводки
           and p2.acc=a2.acc and a2.kf=b2.mfo and a2.rnk=c2.rnk
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30)
           and v.status (+) = 2
          )
          loop

        l_ref92_bank_id := null;
        l_ref92_cust_code := null;
        l_ref92_acc_num := null;
        l_ref92_acc_name := null;
        l_ref92_bank_name := null;

        if cur_d.tt in ('902','901') then
          begin
         select value into l_ref92 from bars.operw where ref=cur_d.doc_id and tag='REF92';
            select mfoa, id_a,  nlsa, nam_a
             into l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name
            from bars.oper where ref= l_ref92;
         select b.nb into l_ref92_bank_name from bars.BANKS$BASE b where b.Mfo = l_ref92_bank_id;
           exception
             when NO_DATA_FOUND then null;
           end;
         end if;

        insert
          into acc_transactions (
               bank_id, acc_num, cur_id, trans_date, trans_id, doc_id, doc_number, doc_date,
               type_id, trans_sum, trans_sum_eq,
               corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num, corr_name,
               narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
           values
               (cur_d.bank_id, cur_d.acc_num, cur_d.cur_id, cur_d.trans_date, cur_d.trans_id, cur_d.doc_id, cur_d.doc_number, cur_d.doc_date,
               cur_d.type_id, cur_d.trans_sum, cur_d.trans_sum_eq,
               cur_d.corr_bank_id, cur_d.corr_bank_name, cur_d.corr_ident_code, cur_d.corr_acc_num, cur_d.corr_name,
               cur_d.narrative, cur_d.narrative_extra, cur_d.ibank_docid, l_ref92_bank_id, l_ref92_cust_code, l_ref92_acc_num, l_ref92_acc_name, l_ref92_bank_name);
           end loop;
        --
        l_cnt := sql%rowcount;
        --
        logger.trace('вставлено дочірні проводки в локальну таблицю, к-сть рядків = %s', to_char(l_cnt));
        --
    end loop;
    --
    bars.bars_audit.info('Наповнено локальну таблицю проводок '
                       ||case when p_acc is null then 'по всіх рахунках' else 'по рахунку acc='||p_acc end
                       ||' починаючи з дати '||to_char(l_startdate,'DD.MM.YYYY')
                       ||' по дату '||to_char(l_finishdate,'DD.MM.YYYY'));
  exception when others then
    --
    rollback to sp;
    --
    raise_application_error(-20000, get_error_msg());
    --
  end sync_acc_period_transactions2;


  ----
  -- sync_swift_banks - синхронизация swift_banks (1 источник)
  --
  procedure sync_swift_banks is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_SWIFT_BANKS);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_SWIFT_BANKS, g_global_name, l_scn);
        --
        -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
        rpc_sync.instantiate_now(TAB_SWIFT_BANKS);
        --
        write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_INPROGRESS, 'видалення даних в БД АБС');
        --
        delete
          from swift_banks;
        --
        write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_INPROGRESS, 'видалення даних в БД corp2');
        --
        rpc_sync.erase_swift_banks();
        --
        write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_INPROGRESS, 'вставка даних в БД АБС');
        --
        insert
          into swift_banks(bic_id, name, office, city, country, closing_date)
        select bic, rtrim(name), rtrim(office), rtrim(city), rtrim(country), null
          from bars.sw_banks as of scn l_scn;
        --
        write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_INPROGRESS, 'вставка даних в БД corp2');
        --
        rpc_sync.fill_swift_banks();
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_swift_banks;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_SW_BANKS, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці SWIFT_BANKS');
        --
    exception when others then
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_swift_banks;

  ----
  -- sync_banks - синхронизация banks (1 источник)
  --
  procedure sync_banks is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_closing_date constant date := trunc(sysdate)-1;
    l_str   varchar2(200);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_BANKS, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_BANKS);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        -- проверка состояния пакета
        check_package_state();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_BANKS, g_global_name, l_scn);
        --
        -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
        rpc_sync.instantiate_now(TAB_BANKS);
        --
        write_sync_status(TAB_BANKS, JOB_STATUS_INPROGRESS, 'видалення даних в БД АБС');
        --
        delete
          from banks;
        --
        write_sync_status(TAB_BANKS, JOB_STATUS_INPROGRESS, 'видалення даних в БД corp2');
        --
        rpc_sync.erase_banks();
        --
        write_sync_status(TAB_BANKS, JOB_STATUS_INPROGRESS, 'вставка даних в БД АБС');
        --
        insert
          into banks(bank_id,name,closing_date)
        select mfo,nb,decode(blk,4,l_closing_date,null)
          from bars.banks as of scn l_scn
         where kodn is null or kodn<>4;
        --
        write_sync_status(TAB_BANKS, JOB_STATUS_INPROGRESS, 'вставка даних в БД corp2');
        --
        rpc_sync.fill_banks;
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_banks;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_BANKS, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці BANKS');
        --
    exception when others then
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_BANKS, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_BANKS, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_banks;

  ----
  -- sync_holidays - синхронизация holidays (1 источник)
  --
  procedure sync_holidays(p_startdate in date default trunc(sysdate-1)) is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_startdate date;
    l_scn   number;
  begin
    --
    write_sync_status(TAB_HOLIDAYS, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_HOLIDAYS);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        l_startdate := p_startdate;
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_HOLIDAYS, g_global_name, l_scn);
        --
        -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
        rpc_sync.instantiate_now(TAB_HOLIDAYS);
        --
        -- удаляем старые значения в локальной таблице
        delete
          from holidays
         where holiday>=l_startdate;
        -- удаляем старые значения в удаленной таблице
        rpc_sync.erase_holidays(l_startdate);
        -- вставляем новые в локальную таблицу
        insert
          into holidays(holiday, cur_id)
        select holiday, kv
          from bars.holiday as of scn l_scn
         where holiday>=l_startdate;
        -- вставляем новые в удаленную таблицу
        rpc_sync.fill_holidays(l_startdate);
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_holidays(l_startdate);
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_HOLIDAY, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці HOLIDAYS');
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_HOLIDAYS, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_HOLIDAYS, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_holidays;

  ----
  -- sync_currency_rates - синхронизация cur_rates
  --
  procedure sync_currency_rates(p_startdate in date default trunc(sysdate-1)) is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_CURRENCY_RATES, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_CURRENCY_RATES);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_CURRENCY_RATES, g_global_name, l_scn);
        --
        for c in (select kf from v_kf) loop
            --
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_CURRENCY_RATES, c.kf);
            --
            -- удаляем старые значения в локальной таблице
            delete
              from currency_rates
             where bank_id=c.kf
               and rate_date >= p_startdate;
            -- удаляем старые значения в удаленной таблице
            rpc_sync.erase_currency_rates(c.kf, p_startdate);
            -- вставляем новые в локальную таблицу
            insert
              into currency_rates(rate_date,bank_id,cur_id,base_sum,rate_official,rate_buying,rate_selling)
            select vdate, kf, kv, bsum, rate_o, rate_b, rate_s
              from v_kf_cur_rates as of scn l_scn
             where kf=c.kf
               and vdate >= p_startdate;
            -- вставка гривны
            begin
                insert
                  into currency_rates(rate_date,bank_id,cur_id,base_sum,rate_official)
                values (to_date('01.01.1900','DD.MM.YYYY'), c.kf, g_base_val, 1, 1);
            exception
                when dup_val_on_index then
                    null;
            end;
            -- вставляем новые в удаленную таблицу
            rpc_sync.fill_currency_rates(c.kf, p_startdate);
            -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
            rpc_sync.sync_currency_rates(c.kf, p_startdate, trunc(sysdate));
        end loop;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_CUR_RATES, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію курсів валют починаючи з дати '||to_char(p_startdate, 'DD.MM.YYYY'));
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_CURRENCY_RATES, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_CURRENCY_RATES, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_currency_rates;

  ----
  -- get_oldest_scn - возвращает последний обработанный SCN,
  -- начиная с данного номера будет возобновлен захват изменений
  -- предполагается, что остановлены capture и apply процессы
  --
  function get_oldest_scn return number
  is
    l_scn   number;
  begin
    begin
        l_scn := dbms_flashback.get_system_change_number();
        -- На время проблем со стримсами в ММФО будем брать текущий scn,
        -- поскольку oldest_message_number и select applied_message_number не обновляются
        -- select oldest_message_number
        /*select applied_message_number
          into l_scn
          from dba_apply_progress
         where apply_name = CB_APPLY;*/
        -- если здесь пусто, тогда не знаю как быть
        if l_scn is null or l_scn = 0
        then
            raise_application_error(-20000, 'Точку відліку визначити неможливо. Зверніться до розробника.');
        end if;
    exception
        when no_data_found then
            raise_application_error(-20000, 'Відсутній процес CB_APPLY. Точкова синхронізація неможлива.');
    end;
    --
    return l_scn;
    --
  end get_oldest_scn;

  ----
  -- sync_account_stmt2 - синхронизирует историю движения по счетам
  -- @param p_acc - acc счета, null - по всем
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_account_stmt2(
    p_acc       in number default null,
    p_startdate in date default trunc(sysdate-1))
  is
    l_local_tag     raw(2000);
    l_remote_tag    raw(2000);
    l_scn           number;
    l_acc_msg       varchar2(128);
    l_startdate     date := p_startdate;
    l_dapp          date; -- дата последнего движения по счету
    l_tx            boolean;
    l_bankid        acc_turnovers.bank_id%type;
    l_accnum        acc_turnovers.acc_num%type;
    l_curid         acc_turnovers.cur_id%type;
  begin
    -- проверка: apply-процесс должен быть остановлен всегда
    --           capture - только для точечной синхронизации
    /*check_requirements(
        TAB_ACC_TRANSACTIONS,
        p_check_capture => case
                           when p_acc is not null then
                                true
                           else
                                false
                           end
    );*/
    --
    -- точка отсчета
    if p_acc is null
    then -- по всем счетам до текущей точки
        l_scn := dbms_flashback.get_system_change_number();
        l_acc_msg := 'по всіх рахунках';
    else
        -- по конкретному счету до последней точки, пройденной apply-процессом
        -- с этой точки начнется захват данных после старта apply-процесса
        l_scn := get_oldest_scn();
        --
        select 'по рахунку '||nls||'('||to_char(kv)||')', dapp, kf, nls, kv
          into l_acc_msg, l_dapp, l_bankid, l_accnum, l_curid
          from v_kf_accounts
         where acc=p_acc;
       -- дату начала синхронизации берем не больше даты последнего движения по счету
       l_startdate := least(l_startdate, l_dapp);
       --
    end if;
    --
    write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_STARTED, l_acc_msg);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    --check_requirements(TAB_ACC_TRANSACTIONS);
    --
    begin
        -- точка отката
        savepoint sp;
        -- входим в транзакцию
        l_tx := true;
        --
        -- проверка состояния пакета
        check_package_state();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицы схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_ACC_TURNOVERS, g_global_name, l_scn);
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_ACC_TRANSACTIONS, g_global_name, l_scn);
        --
        -- устанавливаем(передвигаем) точку синхронизации для удаленных таблиц на текущий момент
        -- чтобы потоки на IBANK не применяли лишних данных
        if p_acc is null
        then
            for c in (select kf from v_kf)
            loop
                rpc_sync.manual_instantiate_now(TAB_ACC_TURNOVERS, c.kf);
                rpc_sync.manual_instantiate_now(TAB_ACC_TRANSACTIONS, c.kf);
            end loop;
        end if;

        -- синхронизируем обороты локально
        sync_acc_turnovers2(
            p_acc       => p_acc,
            p_startdate => l_startdate,
            p_scn       => l_scn);
        --
        -- синхронизируем проводки локально
        sync_acc_transactions2(
            p_acc       => p_acc,
            p_startdate => l_startdate,
            p_scn       => l_scn);
        --
        --
        -- очищаем удаленные временные таблицы(truncate в автономной транзакции)
        rpc_sync.trunc_tmp_table(TAB_ACC_TURNOVERS);
        rpc_sync.trunc_tmp_table(TAB_ACC_TRANSACTIONS);
        --
        logger.trace('Очищено віддалені тимчасові таблиці');
        --
        -- наполняем удаленные временные таблицы в текущей транзакции
        rpc_sync.fill_tmp_acc_turnovers(l_startdate, l_bankid, l_accnum, l_curid);
        rpc_sync.fill_tmp_acc_transactions(l_startdate, l_bankid, l_accnum, l_curid);
        --
        logger.trace('Наповнено віддалені тимчасові таблиці');
        --
        -- фиксируем изменения
        commit;
        --
        l_tx := false;
        --
        logger.trace('Транзакцію зафіксовано');
        --
        -- вот теперь самое важное -
        -- вызываем удаленную процедуру по синхронизации временных и постоянных таблиц на стороне IBANK
        -- в ней фиксируем транзакцию
        -- таким образом минимизируются блокировки постоянных таблиц
        --
        if p_acc is not null
        then
            -- по конкретному счету
            rpc_sync.sync_stmt(l_startdate, l_bankid, l_accnum, l_curid);
        else
            -- по всем счетам каждого МФО
            for c in (select kf from v_kf)
            loop
                -- bars_sync.subst_mfo(c.kf);
                -- bars.logger.info('debug:: sync_stmt c.kf=' || c.kf);
                rpc_sync.sync_stmt(l_startdate, c.kf, null, null);
            end loop;
        end if;
        --
        logger.trace('Виконано віддалену процедуру синхронізації тимчасових та перманентних таблиць');
        --
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицы в будущем
        -- только если синхронизация выполнялась по всем счетам сразу
        if p_acc is null and false -- temporary 02.06.2017
        then
            dbms_apply_adm.set_table_instantiation_scn(SRCTAB_SALDOA, g_global_name, l_scn);
            dbms_apply_adm.set_table_instantiation_scn(SRCTAB_OPLDOK, g_global_name, l_scn);
        end if;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію виписок починаючи з дати '
            ||to_char(p_startdate,'DD.MM.YYYY')||' '||l_acc_msg);
        --
    exception when others then
        --
        if l_tx
        then
            rollback to sp;
            l_tx := false;
        end if;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_SUCCEEDED, l_acc_msg);
    --
  exception when others then
    --
    write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_FAILED, l_acc_msg, SQLCODE, get_error_msg());
    --
  end sync_account_stmt2;


  ----
  -- sync_account_period_stmt2 - синхронизирует историю движения по счетам за указаный период
  -- @param p_acc - acc счета, null - по всем
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  -- @param p_finishdate - конечная дата
  --
  procedure sync_account_period_stmt2(
    p_acc       in number default null,
    p_startdate in date default trunc(sysdate-1),
    p_finishdate in date default trunc(sysdate))
  is
    l_local_tag     raw(2000);
    l_remote_tag    raw(2000);
    l_scn           number;
    l_acc_msg       varchar2(128);
    l_startdate     date := p_startdate;
    l_finishdate    date := p_finishdate;
    l_dapp          date; -- дата последнего движения по счету
    l_tx            boolean;
    l_bankid        acc_turnovers.bank_id%type;
    l_accnum        acc_turnovers.acc_num%type;
    l_curid         acc_turnovers.cur_id%type;
  begin
    -- проверка: apply-процесс должен быть остановлен всегда
    --           capture - только для точечной синхронизации
    /*check_requirements(
        TAB_ACC_TRANSACTIONS,
        p_check_capture => case
                           when p_acc is not null then
                                true
                           else
                                false
                           end
    );*/
    --
    -- точка отсчета
    if p_acc is null
    then -- по всем счетам до текущей точки
        l_scn := dbms_flashback.get_system_change_number();
        l_acc_msg := 'по всіх рахунках з ' || to_char(p_startdate,'DD.MM.YYYY') || ' по ' || to_char(p_finishdate,'DD.MM.YYYY');
    else
        -- по конкретному счету до последней точки, пройденной apply-процессом
        -- с этой точки начнется захват данных после старта apply-процесса
        l_scn := get_oldest_scn();
        --
        select 'по рахунку '||nls||'('||to_char(kv)||')', dapp, kf, nls, kv
          into l_acc_msg, l_dapp, l_bankid, l_accnum, l_curid
          from v_kf_accounts
         where acc=p_acc;
       -- дату начала синхронизации берем не больше даты последнего движения по счету
       l_startdate := least(l_startdate, l_dapp);
       --
    end if;
    --
    write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_STARTED, l_acc_msg);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    --check_requirements(TAB_ACC_TRANSACTIONS);
    --
    begin
        -- точка отката
        savepoint sp;
        -- входим в транзакцию
        l_tx := true;
        --
        -- проверка состояния пакета
        check_package_state();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицы схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_ACC_TURNOVERS, g_global_name, l_scn);
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_ACC_TRANSACTIONS, g_global_name, l_scn);
        --
        -- устанавливаем(передвигаем) точку синхронизации для удаленных таблиц на текущий момент
        -- чтобы потоки на IBANK не применяли лишних данных
        if p_acc is null
        then
            for c in (select kf from v_kf)
            loop
                rpc_sync.manual_instantiate_now(TAB_ACC_TURNOVERS, c.kf);
                rpc_sync.manual_instantiate_now(TAB_ACC_TRANSACTIONS, c.kf);
            end loop;
        end if;

        -- синхронизируем обороты локально
        sync_acc_period_turnovers2(
            p_acc       => p_acc,
            p_startdate => l_startdate,
            p_finishdate => l_finishdate,
            p_scn       => l_scn);
        --
        -- синхронизируем проводки локально
        sync_acc_period_transactions2(
            p_acc       => p_acc,
            p_startdate => l_startdate,
            p_finishdate => l_finishdate,
            p_scn       => l_scn);
        --
        --
        -- очищаем удаленные временные таблицы(truncate в автономной транзакции)
        rpc_sync.trunc_tmp_table(TAB_ACC_TURNOVERS);
        rpc_sync.trunc_tmp_table(TAB_ACC_TRANSACTIONS);
        --
        logger.trace('Очищено віддалені тимчасові таблиці');
        --
        -- наполняем удаленные временные таблицы в текущей транзакции
        rpc_sync.fill_tmp_acc_pr_turnovers(l_startdate, l_finishdate, l_bankid, l_accnum, l_curid);
        rpc_sync.fill_tmp_acc_pr_transactions(l_startdate, l_finishdate, l_bankid, l_accnum, l_curid);
        --
        logger.trace('Наповнено віддалені тимчасові таблиці');
        --
        -- фиксируем изменения
        commit;
        --
        l_tx := false;
        --
        logger.trace('Транзакцію зафіксовано');
        --
        -- вот теперь самое важное -
        -- вызываем удаленную процедуру по синхронизации временных и постоянных таблиц на стороне IBANK
        -- в ней фиксируем транзакцию
        -- таким образом минимизируются блокировки постоянных таблиц
        --
        if p_acc is not null
        then
            -- по конкретному счету
            rpc_sync.sync_period_stmt(l_startdate, l_finishdate, l_bankid, l_accnum, l_curid);
        else
            -- по всем счетам каждого МФО
            for c in (select kf from v_kf)
            loop
                rpc_sync.sync_period_stmt(l_startdate, l_finishdate, c.kf, null, null);
            end loop;
        end if;
        --
        logger.trace('Виконано віддалену процедуру синхронізації тимчасових та перманентних таблиць');
        --
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицы в будущем
        -- только если синхронизация выполнялась по всем счетам сразу
        if p_acc is null
        then
            dbms_apply_adm.set_table_instantiation_scn(SRCTAB_SALDOA, g_global_name, l_scn);
            dbms_apply_adm.set_table_instantiation_scn(SRCTAB_OPLDOK, g_global_name, l_scn);
        end if;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію виписок '||l_acc_msg);
        --
    exception when others then
        --
        if l_tx
        then
            rollback to sp;
            l_tx := false;
        end if;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_SUCCEEDED, l_acc_msg);
    --
  exception when others then
    --
    write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_FAILED, l_acc_msg, SQLCODE, get_error_msg());
    --
  end sync_account_period_stmt2;

  ----
  -- sync_account_stmt - синхронизирует историю движения по счету
  --
  -- @p_acc [in] - id счета в АБС
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_account_stmt(p_acc in integer, p_startdate in date default trunc(sysdate-1)) is
  begin
    sync_account_stmt2(p_acc, p_startdate);
  end sync_account_stmt;

  ----
  -- sync_account_period_stmt - синхронизирует историю движения по счету за период
  --
  -- @p_acc [in] - id счета в АБС
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  -- @param p_finishdate - банковская дата, конечная
  --
  procedure sync_account_period_stmt(p_acc in integer, p_startdate in date default trunc(sysdate-1), p_finishdate in date default trunc(sysdate)) is
  begin
    sync_account_period_stmt2(p_acc, p_startdate, p_finishdate);
  end sync_account_period_stmt;

  ----
  -- sync_account_stmt - синхронизирует историю движения по счету
  --
  -- @p_kf - код банка/филиала(МФО)
  -- @p_nls - номер лицевого счета
  -- @p_kv  - код валюты
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_account_stmt(
        p_kf  in varchar2,
        p_nls in varchar2,
        p_kv  in integer,
        p_startdate in date default trunc(sysdate-1))
  is
    l_acc  integer;
  begin
    begin
        select acc
          into l_acc
          from v_kf_accounts
         where kf=p_kf and nls=p_nls and kv=p_kv;
    exception when no_data_found then
        raise_application_error(-20000, 'Рахунок не знайдено: МФО='||p_kf||', Рахунок='||p_nls||', Валюта='||p_kv, true);
    end;
    sync_account_stmt(l_acc, p_startdate);
  end sync_account_stmt;

  ----
  -- sync_all_account_stmt - синхронизирует историю движения по всем счетам
  --
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure sync_all_account_stmt(p_startdate in date default trunc(sysdate-1)) is
  begin
    sync_account_stmt(p_acc => null, p_startdate => p_startdate);
  end sync_all_account_stmt;

  ----
  -- get_doc_xml - возвращает xml-представление документа из интернет-банкинга
  --               (путем вызова через dblink)
  -- @p_docid        - id документа
  --
  function get_doc_xml(p_docid in number) return xmltype
  is
  begin
    return rpc_sync.get_doc_xml(p_docid);
  end;

  ----
  -- import_documents_int - выполняет импорт документов
  --
  procedure import_documents_int(p_docs_count in out number) is
    l_title     constant varchar2(61) := 'data_import.import_documents';
    l_bankid    varchar2(6);
    l_type_list varchar2(256);
    l_docs      dbms_utility.number_array;
  begin
    logger.trace('%s: start', l_title);
    l_bankid := bars_sync.kf();
    l_type_list := '''P_INT'', ''P_SEP'', ''P_TRANS'', ''P_SWIFT'', ''I_REQUEST'', ''I_NOTICE''';
    l_type_list := l_type_list || ', ''I_CUREXCH''';
    -- получим список документов для экспорта
    rpc_sync.extract_doc_export(l_bankid, l_type_list, l_docs);
    -- общее к-во документов для импорта
    p_docs_count := p_docs_count + l_docs.count;
    --
    for i in 1..l_docs.count
    loop
        -- загружаем один документ
        import_document(l_docs(i));
        -- фиксируем транзакцию каждые 100 документов
        if mod(i, 100) = 0 then
            commit;
        end if;
    end loop;
    commit;
    logger.trace('%s: finish', l_title);
  end import_documents_int;

  ----
  -- import_documents - выполняет импорт документов
  --
  procedure import_documents is
  begin
    for c in (select kf from v_kf) loop
        bars_sync.subst_mfo(c.kf);
        import_documents_int(g_docs_count);
    end loop;
    bars_sync.set_context;
  exception when others then
    bars_sync.set_context;
    raise;
  end import_documents;

    ----
  -- import_documents - выполняет импорт документов
  --
  procedure import_documents_kf(p_kf  bars.mv_kf.kf%type) is
    l_scn           number;
    l_time          date;
    l_period        number;
    l_docs_count    number;
    l_error         varchar2(4000);
  begin

    l_time := sysdate;
    l_scn  := dbms_flashback.get_system_change_number();

    delete from import_activity where start_time<sysdate-1 and kf = p_kf;
    -- пишем время начала работы
    insert into import_activity(start_time, start_scn, kf)
    values(l_time, l_scn, p_kf);
    commit;

    l_docs_count := 0;

    bars_sync.subst_mfo(p_kf);
    import_documents_int(l_docs_count);

    -- вывод результатов
    -- фиксируем завершение работы
    l_period := round((sysdate-l_time)*24*60*60);
    l_scn    := dbms_flashback.get_system_change_number();

    update import_activity set working_period=decode(l_period,0,1,l_period), finish_scn=l_scn, system_error=null, docs_count=l_docs_count
    where start_time=l_time
      and kf = p_kf;
    commit;

    bars_sync.set_context;
  exception when others then
    -- откат на всякий случай
    rollback;
    -- фиксация ошибки
    l_period := round((sysdate-l_time)*24*60*60);
    l_scn    := dbms_flashback.get_system_change_number();
    --
    l_error := substr(get_error_msg(),1,4000);
    update import_activity
       set working_period=decode(l_period,0,1,l_period), finish_scn=l_scn, system_error=l_error
     where start_time=l_time
       and kf = p_kf;
    --
    logger.trace('ERROR:');
    logger.trace(get_error_msg());
    bars_sync.set_context;
    raise;
  end import_documents_kf;

  ----
  -- Возвращает значение атрибута в виде строки
  --
  function get_attr_varchar2(p_xml in xmltype, p_attr in varchar2) return varchar2 is
  begin
    return
            DBMS_XMLGEN.convert(
               p_xml.extract('/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="'||p_attr||'"]/text()').getStringVal(),
               DBMS_XMLGEN.ENTITY_DECODE);
  end;

  ----
  -- Возвращает значение атрибута в виде числа
  --
  function get_attr_number(p_xml in xmltype, p_attr in varchar2) return number is
  begin
    return to_number(get_attr_varchar2(p_xml, p_attr), g_number_format, g_number_nlsparam);
  end;

  ----
  -- Возвращает значение атрибута в виде даты
  --
  function get_attr_date(p_xml in xmltype, p_attr in varchar2) return date is
  begin
    return to_date(get_attr_varchar2(p_xml, p_attr), g_date_format);
  end;

  ----
  -- Возвращает флаг существования атрибута
  --
  function is_attr_exists(p_xml in xmltype, p_attr in varchar2) return boolean is
  begin
    if p_xml.existsNode('/ATTRIBUTES/ATTRIBUTE[@ATTR_ID="'||p_attr||'"]')=1 then
        return true;
    else
        return false;
    end if;
  end;

  ----
  -- Проверяет наличие обязательного атрибута
  -- В случае отсутствия такого атрибута выбрасывает исключение
  --
  procedure check_mandatory_attr(p_xml in xmltype, p_attr in varchar2) is
  begin
    if not is_attr_exists(p_xml, p_attr) then
        raise_application_error(-20000, 'Отсутствует обязательный атрибут '''||p_attr||'''', true);
    end if;
  end check_mandatory_attr;

  ------------------------------------------------------------------------------
  -- lock_document - блокирует документ в БД ibank
  -- @p_docid - id документа
  -- @return true/false
  --
  function lock_document(p_docid in number) return boolean is
    l_num           number;
    app_error exception;
    pragma exception_init(app_error, -20000);
  begin
    rpc_sync.lock_document(p_docid, STATUS_RESIGNED);
    return true;
  exception when app_error then
    logger.error(dbms_utility.format_error_stack());
    return false;
  end lock_document;

  ------------------------------------------------------------------------------
  -- set_status_info - устанавливает статус док-та в БД ibank
  --
  procedure set_status_info(
    p_docid                   number,
    p_statusid                number   default null,
    p_status_change_time      date     default sysdate,
    p_bank_accept_date        date     default null,
    p_bank_ref                varchar2 default null,
    p_bank_back_date          date     default null,
    p_bank_back_reason        varchar2 default null,
    p_bank_back_reason_aux    varchar2 default null,
    p_bank_syserr_date        date     default null,
    p_bank_syserr_msg         varchar2 default null,
    p_is_open                 number   default null)
  is
    l_local_tag raw(2000); l_remote_tag raw(2000);
  begin
    -- точка отката
    savepoint sp;
    --
    replace_tags(l_local_tag, l_remote_tag);
    --
    -- модифицируем локальную таблицу
    update doc_export set
        status_id               = nvl(p_statusid, status_id),
        status_change_time      = p_status_change_time,
        bank_accept_date        = nvl(p_bank_accept_date, bank_accept_date),
        bank_ref                = p_bank_ref,
        bank_back_date          = p_bank_back_date,
        bank_back_reason        = p_bank_back_reason,
        bank_back_reason_aux    = p_bank_back_reason_aux,
        bank_syserr_date        = p_bank_syserr_date,
        bank_syserr_msg         = p_bank_syserr_msg
    where doc_id=p_docid;
    -- модифицируем удаленную таблицу
    if p_is_open = 1 then
      rpc_sync.update_doc_export_status_open(p_docid);
    else
      rpc_sync.update_doc_export_status(p_docid);
    end if;
    --
    restore_tags(l_local_tag, l_remote_tag);
    --
  exception when others then
    rollback to sp;
    --
    restore_tags(l_local_tag, l_remote_tag);
    --
    raise_application_error(-20000, get_error_msg());
    --
  end set_status_info;

  ----
  -- Транслитерация реквизитов swift-платежа
  --
  function trans_value(p_value in varchar2, kv in number) return varchar2 is
  l_value varchar2(200);
  begin
    l_value := substr(replace(p_value,'$nl$',chr(13)||chr(10)),1,200);

    -- замена укр. букв на соответствующие латинские (из-за проблем с транслитерацией)
    l_value := replace(l_value, 'і', 'i');
    l_value := replace(l_value, 'І', 'I');

    if kv!=643 then
        l_value := substr(bars.bars_swift.StrToSwift(l_value,'TRANS'),1,200);
    end if;
    return l_value;
  end;


---------------------------------------------------------------------------
  --  CHECK_AUTOPAY_RULE
  --
  --  Проверка проходит ли платеж правила на автооплату документа
  --  1 -  прошла проверка, значит платеж должен пройти автооплату
  --  0 -  не прошла проверка, платеж пойдет по стандартной цепочке визирования
  ---------------------------------------------------------------------------
  function check_autopay_rule (l_doc doc_import%rowtype) return smallint
  is
  begin
     return bars.sdo_autopay_check_corp2(l_doc);
  end;



----
  ----
  -- import_payment - выполняет импорт платежного документа
  --
  -- возвращает положительный статус импорта
  -- в случае ошибки выбрасывает исключение
  --
  function import_payment(p_xml in xmltype) return integer is
    l_title         constant varchar2(61) := 'data_import.import_payment';
    l_num           number;
    l_payer_acc     integer;
    l_header        xmltype;
    l_body          xmltype;
    l_sign          xmltype;
    l_doc           doc_import%rowtype;
    l_prop          doc_import_props%rowtype;
    l_denom         number;
    l_typeid        varchar2(12);
    l_docid         integer;
    l_creatingdate  date;
    l_date          date;
    l_acc           bars.accounts.acc%type;
    l_acc_a_rec     bars.accounts%rowtype;
    l_acc_b_rec     bars.accounts%rowtype;
    l_narrative_rows    integer;
    l_narrative_rownum  varchar2(2);
    l_narrative_attr    varchar2(30);
    l_narrative_value   varchar2(4000);
    l_visaid        integer;
    l_visa_fullname xmltype;
    l_visa_date     xmltype;
    l_visa_key      xmltype;
    l_docbuf        varchar2(1024);
    l_abs_sign      xmltype;
    l_nbsa          varchar2(4);
    l_nbsb          varchar2(4);
    l_blank_id_code varchar2(10) := '0000000000';
    l_blank_id_code9 varchar2(10) := '000000000';
    l_sideA_tag     doc_import_props.tag%type := 'Ф';
    l_sideB_tag     doc_import_props.tag%type := 'ф';
    l_blank_ser     varchar2(100);
    l_blank_num     varchar2(100);
    l_bank_id       varchar2(100);
    l_is_nls_closed number(1);
    l_cnt           number;
    --
    numeric_value_error exception;
    pragma exception_init(numeric_value_error, -6502);
    --
  begin
    --
    logger.trace('%s: start', l_title);
    --
    -- вычленяем заголовок и тело документа
    l_header   := p_xml.extract('/SIGNED_DOCUMENT/DOCUMENT/HEADER');
    l_body     := p_xml.extract('/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES');
    l_sign     := p_xml.extract('/SIGNED_DOCUMENT/SIGNATURES/SIGNATURE');
    l_abs_sign := p_xml.extract('/SIGNED_DOCUMENT/ABS_SIGNATURE');
    -- doc_id
    l_docid  := l_header.extract('/HEADER/@DOC_ID').getNumberVal();
    -- type_id
    l_typeid := l_header.extract('/HEADER/@TYPE_ID').getStringVal();
    -- проверка наличия подписи АБС
    if l_abs_sign is null then
        raise_application_error(-20000, 'Підпис АБС відсутній, doc_id='||l_docid, true);
    end if;
    -- извлекаем ключ и подпись АБС
    l_doc.id_o := substr(DBMS_XMLGEN.convert(
                            l_abs_sign.extract('/ABS_SIGNATURE/KEY/text()').getStringVal(),
                         DBMS_XMLGEN.ENTITY_DECODE),
                  3,6);
    l_doc.sign := hextoraw(DBMS_XMLGEN.convert(
                            l_abs_sign.extract('/ABS_SIGNATURE/SIGN/text()').getStringVal(),
                           DBMS_XMLGEN.ENTITY_DECODE)
                  );
    -- проверка наличия общих обязательных реквизитов
    check_mandatory_attr(l_body, 'DOC_SUM');
    check_mandatory_attr(l_body, 'DOC_NARRATIVE');
    check_mandatory_attr(l_body, 'DOC_DATE');
    check_mandatory_attr(l_body, 'DOC_NUMBER');
    --
    check_mandatory_attr(l_body, 'PAYER_BANK_CODE');
    check_mandatory_attr(l_body, 'PAYER_ACCOUNT');
    check_mandatory_attr(l_body, 'PAYER_NAME');
    check_mandatory_attr(l_body, 'PAYER_TAX_CODE');
    --
    if l_typeid in ('P_INT','P_SEP','P_TRANS') then
        check_mandatory_attr(l_body, 'PAYEE_ACCOUNT');
        check_mandatory_attr(l_body, 'PAYEE_NAME');
        check_mandatory_attr(l_body, 'PAYEE_TAX_CODE');
    end if;
    -- чтение общих атрибутов
    -- получим валюту
    if is_attr_exists(l_body, 'DOC_CURRENCY') then
        l_doc.kv    := get_attr_number(l_body, 'DOC_CURRENCY');
    else
        l_doc.kv    := g_base_val;
    end if;
    -- выставляем вид документа
    IF l_typeid = 'P_SWIFT'
    THEN
      l_doc.vob       := g_vob_national; --case when l_doc.kv=g_base_val then g_vob_national else g_vob_foreign end;
    ELSE
      l_doc.vob       := case when l_doc.kv=g_base_val then g_vob_national else g_vob_foreign end;
    END IF;
    -- узнаем делитель валюты (10^dig)
    select denom into l_denom from bars.tabval where kv=l_doc.kv;
    -- получим сумму и умножим на делитель
    l_doc.s         := get_attr_number(l_body, 'DOC_SUM')*l_denom;
    -- назначение платежа
    l_doc.nazn      := substr(get_attr_varchar2(l_body, 'DOC_NARRATIVE'),1,160);
    -- дата документа
    l_doc.datd      := get_attr_date(l_body, 'DOC_DATE');
    -- номер документа
    l_doc.nd        := substr(get_attr_varchar2(l_body, 'DOC_NUMBER'), 1, 10);
    -- заполняем реквизиты стороны А
    l_doc.mfo_a     := get_attr_varchar2(l_body, 'PAYER_BANK_CODE');
    l_doc.nls_a     := get_attr_varchar2(l_body, 'PAYER_ACCOUNT');
    l_doc.nam_a     := trim(get_attr_varchar2(l_body, 'PAYER_NAME'));
    l_doc.id_a      := get_attr_varchar2(l_body, 'PAYER_TAX_CODE');
    -- спецобработка переводов между своими счетами
    if l_typeid='P_TRANS' then
        -- проверка наличия обязательных только для данной операции атрибутов
        check_mandatory_attr(l_body, 'PAYEE_BANK_CODE');
        --
        l_doc.mfo_b     := get_attr_varchar2(l_body, 'PAYEE_BANK_CODE');
        --
        if l_doc.mfo_a=l_doc.mfo_b then
            l_typeid := 'P_INT';
        else
            l_typeid := 'P_SEP';
        end if;
    end if;
    -- вычленяем дату создания
    l_creatingdate := to_date(replace(substr(
                              l_header.extract('/HEADER/@CREATING_TIMESTAMP').getStringVal(),
                              1, 19), 'T', ' '), 'YYYY-MM-DD HH24:MI:SS');
    -- заполняем внешний референс документа
    l_doc.ext_ref   := to_char(l_docid);
    -- и другие общие параметры
    begin
        begin  
           select /*+ INDEX UK_ACCOUNTS_KF_NLS_KV*/ acc, isp into l_acc, l_doc.userid from v_kf_accounts
            where kf=l_doc.mfo_a and nls=l_doc.nls_a and kv=l_doc.kv;
         exception when no_data_found then
           select /*+ INDEX IDX_ACCOUNTS_NLSALT_KV*/ acc, isp into l_acc, l_doc.userid from v_kf_accounts
            where kf=l_doc.mfo_a and nlsalt =l_doc.nls_a and kv=l_doc.kv;
        end;
        if l_doc.userid is null then
            raise_application_error(-20000, 'Караул! Рахунок без виконавця: kf='||l_doc.mfo_a||', nls='||l_doc.nls_a||', kv='||l_doc.kv, true);
        end if;
    exception when no_data_found then
        raise_application_error(-20000, 'Рахунок платника не знайдено: kf='||l_doc.mfo_a||', nls='||l_doc.nls_a||', kv='||l_doc.kv, true);
    end;
    -- ищем пользователя, которому могли делегировать права исполнителя
    begin
        select id_who
          into l_doc.userid
          from bars.staff_substitute
         where id_whom = l_doc.userid
           and bars.date_is_valid(date_start, date_finish, null, null)=1;
    exception
        when no_data_found then
            null;
        when too_many_rows then
            raise_application_error(-20000, 'Невизначена ситуація: права делеговано кільком користувачам.');
    end;
    l_doc.dk        := 1;
    -- для всех доп.реквизитов ставим внешний референс
    l_prop.ext_ref  := l_doc.ext_ref;
    --
    -- заполняем реквизиты стороны Б для внутрибанка и межбанка
    --
    if l_typeid in ('P_INT','P_SEP','I_REQUEST','I_NOTICE')
    then
        if l_typeid in ('P_SEP','I_REQUEST','I_NOTICE')
        then
            begin
                l_doc.mfo_b     := get_attr_varchar2(l_body, 'PAYEE_BANK_CODE');
            exception
                when numeric_value_error then
                    raise_application_error(-20000, 'Код банку отримувача занадто довгий');
            end;
        else
            l_doc.mfo_b     := l_doc.mfo_a;
        end if;
        begin
            l_doc.nls_b     := get_attr_varchar2(l_body, 'PAYEE_ACCOUNT');
        exception
            when numeric_value_error then
                raise_application_error(-20000, 'Рахунок отримувача занадто довгий');
        end;

        -- перевірка рахунка отримувача
        begin
          begin 
            select /*+ INDEX UK_ACCOUNTS_KF_NLS_KV*/ case when a.dazs is not null then 1 else 0 end into l_is_nls_closed from v_kf_accounts a where kf=l_doc.mfo_b and a.nls = l_doc.nls_b and kv=l_doc.kv;
           exception when no_data_found then
            select /*+ INDEX IDX_ACCOUNTS_NLSALT_KV*/ case when a.dazs is not null then 1 else 0 end into l_is_nls_closed from v_kf_accounts a where kf=l_doc.mfo_b and a.nlsalt = l_doc.nls_b and kv=l_doc.kv;
          end;

          if l_is_nls_closed = 1 then
            raise_application_error(-20000, 'Рахунок отримувача закритий');
          end if;
        exception
          when no_data_found then
            null;
          when others then
            raise;
        end;

        begin
            l_doc.nam_b     := get_attr_varchar2(l_body, 'PAYEE_NAME');
        exception
            when numeric_value_error then
                raise_application_error(-20000, 'Назва отримувача занадто довга');
        end;
        begin
            l_doc.id_b      := get_attr_varchar2(l_body, 'PAYEE_TAX_CODE');
        exception
            when numeric_value_error then
                raise_application_error(-20000, 'Код отримувача занадто довгий');
        end;

        -- дата валютирования
        if is_attr_exists(l_body, 'VALUE_DATE') then
            l_doc.vdat  := get_attr_date(l_body, 'VALUE_DATE');
        end if;
        -- вычленяем балансовые счета
        l_nbsa := substr(l_doc.nls_a, 1, 4);
        l_nbsb := substr(l_doc.nls_b, 1, 4);

        select count(*)
          into l_cnt
          from bars.accounts a
         where (a.nls = l_doc.nls_a or 
                a.nlsalt = l_doc.nls_a)
           and ((a.nbs = 2600 and a.ob22 = 14)
             or (a.nbs = 2650 and a.ob22 = 12));
         if l_cnt > 0 then
           raise_application_error(-20000, ' Счета БПК 2600/14 и 2650/12 заблокированы для списания!!!');
         end if;

    end if;
    --
    -- внутренний документ
    if     l_typeid = 'P_INT' then
        logger.trace('internal document');

        -- дата вставки
        l_doc.insertion_date := sysdate;
        -- контроль идентификационного кода получателя
        declare
            l_idb      bars.customer.okpo%type;
            l_idb_bank bars.customer.okpo%type;
        begin
          begin 
              select trim(c.okpo), (select trim(val) from bars.params$base where par='OKPO' and kf=l_doc.mfo_b) into l_idb, l_idb_bank from bars.customer c, v_kf_accounts a
                  where c.rnk=a.rnk and a.kf=l_doc.mfo_b and a.nls=l_doc.nls_b  and a.kv=l_doc.kv;
           exception when no_data_found then    
             select trim(c.okpo), (select trim(val) from bars.params$base where par='OKPO' and kf=l_doc.mfo_b) into l_idb, l_idb_bank from bars.customer c, v_kf_accounts a
                  where c.rnk=a.rnk and a.kf=l_doc.mfo_b and a.nlsalt = l_doc.nls_b  and a.kv=l_doc.kv;
          end;    
            if l_idb<>l_doc.id_b and l_idb_bank<>l_doc.id_b then
                raise_application_error(-20000,
                    'Ідентифікаційний код отримувача задано невірно, правильний код = '''||l_idb||''' або '''||l_idb_bank||'''', true);
            end if;
        exception when no_data_found then
            raise_application_error(-20000, 'Отримувача не знайдено: Банк='
                ||l_doc.mfo_b||', Рахунок='||l_doc.nls_b||', Валюта='||l_doc.kv, true);
        end;

		    begin 
            select *
              into l_acc_a_rec
              from bars.accounts
             where nls = l_doc.nls_a
               and kv = l_doc.kv;
         exception when no_data_found then
           select *
              into l_acc_a_rec
              from bars.accounts
             where nlsalt = l_doc.nls_a
               and kv = l_doc.kv;
        end;
        begin 
            select *
              into l_acc_b_rec
              from bars.accounts
             where nls = l_doc.nls_b
               and kv = nvl(l_doc.kv2, l_doc.kv);
         exception when no_data_found then
            select *
              into l_acc_b_rec
              from bars.accounts
             where nlsalt = l_doc.nls_b
               and kv = nvl(l_doc.kv2, l_doc.kv);
        end;
        --
        -- вычисляем код операции
       -- if    l_nbsa in ('2605','2625') and l_nbsb in ('2605','2625')
        if l_acc_a_rec.tip like 'W4%' and l_acc_b_rec.tip like 'W4%'
        then
            l_doc.tt := 'IB6'; -- Internet-Banking: Переказ між карт.рахунками
            --
      --  elsif l_nbsa in ('2605','2625') and l_nbsb not in ('2605','2625')
        elsif l_acc_a_rec.tip like 'W4%' and l_acc_b_rec.tip not like 'W4%'
        then
            l_doc.tt := 'IB3'; -- Internet-Banking: Списання з карт.рахунку внутрішнє
            --
       -- elsif l_nbsa not in ('2605','2625') and l_nbsb in ('2605','2625','2655')
        elsif l_acc_a_rec.tip not like 'W4%' and l_acc_b_rec.tip like 'W4%'
        then
            l_doc.tt := 'IB5'; -- Internet-Banking: Поповнення карт.рахунку внутрішнє
            --
        else
            l_doc.tt := 'IB1'; -- Internet-Banking: Внутрішня
            --
        end if;

		 -- Перед вставкой  нужно пройти правило для проверки автооплаты.
        l_doc.flg_auto_pay := check_autopay_rule(l_doc);

        -- вставляем док-т в таблицу doc_import
        insert into doc_import values l_doc;
    -- документ в СЭП/ВПС
    elsif  l_typeid='P_SEP' then
        logger.trace('interbank document');
        -- проверка наличия обязательных только для данной операции атрибутов
        check_mandatory_attr(l_body, 'PAYEE_BANK_CODE');

        begin 
            select *
              into l_acc_a_rec
              from bars.accounts a
             where a.nls = l_doc.nls_a
               and a.kv = l_doc.kv
               and a.dazs is null;
          exception when no_data_found then
            select *
              into l_acc_a_rec
              from bars.accounts a
             where a.nlsalt = l_doc.nls_a
               and a.kv = l_doc.kv
               and a.dazs is null;
        end;
        --
        -- вычисляем код операции
       -- if l_nbsa in ('2605','2625')
        if l_acc_a_rec.tip like 'W4%'
        then
            l_doc.tt := 'IB4'; -- Internet-Banking: Списання з карт.рахунку міжбанк
            --
        else
            l_doc.tt := 'IB2'; -- Internet-Banking: СЕП
            --
        end if;

        -- признак срочности документа: СЕП/ССП
        if is_attr_exists(l_body, 'DOC_PRIORITY') then
            l_doc.prty  := get_attr_number(l_body, 'DOC_PRIORITY');
        end if;
        -- дата вставки
        l_doc.insertion_date := sysdate;

-- Перед вставкой  нужно пройти правило для проверки автооплаты.
        l_doc.flg_auto_pay := check_autopay_rule(l_doc);

        -- вставляем док-т в таблицу doc_import
        insert into doc_import values l_doc;
        -- дата валютирования в СЭП
        if is_attr_exists(l_body, 'VALUE_DATE_SEP') then
            l_date          := get_attr_date(l_body, 'VALUE_DATE_SEP');
            l_prop.tag      := 'D';
            l_prop.value    := to_char(l_date, 'YYMMDD');
            --
            insert into doc_import_props values l_prop;
        end if;
    elsif  l_typeid in ('I_REQUEST','I_NOTICE') then
        logger.trace('informational document');
        -- проверка наличия обязательных только для данной операции атрибутов
        check_mandatory_attr(l_body, 'PAYEE_BANK_CODE');
        --
        -- вычисляем код операции
        if l_typeid = 'I_REQUEST'
        then
            l_doc.tt := 'IB8';
            l_doc.dk := 2;
            --
        else if l_typeid = 'I_NOTICE'
        then
            l_doc.tt := 'IB9';
            l_doc.dk := 3;
            --
        end if;
        end if;

        -- дата вставки
        l_doc.insertion_date := sysdate;

-- Перед вставкой  нужно пройти правило для проверки автооплаты.
        l_doc.flg_auto_pay := check_autopay_rule(l_doc);
        -- вставляем док-т в таблицу doc_import
        insert into doc_import values l_doc;
    -- SWIFT документ
    elsif  l_typeid='P_SWIFT' then
        logger.trace('swift document');
        -- проверка наличия обязательных только для данной операции атрибутов
        check_mandatory_attr(l_body, 'DOC_CURRENCY');
        check_mandatory_attr(l_body, 'SWIFT_71A');

        case get_attr_varchar2(l_body, 'SWIFT_71A')
          when ('BEN') then
            l_doc.tt        := 'IBB';
          when ('OUR') then
            l_doc.tt        := 'IBO';
          when ('SHA') then
            l_doc.tt        := 'IBS';
        end case;

        if ( g_c2sw_bnk is null or g_c2sw_nls is null or g_c2sw_nam is null or g_c2sw_cod is null ) then
            -- вычитать параметры свифтовых операций если раньше они не вычитывались
            select val into g_c2sw_bnk from bars.params where par='C2SW.BNK';
            select val into g_c2sw_nls from bars.params where par='C2SW.NLS';
            select val into g_c2sw_nam from bars.params where par='C2SW.NAM';
            select val into g_c2sw_cod from bars.params where par='C2SW.COD';
        end if;

        -- заполняем реквизиты стороны Б
        l_doc.mfo_b := g_c2sw_bnk;
        l_doc.nls_b := g_c2sw_nls;
        l_doc.nam_b := g_c2sw_nam;
        l_doc.id_b  := g_c2sw_cod;

        -- дата валютирования
        if is_attr_exists(l_body, 'VALUE_DATE') then
            l_doc.vdat  := get_attr_date(l_body, 'VALUE_DATE');
        end if;
        -- признак срочности документа: СЕП/ССП
        if is_attr_exists(l_body, 'DOC_PRIORITY') then
            l_doc.prty  := get_attr_number(l_body, 'DOC_PRIORITY');
        end if;
        -- дата вставки
        l_doc.insertion_date := sysdate;

 	    -- Перед вставкой  нужно пройти правило для проверки автооплаты.
        l_doc.flg_auto_pay := check_autopay_rule(l_doc);

        -- вставляем док-т в таблицу doc_import
        insert into doc_import values l_doc;

                -- вставляем реквизит MT103
        l_prop.tag      := 'f';
        l_prop.value    := 'MT 103';
        insert into doc_import_props values l_prop;

        -- вставляем реквизит NOS_A
        l_prop.tag      := 'NOS_A';
        l_prop.value    := '0';
        insert into doc_import_props values l_prop;

        -- реквизит 20
        if is_attr_exists(l_body, 'SWIFT_20') then
            l_prop.tag      := '20';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_20'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 33B
        if is_attr_exists(l_body, 'SWIFT_33B') then
            l_prop.tag      := '33B';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_33B'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;

        -- реквизит 50K
        if is_attr_exists(l_body, 'SWIFT_50K') then
            l_prop.tag      := '50K';
            -- новая затребованая фича - для платежей в 840 и 978 шлем как 50F
            -- додав злоті, заявка COBUMMFO-8001
            if l_doc.kv in (840, 978, 985) then
                l_prop.tag      := '50F';
            end if;
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_50K'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;

        -- реквизит 50F
        if is_attr_exists(l_body, 'SWIFT_50F') then
            l_prop.tag      := '50F';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_50F'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;

        -- реквизит 52A
        if is_attr_exists(l_body, 'SWIFT_52A') then
            l_prop.tag      := '52A';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_52A'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 52D
        if is_attr_exists(l_body, 'SWIFT_52D') then
            l_prop.tag      := '52D';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_52D'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 56A
        if is_attr_exists(l_body, 'SWIFT_56A') then
            l_prop.tag      := '56A';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_56A'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 57A
        if is_attr_exists(l_body, 'SWIFT_57A') then
            l_prop.tag      := '57A';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_57A'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 57D
        if is_attr_exists(l_body, 'SWIFT_57D') then
            l_prop.tag      := '57D';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_57D'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 59
        if is_attr_exists(l_body, 'SWIFT_59') then
            l_prop.tag      := '59';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_59'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 70
        if is_attr_exists(l_body, 'SWIFT_70') then
            l_prop.tag      := '70';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_70'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 71A
        if is_attr_exists(l_body, 'SWIFT_71A') then
            l_prop.tag      := '71A';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_71A'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 71F
        if is_attr_exists(l_body, 'SWIFT_71F') then
            l_prop.tag      := '71F';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_71F'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквизит 72
        if is_attr_exists(l_body, 'SWIFT_72') then
            l_prop.tag      := '72';
            l_prop.value    := trans_value(get_attr_varchar2(l_body, 'SWIFT_72'), l_doc.kv);
            --
            insert into doc_import_props values l_prop;
        end if;
        -- реквізит кількість доданих супровідних документів, в xml - реквізит  ATTACHMENT_MAILID - id листа в corp2 з вкладенням
        if is_attr_exists(l_body, 'ATTACHMENT_MAILID') then
            l_prop.tag      := 'ATT_D';
            l_prop.value    := '1';
            --
            insert into doc_import_props values l_prop;
        end if;

    end if;
    -- разбираемся со строками БИС
    if l_typeid in ('P_INT', 'P_SEP', 'P_TRANS') then
        -- строки БИС присутствуют ?
        if is_attr_exists(l_body, 'DOC_NARRATIVE_ROWS') then
            -- читаем кол-во строк
            l_narrative_rows := get_attr_number(l_body, 'DOC_NARRATIVE_ROWS');
            -- сохраняем строки в виде доп.реквизитов
            for i in 2..l_narrative_rows loop
                l_narrative_rownum := lpad(to_char(i),2,'0');
                l_narrative_attr   := 'DOC_NARRATIVE_'||l_narrative_rownum;
                if not is_attr_exists(l_body, l_narrative_attr) then
                    raise_application_error(-20000, 'Не знайдено реквізит '||l_narrative_attr, true);
                end if;
                l_narrative_value := get_attr_varchar2(l_body, l_narrative_attr);
                if length(l_narrative_value) > 160+60-3 then
                    raise_application_error(-20000, 'Довжина реквізиту '||l_narrative_attr||' перевищує допустиму 160+60-3', true);
                end if;
                l_prop.tag      := 'C'||lpad(to_char(i-1),2,'0')||'  ';
                l_prop.value    := l_narrative_value;
                --
                insert into doc_import_props values l_prop;
            end loop;
        end if;
    end if;
    -- сохраняем историю визирования документа в corp2
    l_visaid := 1;
    while l_visaid<=9 and l_sign.existsNode('/SIGNATURE[@VISA_ID="'||l_visaid||'"]')=1
    loop
        -- формируем строку для значения допреквизита
        l_prop.tag      := 'IBV'||lpad(to_char(l_visaid),2,'0');
        l_visa_fullname := l_sign.extract('/SIGNATURE[@VISA_ID="'||l_visaid||'"]/@USER_FULLNAME');
        l_visa_key      := l_sign.extract('/SIGNATURE[@VISA_ID="'||l_visaid||'"]/@KEY_ID');
        l_visa_date     := l_sign.extract('/SIGNATURE[@VISA_ID="'||l_visaid||'"]/@VISA_DATE');
        l_prop.value    := substr(
            case
            when l_visa_fullname is not null then DBMS_XMLGEN.convert(l_visa_fullname.getStringVal(),DBMS_XMLGEN.ENTITY_DECODE)
            else null
            end
            ||', ключ '||
            case
            when l_visa_key is not null then DBMS_XMLGEN.convert(l_visa_key.getStringVal(),DBMS_XMLGEN.ENTITY_DECODE)
            else null
            end
            ||', час '||
            case
            when l_visa_date is not null then
                to_char(to_date(replace(substr(l_visa_date.getStringVal(),1, 19), 'T', ' '),'YYYY-MM-DD HH24:MI:SS'),'DD.MM.YYYY HH24:MI:SS')
            else null
            end
            ,1,200);
        insert into doc_import_props values l_prop;
        l_visaid := l_visaid + 1;
    end loop;
    -- дополнительные реквизиты: время создания документа в Internet-banking
    l_prop.tag      := 'IBTIM';
    l_prop.value    := to_char(l_creatingdate, 'DD.MM.YYYY HH24:MI:SS');
    --
    insert into doc_import_props values l_prop;

    -- обрабатываем ид.код получателя 10 нулей - строна B
    if l_doc.id_b = l_blank_id_code then
        check_mandatory_attr(l_body, 'DOC_SER_PASS');
        check_mandatory_attr(l_body, 'DOC_NUM_PASS');
        l_prop.tag      := l_sideB_tag;
        l_prop.value    := 'серія ' || get_attr_varchar2(l_body, 'DOC_SER_PASS') || ' номер ' || get_attr_varchar2(l_body, 'DOC_NUM_PASS');
        insert into doc_import_props values l_prop;
    end if;

    -- обрабатываем ид.код получателя 10 нулей - строна A
    if l_doc.id_a = l_blank_id_code /* or l_doc.id_a = l_blank_id_code9*/ then
        begin     
            begin
                select ser, numdoc into l_blank_ser, l_blank_num from bars.person p, bars.customer c, v_kf_accounts a
                 where c.rnk=a.rnk and p.rnk=c.rnk and a.kf=l_doc.mfo_a and a.nls=l_doc.nls_a and a.kv=l_doc.kv;
         
             exception when no_data_found then
                select ser, numdoc into l_blank_ser, l_blank_num from bars.person p, bars.customer c, v_kf_accounts a
                 where c.rnk=a.rnk and p.rnk=c.rnk and a.kf=l_doc.mfo_a and a.nlsalt=l_doc.nls_a and a.kv=l_doc.kv;
            end;
               
         exception when no_data_found then
            raise_application_error(-20000, 'Для власника рахунку '||l_doc.nls_a||'('||l_doc.kv||') не знайдено паспортних данних', true);
        end;
        if (l_blank_ser is null or l_blank_num is null) then
            raise_application_error(-20000, 'Для власника рахунку '||l_doc.nls_a||'('||l_doc.kv||') не вказано серію та номер паспорту', true);
        end if;
        l_prop.tag      := l_sideA_tag;
        l_prop.value    := 'серія ' || l_blank_ser || ' номер ' || l_blank_num;
        insert into doc_import_props values l_prop;
    end if;
    --
    -- помечаем документ к оплате
    bars_docsync.confirm_document(l_doc.ext_ref);
    --
    logger.trace('%s: finish', l_title);
    --
    return STATUS_RECV_BANK;
    --
  end import_payment;

  ----
  -- import_curexch - выполняет импорт заявки на куплю/продажу валюты
  --
  -- возвращает положительный статус импорта
  -- в случае ошибки выбрасывает исключение
  --
  function import_curexch(p_xml in xmltype) return integer is
    l_title         constant varchar2(61) := 'data_import.import_curexch';
    l_header        xmltype;
    l_body          xmltype;
    l_sign          xmltype;
    l_docid         number;
    l_doc           bars.zayavka%rowtype;
    l_payer         v_kf_accounts%rowtype;
    l_payee         v_kf_accounts%rowtype;
    l_denom         number;
    l_branch        varchar2(30) := null;
    l_acc0          bars.zayavka.acc0%type;
    l_okpo0         bars.zayavka.okpo0%type;
    l_acc1          bars.zayavka.acc1%type;
    l_taxflg        number;
    l_visaid        integer;
    l_visa_fullname xmltype;
    l_attachments_count  integer := 0;
  begin
    logger.trace('%s: start', l_title);
    --
    -- вычленяем заголовок и тело документа
    l_header := p_xml.extract('/SIGNED_DOCUMENT/DOCUMENT/HEADER');
    l_body   := p_xml.extract('/SIGNED_DOCUMENT/DOCUMENT/ATTRIBUTES');
    l_sign   := p_xml.extract('/SIGNED_DOCUMENT/SIGNATURES/SIGNATURE');
    -- doc_id
    l_docid  := l_header.extract('/HEADER/@DOC_ID').getNumberVal();
    -- проверка наличия общих обязательных реквизитов
    check_mandatory_attr(l_body, 'BUY_SELL_FLAG');
    check_mandatory_attr(l_body, 'DOC_SUM');
    check_mandatory_attr(l_body, 'DOC_CURRENCY');
    check_mandatory_attr(l_body, 'DOC_NUMBER');
    check_mandatory_attr(l_body, 'DOC_DATE');
    --check_mandatory_attr(l_body, 'PURCHASING_AIM');
    --check_mandatory_attr(l_body, 'PURCHASING_CUR_RATE');
    --check_mandatory_attr(l_body, 'PURCHASING_REASON');
    --
    check_mandatory_attr(l_body, 'PAYER_BANK_CODE');
    check_mandatory_attr(l_body, 'PAYER_ACCOUNT');
    check_mandatory_attr(l_body, 'PAYER_CURRENCY');
    --
    check_mandatory_attr(l_body, 'PAYEE_BANK_CODE');
    check_mandatory_attr(l_body, 'PAYEE_ACCOUNT');
    check_mandatory_attr(l_body, 'PAYEE_CURRENCY');
    check_mandatory_attr(l_body, 'PAYEE_TAX_CODE');
    --
    -- чтение общих атрибутов
    l_doc.dk       := get_attr_number(l_body, 'BUY_SELL_FLAG');
    -- кількість доданих документів до заявки
    if is_attr_exists(l_body, 'ATTACHMENT_MAILID') then
        l_attachments_count := 1;
    end if;

    -- получим валюту которая покупается
    l_doc.kv2      := get_attr_number(l_body, 'DOC_CURRENCY');
    -- получим валюту за которую покупается
    if is_attr_exists(l_body, 'DOC_CURRENCY_EX') then
       l_doc.kv_conv  := get_attr_number(l_body, 'DOC_CURRENCY_EX');
    end if;
    -- узнаем делитель валюты (10^dig)
    select denom into l_denom from bars.tabval where kv=l_doc.kv2;
    -- получим сумму и умножим на делитель
    l_doc.s2       := get_attr_number(l_body, 'DOC_SUM')*l_denom;
    -- номер заявки
    l_doc.nd       := substr(get_attr_varchar2(l_body, 'DOC_NUMBER'),1,10);
    -- дата заявки
    l_doc.fdat     := trunc(get_attr_date(l_body, 'DOC_DATE'));
    -- курс заявки
    if is_attr_exists(l_body, 'PURCHASING_CUR_RATE') then
        l_doc.kurs_z   := get_attr_number(l_body, 'PURCHASING_CUR_RATE');
    else
        l_doc.kurs_z   := null;
    end if;
    -- реквизиты плательщика(счет списания)
    l_payer.kf     := get_attr_varchar2(l_body, 'PAYER_BANK_CODE');
    l_payer.nls    := get_attr_varchar2(l_body, 'PAYER_ACCOUNT');
    l_payer.kv     := get_attr_number(l_body, 'PAYER_CURRENCY');
    -- ищем счет
    begin
        select * into l_payer from v_kf_accounts
        where kf=l_payer.kf and nls=l_payer.nls and kv=l_payer.kv;
    exception when no_data_found then
        raise_application_error(-20000, 'Рахунок списання не знайдено: kf='||l_payer.kf||', nls='||l_payer.nls||', kv='||l_payer.kv, true);
    end;
    -- реквизиты получателя(счет зачисления)
    l_payee.kf     := get_attr_varchar2(l_body, 'PAYEE_BANK_CODE');
    l_payee.nls    := get_attr_varchar2(l_body, 'PAYEE_ACCOUNT');
    l_payee.kv     := get_attr_number(l_body, 'PAYEE_CURRENCY');
    l_okpo0        := get_attr_varchar2(l_body, 'PAYEE_TAX_CODE');
    if l_payee.kf = l_payer.kf then -- счет в нашем банке ?
        -- ищем счет
        begin
            select * into l_payee from v_kf_accounts
            where kf=l_payee.kf and nls=l_payee.nls and kv=l_payee.kv;
        exception when no_data_found then
            raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payee.kf||', nls='||l_payee.nls||', kv='||l_payee.kv, true);
        end;

        if l_doc.dk in (3) then
            begin
                select acc into l_acc0 from v_kf_accounts
                where kf=l_payer.kf and nls=l_payer.nls and kv=l_doc.kv_conv;
            exception when no_data_found then
                raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payer.kf||', nls='||l_payer.nls||', kv='||l_doc.kv_conv, true);
            end;
            l_doc.acc0 := l_acc0;
            ---
            begin
                select acc into l_acc1 from v_kf_accounts
                where kf=l_payee.kf and nls=l_payee.nls and kv=l_doc.kv2;
            exception when no_data_found then
                raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payee.kf||', nls='||l_payee.nls||', kv='||l_doc.kv2, true);
            end;
            l_doc.acc1 := l_acc1;

            l_doc.nls0 := l_payee.nls;
        elsif l_doc.dk in (4) then
            begin
                select acc into l_acc0 from v_kf_accounts
                where kf=l_payee.kf and nls=l_payee.nls and kv=l_doc.kv2;
            exception when no_data_found then
                raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payee.kf||', nls='||l_payee.nls||', kv='||l_doc.kv2, true);
            end;
            l_doc.acc0 := l_acc0;
            ---
            begin
                select acc into l_acc1 from v_kf_accounts
                where kf=l_payer.kf and nls=l_payer.nls and kv=l_doc.kv_conv;
            exception when no_data_found then
                raise_application_error(-20000, 'Рахунок зарахування не знайдено: kf='||l_payer.kf||', nls='||l_payer.nls||', kv='||l_doc.kv_conv, true);
            end;
            l_doc.acc1 := l_acc1;
            l_doc.kv2 := get_attr_number(l_body, 'DOC_CURRENCY_EX');
            l_doc.kv_conv := get_attr_number(l_body, 'DOC_CURRENCY');
            l_doc.nls0 := l_payer.nls;
        else
            -- внутр.№ счета в нац.вал.
            l_doc.acc0 := case when l_doc.dk=1 then l_payer.acc else l_payee.acc end;

            if l_doc.dk=1 then
                l_doc.nls0 := l_payee.nls;
            end if;
        end if;
    else
        -- счет в чужом банке
        l_doc.nls0 := l_payee.nls;
        l_doc.mfo0 := l_payee.kf;
        l_doc.okpo0 := l_okpo0;
    end if;
    -- rnk клиента
    l_doc.rnk := l_payer.rnk;
    -- внутр.№ счета в ин.вал.
    ---l_doc.acc1 := case when l_doc.dk=1 then l_payee.acc else l_payer.acc end;
    l_doc.acc1 := case when l_doc.dk=1 then l_payee.acc when l_doc.dk=2 then l_payer.acc when l_doc.dk in (3,4) then l_acc1  end;
    -- код цели покупки/продажи
    l_doc.meta := null; --get_attr_number(l_body, 'PURCHASING_AIM');
    -- основание для покупки валюты
    if is_attr_exists(l_body, 'PURCHASING_REASON') then
        l_doc.basis   := substr(get_attr_varchar2(l_body, 'PURCHASING_REASON'), 1, 512);
    else
        l_doc.basis   := null;
    end if;
    -- необязательные реквизиты
    -- идентификатор контракта
    if is_attr_exists(l_body, 'EXPIMP_CONTR_NUMBER') then
        l_doc.pid := get_attr_number(l_body, 'EXPIMP_CONTR_NUMBER');
    end if;
    -- номер контракта/кред.договора
    if is_attr_exists(l_body, 'CREDIT_NUM') then
        l_doc.contract := get_attr_varchar2(l_body, 'CREDIT_NUM');
    end if;
    -- дата контракта/кред.договора
    if is_attr_exists(l_body, 'CREDIT_DATE') then
        l_doc.dat2_vmd := get_attr_date(l_body, 'CREDIT_DATE');
    end if;
    -- код страны
    if is_attr_exists(l_body, 'CREDIT_COUNTRY_CODE') then
        l_doc.country := get_attr_number(l_body, 'CREDIT_COUNTRY_CODE');
    end if;

    -- номер последней тамож.декларации
    if is_attr_exists(l_body, 'LAST_MD_NUM') then
        l_doc.num_vmd := get_attr_varchar2(l_body, 'LAST_MD_NUM');
    end if;
    -- дата последней тамож.декларации
    if is_attr_exists(l_body, 'LAST_MD_DATE') then
        l_doc.dat_vmd := get_attr_date(l_body, 'LAST_MD_DATE');
    end if;
    -- даты предыдущ.тамож.деклараций
    if is_attr_exists(l_body, 'LAST_MDS_DATES') then
        l_doc.dat5_vmd := get_attr_varchar2(l_body, 'LAST_MDS_DATES');
    end if;
    -- Комісія введена клієнтом
    if is_attr_exists(l_body, 'CURREXCH_FEE') then
        l_doc.skom   := get_attr_number(l_body, 'CURREXCH_FEE');
    else
        l_doc.skom   := null;
    end if;

  begin
     select branch into l_branch from v_kf_accounts where acc = l_doc.acc1;
  exception when no_data_found then null;
  end;

    l_taxflg := 0;

    if l_doc.dk = 1 then
        l_taxflg := 1;
    end if;

    -- добавить сюда остальные проверки
    bars.bars_zay.create_request
       (p_reqtype       => l_doc.dk,                                 -- тип заявки (1-покупка, 2 -продажа)
        p_custid        => l_doc.rnk,                                -- регистр.№ клиента
        p_curid         => l_doc.kv2,                                -- числ.код валюты которая покупается
        p_curconvid     => l_doc.kv_conv,                            -- числ.код валюты за которую покупается
        p_amount        => l_doc.s2,                                 -- сумма заявленной валюты (в коп.)
        p_reqnum        => l_doc.nd,                                 -- номер заявки
        p_reqdate       => l_doc.fdat,                               -- дата заявки
        p_reqrate       => l_doc.kurs_z,                             -- курс заявки
        p_frxaccid      => l_doc.acc1,                               -- внутр.№ счета в ин.вал.
        p_nataccid      => l_doc.acc0,                               -- внутр.№ счета в нац.вал.
        p_nataccnum     => l_doc.nls0,                               -- счет в нац.валюте в др.банке     (для dk = 2)
        p_natbnkmfo     => l_doc.mfo0,                               -- МФО банка счета в нац.валюте     (для dk = 2)
        p_okpo0         => l_doc.okpo0,                              -- ОКПО для зачисления грн на м/б при продаже (для dk = 2)
        --p_cmsprc        => zayavka.kom%type           default null,  -- процент (%) комиссии
        p_cmssum        => l_doc.skom,                                   -- фикс.сумма комиссии
        p_taxflg        => l_taxflg,                                   -- BRSMAIN-2598 признак отчисления в ПФ (для dk = 1)
        --p_taxacc        => zayavka.nlsp%type          default null,  -- счет клиента для отчисления в ПФ (для dk = 1)
        p_aimid         => l_doc.meta,                                 -- код цели покупки/продажи
        p_contractid    => l_doc.pid,                                  -- идентификатор контракта
        p_contractnum   => l_doc.contract,                             -- номер контракта/кред.договора
        p_contractdat   => l_doc.dat2_vmd,                             -- дата контракта/кред.договора
        p_custdeclnum   => l_doc.num_vmd,                              -- номер последней тамож.декларации
        p_custdecldat   => l_doc.dat_vmd,                              -- дата последней тамож.декларации
        p_prevdecldat   => l_doc.dat5_vmd,                             -- даты предыдущ.тамож.деклараций    (для dk = 1)
        --p_basis         => l_doc.basis,                                -- основание для покупки валюты      (для dk = 1)
        p_countryid     => l_doc.country,                              -- код страны перечисления валюты    (для dk = 1)
        --p_bnfcountryid  => zayavka.benefcountry%type  default null,  -- код страны бенефициара            (для dk = 1)
        --p_bnfbankcode   => zayavka.bank_code%type     default null,  -- код банка (B010)                  (для dk = 1)
        --p_bnfbankname   => zayavka.bank_name%type     default null,  -- название банка                    (для dk = 1)
        --p_productgrp    => zayavka.product_group%type default null,  -- код товарной группы               (для dk = 1)
        p_details       => l_doc.basis,
        p_branch        => l_branch,
        p_identkb       => -1,
        p_reqid         => l_doc.id);                         -- идентификатор заявки
    --
    -- сохраняем соответствие id заявки и id первичного документа
    insert into zayavka_id_map(idz, doc_id) values(l_doc.id, l_docid);
    update bars.zayavka z set z.attachments_count = l_attachments_count where z.id = l_doc.id;
    --
    -- сохраняем историю визирования документа в corp2
    l_visaid := 1;
    while l_visaid<=2 and l_sign.existsnode('/SIGNATURE[@VISA_ID="'||l_visaid||'"]')=1
    loop
        l_visa_fullname := l_sign.extract('/SIGNATURE[@VISA_ID="'||l_visaid||'"]/@USER_FULLNAME');
        if l_visa_fullname is not null then
            case when l_visaid=1 then
                update zayavka_id_map
                   set sign01 = substr (dbms_xmlgen.convert(l_visa_fullname.getstringval(),dbms_xmlgen.entity_decode),1,200)
                 where idz = l_doc.id;
            else
                update zayavka_id_map
                   set sign02 = substr (dbms_xmlgen.convert(l_visa_fullname.getstringval(),dbms_xmlgen.entity_decode),1,200)
                 where idz = l_doc.id;
            end case;
        end if;
        l_visaid := l_visaid + 1;
    end loop;
    --
    logger.trace('%s: finish', l_title);
    --
    return STATUS_RECV_BANK;
    --
  end import_curexch;

  ----
  -- add_payment_props - пишем доп.реквизиты для платежей(время отправки в банк и получения банком)
  --
  procedure add_payment_props(p_docid in number) is
    l_prop          doc_import_props%rowtype;
  begin
    l_prop.ext_ref  := to_char(p_docid);
    -- время отправки в банк
    l_prop.tag      := 'IBTSB';
    l_prop.value    := to_char(rpc_sync.get_status_time(p_docid, STATUS_SEND_BANK), 'DD.MM.YYYY HH24:MI:SS');
    insert into doc_import_props values l_prop;
    --
    -- время получения банком
    l_prop.tag      := 'IBTRB';
    l_prop.value    := to_char(rpc_sync.get_status_time(p_docid, STATUS_RECV_BANK), 'DD.MM.YYYY HH24:MI:SS');
    insert into doc_import_props values l_prop;
    --
  end add_payment_props;

  ----
  -- insert_new_document - вставляет новый документ в doc_export
  --
  procedure insert_new_document(p_docid in number, p_xml in xmltype) is
  begin
    --
    rpc_sync.extract_doc_export_single(p_docid, p_xml);
    --
  end insert_new_document;

  ----
  -- import_document - выполняет импорт 1-го документа
  --
  procedure import_document(p_docid in number) is
    l_title         constant varchar2(61) := 'data_import.import_document';
    l_xml           xmltype;
    l_typeid        varchar2(12);
    l_status        integer;
    l_rc            integer;
    l_result        varchar2(4000);
    l_sp_determined_sys boolean := false;
    l_sp_determined_app boolean := false;
    --
  begin
    logger.trace('%s: start: p_docid=%s', l_title, to_char(p_docid));
    -- лочим документ
    if not lock_document(p_docid) then
        return;
    end if;
    -- получаем сам документ в XML-представлении
    l_xml := get_doc_xml(p_docid);
    --
    -- точка отката для системных ошибок
    --
    savepoint sp_sys;
    l_sp_determined_sys := true;
    --
    -- сохраним исходный xml-документ, который импортируем
    --
    insert_new_document(p_docid, l_xml);
    --
    -- вычленяем тип документа
    --
    l_typeid := l_xml.extract('/SIGNED_DOCUMENT/DOCUMENT/HEADER/@TYPE_ID').getStringVal();
    --
    -- точка отката для прикладных ошибок (после блокировки, чтобы поставить статус)
    --
    savepoint sp_app;
    l_sp_determined_app := true;
    --
    -- для разных типов документов разные процедуры разбора
    --
    case
        -- платежные и информационные документы
    when l_typeid in ('P_INT','P_SEP','P_TRANS','P_SWIFT','I_REQUEST','I_NOTICE') then
        --
        l_status := import_payment(l_xml);
        --
        -- заявки на куплю/продажу валюты
    when l_typeid = 'I_CUREXCH' then
        --
        l_status := import_curexch(l_xml);
        --
        --
    else
        raise_application_error(-20000, 'Обробка документів типу '''||l_typeid||''' не реалізована.', true);
    end case;

    -- модифицируем статус документа на возвращенный функцией импорта
    set_status_info(p_docid, l_status, sysdate);
    --
    -- пишем доп.реквизиты для платежей(время отправки в банк и получения банком)
    if l_typeid in ('P_INT','P_SEP','P_TRANS','P_SWIFT','I_REQUEST','I_NOTICE') then
        add_payment_props(p_docid);
    end if;
    --
    logger.trace('%s: finish', l_title);
    --
  exception when others then
        -- откатываемся до прикладной точки
        if l_sp_determined_app then
            rollback to sp_app;
        end if;
        -- культурная обработка ошибки
        declare
            l_errcode   integer;
            l_errfull   varchar2(4000);
            l_errtext   varchar2(4000);
            l_errumsg   varchar2(4000);
            l_erracode  varchar2(4000);
            l_erramsg   varchar2(4000);
            l_pos       integer;
        begin
            l_errcode := SQLCODE;
            l_errfull := substr(dbms_utility.format_error_stack()
                ||chr(10)||chr(10)||'Error backtrace:'||chr(10)||dbms_utility.format_error_backtrace(),1,4000);
            -- логируем напрямую ошибку
            logger.error(l_errfull);
            --
            if l_errcode>-21000 and l_errcode<=-20000 and l_errcode<>-20999 then
                -- прикладные ошибки пишем в статус документа
                l_pos := instr(l_errfull, chr(10));
                if l_pos>0 then
                    l_errtext := substr(l_errfull, 1, l_pos-1);
                else
                    l_errtext := l_errfull;
                end if;
                if l_errcode=-20097 then
                    bars.bars_error.get_error_info(l_errtext, l_errumsg, l_erracode, l_erramsg);
                else
                    l_errumsg := substr(l_errtext, 12);
                end if;
                --
                set_status_info(p_docid,
                    p_statusid              => STATUS_RJCT_BANK,
                    p_status_change_time    => sysdate,
                    p_bank_back_reason      => l_errumsg,
                    p_bank_back_reason_aux  => l_errfull,
                    p_bank_back_date        => sysdate);
            else
                -- в случае системной ошибки считаем, что импорта документа не было
                -- поэтому откатываемся к системной точке sp_sys
                if l_sp_determined_sys then
                    rollback to sp_sys;
                end if;
                -- системные ошибки попадают в таблицу doc_system_errors
                -- и в поля 'BANK_SYSERR_*' документа,
                insert into doc_system_errors(se_id, se_time, se_code, se_msg, ext_ref, doc_xml)
                values(s_docsyserr.nextval, sysdate, l_errcode, l_errfull, p_docid, l_xml);
                -- фиксируем ошибку, на случай ошибки записи статуса
                commit;
                -- но статус самого документа не меняется
                set_status_info(p_docid, p_bank_syserr_msg => l_errfull, p_bank_syserr_date => sysdate);
            end if;
        end;
  end import_document;

  ----
  -- switch_logfile - выполняет переключение текущего лога
  --
  procedure switch_logfile is
  begin
    execute immediate 'alter system switch logfile';
  end switch_logfile;

  ----
  -- lock_document4notify - блокирует документ для уведомления
  --
  function lock_document4notify(p_extref in doc_import.ext_ref%type) return boolean is
    l_booking_flag           doc_import.booking_flag%type;
    l_notification_flag      doc_import.notification_flag%type;
    l_doc_locked  exception;
    pragma        exception_init(l_doc_locked, -54);
  begin
    savepoint sp;
    select booking_flag, notification_flag
    into l_booking_flag, l_notification_flag
    from doc_import where ext_ref=p_extref for update nowait;
    if l_booking_flag is not null and l_notification_flag is null then
        return true;
    else
        rollback to sp;
        bars.bars_audit.error('Документ ext_ref='||p_extref||' не может быть заблокирован, т.к. '
        ||'booking_flag='||nvl(l_booking_flag,'null')
        ||', notification_flag='||nvl(l_notification_flag,'null'));
        return false;
    end if;
  exception when l_doc_locked then
    rollback to sp;
    bars.bars_audit.error('Документ ext_ref='||p_extref||' заблокирован другим пользователем');
    return false;
  end lock_document4notify;

  ----
  -- notify_ibank - уведомляет интернет-банкинг об оплате документов
  --
  procedure notify_ibank is
    l_title     constant varchar2(61) := 'data_import.notify_ibank';
    l_docid     integer;
    l_errtext   varchar2(4000);
    l_errumsg   varchar2(4000);
    l_erracode  varchar2(4000);
    l_erramsg   varchar2(4000);
    l_pos       integer;
    counter     integer := 0 ;
  begin
    logger.trace('%s: start '||sysdate, l_title);
    for c in (
        select * from doc_import where
        case
        when booking_flag is not null and notification_flag is null then 'Y'
        else null
        end = 'Y'
        order by ext_ref)
    loop
        if lock_document4notify(c.ext_ref) then
            --
            l_docid := to_number(c.ext_ref);
            --
            if c.booking_flag='N' then
                -- неуспешная оплата
                l_pos := instr(c.booking_err_msg, chr(10));
                if l_pos>0 then
                    l_errtext := substr(c.booking_err_msg, 1, l_pos);
                else
                    l_errtext := c.booking_err_msg;
                end if;
                bars.bars_error.get_error_info(l_errtext, l_errumsg, l_erracode, l_erramsg);
                --
                set_status_info(l_docid,
                    p_statusid              => STATUS_RJCT_BANK,
                    p_status_change_time    => sysdate,
                    p_bank_back_reason      => l_errumsg,
                    p_bank_back_reason_aux  => c.booking_err_msg,
                    p_bank_back_date        => c.booking_date);
            else
                -- успешная оплата
                set_status_info(l_docid,
                    p_statusid              => STATUS_VISA_BANK,
                    p_status_change_time    => sysdate,
                    p_bank_ref              => to_char(c.ref));
            end if;
            -- ставим флаг уведомления и дату
            update doc_import set notification_flag='Y', notification_date=sysdate
            where ext_ref=c.ext_ref;
            -- переносим ref по файлам
            update doc_export_files set bank_ref=c.ref where doc_id = to_number(c.ext_ref) and doc_file is not null;
            /*if sql%rowcount=0 then -- если нет такого, удаляем
              delete from doc_export_files where doc_id = to_number(c.ext_ref);
            end if; */
            --
            -- фиксируем транзакцию каждые 500 документов
            if mod(counter, 500) = 0 then
                commit;
            end if;
            --
            counter := counter + 1;
            logger.info('Інтернет-банкінг повідомлено про статус док-та: EXT_REF='||c.ext_ref||', REF='||c.ref);
        end if;
    end loop;
    commit;
    logger.trace('%s: doc_count '||counter, l_title);
    logger.trace('%s: finish '||sysdate, l_title);
  end notify_ibank;

  ----
  -- notify_ibank - уведомляет интернет-банкинг об оплате документов
  -- p_kf
  --
  procedure notify_ibank_kf(p_kf  bars.mv_kf.kf%type) is
    l_title     constant varchar2(61) := 'data_import.notify_ibank';
    l_docid     integer;
    l_errtext   varchar2(4000);
    l_errumsg   varchar2(4000);
    l_erracode  varchar2(4000);
    l_erramsg   varchar2(4000);
    l_pos       integer;
    counter     integer := 0 ;
  begin
    logger.trace('%s: start '||sysdate, l_title);
    for c in (
        select * from doc_import where mfo_a = p_kf and
        case
        when booking_flag is not null and notification_flag is null then 'Y'
        else null
        end = 'Y'
        order by ext_ref)
    loop
        if lock_document4notify(c.ext_ref) then
            --
            l_docid := to_number(c.ext_ref);
            --
            if c.booking_flag='N' then
                -- неуспешная оплата
                l_pos := instr(c.booking_err_msg, chr(10));
                if l_pos>0 then
                    l_errtext := substr(c.booking_err_msg, 1, l_pos);
                else
                    l_errtext := c.booking_err_msg;
                end if;
                bars.bars_error.get_error_info(l_errtext, l_errumsg, l_erracode, l_erramsg);
                --
                set_status_info(l_docid,
                    p_statusid              => STATUS_RJCT_BANK,
                    p_status_change_time    => sysdate,
                    p_bank_back_reason      => l_errumsg,
                    p_bank_back_reason_aux  => c.booking_err_msg,
                    p_bank_back_date        => c.booking_date);
            else
                -- успешная оплата
                set_status_info(l_docid,
                    p_statusid              => STATUS_VISA_BANK,
                    p_status_change_time    => sysdate,
                    p_bank_ref              => to_char(c.ref));
            end if;
            -- ставим флаг уведомления и дату
            update doc_import set notification_flag='Y', notification_date=sysdate
            where ext_ref=c.ext_ref;
            -- переносим ref по файлам
            update doc_export_files set bank_ref=c.ref where doc_id = to_number(c.ext_ref) and doc_file is not null;
            /*if sql%rowcount=0 then -- если нет такого, удаляем
              delete from doc_export_files where doc_id = to_number(c.ext_ref);
            end if; */
            --
            -- фиксируем транзакцию каждые 500 документов
            if mod(counter, 500) = 0 then
                commit;
            end if;
            --
            counter := counter + 1;
            logger.info('Інтернет-банкінг повідомлено про статус док-та: EXT_REF='||c.ext_ref||', REF='||c.ref);
        end if;
    end loop;
    commit;
    logger.trace('%s: doc_count '||counter, l_title);
    logger.trace('%s: finish '||sysdate, l_title);
  end notify_ibank_kf;

  ----
  -- email_msg - посылка сообщения администраторам модуля синхронизации по e-mail
  --
  procedure email_msg(p_subject in varchar2, p_body in clob)
  is
  begin
    -- помещаем сообщение в очередь
    bars.bars_mail.put_msg2queue(
        p_name     => g_syncadm,
        p_addr     => g_syncadm,
        p_subject  => p_subject,
        p_body     => p_body
    );
  end email_msg;

  ----
  -- full_import - выполняет полный цикл по импорту документов
  --
  procedure full_import is
    l_scn           number;
    l_time          date;
    l_period        number;
    l_error         varchar2(4000);
    l_prev_error    varchar2(4000);
    l_sync_version  varchar2(4000);
    l_num           number;
    l_date          date;
    l_email         boolean;
  begin
    logger.trace('full_import: start');
    logger.trace('--------------------------------------------------------------------------------------');
    --
    l_time := sysdate;
    l_scn  := dbms_flashback.get_system_change_number();
    --
    -- оставляем записи только за последние 24 часа
    delete from import_activity where start_time<sysdate-1;
    -- пишем время начала работы
    insert into import_activity(start_time, start_scn)
    values(l_time, l_scn);
    commit;
    -- проверка доступности линка на базу ibank путем вызова безобидной процедуры
    -- в случае ошибки, иключение вылетит в обработчик
    begin
        l_sync_version := rpc_sync.body_version();
    exception when others then
        raise_application_error(-20000, substr('Неможливо зв''язатися з базою IBANK по dblink'||chr(10)
            ||get_error_msg(),1,4000), true);
    end;
    g_docs_count := 0;
    -- импорт
    data_import.import_documents;
    --
    -- оплата (по плану или факту, как настроены операции)
    bars_docsync.async_pay_documents;
    --
    -- уведомление
    data_import.notify_ibank;
    --
    -- вывод результатов
    -- фиксируем завершение работы
    l_period := round((sysdate-l_time)*24*60*60);
    l_scn    := dbms_flashback.get_system_change_number();
    --
    update import_activity set working_period=decode(l_period,0,1,l_period), finish_scn=l_scn, system_error=null, docs_count=g_docs_count
    where start_time=l_time;
    commit;
    --
  exception when others then
    -- откат на всякий случай
    rollback;
    -- фиксация ошибки
    l_period := round((sysdate-l_time)*24*60*60);
    l_scn    := dbms_flashback.get_system_change_number();
    --
    l_error := substr(get_error_msg(),1,4000);
    update import_activity
       set working_period=decode(l_period,0,1,l_period), finish_scn=l_scn, system_error=l_error
     where start_time=l_time;
    --
    logger.trace('ERROR:');
    logger.trace(get_error_msg());
    --
    -- надо ли нам слать ошибку на e-mail?
    -- по-умолчанию - да
    l_email := true;
    -- но если последнее сообщение было отослано не позже часа назад с такой же ошибкой,
    -- то спамить не будем
    select max(start_time)
      into l_date
      from import_activity
     where start_time < l_time
       and start_time >= l_time - 1/24
       and email_sent = 'Y';
    if l_date is not null
    then
        select system_error
          into l_prev_error
          from import_activity
         where start_time = l_date;
        if l_prev_error = l_error
        then
            l_email := false;
        end if;
    end if;
    if l_email
    then
        email_msg(
            'Помилка при імпорті в модулі синхронізації АБС БАРС з corp2',
            'Час виникнення помилки: '||to_char(l_time, 'DD.MM.YYYY HH24:MI:SS')||chr(10)||chr(10)||
            'Опис помилки :'||l_error
        );
        update import_activity
           set email_sent = 'Y'
         where start_time=l_time;
    end if;
    --
    commit;
    --
  end full_import;

  ----
  -- sync_bankdates - синхронизирует банковские даты
  --
  procedure sync_bankdates is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn    number;
  begin
    --
    write_sync_status(TAB_BANKDATES, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_BANKDATES);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_BANKDATES, g_global_name, l_scn);
        --
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
            --
            rpc_sync.manual_instantiate_now(TAB_BANKDATES, c.kf);
            -- удаляем старые значения в локальной таблице
            delete
              from bankdates
             where bank_id=c.kf;
            -- удаляем старые значения в удаленной таблице
            rpc_sync.erase_bankdates(c.kf);
            -- вставляем новые в локальную таблицу
            insert
              into bankdates(bank_id, bankdate)
            select kf, to_date(val, 'MM/DD/YYYY')
              from v_kf_params as of scn l_scn
             where kf=c.kf
               and par='BANKDATE';
            -- вставляем новые в удаленную таблицу
            rpc_sync.fill_bankdates(c.kf);
            -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
            rpc_sync.sync_bankdates(c.kf);
        end loop;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_PARAMS, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію банківських дат');
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_BANKDATES, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_BANKDATES, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_bankdates;

  ----
  -- sync_bankdates_job - синхронизирует банковские даты job-ом
  --
  procedure sync_bankdates_job is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn    number;
    l_bankdate_bars varchar2(10);
    l_bankdate_barsaq varchar2(10);
  begin
    --
    select to_char(bankdate, 'MM/DD/YYYY'), bars.branch_attribute_utl.get_value('BANKDATE')
      into l_bankdate_barsaq, l_bankdate_bars
      from bankdates b
     where b.bank_id = '300465';
    if l_bankdate_barsaq = l_bankdate_bars then
      return;
    end if;
    --
    write_sync_status(TAB_BANKDATES, JOB_STATUS_STARTED);
    --
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_BANKDATES, g_global_name, l_scn);
        --
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
            --
            rpc_sync.manual_instantiate_now(TAB_BANKDATES, c.kf);
            -- удаляем старые значения в локальной таблице
            delete
              from bankdates
             where bank_id=c.kf;
            -- удаляем старые значения в удаленной таблице
            rpc_sync.erase_bankdates(c.kf);
            -- вставляем новые в локальную таблицу
            insert
              into bankdates(bank_id, bankdate)
            select kf, to_date(val, 'MM/DD/YYYY')
              from v_kf_params as of scn l_scn
             where kf=c.kf
               and par='BANKDATE';
            -- вставляем новые в удаленную таблицу
            rpc_sync.fill_bankdates(c.kf);
            -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
            rpc_sync.sync_bankdates(c.kf);
        end loop;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_PARAMS, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію банківських дат');
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_BANKDATES, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_BANKDATES, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_bankdates_job;


  ----
  -- sync_branches - синхронизирует бранчи
  --
  procedure sync_branches is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_BRANCHES, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_BRANCHES);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_BRANCHES, g_global_name, l_scn);
        --
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
            --
            rpc_sync.manual_instantiate_now(TAB_BRANCHES, c.kf);
            -- удаляем старые значения в локальной таблице
            delete
              from branches
             where bank_id=c.kf;
            -- удаляем старые значения в удаленной таблице
            rpc_sync.erase_branches(c.kf);
            -- вставляем новые в локальную таблицу
            insert
              into branches(bank_id,branch_id,name,date_opened,date_closed,nbu_code,description)
            select kf,branch,name,date_opened,date_closed,b040,description
              from v_kf_branches as of scn l_scn
             where kf=c.kf;
            -- вставляем новые в удаленную таблицу
            rpc_sync.fill_branches(c.kf);
            -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
            rpc_sync.sync_branches(c.kf);
        end loop;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_BRANCH, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію довідника відділень банку');
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_BRANCHES, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_BRANCHES, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_branches;

  ----
  -- sync_streams_heartbeat - синхронизирует streams_heartbeat
  --
  procedure sync_streams_heartbeat is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_startdate date;
    l_scn   number;
  begin
    --
    write_sync_status(TAB_STREAMS_HEARTBEAT, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_STREAMS_HEARTBEAT);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_STREAMS_HEARTBEAT, g_global_name, l_scn);
        --
        -- устанавливаем точку синхронизации для части удаленной таблицы, соотв. global_name, на текущий момент
        rpc_sync.user_global_instantiate_now(TAB_STREAMS_HEARTBEAT);
        --
        -- удаляем старые значения в локальной таблице
        delete
          from streams_heartbeat;
        -- удаляем старые значения в удаленной таблице
        rpc_sync.erase_streams_heartbeat();
        -- вставляем новые в локальную таблицу
        insert
          into streams_heartbeat(global_name, heartbeat_time)
        select global_name, heartbeat_time
          from bars.streams_heartbeat as of scn l_scn;
        -- вставляем новые в удаленную таблицу
        rpc_sync.fill_streams_heartbeat();
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_streams_heartbeat();
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_STREAMS_HEARTBEAT, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці STREAMS_HEARTBEAT');
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_STREAMS_HEARTBEAT, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_STREAMS_HEARTBEAT, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_streams_heartbeat;


  ----
  -- sync_doc_export - синхронизирует документы
  --
  procedure sync_doc_export(p_startdate in date default trunc(sysdate-1)) is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_change_time   date;
    l_back_reason   varchar2(4000);
    l_docid         integer;
    l_scn           number;
  begin
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_DOC_EXPORT);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_DOC_EXPORT, g_global_name, l_scn);
        --
        for c in (select kf from v_kf)
        loop
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_DOC_EXPORT, c.kf);
        end loop;
        -- идем по платежным документам
        for c in (
               select *
                 from (select i.ref, e.doc_id, e.status_id, e.bank_ref,
                       e.status_change_time, e.bank_accept_date, e.bank_back_date,
                       o.status, o.change_time, o.back_reason, o.pdat
                         from doc_import i, doc_export e,
                            (select ref,case
                                        when sos<0 then -20
                                        when sos>=5 then 50
                                        else 45
                                        end as status,
                                    (select value from bars.operw where ref=p.ref and tag='BACKR')
                                    as back_reason,
                                    (select change_time from bars.sos_track s
                                     where old_sos<>new_sos and sos_tracker=
                                        (select max(sos_tracker) from bars.sos_track
                                         where ref=s.ref and new_sos=s.new_sos and old_sos<>new_sos)
                                        and ref=p.ref and new_sos=p.sos
                                    ) change_time,
                                    pdat
                             from bars.oper p) o
                         where i.insertion_date >= p_startdate
                           and o.status != e.status_id
                           and i.ref is not null -- только документы АБС
                           and e.doc_id=to_number(i.ext_ref) and i.ref=o.ref
                         ) as of scn l_scn
                 )
        loop
            -- блокируем строку в doc_export
            select doc_id into l_docid from doc_export where doc_id=c.doc_id for update nowait;
            -- если нету истории изменений по oper.sos, то ставим время создания документа
            l_change_time := nvl(c.change_time, c.pdat);
            --
            l_back_reason := nvl(c.back_reason, 'Причину сторнування не вказано');
            --
            set_status_info(
                p_docid                   => c.doc_id,
                p_statusid                => c.status,
                p_status_change_time      => l_change_time,
                p_bank_accept_date        => case when c.status=50 then l_change_time else null end,
                p_bank_ref                => c.ref,
                p_bank_back_date          => case when c.status<0 then l_change_time else null end,
                p_bank_back_reason        => case when c.status<0 then l_back_reason else null end
            );

            commit;
        end loop;
        -- идем по заявкам на покупку/продажу валюты
        for c in (select *
                    from (select d.doc_id,
                                 case
                                    when z.sos =-1 then -20
                                    when z.sos = 2 then  50
                                    else 45
                                 end as status,
                                 (select max(change_time)
                                    from bars.zay_track
                                   where id = z.id
                                     and new_sos = z.sos
                                 ) as status_change_time,
                                 z.datedokkb as creating_time,
                                 to_char(z.id) as bank_ref,
                                 case
                                    when z.sos=-1 and z.idback is not null
                                        then
                                            (select reason
                                               from bars.zay_back
                                              where id = z.idback)
                                    else
                                        null
                                 end as bank_back_reason
                            from doc_export d,
                                 zayavka_id_map m,
                                 bars.zayavka z,
                                 bars.zay_track zt
                           where d.doc_id = m.doc_id
                             and m.idz = z.id
                             and z.id = zt.id
                             and zt.change_time >= p_startdate
                         ) as of scn l_scn
                )
        loop
                -- блокируем строку в doc_export
                select doc_id into l_docid from doc_export where doc_id=c.doc_id for update nowait;
                -- если нету истории изменений по oper.sos, то ставим время создания документа
                l_change_time := nvl(c.status_change_time, c.creating_time);
                --
                l_back_reason := nvl(c.bank_back_reason, 'Причину відхилення не вказано');
                --
                set_status_info(
                    p_docid                   => c.doc_id,
                    p_statusid                => c.status,
                    p_status_change_time      => l_change_time,
                    p_bank_accept_date        => case when c.status=50 then l_change_time else null end,
                    p_bank_ref                => c.bank_ref,
                    p_bank_back_date          => case when c.status<0 then l_change_time else null end,
                    p_bank_back_reason        => case when c.status<0 then l_back_reason else null end
                );

        end loop;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_SOS_TRACK, g_global_name, l_scn);
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_ZAY_TRACK, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію статусів документів з дати '||to_char(p_startdate, 'DD.MM.YYYY'));
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_doc_export;

  ---
  -- get_doc_export_old_state
  --
  procedure get_doc_export_old_state
    is
  begin
    insert into tmp_old_state
    select doc_id, status_id from ibank.v_doc_export_open t where t.status_id = 45;
    logger.info('doc_export_old_state'||sql%rowcount);
  end;

  ----
  -- sync_doc_export_open - синхронизирует документы
  --
  procedure sync_doc_export_open is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_change_time   date;
    l_back_reason   varchar2(4000);
    l_docid         integer;
    l_scn           number;
  begin
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_DOC_EXPORT);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета

        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_DOC_EXPORT, g_global_name, l_scn);
        --
        for c in (select kf from v_kf)
        loop
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_DOC_EXPORT, c.kf);
        end loop;

        -- загружаем зависшие статусы в временную таблицу
        get_doc_export_old_state;

     --   l_scn := dbms_flashback.get_system_change_number();

        -- идем по платежным документам
        for c in (select i.ref,
        		 e.doc_id,
                         tos.status_id,
                         e.bank_ref,
                         e.status_change_time,
                         e.bank_accept_date,
                         e.bank_back_date,
                         o.status,
                         o.change_time,
                         o.back_reason,
                         o.pdat
                    from doc_import i,
                         doc_export e,
                         tmp_old_state tos,
                         (select ref,
                                 case
                                 when sos < 0 then
                                      -20
                                 when sos >= 5 then
                                      50
                                 else
                                      45
                                 end as status,
                                (select value
                                   from bars.operw
                                  where ref = p.ref
                                    and tag = 'BACKR') as back_reason,
                                (select change_time
                                   from bars.sos_track s
                                  where old_sos <> new_sos
                                    and sos_tracker =
                                        (select max(sos_tracker)
                                           from bars.sos_track
                                          where ref = s.ref
                                            and new_sos = s.new_sos
                                            and old_sos <> new_sos)
                                    and ref = p.ref
                                    and new_sos = p.sos) change_time,
                                 pdat
                            from bars.oper p) o
               where --i.insertion_date between sysdate - 30 and sysdate - 2
                     o.status != tos.status_id
                 and i.ref is not null -- только документы АБС
                 and to_char(tos.doc_id) = i.ext_ref
                 and i.ref = o.ref
                 and e.doc_id = tos.doc_id)
           loop

            -- блокируем строку в doc_export
            select doc_id into l_docid from doc_export where doc_id=c.doc_id for update nowait;
            -- если нету истории изменений по oper.sos, то ставим время создания документа
            l_change_time := nvl(c.change_time, c.pdat);
            --
            l_back_reason := nvl(c.back_reason, 'Причину сторнування не вказано');
            --
            set_status_info(
                p_docid                   => c.doc_id,
                p_statusid                => c.status,
                p_status_change_time      => l_change_time,
                p_bank_accept_date        => case when c.status=50 then l_change_time else null end,
                p_bank_ref                => c.ref,
                p_bank_back_date          => case when c.status<0 then l_change_time else null end,
                p_bank_back_reason        => case when c.status<0 then l_back_reason else null end,
                p_is_open                 => 1
                );
            commit;
        end loop;
        -- идем по заявкам на покупку/продажу валюты
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_doc_export_open;


  ----
  -- extract_doc_export_sync - получить список проблемных документов для выполнения синхронизации
  --
  procedure extract_doc_export_sync(p_startdate in date, p_docs out t_sync_docs_list)
  is
  begin
    execute immediate
    'select t_sync_docs(i.ref, e.doc_id, o.status, o.change_time, o.pdat, o.back_reason)
     from doc_import i, doc_export e,
                            (select ref,case
                                        when sos<0 then -20
                                        when sos>=5 then 50
                                        else 45
                                        end as status,
                                    (select value from bars.operw where ref=p.ref and tag=''BACKR'')
                                    as back_reason,
                                    (select change_time from bars.sos_track s
                                     where old_sos<>new_sos and sos_tracker=
                                        (select max(sos_tracker) from bars.sos_track
                                         where ref=s.ref and new_sos=s.new_sos and old_sos<>new_sos)
                                        and ref=p.ref and new_sos=p.sos
                                    ) change_time,
                                    pdat
                             from bars.oper p) o, ibank.v_doc_export vde
                         where i.insertion_date >= :p_startdate
                           and i.ref is not null -- только документы АБС
                           and e.doc_id=to_number(i.ext_ref) and i.ref=o.ref
                           and e.doc_id=vde.doc_id and o.ref=vde.bank_ref
                           and (e.status_id != vde.status_id or o.status != e.status_id)'
    bulk collect into p_docs
    using p_startdate;
  end extract_doc_export_sync;

  ----
  -- sync_doc_export_mod - синхронизирует документы (модифицированнная версия)
  --
  procedure sync_doc_export_mod(p_startdate in date default trunc(sysdate-1)) is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_change_time   date;
    l_back_reason   varchar2(4000);
    l_docid         integer;
    l_scn           number;
    l_docs             t_sync_docs_list;
    l_doc             t_sync_docs;
  begin
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_DOC_EXPORT);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_DOC_EXPORT, g_global_name, l_scn);
        --
        for c in (select kf from v_kf)
        loop
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_DOC_EXPORT, c.kf);
        end loop;
        -- идем по платежным документам
        write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_INPROGRESS, 'начало обработки списка документов начиная с ' || to_char(p_startdate,'DD.MM.YYYY'));
        extract_doc_export_sync(p_startdate, l_docs);
        for i in 1..l_docs.count
        loop
            l_doc := l_docs(i);
            write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_INPROGRESS, 'синхронизация документа ref=' || l_doc.bank_ref);
            -- блокируем строку в doc_export
            select doc_id into l_docid from doc_export where doc_id=l_doc.doc_id for update nowait;
            -- если нету истории изменений по oper.sos, то ставим время создания документа
            l_change_time := nvl(l_doc.status_change_time, l_doc.pdat);
            --
            l_back_reason := nvl(l_doc.back_reason, 'Причину сторнування не вказано');
            --
            set_status_info(
                p_docid                   => l_doc.doc_id,
                p_statusid                => l_doc.status_id,
                p_status_change_time      => l_change_time,
                p_bank_accept_date        => case when l_doc.status_id=50 then l_change_time else null end,
                p_bank_ref                => l_doc.bank_ref,
                p_bank_back_date          => case when l_doc.status_id<0 then l_change_time else null end,
                p_bank_back_reason        => case when l_doc.status_id<0 then l_back_reason else null end
            );
        end loop;
        -- идем по заявкам на покупку/продажу валюты
        for c in (select *
                    from (select d.doc_id,
                                 case
                                    when z.sos =-1 then -20
                                    when z.sos = 2 then  50
                                    else 45
                                 end as status,
                                 (select max(change_time)
                                    from bars.zay_track
                                   where id = z.id
                                     and new_sos = z.sos
                                 ) as status_change_time,
                                 z.datedokkb as creating_time,
                                 to_char(z.id) as bank_ref,
                                 case
                                    when z.sos=-1 and z.idback is not null
                                        then
                                            (select reason
                                               from bars.zay_back
                                              where id = z.idback)
                                    else
                                        null
                                 end as bank_back_reason
                            from doc_export d,
                                 zayavka_id_map m,
                                 bars.zayavka z,
                                 bars.zay_track zt
                           where d.doc_id = m.doc_id
                             and m.idz = z.id
                             and z.id = zt.id
                             and zt.change_time >= p_startdate
                         ) as of scn l_scn
                )
        loop
            -- блокируем строку в doc_export
            select doc_id into l_docid from doc_export where doc_id=c.doc_id for update nowait;
            -- если нету истории изменений по oper.sos, то ставим время создания документа
            l_change_time := nvl(c.status_change_time, c.creating_time);
            --
            l_back_reason := nvl(c.bank_back_reason, 'Причину відхилення не вказано');
            --
            set_status_info(
                p_docid                   => c.doc_id,
                p_statusid                => c.status,
                p_status_change_time      => l_change_time,
                p_bank_accept_date        => case when c.status=50 then l_change_time else null end,
                p_bank_ref                => c.bank_ref,
                p_bank_back_date          => case when c.status<0 then l_change_time else null end,
                p_bank_back_reason        => case when c.status<0 then l_back_reason else null end
            );
        end loop;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_SOS_TRACK, g_global_name, l_scn);
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_ZAY_TRACK, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію статусів документів з дати '||to_char(p_startdate, 'DD.MM.YYYY'));
        --
    exception when others then
        --
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_doc_export_mod;


  ---------------------------------------------------------------------------------------
  --
  --  JOB_SYNC_* - procedures
  --
  ---------------------------------------------------------------------------------------

  ----
  -- job_sync_swift_banks
  --
  procedure job_sync_swift_banks
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_SWIFT_BANKS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_swift_banks; end;');
    commit;
  end job_sync_swift_banks;

  ----
  -- job_sync_banks - синхронизация banks (1 источник)
  --
  procedure job_sync_banks
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_BANKS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_banks; end;');
    commit;
  end job_sync_banks;

  ----
  -- job_sync_bankdates
  --
  procedure job_sync_bankdates
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_BANKDATES, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_bankdates; end;');
    commit;
  end job_sync_bankdates;

  ----
  -- job_sync_doc_export - синхронизирует документы
  --
  procedure job_sync_doc_export(p_startdate in date default trunc(sysdate-1))
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_doc_export(to_date('''||to_char(p_startdate,'DD.MM.YYYY')||''',''DD.MM.YYYY'')); end;');
    commit;
  end job_sync_doc_export;

  ----
  -- job_sync_doc_export_mod - синхронизирует документы (модифицированная версия)
  --
  procedure job_sync_doc_export_mod(p_startdate in date default trunc(sysdate-1))
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_DOC_EXPORT, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_doc_export_mod(to_date('''||to_char(p_startdate,'DD.MM.YYYY')||''',''DD.MM.YYYY'')); end;');
    commit;
  end job_sync_doc_export_mod;

  ----
  -- job_sync_branches - синхронизирует бранчи
  --
  procedure job_sync_branches
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_BRANCHES, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_branches; end;');
    commit;
  end job_sync_branches;

  ----
  -- job_sync_streams_heartbeat - синхронизирует streams_heartbeat
  --
  procedure job_sync_streams_heartbeat
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_STREAMS_HEARTBEAT, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_streams_heartbeat; end;');
    commit;
  end job_sync_streams_heartbeat;

  ----
  -- job_sync_holidays - синхронизация holidays
  --
  procedure job_sync_holidays(p_startdate in date default trunc(sysdate-1))
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_HOLIDAYS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_holidays(to_date('''||to_char(p_startdate,'DD.MM.YYYY')||''',''DD.MM.YYYY'')); end;');
    commit;
  end job_sync_holidays;

  ----
  -- job_sync_currency_rates - синхронизация cur_rates
  --
  procedure job_sync_currency_rates(p_startdate in date default trunc(sysdate-1))
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_CURRENCY_RATES, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_currency_rates(to_date('''||to_char(p_startdate,'DD.MM.YYYY')||''',''DD.MM.YYYY'')); end;');
    commit;
  end job_sync_currency_rates;

  ----
  -- job_sync_account_stmt - запускает процедуру sync_account_stmt в виде задания
  --
  -- @p_acc [in] - id счета в АБС
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure job_sync_account_stmt(p_acc in integer, p_startdate in date default trunc(sysdate-1))
  is
    l_job  binary_integer;
  begin
    -- если указан acc конкретного счета, разрешаем параллельное выполнение синхронизации
    -- возможные конфликты на откуп пользователя
    write_sync_status(
        p_table_name    => TAB_ACC_TRANSACTIONS,
        p_status        => JOB_STATUS_ENQUEUED,
        -- временно запрещаем параллельное выполнение синхронизации по отдельным счетам
        --p_in_parallel   => false
        p_in_parallel   => case when p_acc is not null then true else false end
    );
    dbms_job.submit(l_job,
          'begin data_import.sync_account_stmt( '
        ||      'p_acc => '||p_acc||', '
        ||      'p_startdate => to_date('''||to_char(p_startdate,'DD.MM.YYYY')||''',''DD.MM.YYYY'') );'
        ||' end;');
    commit;
  end job_sync_account_stmt;

  ----
  -- job_sync_account_stmt - запускает процедуру sync_account_stmt в виде задания
  --
  -- @p_kf  - код банка/филиала(МФО)
  -- @p_nls - номер лицевого счета
  -- @p_kv  - код валюты
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure job_sync_account_stmt(
        p_kf  in varchar2,
        p_nls in varchar2,
        p_kv  in integer,
        p_startdate in date default trunc(sysdate-1))
  is
    l_acc  integer;
  begin
    begin
        select acc
          into l_acc
          from v_kf_accounts
         where kf=p_kf and nls=p_nls and kv=p_kv;
    exception when no_data_found then
        raise_application_error(-20000, 'Рахунок не знайдено: МФО='||p_kf||', Рахунок='||p_nls||', Валюта='||p_kv, true);
    end;
    --
    job_sync_account_stmt(l_acc, p_startdate);
    --
  end job_sync_account_stmt;

  ----
  -- job_sync_all_account_stmt - запускает процедуру sync_all_account_stmt в виде задания
  --
  -- @param p_startdate - банковская дата, начиная с которой будем синхронизировать записи
  --
  procedure job_sync_all_account_stmt(p_startdate in date default trunc(sysdate-1)) is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_ACC_TRANSACTIONS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job,
          'begin data_import.sync_account_stmt( '
        ||          'p_acc => null, '
        ||          'p_startdate => to_date('''||to_char(p_startdate,'DD.MM.YYYY')||''',''DD.MM.YYYY'')); '
        ||'end;');
    commit;
  end job_sync_all_account_stmt;

  ----
  -- start_capture - запускає capture process
  --
  -- @param p_capture_name - ім'я capture process-у
  --
  procedure start_capture(p_capture_name in varchar2)
  is
    l_status    sys.dba_capture.status%type;
  begin
    begin
        select status
          into l_status
          from dba_capture
         where capture_name=p_capture_name;
    exception
        when no_data_found then
            null;
    end;

    if l_status != G_STREAM_ENABLED
    then
        dbms_capture_adm.start_capture(p_capture_name);
    end if;

  end start_capture;

  ----
  -- stop_capture - зупиняє capture process
  --
  -- @param p_capture_name - ім'я capture process-у
  --
  procedure stop_capture(p_capture_name in varchar2)
  is
    l_status    sys.dba_capture.status%type;
  begin
    begin
        select status
          into l_status
          from dba_capture
         where capture_name=p_capture_name;
    exception
        when no_data_found then
            null;
    end;

    if l_status != G_STREAM_DISABLED
    then
        dbms_capture_adm.stop_capture(p_capture_name);
    end if;

  end stop_capture;

  ----
  -- start_apply - запускає apply process
  --
  -- @param p_apply_name - ім'я apply process-у
  --
  procedure start_apply(p_apply_name in varchar2)
  is
    l_status    sys.dba_apply.status%type;
    l_cnt       integer;
  begin
    -- проверка: сколько ручных синхронизаций еще в процессе
    select count(*)
      into l_cnt
      from sync_activity
     where status not in (JOB_STATUS_SUCCEEDED, JOB_STATUS_FAILED);
    if l_cnt>0
    then
        raise_application_error(-20000, 'Заборонено старт APPLY-процесу до завершення всіх процедур ручної синхронізації');
    end if;
    begin
        select status
          into l_status
          from dba_apply
         where apply_name=p_apply_name;
    exception
        when no_data_found then
            null;
    end;

    if l_status != G_STREAM_ENABLED
    then
        dbms_apply_adm.start_apply(p_apply_name);
    end if;

  end start_apply;

  ----
  -- stop_apply - зупиняє apply process
  --
  -- @param p_apply_name - ім'я apply process-у
  --
  procedure stop_apply(p_apply_name in varchar2)
  is
    l_status    sys.dba_apply.status%type;
  begin
    begin
        select status
          into l_status
          from dba_apply
         where apply_name=p_apply_name;
    exception
        when no_data_found then
            null;
    end;

    if l_status != G_STREAM_DISABLED
    then
        dbms_apply_adm.stop_apply(p_apply_name);
    end if;

  end stop_apply;

  ----
  -- migrate_offline - переводит офлайновых клиентов в онлайновые, а также их счета
  --
  procedure migrate_offline
  is
  begin
    for f in (select * from v_kf)
    loop
        bars_sync.subst_mfo(f.kf);
        migrate_offline_aux(f.kf);
    end loop;
    bars_sync.set_context;
  end migrate_offline;

  ----
  -- migrate_offline_aux - переводит офлайновых клиентов в онлайновые, а также их счета
  --                       для конкретного кода банка
  --
  procedure migrate_offline_aux(p_bankid in varchar2)
  is
    l_error_count   integer := 0;
    l_errors        dbms_utility.lname_array;
    --
    l_custids       dbms_utility.number_array;
    l_custcodes     dbms_utility.name_array;
    --
    l_accids        dbms_utility.number_array;
    l_accnums       dbms_utility.name_array;
    l_curids        dbms_utility.number_array;
    --
    l_rnk            integer;
    l_acc           integer;
    l_custtype        integer;
    l_errmsg        varchar2(4000);
    --
    l_sync          sync_activity%rowtype;
    --
  begin
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    -- и добавления нового счета
    -- и capture-процесс тоже
    check_requirements(TAB_ACC_TRANSACTIONS, p_check_capture => true);
    --
    logger.info('Старт процедури переводу офлайнових клієнтів та рахунків');
    --
    -- ВАЖНО! Ключем для идентификации клиента является идентификационный код(код ОКПО)
    --
    -- На всякий случай рефрешим локальные снимки связных таблиц
    /*
    refresh_custrnk;
    commit;
    refresh_accacc;
    commit;
    */
    --
    -- все офлайновые клиенты заносились в таблицу ibank.cust_rnk с отрицательными RNK
    -- от этого и отталкиваемся
    --
    rpc_sync.extract_offline_clients(p_bankid, l_custids, l_custcodes);
    --
    for i in 1..l_custids.count
    loop
        begin
            --
            begin
                select rnk, custtype
                  into l_rnk, l_custtype
                  from bars.customer
                 where okpo = l_custcodes(i);
            exception
                when no_data_found then
                    raise_application_error(-20000, 'Клієнта не знайдено');
                when too_many_rows then
                    raise_application_error(-20000, 'Клієнтів більше одного');
            end;
            --
            -- TODO: переписать !!
            /*
            if l_custtype=3 -- физлицо
            then
                add_individual_aux(p_bankid, l_rnk, l_custids(i));
            else
                add_company_aux(p_bankid, l_rnk, l_custids(i));
            end if;
            */
            --
            commit;
            --
            logger.info('Успішно перевели офлайнового клієнта: rnk='
                        ||l_rnk||', okpo='||l_custcodes(i)||', cust_id='||l_custids(i));
            --
        exception
            when others then
                rollback;
                l_errmsg := substr('Помилка по ідент. коду '''||l_custcodes(i)||''' : '||get_error_msg(), 1, 4000);
                logger.error(l_errmsg);
        end;
        --
    end loop;
    --
    -- теперь разбираемся со счетами
    rpc_sync.extract_offline_accounts(p_bankid, l_accids, l_accnums, l_curids);
    --
    for i in 1..l_accids.count
    loop
        begin
            begin
                select acc
                  into l_acc
                  from v_kf_accounts
                 where kf = p_bankid
                   and nls = l_accnums(i)
                   and kv = l_curids(i);
            exception
                when no_data_found then
                    raise_application_error(-20000, 'Рахунок не знайдено');
            end;
            --
            -- TODO:
            /*
            add_account_aux(l_acc, l_accids(i));
            */
            --
            commit;
            --
            logger.info('Успішно перевели офлайновий рахунок '||l_accnums(i)||'('||l_curids(i)||')');
            --
        exception
            when others then
                rollback;
                l_errmsg := substr('Помилка по рахунку '||l_accnums(i)||'('||l_curids(i)||') : '||get_error_msg(), 1, 4000);
                logger.error(l_errmsg);
        end;
    end loop;
    --
    -- инициируем синхронизацию выписок по всем счетам за последние 5 дней
    sync_all_account_stmt(trunc(sysdate)-5);
    -- проверяем результат
    select *
      into l_sync
      from sync_activity
     where table_name = TAB_ACC_TRANSACTIONS;
    --
    if l_sync.status = 'FAILED'
    then
        l_errmsg := substr('Помилка при синхронізації виписок: '||l_sync.error_message, 1, 4000);
        logger.error(l_errmsg);
    end if;
    --
    logger.info('Фініш процедури переводу офлайнових клієнтів та рахунків');
    --
  end migrate_offline_aux;

  ----
  -- sync_cust_address - синхронізація адрес контрагентів
  --
  procedure sync_cust_address
  is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    --check_requirements(TAB_CUST_ADDRESSES);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        -- проверка состояния пакета
        check_package_state();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_CUST_ADDRESSES, g_global_name, l_scn);
        --
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
            --
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_CUST_ADDRESSES, c.kf);

        end loop;
        --
        write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_INPROGRESS, 'видалення даних в БД АБС');
        --
        delete
          from cust_addresses;
        --
        write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_INPROGRESS, 'видалення даних в БД corp2');
        --
        rpc_sync.erase_cust_addresses();
        --
        write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_INPROGRESS, 'вставка даних в БД АБС');
/*
        --
        insert
          into cust_addresses(rnk, type_id, country_id, zip, region, district, city, address, bank_id)
        select ca.rnk, ca.type_id, ca.country, ca.zip, ca.domain, ca.region, ca.locality, ca.address, (select val from bars.params where par = 'GLB-MFO')
          from bars.customer_address as of scn l_scn ca where rnk in (select rnk from ibank_rnk);
         --
*/
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
          insert
            into cust_addresses(rnk, type_id, country_id, zip, region, district, city, address, bank_id)
          select ca.rnk, ca.type_id, ca.country, ca.zip, ca.domain, ca.region, ca.locality, ca.address, c.kf
            from bars.customer_address as of scn l_scn ca where rnk in (select rnk from ibank_rnk where kf = c.kf);
        end loop;

        write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_INPROGRESS, 'вставка даних в БД corp2');
        --
        rpc_sync.fill_cust_addresses;
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_cust_addresses;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_CUST_ADDRESSES, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці '||TAB_CUST_ADDRESSES);
        --
    exception when others then
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_cust_address;

  ----
  -- job_sync_cust_address - job для синхронізація адрес контрагентів
  --
  procedure job_sync_cust_address
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_CUST_ADDRESSES, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_cust_address; end;');
    commit;
  end job_sync_cust_address;

  --
  -- sync_contracts - синхронизирует импортно/экспортные контракты клиента
  --
  procedure sync_contracts(p_kf in varchar2, p_rnk in integer) is
    l_custid    integer;
  begin
  -- TODO: переписать
    null;
  end sync_contracts;

  --
  -- sync_contracts - синхронизирует импортно/экспортные контракты клиента
  --
  procedure sync_all_contracts is
  begin
    for c in (select kf, rnk from ibank_rnk)
    loop
        sync_contracts(c.kf, c.rnk);
    end loop;
  end sync_all_contracts;

  ----
  -- sync_exchange_params - синхронизация exchange_params
  --
  procedure sync_exchange_params
  is
  begin
    null;
  end sync_exchange_params;

  ----
  -- job_sync_exchange_params - синхронизация exchange_params
  --
  procedure job_sync_exchange_params
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_EXCHANGE_PARAMS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_exchange_params; end;');
    commit;
  end job_sync_exchange_params;

  ----
  -- sync_curexch_params - синхронизация curexch_params
  --
  procedure sync_curexch_params
  is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_DOC_CUREX_PARAMS);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        -- проверка состояния пакета
        check_package_state();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_DOC_CUREX_PARAMS, g_global_name, l_scn);
        --
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
            --
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_DOC_CUREX_PARAMS, c.kf);

        end loop;
        --
        write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_INPROGRESS, 'видалення даних в БД АБС');
        --
        delete
          from doc_curex_params;
        --
        write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_INPROGRESS, 'видалення даних в БД corp2');
        --
        rpc_sync.erase_doc_curex_params();
        --
        write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_INPROGRESS, 'вставка даних в БД АБС');
        --
        insert
          into doc_curex_params(par_id, par_value, par_comment, bank_id)
          select par, val, comm, (select val from bars.params where par = 'GLB-MFO')
          from bars.birja as of scn l_scn where val is not null;
        --
        write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_INPROGRESS, 'вставка даних в БД corp2');
        --
        rpc_sync.fill_doc_curex_params;
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_doc_curex_params;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_BIRJA, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці '||TAB_DOC_CUREX_PARAMS);
        --
    exception when others then
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_curexch_params;

  ----
  -- sync_curexch_params - синхронизация exchange_params
  --
  procedure job_sync_curexch_params
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_DOC_CUREX_PARAMS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_curexch_params; end;');
    commit;
  end job_sync_curexch_params;

  ----
  -- sync_curexch_custcomm - синхронизация curexch_params
  --
  procedure sync_curexch_custcomm
  is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_DOC_CUREX_CUSTCOMMISSIONS);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        -- проверка состояния пакета
        check_package_state();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_DOC_CUREX_CUSTCOMMISSIONS, g_global_name, l_scn);
        --
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
            --
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_DOC_CUREX_CUSTCOMMISSIONS, c.kf);

        end loop;
        --
        write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_INPROGRESS, 'видалення даних в БД АБС');
        --
        delete
          from doc_curex_custcommissions;
        --
        write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_INPROGRESS, 'видалення даних в БД corp2');
        --
        rpc_sync.erase_doc_curex_custcomm();
        --
        write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_INPROGRESS, 'вставка даних в БД АБС');
        --
        insert
          into doc_curex_custcommissions(rnk, buy_commission, sell_commission, conv_commission, nls_pf, bank_id)
        select rnk, cc.kom, cc.kom2, cc.kom3, nls_pf, kf
          from bars.cust_zay as of scn l_scn cc;
        --
        write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_INPROGRESS, 'вставка даних в БД corp2');
        --
        rpc_sync.fill_doc_curex_custcomm;
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_doc_curex_custcomm;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_CUSTZAY, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці '||TAB_DOC_CUREX_CUSTCOMMISSIONS);
        --
    exception when others then
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_curexch_custcomm;

  ----
  -- job_sync_curexch_custcomm - синхронизация exchange_params
  --
  procedure job_sync_curexch_custcomm
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_DOC_CUREX_CUSTCOMMISSIONS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_curexch_custcomm; end;');
    commit;
  end job_sync_curexch_custcomm;

  ----
  -- sync_curexch_exclusive - синхронизация curexch_params
  --
  procedure sync_curexch_exclusive
  is
    l_local_tag raw(2000); l_remote_tag raw(2000);
    l_scn   number;
  begin
    --
    write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_STARTED);
    --
    -- apply-процесс должен быть приостановлен на время ручной синхронизации
    check_requirements(TAB_DOC_CUREX_EXCLUSIVE);
    --
    begin
        -- точка отката
        savepoint sp;
        -- точка отсчета
        l_scn := dbms_flashback.get_system_change_number();
        -- проверка состояния пакета
        check_package_state();
        --
        replace_tags(l_local_tag, l_remote_tag);
        --
        -- инстанцируем таблицу схемы BARSAQ базы АБС БАРС в базе IBANK
        rpc_sync.instantiate_alien_table(SYNC_SCHEMA||'.'||TAB_DOC_CUREX_EXCLUSIVE, g_global_name, l_scn);
        --
        -- цикл на случай мульти-мфо
        for c in (select kf from v_kf)
        loop
            --
            -- устанавливаем точку синхронизации для удаленной таблицы на текущий момент
            rpc_sync.manual_instantiate_now(TAB_DOC_CUREX_EXCLUSIVE, c.kf);

        end loop;
        --
        write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_INPROGRESS, 'видалення даних в БД АБС');
        --
        delete
          from doc_curex_exclusive;
        --
        write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_INPROGRESS, 'видалення даних в БД corp2');
        --
        rpc_sync.erase_doc_curex_exclusive();
        --
        write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_INPROGRESS, 'вставка даних в БД АБС');
        --
        insert
          into doc_curex_exclusive(rate_id, rnk, buy_sell_flag, cur_group, cur_id, limit, commission_rate, commission_sum, date_on, date_off, bank_id)
          select ce.id, ce.rnk, ce.dk, ce.kv_grp, ce.kv, ce.limit, ce.rate, ce.fix_sum, ce.date_on, ce.date_off, ce.kf
          from bars.zay_comiss as of scn l_scn ce;
        --
        write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_INPROGRESS, 'вставка даних в БД corp2');
        --
        rpc_sync.fill_doc_curex_exclusive;
        -- синхронизируем таблицы схемы BANK и CORE в интернет-банкинге
        rpc_sync.sync_doc_curex_exclusive;
        -- фиксируем изменения
        commit;
        -- устанавливаем SCN, с которого необходимо синхронизировать таблицу в будущем
        dbms_apply_adm.set_table_instantiation_scn(SRCTAB_ZAYCOMISS, g_global_name, l_scn);
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        bars.bars_audit.info('Виконано синхронізацію таблиці '||TAB_DOC_CUREX_EXCLUSIVE);
        --
    exception when others then
        rollback to sp;
        --
        restore_tags(l_local_tag, l_remote_tag);
        --
        raise_application_error(-20000, get_error_msg());
    end;
    --
    write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_SUCCEEDED);
    --
  exception when others then
    --
    write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_FAILED, null, SQLCODE, get_error_msg());
    --
  end sync_curexch_exclusive;

  ----
  -- job_sync_curexch_exclusive - синхронизация exchange_params
  --
  procedure job_sync_curexch_exclusive
  is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_DOC_CUREX_EXCLUSIVE, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_curexch_exclusive; end;');
    commit;
  end job_sync_curexch_exclusive;


  ----
  -- sync_customers - синхронизация клиентов
  --
  procedure job_sync_customers
    is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_CUSTOMERS, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_customers; end;');
    commit;
  end job_sync_customers;

  ----
  -- sync_acctariffs - Синхронизация тарифов между схемами BANK -> CORE
  --
  procedure sync_acctariffs
  is
    l_bankid varchar2(11);
  begin

    select val into l_bankid from bars.params where par = 'GLB-MFO';

    delete from account_tariff;

    insert into account_tariff(BANK_ID,ACC_NUM,CUR_ID,START_DATE,TARIFF_CODE,TARIFF_NAME,ONE_DOC_SUM,ONE_DOC_PERC,MIN_SUM,MAX_SUM)
    select a.kf, a.nls, a.kv, at.bdate, at.kod, t.name, at.tar, at.pr, at.smin, at.smax
    from bars.ACC_TARIF at, bars.tarif t, barsaq.ibank_acc i, bars.accounts a
    where a.acc = at.acc and at.acc = i.acc and at.edate is null and AT.KOD = t.kod
    and at.kf = t.kf;

    rpc_sync.update_acctariffs(l_bankid);

    rpc_sync.sync_acctariffs(l_bankid);

  end sync_acctariffs;

  ----
  -- sync_acctariffs - синхронизация клиентов
  --
  procedure job_sync_acctariffs
    is
    l_job   binary_integer;
  begin
    write_sync_status(TAB_ACCOUNT_TARIFF, JOB_STATUS_ENQUEUED);
    dbms_job.submit(l_job, 'begin data_import.sync_acctariffs; end;');
    commit;
  end job_sync_acctariffs;


  ---------------------------------------------------------------------------------------
  --
  --  Initialization block
  --
  ---------------------------------------------------------------------------------------

  ----
  -- init - инициализация пакета
  --
  procedure init is
    l_userid    integer;
  begin
    if sys_context('userenv','client_identifier') is null
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
        logger.trace('data_import.init() new session');
    else
        logger.trace('data_import.init() existing session');
    end if;
    logger.trace('data_import.init(), proxy_user=%s, bars_global.user_id=%s',
                  nvl(sys_context('userenv', 'proxy_user'),'null'),
                  nvl(sys_context('bars_global', 'user_id'),'null')
                );
    --
    select global_name into g_global_name from global_name;
    -- читаем параметр с перечнем адресов админов модуля синхронизации
    begin
        select val
          into g_syncadm
          from bars.params
         where par='SYNCADM';
    exception
        when no_data_found then
            raise_application_error(-20000, 'Не задано параметр SYNCADM');
    end;
    --

	begin
       -- инициализация массиба мфо ощадного банка
       if g_osch_mfo_list.count  = 0 then
          for c in (select kf from regions) loop
              g_osch_mfo_list(c.kf) := 0;
          end loop;
       end if;
    end;

  end init;

begin
    init;
end data_import;
/
 show err;
 
PROMPT *** Create  grants  DATA_IMPORT ***
grant EXECUTE                                                                on BARSAQ.DATA_IMPORT     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARSAQ.DATA_IMPORT     to IBANK_ADMIN;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/data_import.sql =========*** End *
 PROMPT ===================================================================================== 
 