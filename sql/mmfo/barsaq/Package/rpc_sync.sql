
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/rpc_sync.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.RPC_SYNC is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 12.01.2011
  -- Purpose    : Оболочка для удаленного вызова процедур пакета SYNC@IBANK
  --              + дополнительные процедуры для работы с удаленными таблицами и представлениями
  --              RPC - Remote Procedure Call

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.11 27/09/2012';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- set_tag - оболочка для dbms_streams.set_tag()
  --
  procedure set_tag(tag in raw default null);

  ----
  -- get_tag - оболочка для dbms_streams.get_tag()
  --
  function get_tag return raw;

  ----
  -- instantiate_now - устанавливает точку синхронизации для указанной таблицы на текущий момент
  --
  procedure instantiate_now(p_table in varchar2);

  ----
  -- instantiate_alien_table - устанавливает точку синхронизации для чужой таблицы из чужой БД
  --
  procedure instantiate_alien_table(p_table in varchar2, p_database in varchar2, p_scn in number);

  ----
  -- manual_instantiate_now - устанавливает точку синхронизации для указанной таблицы
  --                          на текущий момент в разрезе банков(МФО)
  --
  procedure manual_instantiate_now(p_table in varchar2, p_bankid in varchar2);

  ----
  -- sync_branches - синхронизирует BANK.BRANCHES --> CORE.CORE_BRANCHES
  --
  procedure sync_branches(p_bankid in banks.bank_id%type default null);

  ----
  -- sync_bankdates - синхронизирует BANK.BANKDATES --> CORE.CORE_BANKDATES
  --
  procedure sync_bankdates(p_bankid in banks.bank_id%type default null);

  ----
  -- sync_currency_rates - синхронизирует BANK.CURRENCY_RATES --> CORE.ACC_CURRENCY_RATES
  --
  procedure sync_currency_rates(
    p_bankid        in banks.bank_id%type default null,
    p_startdate     in date,
    p_finishdate    in date);

  ----
  -- sync_holidays - синхронизирует BANK.HOLIDAYS --> CORE.CORE_HOLIDAYS
  --
  procedure sync_holidays(p_startdate in date default null);

  ----
  -- sync_banks - синхронизирует BANK.BANKS --> CORE.CORE_BANKS
  --
  procedure sync_banks;

  ----
  -- sync_swift_banks - синхронизирует BANK.SWIFT_BANKS --> CORE.SWIFT_BANKS
  --
  procedure sync_swift_banks;

  ----
  -- sync_acc_turnovers - синхронизирует BANK.ACC_TURNOVERS --> CORE.ACC_TURNOVERS
  --
  procedure sync_acc_turnovers(
	p_bankid 	 in acc_turnovers.bank_id%type,
	p_accnum	 in acc_turnovers.acc_num%type,
	p_curid		 in acc_turnovers.cur_id%type,
	p_startdate	 in acc_turnovers.turns_date%type,
    p_finishdate in acc_turnovers.turns_date%type);

  ----
  -- sync_acc_transactions - синхронизирует BANK.ACC_TRANSACTIONS --> CORE.ACC_TRANSACTIONS
  --
  procedure sync_acc_transactions(
	p_bankid 	 in acc_transactions.bank_id%type,
	p_accnum	 in acc_transactions.acc_num%type,
	p_curid		 in acc_transactions.cur_id%type,
	p_startdate	 in acc_transactions.trans_date%type,
    p_finishdate in acc_transactions.trans_date%type);

  ----
  --  Применяем чужой LCR
  --
  procedure apply_alien_lcr;

  --------------------------------------------------------------------------------
  -- check_signatures - проверка всех подписей на документе
  --
  -- @p_docid - id документа
  -- @p_result - [out] описание результата проверки подписей
  --
  -- @return 0 - все подписи верны, -1 - при проверке были ошибки, см. p_result
  --
  function check_signatures(p_docid number, p_result out varchar2)
  return number;

  --------------------------------------------------------------------------------
  -- get_status_time - возвращает время установки статуса документа
  -- @p_docid - id докумнета
  -- @p_statusid - id статуса
  --
  function get_status_time(
	p_docid           in  number,
    p_statusid        in  number)
  return date;

  ----
  -- переводим ограничения целостности в режим отложенной проверки
  --
  procedure set_constraints_deferred;

  ----
  -- переводим ограничения целостности в режим немедленной проверки
  --
  procedure set_constraints_immediate;

  ----
  -- блокируем документ
  --
  procedure lock_document(
    p_docid     in doc_export.doc_id%type,
    p_statusid  in doc_export.status_id%type);

  ----
  -- fill_tmp_clob - выполняет вставку в удаленную таблицу ibank.tmp_clob
  --
  procedure fill_tmp_clob;

  ----
  -- erase_branches - выполняет очистку удаленной таблицы
  --
  procedure erase_branches(p_kf in varchar2);

  ----
  -- fill_branches - выполняет вставку в удаленную таблицу
  --
  procedure fill_branches(p_kf in varchar2);

  ----
  -- erase_bankdates - выполняет очистку удаленной таблицы
  --
  procedure erase_bankdates(p_kf in varchar2);

  ----
  -- fill_bankdates - выполняет вставку в удаленную таблицу
  --
  procedure fill_bankdates(p_kf in varchar2);

  ----
  -- extract_doc_export_single
  --
  procedure extract_doc_export_single(p_docid in number, p_xml in xmltype);

  ----
  -- update_doc_export_status
  --
  procedure update_doc_export_status(p_docid in number);
  
  ----
  -- update_doc_export_status_open
  --
  procedure update_doc_export_status_open(p_docid in number);

  ----
  -- extract_doc_export
  --
  procedure extract_doc_export(p_bankid in varchar2, p_type_list in varchar2, p_docs out dbms_utility.number_array);

  ----
  -- get_doc_xml - возвращает xml-представление документа из интернет-банкинга
  --               (путем вызова через dblink)
  -- @p_docid        - id документа
  --
  function get_doc_xml(p_docid in number) return xmltype;

  ----
  -- erase_currency_rates - выполняет очистку удаленной таблицы
  --
  procedure erase_currency_rates(p_kf in varchar2, p_startdate in date);

  ----
  -- fill_currency_rates - выполняет вставку в удаленную таблицу
  --
  procedure fill_currency_rates(p_kf in varchar2, p_startdate in date);

  ----
  -- erase_holidays - выполняет очистку удаленной таблицы
  --
  procedure erase_holidays(p_startdate in date);

  ----
  -- fill_holidays - выполняет вставку в удаленную таблицу
  --
  procedure fill_holidays(p_startdate in date);

  ----
  -- erase_banks - выполняет очистку удаленной таблицы
  --
  procedure erase_banks;

  ----
  -- fill_banks - выполняет вставку в удаленную таблицу
  --
  procedure fill_banks;

  ----
  -- erase_swift_banks - выполняет очистку удаленной таблицы
  --
  procedure erase_swift_banks;

  ----
  -- fill_swift_banks - выполняет вставку в удаленную таблицу
  --
  procedure fill_swift_banks;

  ----
  -- erase_acc_transactions - выполняет очистку удаленной таблицы
  --
  procedure erase_acc_transactions(p_startdate in date);

  ----
  -- fill_acc_transactions - выполняет вставку в удаленную таблицу
  --
  procedure fill_acc_transactions(p_startdate in date);

  ----
  -- erase_acc_turnovers - выполняет очистку удаленной таблицы
  --
  procedure erase_acc_turnovers(p_startdate in date);

  ----
  -- fill_acc_turnovers - выполняет вставку в удаленную таблицу
  --
  procedure fill_acc_turnovers(p_startdate in date);

  ----
  -- get_acc_type - возвращает тип счета по его балансовому
  --
  function get_acc_type(p_nbs in varchar2) return varchar2;

  ----
  -- add_account - выполняет вставку в удаленную таблицу
  --
  procedure add_account(p_account in accounts%rowtype);

  ----
  -- add_customer - выполняет вставку в удаленную таблицу
  --
  procedure add_customer(p_customer in customers%rowtype);

  -- add_customer_address - выполняет вставку в удаленную таблицу
  --
  procedure add_customer_address(p_cust_address in cust_addresses%rowtype);

  ----
  -- add_company - выполняет вставку в удаленную таблицу
  --
  procedure add_company(p_company in cust_companies%rowtype);

  ----
  -- add_individual - выполняет вставку в удаленную таблицу
  --
  procedure add_individual(p_individual in cust_individuals%rowtype);

  ----
  -- extract_offline_clients
  --
  procedure extract_offline_clients(p_bankid     in varchar2,
									p_custids   out dbms_utility.number_array,
                                    p_custcodes out dbms_utility.name_array
                                   );

  ----
  -- extract_offline_accounts
  --
  procedure extract_offline_accounts(p_bankid     in varchar2,
								 	 p_accids    out dbms_utility.number_array,
                                     p_accnums   out dbms_utility.name_array,
                                     p_curids    out dbms_utility.number_array
                                   );

  ----
  -- erase_exchange_params - выполняет очистку удаленной таблицы
  --
  procedure erase_exchange_params;

  ----
  -- fill_exchange_params - выполняет вставку в удаленную таблицу
  --
  procedure fill_exchange_params;

  ----
  -- sync_exchange_params - синхронизирует BANK.exchange_params --> CORE.exchange_params
  --
  procedure sync_exchange_params;

  ----
  -- sync_customer - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_customer(
    p_bankid  in varchar2,
    p_rnk     in integer
  );

  ----
  -- sync_company - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_company(
    p_bankid  in varchar2,
    p_rnk     in integer
  );

  ----
  -- sync_individual - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_individual(
    p_bankid  in varchar2,
    p_rnk     in integer
  );

  ----
  -- sync_account - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_account(
    p_bankid  in varchar2,
    p_accnum  in varchar2,
    p_curid   in integer
  );
  
  ----
  -- get_corp2_acc
  --
  procedure get_corp2_acc(
    p_bankid  in varchar2,
    p_accnum  in varchar2,
    p_curid   in integer,
    p_acc_corp2 out ibank_acc.acc_corp2%type    
  );

  ----
  -- erase_doc_curex_params - выполняет очистку удаленной таблицы
  --
  procedure erase_doc_curex_params;

  ----
  -- fill_doc_curex_params - выполняет вставку в удаленную таблицу
  --
  procedure fill_doc_curex_params;

  ----
  -- sync_doc_curex_params - синхронизирует BANK.doc_curex_params --> CORE.doc_curex_params
  --
  procedure sync_doc_curex_params;

  ----
  -- erase_doc_curex_custcomm - выполняет очистку удаленной таблицы
  --
  procedure erase_doc_curex_custcomm;

  ----
  -- fill_doc_curex_custcomm - выполняет вставку в удаленную таблицу
  --
  procedure fill_doc_curex_custcomm;

  ----
  -- sync_doc_curex_custcomm - синхронизирует BANK.doc_curex_custcommissions --> CORE.doc_curex_custcommissions
  --
  procedure sync_doc_curex_custcomm;

  ----
  -- erase_doc_curex_exclusive - выполняет очистку удаленной таблицы
  --
  procedure erase_doc_curex_exclusive;

  ----
  -- fill_doc_curex_exclusive - выполняет вставку в удаленную таблицу
  --
  procedure fill_doc_curex_exclusive;

  ----
  -- sync_doc_curex_exclusive - синхронизирует BANK.doc_curex_exclusive --> CORE.doc_curex_exclusive
  --
  procedure sync_doc_curex_exclusive;

  ----
  -- erase_cust_addresses - выполняет очистку удаленной таблицы
  --
  procedure erase_cust_addresses;

  ----
  -- fill_cust_addresses - выполняет вставку в удаленную таблицу
  --
  procedure fill_cust_addresses;

  ----
  -- sync_cust_addresses - синхронизирует BANK.cust_addresses --> CORE.cust_addresses
  --
  procedure sync_cust_addresses;

  ----
  -- trunc_tmp_table - выполняет операцию truncate над временной таблицей tmp_<p_table>
  --
  procedure trunc_tmp_table(p_table in varchar2);

  ----
  -- fill_tmp_acc_turnovers - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_turnovers(p_startdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer);

  ----
  -- fill_tmp_acc_transactions - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_transactions(p_startdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer);

  ----
  -- fill_tmp_acc_period_turnovers - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_pr_turnovers(p_startdate in date, p_finishdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer);

  ----
  -- fill_tmp_acc_period_transactions - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_pr_transactions(p_startdate in date, p_finishdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer);

  ----
  -- sync_stmt - вызывает удаленную процедуру синхронизации выписки(обороты+транзакции)
  --
  procedure sync_stmt(p_startdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer);

  ----
  -- sync_period_stmt - вызывает удаленную процедуру синхронизации выписки(обороты+транзакции) за период
  --
  procedure sync_period_stmt(p_startdate in date, p_finishdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer);

  ----
  -- erase_streams_heartbeat - выполняет очистку удаленной таблицы
  --
  procedure erase_streams_heartbeat;

  ----
  -- fill_streams_heartbeat - выполняет вставку в удаленную таблицу
  --
  procedure fill_streams_heartbeat;

  ----
  -- sync_streams_heartbeat - синхронизирует BANK.streams_heartbeat --> CORE.streams_heartbeat
  --
  procedure sync_streams_heartbeat;

  ----
  -- manual_global_instantiate_now - устанавливает точку синхронизации для указанной таблицы
  --                          на текущий момент в разрезе глобальных имен БД
  --
  procedure manual_global_instantiate_now(p_table in varchar2, p_globalname in varchar2);

  ----
  -- user_global_instantiate_now - устанавливает точку синхронизации для указанной таблицы
  --                          на текущий момент в разрезе глобальных имен БД
  --                          по привязке global_name к user_name
  --
  procedure user_global_instantiate_now(p_table in varchar2);

  ----
  -- update_customer - модифицирует строку таблицы customers
  --
  procedure update_customer(p_row customers%rowtype);

  ----
  -- update_individual - модифицирует строку таблицы cust_individuals
  --
  procedure update_individual(p_row cust_individuals%rowtype);

  ----
  -- update_company - модифицирует строку таблицы cust_companies
  --
  procedure update_company(p_row cust_companies%rowtype);

  ----
  -- sync_customers - Синхронизация клиентов между схемами BANK -> CORE
  --
  procedure sync_customers (p_bankid varchar2);

  ----
  -- update_acctariffs - Обновление тарифов в схеме BANK
  --
  procedure update_acctariffs (p_bankid varchar2);

  ----
  -- sync_acctariffs - Синхронизация тарифов между схемами BANK -> CORE
  --
  procedure sync_acctariffs (p_bankid varchar2);

