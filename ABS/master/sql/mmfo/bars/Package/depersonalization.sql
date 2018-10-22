create or replace package depersonalization is

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
  -- clean_error - очищает переменную ошибки
  --
  procedure clean_error;

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
    -- validate_cons_in_parallel - валидирует
    --
    procedure validate_cons_in_parallel(
        p_proc_name     varchar2,
        p_proc_params   varchar2 default null);


    ----
    -- validate_constraint - валидирует ограничение целостности
    --
    procedure validate_constraint(p_num integer);

  ----------------------------------add 25.04.2016 serhii.bovkush----------------------------------------------
    procedure execute_immediate(ip_sql in varchar2);

    --                                TRIGGERS
    --------------------------------------------------------------------------------
    procedure p_triggers_disable      (stable in varchar2);
    procedure p_trigger_disable       (ip_trigger in varchar2);
    procedure p_trigger_enable        (ip_trigger in varchar2);
    procedure p_triggers_enable       (stable in varchar2);
    function f_trigger_get_metadata   (strigger in varchar2) return clob;

    --                                CONSTRAINT
    ----------------------------------------------------------------------------------
    procedure p_constraints_disable            (stable in varchar2);
    procedure p_constraints_enable             (stable in varchar2);
    procedure p_constraints_en_novalid         (stable in varchar2);
    procedure p_constraints_validate           (stable in varchar2);
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
    --                                TABLE
    ----------------------------------------------------------------------------------

    -- set degree for table and all tables indices
    procedure p_indexes_set_degree             (ip_table_name in varchar2, ip_degree in number);

    -- set degree for table
    procedure p_table_set_degree                 (ip_table_name in varchar2, ip_degree in number);

    -- set degree for index
    procedure p_index_set_degree                (ip_index_name in varchar2, ip_degree in number);

    procedure p_partition_truncate              (ip_table_name in varchar2, ip_partition_name in varchar2);

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

  --делаем анъюзибл все неуникальные индексы на нашей таблице
  procedure p_indexes_unusable(  stable  in varchar2
                         , sowner  in varchar2 default 'BARS');
  --ребилдим все анъюзибл индексы на нашей таблице
  procedure p_indexes_usable(  stable  in varchar2
                         , sowner  in varchar2 default 'BARS');

  function alg1(str in varchar2) return varchar2 deterministic;--number;
  function alg2(str in varchar2) return varchar2 deterministic;
  function alg3(str in varchar2, type_of_information in integer default 0) return varchar2 deterministic;
  function alg4(dat in date) return date deterministic;
  function alg_fio(str in varchar2) return varchar2 deterministic;

--!!!!!!ВХОДЯЩИЙ ПАРАМЕТР - ЭТО ФИО, А НЕ НАСЕЛЕННЫЙ ПУНКТ
  function alg_bplace(str in varchar2, rnk in number default null) return varchar2 deterministic;
  function alg_okpo(str in varchar2) return varchar2 deterministic;

  procedure update_table(stable       in varchar2,
                         set_clause   in varchar2,
                         where_clause in varchar2 default '1 = 1',
                         parallel_level in number default 24,
                         sowner  in varchar2 default 'BARS');

  procedure dep_customer(custtype in varchar2 default '1, 2, 3');
  procedure dep_customer_update(custtype in varchar2 default '1, 2, 3');
  procedure dep_customer_rel;
  procedure dep_customer_rel_update;
  procedure dep_customer_address;
  procedure dep_customer_address_update;
  procedure dep_person;
  procedure dep_person_update;
  procedure dep_customerw(TAG in varchar2 default null);
  procedure dep_customerw_update(TAG in varchar2 default null);
  procedure dep_accounts;
  procedure dep_accounts_update;
  procedure dep_arc_rrp;
  procedure dep_oper;
  procedure dep_opldok;
  procedure dep_ead_docs;
  procedure dep_customer_images;
  procedure dep_operw(TAG in varchar2 default null);
-------------------------------------------------end add-----------------------------------------------------



