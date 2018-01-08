
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mgr_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MGR_UTL is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 19.10.2011
  -- Purpose    : Вспомагательные функции для миграции

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 2.1.7 16/06/2017';

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;


    ------------------------------------------------------------------
    -- PRINTF()
    --
    --     Процедура форматирования строки сообщения. Если в строку
    --     включены описания, то производится подстановка переданных
    --     аргументов в строку сообщения
    --
    --
    function printf(
        p_message  in varchar2,
        p_args     in logger.args     ) return varchar2;


  ----
    --   Запись трассировочного сообщения в протокол
    --
    --
     procedure trace(
         p_msg  in  varchar2,
         p_arg1 in  varchar2  default null,
         p_arg2 in  varchar2  default null,
         p_arg3 in  varchar2  default null,
         p_arg4 in  varchar2  default null,
         p_arg5 in  varchar2  default null,
         p_arg6 in  varchar2  default null,
         p_arg7 in  varchar2  default null,
         p_arg8 in  varchar2  default null,
         p_arg9 in  varchar2  default null );

  ----
  -- get_errmsg - возвращает полный стек ошибки
  --
  function get_errmsg return varchar2;

  ----
  -- get_glb_mfo - возвращает МФО головного банка
  --
  function get_glb_mfo return varchar2;

  ----
  -- get_ru - возвращает текущее значение RU
  --
  function get_ru return varchar2;

  ----
  -- get_kf - возвращает текущее значение KF
  --
  function get_kf return varchar2;

  ----
  -- set_kf - устанаmgr_utl.get_ru()вливает значение KF
  --
  procedure set_kf(p_kf varchar2);

  ----
  -- reset_kf - очищает значение KF
  --
  procedure reset_kf;

  function get_schema return varchar2;

  function get_dblink return varchar2;

  ----
  -- set_dblink - устанавливает значение SCHEMA, DBLINK
  --
  procedure set_dblink(p_schema varchar2,  p_dblink varchar2);
  ----
  -- clean_error - очищает переменную ошибки
  --
  procedure clean_error;

  ----
  -- get_schema_kf - возвращает имя схемы KF<______>
  --
  function get_schema_kf return varchar2;

  ----
  -- pkf - дополняет имя объекта префиксом KF<______>
  --
  function pkf(p_object varchar2, p_schema varchar2 default null,  p_dblink varchar2 default null) return varchar2;

  ----
  -- save_error - сохраняет последнюю ошибку в переменную пакета
  --
  procedure save_error;

  ----
  -- get_error - возвращает значение переменной с текстом последней ошибки
  --
  function get_error return varchar2;

  ----
  -- raise_error - выбрасывает ошибку, если переменная непустая
  --
  procedure raise_error;

  ----
  -- disable_all_policies - отключает все политики
  --
  procedure disable_all_policies;

  ----
  -- enable_all_policies - включает все политики
  --
  procedure enable_all_policies;

  ----
  -- check_policies - проверка: политики должны быть выключены
  --
  procedure check_policies;

  ----
  -- check_event - проверка событий (migration, ...)
  --
  procedure check_event;

  ----
  -- check_context - проверка контекста
  --
  procedure check_context;

  ----
  -- check_foreign_keys - проверяет все ли внешние ключи отключены
  --
  procedure check_foreign_keys;

  /*
  ----
  -- disable_foreign_keys - выключает внешние ключи
  --
  procedure disable_foreign_keys;

  ----
  -- enable_foreign_keys - включает внешние ключи
  --
  procedure enable_foreign_keys;
  */

  ----
  -- disable_foreign_keys - выключает внешние ключи, ссылающиеся на таблицу p_table
  --                        или все, если p_table is null
  procedure disable_foreign_keys(p_table in varchar2 default null);

  ----
  -- enable_foreign_keys - включает внешние ключи, ссылающиеся на таблицу p_table (enable novalidate)
  --                       или все, если p_table is null
  procedure enable_foreign_keys(p_table in varchar2 default null);

  ----
  -- validate_foreign_keys - валидирует внешние ключи, ссылающиеся на таблицу p_table
  --                         или все, если p_table is null
  procedure validate_foreign_keys(p_table in varchar2 default null);

  ----
  -- get_free_userid - возвращает свободный минимальный id пользователя
  --
  function get_free_userid
  return integer;

  ----
  -- get_free_username - возвращает свободное имя пользователя
  --
  function get_free_username(p_username in varchar2)
  return varchar2;

  ----
  -- get_free_rnk - возвращает свободный минимальный rnk
  --
  function get_free_rnk
  return integer;

  ----
  -- get_free_acc - возвращает свободный минимальный acc
  --
  function get_free_acc
  return integer;

  ----
  -- get_free_accs - возвращает массив свободных acc для указанного кол-ва счетов
  --
  procedure get_free_accs(p_acc_cnt in number, p_accs in out nocopy dbms_sql.number_table);

  ----
  -- reset_sequence - сбрасывает значение последовательности
  --
  procedure reset_sequence (seq_name in varchar2, startvalue in number);

  ----
  -- disable_table_triggers - выключает все триггера на таблице p_table
  --                          за исключением неотключаемых триггеров по списку p_exclude
  --
  procedure disable_table_triggers(p_table in varchar2, p_exclude in varchar2 default null);

  ----
  -- enable_table_triggers - включает все отключенные триггера на таблице p_table
  --
  procedure enable_table_triggers(p_table in varchar2);

  ----
  -- before_clean - выполняет предварительные действия со списком таблиц перед их очисткой
  --                отключает внешние ключи, триггера
  procedure before_clean(p_tables in varchar2);

  ----
  -- before_fill - выполняет предварительные действия со списком таблиц перед их наполнением
  --                отключает внешние ключи, триггера
  procedure before_fill(p_tables in varchar2);

  ----
  -- finalize - выполняет финальные действия со списком таблиц после их очистки или наполнения
  --   включает внешние ключи, триггера
  --   список таблиц задается в before_clean(p_tables) или before_fill(p_tables)
  --   и хранится в глобальной переменной
  --   процедура сама разбирается после чего выполнять финализацию: после очистки или после наполнения
  --
  procedure finalize;

  ----
  -- int_clean_table - очистка произвольной таблицы
  --
  procedure int_clean_table(p_table varchar2, p_table_type varchar2);

  ----
  -- clean - очистка произвольной таблицы
  --
  procedure clean(p_table varchar2);

  ----
  -- clean_local_table - очищает локальную таблицу по указанному KF
  --
  procedure clean_local_table(p_table varchar2, p_kf varchar2);

  ----
  -- fill_local_table - наполняет локальную таблицу по указанному SQL-выражению
  --
  procedure fill_local_table(p_table varchar2, p_kf varchar2, p_stmt varchar2);

  ----
  -- sync_global_table - синхронизирует глобальную(без KF) таблицу по указанному SQL-выражению
  --
  procedure sync_global_table(p_table varchar2, p_stmt varchar2);

  ----
  -- sync_table - синхронизирует таблицу с данными по указанному SQL-выражению
  --
  procedure sync_table(p_table varchar2, p_stmt varchar2, p_delete boolean default false);

  ----
  -- sync_table_auto - синхронизирует таблицу с данными
  --
  procedure sync_table_auto(
    p_table varchar2,
    p_delete boolean default false,
    p_column_replace varchar2 default null
  );

  ----
  -- tabsync - вызов sync_table_auto(p_table, true)
  --
  procedure tabsync(p_table varchar2);

  ----
  -- gather_index_stats
  --
  procedure gather_index_stats
    (ownname varchar2, indname varchar2, partname varchar2 default null,
     estimate_percent number default dbms_stats.DEFAULT_ESTIMATE_PERCENT,
     stattab varchar2 default null, statid varchar2 default null,
     statown varchar2 default null,
     degree number default dbms_stats.to_degree_type(dbms_stats.get_param('DEGREE')),
     granularity varchar2 default dbms_stats.DEFAULT_GRANULARITY,
     no_invalidate boolean default
       dbms_stats.to_no_invalidate_type(dbms_stats.get_param('NO_INVALIDATE')),
     stattype varchar2 default 'DATA',
     force boolean default FALSE);

  ----
  -- gather_table_stats
  --
  procedure gather_table_stats
    (ownname varchar2, tabname varchar2, partname varchar2 default null,
     estimate_percent number default dbms_stats.DEFAULT_ESTIMATE_PERCENT,
     block_sample boolean default FALSE,
     method_opt varchar2 default dbms_stats.DEFAULT_METHOD_OPT,
     degree number default dbms_stats.to_degree_type(dbms_stats.get_param('DEGREE')),
     granularity varchar2 default  dbms_stats.DEFAULT_GRANULARITY,
     cascade boolean default dbms_stats.DEFAULT_CASCADE,
     stattab varchar2 default null, statid varchar2 default null,
     statown varchar2 default null,
     no_invalidate boolean default
       dbms_stats.to_no_invalidate_type(dbms_stats.get_param('NO_INVALIDATE')),
     stattype varchar2 default 'DATA',
     force boolean default FALSE,
     -- the context is intended for internal use only.
     context dbms_stats.CContext default null);

  ----
  -- get_rowcount - возвращает кол-во строк в таблице p_table
  --
  function get_rowcount(p_table in varchar2)
  return number deterministic;

  ----
  -- get_errinfo - возвращает описание типовых ошибок в таблице err$_*
  --
  function get_errinfo(p_errtable in varchar2)
  return varchar2;

  ----
  -- mantain_error_table - создает/очищает таблицу ошибок err$_<p_table>
  --
  procedure mantain_error_table(p_table in varchar2);

  ----
  -- make_key - порождает новый ключ со старого путем добавления кода RU в хвост
  --
  function make_key(p_key number, p_kf varchar2) return number;

  ----
  -- make_key - порождает новый ключ со старого путем добавления кода RU в хвост
  --
  function make_key(p_key varchar2, p_kf varchar2) return varchar2;

  ----
  -- rukey - возвращает новый ключ <p_key>||g_ru
  --
  function rukey(p_key varchar2)
  return varchar2;

  ----
  -- ruuser - возвращает новый ключ по пользователям с учетом исключений
  --
  function ruuser(p_user varchar2)
  return varchar2;

  ----
  -- tabdiff - создает протокол расхождения таблиц
  --
  procedure tabdiff(
    p_table_a varchar2,
    p_table_b varchar2,
    p_key_1   varchar2,
    p_key_2   varchar2 default null,
    p_key_3   varchar2 default null,
    p_col_1   varchar2,
    p_col_2   varchar2 default null,
    p_col_3   varchar2 default null,
    p_col_4   varchar2 default null,
    p_col_5   varchar2 default null,
    p_col_6   varchar2 default null,
    p_col_7   varchar2 default null,
    p_col_8   varchar2 default null,
    p_col_9   varchar2 default null,
    p_col_10  varchar2 default null,
    p_col_11  varchar2 default null,
    p_col_12  varchar2 default null,
    p_col_13  varchar2 default null,
    p_col_14  varchar2 default null,
    p_col_15  varchar2 default null,
    p_col_16  varchar2 default null,
    p_col_17  varchar2 default null,
    p_col_18  varchar2 default null,
    p_col_19  varchar2 default null,
    p_col_20  varchar2 default null,
    p_col_21  varchar2 default null,
    p_col_22  varchar2 default null,
    p_col_23  varchar2 default null,
    p_col_24  varchar2 default null,
    p_col_25  varchar2 default null,
    p_col_26  varchar2 default null,
    p_col_27  varchar2 default null,
    p_col_28  varchar2 default null,
    p_col_29  varchar2 default null,
    p_col_30  varchar2 default null,
    p_col_31  varchar2 default null,
    p_col_32  varchar2 default null,
    p_col_33  varchar2 default null,
    p_col_34  varchar2 default null,
    p_col_35  varchar2 default null,
    p_col_36  varchar2 default null,
    p_col_37  varchar2 default null,
    p_col_38  varchar2 default null,
    p_col_39  varchar2 default null,
    p_col_clob_1 varchar2  default null,
    p_col_clob_2 varchar2  default null,
    p_col_clob_3 varchar2  default null
  );

    ----
    -- validate_cons_in_parallel - валидирует
    --
    procedure validate_cons_in_parallel(
        p_proc_name     varchar2,
        p_proc_params   varchar2 default null);


    ----
    -- noop - No Operation
    --
    procedure noop(p_num number);

    ----
    -- validate_constraint - валидирует ограничение целостности
    --
    procedure validate_constraint(p_num integer);
    
  ----------------------------------add 25.04.2016 serhii.bovkush----------------------------------------------
    procedure execute_immediate(ip_sql in varchar2);

    -- drop all partitions range excluding P_FIRST (partition with min high value)
    procedure p_table_partitions_range_drop(ip_table_name in varchar2);

    procedure p_table_truncate(stable in varchar2);

    -- nflag_smart: 0 - raise exception if table does not exist, 1 -will not raise exception if table does not exist
    procedure p_table_drop(nflag_smart in number,stable in varchar2);

    procedure p_object_save(stable in varchar2, sobject_name in varchar2, sobject_type in varchar2, csql_text in clob);
    
    -- stop all jobs that were enabled and run them after the migration process
    procedure p_stop_scheduler_job;
    procedure p_stop_dbms_job;
    procedure p_stop_job;
    procedure p_run_scheduler_job;
    procedure p_run_dbms_job;
    procedure p_run_job;
    --                                TRIGGERS
    --------------------------------------------------------------------------------
    procedure p_triggers_disable      (stable in varchar2);
    procedure p_trigger_disable       (ip_trigger in varchar2);
    procedure p_trigger_enable        (ip_trigger in varchar2);
    procedure p_triggers_enable       (stable in varchar2);
    procedure p_triggers_save         (stable in varchar2);
    procedure p_triggers_restore      (stable in varchar2);
    function f_trigger_get_metadata   (strigger in varchar2) return clob;

    --                               INDEXES
    --------------------------------------------------------------------------------
    procedure p_indexes_nonuq_drop (stable in varchar2);
    procedure p_indexes_save       (stable in varchar2);
    procedure p_indexes_drop       (stable in varchar2);
    procedure p_indexes_restore    (stable in varchar2);

    --                                CONSTRAINT
    ----------------------------------------------------------------------------------
    procedure p_constraints_disable            (stable in varchar2);
    procedure p_constraints_enable             (stable in varchar2);
    procedure p_constraints_en_novalid         (stable in varchar2);
    procedure p_constraints_validate           (stable in varchar2);
    procedure p_constraints_drop               (ip_table in varchar2);
    procedure p_constraints_fk_disable         (stable in varchar2);
    procedure p_constraints_fk_enable          (stable in varchar2);
    procedure p_constraints_fk_en_novalid      (stable in varchar2);
    procedure p_constraints_fk_validate        (stable in varchar2);
    procedure p_constraints_pk_enable          (stable in varchar2);
    procedure p_constraints_pk_en_novalid      (stable in varchar2);
    procedure p_constraints_pk_uk_validate     (stable in varchar2);
    procedure p_constraints_chk_disable        (stable in varchar2);
    procedure p_constraints_chk_enable         (stable in varchar2);
    procedure p_constraints_chk_en_novalid     (stable in varchar2);
    procedure p_constraints_chk_validate       (stable in varchar2);
    procedure p_ref_constraints_disable        (stable in varchar2);
    procedure p_ref_constraints_enable         (stable in varchar2);
    procedure p_ref_constraints_en_novalid     (stable in varchar2);
    procedure p_ref_constraints_validate       (stable in varchar2,  stable_exclude1 in varchar2 default 'AAA' ,  stable_exclude2 in varchar2 default 'AAA' );
    procedure p_ref_constraints_save           (stable in varchar2);
    procedure p_ref_constraints_drop           (stable in varchar2);
    procedure p_ref_constraints_restore        (stable in varchar2);
    procedure p_constraints_copy               (ip_from_table in varchar2, ip_to_table in varchar2);
    procedure p_constraints_save               (stable in varchar2);
    procedure p_constraints_restore            (stable in varchar2);
    procedure p_constraints_pk_save            (stable in varchar2);
    procedure p_constraints_pk_restore         (stable in varchar2);
        
    --                                TABLE
    ----------------------------------------------------------------------------------
                
    procedure p_table_save                     (stable in varchar2);
    procedure p_tbl_col_com_save               (stable in varchar2);
    procedure p_table_exists                   (ip_table in varchar2);
    procedure p_table_exists_kf                (ip_table in varchar2, ip_owner in varchar2, ip_ack out number);
    procedure p_table_column_exists            (ip_table in varchar2, ip_column in varchar2);
    procedure p_table_column_exists_kf         (ip_table in varchar2, ip_column in varchar2, ip_owner in varchar2);
    -- set degree for table and all tables indices
    procedure p_indexes_set_degree             (ip_table_name in varchar2, ip_degree in number);

    -- set degree for table
    procedure p_table_set_degree               	(ip_table_name in varchar2, ip_degree in number);

    -- set degree for index
    procedure p_index_set_degree                (ip_index_name in varchar2, ip_degree in number);

    procedure p_partition_truncate              (ip_table_name in varchar2, ip_partition_name in varchar2);

    procedure p_drop_table                      (ip_table_name in varchar2);

    procedure p_ep_sql_table
    (
     ip_table_from in varchar2,
     ip_table_to   in varchar2,
     op_sql        out clob
    );
              
   procedure p_ep_table_create
   (
    ip_table_from      in varchar,
    ip_partition_from  in varchar2,
    ip_table_to        in varchar2
   );

   procedure p_ep_exchange_partition
   (
    ip_table      in varchar2,
    ip_partition  in varchar2,
    ip_with_table in varchar2
   );
   /*
   example script for exchange partition

   begin
   mgr_utl.p_ep_table_create('OPER','OPER_Y2014_Q1', 'T$_OPER');

   insert data some data into T$_OPER

   mgr_utl.p_ep_exchange_partition('OPER','OPER_Y2014_Q1', 'T$_OPER');
   end;

   */
   procedure p_err$_column_find
   (
    ip_err$_table in varchar2,
    ip_err$_rowid in rowid,
    ip_table      in varchar2
   );

  -- Сolumn type or size mismatch in EXCHANGE SUBPARTITION
  ERR_COLUMN_MISMATCH     exception;
  PRAGMA EXCEPTION_INIT( ERR_COLUMN_MISMATCH, -14278 );
  
  -- Index mismatch for tables in EXCHANGE SUBPARTITION
  ERR_INDEX_MISMATCH      exception;
  PRAGMA EXCEPTION_INIT( ERR_COLUMN_MISMATCH, -14279 );

  --
  -- EXCHANGE PARTITION BY NAME
  --
  procedure EXCHANGE_PARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_partition_nm      in     all_tab_subpartitions.partition_name%type
  );
  
  --
  -- EXCHANGE PARTITION BY CONDITION FOR
  --
  PROCEDURE EXCHANGE_PARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  );
  
  --
  -- EXCHANGE SUBPARTITION BY NAME
  --
  PROCEDURE EXCHANGE_SUBPARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_subpartition_nm   in     all_tab_subpartitions.subpartition_name%type
  );
  
  --
  -- EXCHANGE SUBPARTITION BY CONDITION FOR
  --
  PROCEDURE EXCHANGE_SUBPARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  );

  --
  -- p_migration_jobs
  --
  procedure p_migration_jobs(  p_row_from number
                             , p_row_to number
                             , p_sleep number default 0.1
                             , p_sleep_after boolean default true
                             , p_streems_count number default 24
                             /*, p_schema varchar2 default null
                             , p_dblink varchar2 default null*/);
  
  procedure merge_table_auto(
                          p_table varchar2,
                          p_matched boolean default true,
                          p_not_matched boolean default true,
                          p_column_match varchar2 default null,    
                          p_column_replace varchar2 default null
                        ); 
-------------------------------------------------end add-----------------------------------------------------

end mgr_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.MGR_UTL is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 19.10.2011
  -- Purpose    : Вспомагательные функции для миграции


  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 2.1.7 16/06/2017';

  G_PKG constant varchar2(30) := 'mgr_utl';

  -- операция очистки таблиц
  C_OPERATION_CLEAN constant integer := 0;

  -- операция наполнения таблиц
  C_OPERATION_FILL  constant integer := 1;

  C_CTX_NAME    constant varchar2(30) := 'MGR_UTL';
  C_KF          constant varchar2(30) := 'KF';

  C_TAB_LOCAL_RFC      constant varchar2(30) := 'LOCAL_RFC';
  C_TAB_LOCAL_KF       constant varchar2(30) := 'LOCAL_KF';      -- локальная с полем kf
  C_TAB_LOCAL_BRANCH   constant varchar2(30) := 'LOCAL_BRANCH';  -- локальная с полем branch
  C_TAB_GLOBAL         constant varchar2(30) := 'GLOBAL';
  C_TAB_MIXED          constant varchar2(30) := 'MIXED';

  -- global variables
  g_error_msg       varchar2(4000);
  --
  g_tables          varchar2(4000);
  --
  g_operation       integer;

  -- текущее значение KF (МФО)
  g_kf  varchar2(6);

  -- текущее значение SCHEMA
  g_schema  varchar2(30);

  -- текущее значение DBLINK
  g_dblink  varchar2(30);

  -- текущее значение RU
  g_ru  varchar2(2);

  -- мфо головного банка
  g_glb_mfo varchar2(6);

  -- параметр MGR_STAT = Y/N флаг сбора статистики после импорта каждой таблицы
  g_mgr_stat varchar2(1);

  type t_kf2ru_map is table of varchar2(2) index by varchar2(6);

  g_kf2ru_map   t_kf2ru_map;

  g_kf2ru_map_init   boolean;

  ref_part_restriction exception;
  pragma exception_init(ref_part_restriction, -14650);

    c_enter   constant varchar2(2) := chr(13)||chr(10);
  -- exception
  insert_null_into_notnull exception;
  pragma exception_init(insert_null_into_notnull, -1400);


  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header mgr_utl '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body mgr_utl '||G_BODY_VERSION;
  end body_version;

  ----
  -- get_errmsg - возвращает полный стек ошибки
  --
  function get_errmsg return varchar2
  is
  begin
    return dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace();
  end get_errmsg;

  ----
  -- load_mgr_stat - загружает значение параметра MGR_STAT
  --
  procedure load_mgr_stat
  is
  begin
    select val
      into g_mgr_stat
      from params$global
     where par='MGR_STAT';
  exception
    when no_data_found then
        g_mgr_stat := 'N';
  end load_mgr_stat;

  ----
  -- get_mgr_stat - возвращает значение параметра MGR_STAT
  --
  function get_mgr_stat return varchar2
  is
  begin
    if g_mgr_stat is null
    then
        load_mgr_stat();
    end if;
    return g_mgr_stat;
  end get_mgr_stat;

  ----
  -- clean_error - очищает переменную ошибки
  --
  procedure clean_error
  is
  begin
    --
    logger.trace('clean_error()');
    --
    g_error_msg := null;
    --
  end clean_error;

  ----
  -- save_error - сохраняет последнюю ошибку в переменную пакета
  --
  procedure save_error
  is
  begin
    --
    logger.trace('save_error()');
    --
    g_error_msg := substr(get_errmsg(),1,4000);
    --
    if g_error_msg=chr(10)
    then
        g_error_msg := null;
    else
        logger.error(g_error_msg);
    end if;
    --
  end save_error;

  ----
  -- get_error - возвращает значение переменной с текстом последней ошибки
  --
  function get_error return varchar2
  is
  begin
    --
    return g_error_msg;
    --
  end get_error;

  ----
  -- raise_error - выбрасывает ошибку, если переменная непустая
  --
  procedure raise_error
  is
  begin
    --
    logger.trace('raise_error()');
    --
    if g_error_msg is not null
    then
        raise_application_error(-20000, g_error_msg);
    end if;
    --
  end raise_error;

  ----
  -- get_glb_mfo - возвращает МФО головного банка
  --
  function get_glb_mfo return varchar2
  is
  begin
    if g_glb_mfo is null
    then
        select val
          into g_glb_mfo
          from params$global
         where par='GLB-MFO';
    end if;
    trace('get_glb_mfo()=>''%s''', nvl(g_glb_mfo, 'null'));
    return g_glb_mfo;
  end get_glb_mfo;

  ----
  -- get_ru - возвращает текущее значение RU
  --
  function get_ru return varchar2
  is
  begin
    if g_ru is null
    then
        select ru
          into g_ru
          from kf_ru
         where kf = mgr_utl.get_kf();
    end if;
    --trace('get_ru()=>''%s''', nvl(g_ru, 'null'));
    return g_ru;
  end get_ru;

  ----
  -- get_kf - возвращает текущее значение KF
  --
  function get_kf return varchar2
  is
  begin
    if g_kf is null
    then
        g_kf := sys_context('mgr_utl', 'kf');
    end if;
    --
    --trace('get_kf()=>''%s''', nvl(g_kf, 'null'));
    --
    if g_kf is null
    then
        raise_application_error(-20000, 'Код филиала(МФО) не задан. Выполните SQL> exec ikf(''<KF>'');');
    end if;
    --
    return g_kf;
    --
  end get_kf;

  ----
  -- set_kf - устанавливает значение KF
  --
  procedure set_kf(p_kf varchar2)
  is
    l_ru varchar2(2);
  begin
    -- сбрасываем состояние пакетов
    sys.dbms_session.reset_package();
    --
    sys.dbms_session.set_context(C_CTX_NAME, C_KF, p_kf);
    g_kf := p_kf;
    --
    l_ru := get_ru();
    --
  end set_kf;

  ----
  -- reset_kf - очищает значение KF
  --
  procedure reset_kf
  is
  begin
    sys.dbms_session.clear_context(C_CTX_NAME, C_KF);
    g_kf := null;
  end reset_kf;

  ----
  -- get_schema_kf - возвращает имя схемы KF<______>
  --
  function get_schema_kf return varchar2
  is
  begin
    --
    return 'KF'||get_kf();
    --
  end get_schema_kf;

-------------------------------------------------
  function get_schema return varchar2
  is
  begin
    return g_schema;
  end get_schema;

  function get_dblink return varchar2
  is
  begin
    return g_dblink;
  end get_dblink;

  ----
  -- set_dblink - устанавливает значение SCHEMA, DBLINK
  --
  procedure set_dblink(p_schema varchar2,  p_dblink varchar2)
  is
  begin
    -- сбрасываем состояние пакетов
    --sys.dbms_session.reset_package();
    --
    g_schema := p_schema;
    g_dblink := p_dblink;
  end set_dblink;
  ----
  -- pkf - дополняет имя объекта префиксом KF<______>
  --
  function pkf(p_object varchar2, p_schema varchar2 default null,  p_dblink varchar2 default null) return varchar2
  is
-----
----- Закомментировано до лучших времен
----- Для получения возможности миграции данных с помощью DBlink
----- Раскомментировать
----- 

    l_schema      VARCHAR2(30) := p_schema; 
    l_dblink      VARCHAR2(30) := p_dblink; 
    l_stmt        VARCHAR2(255) := 'begin bars_login.login_user'||rtrim(concat('@', ltrim(p_dblink, '@')), '@')||'(sys_guid,1,null,null); end;';
    l_stmt_g      VARCHAR2(255) := 'begin bars_login.login_user'||rtrim(concat('@', ltrim(g_dblink, '@')), '@')||'(sys_guid,1,null,null); end;';
    i             NUMBER;
    
    cursor c_cur is  
                     SELECT M.TABLE_NAME
                       FROM BARS.MGR_TBL_QUEUE M
                      --WHERE M.MIGR_NSUP_COL_TYPE = '1';
                      WHERE 1 = 0;
    c_lob         BOOLEAN:= false;
    type t_cur is table of BARS.MGR_TBL_QUEUE.TABLE_NAME%type index by pls_integer;
    l_cur t_cur;
  begin
    open c_cur;
    i := 0;
    loop
      fetch c_cur into l_cur(i);
      exit when c_cur%notfound/* or c_lob = true*/;
      if upper(p_object) = l_cur(i) then c_lob := true; end if;
      i := i + 1;
    end loop;
    
    if (p_schema is null and p_dblink is null) 
        then if (g_schema is null or g_dblink is null or c_lob = true)
             then return get_schema_kf()||'.'||p_object;
        else begin
                  begin 
                        execute immediate l_stmt_g;
                        exception when others then null;
                  end;
                  return ltrim(concat(rtrim(g_schema, '.'), '.'), '.')||p_object||rtrim(concat('@', ltrim(g_dblink, '@')), '@');    
                end;
        end if; 
    elsif (p_schema is not null and p_dblink is not null)
        then begin
          execute immediate l_stmt;
          return ltrim(concat(rtrim(p_schema, '.'), '.'), '.')||p_object||rtrim(concat('@', ltrim(p_dblink, '@')), '@');    
        end;
    elsif (p_schema is not null or p_dblink is not null)
        then begin
          execute immediate l_stmt;
          return concat(l_schema, '.')||p_object||l_dblink;    
        end;
    end if;   