end rpc_sync;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.RPC_SYNC is

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.15 26/12/2014';

  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''
	||'KF - схема с полем ''kf''' || chr(10)
	||'GOU - ГОУ Ощадбанка' || chr(10)
  ;

  -- global variables

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header RPC_SYNC '||G_HEADER_VERSION;
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
  -- set_tag - оболочка для dbms_streams.set_tag()
  --
  procedure set_tag(tag in raw default null) is
  begin
    execute immediate 'call ibank.sync.set_tag(:tag)' using tag;
  end set_tag;

  ----
  -- get_tag - оболочка для dbms_streams.get_tag()
  --
  function get_tag return raw is
    l_tag raw(2000);
  begin
    execute immediate 'call ibank.sync.get_tag() into :l_tag' using out l_tag;
    return l_tag;
  end get_tag;

  ----
  -- instantiate_now - устанавливает точку синхронизации для указанной таблицы на текущий момент
  --
  procedure instantiate_now(p_table in varchar2)
  is
  begin
    execute immediate 'call ibank.sync.instantiate_now(:p_table)' using p_table;
  end instantiate_now;

  ----
  -- instantiate_alien_table - устанавливает точку синхронизации для чужой таблицы из чужой БД
  --
  procedure instantiate_alien_table(p_table in varchar2, p_database in varchar2, p_scn in number)
  is
  begin
    execute immediate 'call ibank.sync.instantiate_alien_table(:p_table, :p_database, :p_scn)'
    using p_table, p_database, p_scn;
  end instantiate_alien_table;

  ----
  -- manual_instantiate_now - устанавливает точку синхронизации для указанной таблицы
  --                          на текущий момент в разрезе банков(МФО)
  --
  procedure manual_instantiate_now(p_table in varchar2, p_bankid in varchar2)
  is
  begin
    execute immediate 'call ibank.sync.manual_instantiate_now(:p_table, :p_bankid)'
      using p_table, p_bankid;
  end manual_instantiate_now;

  ----
  -- sync_branches - синхронизирует BANK.BRANCHES --> CORE.CORE_BRANCHES
  --
  procedure sync_branches(p_bankid in banks.bank_id%type default null)
  is
  begin
    execute immediate 'call ibank.sync.sync_branches(:p_bankid)' using p_bankid;
  end sync_branches;

  ----
  -- sync_bankdates - синхронизирует BANK.BANKDATES --> CORE.CORE_BANKDATES
  --
  procedure sync_bankdates(p_bankid in banks.bank_id%type default null)
  is
  begin
    execute immediate 'call ibank.sync.sync_bankdates(:p_bankid)' using p_bankid;
  end sync_bankdates;

  ----
  -- sync_currency_rates - синхронизирует BANK.CURRENCY_RATES --> CORE.ACC_CURRENCY_RATES
  --
  procedure sync_currency_rates(
    p_bankid     in banks.bank_id%type default null,
    p_startdate  in date,
    p_finishdate in date)
  is
  begin
    execute immediate 'call ibank.sync.sync_currency_rates(:p_bankid, :p_startdate, :p_finishdate)'
      using p_bankid, p_startdate, p_finishdate;
  end sync_currency_rates;

  ----
  -- sync_holidays - синхронизирует BANK.HOLIDAYS --> CORE.CORE_HOLIDAYS
  --
  procedure sync_holidays(p_startdate in date default null)
  is
  begin
    execute immediate 'call ibank.sync.sync_holidays(:p_startdate)'
      using p_startdate;
  end sync_holidays;

  ----
  -- sync_banks - синхронизирует BANK.BANKS --> CORE.CORE_BANKS
  --
  procedure sync_banks is
  begin
    execute immediate 'call ibank.sync.sync_banks()';
  end sync_banks;

  ----
  -- sync_swift_banks - синхронизирует BANK.SWIFT_BANKS --> CORE.SWIFT_BANKS
  --
  procedure sync_swift_banks is
  begin
    execute immediate 'call ibank.sync.sync_swift_banks()';
  end sync_swift_banks;

  ----
  -- sync_acc_turnovers - синхронизирует BANK.ACC_TURNOVERS --> CORE.ACC_TURNOVERS
  --
  procedure sync_acc_turnovers(
	p_bankid 	 in acc_turnovers.bank_id%type,
	p_accnum	 in acc_turnovers.acc_num%type,
	p_curid		 in acc_turnovers.cur_id%type,
	p_startdate	 in acc_turnovers.turns_date%type,
    p_finishdate in acc_turnovers.turns_date%type)
  is
  begin
    execute immediate
        'call ibank.sync.sync_acc_turnovers(:p_bankid, :p_accnum, :p_curid, :p_startdate, :p_finishdate)'
      using p_bankid, p_accnum, p_curid, p_startdate, p_finishdate;
  end sync_acc_turnovers;

  ----
  -- sync_acc_transactions - синхронизирует BANK.ACC_TRANSACTIONS --> CORE.ACC_TRANSACTIONS
  --
  procedure sync_acc_transactions(
	p_bankid 	 in acc_transactions.bank_id%type,
	p_accnum	 in acc_transactions.acc_num%type,
	p_curid		 in acc_transactions.cur_id%type,
	p_startdate	 in acc_transactions.trans_date%type,
    p_finishdate in acc_transactions.trans_date%type)
  is
  begin
    execute immediate
        'call ibank.sync.sync_acc_transactions(:p_bankid, :p_accnum, :p_curid, :p_startdate, :p_finishdate)'
      using p_bankid, p_accnum, p_curid, p_startdate, p_finishdate;
  end sync_acc_transactions;

  ----
  --  Применяем чужой LCR
  --
  procedure apply_alien_lcr
  is
  begin
    execute immediate 'call ibank.sync.apply_alien_lcr()';
  end apply_alien_lcr;

  --------------------------------------------------------------------------------
  -- check_signatures - проверка всех подписей на документе
  --
  -- @p_docid - id документа
  -- @p_result - [out] описание результата проверки подписей
  --
  -- @return 0 - все подписи верны, -1 - при проверке были ошибки, см. p_result
  --
  function check_signatures(p_docid number, p_result out varchar2)
  return number
  is
    l_check  number;
  begin
    execute immediate 'call ibank.sync.check_signatures(:p_docid, :p_result) into :l_check'
      using p_docid, out p_result, out l_check;
    return l_check;
  end check_signatures;

  --------------------------------------------------------------------------------
  -- get_status_time - возвращает время установки статуса документа
  -- @p_docid - id докумнета
  -- @p_statusid - id статуса
  --
  function get_status_time(
	p_docid           in  number,
    p_statusid        in  number)
  return date
  is
    l_time date;
  begin
    execute immediate 'call ibank.sync.get_status_time(:p_docid, :p_statusid) into :l_time'
      using p_docid, p_statusid, out l_time;
    return l_time;
  end get_status_time;

  ----
  -- переводим ограничения целостности в режим отложенной проверки
  --
  procedure set_constraints_deferred
  is
  begin
    execute immediate 'call ibank.set_constraints_deferred()';
  end set_constraints_deferred;

  ----
  -- переводим ограничения целостности в режим немедленной проверки
  --
  procedure set_constraints_immediate
  is
  begin
    execute immediate 'call ibank.set_constraints_immediate()';
  end set_constraints_immediate;

  ----
  -- блокируем документ
  --
  procedure lock_document(
    p_docid     in doc_export.doc_id%type,
    p_statusid  in doc_export.status_id%type)
  is
  begin
    execute immediate 'call ibank.lock_document(:p_docid, :p_statusid)'
      using p_docid, p_statusid;
  end lock_document;

  ----
  -- fill_tmp_clob - выполняет вставку в удаленную таблицу ibank.tmp_clob
  --
  procedure fill_tmp_clob
  is
  begin
    execute immediate 'insert into ibank.tmp_clob select aclob from tmp_clob';
  end;

  ----
  -- erase_branches - выполняет очистку удаленной таблицы
  --
  procedure erase_branches(p_kf in varchar2)
  is
  begin
    execute immediate
   'delete
      from ibank.v_branches
     where bank_id=:p_kf'
    using p_kf;
    --
  end erase_branches;

  ----
  -- fill_branches - выполняет вставку в удаленную таблицу
  --
  procedure fill_branches(p_kf in varchar2)
  is
  begin
    execute immediate
   'insert
      into ibank.v_branches(bank_id,branch_id,name,date_opened,date_closed,nbu_code,description)
    select bank_id,branch_id,name,date_opened,date_closed,nbu_code,description
      from branches
     where bank_id=:p_kf'
    using p_kf;
    --
  end fill_branches;

  ----
  -- erase_bankdates - выполняет очистку удаленной таблицы
  --
  procedure erase_bankdates(p_kf in varchar2)
  is
  begin
    execute immediate
   'delete
      from ibank.v_bankdates
     where bank_id=:p_kf'
    using p_kf;
    --
  end erase_bankdates;

  ----
  -- fill_bankdates - выполняет вставку в удаленную таблицу
  --
  procedure fill_bankdates(p_kf in varchar2)
  is
  begin
    execute immediate
   'insert
      into ibank.v_bankdates(bank_id, bankdate)
    select bank_id, bankdate
      from bankdates
     where bank_id=:p_kf'
    using p_kf;
    --
  end fill_bankdates;

  ----
  -- extract_doc_export_single
  --
  procedure extract_doc_export_single(p_docid in number, p_xml in xmltype)
  is
  begin
    execute immediate
    /*'insert all 
       into doc_export(doc_id,doc_xml,bank_id,type_id,status_id,status_change_time) values (doc_id,doc_xml,bank_id,type_id,status_id,status_change_time)
       into doc_export_files(doc_id, doc_file) values (doc_id, doc_desc)
     select doc_id, :p_xml doc_xml, bank_id, type_id, status_id, status_change_time, doc_desc
     from ibank.v_doc_export where doc_id=:p_docid'
    using p_xml, p_docid;*/
   'insert into doc_export(doc_id,doc_xml,bank_id,type_id,status_id,status_change_time)
    select doc_id,:p_xml,bank_id,type_id,status_id,status_change_time
    from ibank.v_doc_export where doc_id=:p_docid'
    using p_xml, p_docid;
    -- insert files
   execute immediate
   'insert into doc_export_files(doc_id,doc_file)
    select doc_id, doc_desc
    from ibank.v_doc_export where doc_id=:p_docid and doc_desc is not null'
   using p_docid;
  end extract_doc_export_single;

  ----
  -- update_doc_export_status
  --
  procedure update_doc_export_status(p_docid in number)
  is
  begin
    execute immediate
   'update ibank.v_doc_export d set
       (status_id, status_change_time, bank_accept_date, bank_ref, bank_back_date,
        bank_back_reason, bank_back_reason_aux, bank_syserr_date, bank_syserr_msg
       ) =
       (select nvl(status_id, d.status_id), status_change_time, nvl(bank_accept_date, d.bank_accept_date),
               bank_ref, bank_back_date, bank_back_reason, bank_back_reason_aux, bank_syserr_date, bank_syserr_msg
          from doc_export
         where doc_id=:p_docid
       )
    where doc_id=:p_docid'
    using p_docid, p_docid;
  end update_doc_export_status;
  
  ----
  -- update_doc_export_status
  --
  procedure update_doc_export_status_open(p_docid in number)
  is
  begin
    execute immediate
   'update ibank.v_doc_export_open d set
       (status_id, status_change_time, bank_accept_date, bank_ref, bank_back_date,
        bank_back_reason, bank_back_reason_aux, bank_syserr_date, bank_syserr_msg
       ) =
       (select nvl(status_id, d.status_id), status_change_time, nvl(bank_accept_date, d.bank_accept_date),
               bank_ref, bank_back_date, bank_back_reason, bank_back_reason_aux, bank_syserr_date, bank_syserr_msg
          from doc_export
         where doc_id=:p_docid
       )
    where doc_id=:p_docid'
    using p_docid, p_docid;
  end update_doc_export_status_open;

  ----
  -- extract_doc_export
  --
  procedure extract_doc_export(p_bankid in varchar2, p_type_list in varchar2, p_docs out dbms_utility.number_array)
  is
  begin
    execute immediate
    'select doc_id
       from (select doc_id
               from ibank.v_doc_export
              where case when status_id=35 then bank_id else null end = :p_bankid
                and type_id in ('||p_type_list||')
              order by doc_id)
      where rownum <= 1000'
    bulk collect into p_docs
    using p_bankid;
    --
  end extract_doc_export;