end depersonalization;
/
create or replace package body depersonalization is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 19.10.2011
  -- Purpose    : Вспомагательные функции для миграции


  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.1.1 04/10/2018';

  G_PKG constant varchar2(30) := 'depersonalization';


  C_CTX_NAME    constant varchar2(30) := 'depersonalization';
  -- global variables
  g_error_msg       varchar2(4000);
  --
  g_tables          varchar2(4000);
  --
  g_operation       integer;


  -- параметр MGR_STAT = Y/N флаг сбора статистики после импорта каждой таблицы
  g_mgr_stat varchar2(1);

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
    return 'Package header depersonalization '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body depersonalization '||G_BODY_VERSION;
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
            depersonalization.validate_constraint(:start_id);
            depersonalization.noop(:end_id);
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
        when unsup_col_tp_fnd then depersonalization.save_error();
      end;
      --
      logger.trace('%s: finish', p);
      --
  end mantain_error_table;


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
   -- elsif sqlcode=(-22864) then depersonalization.save_error();
    exception when others then
    --ORA-22864: cannot ALTER or DROP LOB indexes
    --ORA-02429: cannot drop index used for enforcement of unique/primary key
    if sqlcode=(-22864) then depersonalization.save_error(); --bars_audit.error(l_stmt);
       elsif  sqlcode=(-02429) then depersonalization.save_error();
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

  --
  -- EXCHANGE PARTITION BY NAME
  --
  procedure EXCHANGE_PARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_partition_nm      in     all_tab_subpartitions.partition_name%type
  ) is
  begin

    bars.bars_audit.trace( 'depersonalization.exchange_partition: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_part_nm=%s).'
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

    bars.bars_audit.trace( 'depersonalization.exchange_partition: Exit.'  );

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

    bars.bars_audit.trace( 'depersonalization.exchange_partition_for: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_condition=%s).'
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

    bars.bars_audit.trace( 'depersonalization.exchange_partition_for: Exit.'  );

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

    bars.bars_audit.trace( 'depersonalization.exchange_subpartition: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_subpart_nm=%s).'
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

    bars.bars_audit.trace( 'depersonalization.exchange_subpartition: Exit.'  );

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
    title   constant  varchar2(60) := 'depersonalization.exchange_subpartition_for';
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

    bars.bars_audit.trace( 'depersonalization.exchange_subpartition_for: Exit.'  );

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

   l_stmt_g      VARCHAR2(255);

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


  --делаем анъюзибл все неуникальные индексы на нашей таблице
  procedure p_indexes_unusable(  stable  in varchar2
                         , sowner  in varchar2 default 'BARS')
    is

  begin

    for rec in
      (select  t.TABLE_OWNER
             , t.TABLE_NAME
             , t.INDEX_NAME
             , tt.partition_name
             , ttt.subpartition_name

             , case when t.status = 'UNUSABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild parallel 24'
                    when tt.status = 'UNUSABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild partition '||tt.partition_name||' parallel 24'
                    when ttt.status = 'UNUSABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild subpartition '||ttt.subpartition_name||' parallel 24'
               end as statement_rebuild
             , case when t.status = 'VALID' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' unusable'
                    when tt.status = 'USABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' modify partition '||tt.partition_name||' unusable'
                    when ttt.status = 'USABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' modify subpartition '||ttt.subpartition_name||' unusable'
               end as statement_unusable

        from all_indexes t
        left join all_ind_partitions tt
        on t.INDEX_NAME = tt.index_name
        left join all_ind_subpartitions ttt
        on t.INDEX_NAME = ttt.index_name
        and tt.partition_name = ttt.partition_name
        where t.TABLE_OWNER = upper(sowner)
          and t.TABLE_NAME = upper(stable)
          and t.uniqueness = 'NONUNIQUE'
          and (t.status = 'VALID' or tt.status = 'USABLE' or ttt.status = 'USABLE')
                    order by 2,3,4,5)

    loop
      execute immediate rec.statement_unusable;
    end loop;

  end;

  --ребилдим все анъюзибл индексы на нашей таблице
  procedure p_indexes_usable(  stable  in varchar2
                         , sowner  in varchar2 default 'BARS')
    is

  begin

    execute immediate 'alter session enable parallel ddl';

    for rec in
      (select  t.TABLE_OWNER
             , t.TABLE_NAME
             , t.INDEX_NAME
             , tt.partition_name
             , ttt.subpartition_name

             , case when t.status = 'UNUSABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild parallel 24'
                    when tt.status = 'UNUSABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild partition '||tt.partition_name||' parallel 24'
                    when ttt.status = 'UNUSABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild subpartition '||ttt.subpartition_name||' parallel 24'
               end as statement_rebuild
             , case when t.status = 'VALID' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' unusable'
                    when tt.status = 'USABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' modify partition '||tt.partition_name||' unusable'
                    when ttt.status = 'USABLE' then
                         'alter index '||t.OWNER||'.'||t.INDEX_NAME||' modify subpartition '||ttt.subpartition_name||' unusable'
               end as statement_unusable

        from all_indexes t
        left join all_ind_partitions tt
        on t.INDEX_NAME = tt.index_name
        left join all_ind_subpartitions ttt
        on t.INDEX_NAME = ttt.index_name
        and tt.partition_name = ttt.partition_name
        where t.TABLE_OWNER = upper(sowner)
          and t.TABLE_NAME = upper(stable)
          and t.uniqueness = 'NONUNIQUE'
          and (t.status = 'UNUSABLE' or tt.status = 'UNUSABLE' or ttt.status = 'UNUSABLE')
                    order by 2,3,4,5)

    loop
      --
      logger.trace(rec.statement_rebuild, stable);
      --
      execute immediate rec.statement_rebuild;
    end loop;

    execute immediate 'alter session disable parallel ddl';

  end;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--Алгоритм №1
--Алгоритм автоматичного розрахунку номеру.
--N_new=(N+S)^3/mod(10) (приклад: mod(power((substr(trim(p.numdoc),-S,1)+S),3),10)), де N – числовий символ,
--S – номер позиції символу з кінця рядку (не числові символи видаляються)

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
  function alg1(str in varchar2) return varchar2 deterministic
   is

    l_str varchar2(4000);
    l_str_out_s varchar2(4000) := '';
    l_len       number;
    i           integer;

  begin
    l_str := regexp_replace(str, '[^[:digit:]]');--берем только цифры
    l_len := length(l_str);

    --в цикле от начала строки заменяем цифры как сказано в алгоритме
    if l_len > 0 then
      for i in 1 .. l_len loop
        --l_str := substr(l_str, 1, i-1)||mod(power(substr(l_str, i, 1) + l_len-i+1,3), 10)||substr(l_str, i+1, l_len-i);

        l_str_out_s := l_str_out_s ||
                       mod(power(substr(l_str, i, 1) + l_len - i + 1, 3),
                           10);
      end loop;
    end if;
    return l_str_out_s;
  end alg1;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--Алгоритм №2
--Алгоритм автоматичної заміни символів.
--Виконується заміна літерних символів іншими літерними символами шляхом співставлення їх у визначеному порядку із зміщенням,
--числа у строчці замінюються по алгоритму:  N_new =N^3/mod(10), де N – числовий символ:
--  1 2 3 4 5 6 7 8 9 10  11  12  13  14  15  16  17  18  19  20  21  22
--  Блок символів що мають аналогічні символи Lat/Cyr абетці
--Lat Початковий  A B C E H I K O P M T X
--  Змінюється на T X O P K M H I C E A B
--    Блок символів що не мають аналогічні символи Lat/Cyr абетці
--Lat Початковий  D F G J L N Q R S U V W Y Z
--  Змінюється на Y Z V W D S U F G Q R J L N
--  Блок символів що мають аналогічні символи Lat/Cyr абетці
--Cyr Початковий  А В Е І К М Н О Р С Т У Х
--  Змінюється на Т У О Р С К М Н Х А В Е І
--  Блок символів що не мають аналогічні символи Lat/Cyr абетці
--Cyr Початковий  Б Г Д Є Ж З И Й Л П Ф Ц Ч Ш Щ Ь Ю Я Ы Э Ъ Ї
--  Змінюється на Ю Я Ч Ш Щ Б Ф Ц Ь Й Л П Г Д Є Ж З И Т Н Ф Э
--
--Кожний символ у рядку замінюється на відповідний у таблиці вище з зміщенням на номер позиції початкового символу.
--Нумерація символів серії здійснюється з права на ліво (Наприклад: С3Т2О1, де червоним кольором відмічена нумерація символів).
--Перед заміною, всі символи у строчці приводяться до верхнього регістру, символ пробілу з обох боків видаляється.
--Якщо сума індексу початкового символу + номер позиції символу у строчці більше максимального індексу у відповідному блоці,
--то індекс символу на який виконується заміна визначається наступним чином:
--replace(mod(індекс поч. символу + номер символу у строчці, макс. індекс у таблиці (у відповідному блоці)),0, макс. індекс
--у таблиці (у відповідному блоці))
--Символи кириличної  та латинської абетки діляться на дві групи:
--- ті, що мають аналогічні символи Lat/Cyr абетці
--- ті, що не мають аналогічні символи Lat/Cyr абетці
--Заповнення у таблиці символів позначених зеленим маркером виконується на стороні банку (адміністратором системи).
--Не числові символи у строчці,  які відсутні у таблиці, не модифікуються.
--Наприклад:
--Слово «ТЕСТ» (кирилиця) змінюється наступним чином:
--Перший символ «Т» (з кінця строки) має індекс 11 у таблиці вище. Буква знаходиться в позиції номер 1.
--Далі визначаємо суму 11 + 1 = 12, та із таблиці визначаємо символ з індексом 12 на який відбудеться заміна.
--Даному індексу відповідає символ «Е».
--Другий символ «С» замінюється аналогічно, та отримуємо символ «Е».
--В результаті отримаємо слово «УКЕЕ»

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  function alg2(str in varchar2) return varchar2  deterministic
    is

    l_str    varchar2(4000);
    l_str2   varchar2(4000) := '';
    l_len    integer;
    i        integer;
    --строки из условия
    l_in1    varchar2(12) := 'ABCEHIKOPMTX';
    l_out1   varchar2(12) := 'TXOPKMHICEAB';
    l_in2    varchar2(14) := 'DFGJLNQRSUVWYZ';
    l_out2   varchar2(14) := 'YZVWDSUFGQRJLN';
    l_in3    varchar2(13) := 'АВЕІКМНОРСТУХ';
    l_out3   varchar2(13) := 'ТУОРСКМНХАВЕІ';
    l_in4    varchar2(22) := 'БГДЄЖЗИЙЛПФЦЧШЩЬЮЯЫЭЪЇ';
    l_out4   varchar2(22) := 'ЮЯЧШЩБФЦЬЙЛПГДЄЖЗИТНФЭ';
    l_in_i   integer;
    l_out_i  varchar2(22);
    ll_out_i integer;
    l_out_ii varchar2(1);

  begin
    l_str := upper(trim(str));
    l_len := length(l_str);

    if l_len > 0 then
      for i in 1 .. l_len loop
        --ищем номер симфола в строке в которой есть вхождение (если нет вхождения, то 0)
        l_in_i := greatest(instr(l_in1, substr(l_str, i, 1)),
                           instr(l_in2, substr(l_str, i, 1)),
                           instr(l_in3, substr(l_str, i, 1)),
                           instr(l_in4, substr(l_str, i, 1)));

        --ищем строчку, из которой будем выводить символ (если не нашли - просто забираем символ, который и был, а
        --если на входе цифра, то выводим новую, рассчитываем ее по алгоритму)
        l_out_i := case
                     when instr(l_in1, substr(l_str, i, 1)) > 0 then
                      l_out1
                     when instr(l_in2, substr(l_str, i, 1)) > 0 then
                      l_out2
                     when instr(l_in3, substr(l_str, i, 1)) > 0 then
                      l_out3
                     when instr(l_in4, substr(l_str, i, 1)) > 0 then
                      l_out4
                     when substr(l_str, i, 1) =
                          regexp_replace(substr(l_str, i, 1), '[^[:digit:]]') then
                      to_char(mod(power(substr(l_str, i, 1), 3), 10))
                     else
                      substr(l_str, i, 1)
                   end;

        --ll_out_i := replace(mod(l_in_i + l_len - i + 1, length(l_out_i)),0,length(l_out_i));
        --выискиваем нужное смещение - на сколько символов должны сместиться в строке, из которой будем выводить символ
        ll_out_i := case
                      when mod(l_in_i + l_len - i + 1, length(l_out_i)) = 0 then
                       length(l_out_i)
                      else
                       mod(l_in_i + l_len - i + 1, length(l_out_i))
                    end;

        --
        l_out_ii := substr(l_out_i, ll_out_i, 1);

        --dbms_output.put_line(l_in_i||'    '||l_out_i||'    '||ll_out_i||'    '||l_out_ii);

        --l_str := substr(l_str, 1, i-1)||l_out_ii||substr(l_str, i+1, l_len-i);
        l_str2 := l_str2 || l_out_ii;
      end loop;
    end if;
    return l_str2;
  end alg2;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--Алгоритм №3
--Алгоритм автоматичної заміни адреси.
--Індекс: Алгоритм №1
--Область: не змінюється
--Назва НП: не змінюється
--Назва вулиці: «ВУЛИЦЯ» + перша літера назви що модифікується (наприклад: 'ВУЛИЦЯ '|| substr(trim(p.street),1,1))
--Номер будинку: Алгоритм №1
--Номер квартири: Алгоритм №1
--Номер корпусу: Алгоритм №1
--Примітка: Адреса, інформацію про яку внесено в одне поле, модифікується по Алгоритму №2.

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  function alg3(str in varchar2, type_of_information in integer default 0)
    return varchar2 deterministic
    --type_of_information - определяет тип входящей информации и может быть выбран из след. вариантов:

    --1 Індекс: Алгоритм №1
    --2 Область: не змінюється
    --3 Назва НП: не змінюється
    --4 Назва вулиці: «ВУЛИЦЯ» + перша літера назви що модифікується (наприклад: 'ВУЛИЦЯ '|| substr(trim(p.street),1,1))
    --5 Номер будинку: Алгоритм №1
    --6 Номер квартири: Алгоритм №1
    --7 Номер корпусу: Алгоритм №1
    --0 Адреса, інформацію про яку внесено в одне поле, модифікується по Алгоритму №2.
   is
    l_str varchar2(4000) := str;
    --l_str number;
    l_type_of_information integer := type_of_information;
    l_str_out_s           varchar2(4000) := '';
    l_len                 number;
    i                     integer;

  begin
    if l_type_of_information in (1, 5, 6, 7) then
      return alg1(l_str);--Алгоритм №1
    elsif l_type_of_information in (2, 3) then
      return l_str;--не змінюється
    elsif l_type_of_information = 4 then
      return 'ВУЛИЦЯ ' || substr(trim(l_str), 1, 1);--«ВУЛИЦЯ» + перша літера назви що модифікується
    elsif l_type_of_information = 0 then
      return alg2(l_str);--інформацію про яку внесено в одне поле, модифікується по Алгоритму №2.
    end if;
  end alg3;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--Алгоритм №4
--Алгоритм автоматичної заміни дати
--День: replace( (D1+D2)^3/mod(3) || D2^3/mod(10) ,'00','11'), де
-- D1 –перша цифра числа ,
-- D2 – друга цифра числа
--Місяць: не змінюється
--Рік: не змінюється

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
  function alg4(dat in date) return date  deterministic
   is
    l_dat date := dat;
    l_dat_out date;
    d1 integer;
    d2 integer;
    d_out integer;
  begin
    d1 := trunc(extract(day from l_dat) / 10);--первая цифра из номера дня
    d2 := mod(extract(day from l_dat), 10);--вторая цифра из номера дня
    d_out := case when mod(power((D1+D2), 3), 3) * 10 + mod(power(D2, 3), 10) = 0 then 11
                  else mod(power((D1+D2), 3), 3) * 10 + mod(power(D2, 3), 10)
             end;--высчитываем номер дня, который будет выведен
    l_dat_out := trunc(l_dat, 'MM') + d_out - 1;--считаем день в формате даты
    return l_dat_out;
  end alg4;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
/*Методика
розрахунку контрольного числа ідентифікаційного коду Єдиного державного реєстру підприємств та організацій України


    Методика розрахунку КЧ полягає в наступному:
   1. Кожному  розряду  ідентифікаційного  коду,  починаючи  з найстаршого, надається ваговий коефіцієнт:
Номер розряду числа   1 2 3 4 5 6 7
Значення вагового коефіцієнту (Wi)
для ід.кодів < 30000000
і > 60000000  1 2 3 4 5 6 7
Значення вагового коефіцієнту (Wi)
для ід.кодів > 30000000
і< 60000000 7 1 2 3 4 5 6

    2. Проводиться  розрахунок   КЧ   для   конкретного   ідентифікаційного коду.  Для цього кожна цифра (Di),
    яка займає певний розряд даного коду,  множиться на ваговий коефіцієнт розряду (Wi) і обчислюється сума отриманих добутків.
                 7
                S = SUM Wi * Di            (1)
                i=1
    3. Контрольне число ідентифікаційного коду - це залишок відділення одержано. суми (S) на 11 і виражається формулою:
                                                             КЧ = S - | S/11 | * 11 ,
           де |S/11| - ціла частина результату ділення (частки).

     4. Контрольне число повинно мати один розряд, тобто КЧ = 0,1,2,3,4,5,6,7,8 або 9.

   5. Якщо при розрахунку контрольного числа одержується залишок, який дорівнює 10,  то для забезпечення  одноразрядності  КЧ
   необхідно провести перерахунок, застосовуючи другу послідовність вагових коефіцієнтів, яка здвинута на два розряди вліво:
   (3,4,5,6,7,8,9) або (9,3,4,5,6,7,8).

 6. Якщо  при  повторному  розрахунку КЧ залишок від ділення знову буде дорівнювати 10, то ідентифікаційному коду надати КЧ=0.
Приклад. Необхідно визначити контрольне число такого  ідентифікаційного коду: 0490301. В цьому випадку:

    Di = (0, 4, 9, 0, 3, 0, 1);
    Wi = (1, 2, 3, 4, 5, 6, 7);
    S = 1*0 + 2*4 + 3*9 + 4*0 + 5*3 + 6*0 + 7*1 = 57
   | S/11 | = | 57/11 | = 5 (залишок 2)
    КЧ = 57 - 11*5 = 2
    Правильно побудований ідентифікаційний код - 04903012.
    При перевірці правильності ідентифікаційних кодів необхідно визначити суму по формулі (1), поділити на 11 і одержаний від
    ділення залишок  зрівняти із значенням контрольного числа.  Якщо значення залишку і  контрольного  числа  співпадають,
    то  ідентифікаційний код вважається правильним. В іншому випадку ідентифікаційний код вважається помилковим за виключенням
    того,  коли залишок дорівнює 10.  Якщо залишок від ділення дорівнює 10, проводиться перерахунок суми (1),  використовуючи
    послідовність вагових коефіцієнтів відповідно п.5, визначається новий залишок від ділення одержано. суми на 11 і
    порівнюється з КЧ. Якщо залишок співпадає  з КЧ,  а також у випадку,  коли одержаний залишок дорівнює 10, а КЧ=0,
    ідентифікаційний код вважається правильним, у іншому випадку - помилковим.
*/
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  function alg_okpo(str in varchar2) return varchar2 deterministic
    is

    l_str       varchar2(14);
    l_str_min   varchar2(14);
    l_str_out_s varchar2(38) := '';
    i           integer;
    s           number := 0;

  begin

    l_str := depersonalization.alg1(substr(regexp_replace(str, '[^[:digit:]]'), 1, 8));--пересчитываем по алгоритму 1
                                                                                       --8 символов из входящего ЕДРПОУ
    l_str_min := substr(l_str, 1, 7);--отрезаем первых 7 значимых символов (убираем контрольное число КЧ)

    --высчитываем S = SUM Wi * Di
    if l_str < 30000000 or l_str > 60000000 then
      for i in 1 .. 7 loop
        s := s + substr(l_str_min, i, 1) * i;
      end loop;
    elsif l_str > 30000000 and l_str < 60000000 then
      for i in 1 .. 7 loop
        s := s + substr(l_str_min, i, 1) * (mod(i + 5, 7) + 1);
      end loop;
    end if;

    s := mod(s, 11);--КЧ = S - | S/11 | * 11

    /*Якщо при розрахунку контрольного числа одержується залишок, який дорівнює 10,  то для забезпечення  одноразрядності  КЧ
   необхідно провести перерахунок, застосовуючи другу послідовність вагових коефіцієнтів, яка здвинута на два розряди вліво:
   (3,4,5,6,7,8,9) або (9,3,4,5,6,7,8)*/
    if s = 10 and (l_str < 30000000 or l_str > 60000000) then
      s := 0;
      for i in 1 .. 7 loop
        s := s + substr(l_str_min, i, 1) * (i + 2);
      end loop;
    elsif s = 10 and l_str > 30000000 and l_str < 60000000 then
      s := 0;
      for i in 1 .. 7 loop
        s := s + substr(l_str_min, i, 1) * (mod(i + 5, 7) + 3);
      end loop;
    end if;

    s := mod(s, 11);----КЧ = S - | S/11 | * 11

    --Якщо  при  повторному  розрахунку КЧ залишок від ділення знову буде дорівнювати 10,
    --то ідентифікаційному коду надати КЧ=0.
    if s = 10 then
      s := 0;
    end if;

    --выводим результирующую строку вместе с контрольным числом
    l_str_out_s := case when l_str_min is not null then
                     l_str_min || s
                   end;

    return l_str_out_s;

  end alg_okpo;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
/*ПІБ
Прізвище:
«КФО» + перші дві літери прізвища модифіковані по Алгоритму №2
Ім’я:
«ІМ» + перші дві літери імені модифіковані по Алгоритму №2
По-батькові:
«ПБ» + перші дві літери по батькові модифіковані по Алгоритму №2 (в випадку відсутності по батькові, параметр не модифікуємо)*/
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  function alg_fio(str in varchar2) return varchar2 deterministic
   is

    l_str varchar2(70):= trim(str);
    l_str_out_s varchar2(70) := '';

  begin
    if instr(l_str, ' ', 1 ,2) > 0 then
      l_str_out_s := 'КФО'||depersonalization.alg2(substr(l_str, 1, 2))||' '||
                     'ІМ'||depersonalization.alg2(trim(substr(l_str, instr(l_str, ' ', 1 ,1) + 1, 2)))||' '||
                     'ПБ'||depersonalization.alg2(trim(substr(l_str, instr(l_str, ' ', 1 ,2) + 1, 2)));
    else
      l_str_out_s := 'КФО'||depersonalization.alg2(substr(l_str, 1, 2))||' '||
                     'ІМ'||depersonalization.alg2(trim(substr(l_str, instr(l_str, ' ', 1 ,1) + 1, 2)));
    end if;
    return l_str_out_s;
  end alg_fio;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
/*Місце народження
Модифіковане місце народження = «населений пункт»
+ (1-а літера прізвища + 1-а літера ім'я + 1-а літера по батькові,
символи модифіковані за алгоритмом №2)*/
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--!!!!!!ВХОДЯЩИЙ ПАРАМЕТР - ЭТО ФИО, А НЕ НАСЕЛЕННЫЙ ПУНКТ
--если параметр rnk непуст, то ФИО берез из таблицы customer, а первій пар-р str игнорируется
--причем customer должен быть на этот момент необезличен, иначе получим некорректность

  function alg_bplace(str in varchar2, rnk in number default null) return varchar2 deterministic
   is

    l_str varchar2(70):= trim(str);
    l_str_out_s varchar2(70) := '';
    l_rnk number(38) := rnk;
  begin
    if l_rnk is not null then
      select trim(nmk)
        into l_str
        from bars.customer
       where rnk = l_rnk;
    end if;

      if instr(l_str, ' ', 1 ,2) > 0 then
        l_str_out_s := 'населений пункт'||depersonalization.alg2(substr(l_str, 1, 1))
                       ||depersonalization.alg2(trim(substr(l_str, instr(l_str, ' ', 1 ,1) + 1, 1)))
                       ||depersonalization.alg2(trim(substr(l_str, instr(l_str, ' ', 1 ,2) + 1, 1)));
      else
        l_str_out_s := 'населений пункт'||depersonalization.alg2(substr(l_str, 1, 1))
                       ||depersonalization.alg2(trim(substr(l_str, instr(l_str, ' ', 1 ,1) + 1, 1)));
      end if;

    return l_str_out_s;
  end alg_bplace;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure update_table(stable       in varchar2,
                         set_clause   in varchar2,
                         where_clause in varchar2 default '1 = 1',
                         parallel_level in number default 24,
                         sowner  in varchar2 default 'BARS')

   IS
    l_task_STABLE VARCHAR2(35) := 'TASK_' || STABLE;
    l_sql_stmt    VARCHAR2(32767);
    l_try         NUMBER;
    l_status      NUMBER;
    l_tab         VARCHAR2(30) := upper(STABLE);
    l_owner       VARCHAR2(30) := upper(sowner);
    l_parallel_level      NUMBER := parallel_level;
    l_rowcount    number default 0;

  BEGIN

    --проверяем есть ли таска с нашим названием, пытаемся дропнуть ее
    begin
      DBMS_PARALLEL_EXECUTE.drop_task(l_task_STABLE);
        exception when others then
          if sqlcode=(-29498) then null;--таски не нашли, значит все ок
          else raise; end if;
    end;

    DBMS_PARALLEL_EXECUTE.create_task(task_name => l_task_STABLE);--создаем таску в select * from dba_parallel_execute_tasks

    DBMS_PARALLEL_EXECUTE.create_chunks_by_rowid(task_name   => l_task_STABLE,
                                                 table_owner => l_owner,
                                                 table_name  => l_tab,
                                                 by_row      => TRUE,
                                                 chunk_size  => 100000);

    --генерим скрипт для апдейта
    l_sql_stmt := '
        UPDATE /*+ RO_WID (t) */ BARS.' || STABLE || ' t
          SET ' || set_clause || '
                  WHERE rowid BETWEEN :start_id AND :end_id
                  and ' || where_clause;

    --
    logger.trace(l_sql_stmt, l_tab);
    --
    DBMS_PARALLEL_EXECUTE.run_task(task_name      => l_task_STABLE,
                                   sql_stmt       => l_sql_stmt,
                                   language_flag  => DBMS_SQL.NATIVE,
                                   parallel_level => l_parallel_level);

    -- If there is error, RESUME it for at most 2 times.
    l_try := 0;
    l_status := DBMS_PARALLEL_EXECUTE.task_status (l_task_STABLE);

    WHILE (l_try < 2 AND l_status != DBMS_PARALLEL_EXECUTE.FINISHED)
    LOOP
        l_try := l_try + 1;
        DBMS_PARALLEL_EXECUTE.resume_task (l_task_STABLE);
        l_status := DBMS_PARALLEL_EXECUTE.task_status (l_task_STABLE);
    END LOOP;
    DBMS_PARALLEL_EXECUTE.drop_task(l_task_STABLE);

  END update_table;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customer(custtype in varchar2 default '1, 2, 3')
    is
    l_tab         VARCHAR2(30) := 'CUSTOMER';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'NMK = depersonalization.alg_fio(NMK),
                                                    NMKV = depersonalization.alg_fio(NMKV),
                                                    NMKK = depersonalization.alg_fio(NMKK),
                                                    OKPO = depersonalization.alg_okpo(okpo),
                                                    ADR = depersonalization.alg3(adr),
                                                    ADM = ''ТЕСТОВИЙ ВІДДІЛ'',
                                                    DATEA = depersonalization.alg4(DATEA),
                                                    RGADM = depersonalization.alg1(RGADM)
                                    '
                                   , where_clause => 'custtype in ('||custtype||')'
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customer;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customer_update(custtype in varchar2 default '1, 2, 3')
    is
    l_tab         VARCHAR2(30) := 'CUSTOMER_UPDATE';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'NMK = depersonalization.alg_fio(NMK),
                                                    NMKV = depersonalization.alg_fio(NMKV),
                                                    NMKK = depersonalization.alg_fio(NMKK),
                                                    OKPO = depersonalization.alg_okpo(okpo),
                                                    ADR = depersonalization.alg3(adr),
                                                    ADM = ''ТЕСТОВИЙ ВІДДІЛ'',
                                                    DATEA = depersonalization.alg4(DATEA),
                                                    RGADM = depersonalization.alg1(RGADM)
                                    '
                                   , where_clause => 'custtype in ('||custtype||')'
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customer_update;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customer_rel
    is
    l_tab         VARCHAR2(30) := 'CUSTOMER_REL';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'first_name = ''ІМ''||depersonalization.alg2(trim(substr(first_name, 1, 2))),
                                                    middle_name  = ''ПБ''||depersonalization.alg2(trim(substr(middle_name, 1, 2))),
                                                    last_name  = ''КФО''||depersonalization.alg2(trim(substr(last_name, 1, 2))),
                                                    document   = depersonalization.alg2(trust_regnum),
                                                    trust_regnum  = depersonalization.alg1(trust_regnum),
                                                    name_r  = depersonalization.alg_fio(name_r)
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customer_rel;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customer_rel_update
    is
    l_tab         VARCHAR2(30) := 'CUSTOMER_REL_UPDATE';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'first_name = ''ІМ''||depersonalization.alg2(trim(substr(first_name, 1, 2))),
                                                    middle_name  = ''ПБ''||depersonalization.alg2(trim(substr(middle_name, 1, 2))),
                                                    last_name  = ''КФО''||depersonalization.alg2(trim(substr(last_name, 1, 2))),
                                                    document   = depersonalization.alg2(trust_regnum),
                                                    trust_regnum  = depersonalization.alg1(trust_regnum),
                                                    name_r  = depersonalization.alg_fio(name_r)
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customer_rel_update;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customer_address
    is
    l_tab         VARCHAR2(30) := 'CUSTOMER_ADDRESS';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'ZIP = depersonalization.alg3(ZIP, 1),
                                                    ADDRESS = depersonalization.alg3(ADDRESS, 0),
                                                    STREET = depersonalization.alg3(STREET, 4),
                                                    HOME = depersonalization.alg3(HOME, 5),
                                                    HOMEPART = depersonalization.alg3(HOMEPART, 7),
                                                    ROOM = depersonalization.alg3(ROOM, 6),
                                                    street_id  = null,
                                                    house_id  = null
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customer_address;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customer_address_update
    is
    l_tab         VARCHAR2(30) := 'CUSTOMER_ADDRESS_UPDATE';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'ZIP = depersonalization.alg3(ZIP, 1),
                                                    ADDRESS = depersonalization.alg3(ADDRESS, 0),
                                                    STREET = depersonalization.alg3(STREET, 4),
                                                    HOME = depersonalization.alg3(HOME, 5),
                                                    HOMEPART = depersonalization.alg3(HOMEPART, 7),
                                                    ROOM = depersonalization.alg3(ROOM, 6),
                                                    street_id  = null,
                                                    house_id  = null
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customer_address_update;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_person
    is
    l_tab         VARCHAR2(30) := 'PERSON';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'BPLACE = depersonalization.alg_bplace(str => BPLACE, rnk => RNK),
                                                    SER = depersonalization.alg2(SER),
                                                    NUMDOC = depersonalization.alg1(NUMDOC),
                                                    ORGAN = ''ТЕСТОВИЙ ВІДДІЛ'',
                                                    PDATE = depersonalization.alg4(PDATE),
                                                    TELD = depersonalization.alg1(TELD),
                                                    TELW = depersonalization.alg1(TELW),
                                                    CELLPHONE = depersonalization.alg1(CELLPHONE)
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_person;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_person_update
    is
    l_tab         VARCHAR2(30) := 'PERSON_UPDATE';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'BPLACE = depersonalization.alg_bplace(str => BPLACE, rnk => RNK),
                                                    SER = depersonalization.alg2(SER),
                                                    NUMDOC = depersonalization.alg1(NUMDOC),
                                                    ORGAN = ''ТЕСТОВИЙ ВІДДІЛ'',
                                                    PDATE = depersonalization.alg4(PDATE),
                                                    TELD = depersonalization.alg1(TELD),
                                                    TELW = depersonalization.alg1(TELW),
                                                    CELLPHONE = depersonalization.alg1(CELLPHONE)
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_person_update;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customerw(TAG in varchar2 default null)
    is
    l_tab         VARCHAR2(30) := 'CUSTOMERW';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg_fio(VALUE)
                                                   '
                                   , where_clause => 'tag in (''SN_GC'', ''DOV_F'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''КФО''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''PC_MF'', ''SN_LN'')'--фамилии
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ІМ''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''SN_FN'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ПБ''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''SN_MN'')'
                                  );

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg2(VALUE)
                                                   '
                                   , where_clause => 'tag in (  ''NRDAT'', ''DOV_A'', ''DOV_P'', ''NRSVI'', ''ADRW ''
                                                              , ''FADRB'', ''RVIBA'', ''FGADR'', ''ADRP ''
                                                              , ''ADRU '', ''FADR '', ''MAMA '', ''W4KKW'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg1(VALUE)
                                                   '
                                     --все телефоны + индекс почтовый
                                   , where_clause => 'tag in (  ''RVPH1'', ''RVPH2'', ''RVPH3'', ''TEL_D'', ''MPNO''
                                                              , ''MOB01'', ''MOB02'', ''MOB03'', ''FGIDX'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''''
                                                   '
                                   , where_clause => 'tag in (''EMAIL'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ТЕСТОВИЙ ВІДДІЛ''
                                                   '
                                   , where_clause => 'tag in (''NRORG'')'
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customerw;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customerw_update(TAG in varchar2 default null)
    is
    l_tab         VARCHAR2(30) := 'CUSTOMERW_UPDATE';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg_fio(VALUE)
                                                   '
                                   , where_clause => 'tag in (''SN_GC'', ''DOV_F'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''КФО''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''PC_MF'', ''SN_LN'')'--фамилии
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ІМ''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''SN_FN'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ПБ''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''SN_MN'')'
                                  );

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg2(VALUE)
                                                   '
                                   , where_clause => 'tag in (  ''NRDAT'', ''DOV_A'', ''DOV_P'', ''NRSVI'', ''ADRW ''
                                                              , ''FADRB'', ''RVIBA'', ''FGADR'', ''ADRP ''
                                                              , ''ADRU '', ''FADR '', ''MAMA '', ''W4KKW'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg1(VALUE)
                                                   '
                                     --все телефоны + индекс почтовый
                                   , where_clause => 'tag in (  ''RVPH1'', ''RVPH2'', ''RVPH3'', ''TEL_D'', ''MPNO''
                                                              , ''MOB01'', ''MOB02'', ''MOB03'', ''FGIDX'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''''
                                                   '
                                   , where_clause => 'tag in (''EMAIL'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ТЕСТОВИЙ ВІДДІЛ''
                                                   '
                                   , where_clause => 'tag in (''NRORG'')'
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customerw_update;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--3. Рахунок
--3.1	Назва рахунку
--	Модифікована назва = «Рахунок» + Номер рахунку (на приклад: 'РАХУНОК '||nls)
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_accounts
    is
    l_tab         VARCHAR2(30) := 'ACCOUNTS';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'NMS = ''РАХУНОК ''||NLS
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_accounts;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_accounts_update
    is
    l_tab         VARCHAR2(30) := 'ACCOUNTS_UPDATE';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'NMS = ''РАХУНОК ''||NLS
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_accounts_update;


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_arc_rrp
    is
    l_tab         VARCHAR2(30) := 'ARC_RRP';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'NAZN = ''Переказ ''||ND,
                                                    NAM_A = ''Платник ''||depersonalization.alg_okpo(ID_A),
                                                    NAM_B = ''Отримувач ''||depersonalization.alg_okpo(ID_B),
                                                    ID_A = depersonalization.alg_okpo(ID_A),
                                                    ID_B = depersonalization.alg_okpo(ID_B)
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_arc_rrp;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_oper
    is
    l_tab         VARCHAR2(30) := 'OPER';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'NAZN = ''Переказ ''||ND,
                                                    NAM_A = ''Платник ''||depersonalization.alg_okpo(ID_A),
                                                    NAM_B = ''Отримувач ''||depersonalization.alg_okpo(ID_B),
                                                    ID_A = depersonalization.alg_okpo(ID_A),
                                                    ID_B = depersonalization.alg_okpo(ID_B)
                                    '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_oper;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_opldok
    is
    l_tab         VARCHAR2(30) := 'OPLDOK';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    --p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'TXT = ''Переказ ''||STMT
                                   '
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    --p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_opldok;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_ead_docs
    is
    l_tab         VARCHAR2(30) := 'EAD_DOCS';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

     begin
      for rec in (select tt.id, tt.name
                    from ead_doc_types tt)
      loop
        update EAD_DOCS t
           set t.scan_data = to_hex(rec.name)        --Модифікований документ = білий лист з написом типу документу
         where t.type_id = rec.id
           and t.scan_data is not null;
        commit;
      end loop;
    end;

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_ead_docs;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_customer_images
    is
    l_tab         VARCHAR2(30) := 'CUSTOMER_IMAGES';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    begin
        update CUSTOMER_IMAGES t
           set t.image = '';        --Видаляємо
        commit;
    end;

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_customer_images;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

  procedure dep_operw(TAG in varchar2 default null)
    is
    l_tab         VARCHAR2(30) := 'OPERW';

  begin

    bpa.disable_policies(p_table_name => l_tab);      --дизейблим политики
    p_ref_constraints_disable(stable => l_tab );      --дизейблим реф-констрейнты
    p_constraints_fk_disable(stable => l_tab );       --дизейблим фк-констрейнты
    p_constraints_chk_disable(stable => l_tab );      --дизейблим чек-констрейнты
    p_triggers_disable(stable => l_tab );             --дизейблим триггера
    p_indexes_unusable(stable => l_tab );             --делаем анъюзибл все неуникальные индексы на нашей таблице

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg_fio(VALUE)
                                                   '
                                   , where_clause => 'tag in (''FIO'')'--фио
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''КФО''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''F'')'--фамилия
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ІМ''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''I'')'--имя
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = ''ПБ''||depersonalization.alg2(trim(substr(VALUE, 1, 2)))
                                                   '
                                   , where_clause => 'tag in (''O'')'--отчество
                                  );

    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg2(VALUE)
                                                   '
                                     --все адреса
                                   , where_clause => 'tag in (''ADRES'', ''ADRS '', ''ADRBO'', ''ADROT'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   , set_clause => 'VALUE = depersonalization.alg1(VALUE)
                                                   '
                                     --все телефоны
                                   , where_clause => 'tag in (''MTEL '', ''PHONE'', ''PHONW'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   --парсим VALUE чтоб обезличить паспорт
                                   --Номер документу: Алгоритм №1
                                   --Серія документу: Алгоритм №2
                                   --regexp_replace(VALUE, '[^[:digit:]]') - цифры (depersonalization.alg1 вырежет цифры сам)
                                   --regexp_replace(VALUE, '[^[:alpha:]]') - буквы
                                   , set_clause => 'VALUE = depersonalization.alg2(regexp_replace(VALUE, ''[^[:alpha:]]''))||depersonalization.alg1(VALUE)
                                                   '
                                     --Серiя i номер паспорта
                                   , where_clause => 'tag in (''ф    '', ''Ф    '', ''PASPN'', ''PASPS'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   --Ким виданий: «ТЕСТОВИЙ ВІДДІЛ» паспорт

                                   , set_clause => 'VALUE = ''ТЕСТОВИЙ ВІДДІЛ''
                                                   '

                                   , where_clause => 'tag in (''PASP1'')'
                                  );
    depersonalization.update_table(stable => l_tab
                                   --Дата видачі: Алгоритм №4

                                   , set_clause => 'VALUE = depersonalization.alg4(to_date(VALUE, ''dd.mm.yyyy''))
                                                   '
                                   , where_clause => 'tag in (''PASP2'')'
                                  );

    bpa.enable_policies(p_table_name => l_tab);       --энейблим политики
    p_ref_constraints_en_novalid(stable => l_tab );   --энейблим реф-констрейнты
    p_constraints_fk_en_novalid(stable => l_tab );    --энейблим фк-констрейнты
    p_constraints_chk_en_novalid(stable => l_tab );   --энейблим чек-констрейнты
    p_triggers_enable(stable => l_tab );              --энейблим триггера
    p_indexes_usable(stable => l_tab );               --ребилдим все анъюзибл индексы на нашей таблице

  end dep_operw;



end;
/