-----
----- Закомментировано до лучших времен
----- Для получения возможности миграции данных с помощью DBlink
----- Раскомментировать
----- 
  
  --begin
          --return get_schema_kf()||'.'||p_object;    
  end pkf;

   ------------------------------------------------------------------
   -- PRINTF()
   --
   --     Процедура форматирования строки сообщения. Если в строку
   --     включены описания, то производится подстановка переданных
   --     аргументов в строку сообщения
   --
   --
    function printf(
        p_message  in varchar2,
        p_args     in logger.args     ) return varchar2
    is

    l_src     varchar2(4000);
    l_message varchar2(4000);
    l_argc    number;                      -- количество элементов массива
    l_argn    number           default 1;  -- текущий элемент массива
    l_pos     number           default 0;

    begin

        if (instr(p_message, '%') = 0 and instr(p_message, '\') = 0 )
        then
           return p_message;
        end if;

        --
        -- Получаем кол-во аргументов и строку для разбора
        --
        l_argc := p_args.count;
        l_src  := p_message;

        --
        -- Ищем и образатываем указатели на подстановку аргументов
        --

        loop

            --
            -- получаем первую позицию символа %s
            --
            l_pos := instr(l_src, '%s');

            --
            -- Выходим, если символа нет (0, null) или уже
            -- подставили все возможные аргументы
            --
            exit when (l_pos = 0 or l_pos is null or l_argn > l_argc);

            --
            -- Переносим часть до указателя и текущий аргумент
            -- в выходное сообщение
            --
            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || p_args(l_argn), 1, 4000);
            l_src     := substr(l_src, l_pos+2);
            l_argn    := l_argn + 1;

        end loop;

        -- Переносим полученный текст сообщения в исходное
        -- и начинаем поиск символов перевода строки
        --
        l_src     := substr(l_message || l_src, 1, 4000);
        l_message := null;

        --
        -- Ищем и обрабатываем указатели перевода строки
        --

        loop
            --
            -- получаем первую позицию символов \n
            --
            l_pos := instr(l_src, '\n');

            --
            -- Выходим, если символов нет (0, null)
            --
            exit when (l_pos = 0 or l_pos is null);

            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || chr(10), 1, 4000);
            l_src := substr(l_src, l_pos+2);

        end loop;

        --
        -- Переносим оставшийся кусок исходного сообщения
        --
        l_message := substr(l_message || l_src, 1, 4000);

        return l_message;

    end printf;


    ----
    --   Запись трассировочного сообщения в протокол
    --
    --
     procedure trace(
         p_msg  in  varchar2,
         p_arg1 in  varchar2  default null,
         p_arg2 in  varchar2  default null,
         p_arg3 in  varchar2  default null,
         p_arg4 in  varchar2  default null,
         p_arg5 in  varchar2  default null,
         p_arg6 in  varchar2  default null,
         p_arg7 in  varchar2  default null,
         p_arg8 in  varchar2  default null,
         p_arg9 in  varchar2  default null )
     is

     l_recid   number(38);
     l_msg     sec_audit.rec_message%type;
     l_object  varchar2(100);

     begin
          logger.trace(p_msg, p_arg1, p_arg2, p_arg3, p_arg4, p_arg5, p_arg6, p_arg7, p_arg8, p_arg9);

          -- обрабатываем параметры
          l_msg := printf(p_msg,logger.args(substr(p_arg1, 1, 2000),
                                     substr(p_arg2, 1, 2000),
                                     substr(p_arg3, 1, 2000),
                                     substr(p_arg4, 1, 2000),
                                     substr(p_arg5, 1, 2000),
                                     substr(p_arg6, 1, 2000),
                                     substr(p_arg7, 1, 2000),
                                     substr(p_arg8, 1, 2000),
                                     substr(p_arg9, 1, 2000) ));

          dbms_application_info.set_client_info(l_msg);

     end trace;

  ----
  -- disable_all_policies - отключает все политики
  --
  procedure disable_all_policies
  is
  begin
    bpa.disable_all_policies;
  end disable_all_policies;

  ----
  -- enable_all_policies - включает все политики
  --
  procedure enable_all_policies
  is
  begin
    bpa.enable_all_policies;
  end enable_all_policies;

  ----
  -- check_policies - проверка: политики должны быть выключены
  --
  procedure check_policies
  is
    l_cnt   integer;
  begin
    select count(*)
      into l_cnt
      from user_policies
     where enable='YES';
    if l_cnt>0
    then
        raise_application_error(-20000, 'Найдены включенные политики в кол-ве '||l_cnt||' шт.');
    end if;
  end check_policies;

  ----
  -- check_event - проверка событий (migration, ...)
  --
  procedure check_event
  is
  begin
    -- флаг 'migration' должен быть установлен
    if sys_context('eventspace','migration') is null
    then
        raise_application_error(-20000, 'Флаг ''migration'' не установлен! Выполните SQL> exec eventspace.set_event(eventspace.migration);');
    end if;
  end check_event;

  ----
  -- check_context - проверка контекста
  --
  procedure check_context
  is
  begin
    -- мы должны быть внутри МФО
    if sys_context('bars_context','user_mfo') is null
    then
        raise_application_error(-20000, 'МФО не установлено!');
    end if;
  end check_context;

  ----
  -- check_foreign_keys - проверяет все ли внешние ключи отключены
  --
  procedure check_foreign_keys
  is
    p       constant varchar2(62) := G_PKG||'.check_foreign_keys';
    l_num   number;
  begin
    --
    trace('%s: entry point', p);
    --
    begin
        select 1
          into l_num
          from user_constraints
         where constraint_type = 'R'
           and status = 'ENABLED'
           and rownum = 1;
        --
        raise_application_error(-20000, 'Найдены включенные ссылочные ограничения целостности. Выполните SQL> exec mgr_utl.disable_foreign_keys;');
        --
    exception
        when no_data_found then
            null;
    end;
    --
    trace('%s: finish point', p);
    --
  end check_foreign_keys;

  /*
  ----
  -- disable_foreign_keys - выключает внешние ключи
  --
  procedure disable_foreign_keys

  is
    p   constant varchar2(62) := G_PKG||'.disable_foreign_keys';
  begin
    trace('%s: entry point', p);
    -- очищаем таблицу mgr_fkeys
    execute immediate 'truncate table mgr_fkeys';
    -- наполняем ее
    insert
      into mgr_fkeys(table_name, constraint_name)
    select table_name, constraint_name
      from user_constraints
     where constraint_type = 'R'
       and status = 'ENABLED';
    commit;
    -- отключаем ссылочные ограничения
    for c in (select * from mgr_fkeys)
    loop
        begin
            execute immediate 'alter table '||c.table_name||' modify constraint '||c.constraint_name||' disable';
        exception
            when others then
                raise_application_error(-20000, 'Table: '||c.table_name||', constraint: '||c.constraint_name||': '
                ||dbms_utility.format_error_stack());
        end;
    end loop;
    --
    trace('%s: finished', p);
    --
  end disable_foreign_keys;

  ----
  -- enable_foreign_keys - включает внешние ключи
  --
  procedure enable_foreign_keys
  is
    p   constant    varchar2(62) := G_PKG||'.enable_foreign_keys';
    l_error_msg     varchar2(2000);
    l_cnt           number;
  begin
    trace('%s: entry point', p);
    -- включаем ссылочные ограничения
    for c in (select * from mgr_fkeys)
    loop
        begin
            -- включаем без валидации
            execute immediate 'alter table '||c.table_name||' modify constraint '||c.constraint_name||' enable novalidate';
        exception
            when others then
                l_error_msg := substr('Table: '||c.table_name||', constraint: '||c.constraint_name||': '
                                    ||dbms_utility.format_error_stack(),
                                    1,2000
                               );
                update mgr_fkeys
                   set error_msg = l_error_msg
                 where table_name = c.table_name
                   and constraint_name = c.constraint_name;
                commit;
        end;
    end loop;
    -- валидируем ссылочные ограничения
    for c in (select * from mgr_fkeys)
    loop
        begin
            -- включаем без валидации
            execute immediate 'alter table '||c.table_name||' modify constraint '||c.constraint_name||' enable novalidate';
            -- валидируем
            execute immediate 'alter table '||c.table_name||' modify constraint '||c.constraint_name||' validate';
            -- удаляем запись
            delete
              from mgr_fkeys
             where table_name = c.table_name
               and constraint_name = c.constraint_name;
            commit;
        exception
            when others then
                l_error_msg := substr('Table: '||c.table_name||', constraint: '||c.constraint_name||': '
                                    ||dbms_utility.format_error_stack(),
                                    1,2000
                               );
                update mgr_fkeys
                   set error_msg = l_error_msg
                 where table_name = c.table_name
                   and constraint_name = c.constraint_name;
                commit;
        end;
    end loop;
    -- сколько осталось невключенных или невалидированных констрейнтов
    select count(*)
      into l_cnt
      from mgr_fkeys;
    --
    if l_cnt>0
    then
        raise_application_error(-20000, 'Осталось '||l_cnt||' невключенных или невалидированных ограничений целостности. См. таблицу MGR_FKEYS.');
    end if;
    -- сколько осталось невключенных констрейнтов по user_constraints
    select count(*)
      into l_cnt
      from user_constraints
     where constraint_type='R'
       and status<>'ENABLED';
    --
    if l_cnt>0
    then
        raise_application_error(-20000, 'Осталось '||l_cnt||' невключенных ограничений целостности. См. USER_CONSTRAINTS.');
    end if;
    -- сколько осталось невалидированных констрейнтов по user_constraints
    select count(*)
      into l_cnt
      from user_constraints
     where constraint_type='R'
       and validated<>'VALIDATED';
    --
    if l_cnt>0
    then
        raise_application_error(-20000, 'Осталось '||l_cnt||' невалидированных ограничений целостности. См. USER_CONSTRAINTS.');
    end if;
    --
    trace('%s: finished', p);
    --
  end enable_foreign_keys;
  */

  ----
  -- disable_foreign_keys - выключает внешние ключи, ссылающиеся на таблицу p_table
  --                        или все, если p_table is null
  procedure disable_foreign_keys(p_table in varchar2 default null)
  is
    l_stmt  varchar2(200);
  begin
    --
    logger.trace('disable_foreign_keys: start point');
    --
    for c in (select r.owner, r.table_name, r.constraint_name
                from all_constraints r, all_constraints p
               where r.constraint_type = 'R'
                 and r.status = 'ENABLED'
                 and r.constraint_name = p.constraint_name
                 and r.owner not in ('SYS', 'SYSTEM', 'DBSNMP', 'EXFSYS', 'CTXSYS', 'ORDDATA', 'MDSYS', 'OLAPSYS', 'SYSMAN')
                 and (p.table_name like case when p_table is null then '%' else upper(p_table) end
                 --не понимаю смысла следующей строчки, закомментил
                 /*or substr(r.r_constraint_name,-length(p_table), length(p_table) ) = p.table_name*/)
              )
    loop
        begin
            l_stmt := 'alter table '||c.owner||'.'||rpad(c.table_name,30)||' modify constraint '||rpad(c.constraint_name,30)||' disable';
            --
            logger.trace(l_stmt);
            --
            execute immediate l_stmt;
            --
        exception when ref_part_restriction then
            --
            logger.error(get_errmsg());
            --
        end;
    end loop;
    --
    logger.trace('disable_foreign_keys: finish point');
    --
  end disable_foreign_keys;

  ----
  -- enable_foreign_keys - включает внешние ключи, ссылающиеся на таблицу p_table (enable novalidate)
  --                       или все, если p_table is null
  procedure enable_foreign_keys(p_table in varchar2 default null)
  is
    l_stmt  varchar2(200);
  begin
    --
    logger.trace('enable_foreign_keys: start point');
    --
    for c in (select  r.owner, r.table_name, r.constraint_name
                from all_constraints r, all_constraints p
               where r.constraint_type = 'R'
                 and r.status = 'DISABLED'
                  and r.constraint_name = p.constraint_name
                 and (p.table_name like case when p_table is null then '%' else upper(p_table) end
                 --не понимаю смысла следующей строчки, закомментил
                 /*or substr(r.r_constraint_name,-length(p_table), length(p_table) ) = p.table_name*/)
              )
    loop
        l_stmt := 'alter table '||c.owner||'.'||rpad(c.table_name,30)||' modify constraint '||rpad(c.constraint_name,30)||' enable novalidate';
        --
        logger.trace(l_stmt);
        --
        execute immediate l_stmt;
        --
    end loop;
    --
    exception when others then
    if sqlcode=(-02270) then bars_audit.error(l_stmt);
        else raise; end if;
    --
    logger.trace('enable_foreign_keys: finish point');
    --
  end enable_foreign_keys;

  ----
  -- validate_foreign_keys - валидирует внешние ключи, ссылающиеся на таблицу p_table
  --                         или все, если p_table is null
  procedure validate_foreign_keys(p_table in varchar2 default null)
  is
    l_have_errors   boolean := false;
    l_stmt  varchar2(200);
  begin
    --
    logger.trace('validate_foreign_keys: start point');
    --
    for c in (select  r.owner, r.table_name, r.constraint_name
                from user_constraints r, user_constraints p
               where r.constraint_type = 'R'
                 and r.status = 'ENABLED'
                 and r.validated <> 'VALIDATED'
                  and r.constraint_name = p.constraint_name
                 and (p.table_name like case when p_table is null then '%' else upper(p_table) end
                 --не понимаю смысла следующей строчки, закомментил
                 /*or substr(r.r_constraint_name,-length(p_table), length(p_table) ) = p.table_name*/)
              )
    loop
        begin
            l_stmt := 'alter table '||c.owner||'.'||rpad(c.table_name,30)||' modify constraint '||rpad(c.constraint_name,30)||' validate';
            --
            logger.trace(l_stmt);
            --
            execute immediate l_stmt;
            --
        exception when others then
            --
            logger.error('error: '||get_errmsg());
            --
            l_have_errors := true;
            --
        end;
        --
    end loop;
    --
    if l_have_errors
    then
        l_stmt := 'были ошибки при валидации внешних ключей, см. журнал';
        logger.error(l_stmt);
    end if;
    --
    logger.trace('validate_foreign_keys: finish point');
    --
  end validate_foreign_keys;

    ----
    -- noop - No Operation
    --
    procedure noop(p_num number)
    is
    begin
        null;
    end noop;

    ----
    -- validate_constraint - валидирует ограничение целостности
    --
    procedure validate_constraint(p_num integer)
    is
        l_cons      cons2valid%rowtype;
        l_stmt      varchar2(4000);
    begin
        --
        select *
          into l_cons
          from cons2valid
         where num = p_num;
        --
        begin
            l_stmt := 'alter table '||l_cons.table_name||' modify constraint '||l_cons.constraint_name||' validate';
            --
            logger.info(l_stmt);
            --
            execute immediate l_stmt;
            --
        exception
            when others then
                logger.error(l_stmt||chr(10)||dbms_utility.format_error_stack());
        end;
        --
    end validate_constraint;
    
    ----
    -- validate_cons_in_parallel - валидирует
    --
    procedure validate_cons_in_parallel(
        p_proc_name     varchar2,
        p_proc_params   varchar2 default null)
    is
        l_task_name constant user_parallel_execute_tasks.task_name%type := upper(p_proc_name);
        --
        e_task_not_found    exception;
        pragma exception_init(e_task_not_found, -29498);
        --
        l_sql_stmt      varchar2(4000);
        l_status        user_parallel_execute_tasks.status%type;
        l_errmsg        clob;
        l_msg           varchar2(4000);
        l_msglen        constant number := 900;
        --l_chunk_stmt    varchar2(4000);
    begin
        -- удаляем одноименное задание
        begin
            dbms_parallel_execute.drop_task(l_task_name);
        exception
            when e_task_not_found then
            null;
        end;
        -- создаем задание
        dbms_parallel_execute.create_task(l_task_name);
        -- делим задание на части
        --
        execute immediate 'truncate table cons2valid';
        --
          insert into cons2valid(num,
                 owner, constraint_name, constraint_type,
                 table_name, r_owner, r_constraint_name, delete_rule, status,
                 deferrable, deferred, validated, generated, bad, rely,
                 last_change, index_owner, index_name, invalid, view_related)
          select rownum as num,
                 owner, constraint_name, constraint_type,
                 c.table_name, r_owner, r_constraint_name, delete_rule, c.status,
                 deferrable, deferred, validated, generated, bad, rely,
                 last_change, index_owner, index_name, invalid, view_related
            from user_constraints c, user_tables s
           where c.table_name = s.table_name
             and s.num_rows < 10000000
             and constraint_type = 'R'
             and c.status = 'ENABLED'
             and validated <> 'VALIDATED'
             and rownum <=20
           order by 1;
        --
        commit;
        --
                -- делим задание на части
        dbms_parallel_execute.create_chunks_by_number_col(
            task_name    => l_task_name,
            table_owner  => 'BARS',
            table_name   => 'CONS2VALID',
            table_column => 'NUM',
            chunk_size   => 1
        );

        -- запускаем задачи
        l_sql_stmt :=
        'begin
            mgr_utl.validate_constraint(:start_id);
            mgr_utl.noop(:end_id);
         end;
        ';
        --
        dbms_parallel_execute.run_task(
            task_name      => l_task_name,
            sql_stmt       => l_sql_stmt,
            language_flag  => DBMS_SQL.NATIVE,
            parallel_level => null
        );
        -- проверяем статус
        select status
          into l_status
          from user_parallel_execute_tasks
         where task_name = l_task_name;
        --
        if l_status<>'FINISHED'
        then
            dbms_lob.createTemporary(l_errmsg, false, dbms_lob.call);
            l_msg := 'Task '||l_task_name||' finished with error or crashed.'
                       ||chr(10)||'Select view USER_PARALLEL_EXECUTE_CHUNKS for details.'||chr(10);
            dbms_lob.writeAppend(l_errmsg, length(l_msg), l_msg);
            for c in (select *
                        from user_parallel_execute_chunks
                       where task_name = l_task_name
                         and status <> 'PROCESSED'
                       order by start_id
                     )
            loop
                l_msg := chr(10) || 'Cons #'||c.start_id||' '||c.status||' '||c.error_message;
                dbms_lob.writeAppend(l_errmsg, length(l_msg), l_msg);
            end loop;
            --
            if dbms_lob.getLength(l_errmsg)>l_msglen
            then
                l_msg := dbms_lob.substr(l_errmsg, l_msglen-3, 1)||'...';
            else
                l_msg := dbms_lob.substr(l_errmsg, l_msglen, 1);
            end if;
            --
            dbms_lob.freeTemporary(l_errmsg);
            --
            raise_application_error(-20000, l_msg);
            --
        end if;
        --
    end validate_cons_in_parallel;

  ----
  -- get_free_userid - возвращает свободный минимальный id пользователя
  -- если таковых нету, инкрементирует сиквенс
  --
  function get_free_userid
  return integer
  is
    l_userid        integer;
    l_max_userid    integer;
    --l_num           integer;
  begin
    select nvl(max(id),0)
      into l_max_userid
      from staff$base;
    -- ищем минимальный свободный номер
    select min(num)
      into l_userid
      from (select level as num
              from dual
           connect by level <= l_max_userid+1
           )
     where num not in (select id
                         from staff$base
                      );
    -- подстраиваем сиквенс под наше значение
    if l_userid > l_max_userid
    then
        reset_sequence('S_STAFF', l_userid);
    end if;
    --
    return l_userid;
    --
  end get_free_userid;

  ----
  -- get_free_username - возвращает свободное имя пользователя
  --
  function get_free_username(p_username in varchar2)
  return varchar2
  is
    l_new_username  varchar2(32);
    l_suffix        integer;
    l_userid        integer;
  begin
    begin
        -- ищем пользователя с таким именем
        select id
          into l_userid
          from staff$base
         where logname = p_username;
        -- плохо дело, такой пользователь существует,
        -- ищем свободное имя
        if p_username not like 'USER\_%' escape '\'
        then
            -- база рекурсии
            l_new_username := 'USER_0';
        else
            l_suffix := to_number(substr(p_username, 6));
            l_new_username := 'USER_'||to_char(l_suffix+1);
        end if;
        --
        if length(l_new_username) > 30
        then
            -- выход из рекурсии по ошибке
            raise_application_error(-20000, 'Не нашли свободного имени пользователя');
        end if;
        --
        return get_free_username(l_new_username);
        --
    exception
        when no_data_found then
            -- успешный выход из рекурсии
            return p_username;
    end;
    --
  end get_free_username;

  ----
  -- get_free_rnk - возвращает свободный минимальный rnk
  --
  function get_free_rnk
  return integer
  is
    l_rnk        integer;
    l_max_rnk    integer;
    l_num        integer;
  begin
    select nvl(max(rnk),0)
      into l_max_rnk
      from customer;
    -- ищем минимальный свободный номер
    select min(num)
      into l_rnk
      from (select level as num
              from dual
           connect by level <= l_max_rnk+1
           )
     where num not in (select rnk
                         from customer
                      );
    --
    return l_rnk;
    --
  end get_free_rnk;

  ----
  -- get_free_acc - возвращает свободный минимальный acc
  --
  function get_free_acc
  return integer
  is
    l_acc           integer;
    l_max_acc       integer;
    l_num           integer;
    l_cur_branch    branch.branch%type := sys_context('bars_context','user_branch');
  begin
    -- идем в корень, чтобы видеть все счета
    bc.set_context;
    --
    select nvl(max(acc),0)
      into l_max_acc
      from accounts;
    -- ищем минимальный свободный номер
    select min(num)
      into l_acc
      from (select level as num
              from dual
           connect by level <= l_max_acc+1
           )
     where num not in (select acc
                         from accounts
                      );
    -- возвращаемся
    bc.go(l_cur_branch);
    --
    return l_acc;
    --
  exception when others then
    --
    bc.go(l_cur_branch);
    raise;
    --
  end get_free_acc;

  ----
  -- get_free_accs - возвращает массив свободных acc для указанного кол-ва счетов
  --
  procedure get_free_accs(p_acc_cnt in number, p_accs in out nocopy dbms_sql.number_table)
  is
    l_acc           integer;
    l_max_acc       integer;
    l_num           integer;
    l_cur_branch    branch.branch%type := sys_context('bars_context','user_branch');
  begin
    -- идем в корень, чтобы видеть все счета
    bc.set_context;
    --
    select nvl(max(acc),0)
      into l_max_acc
      from accounts;
    -- ищем
    select num
      bulk collect into p_accs
      from (select level as num
              from dual
           connect by level <= l_max_acc+p_acc_cnt
           )
     where num not in (select acc
                         from accounts
                      )
     order by num;
    -- возвращаемся
    bc.go(l_cur_branch);
    --
    --
  exception when others then
    --
    bc.go(l_cur_branch);
    raise;
    --
  end get_free_accs;

    ----
    -- reset_sequence - сбрасывает значение последовательности
    --
    procedure reset_sequence (seq_name in varchar2, startvalue in number)
    is
        cval   number;
        inc_by varchar2(25);
    begin

      execute immediate 'ALTER SEQUENCE ' ||seq_name||' MINVALUE 0';

      execute immediate 'SELECT ' ||seq_name ||'.NEXTVAL FROM DUAL'
      into cval;

      cval := cval - startvalue + 1;
      if cval < 0 then
        inc_by := ' INCREMENT BY ';
        cval:= abs(cval);
      else
        inc_by := ' INCREMENT BY -';
      end if;

      if cval=0
      then
        return;
      end if;

      execute immediate 'ALTER SEQUENCE ' || seq_name || inc_by ||
      cval;

      execute immediate 'SELECT ' ||seq_name ||'.NEXTVAL FROM DUAL'
      into cval;

      execute immediate 'ALTER SEQUENCE ' || seq_name ||
      ' INCREMENT BY 1';

    end reset_sequence;

    ----
    -- disable_table_triggers - выключает все триггера на таблице p_table
    --                          за исключением неотключаемых триггеров по списку p_exclude
    --
    procedure disable_table_triggers(p_table in varchar2, p_exclude in varchar2 default null)
    is
        l_errors    boolean := false;
        l_stmt      varchar2(200);
    begin
        --
        logger.trace('disable_table_triggers(''%s'',%s)', p_table,
            case when p_exclude is not null then ''''||p_exclude||'''' else 'null' end
        );
        -- выключаем все триггера
        /*begin
            l_stmt := 'alter table '||p_table||' disable all triggers';
            logger.trace(l_stmt);
            execute immediate l_stmt;
        exception
            when others then
                l_errors := true;
                logger.error(get_errmsg());
        end;*/
        begin
                for rec in 
                    (select t.trigger_name from all_triggers t
                      where t.owner = 'BARS'
                        and t.table_name = p_table
                        and t.status = 'ENABLED')  
            loop
            begin  
                l_stmt := 'alter trigger '||rec.trigger_name||' disable';
                logger.trace(l_stmt);
                execute immediate l_stmt;
            exception
                when others then
                    l_errors := true;
                    logger.error(get_errmsg());
            end;
            end loop;
        end;
        
        -- включаем триггера по списку p_exclude
        for c in (select upper(trim(token)) as trigger_name
                    from ( select regexp_substr(p_exclude,'[^,]+', 1, level) token
                             from dual
                          connect by regexp_substr(p_exclude, '[^,]+', 1, level) is not null
                         )
                   where upper(trim(token)) is not null
                 )
        loop
            begin
                l_stmt := 'alter trigger '||c.trigger_name||' enable';
                logger.trace(l_stmt);
                execute immediate l_stmt;
            exception
                when others then
                    l_errors := true;
                    logger.error(get_errmsg());
            end;
        end loop;
        if l_errors
        then
            raise_application_error(-20000, 'При выключении триггеров на таблице '||p_table||' возникли ошибки. См. журнал.');
        end if;
        --
        logger.trace('disable_table_triggers: finish point');
        --
    end disable_table_triggers;

    ----
    -- enable_table_triggers - включает все отключенные триггера на таблице p_table
    --
    procedure enable_table_triggers(p_table in varchar2)
    is
        l_errors    boolean := false;
        l_stmt      varchar2(200);
    begin
        --
        logger.trace('enable_table_triggers(''%s'')', p_table);
        --
        /*begin
            l_stmt := 'alter table '||p_table||' enable all triggers';
            logger.trace(l_stmt);
            execute immediate l_stmt;
        exception
            when others then
                l_errors := true;
                logger.error(get_errmsg());
        end;*/
        begin
                for rec in 
                    (select t.trigger_name from all_triggers t
                      where t.owner = 'BARS'
                        and t.table_name = p_table
                        and t.status = 'DISABLED')  
            loop
            begin  
                l_stmt := 'alter trigger '||rec.trigger_name||' enable';
                logger.trace(l_stmt);
                execute immediate l_stmt;
            exception
                when others then
                    l_errors := true;
                    logger.error(get_errmsg());
            end;
            end loop;
        end;

        -- выключаем триггера по списку из mgr_oschad.check_disable_trigger
        /*for c in (
                   select dus.object_name 
                      from ddl_utils_store dus 
                    where dus.object_type = 'TRIGGER_DISABLED'
                      and dus.table_name = p_table
                 )
        loop
            begin
                l_stmt := 'alter trigger '||c.object_name||' disable';
                logger.trace(l_stmt);
                execute immediate l_stmt;
            exception
                when others then
                    l_errors := true;
                    logger.error(get_errmsg());
            end;
        end loop;*/
        if l_errors
        then
            raise_application_error(-20000, 'При включении триггеров на таблице '||p_table||' возникли ошибки. См. журнал.');
        end if;
        --
        logger.trace('enable_table_triggers: finish point');
        --
    end enable_table_triggers;


  ----
  -- before_clean - выполняет предварительные действия со списком таблиц перед их очисткой
  --                отключает внешние ключи, триггера
  procedure before_clean(p_tables in varchar2)
  is
  begin
    --
    if g_operation is not null
    then
      -- было
      --  raise_application_error(-20000, 'Нарушена последовательность вызова служебных процедур.'
      --                       ||chr(10)||'Выполните SQL> exec mgr_utl.finalize;');
      -- вместо raise_application_error выполняем mgr_utl.finalize
      finalize();
    end if;
    --
    g_operation := C_OPERATION_CLEAN;
    g_tables    := p_tables;
    --
    clean_error();
    --
    for c in (select upper(trim(token)) atable
                from ( select regexp_substr(g_tables,'[^,]+', 1, level) token
                         from dual
                      connect by regexp_substr(g_tables, '[^,]+', 1, level) is not null
                     )
               where upper(trim(token)) is not null
             )
    loop
        disable_table_triggers (c.atable);
        disable_foreign_keys   (c.atable);
    end loop;
    --
  end before_clean;

  ----
  -- before_fill - выполняет предварительные действия со списком таблиц перед их наполнением
  --                отключает внешние ключи, триггера
  procedure before_fill(p_tables in varchar2)
  is
  begin
    --
    --
    if g_operation is not null
    then
      -- было
      --  raise_application_error(-20000, 'Нарушена последовательность вызова служебных процедур.'
      --                       ||chr(10)||'Выполните SQL> exec mgr_utl.finalize;');
      -- вместо raise_application_error выполняем mgr_utl.finalize
      finalize();
    end if;
    --
    g_operation := C_OPERATION_FILL;
    g_tables    := p_tables;
    --
    clean_error();
    --
    for c in (select upper(trim(token)) atable
                from ( select regexp_substr(g_tables,'[^,]+', 1, level) token
                         from dual
                      connect by regexp_substr(g_tables, '[^,]+', 1, level) is not null
                     )
               where upper(trim(token)) is not null
             )
    loop
        disable_table_triggers (c.atable);
        disable_foreign_keys (c.atable);

    end loop;
    --
  end before_fill;

  ----
  -- rebuild_unusable_indexes - перестраиваем неиспользуемые индексы на таблице
  --
  procedure rebuild_unusable_indexes(p_table varchar2)
  is
    l_stmt  varchar2(256);
  begin
    for c in (select *
                from user_indexes
               where table_owner='BARS'
                 and table_name=p_table
                 and status='UNUSABLE'
             )
    loop
        l_stmt := 'alter index '||c.index_name||' rebuild parallel';
        --
        trace(l_stmt);
        --
        execute immediate l_stmt;
        --
    end loop;
    --
  end rebuild_unusable_indexes;

  ----
  -- finalize - выполняет финальные действия со списком таблиц после их очистки или наполнения
  --   включает внешние ключи, триггера
  --   список таблиц задается в before_clean(p_tables) или before_fill(p_tables)
  --   и хранится в глобальной переменной
  --   процедура сама разбирается после чего выполнять финализацию: после очистки или после наполнения
  --
  procedure finalize
  is
  begin
    if g_operation is null
    then
        raise_application_error(-20000, 'Нарушена последовательность вызова служебных процедур.'
                             ||chr(10)||'Выполните SQL> exec mgr_utl.before_clean(:p_tables);'
                             ||chr(10)||'      или SQL> exec mgr_utl.before_fill (:p_tables);');
    end if;
    --
    for c in (select upper(trim(token)) atable
                from ( select regexp_substr(g_tables,'[^,]+', 1, level) token
                         from dual
                      connect by regexp_substr(g_tables, '[^,]+', 1, level) is not null
                     )
               where upper(trim(token)) is not null
             )
    loop
        if      g_operation = C_OPERATION_CLEAN
        then
            enable_table_triggers (c.atable);
            enable_foreign_keys   (c.atable);
            --
        elsif   g_operation = C_OPERATION_FILL
        then
            enable_table_triggers (c.atable);
        else
            raise_application_error(-20000, 'Неизвестный тип операции: '||to_char(g_operation));
        end if;
        --
        rebuild_unusable_indexes(c.atable);
        --
    end loop;
    --
    g_operation := null;
    g_tables    := null;
    --
    raise_error();
    --
  end finalize;

  ----
  -- clean_local_table - очищает локальную таблицу по указанному KF
  --
  procedure clean_local_table(p_table varchar2, p_kf varchar2)
  is
    p           constant varchar2(62) := G_PKG||'.clean_local_table';
    l_stmt      varchar2(4000);
  begin
    --
    trace('%s(''%s'', ''%s''): entry point', p, p_table, p_kf);
    --
    bc.go(p_kf);
    --
    mgr_utl.before_clean(p_table);
    --
    begin
        --
        l_stmt := 'delete from '||p_table||' where kf='''||p_kf||'''';
        --
        trace(l_stmt);
        --
        execute immediate l_stmt;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            mgr_utl.save_error();
    end;
    --
    bc.home();
    --
    mgr_utl.finalize();
    --
    trace('%s: finish point', p);
    --
  end clean_local_table;

  ----
  -- fill_local_table - наполняет локальную таблицу по указанному SQL-выражению
  --
  procedure fill_local_table(p_table varchar2, p_kf varchar2, p_stmt varchar2)
  is
    p                       constant varchar2(62) := G_PKG||'.fill_local_table';
    l_tab                   varchar2(30);
    l_migration_start_time  date default sysdate;
    l_start_time            timestamp default current_timestamp;
    l_end_time              timestamp default current_timestamp;
    l_rowcount              number default 0;
    l_time_duration         interval day(3) to second(3);
  begin
    --
    l_tab := upper(p_table);
    --
    trace('%s(''%s'', ''%s'', p_stmt): entry point', p, p_table, p_kf);
    --
    bc.go(p_kf);
    --
    mgr_utl.before_fill(p_table);
    --
    begin
        l_migration_start_time := sysdate;
        l_start_time := current_timestamp;
        --
        trace(p_stmt);
        --
        execute immediate p_stmt;
        --
        l_rowcount        := l_rowcount + sql%rowcount;
        l_end_time        := current_timestamp;
        l_time_duration   := (l_end_time - l_start_time);
        trace('%s rows inserted', l_rowcount);
        mgr_log.p_save_log_info_mesg(ip_migration_id              => p_kf
                                ,ip_migration_start_time          => l_migration_start_time
                                ,ip_table_name                    => l_tab
                                ,ip_operation                     => p
                                ,ip_row_count                     => l_rowcount
                                ,ip_task_start_time               => l_start_time
                                ,ip_task_end_time                 => l_end_time
                                ,ip_time_duration                 => l_time_duration
                                ,ip_log_message                   => 'Done'
                                 );
       exception when others then
         rollback;
         --mgr_utl.save_error();
       mgr_log.p_save_log_error(ip_migration_id                      => p_kf
                               ,ip_migration_start_time              => l_migration_start_time
                               ,ip_table_name                        => l_tab
                               ,ip_operation                         => p
                               ,ip_row_count                         => l_rowcount
                               ,ip_task_start_time                   => l_start_time
                               ,ip_task_end_time                     => l_end_time
                               ,ip_time_duration                     => l_time_duration
                               ,ip_log_message                       => 'Error'
                               );
           
     end;
        
        --
        commit;
        --
        bc.home();
        --
        trace('собираем статистику');
        --
        mgr_utl.gather_table_stats('bars', p_table, cascade=>true);
        --
    exception
        when others then
            rollback;
            mgr_utl.save_error();
    --
    bc.home();
    --
    mgr_utl.finalize();
    --
    trace('%s: finish point', p);
    --
  end fill_local_table;

  ----
  -- sync_global_table - синхронизирует глобальную(без KF) таблицу по указанному SQL-выражению
  --
  procedure sync_global_table(p_table varchar2, p_stmt varchar2)
  is
    p       constant varchar2(62) := G_PKG||'.sync_global_table';
    l_stmt  varchar2(4000);
    l_migration_start_time     date default sysdate;
    l_start_time               timestamp default current_timestamp;
    l_end_time                 timestamp default current_timestamp;
    l_rowcount                 number default 0;
    l_time_duration            interval day(3) to second(3);
  begin
    --
    trace('%s(''%s'', p_stmt): entry point', p, p_table);
    --
    bc.home();
    --
    -- очистка
    --
    mgr_utl.before_clean(p_table);
    --
    begin
        l_stmt := 'truncate table '||p_table;
        --
        trace(l_stmt);
        --
        execute immediate l_stmt;
        --
    end;
    --
    mgr_utl.finalize();
    --
    -- наполнение
    --
    mgr_utl.before_fill(p_table);
    --
    begin
        --
        trace(p_stmt);
        --
        l_migration_start_time := sysdate;
        l_start_time := current_timestamp;
        --
        execute immediate p_stmt;
        
        l_rowcount := sql%rowcount;
        
        trace('вставлено %s строк', to_char(sql%rowcount));
        --
        l_end_time := current_timestamp;
        l_time_duration:= (l_end_time - l_start_time);
        --
        mgr_log.p_save_log_info_mesg(ip_migration_id                  => mgr_utl.g_kf
                                    ,ip_migration_start_time          => l_migration_start_time
                                    ,ip_table_name                    => p_table
                                    ,ip_operation                     => p
                                    ,ip_row_count                     => l_rowcount
                                    ,ip_task_start_time               => l_start_time
                                    ,ip_task_end_time                 => l_end_time
                                    ,ip_time_duration                 => l_time_duration
                                    ,ip_log_message                   => 'Done'
                                     );
        --
        commit;
        --
        trace('gather stats');
        --
        mgr_utl.gather_table_stats('bars', p_table, cascade=>true);
        --
        --
        exception when others then
                  rollback;
        mgr_utl.save_error();
             mgr_log.p_save_log_error( ip_migration_id                      => mgr_utl.g_kf
                                      ,ip_migration_start_time              => l_migration_start_time
                                      ,ip_table_name                        => p_table
                                      ,ip_operation                         => p
                                      ,ip_row_count                         => l_rowcount
                                      ,ip_task_start_time                   => l_start_time
                                      ,ip_task_end_time                     => l_end_time
                                      ,ip_time_duration                     => l_time_duration
                                      ,ip_log_message                       => 'Error'
                                      );
    end;
    --
    mgr_utl.finalize();
    --
    trace('%s: finish point', p);
    --
  end sync_global_table;

  ----
  -- int_clean_table - очистка произвольной таблицы
  --
  procedure int_clean_table(p_table varchar2, p_table_type varchar2)
  is
    l_table varchar2(30) := upper(p_table);
    l_stmt  varchar2(4000);
  begin
      --
      mgr_utl.before_clean(l_table);
      --
      begin
          l_stmt := 'delete from '||l_table;
          --
          case
          when p_table_type = C_TAB_GLOBAL
          then
                null;
          when p_table_type = C_TAB_LOCAL_KF
          then
                l_stmt := l_stmt || ' where kf = sys_context(''bars_context'',''user_mfo'')';
          when p_table_type = C_TAB_LOCAL_RFC
            then
                    l_stmt := l_stmt || ' where rfc = sys_context(''bars_context'',''rfc'')';
                --
          when p_table_type = C_TAB_LOCAL_BRANCH
          then
                l_stmt := l_stmt || ' where sys_context(''bars_context'',''user_branch'')=''/'' and branch=''/'''
                ||' or sys_context(''bars_context'',''user_branch'')<>''/'' and branch like sys_context(''bars_context'',''user_mfo_mask'')';
                --
          when p_table_type = C_TAB_MIXED
          then
            -- чистим локальные данные
            l_stmt := l_stmt || ' where branch like ''/'||g_kf||'/%''';
            -- для головного банка чистим также глобальные данные
            if g_kf = g_glb_mfo
            -- во всяком правиле есть исключения: не чистим корневые записи для таблиц META_*,
            -- DYN_FILTER, REFERENCES, DBF_SYNC_TABS
            and l_table not in ('DYN_FILTER','REFERENCES','DBF_SYNC_TABS')
            and l_table not like 'META\_%' escape '\'
            and l_table not like 'STAFFTIP_GRP'
            then
                l_stmt := l_stmt || ' or branch=''/''';
            end if;
          end case;
          --
          trace(l_stmt);
          --
          execute immediate l_stmt;
          --
          trace('удалено %s строк', to_char(sql%rowcount));
          --
          commit;
          --
      exception when others then
          rollback;
          mgr_utl.save_error();
      end;
      --
      mgr_utl.finalize();
      --
  end int_clean_table;

  ----
  -- get_table_type - возвращает тип таблицы: локальная/глобальная/смешанная
  --
  function get_table_type(p_table varchar2) return varchar2
  is
    l_table_type    varchar2(30);
    l_num           number;
    is_pk_contains_branch  boolean;
  begin
    --
    -- тип таблицы(локальная/глобальная/смешанная) определяем по наличию полей KF и BRANCH
    --
    begin
        -- ищем поле KF
        select 1
          into l_num
          from user_tab_columns
         where table_name=p_table
           and column_name ='KF'
           and rownum=1;
        -- тип таблицы - локальная с полем KF
        l_table_type := C_TAB_LOCAL_KF;
        --
    exception
        when no_data_found then
        begin
            select 1
          into l_num
          from user_tab_columns
         where table_name=p_table
           and column_name ='RFC'
           and rownum=1;
        -- тип таблицы - локальная с полем RFC
        l_table_type := C_TAB_LOCAL_RFC;
        exception when no_data_found then
            -- ищем поле BRANCH
            begin
                select 1
                  into l_num
                  from user_tab_columns
                 where table_name=p_table
                   and column_name='BRANCH'
                   and rownum=1;
                -- нашли, смотрим входит ли оно в первичный ключ
                begin
                    select 1
                      into l_num
                      from user_constraints p, user_cons_columns c
                     where p.table_name=p_table
                       and p.constraint_type='P'
                       and p.constraint_name=c.constraint_name
                       and c.column_name='BRANCH';
                    --
                    is_pk_contains_branch := true;
                    --
                exception when no_data_found then
                    --
                    is_pk_contains_branch := false;
                    --
                end;
                --
                if is_pk_contains_branch
                then
                    -- тип таблицы - локальная с полем BRANCH
                    l_table_type := C_TAB_LOCAL_BRANCH;
                else
                    -- тип таблицы - смешанная
                    l_table_type := C_TAB_MIXED;
                end if;
                --
            exception
                when no_data_found then
                    -- тип таблицы - глобальная
                    l_table_type := C_TAB_GLOBAL;
            end;

         end;
    end;
    --
    trace('get_table_type(''%s'')=>''%s''', p_table, l_table_type);
    --
    return l_table_type;
    --
  end get_table_type;

  ----
  -- clean - очистка произвольной таблицы
  --
  procedure clean(p_table varchar2)
  is
    l_table         varchar2(30) := upper(p_table);
    l_kf            varchar2(6);
    l_num           number;
    l_table_type    varchar2(30);
  begin
    --
    g_glb_mfo := get_glb_mfo();
    --
    l_table_type := get_table_type(l_table);
    --
    if l_table_type in (C_TAB_GLOBAL, C_TAB_MIXED)
    then
        l_kf := null;
    else
        l_kf := get_kf();
    end if;
    --
    trace('l_kf = ''%s''', nvl(l_kf, 'null'));
    --
    if l_kf is not null
    then
      logger.trace('bc.go(''%s'')', l_kf);
      bc.go(l_kf);
    else
      logger.trace('bc.home()');
      bc.home();
    end if;

    int_clean_table(l_table, l_table_type);

    if l_kf is not null
    then
      logger.trace('bc.home()');
      bc.home();
    end if;

  exception when others
  then
    --
    rollback;
    logger.trace('bc.home()');
    bc.home();
    raise_application_error(-20000, get_errmsg());
    --
  end clean;

  ----
  -- sync_table - синхронизирует таблицу с данными по указанному SQL-выражению
  --
  procedure sync_table(p_table varchar2, p_stmt varchar2, p_delete boolean default false)
  is
    l_table                    varchar2(30) := upper(p_table);
    p                          constant varchar2(62) := G_PKG||'.sync_'||l_table;
    --l_stmt                     varchar2(4000);
    l_kf                       varchar2(6);
    --l_num                      number;
    l_table_type               varchar2(30);
    l_migration_start_time     date default sysdate;
    l_start_time               timestamp default current_timestamp;
    l_end_time                 timestamp default current_timestamp;
    l_rowcount                 number default 0;
    l_time_duration            interval day(3) to second(3);
  begin
    --
    trace('%s(''%s'', p_stmt): entry point', p, p_table);
    --
    g_glb_mfo := get_glb_mfo();
    --
    l_table_type := get_table_type(l_table);
    --
    if l_table_type in (C_TAB_GLOBAL, C_TAB_MIXED)
    then
        l_kf := null;
    else
        l_kf := get_kf();
    end if;
    --
    trace('l_kf = ''%s''', nvl(l_kf, 'null'));
    --
    if l_kf is not null
    then
      logger.trace('bc.go(''%s'')', l_kf);
      bc.go(l_kf);
    else
      logger.trace('bc.home()');
      bc.home();
    end if;
    --
    -- очистка
    --
    if p_delete
    then
      int_clean_table(l_table, l_table_type);
    end if;
    --
    -- наполнение
    --
    mgr_utl.before_fill(l_table);
    --
    begin
        --
        l_migration_start_time := sysdate;
        l_start_time := current_timestamp;
        --
        trace(chr(10)||p_stmt);
        --
        execute immediate p_stmt;
        --
        l_rowcount := sql%rowcount;
        
        trace('вставлено %s строк', to_char(sql%rowcount));
        --
        l_end_time := current_timestamp;
        l_time_duration:= (l_end_time - l_start_time);
        --
        mgr_log.p_save_log_info_mesg(ip_migration_id                  => mgr_utl.g_kf
                                    ,ip_migration_start_time          => l_migration_start_time
                                    ,ip_table_name                    => l_table
                                    ,ip_operation                     => p
                                    ,ip_row_count                     => l_rowcount
                                    ,ip_task_start_time               => l_start_time
                                    ,ip_task_end_time                 => l_end_time
                                    ,ip_time_duration                 => l_time_duration
                                    ,ip_log_message                   => 'Done'
                                     );
        --
        commit;
        --
        trace('gather stats');
        --
        mgr_utl.gather_table_stats('bars', l_table, cascade=>true);
        --
    exception 
        when others then
             rollback;
             mgr_utl.save_error();
             mgr_log.p_save_log_error( ip_migration_id                      => mgr_utl.g_kf
                                      ,ip_migration_start_time              => l_migration_start_time
                                      ,ip_table_name                        => l_table
                                      ,ip_operation                         => p
                                      ,ip_row_count                         => l_rowcount
                                      ,ip_task_start_time                   => l_start_time
                                      ,ip_task_end_time                     => l_end_time
                                      ,ip_time_duration                     => l_time_duration
                                      ,ip_log_message                       => 'Error'
                                      );
    end;
    --
    if l_kf is not null
    then
      logger.trace('bc.home()');
      bc.home();
    end if;
    --
    mgr_utl.finalize();
    --
    trace('%s: finish point', p);
    --
  end sync_table;


  ----
  -- sync_table_auto - синхронизирует таблицу с данными
  --