----
  -- get_doc_xml - возвращает xml-представление документа из интернет-банкинга
  --               (путем вызова через dblink)
  -- @p_docid        - id документа
  --
  function get_doc_xml(p_docid in number) return xmltype
  is
    l_xml   xmltype;
  begin
    execute immediate 'select doc_xml from ibank.v_doc_export where doc_id=:p_docid'
       into l_xml
      using p_docid;
    return xmltype(convert(l_xml.getClobVal(), 'CL8MSWIN1251', 'AL32UTF8'));
  end get_doc_xml;

  ----
  -- erase_currency_rates - выполняет очистку удаленной таблицы
  --
  procedure erase_currency_rates(p_kf in varchar2, p_startdate in date)
  is
  begin
    execute immediate
   'delete
      from ibank.v_currency_rates
     where bank_id=:p_kf
       and rate_date >= :p_startdate'
    using p_kf, p_startdate;
  end erase_currency_rates;

  ----
  -- fill_currency_rates - выполняет вставку в удаленную таблицу
  --
  procedure fill_currency_rates(p_kf in varchar2, p_startdate in date)
  is
  begin
    execute immediate
   'insert
      into ibank.v_currency_rates(rate_date,bank_id,cur_id,base_sum,rate_official,rate_buying,rate_selling)
    select rate_date,bank_id,cur_id,base_sum,rate_official,rate_buying,rate_selling
      from currency_rates
     where bank_id = :p_kf
       and rate_date >= :p_startdate'
    using p_kf, p_startdate;
    --
    --raise_application_error(-20000, sql%rowcount);
    -- вставка гривны
    begin
        execute immediate
       'insert
          into ibank.v_currency_rates(rate_date,bank_id,cur_id,base_sum,rate_official)
        values (to_date(''01.01.1900'',''DD.MM.YYYY''), :p_kf, 980, 1, 1)'
        using p_kf;
    exception
        when dup_val_on_index then
            null;
    end;
  end fill_currency_rates;

  ----
  -- erase_holidays - выполняет очистку удаленной таблицы
  --
  procedure erase_holidays(p_startdate in date)
  is
  begin
    execute immediate
   'delete
      from ibank.holidays
     where holiday >= :p_startdate'
    using p_startdate;
  end erase_holidays;

  ----
  -- fill_holidays - выполняет вставку в удаленную таблицу
  --
  procedure fill_holidays(p_startdate in date)
  is
  begin
    execute immediate
   'insert
      into ibank.holidays(holiday, cur_id)
    select holiday, cur_id
      from holidays
     where holiday >= :p_startdate'
    using p_startdate;
  end fill_holidays;

  ----
  -- erase_banks - выполняет очистку удаленной таблицы
  --
  procedure erase_banks
  is
  begin
    execute immediate
   'delete
      from ibank.banks';
  end erase_banks;

  ----
  -- fill_banks - выполняет вставку в удаленную таблицу
  --
  procedure fill_banks
  is
  begin
    execute immediate
   'insert
      into ibank.banks(bank_id,name,closing_date)
    select bank_id,name,closing_date
      from banks';
  end fill_banks;

  ----
  -- erase_swift_banks - выполняет очистку удаленной таблицы
  --
  procedure erase_swift_banks
  is
  begin
    execute immediate
   'delete
      from ibank.swift_banks';
  end erase_swift_banks;

  ----
  -- fill_swift_banks - выполняет вставку в удаленную таблицу
  --
  procedure fill_swift_banks
  is
  begin
    execute immediate
   'insert
      into ibank.swift_banks(bic_id, name, office, city, country, closing_date)
    select bic_id, name, office, city, country, closing_date
      from swift_banks';
  end fill_swift_banks;

  ----
  -- erase_acc_transactions - выполняет очистку удаленной таблицы
  --
  procedure erase_acc_transactions(p_startdate in date)
  is
  begin
    execute immediate
   'delete
      from ibank.v_acc_transactions
     where (bank_id, acc_num, cur_id) in
               (select bank_id, acc_num, cur_id
                  from tmp_acc
               )
       and trans_date >= :p_startdate'
    using p_startdate;
  end erase_acc_transactions;

  ----
  -- fill_acc_transactions - выполняет вставку в удаленную таблицу
  --
  procedure fill_acc_transactions(p_startdate in date)
  is
  begin
    execute immediate
   'insert
      into ibank.v_acc_transactions (
           bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
           trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
           corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
    select bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
           trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
           corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name
      from acc_transactions
     where (bank_id, acc_num, cur_id) in
           (select bank_id, acc_num, cur_id
              from tmp_acc
           )
       and trans_date >= :p_startdate'
    using p_startdate;
  end fill_acc_transactions;

  ----
  -- erase_acc_turnovers - выполняет очистку удаленной таблицы
  --
  procedure erase_acc_turnovers(p_startdate in date)
  is
  begin
    execute immediate
   'delete
      from ibank.v_acc_turnovers a
     where exists (select 1
                     from tmp_acc
                    where a.bank_id = bank_id
                      and a.acc_num = acc_num
                      and a.cur_id  = cur_id
                      and a.turns_date >= least(:p_startdate, dapp)
                  )'
    using p_startdate;
  end erase_acc_turnovers;

  ----
  -- fill_acc_turnovers - выполняет вставку в удаленную таблицу
  --
  procedure fill_acc_turnovers(p_startdate in date)
  is
  begin
    execute immediate
   'insert
      into ibank.v_acc_turnovers (
              bank_id, acc_num, cur_id, turns_date, prev_turns_date,
              balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
    select a.bank_id, a.acc_num, a.cur_id, a.turns_date, a.prev_turns_date,
           a.balance, a.debit_turns, a.credit_turns, a.balance_eq, a.debit_turns_eq, a.credit_turns_eq
      from acc_turnovers a, tmp_acc c
     where a.bank_id = c.bank_id
       and a.acc_num = c.acc_num
       and a.cur_id  = c.cur_id
       and a.turns_date >= least(:p_startdate, c.dapp)'
    using p_startdate;
  end fill_acc_turnovers;

  ----
  -- get_acc_type - возвращает тип счета по его балансовому
  --
  function get_acc_type(p_nbs in varchar2) return varchar2
  is
    l_typeid varchar2(30);
  begin
    execute immediate
    'select type_id
       from ibank.nbs_acctypes
      where nbs = :p_nbs'
       into l_typeid
      using p_nbs;
    --
    return l_typeid;
    --
  end get_acc_type;

  ----
  -- add_account - выполняет вставку в удаленную таблицу
  --
  procedure add_account(p_account in accounts%rowtype)
  is
  begin
    execute immediate
    'insert
       into ibank.v_accounts2(
            bank_id,
            acc_num,
            cur_id,
	        rnk,
            name,
            branch_id,
            opening_date,
            closing_date,
            paf_id,
            type_id,
            lock_debit,
            lock_credit,
            alt_name,
            limit,
            fin_date,
	    	fin_balance,
		    debit_turns,
		    credit_turns,
		    eq_date,
	    	eq_balance,
		    eq_debit_turns,
		    eq_credit_turns
            )
     values (
            :p_bank_id,
            :p_acc_num,
            :p_cur_id,
	        :p_rnk,
            :p_name,
            :p_branch_id,
            :p_opening_date,
            :p_closing_date,
            :p_paf_id,
            :p_type_id,
            :p_lock_debit,
            :p_lock_credit,
            :p_alt_name,
            :p_limit,
		    :p_fin_date,
	    	:p_fin_balance,
		    :p_debit_turns,
		    :p_credit_turns,
		    :p_eq_date,
	    	:p_eq_balance,
		    :p_eq_debit_turns,
		    :p_eq_credit_turns)'
     using  p_account.bank_id,
            p_account.acc_num,
            p_account.cur_id,
	        p_account.rnk,
            p_account.name,
            p_account.branch_id,
            p_account.opening_date,
            p_account.closing_date,
            p_account.paf_id,
            p_account.type_id,
            p_account.lock_debit,
            p_account.lock_credit,
            p_account.alt_name,
            p_account.limit,
		    p_account.fin_date,
	    	p_account.fin_balance,
		    p_account.debit_turns,
		    p_account.credit_turns,
		    p_account.eq_date,
	    	p_account.eq_balance,
		    p_account.eq_debit_turns,
		    p_account.eq_credit_turns;
  end add_account;

  ----
  -- add_customer - выполняет вставку в удаленную таблицу
  --
  procedure add_customer(p_customer in customers%rowtype)
  is
  begin
    execute immediate
   'insert
      into ibank.v_customers2(
           bank_id,
           rnk,
           type_id,
           name,
           english_name,
           short_name,
		   russian_name,
           cust_code,
           prt_id,
           country_id,
           cov_id,
           insider_id,
           opened,
           closed,
           notes,
           cust_limit)
    values (
           :p_bank_id,
           :p_rnk,
           :p_type_id,
           :p_name,
           :p_english_name,
           :p_short_name,
		   :p_russian_name,
           :p_cust_code,
           :p_prt_id,
           :p_country_id,
           :p_cov_id,
           :p_insider_id,
           :p_opened,
           :p_closed,
           :p_notes,
           :p_cust_limit)'
     using
           p_customer.bank_id,
           p_customer.rnk,
           p_customer.type_id,
           p_customer.name,
           p_customer.english_name,
           p_customer.short_name,
		   p_customer.russian_name,
           p_customer.cust_code,
           p_customer.prt_id,
           p_customer.country_id,
           p_customer.cov_id,
           p_customer.insider_id,
           p_customer.opened,
           p_customer.closed,
           p_customer.notes,
           p_customer.cust_limit;
  end add_customer;

  -- add_customer_address - выполняет вставку в удаленную таблицу
  --
  procedure add_customer_address(p_cust_address in cust_addresses%rowtype)
  is
  begin
    execute immediate
   'insert
      into bank.cust_addresses(
            rnk,
            type_id,
            country_id,
            zip,
            region,
            district,
            city,
            address,
			bank_id)
    values (
           :p_rnk,
           :p_type_id,
           :p_country_id,
           :p_zip,
           :p_region,
           :p_district,
           :p_city,
           :p_address,
		   :p_bankid)'
     using
           p_cust_address.rnk,
           p_cust_address.type_id,
           p_cust_address.country_id,
           p_cust_address.zip,
           p_cust_address.region,
           p_cust_address.district,
           p_cust_address.city,
           p_cust_address.address,
		   p_cust_address.bank_id;
  end add_customer_address;
  ----

  ----
  -- add_company - выполняет вставку в удаленную таблицу
  --
  procedure add_company(p_company in cust_companies%rowtype)
  is
  begin
    execute immediate
   'insert
      into ibank.v_cust_companies2
           (
            bank_id,
            rnk,
            article_name,
            head_name,
            head_phone,
            accountant_name,
            accountant_phone,
            fax,
            email
           )
    values (
            :p_bank_id,
            :p_rnk,
            :p_article_name,
            :p_head_name,
            :p_head_phone,
            :p_accountant_name,
            :p_accountant_phone,
            :p_fax,
            :p_email
           )'
     using  p_company.bank_id,
            p_company.rnk,
            p_company.article_name,
            p_company.head_name,
            p_company.head_phone,
            p_company.accountant_name,
            p_company.accountant_phone,
            p_company.fax,
            p_company.email;
  end add_company;

  ----
  -- add_individual - выполняет вставку в удаленную таблицу
  --
  procedure add_individual(p_individual in cust_individuals%rowtype)
  is
  begin
    execute immediate
   'insert
      into ibank.v_cust_individuals2
           (
            bank_id,
            rnk,
            id_id,
            id_serial,
            id_number,
            id_date,
            id_issuer,
            birthday,
            birthplace,
            phone_home,
            phone_work,
            phone_mobile,
            email,
            id_date_valid
           )
    values (
            :p_bank_id,
            :p_rnk,
            :p_id_id,
            :p_id_serial,
            :p_id_number,
            :p_id_date,
            :p_id_issuer,
            :p_birthday,
            :p_birthplace,
            :p_phone_home,
            :p_phone_work,
            :p_phone_mobile,
            :p_email,
            :id_date_valid)'
      using
            p_individual.bank_id,
            p_individual.rnk,
            p_individual.id_id,
            p_individual.id_serial,
            p_individual.id_number,
            p_individual.id_date,
            p_individual.id_issuer,
            p_individual.birthday,
            p_individual.birthplace,
            p_individual.phone_home,
            p_individual.phone_work,
            p_individual.phone_mobile,
            p_individual.email,
            p_individual.id_date_valid;
  end add_individual;

  ----
  -- extract_offline_clients
  --
  procedure extract_offline_clients(p_bankid     in varchar2,
									p_custids   out dbms_utility.number_array,
                                    p_custcodes out dbms_utility.name_array
                                   )
  is
  begin
    --
    execute immediate
    'select c.cust_id, c.cust_code
       from ibank.v_cust_rnk r, ibank.v_customers c
      where r.bank_id = :p_bankid
        and r.rnk < 0
        and r.cust_id = c.cust_id'
    bulk collect into p_custids, p_custcodes
    using p_bankid;
    --
  end extract_offline_clients;

  ----
  -- extract_offline_accounts
  --
  procedure extract_offline_accounts(p_bankid     in varchar2,
								 	 p_accids    out dbms_utility.number_array,
                                     p_accnums   out dbms_utility.name_array,
                                     p_curids    out dbms_utility.number_array
                                    )
  is
  begin
	--
	execute immediate
    'select a.acc_id, a.acc_num, a.cur_id
       from ibank.v_accounts a
      where a.bank_id = :p_bankid
        and not exists (select 1
                          from ibank.v_acc_acc
                         where acc_id = a.acc_id
                       )
    '
    bulk collect into p_accids, p_accnums, p_curids
    using p_bankid;
	--
  end extract_offline_accounts;

  ----
  -- erase_exchange_params - выполняет очистку удаленной таблицы
  --
  procedure erase_exchange_params
  is
  begin
    execute immediate
   'delete
      from ibank.exchange_params';
  end erase_exchange_params;

  ----
  -- fill_exchange_params - выполняет вставку в удаленную таблицу
  --
  procedure fill_exchange_params
  is
  begin
    execute immediate
   'insert
      into ibank.exchange_params(par, val, comm)
    select par, val, comm
      from exchange_params';
  end fill_exchange_params;

  ----
  -- sync_exchange_params - синхронизирует BANK.exchange_params --> CORE.exchange_params
  --
  procedure sync_exchange_params
  is
  begin
	execute immediate 'call ibank.sync.sync_exchange_params()';
  end sync_exchange_params;

  ----
  -- sync_customer - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_customer(
    p_bankid  in varchar2,
    p_rnk     in integer
  )
  is
  begin
    execute immediate 'call ibank.sync.sync_customer(:p_bankid, :p_rnk)'
      using p_bankid, p_rnk;
  end sync_customer;

  ----
  -- sync_company - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_company(
    p_bankid  in varchar2,
    p_rnk     in integer
  )
  is
  begin
    execute immediate 'call ibank.sync.sync_company(:p_bankid, :p_rnk)'
      using p_bankid, p_rnk;
  end sync_company;

  ----
  -- sync_individual - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_individual(
    p_bankid  in varchar2,
    p_rnk     in integer
  )
  is
  begin
    execute immediate 'call ibank.sync.sync_individual(:p_bankid, :p_rnk)'
      using p_bankid, p_rnk;
  end sync_individual;

  ----
  -- sync_account - создает новую запись в схеме CORE по данным схемы BANK
  --
  procedure sync_account(
    p_bankid  in varchar2,
    p_accnum  in varchar2,
    p_curid   in integer
  )
  is
  begin
    execute immediate 'call ibank.sync.sync_account(:p_bankid, :p_accnum, :p_curid)'
      using p_bankid, p_accnum, p_curid;
  end sync_account;
  
  ----
  -- get_corp2_acc
  --
  procedure get_corp2_acc(
    p_bankid  in varchar2,
    p_accnum  in varchar2,
    p_curid   in integer,
    p_acc_corp2 out ibank_acc.acc_corp2%type    
  )
  is
  begin
    execute immediate 'begin :p_acc_corp2 := ibank.sync.get_corp2_account(:p_bankid, :p_accnum, :p_curid); end;'
      using OUT p_acc_corp2, IN p_bankid, IN p_accnum, IN p_curid;
  end get_corp2_acc;

  -- erase_doc_curex_params - выполняет очистку удаленной таблицы
  --
/*
  procedure erase_doc_curex_params
  is
    l_bankid varchar2(6);
  begin
    select val into l_bankid from bars.params where par = 'GLB-MFO';
    execute immediate 'delete from ibank.doc_curex_params where bank_id = :1' using l_bankid;
  end erase_doc_curex_params;
*/ 
  procedure erase_doc_curex_params
  is
  begin
    -- цикл на случай мульти-мфо
    for c in (select kf from v_kf)
    loop
      execute immediate 'delete from ibank.doc_curex_params where bank_id = :1' using c.kf;
    end loop;
  end erase_doc_curex_params;


  ----
  -- fill_doc_curex_params - выполняет вставку в удаленную таблицу
  --
  procedure fill_doc_curex_params
  is
  begin
    execute immediate
   'insert
      into ibank.doc_curex_params(par_id, par_value, par_comment,bank_id)
    select par_id, par_value, par_comment, bank_id
      from doc_curex_params';
  end fill_doc_curex_params;


  ----
  -- sync_doc_curex_params - синхронизирует BANK.doc_curex_params --> CORE.doc_curex_params
  --
  procedure sync_doc_curex_params
  is
  begin
	execute immediate 'call ibank.sync.sync_doc_curex_params()';
  end sync_doc_curex_params;

  ----
  -- erase_doc_curex_custcomm - выполняет очистку удаленной таблицы
  --
/*        
  procedure erase_doc_curex_custcomm
  is
    l_bankid varchar2(6);
  begin
    select val into l_bankid from bars.params where par = 'GLB-MFO';
    execute immediate 'delete from ibank.doc_curex_custcommissions where bank_id = :1' using l_bankid;
  end erase_doc_curex_custcomm;
*/  
  procedure erase_doc_curex_custcomm
  is
  begin
    -- цикл на случай мульти-мфо
    for c in (select kf from v_kf)
    loop
      execute immediate 'delete from ibank.doc_curex_custcommissions where bank_id = :1' using c.kf;
    end loop;
  end erase_doc_curex_custcomm;

  ----
  -- fill_doc_curex_custcomm - выполняет вставку в удаленную таблицу
  --
  procedure fill_doc_curex_custcomm
  is
  begin
    execute immediate
   'insert
      into ibank.doc_curex_custcommissions(rnk, buy_commission, sell_commission, conv_commission, nls_pf, bank_id)
    select round(cc.rnk/100, 0), cc.buy_commission, cc.sell_commission, cc.conv_commission, cc.nls_pf, cc.bank_id
      from doc_curex_custcommissions cc';
  end fill_doc_curex_custcomm;


  ----
  -- sync_doc_curex_custcomm - синхронизирует BANK.doc_curex_custcommissions --> CORE.doc_curex_custcommissions
  --
  procedure sync_doc_curex_custcomm
  is
  begin
	execute immediate 'call ibank.sync.sync_doc_curex_custcommissions()';
  end sync_doc_curex_custcomm;

  ----
  -- erase_doc_curex_exclusive - выполняет очистку удаленной таблицы
  --
/*
  procedure erase_doc_curex_exclusive
  is
    l_bankid varchar2(6);
  begin
    select val into l_bankid from bars.params where par = 'GLB-MFO';
    execute immediate 'delete from ibank.doc_curex_exclusive where bank_id = :1' using l_bankid;
  end erase_doc_curex_exclusive;
*/
  procedure erase_doc_curex_exclusive
  is
  begin
    -- цикл на случай мульти-мфо
    for c in (select kf from v_kf)
    loop
      execute immediate 'delete from ibank.doc_curex_exclusive where bank_id = :1' using c.kf;
    end loop;
  end erase_doc_curex_exclusive;


  ----
  -- fill_doc_curex_exclusive - выполняет вставку в удаленную таблицу
  --
  procedure fill_doc_curex_exclusive
  is
  begin
    execute immediate
   'insert
      into ibank.doc_curex_exclusive(rate_id, rnk, buy_sell_flag, cur_group, cur_id, limit, commission_rate, commission_sum, date_on, date_off, bank_id)
    select ce.rate_id, round(ce.rnk/100, 0), ce.buy_sell_flag, ce.cur_group, ce.cur_id, ce.limit, ce.commission_rate, ce.commission_sum, ce.date_on, ce.date_off, ce.bank_id
      from doc_curex_exclusive ce';
  end fill_doc_curex_exclusive;


  ----
  -- sync_doc_curex_exclusive - синхронизирует BANK.doc_curex_exclusive --> CORE.doc_curex_exclusive
  --
  procedure sync_doc_curex_exclusive
  is
  begin
	execute immediate 'call ibank.sync.sync_doc_curex_exclusive()';
  end sync_doc_curex_exclusive;

  ----
  -- erase_cust_addresses - выполняет очистку удаленной таблицы
  --
/*
  procedure erase_cust_addresses is
    l_bankid varchar2(6);
  begin
    select val into l_bankid from bars.params where par = 'GLB-MFO';
    execute immediate 'delete from ibank.cust_addresses where bank_id = :1' using l_bankid;
  end erase_cust_addresses;
*/
  procedure erase_cust_addresses is
  begin
    -- цикл на случай мульти-мфо
    for c in (select kf from v_kf)
    loop
      execute immediate 'delete from ibank.cust_addresses where bank_id = :1' using c.kf;
    end loop;
  end erase_cust_addresses;

  ----
  -- fill_cust_addresses - выполняет вставку в удаленную таблицу
  --
  procedure fill_cust_addresses
  is
  begin
    execute immediate
   'insert
      into ibank.cust_addresses(rnk, type_id, country_id, zip, region, district, city, address, bank_id)
    select round(ca.rnk/100, 0), ca.type_id, ca.country_id, ca.zip, ca.region, ca.district, ca.city, ca.address, ca.bank_id
      from cust_addresses ca';
  end fill_cust_addresses;

  ----
  -- sync_cust_addresses - синхронизирует BANK.cust_addresses --> CORE.cust_addresses
  --
  procedure sync_cust_addresses
  is
  begin
    execute immediate 'call ibank.sync.sync_cust_addresses()';
  end sync_cust_addresses;

  ----
  -- trunc_tmp_table - выполняет операцию truncate над временной таблицей tmp_<p_table>
  --
  procedure trunc_tmp_table(p_table in varchar2)
  is
  begin
    execute immediate 'call ibank.sync.trunc_tmp_table(:p_table)'
      using p_table;
  end trunc_tmp_table;

  ----
  -- fill_tmp_acc_turnovers - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_turnovers(p_startdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer)
  is
  begin
    if p_bankid is null and p_accnum is null and p_curid is null
    then
        -- работаем по всем счетам по всем МФО
        execute immediate
       'insert
          into ibank.tmp_acc_turnovers (
                  bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                  balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
        select a.bank_id, a.acc_num, a.cur_id, a.turns_date, a.prev_turns_date,
               a.balance, a.debit_turns, a.credit_turns, a.balance_eq, a.debit_turns_eq, a.credit_turns_eq
          from acc_turnovers a
         where a.turns_date >= :p_startdate'
        using p_startdate;
    elsif p_bankid is not null and p_accnum is null and p_curid is null
    then
        -- работаем по всем счетам одного МФО
        execute immediate
       'insert
          into ibank.tmp_acc_turnovers (
                  bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                  balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
        select a.bank_id, a.acc_num, a.cur_id, a.turns_date, a.prev_turns_date,
               a.balance, a.debit_turns, a.credit_turns, a.balance_eq, a.debit_turns_eq, a.credit_turns_eq
          from acc_turnovers a
         where a.turns_date >= :p_startdate
           and a.bank_id = :p_bankid'
        using p_startdate, p_bankid;
    else
        -- работаем точечно по одному счету
        execute immediate
       'insert
          into ibank.tmp_acc_turnovers (
                  bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                  balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
        select a.bank_id, a.acc_num, a.cur_id, a.turns_date, a.prev_turns_date,
               a.balance, a.debit_turns, a.credit_turns, a.balance_eq, a.debit_turns_eq, a.credit_turns_eq
          from acc_turnovers a
         where a.bank_id = :p_bankid
           and a.acc_num = :p_accnum
           and a.cur_id  = :p_curid
           and a.turns_date >= :p_startdate'
        using p_bankid, p_accnum, p_curid, p_startdate;
    end if;
    --
  end fill_tmp_acc_turnovers;

  ----
  -- fill_tmp_acc_period_turnovers - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_pr_turnovers(p_startdate in date, p_finishdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer)
  is
  begin
    if p_bankid is null and p_accnum is null and p_curid is null
    then
        -- работаем по всем счетам по всем МФО
        execute immediate
       'insert
          into ibank.tmp_acc_turnovers (
                  bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                  balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
        select a.bank_id, a.acc_num, a.cur_id, a.turns_date, a.prev_turns_date,
               a.balance, a.debit_turns, a.credit_turns, a.balance_eq, a.debit_turns_eq, a.credit_turns_eq
          from acc_turnovers a
         where a.turns_date between :p_startdate and :p_finishdate'
        using p_startdate, p_finishdate;
    elsif p_bankid is not null and p_accnum is null and p_curid is null
    then
        -- работаем по всем счетам одного МФО
        execute immediate
       'insert
          into ibank.tmp_acc_turnovers (
                  bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                  balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
        select a.bank_id, a.acc_num, a.cur_id, a.turns_date, a.prev_turns_date,
               a.balance, a.debit_turns, a.credit_turns, a.balance_eq, a.debit_turns_eq, a.credit_turns_eq
          from acc_turnovers a
         where a.turns_date between :p_startdate and :p_finishdate
           and a.bank_id = :p_bankid'
        using p_startdate, p_finishdate, p_bankid;
    else
        -- работаем точечно по одному счету
        execute immediate
       'insert
          into ibank.tmp_acc_turnovers (
                  bank_id, acc_num, cur_id, turns_date, prev_turns_date,
                  balance, debit_turns, credit_turns, balance_eq, debit_turns_eq, credit_turns_eq)
        select a.bank_id, a.acc_num, a.cur_id, a.turns_date, a.prev_turns_date,
               a.balance, a.debit_turns, a.credit_turns, a.balance_eq, a.debit_turns_eq, a.credit_turns_eq
          from acc_turnovers a
         where a.bank_id = :p_bankid
           and a.acc_num = :p_accnum
           and a.cur_id  = :p_curid
           and a.turns_date between :p_startdate and :p_finishdate'
        using p_bankid, p_accnum, p_curid, p_startdate, p_finishdate;
    end if;
    --
  end fill_tmp_acc_pr_turnovers;

  ----
  -- fill_tmp_acc_transactions - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_transactions(p_startdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer)
  is
  begin
    if p_bankid is null and p_accnum is null and p_curid is null
    then
        -- работаем по всем счетам по всем МФО
        execute immediate
       'insert
          into ibank.tmp_acc_transactions (
               bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        select bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name
          from acc_transactions
         where trans_date >= :p_startdate'
        using p_startdate;
    elsif p_bankid is not null and p_accnum is null and p_curid is null
    then
        execute immediate
        'insert
          into ibank.tmp_acc_transactions (
               bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        select bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name
          from acc_transactions
         where trans_date >= :p_startdate
           and bank_id = :p_bankid'
        using p_startdate, p_bankid;
    else
        -- работаем точечно по одному счету
        execute immediate
       'insert
          into ibank.tmp_acc_transactions (
               bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        select bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name
          from acc_transactions
         where bank_id = :p_bankid
           and acc_num = :p_accnum
           and cur_id  = :p_curid
           and trans_date >= :p_startdate'
        using p_bankid, p_accnum, p_curid, p_startdate;
    end if;
  end fill_tmp_acc_transactions;

  ----
  -- fill_tmp_acc_period_transactions - выполняет вставку во временную удаленную таблицу
  --
  procedure fill_tmp_acc_pr_transactions(p_startdate in date, p_finishdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer)
  is
  begin
    if p_bankid is null and p_accnum is null and p_curid is null
    then
        -- работаем по всем счетам по всем МФО
        execute immediate
       'insert
          into ibank.tmp_acc_transactions (
               bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        select bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name
          from acc_transactions
         where trans_date between :p_startdate and :p_finishdate'
        using p_startdate, p_finishdate;
    elsif p_bankid is not null and p_accnum is null and p_curid is null
    then
        execute immediate
        'insert
          into ibank.tmp_acc_transactions (
               bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        select bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name
          from acc_transactions
         where trans_date between :p_startdate and :p_finishdate
           and bank_id = :p_bankid'
        using p_startdate, p_finishdate, p_bankid;
    else
        -- работаем точечно по одному счету
        execute immediate
       'insert
          into ibank.tmp_acc_transactions (
               bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name)
        select bank_id, acc_num, name, cur_id,trans_date, trans_id, doc_id,doc_number, doc_date, type_id,
               trans_sum, trans_sum_eq, corr_bank_id, corr_bank_name, corr_ident_code, corr_acc_num,
               corr_name, narrative, narrative_extra, ibank_docid, ref92_bank_id, ref92_cust_code, ref92_acc_num, ref92_acc_name, ref92_bank_name
          from acc_transactions
         where bank_id = :p_bankid
           and acc_num = :p_accnum
           and cur_id  = :p_curid
           and trans_date between :p_startdate and :p_finishdate'
        using p_bankid, p_accnum, p_curid, p_startdate, p_finishdate;
    end if;
  end fill_tmp_acc_pr_transactions;

  ----
  -- sync_stmt - вызывает удаленную процедуру синхронизации выписки(обороты+транзакции)
  --
  procedure sync_stmt(p_startdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer)
  is
  begin
    execute immediate 'call ibank.sync.sync_stmt(:p_startdate, :p_bankid, :p_accnum, :p_curid)'
      using p_startdate, p_bankid, p_accnum, p_curid;
  end sync_stmt;

  ----
  -- sync_period_stmt - вызывает удаленную процедуру синхронизации выписки(обороты+транзакции) за период
  --
  procedure sync_period_stmt(p_startdate in date, p_finishdate in date, p_bankid varchar2, p_accnum varchar2, p_curid integer)
  is
  begin
    execute immediate 'call ibank.sync.sync_period_stmt(:p_startdate, :p_finishdate, :p_bankid, :p_accnum, :p_curid)'
      using p_startdate, p_finishdate, p_bankid, p_accnum, p_curid;
  end sync_period_stmt;

  ----
  -- erase_streams_heartbeat - выполняет очистку удаленной таблицы
  --
  procedure erase_streams_heartbeat
  is
  begin
    execute immediate
   'delete
      from ibank.v_streams_heartbeat';
  end erase_streams_heartbeat;

  ----
  -- fill_streams_heartbeat - выполняет вставку в удаленную таблицу
  --
  procedure fill_streams_heartbeat
  is
  begin
    execute immediate
   'insert
      into ibank.v_streams_heartbeat(global_name, heartbeat_time)
    select global_name, heartbeat_time
      from streams_heartbeat';
  end fill_streams_heartbeat;


  ----
  -- sync_streams_heartbeat - синхронизирует BANK.streams_heartbeat --> CORE.streams_heartbeat
  --
  procedure sync_streams_heartbeat
  is
  begin
    execute immediate 'call ibank.sync.sync_streams_heartbeat()';
  end sync_streams_heartbeat;

  ----
  -- manual_global_instantiate_now - устанавливает точку синхронизации для указанной таблицы
  --                          на текущий момент в разрезе глобальных имен БД
  --
  procedure manual_global_instantiate_now(p_table in varchar2, p_globalname in varchar2)
  is
  begin
    execute immediate 'call ibank.sync.manual_global_instantiate_now(:p_table, :p_globalname)'
      using p_table, p_globalname;
  end manual_global_instantiate_now;

  ----
  -- user_global_instantiate_now - устанавливает точку синхронизации для указанной таблицы
  --                          на текущий момент в разрезе глобальных имен БД
  --                          по привязке global_name к user_name
  --
  procedure user_global_instantiate_now(p_table in varchar2)
  is
  begin
    execute immediate 'call ibank.sync.user_global_instantiate_now(:p_table)'
      using p_table;
  end user_global_instantiate_now;

  ----
  -- update_customer - модифицирует строку таблицы customers
  --
  procedure update_customer(p_row customers%rowtype)
  is
  begin
    execute immediate
           'update ibank.v_customers2
               set type_id = :p_type_id,
                   name = :p_name,
                   english_name = :p_english_name,
                   short_name = :p_short_name,
				   russian_name = :p_russian_name,
                   cust_code = :p_cust_code,
                   prt_id = :p_prt_id,
                   country_id = :p_country_id,
                   cov_id = :p_cov_id,
                   insider_id = :p_insider_id,
                   opened = :p_opened,
                   closed = :p_closed,
                   notes = :p_notes,
                   cust_limit = :p_cust_limit
             where rnk = :p_rnk
               and bank_id = :p_bank_id'
    using p_row.type_id,
          p_row.name,
          p_row.english_name,
          p_row.short_name,
		  p_row.russian_name,
          p_row.cust_code,
          p_row.prt_id,
          p_row.country_id,
          p_row.cov_id,
          p_row.insider_id,
          p_row.opened,
          p_row.closed,
          p_row.notes,
          p_row.cust_limit,
          p_row.rnk,
          p_row.bank_id;
  end update_customer;

  ----
  -- update_individual - модифицирует строку таблицы cust_individuals
  --
  procedure update_individual(p_row cust_individuals%rowtype)
  is
  begin
    execute immediate
           'update ibank.v_cust_individuals2
               set id_id = :p_id_id,
                   id_serial = :p_id_serial,
                   id_number = :p_id_number,
                   id_date = :p_id_date,
                   id_issuer = :p_id_issuer,
                   birthday = :p_birthday,
                   birthplace = :p_birthplace,
                   phone_home = :p_phone_home,
                   phone_work = :p_phone_work,
                   phone_mobile = :p_phone_mobile,
                   email = :p_email,
                   id_date_valid = :id_date_valid
             where rnk = :p_rnk
               and bank_id = :p_bank_id'
    using  p_row.id_id,
           p_row.id_serial,
           p_row.id_number,
           p_row.id_date,
           p_row.id_issuer,
           p_row.birthday,
           p_row.birthplace,
           p_row.phone_home,
           p_row.phone_work,
           p_row.phone_mobile,
           p_row.email,
           p_row.id_date_valid,
           p_row.rnk,
           p_row.bank_id;
  end update_individual;

  ----
  -- update_company - модифицирует строку таблицы cust_companies
  --
  procedure update_company(p_row cust_companies%rowtype)
  is
  begin
    execute immediate
   'update ibank.v_cust_companies2
       set article_name = :p_article_name,
           head_name = :p_head_name,
           head_phone = :p_head_phone,
           accountant_name = :p_accountant_name,
           accountant_phone = :p_accountant_phone,
           fax = :p_fax,
           email = :p_email
     where rnk = :p_rnk
       and bank_id = :p_bank_id'
    using  p_row.article_name,
           p_row.head_name,
           p_row.head_phone,
           p_row.accountant_name,
           p_row.accountant_phone,
           p_row.fax,
           p_row.email,
           p_row.rnk,
           p_row.bank_id;
  end update_company;

  ----
  -- sync_customers - Синхронизация клиентов между схемами BANK -> CORE
  --
  procedure sync_customers (p_bankid varchar2)
  is
  begin
    execute immediate 'call ibank.sync.sync_customers(:p_bankid)' using p_bankid;
  end sync_customers;

  ----
  -- update_acctariffs - Обновление тарифов в схеме BANK
  --
  procedure update_acctariffs (p_bankid varchar2)
  is
  begin
	execute immediate 'delete from ibank.v_ACCOUNT_TARIFF where bank_id = :p_bank_id' using p_bankid;

	execute immediate 'insert into ibank.v_ACCOUNT_TARIFF select * from account_tariff where bank_id = :p_bank_id' using p_bankid;
  end update_acctariffs;
  ----
  -- sync_acctariffs - Синхронизация тарифов между схемами BANK -> CORE
  --
  procedure sync_acctariffs (p_bankid varchar2)
  is
  begin
    execute immediate 'call ibank.sync.sync_acctariffs(:p_bankid)' using p_bankid;
  end sync_acctariffs;


end rpc_sync;
/
 show err;
 
PROMPT *** Create  grants  RPC_SYNC ***
grant EXECUTE                                                                on RPC_SYNC        to BARS with grant option;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/rpc_sync.sql =========*** End *** 
 PROMPT ===================================================================================== 
 