------------------------------------------------------------  
------------------------------------------------------------
  procedure sync_table_auto(
    p_table varchar2,
    p_delete boolean default false,
    p_column_replace varchar2 default null
  )
  is
    p          constant varchar2(62) := G_PKG||'.sync_table_auto';
    l_table    varchar2(30) := upper(p_table);
    l_stmt     varchar2(4000);
    l_ins_cols varchar2(4000);
    l_sel_cols varchar2(4000);
    l_col      varchar2(256);
    l_kf       varchar2(6);
    l_include       boolean;
    l_tab_exists    number;
    l_tab_length    BINARY_INTEGER;
    l_array         DBMS_UTILITY.lname_array;
    type t_colrep is table of varchar2(4000) index by varchar2(30);
    l_colrep        t_colrep;
    l_index         pls_integer;
    l_column        varchar2(30);
    l_replace       varchar2(4000);
    l_nullable      varchar2(1);
    l_datadefault   varchar2(1024);
  begin
    --
    trace('%s(''%s'',%s): entry point', p, p_table, case when p_delete then 'true' else 'false' end);
    --
    l_kf := get_kf();
    
  if (g_schema is null or g_dblink is null)
  then  
    begin
        -- посмотрим существует ли исходная таблица
        begin
            select 1
              into l_tab_exists
              from all_tables
             where owner='KF'||l_kf
               and table_name=l_table;
        exception
            when no_data_found then
                l_tab_exists := 0;
        end;
        --
        if l_tab_exists=0
        then
            raise_application_error(-20000, 'Таблица KF'||l_kf||'.'||l_table||' не существует. Импорт не выполняем.');
        end if;
        --
        -- обрабатываем p_column_replace
        --
        if p_column_replace is not null
        then
            dbms_utility.comma_to_table(
                list    => p_column_replace,
                tablen  => l_tab_length,
                tab     => l_array
            );
            l_index := 1;
            while l_index < l_tab_length
            loop
                l_column := upper(trim(l_array(l_index)));
                l_replace := trim(l_array(l_index+1));
                if l_replace like '"%"'
                then
                    l_replace := substr(l_replace, 2, length(l_replace)-2);
                end if;
                l_colrep(l_column) := l_replace;
                trace('Колонка %s будет заменена на выражение %s', l_column, l_replace);
                l_index := l_index + 2;
            end loop;
        end if;
        --
        -- формируем sql-выражение для вставки
        -- список колонок с автозаменой
        for t in (select *
                    from user_tab_columns
                   where table_name=l_table
                     --and column_name not in ('KF','BRANCH')
                     and column_name <> 'KF' --поле BRANCH мигрируем с теми данными какие есть в РУ
                   order by column_id
                 )
        loop
            --trace('обрыбатываем колонку '||t.column_name);
            -- ищем аналогичную колонку в исходной таблице kf<mfo>.table_name
            begin
                select column_name, nullable
                  into l_col, l_nullable
                  from all_tab_columns
                 where owner='KF'||l_kf
                   and table_name=l_table
                   and column_name=t.column_name;
                --
                l_include := true;
            exception
                when no_data_found then
                -- колонку в исходной таблице не нашли, в списки колонок включать не будем
                l_include := false;
                --
                logger.warning('Колонка '||t.column_name||' не найдена в исходной таблице KF'||l_kf||'.'||l_table);
                --
            end;
            --
            if l_include
            then
                begin
                    select case p.table_name
                           when 'ACCOUNTS'      then 'GetNewAcc('''||l_kf||''','||c.column_name||')'
                           when 'CUSTOMER'      then 'GetNewRnk('''||l_kf||''','||c.column_name||')'
                           when 'STAFF$BASE'    then case p.constraint_type
                                                     when 'P' then 'GetNewUserid('''||l_kf||''','||c.column_name||')'
                                                     when 'U' then 'GetNewUsername('''||l_kf||''','||c.column_name||')'
                                                     end
                           when 'TTS'           then 'GetNewTT('''||l_kf||''','||c.column_name||')'
                           when 'BRANCH'        then 'GetNewBranch('''||l_kf||''','||c.column_name||')'
                           when 'ARC_RRP'       then 'rukey('||c.column_name||')'
                           when 'OPER'          then 'rukey('||c.column_name||')'
                           when 'OTDEL'         then 'rukey('||c.column_name||')'
                           when 'ZAPROS'        then 'rukey('||c.column_name||')'
                           when 'REPORTS'       then 'rukey('||c.column_name||')'
                           else c.column_name
                           end as replace_func
                      into l_col
                      from user_cons_columns c, user_constraints s, user_constraints p
                     where c.table_name=l_table
                       and c.column_name=t.column_name
                       and c.owner=s.owner
                       and c.constraint_name=s.constraint_name
                       and s.constraint_type='R'
                       and s.r_owner=p.owner
                       and s.r_constraint_name=p.constraint_name
                       and p.constraint_type in ('P','U');
                exception
                    when no_data_found then
                        l_col := t.column_name;
                        -- спец.обработка поля STMT типа NUMBER: его тоже перекодируем
                        if t.column_name='STMT' and t.data_type='NUMBER'
                        then
                            l_col := 'rukey('||t.column_name||')';
                        end if;
                end;

                --
                if t.nullable='N' and l_nullable='Y' and t.data_default is not null
                then
                    trace('подмена not null колонки %s', t.column_name);
                    l_datadefault := t.data_default;
                    l_col := 'nvl2('||t.column_name||', '||l_col||', '||l_datadefault||')';
                    trace('l_col = %s', l_col);
                end if;
                --
                l_ins_cols := l_ins_cols || case when l_ins_cols is null then null else ', ' end || t.column_name;
                -- подменяем колонку, если просят
                if l_colrep.exists(l_col)
                then
                    trace('подменяем колонку %s на выражение %s', l_col, l_colrep(l_col));
                    l_col := l_colrep(l_col);
                end if;
                --
                l_sel_cols := l_sel_cols || case when l_sel_cols is null then null else ', ' end || l_col;
                --
            end if;
            --
        end loop;        
    end;
    else 
    begin    
        -- посмотрим существует ли исходная таблица по dblink
        begin
            execute immediate ' select 1
                                  from all_tables@'||ltrim(g_dblink, '@')||'
                                 where owner='''||upper(g_schema)||'''
                                   and table_name='''||l_table||'''
                                   union 
                                select 1
                                  from all_views@'||ltrim(g_dblink, '@')||'
                                 where owner='''||upper(g_schema)||'''
                                   and view_name='''||l_table||''''
               into l_tab_exists;
          exception
                    when no_data_found then
                         l_tab_exists := 0;
        end;
        --
        if l_tab_exists=0
        then
            raise_application_error(-20000, 'Таблица '||g_schema||'.'||l_table||' не существует. Импорт не выполняем.');
        end if;
        --
        -- обрабатываем p_column_replace
        --
        if p_column_replace is not null
        then
            dbms_utility.comma_to_table(
                list    => p_column_replace,
                tablen  => l_tab_length,
                tab     => l_array
            );
            l_index := 1;
            while l_index < l_tab_length
            loop
                l_column := upper(trim(l_array(l_index)));
                l_replace := trim(l_array(l_index+1));
                if l_replace like '"%"'
                then
                    l_replace := substr(l_replace, 2, length(l_replace)-2);
                end if;
                l_colrep(l_column) := l_replace;
                trace('Колонка %s будет заменена на выражение %s', l_column, l_replace);
                l_index := l_index + 2;
            end loop;
        end if;
        --
        -- формируем sql-выражение для вставки
        -- список колонок с автозаменой
        for t in (select *
                    from user_tab_columns
                   where table_name=l_table
                     --and column_name not in ('KF','BRANCH')
                     and column_name <> 'KF' --поле BRANCH мигрируем с теми данными какие есть в РУ
                   order by column_id
                 )
        loop
            --trace('обрыбатываем колонку '||t.column_name);
            -- ищем аналогичную колонку в исходной таблице kf<mfo>.table_name
            begin
                execute immediate ' select column_name, nullable
                                      from all_tab_columns@'||ltrim(g_dblink, '@')||'
                                     where owner='''||upper(g_schema)||'''
                                       and table_name='''||l_table||'''
                                       and column_name=:cn'
                   into l_col, l_nullable
                  using t.column_name;
                --
                l_include := true;
            exception
                when no_data_found then
                -- колонку в исходной таблице не нашли, в списки колонок включать не будем
                l_include := false;
                --
                logger.warning('Колонка '||t.column_name||' не найдена в исходной таблице KF'||l_kf||'.'||l_table);
                --
            end;
            --
            if l_include
            then
                begin
                    select case p.table_name
                           when 'ACCOUNTS'      then 'GetNewAcc('''||l_kf||''','||c.column_name||')'
                           when 'CUSTOMER'      then 'GetNewRnk('''||l_kf||''','||c.column_name||')'
                           when 'STAFF$BASE'    then case p.constraint_type
                                                     when 'P' then 'GetNewUserid('''||l_kf||''','||c.column_name||')'
                                                     when 'U' then 'GetNewUsername('''||l_kf||''','||c.column_name||')'
                                                     end
                           when 'TTS'           then 'GetNewTT('''||l_kf||''','||c.column_name||')'
                           when 'BRANCH'        then 'GetNewBranch('''||l_kf||''','||c.column_name||')'
                           when 'ARC_RRP'       then 'rukey('||c.column_name||')'
                           when 'OPER'          then 'rukey('||c.column_name||')'
                           when 'OTDEL'         then 'rukey('||c.column_name||')'
                           when 'ZAPROS'        then 'rukey('||c.column_name||')'
                           when 'REPORTS'       then 'rukey('||c.column_name||')'
                           else c.column_name
                           end as replace_func
                      into l_col
                      from user_cons_columns c, user_constraints s, user_constraints p
                     where c.table_name=l_table
                       and c.column_name=t.column_name
                       and c.owner=s.owner
                       and c.constraint_name=s.constraint_name
                       and s.constraint_type='R'
                       and s.r_owner=p.owner
                       and s.r_constraint_name=p.constraint_name
                       and p.constraint_type in ('P','U');
                exception
                    when no_data_found then
                        l_col := t.column_name;
                        -- спец.обработка поля STMT типа NUMBER: его тоже перекодируем
                        if t.column_name='STMT' and t.data_type='NUMBER'
                        then
                            l_col := 'rukey('||t.column_name||')';
                        end if;
                end;

                --
                if t.nullable='N' and l_nullable='Y' and t.data_default is not null
                then
                    trace('подмена not null колонки %s', t.column_name);
                    l_datadefault := t.data_default;
                    l_col := 'nvl2('||t.column_name||', '||l_col||', '||l_datadefault||')';
                    trace('l_col = %s', l_col);
                end if;
                --
                l_ins_cols := l_ins_cols || case when l_ins_cols is null then null else ', ' end || t.column_name;
                -- подменяем колонку, если просят
                if l_colrep.exists(l_col)
                then
                    trace('подменяем колонку %s на выражение %s', l_col, l_colrep(l_col));
                    l_col := l_colrep(l_col);
                end if;
                --
                l_sel_cols := l_sel_cols || case when l_sel_cols is null then null else ', ' end || l_col;
                --
            end if;
            --
        end loop;
    end;    
    end if;
    --
    l_stmt :=   'insert'||chr(10)
              ||'  into '||l_table||' ('||l_ins_cols||')'||chr(10)
              ||'select '||l_sel_cols||chr(10)
              ||'  from '||pkf(l_table);
    --
    --trace(l_stmt);
    -- зовем младшего брата
    sync_table(l_table, l_stmt, p_delete);
    --
    trace('%s: finish point', p);
    --
  end sync_table_auto;

------------------------------------------------------------
------------------------------------------------------------  
  
/*  procedure sync_table_auto(
    p_table varchar2,
    p_delete boolean default false,
    p_column_replace varchar2 default null
  )
  is
    p          constant varchar2(62) := G_PKG||'.sync_table_auto';
    l_table    varchar2(30) := upper(p_table);
    l_stmt     varchar2(4000);
    l_ins_cols varchar2(4000);
    l_sel_cols varchar2(4000);
    l_col      varchar2(256);
    l_kf       varchar2(6);
    l_include       boolean;
    l_tab_exists    number;
    l_tab_length    BINARY_INTEGER;
    l_array         DBMS_UTILITY.lname_array;
    type t_colrep is table of varchar2(4000) index by varchar2(30);
    l_colrep        t_colrep;
    l_index         pls_integer;
    l_column        varchar2(30);
    l_replace       varchar2(4000);
    l_nullable      varchar2(1);
    l_datadefault   varchar2(1024);
  begin
    --
    trace('%s(''%s'',%s): entry point', p, p_table, case when p_delete then 'true' else 'false' end);
    --
    l_kf := get_kf();
    -- посмотрим существует ли исходная таблица
    begin
        select 1
          into l_tab_exists
          from all_tables
         where owner='KF'||l_kf
           and table_name=l_table;
    exception
        when no_data_found then
            l_tab_exists := 0;
    end;
    --
    if l_tab_exists=0
    then
        raise_application_error(-20000, 'Таблица KF'||l_kf||'.'||l_table||' не существует. Импорт не выполняем.');
    end if;
    --
    -- обрабатываем p_column_replace
    --
    if p_column_replace is not null
    then
        dbms_utility.comma_to_table(
            list    => p_column_replace,
            tablen  => l_tab_length,
            tab     => l_array
        );
        l_index := 1;
        while l_index < l_tab_length
        loop
            l_column := upper(trim(l_array(l_index)));
            l_replace := trim(l_array(l_index+1));
            if l_replace like '"%"'
            then
                l_replace := substr(l_replace, 2, length(l_replace)-2);
            end if;
            l_colrep(l_column) := l_replace;
            trace('Колонка %s будет заменена на выражение %s', l_column, l_replace);
            l_index := l_index + 2;
        end loop;
    end if;
    --
    -- формируем sql-выражение для вставки
    -- список колонок с автозаменой
    for t in (select *
                from user_tab_columns
               where table_name=l_table
                 --and column_name not in ('KF','BRANCH')
                 and column_name <> 'KF' --поле BRANCH мигрируем с теми данными какие есть в РУ
               order by column_id
             )
    loop
        --trace('обрыбатываем колонку '||t.column_name);
        -- ищем аналогичную колонку в исходной таблице kf<mfo>.table_name
        begin
            select column_name, nullable
              into l_col, l_nullable
              from all_tab_columns
             where owner='KF'||l_kf
               and table_name=l_table
               and column_name=t.column_name;
            --
            l_include := true;
        exception
            when no_data_found then
            -- колонку в исходной таблице не нашли, в списки колонок включать не будем
            l_include := false;
            --
            logger.warning('Колонка '||t.column_name||' не найдена в исходной таблице KF'||l_kf||'.'||l_table);
            --
        end;
        --
        if l_include
        then
            begin
                select case p.table_name
                       when 'ACCOUNTS'      then 'GetNewAcc('''||l_kf||''','||c.column_name||')'
                       when 'CUSTOMER'      then 'GetNewRnk('''||l_kf||''','||c.column_name||')'
                       when 'STAFF$BASE'    then case p.constraint_type
                                                 when 'P' then 'GetNewUserid('''||l_kf||''','||c.column_name||')'
                                                 when 'U' then 'GetNewUsername('''||l_kf||''','||c.column_name||')'
                                                 end
                       when 'TTS'           then 'GetNewTT('''||l_kf||''','||c.column_name||')'
                       when 'BRANCH'        then 'GetNewBranch('''||l_kf||''','||c.column_name||')'
                       when 'ARC_RRP'       then 'rukey('||c.column_name||')'
                       when 'OPER'          then 'rukey('||c.column_name||')'
                       when 'OTDEL'         then 'rukey('||c.column_name||')'
                       when 'ZAPROS'        then 'rukey('||c.column_name||')'
                       when 'REPORTS'       then 'rukey('||c.column_name||')'
                       else c.column_name
                       end as replace_func
                  into l_col
                  from user_cons_columns c, user_constraints s, user_constraints p
                 where c.table_name=l_table
                   and c.column_name=t.column_name
                   and c.owner=s.owner
                   and c.constraint_name=s.constraint_name
                   and s.constraint_type='R'
                   and s.r_owner=p.owner
                   and s.r_constraint_name=p.constraint_name
                   and p.constraint_type in ('P','U');
            exception
                when no_data_found then
                    l_col := t.column_name;
                    -- спец.обработка поля STMT типа NUMBER: его тоже перекодируем
                    if t.column_name='STMT' and t.data_type='NUMBER'
                    then
                        l_col := 'rukey('||t.column_name||')';
                    end if;
            end;

            --
            if t.nullable='N' and l_nullable='Y' and t.data_default is not null
            then
                trace('подмена not null колонки %s', t.column_name);
                l_datadefault := t.data_default;
                l_col := 'nvl2('||t.column_name||', '||l_col||', '||l_datadefault||')';
                trace('l_col = %s', l_col);
            end if;
            --
            l_ins_cols := l_ins_cols || case when l_ins_cols is null then null else ', ' end || t.column_name;
            -- подменяем колонку, если просят
            if l_colrep.exists(l_col)
            then
                trace('подменяем колонку %s на выражение %s', l_col, l_colrep(l_col));
                l_col := l_colrep(l_col);
            end if;
            --
            l_sel_cols := l_sel_cols || case when l_sel_cols is null then null else ', ' end || l_col;
            --
        end if;
        --
    end loop;
    --
    l_stmt :=   'insert'||chr(10)
              ||'  into '||l_table||' ('||l_ins_cols||')'||chr(10)
              ||'select '||l_sel_cols||chr(10)
              ||'  from '||pkf(l_table);
    --
    --trace(l_stmt);
    -- зовем младшего брата
    sync_table(l_table, l_stmt, p_delete);
    --
    trace('%s: finish point', p);
    --
  end sync_table_auto;*/

  ----
  -- tabsync - вызов sync_table_auto(p_table, true)
  --
  procedure tabsync(p_table varchar2)
  is
  begin
    sync_table_auto(p_table, true);
  end tabsync;

  ----
  -- gather_index_stats
  --
  procedure gather_index_stats
    (ownname varchar2, indname varchar2, partname varchar2 default null,
     estimate_percent number default dbms_stats.DEFAULT_ESTIMATE_PERCENT,
     stattab varchar2 default null, statid varchar2 default null,
     statown varchar2 default null,
     degree number default dbms_stats.to_degree_type(dbms_stats.get_param('DEGREE')),
     granularity varchar2 default dbms_stats.DEFAULT_GRANULARITY,
     no_invalidate boolean default
       dbms_stats.to_no_invalidate_type(dbms_stats.get_param('NO_INVALIDATE')),
     stattype varchar2 default 'DATA',
     force boolean default FALSE)
  is
  begin
    if get_mgr_stat()='Y'
    then
        dbms_stats.gather_index_stats(
           ownname, indname, partname, estimate_percent, stattab, statid,
           statown, degree, granularity, no_invalidate, stattype, force
        );
    end if;
  end gather_index_stats;

  ----
  -- gather_table_stats
  --
  procedure gather_table_stats
    (ownname varchar2, tabname varchar2, partname varchar2 default null,
     estimate_percent number default dbms_stats.DEFAULT_ESTIMATE_PERCENT,
     block_sample boolean default FALSE,
     method_opt varchar2 default dbms_stats.DEFAULT_METHOD_OPT,
     degree number default dbms_stats.to_degree_type(dbms_stats.get_param('DEGREE')),
     granularity varchar2 default  dbms_stats.DEFAULT_GRANULARITY,
     cascade boolean default dbms_stats.DEFAULT_CASCADE,
     stattab varchar2 default null, statid varchar2 default null,
     statown varchar2 default null,
     no_invalidate boolean default
       dbms_stats.to_no_invalidate_type(dbms_stats.get_param('NO_INVALIDATE')),
     stattype varchar2 default 'DATA',
     force boolean default FALSE,
     -- the context is intended for internal use only.
     context dbms_stats.CContext default null)
  is
  begin
    if get_mgr_stat()='Y'
    then
        dbms_stats.gather_table_stats(
             ownname, tabname, partname, estimate_percent, block_sample,
             method_opt, degree, granularity, cascade, stattab, statid,
             statown, no_invalidate, stattype, force, context
        );
    end if;
  end gather_table_stats;

  ----
  -- get_rowcount - возвращает кол-во строк в таблице p_table
  --
  function get_rowcount(p_table in varchar2)
  return number deterministic
  is
    l_rowcount  number;
  begin
    execute immediate
    'select count(*) from '||p_table
    into l_rowcount;
    --
    return l_rowcount;
    --
  end get_rowcount;

  ----
  -- get_errinfo - возвращает описание типовых ошибок в таблице err$_*
  --
  function get_errinfo(p_errtable in varchar2)
  return varchar2
  is
    l_errinfo varchar2(1000);
    l_errnums   dbms_sql.number_table;
    l_errmsgs   dbms_sql.varchar2_table;
    l_cnts      dbms_sql.number_table;
  begin
    execute immediate
    'select *
       from (select ora_err_number$, ora_err_mesg$, count(*) cnt
               from '||p_errtable||'
              group by rollup((ora_err_number$, ora_err_mesg$))
              order by 3 desc, 1 desc
            )
      where rownum <= 4'
    bulk collect into l_errnums, l_errmsgs, l_cnts;
    --
    for i in 1..l_cnts.count
    loop
        --
        l_errinfo := l_errinfo || chr(10) ||
        case
        when l_errnums(i) is null then 'Всего ошибок: '||lpad(to_char(l_cnts(i)),5)
        else 'ORA-'||lpad(to_char(l_errnums(i)),5,'0')||': '||substr(l_errmsgs(i),1,50)
           ||'    '||lpad(to_char(l_cnts(i)),5)
        end
        ;
    end loop;
    --
    return l_errinfo;
    --
  end get_errinfo;

  ----
  -- mantain_error_table - создает/очищает таблицу ошибок err$_<p_table>
  --
  procedure mantain_error_table(p_table in varchar2)
  is  
      unsup_col_tp_fnd exception;
      pragma exception_init (unsup_col_tp_fnd, -20069);--ORA-20069: Unsupported column type(s) found               
      p constant varchar2(61) := G_PKG||'.'||'manerrtab';
      l_table       varchar2(30) := upper(p_table);
      l_errtable    varchar2(30) := 'ERR$_'||substr(l_table,1,25);
      l_num         number;
      
  begin
      --
      logger.trace('%s: start', p);
      --
      begin
        select 1
          into l_num
          from user_tables
         where table_name=l_errtable;
        --
        execute immediate 'truncate table '||l_errtable;
        logger.trace('%s: table %s truncated', p, l_errtable);
      exception
        when no_data_found then
             dbms_errlog.create_error_log(l_table);
             logger.trace('%s: table %s created', p, l_errtable);
        when unsup_col_tp_fnd then mgr_utl.save_error();
      end;
      --
      logger.trace('%s: finish', p);
      --
  end mantain_error_table;


  ----
  -- init_kf2ru_map - инициализирует массив по таблице kf_ru
  --
  procedure init_kf2ru_map
  is
  begin
    for c in (select * from kf_ru)
    loop
        g_kf2ru_map(c.kf) := c.ru;
    end loop;
    --
    g_kf2ru_map('/') := '00';
    --
  end init_kf2ru_map;

  ----
  -- make_key - порождает новый ключ со старого путем добавления кода RU в хвост
  --
  function make_key(p_key number, p_kf varchar2) return number
  is
  begin
    --
    return to_number(make_key(to_char(p_key), p_kf));
    --
  end;

  ----
  -- make_key - порождает новый ключ со старого путем добавления кода RU в хвост
  --
  function make_key(p_key varchar2, p_kf varchar2) return varchar2
  is
  begin
    if g_kf2ru_map_init is null
    then
        init_kf2ru_map();
        g_kf2ru_map_init := true;
    end if;
    --
    return p_key||g_kf2ru_map(nvl(p_kf,'/'));
    --
  end;

  ----
  -- rukey - возвращает новый ключ <p_key>||g_ru
  --
  function rukey(p_key varchar2)
  return varchar2
  is

  begin
   begin

       if p_key <=0 then return p_key;
       elsif p_key is null then return null;
       else return p_key||get_ru();
        end if;
    exception when others then
        if sqlcode=(-6502) then return p_key||get_ru();
        else raise; end if;

   end;
  end rukey;

  ----
  -- ruuser - возвращает новый ключ по пользователям с учетом исключений
  --
  function ruuser(p_user varchar2)
  return varchar2
  is
  begin
    if p_user in ('DUMMY','BARS','RS_DUMP','JBOSS_USR','QOWNER','1')
    then
        return p_user;
    else
        return rukey(p_user);
    end if;
  end ruuser;

    ----------------------------------------------------------------------------
    -- get_table_fields  - возвращает список полей таблицы через запятую
    --
    function get_table_fields(p_table varchar2, p_prefix varchar2, p_suffix varchar2)
    return varchar2
    is
    l_uptable   varchar2(61) := upper(p_table);
    l_owner     varchar2(30) := substr(l_uptable, 1, instr(l_uptable,'.')-1);
    l_table     varchar2(30) := substr(l_uptable, instr(l_uptable,'.')+1);
    l_fields    varchar2(32767);
    begin
        select max( sys_connect_by_path(p_prefix||column_name||' as '||column_name||'_'||p_suffix, ',')) into l_fields
        from (
               select column_name, row_number() over (order by column_id) as num
                 from all_tab_columns
                where owner=l_owner
                  and table_name=l_table
             )
        connect by  prior num = num-1
        start with num = 1;
        return substr(l_fields, 2);
    end get_table_fields;

  ----
  -- tabdiff - создает протокол расхождения таблиц
  --
  procedure tabdiff(
    p_table_a varchar2,
    p_table_b varchar2,
    p_key_1   varchar2,
    p_key_2   varchar2 default null,
    p_key_3   varchar2 default null,
    p_col_1   varchar2,
    p_col_2   varchar2 default null,
    p_col_3   varchar2 default null,
    p_col_4   varchar2 default null,
    p_col_5   varchar2 default null,
    p_col_6   varchar2 default null,
    p_col_7   varchar2 default null,
    p_col_8   varchar2 default null,
    p_col_9   varchar2 default null,
    p_col_10  varchar2 default null,
    p_col_11  varchar2 default null,
    p_col_12  varchar2 default null,
    p_col_13  varchar2 default null,
    p_col_14  varchar2 default null,
    p_col_15  varchar2 default null,
    p_col_16  varchar2 default null,
    p_col_17  varchar2 default null,
    p_col_18  varchar2 default null,
    p_col_19  varchar2 default null,
    p_col_20  varchar2 default null,
    p_col_21  varchar2 default null,
    p_col_22  varchar2 default null,
    p_col_23  varchar2 default null,
    p_col_24  varchar2 default null,
    p_col_25  varchar2 default null,
    p_col_26  varchar2 default null,
    p_col_27  varchar2 default null,
    p_col_28  varchar2 default null,
    p_col_29  varchar2 default null,
    p_col_30  varchar2 default null,
    p_col_31  varchar2 default null,
    p_col_32  varchar2 default null,
    p_col_33  varchar2 default null,
    p_col_34  varchar2 default null,
    p_col_35  varchar2 default null,
    p_col_36  varchar2 default null,
    p_col_37  varchar2 default null,
    p_col_38  varchar2 default null,
    p_col_39  varchar2 default null,
    p_col_clob_1 varchar2  default null,
    p_col_clob_2 varchar2  default null,
    p_col_clob_3 varchar2  default null
  )
  is
    l_stmt          clob;
    l_num           number;
    -- результат будем писать в таблицу DIFF_<TABLE>_<KF>, н-р: DIFF_ZAPROS_399131
    l_uptable       varchar2(61) := upper(p_table_a);
    l_nstable       varchar2(30) := substr(l_uptable, instr(l_uptable,'.')+1);
    l_diff_table    varchar2(30) := 'DIFF_'||substr(l_nstable,1,18)||'_'||g_kf;
  begin
    trace('diff_table = ''%s''', l_diff_table);
    -- проверим наличие таблицы
    begin
        select 1
          into l_num
          from user_tables
         where table_name = l_diff_table;
        --
        raise_application_error(-20000,
            'Протокольная таблица '||l_diff_table||'. уже существует.'||chr(10)
          ||'Удалите таблицу для повторного наполнения.'||chr(10)
          ||'При этом Вы потеряете выполненный ранее анализ расхождений!'
        );
        --
    exception when no_data_found then
        null;
    end;
    l_stmt :=
      'create table '||l_diff_table||chr(10)
    ||'as'||chr(10)
    ||'select '||chr(10)
         ||''' '' as diff_result'||chr(10)
         ||',rpad('' '',128,'' '') as diff_comment'||chr(10)
         ||','''||p_table_a||''' as source_table'||chr(10)
         ||','''||p_table_b||''' as target_table'||chr(10)
         ||case when p_key_1 is not null then ',a.'||p_key_1||chr(10) else '' end
         ||case when p_key_2 is not null then ',a.'||p_key_2||chr(10) else '' end
         ||case when p_key_3 is not null then ',a.'||p_key_3||chr(10) else '' end
         ||case when p_col_1 is not null then
         ',case when nvl(to_char(a.'||p_col_1||'),''null'') <> nvl(to_char(b.'||p_col_1||'),''null'') then
           nvl(to_char(a.'||p_col_1||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_1||'),''null'') else null end as diff_'||p_col_1||chr(10)
         else null end
         ||case when p_col_2 is not null then
         ',case when nvl(to_char(a.'||p_col_2||'),''null'') <> nvl(to_char(b.'||p_col_2||'),''null'') then
           nvl(to_char(a.'||p_col_2||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_2||'),''null'') else null end as diff_'||p_col_2||chr(10)
         else null end
         ||case when p_col_3 is not null then
         ',case when nvl(to_char(a.'||p_col_3||'),''null'') <> nvl(to_char(b.'||p_col_3||'),''null'') then
           nvl(to_char(a.'||p_col_3||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_3||'),''null'') else null end as diff_'||p_col_3||chr(10)
         else null end
         ||case when p_col_4 is not null then
         ',case when nvl(to_char(a.'||p_col_4||'),''null'') <> nvl(to_char(b.'||p_col_4||'),''null'') then
           nvl(to_char(a.'||p_col_4||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_4||'),''null'') else null end as diff_'||p_col_4||chr(10)
         else null end
         ||case when p_col_5 is not null then
         ',case when nvl(to_char(a.'||p_col_5||'),''null'') <> nvl(to_char(b.'||p_col_5||'),''null'') then
           nvl(to_char(a.'||p_col_5||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_5||'),''null'') else null end as diff_'||p_col_5||chr(10)
         else null end
         ||case when p_col_6 is not null then
         ',case when nvl(to_char(a.'||p_col_6||'),''null'') <> nvl(to_char(b.'||p_col_6||'),''null'') then
           nvl(to_char(a.'||p_col_6||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_6||'),''null'') else null end as diff_'||p_col_6||chr(10)
         else null end
         ||case when p_col_7 is not null then
         ',case when nvl(to_char(a.'||p_col_7||'),''null'') <> nvl(to_char(b.'||p_col_7||'),''null'') then
           nvl(to_char(a.'||p_col_7||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_7||'),''null'') else null end as diff_'||p_col_7||chr(10)
         else null end
         ||case when p_col_8 is not null then
         ',case when nvl(to_char(a.'||p_col_8||'),''null'') <> nvl(to_char(b.'||p_col_8||'),''null'') then
           nvl(to_char(a.'||p_col_8||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_8||'),''null'') else null end as diff_'||p_col_8||chr(10)
         else null end
         ||case when p_col_9 is not null then
         ',case when nvl(to_char(a.'||p_col_9||'),''null'') <> nvl(to_char(b.'||p_col_9||'),''null'') then
           nvl(to_char(a.'||p_col_9||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_9||'),''null'') else null end as diff_'||p_col_9||chr(10)
         else null end
         ||case when p_col_10 is not null then
         ',case when nvl(to_char(a.'||p_col_10||'),''null'') <> nvl(to_char(b.'||p_col_10||'),''null'') then
           nvl(to_char(a.'||p_col_10||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_10||'),''null'') else null end as diff_'||p_col_10||chr(10)
         else null end
         ||case when p_col_11 is not null then
         ',case when nvl(to_char(a.'||p_col_11||'),''null'') <> nvl(to_char(b.'||p_col_11||'),''null'') then
           nvl(to_char(a.'||p_col_11||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_11||'),''null'') else null end as diff_'||p_col_11||chr(10)
         else null end
         ||case when p_col_12 is not null then
         ',case when nvl(to_char(a.'||p_col_12||'),''null'') <> nvl(to_char(b.'||p_col_12||'),''null'') then
           nvl(to_char(a.'||p_col_12||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_12||'),''null'') else null end as diff_'||p_col_12||chr(10)
         else null end
         ||case when p_col_13 is not null then
         ',case when nvl(to_char(a.'||p_col_13||'),''null'') <> nvl(to_char(b.'||p_col_13||'),''null'') then
           nvl(to_char(a.'||p_col_13||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_13||'),''null'') else null end as diff_'||p_col_13||chr(10)
         else null end
         ||case when p_col_14 is not null then
         ',case when nvl(to_char(a.'||p_col_14||'),''null'') <> nvl(to_char(b.'||p_col_14||'),''null'') then
           nvl(to_char(a.'||p_col_14||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_14||'),''null'') else null end as diff_'||p_col_14||chr(10)
         else null end
         ||case when p_col_15 is not null then
         ',case when nvl(to_char(a.'||p_col_15||'),''null'') <> nvl(to_char(b.'||p_col_15||'),''null'') then
           nvl(to_char(a.'||p_col_15||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_15||'),''null'') else null end as diff_'||p_col_15||chr(10)
         else null end
         ||case when p_col_16 is not null then
         ',case when nvl(to_char(a.'||p_col_16||'),''null'') <> nvl(to_char(b.'||p_col_16||'),''null'') then
           nvl(to_char(a.'||p_col_16||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_16||'),''null'') else null end as diff_'||p_col_16||chr(10)
         else null end
         ||case when p_col_17 is not null then
         ',case when nvl(to_char(a.'||p_col_17||'),''null'') <> nvl(to_char(b.'||p_col_17||'),''null'') then
           nvl(to_char(a.'||p_col_17||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_17||'),''null'') else null end as diff_'||p_col_17||chr(10)
         else null end
         ||case when p_col_18 is not null then
         ',case when nvl(to_char(a.'||p_col_18||'),''null'') <> nvl(to_char(b.'||p_col_18||'),''null'') then
           nvl(to_char(a.'||p_col_18||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_18||'),''null'') else null end as diff_'||p_col_18||chr(10)
         else null end
         ||case when p_col_19 is not null then
         ',case when nvl(to_char(a.'||p_col_19||'),''null'') <> nvl(to_char(b.'||p_col_19||'),''null'') then
           nvl(to_char(a.'||p_col_19||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_19||'),''null'') else null end as diff_'||p_col_19||chr(10)
         else null end
         ||case when p_col_20 is not null then
         ',case when nvl(to_char(a.'||p_col_20||'),''null'') <> nvl(to_char(b.'||p_col_20||'),''null'') then
           nvl(to_char(a.'||p_col_20||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_20||'),''null'') else null end as diff_'||p_col_20||chr(10)
         else null end
         ||case when p_col_21 is not null then
         ',case when nvl(to_char(a.'||p_col_21||'),''null'') <> nvl(to_char(b.'||p_col_21||'),''null'') then
           nvl(to_char(a.'||p_col_21||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_21||'),''null'') else null end as diff_'||p_col_21||chr(10)
         else null end
         ||case when p_col_22 is not null then
         ',case when nvl(to_char(a.'||p_col_22||'),''null'') <> nvl(to_char(b.'||p_col_22||'),''null'') then
           nvl(to_char(a.'||p_col_22||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_22||'),''null'') else null end as diff_'||p_col_22||chr(10)
         else null end
         ||case when p_col_23 is not null then
         ',case when nvl(to_char(a.'||p_col_23||'),''null'') <> nvl(to_char(b.'||p_col_23||'),''null'') then
           nvl(to_char(a.'||p_col_23||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_23||'),''null'') else null end as diff_'||p_col_23||chr(10)
         else null end
         ||case when p_col_24 is not null then
         ',case when nvl(to_char(a.'||p_col_24||'),''null'') <> nvl(to_char(b.'||p_col_24||'),''null'') then
           nvl(to_char(a.'||p_col_24||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_24||'),''null'') else null end as diff_'||p_col_24||chr(10)
         else null end
         ||case when p_col_25 is not null then
         ',case when nvl(to_char(a.'||p_col_25||'),''null'') <> nvl(to_char(b.'||p_col_25||'),''null'') then
           nvl(to_char(a.'||p_col_25||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_25||'),''null'') else null end as diff_'||p_col_25||chr(10)
         else null end
         ||case when p_col_26 is not null then
         ',case when nvl(to_char(a.'||p_col_26||'),''null'') <> nvl(to_char(b.'||p_col_26||'),''null'') then
           nvl(to_char(a.'||p_col_26||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_26||'),''null'') else null end as diff_'||p_col_26||chr(10)
         else null end
         ||case when p_col_27 is not null then
         ',case when nvl(to_char(a.'||p_col_27||'),''null'') <> nvl(to_char(b.'||p_col_27||'),''null'') then
           nvl(to_char(a.'||p_col_27||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_27||'),''null'') else null end as diff_'||p_col_27||chr(10)
         else null end
         ||case when p_col_28 is not null then
         ',case when nvl(to_char(a.'||p_col_28||'),''null'') <> nvl(to_char(b.'||p_col_28||'),''null'') then
           nvl(to_char(a.'||p_col_28||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_28||'),''null'') else null end as diff_'||p_col_28||chr(10)
         else null end
         ||case when p_col_29 is not null then
         ',case when nvl(to_char(a.'||p_col_29||'),''null'') <> nvl(to_char(b.'||p_col_29||'),''null'') then
           nvl(to_char(a.'||p_col_29||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_29||'),''null'') else null end as diff_'||p_col_29||chr(10)
         else null end
         ||case when p_col_30 is not null then
         ',case when nvl(to_char(a.'||p_col_30||'),''null'') <> nvl(to_char(b.'||p_col_30||'),''null'') then
           nvl(to_char(a.'||p_col_30||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_30||'),''null'') else null end as diff_'||p_col_30||chr(10)
         else null end
         ||case when p_col_31 is not null then
         ',case when nvl(to_char(a.'||p_col_31||'),''null'') <> nvl(to_char(b.'||p_col_31||'),''null'') then
           nvl(to_char(a.'||p_col_31||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_31||'),''null'') else null end as diff_'||p_col_31||chr(10)
         else null end
         ||case when p_col_32 is not null then
         ',case when nvl(to_char(a.'||p_col_32||'),''null'') <> nvl(to_char(b.'||p_col_32||'),''null'') then
           nvl(to_char(a.'||p_col_32||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_32||'),''null'') else null end as diff_'||p_col_32||chr(10)
         else null end
         ||case when p_col_33 is not null then
         ',case when nvl(to_char(a.'||p_col_33||'),''null'') <> nvl(to_char(b.'||p_col_33||'),''null'') then
           nvl(to_char(a.'||p_col_33||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_33||'),''null'') else null end as diff_'||p_col_33||chr(10)
         else null end
         ||case when p_col_34 is not null then
         ',case when nvl(to_char(a.'||p_col_34||'),''null'') <> nvl(to_char(b.'||p_col_34||'),''null'') then
           nvl(to_char(a.'||p_col_34||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_34||'),''null'') else null end as diff_'||p_col_34||chr(10)
         else null end
         ||case when p_col_35 is not null then
         ',case when nvl(to_char(a.'||p_col_35||'),''null'') <> nvl(to_char(b.'||p_col_35||'),''null'') then
           nvl(to_char(a.'||p_col_35||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_35||'),''null'') else null end as diff_'||p_col_35||chr(10)
         else null end
         ||case when p_col_36 is not null then
         ',case when nvl(to_char(a.'||p_col_36||'),''null'') <> nvl(to_char(b.'||p_col_36||'),''null'') then
           nvl(to_char(a.'||p_col_36||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_36||'),''null'') else null end as diff_'||p_col_36||chr(10)
         else null end
         ||case when p_col_37 is not null then
         ',case when nvl(to_char(a.'||p_col_37||'),''null'') <> nvl(to_char(b.'||p_col_37||'),''null'') then
           nvl(to_char(a.'||p_col_37||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_37||'),''null'') else null end as diff_'||p_col_37||chr(10)
         else null end
         ||case when p_col_38 is not null then
         ',case when nvl(to_char(a.'||p_col_38||'),''null'') <> nvl(to_char(b.'||p_col_38||'),''null'') then
           nvl(to_char(a.'||p_col_38||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_38||'),''null'') else null end as diff_'||p_col_38||chr(10)
         else null end
         ||case when p_col_39 is not null then
         ',case when nvl(to_char(a.'||p_col_39||'),''null'') <> nvl(to_char(b.'||p_col_39||'),''null'') then
           nvl(to_char(a.'||p_col_39||'),''null'')||chr(10)||nvl(to_char(b.'||p_col_39||'),''null'') else null end as diff_'||p_col_39||chr(10)
         else null end
         -- clob columns
         ||case when p_col_clob_1 is not null then
           ',case when dbms_lob.compare(nvl(a.'||p_col_clob_1||',to_clob(''null'')), nvl(b.'||p_col_clob_1||',to_clob(''null'')))<>0 then
             nvl(a.'||p_col_clob_1||',to_clob(''null''))
             ||chr(10)||''--------------------------------------------------------------------------------------------------------------''||chr(10)
             ||nvl(b.'||p_col_clob_1||',to_clob(''null'')) else null end as diff_'||p_col_clob_1||chr(10)
          else ''
          end
        ||case when p_col_clob_2 is not null then
           ',case when dbms_lob.compare(nvl(a.'||p_col_clob_2||',to_clob(''null'')), nvl(b.'||p_col_clob_2||',to_clob(''null'')))<>0 then
             nvl(a.'||p_col_clob_2||',to_clob(''null''))
             ||chr(10)||''--------------------------------------------------------------------------------------------------------------''||chr(10)
             ||nvl(b.'||p_col_clob_2||',to_clob(''null'')) else null end as diff_'||p_col_clob_2||chr(10)
          else ''
          end
        ||case when p_col_clob_3 is not null then
           ',case when dbms_lob.compare(nvl(a.'||p_col_clob_3||',to_clob(''null'')), nvl(b.'||p_col_clob_3||',to_clob(''null'')))<>0 then
             nvl(a.'||p_col_clob_3||',to_clob(''null''))
             ||chr(10)||''--------------------------------------------------------------------------------------------------------------''||chr(10)
             ||nvl(b.'||p_col_clob_3||',to_clob(''null'')) else null end as diff_'||p_col_clob_3||chr(10)
          else ''
          end
    ||','||get_table_fields(p_table_a, 'a.', 'A')||chr(10)
    ||','||get_table_fields(p_table_b, 'b.', 'B')||chr(10)
    ||'  from '||p_table_a||' a, '||p_table_b||' b '||chr(10)
    ||' where a.'||p_key_1||'=b.'||p_key_1||'(+)'||chr(10)
    ||case when p_key_2 is not null then 'and a.'||p_key_2||'=b.'||p_key_2||'(+)'||chr(10) else '' end
    ||case when p_key_3 is not null then 'and a.'||p_key_3||'=b.'||p_key_3||'(+)'||chr(10) else '' end
    ||' and ('||chr(10)
              ||'nvl(to_char(a.'||p_col_1||'),''null'') <> nvl(to_char(b.'||p_col_1||'),''null'')'||chr(10)
    ||case when p_col_2 is not null then
           ' or nvl(to_char(a.'||p_col_2||'),''null'') <> nvl(to_char(b.'||p_col_2||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_3 is not null then
           ' or nvl(to_char(a.'||p_col_3||'),''null'') <> nvl(to_char(b.'||p_col_3||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_4 is not null then
           ' or nvl(to_char(a.'||p_col_4||'),''null'') <> nvl(to_char(b.'||p_col_4||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_5 is not null then
           ' or nvl(to_char(a.'||p_col_5||'),''null'') <> nvl(to_char(b.'||p_col_5||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_6 is not null then
           ' or nvl(to_char(a.'||p_col_6||'),''null'') <> nvl(to_char(b.'||p_col_6||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_7 is not null then
           ' or nvl(to_char(a.'||p_col_7||'),''null'') <> nvl(to_char(b.'||p_col_7||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_8 is not null then
           ' or nvl(to_char(a.'||p_col_8||'),''null'') <> nvl(to_char(b.'||p_col_8||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_9 is not null then
           ' or nvl(to_char(a.'||p_col_9||'),''null'') <> nvl(to_char(b.'||p_col_9||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_10 is not null then
           ' or nvl(to_char(a.'||p_col_10||'),''null'') <> nvl(to_char(b.'||p_col_10||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_11 is not null then
           ' or nvl(to_char(a.'||p_col_11||'),''null'') <> nvl(to_char(b.'||p_col_11||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_12 is not null then
           ' or nvl(to_char(a.'||p_col_12||'),''null'') <> nvl(to_char(b.'||p_col_12||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_13 is not null then
           ' or nvl(to_char(a.'||p_col_13||'),''null'') <> nvl(to_char(b.'||p_col_13||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_14 is not null then
           ' or nvl(to_char(a.'||p_col_14||'),''null'') <> nvl(to_char(b.'||p_col_14||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_15 is not null then
           ' or nvl(to_char(a.'||p_col_15||'),''null'') <> nvl(to_char(b.'||p_col_15||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_16 is not null then
           ' or nvl(to_char(a.'||p_col_16||'),''null'') <> nvl(to_char(b.'||p_col_16||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_17 is not null then
           ' or nvl(to_char(a.'||p_col_17||'),''null'') <> nvl(to_char(b.'||p_col_17||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_18 is not null then
           ' or nvl(to_char(a.'||p_col_18||'),''null'') <> nvl(to_char(b.'||p_col_18||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_19 is not null then
           ' or nvl(to_char(a.'||p_col_19||'),''null'') <> nvl(to_char(b.'||p_col_19||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_20 is not null then
           ' or nvl(to_char(a.'||p_col_20||'),''null'') <> nvl(to_char(b.'||p_col_20||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_21 is not null then
           ' or nvl(to_char(a.'||p_col_21||'),''null'') <> nvl(to_char(b.'||p_col_21||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_22 is not null then
           ' or nvl(to_char(a.'||p_col_22||'),''null'') <> nvl(to_char(b.'||p_col_22||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_23 is not null then
           ' or nvl(to_char(a.'||p_col_23||'),''null'') <> nvl(to_char(b.'||p_col_23||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_24 is not null then
           ' or nvl(to_char(a.'||p_col_24||'),''null'') <> nvl(to_char(b.'||p_col_24||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_25 is not null then
           ' or nvl(to_char(a.'||p_col_25||'),''null'') <> nvl(to_char(b.'||p_col_25||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_26 is not null then
           ' or nvl(to_char(a.'||p_col_26||'),''null'') <> nvl(to_char(b.'||p_col_26||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_27 is not null then
           ' or nvl(to_char(a.'||p_col_27||'),''null'') <> nvl(to_char(b.'||p_col_27||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_28 is not null then
           ' or nvl(to_char(a.'||p_col_28||'),''null'') <> nvl(to_char(b.'||p_col_28||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_29 is not null then
           ' or nvl(to_char(a.'||p_col_29||'),''null'') <> nvl(to_char(b.'||p_col_29||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_30 is not null then
           ' or nvl(to_char(a.'||p_col_30||'),''null'') <> nvl(to_char(b.'||p_col_30||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_31 is not null then
           ' or nvl(to_char(a.'||p_col_31||'),''null'') <> nvl(to_char(b.'||p_col_31||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_32 is not null then
           ' or nvl(to_char(a.'||p_col_32||'),''null'') <> nvl(to_char(b.'||p_col_32||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_33 is not null then
           ' or nvl(to_char(a.'||p_col_33||'),''null'') <> nvl(to_char(b.'||p_col_33||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_34 is not null then
           ' or nvl(to_char(a.'||p_col_34||'),''null'') <> nvl(to_char(b.'||p_col_34||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_35 is not null then
           ' or nvl(to_char(a.'||p_col_35||'),''null'') <> nvl(to_char(b.'||p_col_35||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_36 is not null then
           ' or nvl(to_char(a.'||p_col_36||'),''null'') <> nvl(to_char(b.'||p_col_36||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_37 is not null then
           ' or nvl(to_char(a.'||p_col_37||'),''null'') <> nvl(to_char(b.'||p_col_37||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_38 is not null then
           ' or nvl(to_char(a.'||p_col_38||'),''null'') <> nvl(to_char(b.'||p_col_38||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_39 is not null then
           ' or nvl(to_char(a.'||p_col_39||'),''null'') <> nvl(to_char(b.'||p_col_39||'),''null'')'||chr(10)
      else ''
      end
    ||case when p_col_clob_1 is not null then
           ' or dbms_lob.compare(nvl(a.'||p_col_clob_1||',to_clob(''null'')), nvl(b.'||p_col_clob_1||',to_clob(''null'')))<>0'||chr(10)
      else ''
      end
    ||case when p_col_clob_2 is not null then
           ' or dbms_lob.compare(nvl(a.'||p_col_clob_2||',to_clob(''null'')), nvl(b.'||p_col_clob_2||',to_clob(''null'')))<>0'||chr(10)
      else ''
      end
    ||case when p_col_clob_3 is not null then
           ' or dbms_lob.compare(nvl(a.'||p_col_clob_3||',to_clob(''null'')), nvl(b.'||p_col_clob_3||',to_clob(''null'')))<>0'||chr(10)
      else ''
      end
    ||')'||chr(10)
    ||'order by a.'||p_key_1
    ||case when p_key_2 is not null then ', a.'||p_key_2 else '' end
    ||case when p_key_3 is not null then ', a.'||p_key_3 else '' end
    ;
    trace(dbms_lob.substr(l_stmt,3900));
    --
    execute immediate l_stmt;
    --
    l_stmt := 'update '||l_diff_table||' set diff_result=null, diff_comment=null';
    --
    trace(l_stmt);
    --
    execute immediate l_stmt;
    --
    trace('%s rows updated', to_char(sql%rowcount));
    --
    commit;
    --
    l_stmt := 'alter table '||l_diff_table||' add constraint cc_'||replace(l_diff_table,'_','')||' check(diff_result in (''+'',''-''))';
    --
    trace(l_stmt);
    --
    execute immediate l_stmt;
    --
    l_stmt := 'alter table '||l_diff_table||' add constraint pk_'||replace(l_diff_table,'_','')||' primary key('
    ||p_key_1
    ||case when p_key_2 is not null then ', '||p_key_2 else '' end
    ||case when p_key_3 is not null then ', '||p_key_3 else '' end
    ||')';
    --
    trace(l_stmt);
    --
    execute immediate l_stmt;
    --
    trace('Протокол расхождений см. в таблице %s', l_diff_table);
    --
  end tabdiff;

-----------------------------------------------------------------------------------------------
--                                         Begin private
-----------------------------------------------------------------------------------------------
  procedure execute_immediate
  (
   ip_sql in varchar2
  )
  as
  l_trace_message         varchar2(32767 byte);
  begin
    l_trace_message := ip_sql;
    execute immediate ip_sql;
  exception when others then
        if sqlcode=(-02270) then bars_audit.error(l_trace_message);
          elsif sqlcode=(-02297) then bars_audit.error(l_trace_message);
          elsif sqlcode=(-25188) then bars_audit.error(l_trace_message);
          elsif sqlcode=(-02266) then bars_audit.error(l_trace_message);
          --ORA-02291: integrity constraint violated - parent key not found
          elsif sqlcode=(-02291) then bars_audit.error(l_trace_message);
          --ORA-01442: column to be modified to NOT NULL is already NOT NULL
          elsif sqlcode=(-01442) then bars_audit.error(l_trace_message);
          --ORA-38029: object statistics are locked
          elsif sqlcode=(-38029) then bars_audit.error(l_trace_message);  
          --ORA-01408: such column list already indexed
          elsif sqlcode=(-01408) then bars_audit.error(l_trace_message);
          --ORA-02275: such a referential constraint already exists in the table
          elsif sqlcode=(-02275) then bars_audit.error(l_trace_message);
        else raise; end if;
  end execute_immediate;

  procedure p_exception
  (
    nflag_smart   in number default 0,
    stext         in varchar2
  )
  as
  begin
    if  nflag_smart = 0 then
       raise_application_error( -20103, stext );
   else
       dbms_output.put_line(stext);
   end if;

  end p_exception;

  function f_table_exists
  (
   ip_table in varchar2
  )
  return boolean
  as
   bexist boolean := false;
   nexist number(1);
  begin
    begin
      select 1
      into nexist
      from user_tables u
      where u.table_name = upper(ip_table);
      bexist := true;
    exception
      when no_data_found then
        bexist := false;
    end;
    return bexist;
  end f_table_exists;

  procedure p_table_exists
  (
   ip_table in varchar2
  )
  as
  begin
    if ip_table is null then
       p_exception(0,'Parameter ip_table is not specified');
    end if;

    if not f_table_exists(ip_table) then
       p_exception(0,'Table '||ip_table||' not exists');
    end if;
  end p_table_exists;
  
  function f_table_exists_kf
  (
   ip_table in varchar2,
   ip_owner  in varchar2
  )
  return boolean
  as
   bexist boolean := false;
   nexist number(1);
  begin
    begin
      select 1
        into nexist
        from dba_tables dt
       where dt.table_name = upper(ip_table)
         and dt.owner = upper(ip_owner);
      bexist := true;
    exception
      when no_data_found then
        bexist := false;
    end;
    return bexist;
  end f_table_exists_kf;
  
  procedure p_table_exists_kf
  (
   ip_table in varchar2,
   ip_owner in varchar2,
   ip_ack   out number
  )
  as
  l_operation varchar2(50) := 'mgr.utl.p_table_exists_kf';
  begin
    if ip_table is null then
       ip_ack := 0;           -- No acknowleged
       p_exception(0,'Parameter ip_table is not specified');
    end if;
    if ip_owner is null then
       ip_ack := 0;           -- No acknowleged
       p_exception(0,'Parameter ip_table is not specified');
    end if;
    if not f_table_exists_kf(ip_table, ip_owner) then
       --p_exception(0,'Table '||ip_owner||'.'||ip_table||' not exists');
       ip_ack := 0;           -- No acknowleged
       mgr_log.p_save_log_info_mesg(
                                     ip_migration_id               => g_kf
                                    ,ip_table_name                 => ip_table
                                    ,ip_operation                  => l_operation
                                    ,ip_log_type                   => 'MGR_CHECK'
                                    ,ip_log_message                => 'Table '||ip_owner||'.'||ip_table||' not exists'
                                    ); 
    else ip_ack := 1;        -- Acknowleged
    end if;
  end p_table_exists_kf;

  function f_partition_exists
  (
   ip_table      in varchar2,
   ip_partition  in varchar2
  )
  return boolean
  as
   bexist boolean := false;
   nexist number(1);
  begin
    begin
      select 1
      into nexist
      from user_tab_partitions u
      where u.table_name = upper(ip_table)
        and u.partition_name = ip_partition;
      bexist := true;
    exception
      when no_data_found then
        bexist := false;
    end;
    return bexist;
  end f_partition_exists;

  procedure p_partition_exists
  (
   ip_table      in varchar2,
   ip_partition  in varchar2
  )
  as
  begin
    if ip_table is null then
       p_exception(0,'Parameter ip_table is not specified');
    end if;

    if ip_partition is null then
       p_exception(0,'Parameter ip_partition is not specified');
    end if;

    if not f_table_exists(ip_table) then
       p_exception(0,'Table '||ip_table||' not exists');
    end if;

    if not f_partition_exists(ip_table, ip_partition) then
       p_exception(0,'Partition '||ip_partition||' for table '||ip_table||' not exists');
    end if;
  end p_partition_exists;

  function f_table_column_exists
  (
   ip_table  in varchar2,
   ip_column in varchar2
  )
  return boolean
  as
   bexist boolean := false;
   nexist number(1);
  begin
    p_table_exists(ip_table);
    begin
      select 1
      into nexist
      from user_tab_columns u
      where u.table_name = upper(ip_table)
        and u.column_name = upper(ip_column);
      bexist := true;
    exception
      when no_data_found then
        bexist := false;
    end;
    return bexist;
  end f_table_column_exists;
  
  function f_table_column_exists_kf
  (
   ip_table  in varchar2,
   ip_column in varchar2,
   ip_owner  in varchar2
  )
  return boolean
  as
   bexist boolean := false;
   nexist number(1);
  begin
    p_table_exists(ip_table);
    begin
      select 1
      into nexist
      from dba_tab_columns d
      where d.table_name = upper(ip_table)
        and d.column_name = upper(ip_column)
        and d.owner = upper(ip_owner);
      bexist := true;
    exception
      when no_data_found then
        bexist := false;
    end;
    return bexist;
  end f_table_column_exists_kf;  

  procedure p_table_column_exists
  (
   ip_table  in varchar2,
   ip_column in varchar2
  )
  as
  begin
    if ip_table is null then
       p_exception(0,'Parameter ip_table is not specified');
    end if;

    if ip_column is null then
       p_exception(0,'Parameter ip_column is not specified');
    end if;

    if not f_table_column_exists(ip_table,ip_column) then
       p_exception(0,'Column '||ip_column||' of table '||ip_table||' not exists');
    end if;
  end p_table_column_exists;
  
  procedure p_table_column_exists_kf
  (
   ip_table  in varchar2,
   ip_column in varchar2,
   ip_owner  in varchar2
  )
  is
  l_operation varchar2(50) := 'mgr.utl.p_table_column_exists_kf';
  begin
    if ip_table is null then
       p_exception(0,'Parameter ip_table is not specified');
    end if;

    if ip_column is null then
       p_exception(0,'Parameter ip_column is not specified');
    end if;

    if not f_table_column_exists_kf(ip_table,ip_column,ip_owner) then
       --p_exception(0,'Column '||ip_column||' of table '||ip_table||' not exists');
       mgr_log.p_save_log_info_mesg(
                                     ip_migration_id               => g_kf
                                    ,ip_table_name                 => ip_table
                                    ,ip_operation                  => l_operation
                                    ,ip_log_type                   => 'MGR_CHECK'
                                    ,ip_log_message                => 'Column '||ip_column||' of table '||ip_table||' not exists'
                                    ); 
    end if;
  end p_table_column_exists_kf;  

  --                                         Triggers
-----------------------------------------------------------------------------------------------
  procedure p_trigger_disable
  (
   ip_trigger in varchar2
  )
  as
  begin
    execute immediate 'alter trigger ' || ip_trigger || ' disable';
  end p_trigger_disable;

  procedure p_trigger_enable
  (
   ip_trigger in varchar2
  )
  as
  begin
    execute immediate 'alter trigger ' || ip_trigger || ' enable';
  end p_trigger_enable;

--                                         indexes
-----------------------------------------------------------------------------------------------
  procedure p_index_drop
  (
  sindex in varchar2
  )
  as
  begin
    execute immediate 'drop index ' || sindex;
   -- elsif sqlcode=(-22864) then mgr_utl.save_error();
    exception when others then
    --ORA-22864: cannot ALTER or DROP LOB indexes
    --ORA-02429: cannot drop index used for enforcement of unique/primary key
    if sqlcode=(-22864) then mgr_utl.save_error(); --bars_audit.error(l_stmt);
       elsif  sqlcode=(-02429) then mgr_utl.save_error();
        else raise; end if;
  end;

--- partition
  procedure p_partition_drop
  (
   ip_table_name in varchar2,
   ip_partition  in varchar2
  )
  as
  begin
   execute immediate 'alter table '||ip_table_name||' drop partition '||ip_partition;
  end p_partition_drop;

  procedure p_partition_range_first
  (
   ip_table_name       in varchar2, -- partition table by range
   op_partition_first  out varchar2
  )
  as
   shigh_value     varchar2(40);
   nhigh_value_min integer;
   nexist          number(1);
   spart_column    user_part_key_columns.column_name%type;
  begin
  -- step 1 verify  table partition by range
    select 1
    into nexist
    from user_part_tables t
    where t.table_name = ip_table_name
      and t.partitioning_type = 'RANGE';

  -- step 2 get partition column
    select part_key.column_name
    into spart_column
    from user_part_key_columns part_key
    where part_key.name = ip_table_name
      and part_key.object_type = 'TABLE';

  -- step3 verify  partition column is number
    select 1
    into nexist
    from  user_tab_cols cols
    where cols.table_name = ip_table_name
      and cols.column_name = spart_column
      and cols.data_type = 'NUMBER';
  -- get partition with  min high value

   for cur in
      (
       select p.partition_name, p.high_value
       from  user_tab_partitions   p
       where p.table_name =  ip_table_name
      )
   loop
      shigh_value := cur.high_value;

      if nhigh_value_min is not null and nhigh_value_min > to_number(shigh_value)
      then
         nhigh_value_min := to_number(shigh_value);
         op_partition_first := cur.partition_name;
      elsif nhigh_value_min is null then
         -- init
         nhigh_value_min := to_number(shigh_value);
         op_partition_first := cur.partition_name;
      end if;

   end loop;

  exception
    when no_data_found then
      op_partition_first := null;
  end p_partition_range_first;
-----------------------------------------------------------------------------------------------
--                                         end private
-----------------------------------------------------------------------------------------------

  procedure p_indexes_drop
  (
  stable in varchar2
  )
  as
  begin
   for r in
     (
      select ui.index_name
      from user_indexes ui
       where ui.table_name = upper (stable)
      )
   loop
      p_index_drop(r.index_name);
    end loop;
  end p_indexes_drop;

  procedure p_table_partitions_range_drop
  /*
      Drop all partitions range excluding P_FIRST (partition with min high value)
  */
  (
  ip_table_name in varchar2
  )
  as
   spartition_first varchar2(30);
  begin

   p_partition_range_first(ip_table_name, spartition_first);
   for cur in
     (
      select u.partition_name
      from user_tab_partitions u
      where u.table_name = ip_table_name
        and spartition_first is not null
        and u.partition_name <> spartition_first
      )
   loop
    p_partition_drop(ip_table_name, cur.partition_name);
   end loop;
  end p_table_partitions_range_drop;

  procedure p_triggers_disable
  (
   stable in varchar2
  )
  as
  begin
    for cur in
      (
       select '"'||u.trigger_name||'"' trigger_name
       from user_triggers u
       where u.table_name = upper(stable)
         and u.status = 'ENABLED'
       )
    loop
      p_trigger_disable(cur.trigger_name);
    end loop;
  end p_triggers_disable;

  procedure p_triggers_enable
  (
   stable in varchar2
  )
  as
  begin
    for cur in
      (
       select '"'||u.trigger_name||'"' trigger_name
       from user_triggers u
       where u.table_name = upper(stable)
         and u.status = 'DISABLED'
       )
    loop
      p_trigger_enable(cur.trigger_name);
    end loop;
  -- выключаем триггера по списку из mgr_oschad.check_disable_trigger
  /*for c in (
             select dus.object_name 
                from ddl_utils_store dus 
              where dus.object_type = 'TRIGGER_DISABLED'
                and dus.table_name = stable
                --and dus.table_name not in ('OPLDOK', 'ARC_RRP')
           )
  loop
      begin
       p_trigger_disable(c.object_name);
       exception
       when others then null; 
      end;
  end loop;*/
  end p_triggers_enable;

  procedure p_indexes_nonuq_drop
  (
   stable in varchar2
  )
  as
  begin
    for cur in
      (
       select i.index_name
       from user_indexes i
       where i.table_name = upper(stable)
         and i.uniqueness = 'NONUNIQUE'
      )
    loop
      p_index_drop(cur.index_name);
    end loop;
  end p_indexes_nonuq_drop;

  procedure p_constraint_disable
  (
  stable      in varchar2,
  sconstraint in varchar2
  )
  as
  begin
   execute_immediate(ip_sql =>'alter table '||stable||' disable constraint '||sconstraint);
  end p_constraint_disable;

  procedure p_constraint_enable
  (
  stable      in varchar2,
  sconstraint in varchar2
  )
  as
  begin
   execute_immediate(ip_sql =>'alter table '||stable||' enable constraint '||sconstraint);
   end p_constraint_enable;

  procedure p_constraint_en_novalid
  (
  stable      in varchar2,
  sconstraint in varchar2
  )
  as
  begin
  execute_immediate(ip_sql =>'alter table '||stable||' modify constraint '||sconstraint||' enable novalidate');
  end p_constraint_en_novalid;
  
 procedure p_constraint_validate
  (
  stable      in varchar2,
  sconstraint in varchar2
  )
  as
  l_trace_message         varchar2(32767 byte);
  begin
  l_trace_message := 'Check '||stable||' constraint '||sconstraint||' has been not validated';
  execute_immediate(ip_sql =>'alter table '||stable||' modify constraint '||sconstraint||' validate');
  
  exception
  when others then
    --ORA-02298: cannot validate "constraint_name" - parent keys not found
    if  sqlcode=(-02298) then bars_audit.error(l_trace_message);
        else raise; end if;
  end p_constraint_validate;
  
  procedure p_constraints_chk_validate
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select u.constraint_name
          from user_constraints u
         where u.constraint_type = 'C'
           and u.table_name = upper(stable)
           and u.status = 'ENABLED'
           and u.validated <> 'VALIDATED'
        )
    loop
      p_constraint_validate(stable,cur.constraint_name);
    end loop;
  end p_constraints_chk_validate;  

  procedure p_constraints_fk_disable
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type = 'R'
          and u.table_name = upper(stable)
          and u.status = 'ENABLED'
        )
    loop
      p_constraint_disable(stable,cur.constraint_name);
    end loop;
  end p_constraints_fk_disable;
  
  procedure p_constraints_chk_disable
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type = 'C'
          and u.table_name = upper(stable)
          and u.status = 'ENABLED'
        )
    loop
      p_constraint_disable(stable,cur.constraint_name);
    end loop;
  end p_constraints_chk_disable;
  
  procedure p_constraints_chk_enable
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type = 'C'
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
      p_constraint_enable(stable,cur.constraint_name);
    end loop;
  end p_constraints_chk_enable;
  
  procedure p_constraints_chk_en_novalid
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type = 'C'
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
      p_constraint_en_novalid(stable,cur.constraint_name);
    end loop;
  end p_constraints_chk_en_novalid;

  procedure p_constraints_pk_enable
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type in ('P','U')
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
      p_constraint_enable(stable,cur.constraint_name);
      --p_constraint_en_novalid(stable,cur.constraint_name);
    end loop;
  end p_constraints_pk_enable;
  
  procedure p_constraints_pk_en_novalid
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type in ('P','U')
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
     p_constraint_en_novalid(stable,cur.constraint_name);
    end loop;
  end p_constraints_pk_en_novalid;  
  
  procedure p_constraints_pk_uk_validate
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
          from user_constraints u
         where u.constraint_type in ('P','U')
           and u.table_name = upper(stable)
           and u.status = 'ENABLED'
           and u.validated <> 'VALIDATED'
        )
    loop
      p_constraint_validate(stable,cur.constraint_name);
    end loop;
  end p_constraints_pk_uk_validate; 
  
  procedure p_constraints_disable
  (
  stable      in varchar2
  )
  as
  begin
     p_constraints_chk_disable(stable);
    p_constraints_fk_disable (stable);

    /*for cur in
       (
        select u.constraint_name
        from user_constraints u
        where u.constraint_type in ('P','U')
          and u.table_name = upper(stable)
          and u.status = 'ENABLED'
        )
    loop
      p_constraint_disable(stable,cur.constraint_name);
    end loop;*/

  end p_constraints_disable;

  procedure p_ref_constraints_disable
  (
  stable      in varchar2
  )
  as
  begin
    for cur in
       ( select  table_name, '"'||constraint_name||'"' constraint_name
            from user_constraints
            where r_constraint_name
               in (select constraint_name
                     from user_constraints
                    where constraint_type in ('P','U')
                      and table_name = upper(stable)
                      and status = 'ENABLED')
               and status = 'ENABLED'
        )
    loop
      p_constraint_disable(cur.table_name,cur.constraint_name);
    end loop;
  end p_ref_constraints_disable;

  procedure p_ref_constraints_enable
  (
  stable      in varchar2
  )
  as
  begin
    for cur in
       ( select  table_name, '"'||constraint_name||'"' constraint_name
            from user_constraints
            where r_constraint_name
               in (select constraint_name
                     from user_constraints
                    where constraint_type in ('P','U')
                      and table_name = upper(stable)
                      and status = 'ENABLED')
               and status = 'DISABLED'
        )
    loop
      p_constraint_enable(cur.table_name,cur.constraint_name);
    end loop;
  end p_ref_constraints_enable;

  procedure p_ref_constraints_en_novalid
  (
  stable      in varchar2
  )
  as
  begin
    for cur in
       ( select  table_name, '"'||constraint_name||'"' constraint_name
            from user_constraints
            where r_constraint_name
               in (select constraint_name
                     from user_constraints
                    where constraint_type in ('P','U')
                      and table_name = upper(stable)
                      and status = 'ENABLED')
               and status = 'DISABLED'
        )
    loop
      p_constraint_en_novalid(cur.table_name,cur.constraint_name);
    end loop;
  end p_ref_constraints_en_novalid;
  
  procedure p_ref_constraints_validate
  (
  stable      in varchar2,
  stable_exclude1 in varchar2 default 'AAA',
  stable_exclude2 in varchar2 default 'AAA' 
  )
  as
  begin

    for cur in
       (
        select  table_name, '"'||constraint_name||'"' constraint_name
            from user_constraints
           where r_constraint_name
              in (select constraint_name
                     from user_constraints
                    where constraint_type in ('P','U')
                      and table_name = upper(stable)
                      and status = 'ENABLED')
             and validated <> 'VALIDATED'
             and not table_name in (stable_exclude1)
             and not table_name in (stable_exclude2)
        )
    loop
      p_constraint_validate(cur.table_name, cur.constraint_name);
    end loop;
  end p_ref_constraints_validate;

  procedure p_constraints_fk_enable
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type = 'R'
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
      p_constraint_enable(stable,cur.constraint_name);
    end loop;

  end p_constraints_fk_enable;
  
  procedure p_constraints_fk_en_novalid
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type = 'R'
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
      p_constraint_en_novalid(stable,cur.constraint_name);
    end loop;

  end p_constraints_fk_en_novalid;
  
  procedure p_constraints_fk_validate
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type = 'R'
          and u.table_name = upper(stable)
           and u.status = 'ENABLED'
           and u.validated <> 'VALIDATED'
        )
    loop
      p_constraint_validate(stable,cur.constraint_name);
    end loop;
  end p_constraints_fk_validate;

  procedure p_constraints_enable
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type in ('P','U')
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
      p_constraint_enable(stable,cur.constraint_name);
    end loop;

    p_constraints_fk_enable(stable);
    p_constraints_chk_enable(stable);

  end p_constraints_enable;
  
  procedure p_constraints_en_novalid
  (
  stable      in varchar2
  )
  as
  begin

    for cur in
       (
        select '"'||u.constraint_name||'"' constraint_name
        from user_constraints u
        where u.constraint_type in ('P','U')
          and u.table_name = upper(stable)
          and u.status = 'DISABLED'
        )
    loop
      p_constraint_en_novalid(stable,cur.constraint_name);
    end loop;

    p_constraints_fk_en_novalid(stable);
    p_constraints_chk_en_novalid(stable);

  end p_constraints_en_novalid;

  procedure p_constraints_validate
  (
  stable      in varchar2
  )
  as
  begin
    
    p_constraints_pk_uk_validate(stable);
    p_constraints_chk_validate(stable);
    p_constraints_fk_validate(stable);
    p_ref_constraints_validate(stable);
 
  end p_constraints_validate;

  function f_index_get_metadata
  (
  sindex in varchar2
  ) return clob
  is
   cbuffer      clob;
   cresult      clob;
   nhandle      number;
   nddl_handle  number;
   sobject_type varchar2(19) := 'INDEX';
  begin
   dbms_lob.createtemporary(cresult, true);
   nhandle := dbms_metadata.open(sobject_type);
   dbms_metadata.set_filter(nhandle, 'NAME', sindex);
   nddl_handle  := dbms_metadata.add_transform(nhandle, 'DDL');
   dbms_metadata.set_transform_param(nddl_handle, 'STORAGE', false);
   loop
     cbuffer := dbms_metadata.fetch_clob(nhandle);
     if cbuffer is null then
       exit;
     else
       dbms_lob.append(cresult, cbuffer);
     end if;
   end loop;

   return cresult;

  end f_index_get_metadata;

function f_trigger_get_metadata
  (
  strigger in varchar2
  ) return clob
  is
   cbuffer      clob;
   cresult      clob;
   nhandle      number;
   nddl_handle  number;
   sobject_type varchar2(19) := 'TRIGGER';
  begin
   dbms_lob.createtemporary(cresult, true);
   nhandle := dbms_metadata.open(sobject_type);
   dbms_metadata.set_filter(nhandle, 'NAME', strigger);
   nddl_handle  := dbms_metadata.add_transform(nhandle, 'DDL');
   --dbms_metadata.set_transform_param(nddl_handle, 'STORAGE', false);
   loop
     cbuffer := dbms_metadata.fetch_clob(nhandle);
     if cbuffer is null then
       exit;
     else
       dbms_lob.append(cresult, cbuffer);
     end if;
   end loop;

   return cresult;

  end f_trigger_get_metadata;

function f_constraint_get_metadata
  (
  sconstraint in varchar2
  ) return clob
  is
   cbuffer      clob;
   cresult      clob;
   nhandle      number;
   nddl_handle  number;
   sobject_type varchar2(19) := 'CONSTRAINT';
  begin
   dbms_lob.createtemporary(cresult, true);
   nhandle := dbms_metadata.open(sobject_type);
   dbms_metadata.set_filter(nhandle, 'NAME', sconstraint);
   nddl_handle  := dbms_metadata.add_transform(nhandle, 'DDL');
   --dbms_metadata.set_transform_param(nddl_handle, 'STORAGE', false);
   loop
     cbuffer := dbms_metadata.fetch_clob(nhandle);
     if cbuffer is null then
       exit;
     else
       dbms_lob.append(cresult, cbuffer);
     end if;
   end loop;

   return cresult;

  end f_constraint_get_metadata;
  
  
  function f_constraint_pk_get_metadata 
  (
  sconstraint in varchar2 
  ) return clob
  is
    
   cbuffer      clob;
   cresult      clob;
   nhandle      number;
   nddl_handle  number;
   sobject_type varchar2(19) := 'CONSTRAINT';

  begin
     dbms_lob.createtemporary(cresult, true);
     nhandle:=dbms_metadata.open(sobject_type);
     dbms_metadata.set_filter(nhandle, 'NAME', sconstraint);
     nddl_handle  := dbms_metadata.add_transform(nhandle, 'DDL');
   --dbms_metadata.set_transform_param (nddl_handle, 'CONSTRAINTS_AS_ALTER', true );
     --dbms_metadata.set_transform_param (nddl_handle, 'STORAGE', false );
     --dbms_metadata.set_transform_param (nddl_handle, 'SQLTERMINATOR', true );
     
    
   loop
     cbuffer := dbms_metadata.fetch_clob(nhandle);
     if cbuffer is null then
       exit;
     else
       dbms_lob.append(cresult, cbuffer);
     end if;
   end loop;

   return cresult;  

end  f_constraint_pk_get_metadata ;

 function f_table_get_metadata 
  (
  stable in varchar2 
  ) return clob
  is
    
   cbuffer      clob;
   cresult      clob;
   nhandle      number;
   nddl_handle  number;
   sobject_type varchar2(19) := 'TABLE';

  begin
     dbms_lob.createtemporary(cresult, true);
     nhandle:=dbms_metadata.open(sobject_type);
     dbms_metadata.set_filter(nhandle, 'NAME', stable);
     nddl_handle  := dbms_metadata.add_transform(nhandle, 'DDL');
   dbms_metadata.set_transform_param (nddl_handle,'STORAGE',false);
   dbms_metadata.set_transform_param (nddl_handle,'TABLESPACE',false);
   dbms_metadata.set_transform_param (nddl_handle,'SEGMENT_ATTRIBUTES', false);
   dbms_metadata.set_transform_param (nddl_handle,'REF_CONSTRAINTS', false);
   dbms_metadata.set_transform_param (nddl_handle,'CONSTRAINTS', false);
   --dbms_metadata.set_transform_param (nddl_handle,'SQLTERMINATOR', true ); --add symbol ';' into the end of script
    
   loop
     cbuffer := dbms_metadata.fetch_clob(nhandle);
     if cbuffer is null then
       exit;
     else
       dbms_lob.append(cresult, cbuffer);
     end if;
   end loop;

   return cresult;  

end  f_table_get_metadata ;

 function f_tbl_col_com_get_metadata 
  (
  stable in varchar2 
  ) return clob
  is
    
   cbuffer      clob;
   cresult      clob;
   nhandle      number;
   nddl_handle  number;
   sobject_type varchar2(19) := 'COMMENT';

  begin
     dbms_lob.createtemporary(cresult, true);
     nhandle:=dbms_metadata.open(sobject_type);
     dbms_metadata.set_filter(nhandle, 'BASE_OBJECT_NAME', stable);
     nddl_handle  := dbms_metadata.add_transform(nhandle, 'DDL');
   dbms_metadata.set_transform_param (nddl_handle,'SQLTERMINATOR', true );
    
   loop
     cbuffer := dbms_metadata.fetch_clob(nhandle);
     if cbuffer is null then
       exit;
     else
       dbms_lob.append(cresult, cbuffer);
     end if;
   end loop;

   return cresult;  

end  f_tbl_col_com_get_metadata ;


  procedure p_object_save
  (
   stable       in varchar2,
   sobject_name in varchar2,
   sobject_type in varchar2,
   csql_text    in clob
  )
  as
  l_trace_message         varchar2(32767 byte);
  begin
    l_trace_message := 'Object_save: '||sobject_name||' '||sobject_type||' for '||stable||' already exists in ddl_utils_store ';
    insert
    into ddl_utils_store
     (
      table_name,
      object_name,
      object_type,
      sql_text
     )
     values
     (
      stable,
      sobject_name,
      sobject_type,
      csql_text
     );
   exception when others then
            --ORA-00001: unique constraint violated
            if sqlcode=(-00001) then bars_audit.error(l_trace_message);
            else raise; end if;    
  end p_object_save;

  procedure p_index_save
  (
  stable in varchar2,
  sindex in varchar2
  )
  as
  csql_text clob;
  begin
    csql_text := f_index_get_metadata(sindex);
    p_object_save(stable, sindex,'INDEX', csql_text);
  end p_index_save;

  procedure p_trigger_save
  (
  stable in varchar2,
  strigger in varchar2,
  sstatus in varchar2
  )
  as
  csql_text clob;
  l_status varchar2(30 char);
  begin
    csql_text := f_trigger_get_metadata(strigger);
    l_status  := sstatus;
    case when l_status = 'DISABLED'
              then p_object_save(stable, strigger,'TRIGGER_DISABLED', csql_text);
         when l_status = 'ENABLED'
              then p_object_save(stable, strigger,'TRIGGER', csql_text);
         else null;
    end case;
  end p_trigger_save;

  procedure p_constraint_save
  (
  stable in varchar2,
  sconstraint in varchar2
  )
  as
  csql_text clob;
  begin
    csql_text := f_constraint_get_metadata(sconstraint);
    p_object_save(stable, sconstraint,'CONSTRAINT_CHK', csql_text);
  end p_constraint_save;
  
  procedure p_constraint_pk_save
  (
  stable in varchar2,
  sconstraint in varchar2
  )
  as
  csql_text clob;
  begin
    csql_text := f_constraint_pk_get_metadata(sconstraint);
    p_object_save(stable, sconstraint,'CONSTRAINT_PK_UK', csql_text);
  end p_constraint_pk_save;
  
  procedure p_table_save
  (
  stable in varchar2
  )
  as
  csql_text clob;
  ncount number;
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;
    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;
    begin
      select 1
      into ncount
      from user_tables u
      where u.table_name = stable
        and rownum = 1;
    exception
      when no_data_found then
        ncount := 0;
    end;
    if ncount > 0 then
       delete from  ddl_utils_store v
       where v.table_name = stable
         and v.object_type = 'TABLE';
    end if;
    csql_text := f_table_get_metadata(stable);
    p_object_save(stable, NULL,'TABLE', csql_text);
  end p_table_save;
  
  procedure p_tbl_col_com_save
  (
  stable in varchar2
  )
  as
  csql_text clob;
  ncount number;
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;
    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;
    begin
      select 1
      into ncount
      from user_tab_comments u
      where u.table_name = stable
        and rownum = 1;
    exception
      when no_data_found then
        ncount := 0;
    end;
    if ncount > 0 then
       delete from  ddl_utils_store v
       where v.table_name = stable
         and v.object_type = 'COMMENT';
    end if;
    csql_text := f_tbl_col_com_get_metadata(stable);
    p_object_save(stable, 'TABLE_COM_COL', 'COMMENT', csql_text);
  end p_tbl_col_com_save;

  procedure p_indexes_save
  (
  stable in varchar2
  )
  as
  ncount number;
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

    begin
      select 1
      into ncount
      from user_indexes u
      where u.index_type <> 'LOB'
        and u.table_name = stable
        and rownum = 1;
    exception
      when no_data_found then
        ncount := 0;
    end;

    if ncount > 0 then
       delete from  ddl_utils_store v
       where v.table_name = stable
         and v.object_type = 'INDEX';
    end if;

    for cur in
      (
       select u.index_name
       from user_indexes u
       where u.index_type <> 'LOB'
         and u.table_name = stable
       )
    loop
      p_index_save(stable, cur.index_name);
    end loop;
    commit;
  end p_indexes_save;

  procedure p_triggers_save
  (
  stable in varchar2
  )
  as
  ncount number;
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

    begin
      select 1
      into ncount
      from user_dependencies
      where type = 'TRIGGER'
      and referenced_type = 'TABLE'
      and referenced_name = stable
      and rownum = 1;
    exception
      when no_data_found then
        ncount := 0;
    end;

    if ncount > 0 then
       delete from  ddl_utils_store v
       where v.table_name = stable
         and (v.object_type = 'TRIGGER' or v.object_type = 'TRIGGER_DISABLED');
    end if;

    for cur in
      (
       select ud.name, ut.status 
       from user_dependencies ud,
            user_triggers     ut
       where ud.name = ut.trigger_name
       and type = 'TRIGGER'
       and referenced_type = 'TABLE'
       and referenced_name = stable
       )
    loop
      p_trigger_save(stable, cur.name, cur.status);
    end loop;
    commit;
  end p_triggers_save;

  procedure p_constraints_save
  (
  stable in varchar2
  )
  as
  ncount number;
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

    begin
      select 1
      into ncount
      from user_constraints u
      where u.constraint_type = 'C'
      and u.table_name =  stable
      and rownum = 1;
    exception
      when no_data_found then
        ncount := 0;
    end;

    if ncount > 0 then
       delete from  ddl_utils_store v
       where v.table_name = stable
         and v.object_type = 'CONSTRAINT_CHK';
    end if;

    for cur in
      (
       select constraint_name
       from user_constraints u
       where u.constraint_type = 'C'
       and u.table_name =  stable
       )
    loop
      p_constraint_save(stable, cur.constraint_name);
    end loop;
    commit;
  end p_constraints_save;

  procedure p_constraints_pk_save
  (
  stable in varchar2
  )
  as
  ncount number;
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

    begin
      select 1
      into ncount
      from user_constraints u
      where u.constraint_type in ( 'P', 'U')
      and u.table_name =  stable
      and rownum = 1;
    exception
      when no_data_found then
        ncount := 0;
    end;

    if ncount > 0 then
       delete from  ddl_utils_store v
       where v.table_name = stable
         and v.object_type = 'CONSTRAINT_PK_UK';
    end if;

    for cur in
      (
       select constraint_name
       from user_constraints u
       where u.constraint_type in ( 'P', 'U')
       and u.table_name =  stable
       )
    loop
      p_constraint_pk_save(stable, cur.constraint_name);
    end loop;
    commit;
  end p_constraints_pk_save;

  procedure p_object_restore
  (
  sobject_name in varchar2,
  sobject_type in varchar2 default null,
  stable       in varchar2
  )
  as
  pragma autonomous_transaction;
  ssql_text clob;
  begin
    select s.sql_text
    into ssql_text
    from ddl_utils_store s
    where s.object_name = sobject_name
      and s.object_type = sobject_type
      and s.table_name = stable;
    --execute immediate ssql_text;
    execute_immediate(ip_sql => ssql_text);
    exception
    when no_data_found then
      commit;
    when others then
    --ORA-14024: number of partitions of LOCAL index must equal that of the underlying table
    if  sqlcode=(-14024) then bars_audit.error(ssql_text);
        else raise; end if;
  end p_object_restore;
  
  procedure p_job_restore
  (
  sobject_name in varchar2,
  sobject_type in varchar2 default null
  )
  as
  pragma autonomous_transaction;
  ssql_text clob;
  begin
    select s.sql_text
    into ssql_text
    from ddl_utils_store s
    where s.object_name = sobject_name
      and s.object_type = sobject_type;
    execute_immediate(ip_sql => ssql_text);
    exception
    when no_data_found then
      commit;
  end p_job_restore;

  procedure p_indexes_restore
  (
  stable in varchar2
  )
  as
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

   for cur in
     (
      select t.object_name, t.object_type, t.table_name 
      from ddl_utils_store t
      where t.table_name = stable
        and t.object_type = 'INDEX'
        and not exists (select 1
                        from user_indexes u
                        where u.index_name = t.object_name)
      )
   loop
     p_object_restore(cur.object_name, cur.object_type,  cur.table_name);
   end loop;

  end p_indexes_restore;

  procedure p_triggers_restore
  (
  stable in varchar2
  )
  as
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

   for cur in
     (
      select t.object_name, t.object_type, t.table_name
      from ddl_utils_store t
      where t.table_name = stable
        and t.object_type = 'TRIGGER'
        and not exists (select 1
                        from user_objects o
                        where o.object_name = t.object_name)
      )
   loop
     p_object_restore(cur.object_name, cur.object_type, cur.table_name);
   end loop;

  end p_triggers_restore;

  procedure p_constraints_restore
  (
  stable in varchar2
  )
  as
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

   for cur in
     (
      select t.object_name, t.object_type, t.table_name
      from ddl_utils_store t  
      where t.table_name = stable
        and t.object_type = 'CONSTRAINT_CHK'
        and not exists (select 1
                        from user_constraints c
                        where c.constraint_name = t.object_name)
      )
   loop
     p_object_restore(cur.object_name, cur.object_type, cur.table_name);
   end loop;

  end p_constraints_restore;
  
  procedure p_constraints_pk_restore
  (
  stable in varchar2
  )
  as
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

   for cur in
     (
      select t.object_name, t.object_type, t.table_name
      from ddl_utils_store t            
      where t.table_name = stable
        and t.object_type = 'CONSTRAINT_PK_UK'
    and not exists (select 1
                        from user_constraints c
                        where c.constraint_name = t.object_name)
      )
   loop
     p_object_restore(cur.object_name, cur.object_type, cur.table_name);
   end loop;

  end p_constraints_pk_restore;
  
  procedure p_run_scheduler_job
  as
  begin
  for cur in
     (
      select t.object_name, t.object_type
      from ddl_utils_store t
      where t.object_type = 'JOB'
        and not exists (select 1
                        from dba_scheduler_jobs dsj
                        where dsj.owner||'.'||dsj.job_name = t.object_name
                        and dsj.enabled = 'TRUE'
                        )
      )
   loop
     begin
       p_job_restore(cur.object_name, cur.object_type);
       exception when others then null;
     end;
   end loop;
  end p_run_scheduler_job;
  
  procedure p_run_dbms_job
  as
  begin
  for cur in
     (
      select t.object_name, t.object_type
      from ddl_utils_store t
      where t.object_type = 'DBMS_JOB'
        and not exists (select 1
                        from all_jobs aj
                        where aj.job = t.object_name 
                        and aj.broken = 'N'
                        )
      )
   loop
     p_job_restore(cur.object_name, cur.object_type);
   end loop;
  end p_run_dbms_job;
  
  procedure p_run_job
  as
  begin
  p_run_scheduler_job;
  p_run_dbms_job;
  exception when others
   then raise;
  end p_run_job; 
  
  procedure p_stop_scheduler_job
    as
     job_is_running   EXCEPTION;
     PRAGMA EXCEPTION_INIT (job_is_running, -27478);
     csql_text clob;
  begin
  for cur in 
  (
  select dsj.owner||'.'||dsj.job_name as job  from dba_scheduler_jobs dsj
   where dsj.owner in ('BARS', 'BARSAQ', 'CDB', 'BARS_DM', 'BARSUPL','PFU', 'SBON')
     and dsj.enabled = 'TRUE'
  )
  loop
   csql_text := 'begin dbms_scheduler.enable('''||cur.job||'''); end;';
   mgr_utl.p_object_save(null, cur.job,'JOB', csql_text);
   begin
     dbms_scheduler.stop_job(cur.job); 
     exception when others 
          then null; 
   end;
   
   begin
     dbms_scheduler.disable(cur.job);
     exception when others 
          then null; 
   end;   
  end loop;
  exception when job_is_running 
    then raise_application_error( -20001, 'All job must be stoped! Please stop running job and try again!' );
  --dbms_scheduler.stop_job(cur.job, force=>true);
  --dbms_scheduler.disable(cur.job);
  end p_stop_scheduler_job; 
  
  procedure p_stop_dbms_job
    as
     job_is_not_in_queue EXCEPTION;
     PRAGMA EXCEPTION_INIT (job_is_not_in_queue, -23421);
     csql_text clob;
  begin
  for cur in 
  (
    select aj.job as job
      from all_jobs aj
     where aj.broken = 'N'
   )
  loop
   csql_text := 'begin sys.dbms_job.broken(job => '''||cur.job||''', broken => false); commit; end;';
   mgr_utl.p_object_save(null, cur.job,'DBMS_JOB', csql_text);
   sys.dbms_job.broken(job => cur.job,broken => true); 
   commit; 
  end loop;
  exception when job_is_not_in_queue
    then null;
  end p_stop_dbms_job; 
  
  procedure p_stop_job
    as
  begin
   p_stop_scheduler_job; 
   p_stop_dbms_job;
  exception when others
   then raise;
  end p_stop_job;

  procedure p_table_truncate
  (
  stable in varchar2
  )
  as
  begin
    p_table_exists(stable);
    execute_immediate(ip_sql =>'truncate table '||stable);
  end p_table_truncate;

  procedure p_table_drop
  (
  nflag_smart in number,
  stable      in varchar2
  )
  as
  begin
    if f_table_exists(stable) then
       execute immediate 'drop table '||stable;
    else
       p_exception(nflag_smart,'Table '||stable||' not exist');
    end if;
  end p_table_drop;
  -- ref constraint --

  procedure p_constraint_drop
  (
   ip_table      in varchar2,
   ip_constraint in varchar2
  )
  as
  begin
    execute_immediate('alter table '||ip_table||' drop constraint '||ip_constraint);
  end p_constraint_drop;
  
  procedure p_constraint_pk_uk_drop
  (
   ip_table      in varchar2,
   ip_constraint in varchar2
  )
  as
  begin
    execute_immediate('alter table '||ip_table||' drop constraint '||ip_constraint||' cascade drop index');
  end p_constraint_pk_uk_drop;

  procedure p_constraints_ref_drop
  (
   ip_table      in varchar2
  )
  as
  begin
    for cur in
      (
       select c.constraint_name
       from user_constraints c
       where c.table_name = ip_table
         and c.constraint_type = 'R'
       )
    loop
      p_constraint_drop(ip_table,cur.constraint_name);
    end loop;
  end p_constraints_ref_drop;

  procedure p_constraints_pk_drop
  (
   ip_table      in varchar2
  )
  as
  begin
    for cur in
      (
       select c.constraint_name
       from user_constraints c
       where c.table_name = ip_table
         and c.constraint_type in ('P','U')
       )
    loop
      p_constraint_pk_uk_drop(ip_table,cur.constraint_name);
    end loop;
  end p_constraints_pk_drop;
  
  procedure p_constraints_chk_drop
  (
   ip_table      in varchar2
  )
  as
  begin
    for cur in
      (
       select c.constraint_name
       from user_constraints c
       where c.table_name = ip_table
         and c.constraint_type = 'C'
       )
    loop
      p_constraint_drop(ip_table,cur.constraint_name);
    end loop;
  end p_constraints_chk_drop;

  procedure p_constraints_drop
  (
   ip_table      in varchar2
  )
  as
  begin
    p_constraints_chk_drop (ip_table);
     p_constraints_ref_drop (ip_table);
    p_ref_constraints_drop (ip_table);
     p_constraints_pk_drop  (ip_table);
 end p_constraints_drop;

  procedure p_ref_constraints_drop
  (
  stable in varchar2
  )
  as
  begin
    for cur in
      (
       select rf.table_name, rf.constraint_name
       from user_constraints u,
            user_constraints rf
        where u.table_name = stable
          and u.constraint_type in ('P','U')
          and rf.r_constraint_name = u.constraint_name
          and rf.r_owner = u.owner
          and rf.constraint_type = 'R'
       )
    loop
      p_constraint_drop(cur.table_name, cur.constraint_name);
    end loop;
  end p_ref_constraints_drop;

  function f_ref_constraint_get_metadata
  (
  sref_constraint in varchar2
  )
  return clob
  is
   cbuffer      clob;
   cresult      clob;
   nhandle      number;
   nddl_handle  number;
   sobject_type varchar2(19) := 'REF_CONSTRAINT';
  begin
    dbms_lob.createtemporary(cresult, true);
    nhandle := dbms_metadata.open(sobject_type);
    dbms_metadata.set_filter(nhandle, 'NAME', sref_constraint);
    nddl_handle  := dbms_metadata.add_transform(nhandle, 'DDL');

    loop
      cbuffer := dbms_metadata.fetch_clob(nhandle);
      if cbuffer is null then
        exit;
      else
        dbms_lob.append(cresult, cbuffer);
      end if;
    end loop;

    return cresult;

  end f_ref_constraint_get_metadata;

  procedure p_ref_constraint_save
  (
   stable          in varchar2,
   sref_constraint in varchar2
  )
  as
   csql_text clob;
  begin
    csql_text := f_ref_constraint_get_metadata(sref_constraint);
    p_object_save(stable, sref_constraint, 'REF_CONSTRAINT', csql_text);
  end p_ref_constraint_save;

  procedure p_ref_constraints_save
  (
  stable in varchar2
  )
  as
  ncount number;
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

   begin
     select 1
     into ncount
     from 
   ( select rf.constraint_name
     from user_constraints u,
               user_constraints rf
      where u.table_name = stable
        and u.constraint_type in ('P','U')
        and rf.r_constraint_name = u.constraint_name
        and rf.r_owner = u.owner
        and rf.constraint_type = 'R'
      union all
    select u.constraint_name
       from user_constraints u
       where u.table_name = stable
         and u.constraint_type = 'R'
    ) where rownum = 1;
   exception
     when no_data_found then
       ncount := 0;
   end;

   if ncount > 0 then
      delete from  ddl_utils_store v
      where v.table_name = stable
        and v.object_type = 'REF_CONSTRAINT';
   end if;

   for cur in
     (
       select rf.constraint_name
       from user_constraints u,
            user_constraints rf
        where u.table_name = stable
          and u.constraint_type in ('P','U')
          and rf.r_constraint_name = u.constraint_name
          and rf.r_owner = u.owner
          and rf.constraint_type = 'R'
    union all
    select u.constraint_name
       from user_constraints u
       where u.table_name = stable
         and u.constraint_type = 'R'
      )
   loop
     p_ref_constraint_save(stable, cur.constraint_name);
   end loop;
   commit;
  end p_ref_constraints_save;

  procedure p_ref_constraints_restore
  (
  stable in varchar2
  )
  as
  l_trace_message         varchar2(32767 byte);
  begin
    if ltrim(stable)is null then
       p_exception(0,'No table name is specified');
    end if;

    if not f_table_exists(stable) then
       p_exception(0,'Table '||stable||' not exists');
    end if;

   for cur in
     (
      select t.object_name, t.object_type, t.table_name
      from ddl_utils_store t
      where t.table_name = stable
        and t.object_type = 'REF_CONSTRAINT'
        and not exists (select 1
                        from user_constraints u
                        where u.constraint_name = t.object_name)
      )
   loop
     l_trace_message := 'Check '||cur.object_name||' '||cur.object_type||' for '|| cur.table_name;
     p_object_restore(cur.object_name, cur.object_type, cur.table_name);
   end loop;
  exception when others then
  if sqlcode=(-01422) then bars_audit.error(l_trace_message);
  else raise; end if;  

  end p_ref_constraints_restore;
  ------------------------- copy table for exchange partition --------------------------------------------
  --------------------------------------------------------------------------------------------------------

  function f_table_column_data_type
  (
   ip_data_default in number,
   ip_nullable     in number,
   ip_table        in varchar2,
   ip_column       in varchar2
  )
   return varchar2
  as
  r                 user_tab_cols%rowtype;
  v_data_length     varchar2(100);
  v_data_precision  varchar2(100);
  v_char_length     varchar2(100);
  v_char_length2    varchar2(100);
  v_column_type     varchar2(4000);
  begin

    select u.*
    into r
    from user_tab_cols u
    where u.table_name = ip_table
      and u.column_name = ip_column;

  v_data_length    := '('||to_char(r.data_length)||')';
  v_data_precision := '('||to_char(r.data_precision)||')';
  v_char_length    := '('||to_char(r.char_length )||')';
  v_char_length2   := '('||to_char(r.char_length )|| case r.char_used
                                                       when 'B' then null --' Byte'
                                                       when 'C' then ' Char'
                                                       else null
                                                     end ||')';
    if r.virtual_column = 'YES' and r.data_default is not null then
       v_column_type := 'as ( '||r.data_default||' )';
    else
       v_column_type := case
                        when r.data_type_mod is not null
                           then r.data_type_mod || case
                                                     when r.data_type_owner is not null then ' '||r.data_type_owner||'.'
                                                     else ' '
                                                   end
                        end ||
                        case
                          when r.data_type_mod = 'REF' then r.data_type

                          when r.data_type = 'VARCHAR2'  then 'VARCHAR2' || v_char_length2
                          when r.data_type = 'NVARCHAR2' then 'NVARCHAR2'|| v_char_length2
                          when r.data_type = 'VARCHAR'   then 'VARCHAR'  || v_char_length
                          when r.data_type = 'NVARCHAR'  then 'NVARCHAR' || v_char_length
                          when r.data_type = 'CHAR'      then 'CHAR'     || v_char_length
                          when r.data_type = 'NCHAR'     then 'NCHAR'    || v_char_length
                          when r.data_type = 'NCHAR VARYING' then 'NCHAR VARYING' || v_char_length

                          when r.data_type = 'NUMBER'    then case
                                                               when r.data_precision is null and r.data_scale is null         then 'NUMBER'
                                                               when r.data_precision is null and r.data_scale = 0             then 'INTEGER'
                                                               when r.data_precision is not null and r.data_scale is null     then 'NUMBER'||v_data_precision
                                                               when r.data_precision is not null and r.data_scale is not null then 'NUMBER'||'('||to_char(r.data_precision)||','||to_char(r.data_scale)||')'
                                                              end

                          when r.data_type = 'FLOAT'     then 'FLOAT' || case
                                                                          when r.data_precision = 126 then null
                                                                           else v_data_precision
                                                                         end
                          when r.data_type = 'BINARY_FLOAT'   then 'BINARY_FLOAT'
                          when r.data_type = 'BINARY_DOUBLE'  then 'BINARY_DOUBLE'

                          when r.data_type = 'LONG'      then 'LONG'
                          when r.data_type = 'LONG RAW'  then 'LONG RAW'
                          when r.data_type = 'RAW'       then 'RAW' || v_data_length

                          when r.data_type = 'DATE'                          then 'DATE'
                          when substr(r.data_type, 1, 5)  = 'TIME('          then r.data_type -- TIME(scale)  TIME(scale) WITH TIME ZONE
                          when substr(r.data_type, 1, 10) = 'TIMESTAMP('     then r.data_type -- TIMESTAMP(scale) TIMESTAMP(scale) WITH TIME ZONE TIMESTAMP(scale) WITH LOCAL TIME ZONE
                          when substr(r.data_type, 1, 14) = 'INTERVAL YEAR(' then r.data_type -- INTERVAL YEAR(precision) TO MONTH
                          when substr(r.data_type, 1, 13) = 'INTERVAL DAY('  then r.data_type -- INTERVAL DAY(precision) TO SECOND(scale)

                          when r.data_type = 'ROWID'  then 'ROWID'
                          when r.data_type = 'UROWID' then 'UROWID' || v_data_length

                          when r.data_type = 'NCLOB'   then 'NCLOB'
                          when r.data_type = 'CLOB'    then 'CLOB'
                          when r.data_type = 'BLOB'    then 'BLOB'
                          when r.data_type = 'BFILE'   then 'BFILE'
                          when r.data_type = 'CFILE'   then 'CFILE'
                          when r.data_type = 'XMLTYPE' then 'XMLTYPE'
                        end ||
                        case
                         when ip_data_default = 1 and r.data_default is not null and r.virtual_column = 'NO' then ' DEFAULT '||r.data_default
                        end ||
                        case
                          when ip_nullable = 1 and r.nullable = 'N' then ' NOT NULL'
                        end;
      end if;

      return v_column_type;

  end f_table_column_data_type;

  function f_column_data_type
  (
   ip_table      in varchar2,
   ip_column     in varchar2
  )
   return varchar2
  as
  begin
   return f_table_column_data_type(1, 1, ip_table, ip_column);
  end f_column_data_type;

  function f_variable_data_type
  (
   ip_table      in varchar2,
   ip_column     in varchar2
  )
   return varchar2
  as
  begin
   return f_table_column_data_type(0, 0, ip_table, ip_column);
  end f_variable_data_type;

  procedure p_ep_sql_table
  (
   ip_table_from in varchar2,
   ip_table_to   in varchar2,
   op_sql        out clob
  )
  as
    subtype oracle_name_len is pls_integer range 1 .. 32;
    v_first      boolean := true;
    v_format_len oracle_name_len;
  begin
    p_table_exists(ip_table_from);

     select max(length(t.column_name))
     into v_format_len
     from user_tab_columns t
     where t.table_name = ip_table_from;

     v_format_len := v_format_len + 2; -- extend on two symbol ""

     for cur in
       (
        select u.table_name, u.column_name column_name
        from user_tab_columns u
        where u.table_name = ip_table_from
        order by u.column_id
       )
     loop
       if v_first then
          op_sql := rpad('"'||cur.column_name||'"',v_format_len,' ')||' '||f_column_data_type(cur.table_name,cur.column_name);
          v_first := false;
       else
          op_sql := op_sql||','||c_enter||rpad('"'||cur.column_name||'"',v_format_len,' ')||' '||f_column_data_type(cur.table_name,cur.column_name);
       end if;
     end loop;

     -- final
     op_sql := 'create table '||ip_table_to||c_enter||
               '('                         ||c_enter||
               op_sql                      ||c_enter||
               ')';
    end p_ep_sql_table;
    
  procedure p_interim_sql_table
  (
   ip_table_from in varchar2,
   ip_table_to   in varchar2,
   op_sql        out clob
  )
  as
    subtype oracle_name_len is pls_integer range 1 .. 32;
    v_first      boolean := true;
    v_format_len oracle_name_len;
  begin
    p_table_exists(ip_table_from);

     select max(length(t.column_name))
     into v_format_len
     from user_tab_columns t
     where t.table_name = ip_table_from;

     v_format_len := v_format_len + 2; -- extend on two symbol ""

     for cur in
       (
        select u.table_name, u.column_name column_name
        from user_tab_columns u
        where u.table_name = ip_table_from
        order by u.column_id
       )
     loop
       if v_first then
          op_sql := rpad('"'||cur.column_name||'"',v_format_len,' ')||' '||f_column_data_type(cur.table_name,cur.column_name);
          v_first := false;
       else
          op_sql := op_sql||','||c_enter||rpad('"'||cur.column_name||'"',v_format_len,' ')||' '||f_column_data_type(cur.table_name,cur.column_name);
       end if;
     end loop;

     -- final
     op_sql := 'create table '||ip_table_to||c_enter||
               '('                         ||c_enter||
               op_sql                      ||c_enter||
               ')'                         ||c_enter||
               'segment creation deferred' ||c_enter||
               'partition by list (kf)'    ||c_enter||
               '';
    end p_interim_sql_table;    

    procedure p_ep_sql_subpartition
    -- for exchange partition
    (
     ip_table      in varchar2,
     ip_partition  in varchar2,
     op_sql        out clob
    )
    as
     v_subpartitioning_type   user_part_tables.subpartitioning_type%type;
     v_subpart_column         user_subpart_key_columns.column_name%type;
     v_first                  boolean := true;
    begin
      p_table_exists(ip_table);

      p_partition_exists(ip_table,ip_partition);

      -- check subpartition and get subpartition type
      begin
        select t.subpartitioning_type
        into v_subpartitioning_type
        from user_part_tables t
        where t.table_name = ip_table;
      exception
        when no_data_found then
          v_subpartitioning_type := 'NONE';
      end;

      if v_subpartitioning_type <> 'NONE' then
          select k.column_name
          into  v_subpart_column
          from user_subpart_key_columns k
          where k.name = ip_table
            and k.object_type = 'TABLE';

          for cur in
            (
             select t.subpartition_name, t.high_value
             from user_tab_subpartitions t
             where t.table_name = ip_table
               and t.partition_name = ip_partition
            )
          loop
            if v_first then
               op_sql := 'partition by '||v_subpartitioning_type||' ('||v_subpart_column||')'||c_enter||
                   '(' ||c_enter;
               op_sql := op_sql||'  partition '||cur.subpartition_name||' values ('||cur.high_value||')';
               v_first := false;
            else
               op_sql := op_sql||','||c_enter||'  partition '||cur.subpartition_name||' values ('||cur.high_value||')';
            end if;
          end loop;
          if op_sql is not null then
             op_sql := op_sql || c_enter || ')';
          end if;
       end if;

    end p_ep_sql_subpartition;

    procedure p_ep_table_create
    (
     ip_table_from      in varchar ,
     ip_partition_from  in varchar2,
     ip_table_to        in varchar2
    )
    as
     v_sql           clob;
     v_sql_table     clob;
     v_sql_partition clob;
    begin
     p_ep_sql_table       (ip_table_from, ip_table_to, v_sql_table);
     p_ep_sql_subpartition(ip_table_from, ip_partition_from, v_sql_partition);
     v_sql := v_sql_table || v_sql_partition;
     execute_immediate(v_sql);

    end p_ep_table_create;

    function f_index_unique_name
    return varchar2
    as
     v_rn number(4);
    begin
      with id_list
      as
      (
      select to_number(substr(u.index_name, 5)) as rn
      from user_indexes u
      where regexp_like(u.index_name,'^IDX_\d\d\d\d$')
      )

      select coalesce(min(case when rn <> must_be_rn then must_be_rn end), max(rn) + 1, 1)
      into v_rn
      from
         (
          select rn, row_number() over (order by rn) as must_be_rn
          from id_list
         );

      return 'IDX_'||lpad(to_char(v_rn),4,'0');
    end f_index_unique_name;

    procedure p_ep_index_copy
    (
     ip_table_from        in varchar2,
     ip_index_from        in varchar2,
     ip_table_to          in varchar2
    )
    as
     v_sql_index     clob;
     v_handle        number;
     v_ddl_handle    number;
     v_modify_handle number;
     v_index_to      varchar2(30);

    function f_add_local
    return boolean
    as
     v_locality  number(1);
     v_partition number(1);
    begin
      begin
        select 1
        into v_locality
        from user_part_indexes i
        where i.index_name = ip_index_from
          and i.locality = 'LOCAL';
      exception
        when no_data_found then
          v_locality := 0;
      end;

      begin
        select 1
        into v_partition
        from user_tables u
        where u.table_name = ip_table_to
          and u.partitioned = 'YES';
      exception
        when no_data_found then
          v_partition := 0;
      end;

      return (v_locality = v_partition);
    end f_add_local;

    begin

     dbms_lob.createtemporary(v_sql_index, true);
     v_handle := dbms_metadata.open('INDEX');
     dbms_metadata.set_filter(v_handle, 'NAME', ip_index_from);

     v_modify_handle := dbms_metadata.add_transform(v_handle,'MODIFY');

     v_index_to := f_index_unique_name;

     dbms_metadata.set_remap_param (v_modify_handle,'REMAP_NAME',ip_table_from,ip_table_to);
     dbms_metadata.set_remap_param (v_modify_handle,'REMAP_NAME',ip_index_from, v_index_to);

     v_ddl_handle  := dbms_metadata.add_transform(v_handle, 'DDL');
     dbms_metadata.set_transform_param(v_ddl_handle, 'STORAGE', false);
     dbms_metadata.set_transform_param(v_ddl_handle, 'PARTITIONING', false);

     v_sql_index := dbms_metadata.fetch_clob(v_handle);
     dbms_metadata.close(v_handle);

     -- add local
     if f_add_local then
        v_sql_index := v_sql_index || ' LOCAL';
     end if;
     execute_immediate(v_sql_index);

    end p_ep_index_copy;

    procedure p_ep_indexes_copy
    (
     ip_table_from in varchar2,
     ip_table_to   in varchar2
    )
    as
     v_index_not_partitioned number(1);
    begin

      begin
        select 1
        into v_index_not_partitioned
        from user_indexes u
        where u.table_name = ip_table_from
          and u.partitioned = 'NO'
          and rownum = 1;
       exception
         when no_data_found then
           v_index_not_partitioned := 0;
       end;
     -- if existing non partitioned then copy only index for P or U constraint
     -- else copy all indexes
      if v_index_not_partitioned = 1 then
         for cur in
           (
            select u.index_name
            from user_constraints u
            where u.table_name = ip_table_from
              and u.constraint_type in ('P','U')
              and u.index_name is not null
           )
         loop
           p_ep_index_copy(ip_table_from,cur.index_name, ip_table_to);
         end loop;

      else

        for cur in
          (
           select u.index_name
           from user_indexes u
           where u.table_name = ip_table_from
             and u.index_type <> 'LOB'
          )
        loop
          p_ep_index_copy(ip_table_from,cur.index_name, ip_table_to);
        end loop;

      end if;

    end p_ep_indexes_copy;

    function f_constraint_uq_name
    return varchar2
    as
     v_rn number(4);
    begin
      with id_list
      as
      (
      select to_number(substr(u.constraint_name, 5)) as rn
      from user_constraints u
      where regexp_like(u.constraint_name,'^CNS_\d\d\d\d$')
      )

      select coalesce(min(case when rn <> must_be_rn then must_be_rn end), max(rn) + 1, 1)
      into v_rn
      from
         (
          select rn, row_number() over (order by rn) as must_be_rn
          from id_list
         );

      return 'CNS_'||lpad(to_char(v_rn),4,'0');
    end f_constraint_uq_name;


    procedure p_constraint_pk_copy
    (
     ip_constraint_from   in varchar2,
     ip_table_to          in varchar2
    )
    as
     v_constraint_type_cd    user_constraints.constraint_type%type;
     v_constraint_type_name  varchar2(30);
     v_constraint_name       varchar2(30);
     v_constraint_columns    varchar2(2000);
     v_sql                   varchar2(2000);
    begin
     -- constraint type
     begin
       select u.constraint_type
       into v_constraint_type_cd
       from user_constraints u
       where u.constraint_name = ip_constraint_from;
     exception
       when no_data_found then
         p_exception(0,'Constraint '||ip_constraint_from||' not found in database');
     end;

     case v_constraint_type_cd
       when 'P' then v_constraint_type_name := 'PRIMARY KEY';
       when 'U' then v_constraint_type_name := 'UNIQUE';
       else p_exception(0,'Constraint '||ip_constraint_from||' type '||v_constraint_type_cd||' but expected "U" or "P"');
     end case;

     v_constraint_name := f_constraint_uq_name;

     select '(' ||
            listagg('"' || v.column_name || '"',',') within group (order by v.position) ||
            ')'
     into v_constraint_columns
     from user_cons_columns v
     where v.constraint_name = ip_constraint_from;

     v_sql := ' alter table '||ip_table_to ||c_enter||
              ' add constraint '||v_constraint_name||' '||v_constraint_type_name||' '||v_constraint_columns;

     execute_immediate(v_sql);

    end p_constraint_pk_copy;

    procedure p_constraint_ref_copy
    (
     ip_table_from        in varchar2,
     ip_constraint_from   in varchar2,
     ip_table_to          in varchar2
    )
    as
     v_result         clob;
     v_buffer         clob;
     v_handle         number;
     v_ddl_handle     number;
     v_modify_handle  number;
     v_object_type    varchar2(19) := 'REF_CONSTRAINT';
     v_constraint_to  varchar2(30);
    begin

     dbms_lob.createtemporary(v_result, true);

     v_handle := dbms_metadata.open(v_object_type);
     dbms_metadata.set_filter(v_handle, 'NAME', ip_constraint_from, v_object_type);

     v_modify_handle := dbms_metadata.add_transform(v_handle,'MODIFY');

     v_constraint_to := f_constraint_uq_name;

     dbms_metadata.set_remap_param (v_modify_handle,'REMAP_NAME',ip_constraint_from, v_constraint_to ,v_object_type);
     dbms_metadata.set_remap_param (v_modify_handle,'REMAP_NAME',ip_table_from,      ip_table_to     ,v_object_type);

     --v_ddl_handle  := dbms_metadata.add_transform(v_handle, 'DDL');

     loop
       v_buffer := dbms_metadata.fetch_clob(v_handle);
       if v_buffer is null then
         exit;
       else
         dbms_lob.append(v_result, v_buffer);
       end if;
     end loop;

     execute_immediate(v_result);

    end p_constraint_ref_copy;

    procedure p_constraints_copy
    (
     ip_from_table in varchar2,
     ip_to_table   in varchar2
    )
    as
    begin
      for cur in
        (
         select u.constraint_name, u.constraint_type
         from user_constraints u
         where u.table_name = ip_from_table
           and u.constraint_type in ('P','U','R')
        )
      loop
        case cur.constraint_type
          when 'P' then p_constraint_pk_copy(cur.constraint_name,ip_to_table);
          when 'U' then p_constraint_pk_copy(cur.constraint_name,ip_to_table);
          when 'R' then p_constraint_ref_copy(ip_from_table,cur.constraint_name, ip_to_table);
       end case;
      end loop;
    end p_constraints_copy;

    procedure p_indexe_rebuild
    (
     ip_index in varchar2
    )
    as
    begin
      execute_immediate('alter index '||ip_index||' rebuild parallel 4');
    end p_indexe_rebuild;

    procedure p_indexe_partition_rebuild
    (
     ip_index      in varchar2,
     ip_partition  in varchar2
    )
    as
    begin
      execute_immediate('alter index '||ip_index||' rebuild partition '||ip_partition||' parallel 4');
    end p_indexe_partition_rebuild;

    procedure p_indexe_subpartition_rebuild
    (
     ip_index      in varchar2,
     ip_subpartition  in varchar2
    )
    as
    begin
      execute_immediate('alter index '||ip_index||' rebuild subpartition '||ip_subpartition||' parallel 4');
    end p_indexe_subpartition_rebuild;

    procedure p_indexes_rebuild
    (
     ip_table  in varchar2
    )
    as
    begin
      -- rebuild unusable global indexes
      for cur in
        (
         select u.index_name
         from user_indexes u
         where u.status = 'UNUSABLE'
           and u.table_name = ip_table
        )
      loop
        p_indexe_rebuild(cur.index_name);
      end loop;

      -- rebuild unusable partition indexes
      for part in
        (
         select p.index_name, p.partition_name
         from user_indexes        u,
              user_ind_partitions p
         where u.table_name = ip_table
           and u.partitioned = 'YES'
           and p.index_name = u.index_name
           and p.status = 'UNUSABLE'
         )
       loop
         p_indexe_partition_rebuild(part.index_name, part.partition_name);
       end loop;

      -- rebuild unusable subpartition indexes
      for subpart in
        (
         select p.index_name, p.subpartition_name
         from user_indexes        u,
              user_ind_subpartitions p
         where u.table_name = ip_table
           and u.partitioned = 'YES'
           and p.index_name = u.index_name
           and p.status = 'UNUSABLE'
         )
       loop
         p_indexe_subpartition_rebuild(subpart.index_name, subpart.subpartition_name);
       end loop;

    end p_indexes_rebuild;

    procedure p_ep_exchange_partition
    (
    ip_table      in varchar2,
    ip_partition  in varchar2,
    ip_with_table in varchar2
    )
    as
     v_sql                      varchar2(2000);

     function f_including_indexes
     return boolean
     as
      v_including_indexes        boolean;
      v_index_count_in_table     number;
      v_index_count_in_tmp_table number;
       procedure p_count_indexes
       (
        ip_count_table   in varchar2,
        op_indexes_count out number
       )
       as
       begin
         select count(*)
         into op_indexes_count
         from user_indexes u
         where u.table_name = ip_count_table;
       end p_count_indexes;
     begin
      p_count_indexes(ip_table, v_index_count_in_table);
      p_count_indexes(ip_with_table, v_index_count_in_tmp_table);
      v_including_indexes := (v_index_count_in_table = v_index_count_in_tmp_table);
      return v_including_indexes;
     end f_including_indexes;
    begin
      p_ep_indexes_copy(ip_table, ip_with_table);
      p_constraints_copy(ip_table, ip_with_table);

      v_sql := ' alter table '||ip_table               ||c_enter||
               ' exchange partition '||ip_partition    ||c_enter||
               ' with table '||ip_with_table           ||c_enter||
               case when f_including_indexes then ' including indexes'||c_enter else null end ||
               ' without validation'                   ||c_enter
               ;
      execute_immediate(v_sql);
      -- clear constraint
      p_constraints_drop(ip_with_table);
      p_indexes_rebuild(ip_table);

    end p_ep_exchange_partition;


-- set degree for table and all tables indices
  procedure p_indexes_set_degree(ip_table_name in varchar2, ip_degree in number)
  as
  begin
    p_table_set_degree(ip_table_name =>ip_table_name,ip_degree =>ip_degree);
    for rec in (select i.index_name from user_indexes i where i.table_name = ip_table_name) loop
      p_index_set_degree (ip_index_name => rec.index_name, ip_degree => ip_degree);
    end loop;
  end p_indexes_set_degree;

  -- set degree for table
  procedure p_table_set_degree(ip_table_name in varchar2, ip_degree in number)
  as
   l_sql varchar2(2000);
  begin
    l_sql := 'alter table '||ip_table_name||' parallel '||to_char(ip_degree);
    execute_immediate(ip_sql =>l_sql);
  end p_table_set_degree;


  -- set degree for index
  procedure p_index_set_degree(ip_index_name in varchar2, ip_degree in number)
  as
   l_sql varchar2(2000);
  begin
    l_sql := 'alter index '||ip_index_name||' parallel '||to_char(ip_degree);
    execute_immediate(ip_sql =>l_sql);
  end p_index_set_degree;

  procedure p_partition_truncate(ip_table_name in varchar2, ip_partition_name in varchar2)
  as
    l_sql varchar2(2000);
  begin
    l_sql := 'alter table '||ip_table_name||' truncate partition '||(ip_partition_name);
    execute_immediate(ip_sql =>l_sql);
  end p_partition_truncate;

  procedure p_drop_table(ip_table_name in varchar2)
  is
    v_cnt number;
  begin
   select (select count(1)
            from user_constraints a
             join user_constraints u
               on u.constraint_type='R'
              and u.r_constraint_name=a.constraint_name
            where a.constraint_type='P'
              and a.table_name=upper(ip_table_name))
           +
        (select count(1)
           from dba_dependencies d
          where d.owner=user
            and d.referenced_type='TABLE'
              and d.referenced_name=upper(ip_table_name))
     into v_cnt
    from dual;
    if v_cnt!=0 then
       dbms_output.put_line('Table in use. Delete is impossible');
    else
       execute immediate 'drop table '||ip_table_name;
       dbms_output.put_line('Table is dropped');
    end if;
  end;


  procedure p_table_row_exist
  (
   ip_table in varchar2,
   ip_rowid in rowid
  )
  as
   v_exist number;
  begin
   p_table_exists(ip_table);
   if ip_rowid is null then
      p_exception(0,'Params ip_rowid of procedure p_table_row_exist is null');
   end if;

   begin
    execute immediate
     'select 1
      from '||ip_table||'
      where rowid = '''||ip_rowid||''''
    into v_exist;
   exception
     when no_data_found then
       p_exception(0,'Record with rowid = '''||ip_rowid||''' for table '||ip_table||' not exists');
   end;
  end p_table_row_exist;

  procedure p_table_column_nullable
  (
   ip_table    in varchar2,
   ip_column   in varchar2,
   op_nullable out varchar2
  )
  as

  begin
   p_table_column_exists(ip_table,ip_column);

   select u.nullable
   into op_nullable
   from user_tab_columns u
   where u.table_name = ip_table
     and u.column_name = ip_column;

  end p_table_column_nullable;


  procedure p_err$_column_find
  (
   ip_err$_table in varchar2,
   ip_err$_rowid in rowid,
   ip_table      in varchar2
  )
  as
   ---------------------------------
   procedure p_column_value_check
   (
    ip_table      in varchar2,
    ip_err$_table in varchar2,
    ip_err$_rowid in rowid,
    ip_column     in varchar2
   )
   as
    v_data_type      varchar2(100);
    v_nullable_sign  varchar2(1);
    c_nullable_sql   constant varchar2(200) := c_enter||
                                               'if v is null then '                ||c_enter||
                                               '   raise insert_null_into_notnull;'||c_enter||
                                               'end if;'                           ||c_enter;
   begin
     v_data_type := f_variable_data_type(ip_table, ip_column);
     p_table_column_nullable(ip_table, ip_column, v_nullable_sign);

     begin
       execute immediate '
       declare
        v '||v_data_type||';
        insert_null_into_notnull exception;
        pragma exception_init(insert_null_into_notnull, -1400);
       begin
         select '||ip_column||'
         into v
         from '||ip_err$_table||' e
         where e.rowid = '''||ip_err$_rowid||''';'||
        case v_nullable_sign when 'N' then c_nullable_sql else null end|| -- add check on nullable
       'end;';
     exception
      when mgr_utl.insert_null_into_notnull then
        p_exception(1,'Table '||ip_table||' column '||ip_column||
                    ' ORA-01400: Cannot insert null into '||ip_table||'.'||ip_column);
      when no_data_found then
        p_exception(0,'Record with rowid = '''||ip_err$_rowid||''' for table '||ip_err$_table||' not exists');
      when others then
        p_exception(1,'Table '||ip_table||' column '||ip_column||' '||sqlerrm);
     end;
   end p_column_value_check;
   ------------------------------
   procedure p_column_not_exists
   (
    ip_err$_table in varchar2,
    ip_table      in varchar2
   )
   as
   begin
     for cur in
       (
         select m.column_name
         from user_tab_cols m
         where m.table_name = ip_table
           and m.hidden_column  = 'NO'
           and m.virtual_column = 'NO'
           and not exists (
                            select null
                            from user_tab_columns e
                            where e.table_name = ip_err$_table
                              and e.column_name = m.column_name
                           )
        )
      loop
        p_exception(1,rpad(cur.column_name,30,' ')|| ' not exists in table '||ip_err$_table);
      end loop;
   end p_column_not_exists;
  begin
    -- check params
    p_table_exists(ip_err$_table);
    p_table_exists(ip_table);
    p_table_row_exist(ip_err$_table,ip_err$_rowid);
    p_column_not_exists(ip_err$_table,ip_table);

    for cur in
      (
       select m.column_name
       from user_tab_columns m,
            user_tab_columns e
       where m.table_name = ip_table
         and e.table_name = ip_err$_table
         and m.column_name = e.column_name
       order by m.column_id
       )
     loop
       p_column_value_check(ip_table, ip_err$_table, ip_err$_rowid, cur.column_name);
     end loop;
  end p_err$_column_find;
  
  --
  -- EXCHANGE PARTITION BY NAME
  --
  procedure EXCHANGE_PARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_partition_nm      in     all_tab_subpartitions.partition_name%type 
  ) is
  begin
    
    bars.bars_audit.trace( 'mgr_utl.exchange_partition: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_part_nm=%s).'
                         , p_source_table_nm, p_target_table_nm, p_partition_nm );
    
    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!' );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!' );
      when ( p_partition_nm    Is Null )
      then raise_application_error( -20666, 'Parameter [p_partition_nm] must be specified!' );
      else null;
    end case;
    
    execute immediate 'ALTER TABLE BARS.'   ||p_target_table_nm||
                      ' EXCHANGE PARTITION '||p_partition_nm   ||
                      ' WITH TABLE BARS.'   ||p_source_table_nm||
                      ' INCLUDING INDEXES WITHOUT VALIDATION ';
    
    bars.bars_audit.trace( 'mgr_utl.exchange_partition: Exit.'  );
    
  end EXCHANGE_PARTITION;
  
  --
  -- EXCHANGE PARTITION BY CONDITION FOR
  --
  PROCEDURE EXCHANGE_PARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  ) is
  begin
    
    bars.bars_audit.trace( 'mgr_utl.exchange_partition_for: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_condition=%s).'
                         , p_source_table_nm, p_target_table_nm, p_condition );
    
    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!' );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!' );
      when ( p_condition       Is Null )
      then raise_application_error( -20666, 'Parameter [p_condition] must be specified!' );
      else null;
    end case;
    
    -- partition is first locked to ensure that the partition is created
    execute immediate 'LOCK TABLE BARS.'||p_target_table_nm||
                      ' PARTITION FOR ' ||p_condition      ||
                      ' IN SHARE MODE';
    
    execute immediate 'ALTER TABLE BARS.'       ||p_target_table_nm||
                      ' EXCHANGE PARTITION FOR '||p_condition      ||
                      ' WITH TABLE BARS.'       ||p_source_table_nm||
                      ' INCLUDING INDEXES WITHOUT VALIDATION ';
    
    bars.bars_audit.trace( 'mgr_utl.exchange_partition_for: Exit.'  );
    
  end EXCHANGE_PARTITION_FOR;
  
  --
  -- EXCHANGE SUBPARTITION BY NAME
  --
  PROCEDURE EXCHANGE_SUBPARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_subpartition_nm   in     all_tab_subpartitions.subpartition_name%type 
  ) is
  begin
    
    bars.bars_audit.trace( 'mgr_utl.exchange_subpartition: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_subpart_nm=%s).'
                         , p_source_table_nm, p_target_table_nm, p_subpartition_nm );
    
    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!', true );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!', true );
      when ( p_subpartition_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_subpartition_nm] must be specified!', true );
      else null;
    end case;
    
    execute immediate 'ALTER TABLE BARS.'      ||p_target_table_nm||
                      ' EXCHANGE SUBPARTITION '||p_subpartition_nm||
                      ' WITH TABLE BARS.'      ||p_source_table_nm||
                      ' INCLUDING INDEXES WITHOUT VALIDATION ';
    
    bars.bars_audit.trace( 'mgr_utl.exchange_subpartition: Exit.'  );
    
  end EXCHANGE_SUBPARTITION;
  
  --
  -- EXCHANGE SUBPARTITION BY CONDITION FOR
  --
  PROCEDURE EXCHANGE_SUBPARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  ) is
  /**
  <b>EXCHANGE_SUBPARTITION_FOR</b> - EXCHANGE SUBPARTITION without specified SUBPARTITION NAME (by section key)
  %param p_source_table_nm - source table name
  %param p_target_table_nm - target table name
  %param p_condition       - section key for subpartition
  */
    title   constant  varchar2(60) := 'mgr_utl.exchange_subpartition_for';
  begin
    
    bars.bars_audit.trace( '%s: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_condition=%s).'
                         , title, p_source_table_nm, p_target_table_nm, p_condition );
    
    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!' );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!' );
      when ( p_condition       Is Null )
      then raise_application_error( -20666, 'Parameter [p_condition] must be specified!' );
      else null;
    end case;
    
    -- subpartition is first locked to ensure that the partition is created
    execute immediate 'LOCK TABLE BARS.'  ||p_target_table_nm||
                      ' SUBPARTITION FOR '||p_condition      ||
                      ' IN SHARE MODE';
    
    begin
      execute immediate 'ALTER TABLE BARS.'          ||p_target_table_nm||
                        ' EXCHANGE SUBPARTITION FOR '||p_condition      ||
                        ' WITH TABLE BARS.'          ||p_source_table_nm||
                        ' INCLUDING INDEXES WITHOUT VALIDATION ';
    exception
      when ERR_COLUMN_MISMATCH then
        bars_audit.error( title || ': Невідповідність типу або розміру полів таблиць ' || p_target_table_nm || ' та ' || p_source_table_nm 
                                || chr(10) || dbms_utility.format_error_backtrace() );
        raise ERR_COLUMN_MISMATCH;
        /*
        -- compare table columns and write diff log in sec_audit
        select * 
          from all_tab_columns
         where owner = 'BARS'
           and table_name = 'AGG_MONBALS'
        */
      when ERR_INDEX_MISMATCH then
        bars_audit.error( title || ': Невідповідність структури індексу таблиць ' || p_target_table_nm || ' та ' || p_source_table_nm 
                                || chr(10) || dbms_utility.format_error_backtrace() );
        raise ERR_INDEX_MISMATCH;
    end;
    
    bars.bars_audit.trace( 'mgr_utl.exchange_subpartition_for: Exit.'  );
    
  end EXCHANGE_SUBPARTITION_FOR;
  
 procedure p_migration_jobs(  p_row_from number
                             , p_row_to number
                             , p_sleep number default 0.1
                             , p_sleep_after boolean default true
                             , p_streems_count number default 24
                             /*, p_schema varchar2 default null
                             , p_dblink varchar2 default null*/)
    is 
   
   c_sleep number := p_sleep;
   c_sleep_after boolean := p_sleep_after;
   --v_i NUMBER := 0;
       
   l_job_cnt number := 0;
   l_next_step boolean := false;
      
   l_stmt_g      VARCHAR2(255) := 'begin bars_login.login_user'||rtrim(concat('@', ltrim(g_dblink, '@')), '@')||'(sys_guid,1,null,null); end;';
   
  begin 

      --execute immediate l_stmt_g;

  for rec in 
        ( select  t.numb, t.proc
            from TMP_MIGRATION t 
           where t.numb >= p_row_from
             and t.numb <= p_row_to
           order by t.numb)     
    loop        
      loop        
        l_next_step := false;
          
        select count(*)
        into l_job_cnt
        from dba_scheduler_running_jobs
          where JOB_NAME like 'B%'
            and length (JOB_NAME) < 7
            and substr(JOB_NAME, 2, 5) >= p_row_from 
            and substr(JOB_NAME, 2, 5) <= p_row_to;
        
        if l_job_cnt < p_streems_count
          then
            begin
                dbms_scheduler.create_job( job_name => 'B'||rec.numb
                                         , job_type => 'PLSQL_BLOCK'
                                         , job_action => 'begin 
                                                            ikf('''||g_kf||''');
                                                            ikfdblink(p_schema => '''||g_schema||''', p_dblink => '''||g_dblink||''');
                                                            '||l_stmt_g||'
                                                            '||rec.proc||'
                                                          end;' 
                                         , enabled => TRUE);
        --        v_i := v_i + 1;
                l_next_step := true;
                dbms_lock.sleep(c_sleep);
            end;
        else dbms_lock.sleep(10);
             l_next_step := false;
        end if;   
        exit when l_next_step = true;       
      end loop; 
    end loop; 
      
      if c_sleep_after = true then
        loop  
                 
          l_next_step := false;
            
          select count(*)
          into l_job_cnt
          from dba_scheduler_running_jobs
          where JOB_NAME like 'B%'
            and length (JOB_NAME) < 7
            and substr(JOB_NAME, 2, 5) >= p_row_from 
            and substr(JOB_NAME, 2, 5) <= p_row_to;
          
          if l_job_cnt > 0
            then dbms_lock.sleep(10);
          else l_next_step := true;
          end if;   
          exit when l_next_step = true;       
        end loop;
     end if;
  end p_migration_jobs;
  
/*  procedure merge_table_auto(
                          p_table varchar2,
                          p_matched boolean default true,
                          p_not_matched boolean default true,
                          p_column_match varchar2 default null,    
                          p_column_replace varchar2 default null
                        ) 
    is
    
    l_table    varchar2(30) := upper(p_table);
      
      cursor c_c is
        (
        select t.COLUMN_ID rn
             , cast(t.COLUMN_NAME as varchar2(255)) as COLUMN_NAME
          from all_tab_cols t
         where t.TABLE_NAME = l_table
           and t.owner = 'KF'||g_kf
        );

      cursor c_cc is  
        (
        select rownum rn
             , cc.column_name
          from dba_constraints c
          join dba_cons_columns cc
            on c.constraint_name = cc.constraint_name
         where c.TABLE_NAME = l_table
           and c.owner = upper('BARS')
           and c.CONSTRAINT_TYPE = 'P'
        );
        
      cursor c_tab is  
        (    
        select row_number() over( order by t.column_id ) rn
             , t.column_id 
             , '  t.'||t.COLUMN_NAME cn
             , case when t.COLUMN_NAME = 'KF' and tt.COLUMN_NAME is null then ''''||g_kf||'''' 
                    when tt.COLUMN_NAME is null then null 
               else '  tt.'||tt.COLUMN_NAME end cnk
          from all_tab_cols t
          left join all_tab_cols tt
            on t.TABLE_NAME = tt.TABLE_NAME
           and t.COLUMN_NAME = tt.COLUMN_NAME
           and tt.owner = 'KF'||g_kf
          left join (select cc.column_name
                       from dba_constraints c
                       join dba_cons_columns cc
                         on c.constraint_name = cc.constraint_name
                      where c.TABLE_NAME = l_table
                        and c.owner = upper('BARS')
                        and c.CONSTRAINT_TYPE = 'P') ttt
            on t.column_name = ttt.column_name
         where t.TABLE_NAME = l_table
           and t.owner = 'BARS'
           and ttt.column_name is null
        );
       
      cursor c_ins is
        (    
        select t.column_id 
             , 't.'||t.COLUMN_NAME cn
             , case when t.COLUMN_NAME = 'KF' and tt.COLUMN_NAME is null then ''''||g_kf||'''' 
                    when tt.COLUMN_NAME is null then 'null' 
               else '  tt.'||tt.COLUMN_NAME end cnk
          from all_tab_cols t
          left join all_tab_cols tt
            on t.TABLE_NAME = tt.TABLE_NAME
           and t.COLUMN_NAME = tt.COLUMN_NAME
           and tt.owner = 'KF'||g_kf
         where t.TABLE_NAME = l_table
           and t.owner = 'BARS'
        );

    l_stmt     varchar2(4000);
    l_ins_cols varchar2(4000);
    l_sel_cols varchar2(4000);
    l_col      varchar2(256);
    l_kf       varchar2(6);
    l_include       boolean;
    l_tab_exists    number;
    l_tab_length    BINARY_INTEGER;    
    l_array         DBMS_UTILITY.lname_array;
    type t_colrep is table of varchar2(4000) index by varchar2(30);
    l_colrep        t_colrep;
    l_index         pls_integer;
    l_column        varchar2(30);
    l_replace       varchar2(4000);
    l_nullable      varchar2(1);
    l_datadefault   varchar2(1024); 
 
----------------------------------------------------------------------------------------------        
    begin  

        -- посмотрим существует ли исходная таблица
        l_kf := mgr_utl.get_kf();
        begin
            select 1
              into l_tab_exists
              from all_tables
             where owner='KF'||l_kf
               and table_name=l_table;
        exception
            when no_data_found then
                l_tab_exists := 0;
        end;
        --
        if l_tab_exists=0
        then
            raise_application_error(-20000, 'Таблица KF'||l_kf||'.'||l_table||' не существует. Импорт не выполняем.');
        end if;
        --
        -- обрабатываем p_column_replace
        --
        if p_column_replace is not null
        then
            dbms_utility.comma_to_table(
                list    => p_column_replace,
                tablen  => l_tab_length,
                tab     => l_array
            );
            l_index := 1;
            while l_index < l_tab_length
            loop
                l_column := upper(trim(l_array(l_index)));
                l_replace := trim(l_array(l_index+1));
                if l_replace like '"%"'
                then
                    l_replace := substr(l_replace, 2, length(l_replace)-2);
                end if;
                l_colrep(l_column) := l_replace;
                mgr_utl.trace('Колонка %s будет заменена на выражение %s', l_column, l_replace);

                l_index := l_index + 2;
            end loop;
        end if;
      
      --START FORMING MERGE STATEMENT
      l_stmt := '';
      
      l_stmt := concat(l_stmt, 'merge into '||l_table||' t using '||chr(13));   
      l_stmt := concat(l_stmt, '(select '||chr(13));   
           
      for rec in c_c      
      loop
            l_index := 1;
            while l_index < l_tab_length
            loop
               if upper(l_array(l_index)) = rec.column_name
                 then rec.column_name := upper(substr(l_array(l_index+1), 2, length(l_array(l_index+1))-2))||' as '||rec.column_name;
               end if;
               l_index := l_index + 2;
            end loop;
        if rec.rn = 1 
          then l_stmt := concat(l_stmt, rec.column_name||chr(13));   
        else   l_stmt := concat(l_stmt, ','||rec.column_name||chr(13));   
        end if;
      end loop;

      l_stmt := concat(l_stmt, 'from '||mgr_utl.pkf(l_table)||' ) tt '||chr(13));   
      --ON
        --
        -- обрабатываем p_column_match
        --
      if p_column_match is not null
      then
          dbms_utility.comma_to_table(
              list    => p_column_match,
              tablen  => l_tab_length,
              tab     => l_array
          );
          l_index := 1;
          while l_index < l_tab_length + 1
          loop
              l_column := upper(trim(l_array(l_index)));
              if l_index = 1 
                then l_stmt := concat(l_stmt, 'ON( t.'||l_array(l_index)||' = tt.'||l_array(l_index)||chr(13));   
              elsif l_index > 1 
                then l_stmt := concat(l_stmt, 'AND t.'||l_array(l_index)||' = tt.'||l_array(l_index)||chr(13));   
              --else l_stmt := concat(l_stmt, 'ON( 1 = 0'||chr(13));
              end if;
              l_index := l_index + 1;
          end loop;

      else

          for rec in c_cc                 
          loop
            
            if rec.rn = 1 
              then l_stmt := concat(l_stmt, 'ON( t.'||rec.column_name||' = tt.'||rec.column_name||chr(13));   
            elsif rec.rn > 1 
              then l_stmt := concat(l_stmt, 'AND t.'||rec.column_name||' = tt.'||rec.column_name||chr(13));   
            else l_stmt := concat(l_stmt, 'ON( 1 = 0'||chr(13));
            end if;
          end loop;

      end if;

      l_stmt := concat(l_stmt, ')');   

      --WHEN MATCHED PART
      if p_matched = true then    
          l_stmt := concat(l_stmt, 'when matched then update set '||chr(13));   
          
          if p_column_match is not null
          then
              for rec in c_ins      
              loop
                    l_index := 1;
                    l_include := false;
                    while l_index < l_tab_length + 1
                    loop
                       if upper('t.'||l_array(l_index)) = upper(rec.cn)
                         then l_include := true;
                       end if;
                       l_index := l_index + 1;
                    end loop;
                    if l_include = false 
                      then
                        l_stmt := concat(l_stmt, rec.cn||' = '||rec.cnk||', '||chr(13));   
                    end if;
              end loop;
              
              l_stmt := rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(l_stmt, ', '||chr(13))
                        , chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13));
          else

              for rec in c_tab 
              loop
                if rec.rn = 1 
                  then l_stmt := concat(l_stmt, rec.cn||' = '||rec.cnk||chr(13));   
                  else l_stmt := concat(l_stmt, ', '||rec.cn||' = '||rec.cnk||chr(13));   
                end if;
              end loop;
          
        end if;
      end if;
              l_stmt := l_stmt||chr(13);       
      --WHEN NOT MATCHED PART
      if p_not_matched = true then    
          l_stmt := concat(l_stmt, 'when not matched then insert values ('||chr(13));   

          for rec in 
                    (    
                    select t.column_id 
                         , 't.'||t.COLUMN_NAME cn
                         , case when t.COLUMN_NAME = 'KF' and tt.COLUMN_NAME is null then ''''||g_kf||'''' 
                                when tt.COLUMN_NAME is null then 'null' 
                           else '  tt.'||tt.COLUMN_NAME end cnk
                      from all_tab_cols t
                      left join all_tab_cols tt
                        on t.TABLE_NAME = tt.TABLE_NAME
                       and t.COLUMN_NAME = tt.COLUMN_NAME
                       and tt.owner = 'KF'||g_kf
                     where t.TABLE_NAME = l_table
                       and t.owner = 'BARS'
                     order by 1
                    )
      
          loop
            l_stmt := concat(l_stmt, rec.cnk||', '||chr(13));   
          end loop;

          l_stmt := rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(l_stmt, ', '||chr(13))
                    , chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13));
          l_stmt := l_stmt||chr(13);  
          l_stmt := concat(l_stmt, ')');  

      end if;
      
      --dbms_output.put_line(l_stmt);
      
      mgr_utl.sync_table(p_table => l_table, p_stmt => l_stmt, p_delete => false);
      
  end merge_table_auto;  */
  
    procedure merge_table_auto(
                          p_table varchar2,
                          p_matched boolean default true,
                          p_not_matched boolean default true,
                          p_column_match varchar2 default null,    
                          p_column_replace varchar2 default null
                        ) 
    is
    
    l_table    varchar2(30) := upper(p_table);
      
      rc_c sys_refcursor;
      type t_rec_c is record
          ( 
            rn           integer,
            column_name    sys.all_tab_cols.column_name%type 
          );
      rec_c t_rec_c;

      cursor c_cc is  
        (
        select rownum rn
             , cc.column_name
          from dba_constraints c
          join dba_cons_columns cc
            on c.constraint_name = cc.constraint_name
           and c.owner = cc.owner
         where c.TABLE_NAME = l_table
           and c.owner = upper('BARS')
           and c.CONSTRAINT_TYPE = 'P'
        );
       
      rc_inc sys_refcursor;
      type t_rec_inc is record
          ( 
            column_id    sys.all_tab_cols.column_id%type,
            cn           sys.all_tab_cols.column_name%type,
            cnk          sys.all_tab_cols.column_name%type
          );
      rec_inc t_rec_inc;

    l_stmt     varchar2(4000);
    l_ins_cols varchar2(4000);
    l_sel_cols varchar2(4000);
    l_col      varchar2(256);
    l_kf       varchar2(6);
    l_include       boolean;
    l_tab_exists    number;
    l_tab_length    BINARY_INTEGER;    
    l_array         DBMS_UTILITY.lname_array;
    type t_colrep is table of varchar2(4000) index by varchar2(30);
    l_colrep        t_colrep;
    l_index         pls_integer;
    l_column        varchar2(30);
    l_replace       varchar2(4000);
    l_nullable      varchar2(1);
    l_datadefault   varchar2(1024); 
 
----------------------------------------------------------------------------------------------        
    begin  

        -- посмотрим существует ли исходная таблица
        l_kf := mgr_utl.get_kf();
        begin
          execute immediate '
            select 1
              from '||regexp_replace(mgr_utl.pkf('all_tables'), 'BARS.', '')||'
             where owner=''BARS''
               and table_name='''||l_table||''''
          into l_tab_exists;
          exception
            when no_data_found then
                l_tab_exists := 0;
        end;
        --
        if l_tab_exists=0
        then
            raise_application_error(-20000, 'Таблица '||l_table||' не существует на источнике. Импорт не выполняем.');
        end if;
        --
        -- обрабатываем p_column_replace
        --
        if p_column_replace is not null
        then
            dbms_utility.comma_to_table(
                list    => p_column_replace,
                tablen  => l_tab_length,
                tab     => l_array
            );
            l_index := 1;
            while l_index < l_tab_length
            loop
                l_column := upper(trim(l_array(l_index)));
                l_replace := trim(l_array(l_index+1));
                if l_replace like '"%"'
                then
                    l_replace := substr(l_replace, 2, length(l_replace)-2);
                end if;
                l_colrep(l_column) := l_replace;
                mgr_utl.trace('Колонка %s будет заменена на выражение %s', l_column, l_replace);

                l_index := l_index + 2;
            end loop;
        end if;
      
      --START FORMING MERGE STATEMENT
      l_stmt := '';
      
      l_stmt := concat(l_stmt, 'merge into '||l_table||' t using '||chr(13));   
      l_stmt := concat(l_stmt, '(select '||chr(13));   
           
      --for rec in c_c      
      --loop
      
      open rc_c for ' select t.COLUMN_ID rn
                           , cast(t.COLUMN_NAME as varchar2(255)) as COLUMN_NAME
                        from '||regexp_replace(mgr_utl.pkf('all_tab_cols'), 'BARS.', '')||' t
                       where t.TABLE_NAME = '''||l_table||'''
                         and t.owner = ''BARS''
                       order by 1';
      while true
      loop
            fetch rc_c into rec_c;
            exit when rc_c%notfound;
            l_index := 1;
            while l_index < l_tab_length
            loop
               if upper(l_array(l_index)) = rec_c.column_name
                 then rec_c.column_name := upper(substr(l_array(l_index+1), 2, length(l_array(l_index+1))-2))||' as '||rec_c.column_name;
               end if;
               l_index := l_index + 2;
            
            end loop;
        if rec_c.rn = 1 
          then l_stmt := concat(l_stmt, rec_c.column_name||chr(13));   
        else   l_stmt := concat(l_stmt, ','||rec_c.column_name||chr(13));   
        end if;
      end loop;
      
      close rc_c;

      l_stmt := concat(l_stmt, 'from '||mgr_utl.pkf(l_table)||' ) tt '||chr(13));   
      --ON
        --
        -- обрабатываем p_column_match
        --
      if p_column_match is not null
      then
          dbms_utility.comma_to_table(
              list    => p_column_match,
              tablen  => l_tab_length,
              tab     => l_array
          );
          l_index := 1;
          while l_index < l_tab_length + 1
          loop
              l_column := upper(trim(l_array(l_index)));
              if l_index = 1 
                then l_stmt := concat(l_stmt, 'ON( t.'||l_array(l_index)||' = tt.'||l_array(l_index)||chr(13));   
              elsif l_index > 1 
                then l_stmt := concat(l_stmt, 'AND t.'||l_array(l_index)||' = tt.'||l_array(l_index)||chr(13));   
              --else l_stmt := concat(l_stmt, 'ON( 1 = 0'||chr(13));
              end if;
              l_index := l_index + 1;
          end loop;

      else

          for rec in c_cc                 
          loop
            
            if rec.rn = 1 
              then l_stmt := concat(l_stmt, 'ON( t.'||rec.column_name||' = tt.'||rec.column_name||chr(13));   
            elsif rec.rn > 1 
              then l_stmt := concat(l_stmt, 'AND t.'||rec.column_name||' = tt.'||rec.column_name||chr(13));   
            else l_stmt := concat(l_stmt, 'ON( 1 = 0'||chr(13));
            end if;
          end loop;

      end if;

      l_stmt := concat(l_stmt, ')');   

      --WHEN MATCHED PART
      if p_matched = true then    
          l_stmt := concat(l_stmt, 'when matched then update set '||chr(13));   
          l_index := 1;
          
          if p_column_match is not null
          then
              open rc_inc for ' select t.column_id 
                                     , ''t.''||t.COLUMN_NAME cn
                                     , case when t.COLUMN_NAME = ''KF'' and tt.COLUMN_NAME is null then '''||g_kf||''' 
                                            when tt.COLUMN_NAME is null then ''null'' 
                                       else ''  tt.''||tt.COLUMN_NAME end cnk
                                  from all_tab_cols t
                                  left join '||regexp_replace(mgr_utl.pkf('all_tab_cols'), 'BARS.', '')||' tt
                                    on t.TABLE_NAME = tt.TABLE_NAME
                                   and t.COLUMN_NAME = tt.COLUMN_NAME
                                   and tt.owner = ''BARS''
                                 where t.TABLE_NAME = '''||l_table||'''
                                   and t.owner = ''BARS''
                                 order by 1'
                                   ;
                
              while true
              loop
                  fetch rc_inc into rec_inc;
                  exit when rc_inc%notfound;
                  
                    l_index := 1;
                    l_include := false;
                    while l_index < l_tab_length + 1
                    loop
                       if upper('t.'||l_array(l_index)) = upper(rec_inc.cn)
                         then l_include := true;
                       end if;
                       l_index := l_index + 1;
                    end loop;
                    if l_include = false 
                      then
                        l_stmt := concat(l_stmt, rec_inc.cn||' = '||rec_inc.cnk||', '||chr(13));   
                    end if;
              end loop;
              
              close rc_inc;
              
              l_stmt := rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(l_stmt, ', '||chr(13))
                        , chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13));
          else

              --for rec in c_inc 
              --loop
              open rc_inc for ' select --row_number() over( order by t.column_id ) rn ,
                                       t.column_id 
                                     , ''t.''||t.COLUMN_NAME cn
                                     , case when t.COLUMN_NAME = ''KF'' and tt.COLUMN_NAME is null then '''||g_kf||''' 
                                            when tt.COLUMN_NAME is null then ''null'' 
                                       else ''tt.''||tt.COLUMN_NAME end cnk
                                  from all_tab_cols t
                                  left join '||regexp_replace(mgr_utl.pkf('all_tab_cols'), 'BARS.', '')||' tt
                                    on t.TABLE_NAME = tt.TABLE_NAME
                                   and t.COLUMN_NAME = tt.COLUMN_NAME
                                   and tt.owner = upper(''BARS'')
                                  left join (select cc.column_name
                                               from all_constraints c
                                               join all_cons_columns cc
                                                 on c.constraint_name = cc.constraint_name
                                                and c.owner = cc.owner
                                              where c.TABLE_NAME = '''||l_table||'''
                                                and c.owner = upper(''BARS'')
                                                and c.CONSTRAINT_TYPE = ''P'') ttt
                                    on t.column_name = ttt.column_name
                                 where t.TABLE_NAME = '''||l_table||'''
                                   and t.owner = ''BARS''
                                   and ttt.column_name is null
                                 order by 1';
              while true
              loop
                
                fetch rc_inc into rec_inc;
                exit when rc_inc%notfound;
              
                if l_index = 1  
                  then l_stmt := concat(l_stmt, rec_inc.cn||' = '||rec_inc.cnk||chr(13));   
                  else l_stmt := concat(l_stmt, ', '||rec_inc.cn||' = '||rec_inc.cnk||chr(13));   
                end if;
                l_index := l_index + 1;
              end loop;
          
        end if;
      end if;
              l_stmt := l_stmt||chr(13);       
      --WHEN NOT MATCHED PART
      if p_not_matched = true then    
          l_stmt := concat(l_stmt, 'when not matched then insert values ('||chr(13));   

              open rc_inc for ' select t.column_id 
                                     , ''t.''||t.COLUMN_NAME cn
                                     , case when t.COLUMN_NAME = ''KF'' and tt.COLUMN_NAME is null then '''||g_kf||''' 
                                            when tt.COLUMN_NAME is null then ''null'' 
                                       else ''  tt.''||tt.COLUMN_NAME end cnk
                                  from all_tab_cols t
                                  left join '||regexp_replace(mgr_utl.pkf('all_tab_cols'), 'BARS.', '')||' tt
                                    on t.TABLE_NAME = tt.TABLE_NAME
                                   and t.COLUMN_NAME = tt.COLUMN_NAME
                                   and tt.owner = ''BARS''
                                 where t.TABLE_NAME = '''||l_table||'''
                                   and t.owner = ''BARS''
                                 order by 1';
                
              while true
              loop
                  fetch rc_inc into rec_inc;
                  exit when rc_inc%notfound;

                  l_stmt := concat(l_stmt, rec_inc.cnk||', '||chr(13));   
              end loop;
              close rc_inc;

          l_stmt := rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(rtrim(l_stmt, ', '||chr(13))
                    , chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13)), chr(13));
          l_stmt := l_stmt||chr(13);  
          l_stmt := concat(l_stmt, ')');  

      end if;
      
      --dbms_output.put_line(l_stmt);
      
      mgr_utl.sync_table(p_table => l_table, p_stmt => l_stmt, p_delete => false);
      
  end merge_table_auto;
  
end mgr_utl;
/
 show err;
 
PROMPT *** Create  grants  MGR_UTL ***
grant EXECUTE                                                                on MGR_UTL         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MGR_UTL         to FINMON;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mgr_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 