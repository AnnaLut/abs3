
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/ibank_mgr.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.IBANK_MGR authid current_user is
  --
  --  ibank_mgr - пакет для обслуживания системи corp2
  --

  g_header_version constant varchar2(64) := 'version 1.0 03/09/2014';

  g_awk_header_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- enable_mod - установка модифицированого режима работы
  -- p_flag - true (включить), false (выключить)
  --
  procedure enable_mod(p_flag boolean);

  --------------------------------------------------------------------------------
  -- create_dblink - создать dblink на базу IBANK
  --
  procedure create_dblink(p_dblink_name in varchar2, p_user_name in varchar2, p_user_pass in varchar2, p_ibank_host in varchar2, p_ibank_port in varchar2, p_ibank_service_name in varchar2);

  --------------------------------------------------------------------------------
  -- get_dblink_name - возвращает имя дблинка (IBANK или IBTEST)
  --
  function get_dblink_name return varchar2;

  --------------------------------------------------------------------------------
  -- get_dblink_username - возвращает имя пользователя дблинка
  --
  function get_dblink_username return varchar2;

  --------------------------------------------------------------------------------
  -- resync_tables - полная синхронизация таблиц начиная с даты p_startdate
  --
  procedure resync_tables(p_startdate date default trunc(sysdate - 1));

  --------------------------------------------------------------------------------
  -- stop_streams - остановка потоков
  --
  procedure stop_streams(p_force boolean default FALSE);

  --------------------------------------------------------------------------------
  -- start_streams - запуск потоков
  --
  procedure start_streams;

  --------------------------------------------------------------------------------
  -- restart_streams - перезапуск потоков
  --
  procedure restart_streams;

  --------------------------------------------------------------------------------
  -- stop_sched_jobs - остановка заданий
  --
  procedure stop_sched_jobs;

  --------------------------------------------------------------------------------
  -- start_sched_jobs - запуск заданий
  --
  procedure start_sched_jobs;

  ----
  -- kill_blocking_sessions - убиваем блокирующие сессии
  --
  procedure kill_blocking_sessions;

  --------------------------------------------------------------------------------
  -- build_dictionary - создание словаря
  --
  procedure build_dictionary;

  --------------------------------------------------------------------------------
  -- recreate_tr_capture - пересоздание процесса TR_CAPTURE
  --
  procedure recreate_tr_capture;

  --------------------------------------------------------------------------------
  -- drop_streams - полное удаление процессов
  --
  procedure drop_streams;

  --------------------------------------------------------------------------------
  -- recreate_streams - базовое пересоздание процессов
  --
  procedure recreate_streams;

  --------------------------------------------------------------------------------
  -- recreate_streams_full - полное пересоздание процессов
  --
  procedure recreate_streams_full;

  --------------------------------------------------------------------------------
  -- restart_tr_capture - полный перезапуск процесса TR_CAPTURE (учитывая удаленный перезапуск на базе IBANK)
  --
  procedure restart_tr_capture;

  --------------------------------------------------------------------------------
  -- streams_status - состояние потоков
  --
  function streams_status return bars.varchar2_list
    pipelined;

  --------------------------------------------------------------------------------
  -- sync_status_docs - состояние синхронизации DOC_EXPORT
  --
  -- @p_days - к-во дней для анализа
  function sync_status_docs(p_days in integer default 1) return varchar2;

  --------------------------------------------------------------------------------
  -- alignment_statuses - принудительное выравнивание статусов DOC_EXPORT
  --
  -- @p_days - к-во дней начиная с которого
  procedure alignment_statuses(p_days in integer default 1);

  --------------------------------------------------------------------------------
  -- alignment_statuses_by_interval - выравнивание статусов DOC_EXPORT за интервал дат
  --
  -- @p_start_date - дата начала
  -- @p_finish_date - дата начала
  procedure alignment_statuses_by_interval(p_start_date in date default trunc(sysdate-1), p_finish_date in date default trunc(sysdate));

  --------------------------------------------------------------------------------
  -- sync_status_trans - состояние синхронизации ACC_TRANSACTIONS
  --
  -- @p_days - к-во дней для анализа
  function sync_status_trans(p_days in integer default 1) return varchar2;

  --------------------------------------------------------------------------------
  -- sync_status_turns - состояние синхронизации ACC_TURNOVERS
  --
  -- @p_days - к-во дней для анализа
  function sync_status_turns(p_days in integer default 1) return varchar2;

  --------------------------------------------------------------------------------
  -- restart_full_import_job - перезапуск Sched. Job-a FULL_IMPORT_JOB
  --
  procedure restart_full_import_job;

  --------------------------------------------------------------------------------
  -- enable_job_sync - включение режима синхронизации на джобах - не желательно
  --
  procedure enable_job_sync;

end ibank_mgr;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.IBANK_MGR is
  --
  --  ibank_mgr - пакет для обслуживания системи corp2
  --

  g_body_version  constant varchar2(64) := 'version 1.2 13/09/2016';
  g_awk_body_defs constant varchar2(512) := '';

  g_module_name    constant varchar2(3) := 'IBM'; -- Internet Banking Module
  g_trace          constant varchar2(20) := 'ibank_mgr.';
  g_cb_capture     constant varchar2(20) := 'CB_CAPTURE';
  g_tr_capture     constant varchar2(20) := 'TR_CAPTURE';
  g_apply          constant varchar2(20) := 'CB_APPLY';
  g_propogation    constant varchar2(20) := 'TR_PROPAGATION';
  g_tr_queue       constant varchar2(20) := 'TR_Q';
  g_tr_queue_table constant varchar2(20) := 'TR_QT';
  g_cb_queue       constant varchar2(20) := 'CB_QUEUE';
  g_cb_queue_table constant varchar2(20) := 'CB_QUEUE_TABLE';

  g_action_stop    constant varchar2(10) := 'STOP';
  g_action_start   constant varchar2(10) := 'START';
  g_action_drop    constant varchar2(10) := 'DROP';
  g_action_create  constant varchar2(10) := 'CREATE';
  g_action_enable  constant varchar2(10) := 'ENABLE';
  g_action_disable constant varchar2(10) := 'DISABLE';

  g_job_monitor constant varchar2(20) := 'SYNC_MONITOR_JOB';

  l_first_scn number; -- проверка
  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета 3333
  --
  function header_version return varchar2 is
  begin
    return 'Package header ibank_mgr ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета 222
  --
  function body_version return varchar2 is
  begin
    return 'Package body ibank_mgr ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
  end body_version;

  --------------------------------------------------------------------------------
  -- write_output - вывод сообщения в журнал аудита и в поток dbms_output
  --
  procedure write_output(p_message in varchar2) is
  begin
    bars.bars_audit.info(p_message);
    dbms_output.put_line(p_message);
  end;

  --------------------------------------------------------------------------------
  -- enable_mod - установка модифицированого режима работы
  -- p_flag - true (включить), false (выключить)
  --
  procedure enable_mod(p_flag boolean) is
  begin
    if p_flag = true then
      update SYNC_TABLES
         set sync_sql = 'begin barsaq.data_import.job_sync_doc_export_mod(:p_startdate); end;'
       where table_name = 'DOC_EXPORT';
    else
      update SYNC_TABLES
         set sync_sql = 'begin barsaq.data_import.job_sync_doc_export(:p_startdate); end;'
       where table_name = 'DOC_EXPORT';
    end if;
  end;

  --------------------------------------------------------------------------------
  -- create_dblink - создать dblink на базу IBANK
  --
  procedure create_dblink(p_dblink_name        in varchar2,
                          p_user_name          in varchar2,
                          p_user_pass          in varchar2,
                          p_ibank_host         in varchar2,
                          p_ibank_port         in varchar2,
                          p_ibank_service_name in varchar2) is
  begin
    begin
      execute immediate 'DROP DATABASE LINK "' || p_dblink_name || '"';
    exception
      when others then if sqlcode = -2024 then null; else raise; end if;
    end;

    execute immediate 'create database link "'|| p_dblink_name||'" connect to ' || p_user_name || ' identified by ' || p_user_pass || ' using ''
    (DESCRIPTION =
     (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = ' || p_ibank_host || ')(PORT = ' || p_ibank_port || '))
     )
     (CONNECT_DATA = (SERVICE_NAME = ' || p_ibank_service_name || ')))''';
  end;

  --------------------------------------------------------------------------------
  -- get_dblink_name - возвращает имя дблинка (IBANK или IBTEST)
  --
  function get_dblink_name return varchar2 is
    l_db_link user_db_links.db_link%type;
  begin
    select db_link into l_db_link from user_db_links where db_link like 'IB%.UA' and rownum < 2;
    return l_db_link;
  end;

  --------------------------------------------------------------------------------
  -- get_dblink_username - возвращает имя пользователя дблинка
  --
  function get_dblink_username return varchar2 is
    l_db_username user_db_links.username%type;
  begin
    select username into l_db_username from user_db_links where db_link like 'IB%.UA';
    return l_db_username;
  end;

  --------------------------------------------------------------------------------
  -- resync_tables - полная синхронизация таблиц начиная с даты p_startdate
  --
  procedure resync_tables(p_startdate date default trunc(sysdate - 1)) is
    l_trace     varchar2(1000) := g_trace || 'resync_tables: ';
    l_startdate date;
    p_flag      number;
    l_count     number;
    l_timeout   number; -- время работы синхронизации в мин.
    l_scn           number;
  begin
    l_startdate := p_startdate;
    if p_startdate < sysdate - 7 then
      l_startdate := trunc(sysdate - 6);
    end if;
    write_output(l_trace || 'start, p_startdate=' || to_char(l_startdate, 'DD.MM.YYYY'));

    stop_streams;
    l_scn := dbms_flashback.get_system_change_number();

    write_output(l_trace || 'begin job_sync_streams_heartbeat');
    data_import.job_sync_streams_heartbeat;
    write_output(l_trace || 'begin job_sync_branches');
    data_import.job_sync_branches;
    write_output(l_trace || 'begin job_sync_bankdates');
    data_import.job_sync_bankdates;
    write_output(l_trace || 'begin job_sync_currency_rates');
    data_import.job_sync_currency_rates(l_startdate);
    write_output(l_trace || 'begin job_sync_doc_export_mod');
    data_import.job_sync_doc_export_mod(l_startdate);
    write_output(l_trace || 'begin job_sync_all_account_stmt');
    data_import.job_sync_all_account_stmt(l_startdate);
    write_output(l_trace || 'begin job_sync_curexch_params');
    data_import.job_sync_curexch_params();
    write_output(l_trace || 'begin job_sync_curexch_custcomm');
    data_import.job_sync_curexch_custcomm();
    write_output(l_trace || 'begin job_sync_curexch_exclusive');
    data_import.job_sync_curexch_exclusive();
    write_output(l_trace || 'begin job_sync_cust_address');
    data_import.job_sync_cust_address();

    l_count     := 1;
    l_startdate := sysdate;
    while l_count > 0 loop
      -- спим 10 сек.
      dbms_lock.sleep(10);
      -- вычисляем сколько работаем
      l_timeout := (sysdate - l_startdate) * 24 * 60;
      -- смотрим к-во таблиц что еще в процессе
      select count(*) into l_count from sync_activity where status not in ('FAILED', 'SUCCEEDED');

      -- если перевалили за 20 мин.
      if l_timeout >= 20 then
        p_flag := 0;
        write_output(l_trace || 'перевищено ліміт у 20 хв. очікування');
        exit;
      end if;
    end loop;
    write_output(l_trace || ' finish=' || to_char(sysdate, 'DD.MM.YYYY HH24:MI:SS'));
    start_streams;
  end;

  --------------------------------------------------------------------------------
  -- manage_apply - управление процессом apply
  --
  -- p_action: 'STOP', 'START', 'DROP', 'CREATE'
  --
  procedure manage_apply(p_action varchar2, p_force boolean default FALSE, p_queue_name varchar2 default null) is
    l_trace varchar2(4000) := g_trace || 'manage_apply(p_action => "' || p_action || '", p_force => "' || (CASE p_force
                                when true then
                                 'Y'
                                ELSE
                                 'N'
                              END) || '"): ';
  begin
    case p_action
      when g_action_stop then
        bars.bars_audit.info(l_trace || 'остановка процесса ' || g_apply);
        dbms_apply_adm.stop_apply(g_apply, p_force);

      when g_action_start then
        write_output(l_trace || 'запуск процесса ' || g_apply);
        dbms_apply_adm.start_apply(g_apply);

      when g_action_drop then
        write_output(l_trace || 'удаление процесса ' || g_apply);
        dbms_apply_adm.delete_all_errors;
        dbms_apply_adm.drop_apply(g_apply, p_force);

      when g_action_create then
        write_output(l_trace || 'создание процесса ' || g_apply || ', очередь - ' || p_queue_name);
        begin
            dbms_apply_adm.create_apply(queue_name => p_queue_name, apply_name => g_apply, apply_captured => true, apply_tag => null);
        exception when others then if sqlcode = -4020 then
            dbms_lock.sleep(5);
            dbms_apply_adm.create_apply(queue_name => p_queue_name, apply_name => g_apply, apply_captured => true, apply_tag => null);
          else  raise;
          end if;
        end;
        dbms_apply_adm.set_parameter(apply_name => 'CB_APPLY', parameter => 'disable_on_error', value => 'y');
        dbms_apply_adm.set_parameter(apply_name => 'CB_APPLY', parameter => 'PARALLELISM',      value => '1');
      else
        bars.bars_error.raise_error(G_MODULE_NAME, 100, p_action);
    end case;
  exception
    when others then
      if sqlcode = -26701 then
        -- STREAMS process ... does not exist
        null;
      else
        raise;
      end if;
  end;

  --------------------------------------------------------------------------------
  -- manage_capture - управление процессом capture
  --
  -- p_action: 'STOP', 'START', 'DROP', 'CREATE'
  --
  procedure manage_capture(p_action varchar2, p_capture_name varchar2, p_force boolean default FALSE, p_queue_name varchar2 default null) is
    l_trace varchar2(4000) := g_trace || 'manage_capture(p_action => "' || p_action || '", p_capture_name => "' || p_capture_name || '", p_force => "' || (CASE p_force
                                when true then
                                 'Y'
                                ELSE
                                 'N'
                              END) || '"): ';
  begin
    case p_action
      when g_action_stop then
        begin
          write_output(l_trace || 'остановка процесса ' || p_capture_name);
          dbms_capture_adm.stop_capture(p_capture_name, p_force);
        exception
          when others then
            if sqlcode = -26701 then
              null; --STREAMS process ... does not exist
            else
              raise;
            end if;
        end;

      when g_action_start then
        begin
          write_output(l_trace || 'запуск процесса ' || p_capture_name);
          dbms_capture_adm.start_capture(p_capture_name);
        exception
          when others then
            if sqlcode in (-26666, -26701) then
              null; -- cannot alter STREAMS process (allready runing)
            else
              raise;
            end if;
        end;

      when g_action_drop then
        begin
          write_output(l_trace || 'удаление процесса ' || p_capture_name);
          dbms_capture_adm.drop_capture(p_capture_name);
        exception
          when others then
            if sqlcode = -26701 then
              null; --STREAMS process BARS_CAPTURE does not exist
            else
              raise;
            end if;
        end;

      when g_action_create then
        begin
          write_output(l_trace || 'создание процесса ' || p_capture_name || ', очередь - ' || p_queue_name);
          dbms_capture_adm.create_capture(queue_name => p_queue_name, capture_name => p_capture_name, start_scn => l_first_scn, first_scn => l_first_scn, checkpoint_retention_time => 1/24);
        exception
          when others then
            if sqlcode = -26665 then
              null;
            else
              raise;
            end if;
        end;

      else
        bars.bars_error.raise_error(G_MODULE_NAME, 200, p_action);

    end case;
  end;

  --------------------------------------------------------------------------------
  -- manage_propogation - управление процессом propogation
  --
  -- p_action: 'STOP', 'START', 'DROP', 'CREATE'
  --
  procedure manage_propogation(p_action varchar2) is
    l_trace varchar2(1000) := g_trace || 'manage_propogation(p_action => "' || p_action || '"): ';
  begin
    case p_action
      when g_action_stop then
        write_output(l_trace || 'остановка процесса ' || g_propogation);
        dbms_propagation_adm.stop_propagation(g_propogation, TRUE);

      when g_action_start then
        write_output(l_trace || 'запуск процесса ' || g_propogation);
        dbms_propagation_adm.start_propagation(g_propogation);

      when g_action_drop then
        write_output(l_trace || 'удаление процесса ' || g_propogation);
        dbms_propagation_adm.drop_propagation(g_propogation, TRUE);

      when g_action_create then
        write_output(l_trace || 'создание процесса ' || g_propogation);
        dbms_propagation_adm.create_propagation(propagation_name          => g_propogation,
                                                source_queue              => 'BARSAQ.TR_Q',
                                                destination_queue         => 'BANK.TR_' || get_dblink_username() || '_Q',
                                                destination_dblink        => get_dblink_name(),
                                                rule_set_name             => null,
                                                negative_rule_set_name    => null,
                                                queue_to_queue            => true,
                                                original_propagation_name => null,
                                                auto_merge_threshold      => null);

      else
        bars.bars_error.raise_error(G_MODULE_NAME, 300, p_action);
    end case;
  exception
    when no_data_found then
      null;
    when others then
      if sqlcode = -23601 or sqlcode = -24042 or sqlcode = -24064  then
        null;
      else
        raise;
      end if;
  end;

  --------------------------------------------------------------------------------
  -- manage_queue - управление процессом queue
  --
  -- p_action: 'STOP', 'START', 'DROP', 'CREATE'
  --
  procedure manage_queue(p_action varchar2, p_queue_name varchar2, p_queue_table varchar2 default null) is
    l_trace varchar2(1000) := g_trace || 'manage_queue(p_action => "' || p_action || '", p_queue_name => "' || p_queue_name || '", p_queue_table => "' || p_queue_table || '"): ';
  begin
    case p_action
      when g_action_stop then
        write_output(l_trace || 'остановка очереди ' || p_queue_name);
        dbms_aqadm.stop_queue(p_queue_name);

      when g_action_start then
        write_output(l_trace || 'запуск очереди ' || p_queue_name);
        dbms_aqadm.stop_queue(p_queue_name);

      when g_action_drop then
        write_output(l_trace || 'удаление очереди ' || p_queue_name);
        dbms_aqadm.drop_queue(p_queue_name);
        write_output(l_trace || 'удаление таблицы очереди ' || p_queue_table);
        dbms_aqadm.drop_queue_table(p_queue_table, true);

      when g_action_create then
        write_output(l_trace || 'создание очереди ' || p_queue_name);
        dbms_streams_adm.set_up_queue(queue_table => p_queue_table, queue_name => p_queue_name, queue_user => 'BARSAQ');

      else
        bars.bars_error.raise_error(G_MODULE_NAME, 300, p_action);
    end case;
  exception
    when no_data_found then
      null;
    when others then
      if sqlcode in (-24010, -24002) then
        null;
      else
        raise;
      end if;
  end;

  --------------------------------------------------------------------------------
  -- manage_scheduler - управление заданиями
  --
  -- p_action: 'STOP', 'START', 'DROP', 'CREATE'
  --
  procedure manage_scheduler(p_action varchar2, p_job_name varchar2, p_force boolean default FALSE) is
    l_trace varchar2(1000) := g_trace || 'manage_scheduler(p_action => "' || p_action || '", p_job_name => "' || p_job_name || '"): ';
  begin
    case p_action
      when g_action_disable then
        write_output(l_trace || 'отключение задания ' || p_job_name);
        sys.dbms_scheduler.disable(name => p_job_name, force => p_force);

      when g_action_enable then
        write_output(l_trace || 'включение задания ' || p_job_name);
        sys.dbms_scheduler.enable(name => p_job_name);

      when g_action_stop then
        write_output(l_trace || 'остановка задания ' || p_job_name);
        sys.dbms_scheduler.stop_job(job_name => p_job_name, force => TRUE);

      when g_action_start then
        write_output(l_trace || 'запуск задания ' || p_job_name);
        sys.dbms_scheduler.run_job(job_name => p_job_name);

      when g_action_drop then
        write_output(l_trace || 'удаление задания ' || p_job_name);
        sys.dbms_scheduler.drop_job(job_name => p_job_name);

      when g_action_create then
        write_output(l_trace || 'создание задания ' || p_job_name);
      else
        bars.bars_error.raise_error(G_MODULE_NAME, 300, p_action);
    end case;
  exception
    when no_data_found then
      null;
    when others then
      if sqlcode in (-27366, -27475) then
        null;
      else
        raise;
      end if;
  end;

  --------------------------------------------------------------------------------
  -- stop_streams - остановка потоков
  --
  procedure stop_streams(p_force boolean default FALSE) is
  begin
    manage_apply(g_action_stop, p_force);
    manage_capture(g_action_stop, g_cb_capture, p_force);
    manage_capture(g_action_stop, g_tr_capture, p_force);
    manage_propogation(g_action_stop);
    commit;
  end;

  --------------------------------------------------------------------------------
  -- start_streams - запуск потоков
  --
  procedure start_streams is
  begin
    manage_apply(g_action_start);
    manage_capture(g_action_start, g_cb_capture);
    manage_capture(g_action_start, g_tr_capture);
    manage_propogation(g_action_start);
    commit;
  end;

  --------------------------------------------------------------------------------
  -- restart_streams - перезапуск потоков
  --
  procedure restart_streams is
  begin
    stop_streams;
    start_streams;
  end;

  --------------------------------------------------------------------------------
  -- stop_sched_jobs - остановка заданий
  --
  procedure stop_sched_jobs is
  begin
    manage_scheduler(g_action_disable, g_job_monitor);
  end;

  --------------------------------------------------------------------------------
  -- start_sched_jobs - запуск заданий
  --
  procedure start_sched_jobs is
  begin
    manage_scheduler(g_action_enable, g_job_monitor);
  end;

  --------------------------------------------------------------------------------
  -- build_dictionary - создание словаря
  --
  procedure build_dictionary is
    l_trace     varchar2(1000) := g_trace || 'build_dictionary: ';
    l_first_scn number;
  begin
    write_output(l_trace || ' start dbms_capture_adm.build');
    dbms_capture_adm.build(l_first_scn);
    write_output(l_trace || ' finish dbms_capture_adm.build, l_first_scn=' || l_first_scn);
    --
    update sync_parameters set param_value = to_char(l_first_scn) where param_name = 'FIRST_SCN';
    --
    if sql%rowcount = 0 then
      insert into sync_parameters
        (param_name, param_value, param_comment)
      values
        ('FIRST_SCN', to_char(l_first_scn), 'Значение FIRST_SCN(начальная точка) для процессов захвата(capture)');
    end if;

    --
    commit;
  end;

  ----
  -- add_table_rule_tr_capture - добавляем правила на таблицу для процесса tr_capture
  --
  procedure add_table_rule_tr_capture(p_table_name in varchar2, p_condition in varchar2 default null) is
    l_trace   varchar2(1000) := g_trace || 'add_table_rule_tr_capture: ';
    l_dmlrule varchar2(60);
    l_ddlrule varchar2(60);
  begin
    dbms_streams_adm.add_table_rules(table_name     => p_table_name,
                                     streams_type   => 'capture',
                                     streams_name   => g_tr_capture,
                                     queue_name     => 'barsaq.tr_q',
                                     include_dml    => true,
                                     include_ddl    => false,
                                     inclusion_rule => true,
                                     and_condition  => p_condition,
                                     dml_rule_name  => l_dmlrule,
                                     ddl_rule_name  => l_ddlrule);
    --
    dbms_streams_adm.rename_schema(rule_name => l_dmlrule, from_schema_name => 'BARSAQ', to_schema_name => 'BANK');
    write_output(l_trace || ' done for p_table_name=' || p_table_name);
  end add_table_rule_tr_capture;


  ----
  -- set_dml_handler обработчики для удаленного применения
  --
  procedure set_dml_handler(p_object_name    in varchar2,
                            p_user_procedure in varchar2) is
    l_trace varchar2(1000) := g_trace || 'set_dml_handler: ';
  begin
    dbms_apply_adm.set_dml_handler(object_name => p_object_name, object_type => 'TABLE', operation_name => 'DEFAULT', error_handler => false, user_procedure => p_user_procedure, apply_name => g_apply);
    write_output(l_trace || ' set_dml_handler, p_object_name= ' || p_object_name || ', p_user_procedure= ' || p_user_procedure);
  end;

  ----
  -- add_table_rule_cb_apply - добавляем правила на таблицу для процесса cb_apply
  --
  procedure add_table_rule_cb_apply(p_table_name in varchar2, p_condition in varchar2 default null, p_transform_function in varchar2 default null, p_rename_table in varchar2 default null) is
    l_trace   varchar2(1000) := g_trace || 'add_table_rule_cb_apply: ';
    l_dmlrule varchar2(60);
    l_ddlrule varchar2(60);
  begin
    dbms_streams_adm.add_table_rules(table_name    => p_table_name,
                                     streams_type  => 'APPLY',
                                     streams_name  => g_apply,
                                     queue_name    => 'BARSAQ.CB_QUEUE',
                                     include_dml   => true,
                                     include_ddl   => false,
                                     and_condition => p_condition,
                                     dml_rule_name => l_dmlrule,
                                     ddl_rule_name => l_ddlrule);
    --
    if p_transform_function is not null then
      dbms_streams_adm.set_rule_transform_function(rule_name => l_dmlrule, transform_function => p_transform_function);
      write_output(l_trace || ' set_rule_transform_function, transform_function= ' || p_transform_function);
    elsif p_rename_table is not null then
      dbms_streams_adm.rename_schema(rule_name => l_dmlrule, from_schema_name => 'BARS', to_schema_name => 'BARSAQ', step_number => 0, operation => 'ADD');
      dbms_streams_adm.rename_table(rule_name => l_dmlrule, from_table_name => replace(p_table_name, 'BARS.', ''), to_table_name => p_rename_table, step_number => 1, operation => 'ADD');
      write_output(l_trace || ' rename_table, to_table_name= ' || p_rename_table);
    else
      dbms_streams_adm.rename_schema(rule_name => l_dmlrule, from_schema_name => 'BARS', to_schema_name => 'BARSAQ');
      write_output(l_trace || ' rename_schema BARS  => BARSAQ');
    end if;
    write_output(l_trace || ' done for p_table_name=' || p_table_name);
  end add_table_rule_cb_apply;

  ----
  -- add_table_rule_cb_capture - добавляем правила на таблицу для процесса cb_capture
  --
  procedure add_table_rule_cb_capture(p_table_name in varchar2, p_condition in varchar2 default null) is
    l_trace varchar2(1000) := g_trace || 'add_table_rule_cb_capture: ';
  begin
    dbms_streams_adm.add_table_rules(table_name    => p_table_name,
                                     streams_type  => 'CAPTURE',
                                     streams_name  => g_cb_capture,
                                     queue_name    => 'BARSAQ.CB_QUEUE',
                                     include_dml   => true,
                                     include_ddl   => false,
                                     and_condition => p_condition);
    --
    write_output(l_trace || ' done for p_table_name=' || p_table_name);
  end add_table_rule_cb_capture;

  ----
  -- kill_blocking_sessions - убиваем блокирующие сессии
  --
  procedure kill_blocking_sessions is
    l_trace   varchar2(1000) := g_trace || 'kill_blocking_sessions: ';
    l_sid     number;
    l_serial  number;
  begin
    loop
        begin
          select s.sid, s.serial#
            into l_sid, l_serial
            from v$session s, v$lock l1
           where l1.type = 'TX'
             and l1.lmode = 6
             and s.sid = l1.sid
             and l1.block = 1
             and rownum < 2
             and not exists (select *
                    from v$lock l2
                   where l2.type = 'TX'
                     and l2.request > 0
                     and l1.sid = l2.sid);
        exception
          when no_data_found then
            exit;
        end;
        write_output(l_trace || ' kill user session ' || l_sid || ',' || l_serial);
        begin
            execute immediate 'ALTER SYSTEM KILL SESSION ''' || l_sid || ',' || l_serial || ''' IMMEDIATE';
        exception when others then null;
        end;
        dbms_lock.sleep(2);
      end loop;
  end;

  ----
  -- job_build_dictionary - создание задания по созданию словаря
  --
  procedure job_build_dictionary(p_flag out number) is
    l_trace   varchar2(1000) := g_trace || 'job_build_dictionary: ';
    l_jobid   binary_integer;
    l_job_sid number;
    l_timeout number; -- время работы джоба в мин.
    l_sid     number;
    l_serial  number;
  begin
    dbms_job.submit(l_jobid, 'begin ibank_mgr.build_dictionary; end;');
    write_output(l_trace || ' l_jobid=' || l_jobid);
    commit;
    --
    -- засыпаем на 5 сек.
    dbms_lock.sleep(5);
    p_flag := 1;
    while p_flag > 0 loop
      -- убиваем блокирующие сесии
      kill_blocking_sessions;

      -- проверка работает ли еще job
      begin
        select (sysdate - this_date) * (24 * 60), sid into l_timeout, l_job_sid from dba_jobs_running where job = l_jobid;
      exception
        when no_data_found then
          write_output(l_trace || ' не найден l_jobid=' || l_jobid);
          p_flag := 0;
          exit;
      end;
      write_output(l_trace || ' waiting for done, l_jobid=' || l_jobid || ', l_job_sid=' || l_job_sid || ', l_timeout=' || round(l_timeout * 60));
      dbms_lock.sleep(10);

      -- превысили лимит ожидания - рубим job
      if l_timeout >= 2 then
        p_flag := -1;
        dbms_job.broken(l_jobid, TRUE);
        dbms_job.remove(l_jobid);
        begin
          select sid, serial# into l_sid, l_serial from v$session where sid = l_job_sid;
          execute immediate 'ALTER SYSTEM KILL SESSION ''' || l_sid || ',' || l_serial || ''' IMMEDIATE';
          write_output(l_trace || ' kill job session ' || l_sid || ',' || l_serial);
        exception
          when others then
            null;
        end;
        write_output(l_trace || ' перевищено ліміт у 2 хв. очікування');
        commit;
        exit;
      end if;
    end loop;
  end job_build_dictionary;

  --------------------------------------------------------------------------------
  -- recreate_tr_capture - пересоздание процесса TR_CAPTURE
  --
  procedure recreate_tr_capture is
    l_trace varchar2(1000) := g_trace || 'recreate_tr_capture: ';
    l_flag  number;
  begin
    write_output(l_trace || ' удаление процессов');
    -- остановка задания SYNC_MONITOR_JOB
    manage_scheduler(g_action_disable, g_job_monitor);
    -- stop propagation
    manage_propogation(g_action_stop);
    -- drop propagation
    manage_propogation(g_action_drop);
    -- stop capture
    manage_capture(g_action_stop, g_tr_capture, true);
    -- drop capture
    manage_capture(g_action_drop, g_tr_capture);
    -- stop queue
    manage_queue(g_action_stop, g_tr_queue);
    -- drop queue and table
    manage_queue(g_action_drop, g_tr_queue, g_tr_queue_table);
    -- build dictioonary
    job_build_dictionary(l_flag);
    if l_flag = 0 then
      -- получаем  l_first_scn
      select to_number(param_value) into l_first_scn from sync_parameters where param_name = 'FIRST_SCN';

      -- очередь tr_queue
      manage_queue(g_action_create, g_tr_queue, g_tr_queue_table);

      -- процесс tr_capture
      manage_capture(g_action_create, g_tr_capture, false, g_tr_queue);

      -- правило для захвата BARSAQ.STREAMS_HEARTBEAT
      add_table_rule_tr_capture('BARSAQ.STREAMS_HEARTBEAT');

      -- правило для захвата BARSAQ.BRANCHES
      add_table_rule_tr_capture('BARSAQ.BRANCHES');

      -- правило для захвата BARSAQ.BANKDATES
      add_table_rule_tr_capture('BARSAQ.BANKDATES');

      -- правило для захвата BARSAQ.CURRENCY_RATES
      add_table_rule_tr_capture('BARSAQ.CURRENCY_RATES');

      -- правило для захвата BARSAQ.DOC_EXPORT
      add_table_rule_tr_capture('BARSAQ.DOC_EXPORT', ' (:dml.get_value(''NEW'',''STATUS_ID'').AccessNumber() > 45 or :dml.get_value(''NEW'',''STATUS_ID'').AccessNumber() < 0) ');

      -- правило для захвата BARSAQ.ACC_TURNOVERS
      add_table_rule_tr_capture('BARSAQ.ACC_TURNOVERS');

      -- правило для захвата BARSAQ.ACC_TRANSACTIONS
      add_table_rule_tr_capture('BARSAQ.ACC_TRANSACTIONS');

      -- правило для захвата BARSAQ.DOC_CUREX_PARAMS
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_PARAMS');

      -- правило для захвата BARSAQ.DOC_CUREX_CUSTCOMMISSIONS
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_CUSTCOMMISSIONS');

      -- правило для захвата BARSAQ.DOC_CUREX_EXCLUSIVE
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_EXCLUSIVE');

      -- правило для захвата BARSAQ.CUST_ADDRESSES
      add_table_rule_tr_capture('BARSAQ.CUST_ADDRESSES');

      -- создаем TR_PROPAGATION
      manage_propogation(g_action_create);

      -- пересинхронизация таблиц
      resync_tables;

      -- запускаем задание SYNC_MONITOR_JOB
      manage_scheduler(g_action_enable, g_job_monitor);
    end if;
  end;

  --------------------------------------------------------------------------------
  -- drop_streams - полное удаление процессов
  --
  procedure drop_streams is
    l_trace varchar2(1000) := g_trace || 'recreate_streams: ';
    l_num   number;
  begin
    write_output(l_trace || ' удаление процессов - start');
    -- остановка задания SYNC_MONITOR_JOB
    manage_scheduler(g_action_disable, g_job_monitor);
    -- stop capture CB_CAPTURE
    manage_capture(g_action_stop, g_cb_capture, true);
    -- drop capture CB_CAPTURE
    manage_capture(g_action_drop, g_cb_capture);
    -- stop apply CB_APPLY
    manage_apply(g_action_stop, true);
    -- drop apply CB_APPLY
    manage_apply(g_action_drop, true);
    -- stop queue CB_QUEUE
    manage_queue(g_action_stop, g_cb_queue);
    -- drop queue CB_QUEUE and table
    -- manage_queue(g_action_drop, g_cb_queue, g_cb_queue_table);
    begin
      select 1 into l_num from dba_capture where capture_name = 'BARS_CAPTURE';
    exception
      when no_data_found then
        begin
          execute immediate 'alter table bars.opldok drop supplemental log data (all) columns';
        exception
          when others then
            if sqlcode in (-32587) then
              null;
            else
              raise;
            end if;
        end;
    end;
    -- Remove all apply dml handlers
    for c in (select * from dba_apply_dml_handlers where apply_name = g_apply) loop
      dbms_apply_adm.set_dml_handler(object_name    => c.object_owner || '.' || c.object_name,
                                     object_type    => 'TABLE',
                                     operation_name => c.operation_name,
                                     error_handler  => case
                                                         when c.error_handler = 'Y' then
                                                          true
                                                         else
                                                          false
                                                       end,
                                     user_procedure => NULL,
                                     apply_name     => c.apply_name);
    end loop;

    -- stop propagation
    manage_propogation(g_action_stop);
    -- drop propagation
    manage_propogation(g_action_drop);
    -- stop capture
    manage_capture(g_action_stop, g_tr_capture, true);
    -- drop capture
    manage_capture(g_action_drop, g_tr_capture);
    -- stop queue
    manage_queue(g_action_stop, g_tr_queue);
    -- drop queue and table
    -- manage_queue(g_action_drop, g_tr_queue, g_tr_queue_table);

    write_output(l_trace || ' удаление процессов - finish');
    commit;
  end;

  --------------------------------------------------------------------------------
  -- recreate_streams - базовое пересоздание процессов
  --
  procedure recreate_streams is
    l_trace varchar2(1000) := g_trace || 'recreate_streams: ';
    l_flag  number;
  begin
    write_output(l_trace || ' пересоздание процессов - start');
    -- остановка задания SYNC_MONITOR_JOB
    stop_sched_jobs;
    -- stop_streams - остановка потоков
    stop_streams(true);
    -- drop capture CB_CAPTURE
    manage_capture(g_action_drop, g_cb_capture);
    -- drop capture
    manage_capture(g_action_drop, g_tr_capture);
    -- build dictioonary
    job_build_dictionary(l_flag);
    if l_flag = 0 then
      -- получаем  l_first_scn
      select to_number(param_value)
        into l_first_scn
        from sync_parameters
       where param_name = 'FIRST_SCN';

      -------------------------------------* CB_CAPTURE *---------------------------------------------
      -- create cb_capture
      manage_capture(g_action_create, g_cb_capture, false, g_cb_queue);

      -- правило для захвата BARS.STREAMS_HEARTBEAT
      add_table_rule_cb_capture(p_table_name => 'BARS.STREAMS_HEARTBEAT');
      -- правило для захвата BARS.SALDOA
      add_table_rule_cb_capture(p_table_name => 'BARS.SALDOA',
                                p_condition  => 'barsaq.ibank_accounts.is_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ACC'').AccessNumber()) = 1');
      -- правило для захвата BARS.OPLDOK
      add_table_rule_cb_capture(p_table_name => 'BARS.OPLDOK',
                                p_condition  => 'barsaq.ibank_accounts.is_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ACC'').AccessNumber()) = 1 ' ||
                                                'and (:dml.get_command_type()=''DELETE'' and :dml.get_value(''OLD'',''SOS'').AccessNumber()=5 or ' ||
                                                ':dml.get_value(''OLD'',''SOS'').AccessNumber()<>5 and :dml.get_value(''NEW'',''SOS'').AccessNumber()=5)');
      -- правило для захвата BARS.SOS_TRACK
      add_table_rule_cb_capture(p_table_name => 'BARS.SOS_TRACK',
                                p_condition  => 'barsaq.ibank_accounts.is_doc_imported(:dml.get_value(''NEW'',''REF'').AccessNumber()) = 1' ||
                                                ' and :dml.get_command_type()=''INSERT''' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() is not null' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() <> :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber()' ||
                                                ' and :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber() in (-2,-1,5)');
      -- правило для захвата BARS.BRANCH_ATTRIBUTE_VALUE
      add_table_rule_cb_capture(p_table_name => 'BARS.BRANCH_ATTRIBUTE_VALUE',
                                p_condition  => ':dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ATTRIBUTE_CODE'').AccessVarchar2()=''BANKDATE''');
      -- правило для захвата BARS.CUR_RATES$BASE
      add_table_rule_cb_capture(p_table_name => 'BARS.CUR_RATES$BASE',
                                p_condition  => ':dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''BRANCH'').AccessVarchar2() like ''/______/''');
      -- правило для захвата BARS.BRANCH
      add_table_rule_cb_capture(p_table_name => 'BARS.BRANCH',
                                p_condition  => ':dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''BRANCH'').AccessVarchar2() like ''/______/%''');
      -- правило для захвата BARS.BIRJA
      add_table_rule_cb_capture(p_table_name => 'BARS.BIRJA');
      -- правило для захвата BARS.CUST_ZAY
      add_table_rule_cb_capture(p_table_name => 'BARS.CUST_ZAY',
                                p_condition  => 'barsaq.ibank_accounts.is_cust_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber()) = 1 ');
      -- правило для захвата BARS.ZAY_COMISS
      add_table_rule_cb_capture(p_table_name => 'BARS.ZAY_COMISS',
                                p_condition  => 'barsaq.ibank_accounts.is_cust_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber()) = 1 ' ||
                                                ' or :dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber() is null');
      -- правило для захвата BARS.CUSTOMER_ADDRESS
      add_table_rule_cb_capture(p_table_name => 'BARS.CUSTOMER_ADDRESS',
                                p_condition  => 'barsaq.ibank_accounts.is_cust_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber()) = 1 ' ||
                                                ' or :dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber() is null');
      -- правило для захвата BARS.ZAY_TRACK
      add_table_rule_cb_capture(p_table_name => 'BARS.ZAY_TRACK',
                                p_condition  => 'barsaq.ibank_accounts.is_client_zayavka(:dml.get_value(''NEW'',''ID'').AccessNumber()) = 1' ||
                                                ' and :dml.get_command_type()=''INSERT''' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() is not null' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() <> :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber()' ||
                                                ' and :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber() in (-1,2)');

      -------------------------------------* TR_CAPTURE *---------------------------------------------
      -- процесс tr_capture
      manage_capture(g_action_create, g_tr_capture, false, g_tr_queue);

      -- правило для захвата BARSAQ.STREAMS_HEARTBEAT
      add_table_rule_tr_capture('BARSAQ.STREAMS_HEARTBEAT');

      -- правило для захвата BARSAQ.BRANCHES
      add_table_rule_tr_capture('BARSAQ.BRANCHES');

      -- правило для захвата BARSAQ.BANKDATES
      add_table_rule_tr_capture('BARSAQ.BANKDATES');

      -- правило для захвата BARSAQ.CURRENCY_RATES
      add_table_rule_tr_capture('BARSAQ.CURRENCY_RATES');

      -- правило для захвата BARSAQ.DOC_EXPORT
      add_table_rule_tr_capture('BARSAQ.DOC_EXPORT',
                                ' (:dml.get_value(''NEW'',''STATUS_ID'').AccessNumber() > 45 or :dml.get_value(''NEW'',''STATUS_ID'').AccessNumber() < 0) ');

      -- правило для захвата BARSAQ.ACC_TURNOVERS
      add_table_rule_tr_capture('BARSAQ.ACC_TURNOVERS');

      -- правило для захвата BARSAQ.ACC_TRANSACTIONS
      add_table_rule_tr_capture('BARSAQ.ACC_TRANSACTIONS');

      -- правило для захвата BARSAQ.DOC_CUREX_PARAMS
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_PARAMS');

      -- правило для захвата BARSAQ.DOC_CUREX_CUSTCOMMISSIONS
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_CUSTCOMMISSIONS');

      -- правило для захвата BARSAQ.DOC_CUREX_EXCLUSIVE
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_EXCLUSIVE');

      -- правило для захвата BARSAQ.CUST_ADDRESSES
      add_table_rule_tr_capture('BARSAQ.CUST_ADDRESSES');


      -- пересинхронизация таблиц
      resync_tables;

      -- запускаем задание SYNC_MONITOR_JOB
      manage_scheduler(g_action_enable, g_job_monitor);

      write_output(l_trace || ' пересоздание процессов - finish');
    end if;
  end recreate_streams;

  --------------------------------------------------------------------------------
  -- recreate_streams_full - полное пересоздание процессов
  --
  procedure recreate_streams_full is
    l_trace varchar2(1000) := g_trace || 'recreate_streams_full: ';
    l_flag  number;
  begin
    write_output(l_trace || ' пересоздание процессов - start');
    -- delete streams
    drop_streams;
    -- drop jobs
    manage_scheduler(g_action_drop, 'IBANK_SYNC_DOCUMENTS', TRUE);
    manage_scheduler(g_action_drop, 'IBANK_SYNC_DOCUMENTS_WEEK', TRUE);

    -- build dictioonary
    job_build_dictionary(l_flag);
    if l_flag = 0 then
      -- получаем  l_first_scn
      select to_number(param_value) into l_first_scn from sync_parameters where param_name = 'FIRST_SCN';

      -- очередь cb_queue
      manage_queue(g_action_create, g_cb_queue, g_cb_queue_table);
      -- create cb_apply
      manage_apply(g_action_create, false, g_cb_queue);
      -- правило для 'STREAMS_HEARTBEAT'
      add_table_rule_cb_apply(p_table_name => 'BARS.STREAMS_HEARTBEAT');
      -- правило для 'SALDOA'
      add_table_rule_cb_apply(p_table_name => 'BARS.SALDOA', p_transform_function => 'barsaq.ibank_accounts.transform_saldoa');
      -- правило для 'OPLDOK'
      add_table_rule_cb_apply(p_table_name => 'BARS.OPLDOK', p_rename_table => 'ACC_TRANSACTIONS');
      -- правило для 'SOS_TRACK --> DOC_EXPORT'
      add_table_rule_cb_apply(p_table_name => 'BARS.SOS_TRACK', p_transform_function => 'barsaq.ibank_accounts.doc_export');
      -- правило для 'PARAMS --> BANKDATES'
      add_table_rule_cb_apply(p_table_name => 'BARS.PARAMS$BASE', p_transform_function => 'barsaq.ibank_accounts.bankdates');
      -- правило для 'CURRENCY_RATES'
      add_table_rule_cb_apply(p_table_name => 'BARS.CUR_RATES$BASE', p_transform_function => 'barsaq.ibank_accounts.currency_rates');
      -- правило для 'BRANCH'
      add_table_rule_cb_apply(p_table_name => 'BARS.BRANCH', p_transform_function => 'barsaq.ibank_accounts.branches');
      -- правило для 'BIRJA'
      add_table_rule_cb_apply(p_table_name => 'BARS.BIRJA', p_transform_function => 'barsaq.ibank_accounts.doc_curex_params');
      -- правило для 'CUST_ZAY'
      add_table_rule_cb_apply(p_table_name => 'BARS.CUST_ZAY', p_transform_function => 'barsaq.ibank_accounts.doc_curex_custcommissions');
      -- правило для 'ZAY_COMISS'
      add_table_rule_cb_apply(p_table_name => 'BARS.ZAY_COMISS', p_transform_function => 'barsaq.ibank_accounts.doc_curex_exclusive');
      -- правило для 'CUSTOMER_ADDRESS'
      add_table_rule_cb_apply(p_table_name => 'BARS.CUSTOMER_ADDRESS', p_transform_function => 'barsaq.ibank_accounts.cust_addresses');
      -- правило для 'ZAY_TRACK'
      add_table_rule_cb_apply(p_table_name => 'BARS.ZAY_TRACK', p_rename_table => 'ZAYAVKA_ID_MAP');

      -- Обработчики для удаленного применения
      set_dml_handler(p_object_name => 'BARSAQ.ACC_TURNOVERS', p_user_procedure => 'barsaq.ibank_accounts.handler_sync');
      set_dml_handler(p_object_name => 'BARSAQ.ACC_TRANSACTIONS', p_user_procedure => 'barsaq.ibank_accounts.acc_transactions_handler');
      set_dml_handler(p_object_name => 'BARSAQ.DOC_EXPORT', p_user_procedure => 'barsaq.ibank_accounts.handler_sync');
      set_dml_handler(p_object_name => 'BARSAQ.BRANCHES', p_user_procedure => 'barsaq.ibank_accounts.handler_sync');
      set_dml_handler(p_object_name => 'BARSAQ.BANKDATES', p_user_procedure => 'barsaq.ibank_accounts.handler_sync');
      set_dml_handler(p_object_name => 'BARSAQ.CURRENCY_RATES', p_user_procedure => 'barsaq.ibank_accounts.handler_sync');
      set_dml_handler(p_object_name => 'BARSAQ.ZAYAVKA_ID_MAP', p_user_procedure => 'barsaq.ibank_accounts.zay_handler');

      -- create cb_capture
      manage_capture(g_action_create, g_cb_capture, false, g_cb_queue);

      -- правило для захвата BARS.STREAMS_HEARTBEAT
      add_table_rule_cb_capture(p_table_name => 'BARS.STREAMS_HEARTBEAT');
      -- правило для захвата BARS.SALDOA
      add_table_rule_cb_capture(p_table_name => 'BARS.SALDOA',
                                p_condition  => 'barsaq.ibank_accounts.is_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ACC'').AccessNumber()) = 1');
      -- правило для захвата BARS.OPLDOK
      add_table_rule_cb_capture(p_table_name => 'BARS.OPLDOK',
                                p_condition  => 'barsaq.ibank_accounts.is_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ACC'').AccessNumber()) = 1 ' ||
                                                'and (:dml.get_command_type()=''DELETE'' and :dml.get_value(''OLD'',''SOS'').AccessNumber()=5 or ' ||
                                                ':dml.get_value(''OLD'',''SOS'').AccessNumber()<>5 and :dml.get_value(''NEW'',''SOS'').AccessNumber()=5)');
      -- правило для захвата BARS.SOS_TRACK
      add_table_rule_cb_capture(p_table_name => 'BARS.SOS_TRACK',
                                p_condition  => 'barsaq.ibank_accounts.is_doc_imported(:dml.get_value(''NEW'',''REF'').AccessNumber()) = 1' || ' and :dml.get_command_type()=''INSERT''' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() is not null' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() <> :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber()' ||
                                                ' and :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber() in (-2,-1,5)');
      -- правило для захвата BARS.PARAMS$BASE
      add_table_rule_cb_capture(p_table_name => 'BARS.PARAMS$BASE', p_condition => ':dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''PAR'').AccessVarchar2()=''BANKDATE''');
      -- правило для захвата BARS.CUR_RATES$BASE
      add_table_rule_cb_capture(p_table_name => 'BARS.CUR_RATES$BASE',
                                p_condition  => ':dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''BRANCH'').AccessVarchar2() like ''/______/''');
      -- правило для захвата BARS.BRANCH
      add_table_rule_cb_capture(p_table_name => 'BARS.BRANCH',
                                p_condition  => ':dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''BRANCH'').AccessVarchar2() like ''/______/%''');
      -- правило для захвата BARS.BIRJA
      add_table_rule_cb_capture(p_table_name => 'BARS.BIRJA');
      -- правило для захвата BARS.CUST_ZAY
      add_table_rule_cb_capture(p_table_name => 'BARS.CUST_ZAY',
                                p_condition  => 'barsaq.ibank_accounts.is_cust_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber()) = 1 ');
      -- правило для захвата BARS.ZAY_COMISS
      add_table_rule_cb_capture(p_table_name => 'BARS.ZAY_COMISS',
                                p_condition  => 'barsaq.ibank_accounts.is_cust_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber()) = 1 ' ||
                                                              ' or :dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber() is null');
      -- правило для захвата BARS.CUSTOMER_ADDRESS
      add_table_rule_cb_capture(p_table_name => 'BARS.CUSTOMER_ADDRESS',
                                p_condition  => 'barsaq.ibank_accounts.is_cust_subscribed(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber()) = 1 ' ||
                                                              ' or :dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''RNK'').AccessNumber() is null');
      -- правило для захвата BARS.ZAY_TRACK
      add_table_rule_cb_capture(p_table_name => 'BARS.ZAY_TRACK',
                                p_condition  => 'barsaq.ibank_accounts.is_client_zayavka(:dml.get_value(''NEW'',''ID'').AccessNumber()) = 1' ||
                                                ' and :dml.get_command_type()=''INSERT''' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() is not null' ||
                                                ' and :dml.get_value(''NEW'',''OLD_SOS'').AccessNumber() <> :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber()' ||
                                                ' and :dml.get_value(''NEW'',''NEW_SOS'').AccessNumber() in (-1,2)');

      -- Устанавливаем захват значений для OPLDOK
      begin
         execute immediate 'alter table bars.opldok add supplemental log data (all) columns';
      exception
        when others then
          if sqlcode in (-32588) then
            null;
          else
            raise;
          end if;
      end;
      -------------------------------------* TR_CAPTURE *---------------------------------------------
      -- очередь tr_queue
      manage_queue(g_action_create, g_tr_queue, g_tr_queue_table);

      -- процесс tr_capture
      manage_capture(g_action_create, g_tr_capture, false, g_tr_queue);

      -- правило для захвата BARSAQ.STREAMS_HEARTBEAT
      add_table_rule_tr_capture('BARSAQ.STREAMS_HEARTBEAT');

      -- правило для захвата BARSAQ.BRANCHES
      add_table_rule_tr_capture('BARSAQ.BRANCHES');

      -- правило для захвата BARSAQ.BANKDATES
      add_table_rule_tr_capture('BARSAQ.BANKDATES');

      -- правило для захвата BARSAQ.CURRENCY_RATES
      add_table_rule_tr_capture('BARSAQ.CURRENCY_RATES');

      -- правило для захвата BARSAQ.DOC_EXPORT
      add_table_rule_tr_capture('BARSAQ.DOC_EXPORT', ' (:dml.get_value(''NEW'',''STATUS_ID'').AccessNumber() > 45 or :dml.get_value(''NEW'',''STATUS_ID'').AccessNumber() < 0) ');

      -- правило для захвата BARSAQ.ACC_TURNOVERS
      add_table_rule_tr_capture('BARSAQ.ACC_TURNOVERS');

      -- правило для захвата BARSAQ.ACC_TRANSACTIONS
      add_table_rule_tr_capture('BARSAQ.ACC_TRANSACTIONS');

      -- правило для захвата BARSAQ.DOC_CUREX_PARAMS
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_PARAMS');

      -- правило для захвата BARSAQ.DOC_CUREX_CUSTCOMMISSIONS
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_CUSTCOMMISSIONS');

      -- правило для захвата BARSAQ.DOC_CUREX_EXCLUSIVE
      add_table_rule_tr_capture('BARSAQ.DOC_CUREX_EXCLUSIVE');

      -- правило для захвата BARSAQ.CUST_ADDRESSES
      add_table_rule_tr_capture('BARSAQ.CUST_ADDRESSES');

      -- создаем TR_PROPAGATION
      manage_propogation(g_action_create);

      -- пересинхронизация таблиц
      resync_tables;

      -- запускаем задание SYNC_MONITOR_JOB
      manage_scheduler(g_action_enable, g_job_monitor);

      write_output(l_trace || ' пересоздание процессов - finish');
    end if;
  end recreate_streams_full;

  --------------------------------------------------------------------------------
  -- restart_tr_capture - полный перезапуск процесса TR_CAPTURE (учитывая удаленный перезапуск на базе IBANK)
  --
  procedure restart_tr_capture is
  begin
    dbms_capture_adm.stop_capture(g_tr_capture);
    manage_propogation(g_action_stop);
    execute immediate 'begin bank.restart_tr_process@' || get_dblink_name || '; end;';
    dbms_capture_adm.start_capture(g_tr_capture);
    manage_propogation(g_action_start);
  end;

  --------------------------------------------------------------------------------
  -- streams_status - состояние потоков
  --
  function streams_status return bars.varchar2_list
    pipelined is
  begin
    for c_captures in (select rpad(capture_name, 20) || rpad(status, 20) || error_message r_info from dba_capture where capture_name in (g_cb_capture, g_tr_capture)) loop
      pipe row('CAPTURE:: ' || c_captures.r_info);
    end loop;
    for c_apply in (select rpad(apply_name, 20) || rpad(status, 20) || error_message r_info from dba_apply where apply_name in (g_apply)) loop
      pipe row('APPLY  :: ' || c_apply.r_info);
    end loop;
    return;
  end;

  --------------------------------------------------------------------------------
  -- sync_status_docs - состояние синхронизации DOC_EXPORT
  --
  -- @p_days - к-во дней для анализа
  function sync_status_docs(p_days in integer default 1) return varchar2 is
    l_output varchar2(4000) := 'status_docs:';
    l_count  integer;
    l_mindat date;
  begin
    select count(*), min(insertion_date)
      into l_count, l_mindat
      from v_doc_statuses
     WHERE insertion_date >= TRUNC(SYSDATE - p_days)
       AND bars_status_id != ibank_status_id;
    if l_count > 0 then
      l_output := l_output || 'ERR: count=' || l_count || ', date=' || to_char(l_mindat, 'DD.MM.YYYY') || ')';
    else
      l_output := l_output || 'OK';
    end if;
    return l_output;
  end;


  ----
  -- extract_docs - получить список проблемных документов для выполнения синхронизации
  --
  procedure extract_docs(p_startdate in date, p_enddate in date, p_docs out t_sync_docs_list)
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
                         where i.insertion_date between :p_startdate and :p_enddate
                           and i.ref is not null -- только документы АБС
                           and e.doc_id=to_number(i.ext_ref) and i.ref=o.ref
                           and e.doc_id=vde.doc_id and o.ref=vde.bank_ref
                           and (e.status_id != vde.status_id or o.status != e.status_id)'
    bulk collect into p_docs
    using p_startdate, p_enddate;
  end extract_docs;

  --------------------------------------------------------------------------------
  -- alignment_statuses - принудительное выравнивание статусов DOC_EXPORT
  --
  -- @p_days - к-во дней начиная с которого
  procedure alignment_statuses(p_days in integer default 1) as
    l_docs          t_sync_docs_list;
    l_doc           t_sync_docs;
  begin
     extract_docs(sysdate - p_days, sysdate, l_docs);
     for i in 1..l_docs.count
     loop
         l_doc := l_docs(i);
         update doc_export set status_id=l_doc.status_id, bank_back_reason=l_doc.back_reason, status_change_time=l_doc.status_change_time where doc_id=l_doc.doc_id;
         execute immediate 'update ibank.v_doc_export set status_id=:status_id, bank_back_reason=:back_reason, status_change_time=:status_change_time where doc_id=:doc_id'
         using l_doc.status_id, l_doc.back_reason, l_doc.status_change_time, l_doc.doc_id;
     end loop;
     commit;
  end;

  --------------------------------------------------------------------------------
  -- alignment_statuses_by_interval - выравнивание статусов DOC_EXPORT за интервал дат
  --
  -- @p_start_date - дата начала
  -- @p_finish_date - дата начала
  procedure alignment_statuses_by_interval(p_start_date in date default trunc(sysdate-1), p_finish_date in date default trunc(sysdate)) as
    l_docs          t_sync_docs_list;
    l_doc           t_sync_docs;
  begin
     extract_docs(p_start_date, p_finish_date, l_docs);
     for i in 1..l_docs.count
     loop
         l_doc := l_docs(i);
         update doc_export set status_id=l_doc.status_id, bank_back_reason=l_doc.back_reason, status_change_time=l_doc.status_change_time where doc_id=l_doc.doc_id;
         execute immediate 'update ibank.v_doc_export set status_id=:status_id, bank_back_reason=:back_reason, status_change_time=:status_change_time where doc_id=:doc_id'
         using l_doc.status_id, l_doc.back_reason, l_doc.status_change_time, l_doc.doc_id;
     end loop;
     commit;
  end;

  --------------------------------------------------------------------------------
  -- sync_status_trans - состояние синхронизации ACC_TRANSACTIONS
  --
  -- @p_days - к-во дней для анализа
  function sync_status_trans(p_days in integer default 1) return varchar2 is
    l_trace  varchar2(4000) := g_trace || 'sync_status_trans(p_days => "' || p_days || '"): ';
    l_output varchar2(4000);
  begin
    write_output(l_trace || ' start');
    return l_output;
  end;

  --------------------------------------------------------------------------------
  -- sync_status_turns - состояние синхронизации ACC_TURNOVERS
  --
  -- @p_days - к-во дней для анализа
  function sync_status_turns(p_days in integer default 1) return varchar2 is
    l_trace  varchar2(4000) := g_trace || 'sync_status_turns(p_days => "' || p_days || '"): ';
    l_output varchar2(4000);
  begin
    write_output(l_trace || ' start');
    return l_output;
  end;

  --------------------------------------------------------------------------------
  -- restart_full_import_job - перезапуск Sched. Job-a FULL_IMPORT_JOB
  --
  procedure restart_full_import_job as
    l_trace varchar2(1000) := g_trace || 'restart_full_import_job: ';
  begin
    write_output(l_trace || ' start');
    manage_scheduler(g_action_stop, 'FULL_IMPORT_JOB', TRUE);
    manage_scheduler(g_action_disable, 'FULL_IMPORT_JOB', TRUE);
    for c in (select * from v$session where username='BARSAQ' and action='FULL_IMPORT_JOB')
    loop
      begin
        write_output(l_trace || ' kill session ' || c.sid || ',' || c.serial#);
        execute immediate 'ALTER SYSTEM KILL SESSION ''' || c.sid || ',' || c.serial# || ''' IMMEDIATE';
        dbms_lock.sleep(1);
      exception when others then null;
      end;
    end loop;
    manage_scheduler(g_action_enable, 'FULL_IMPORT_JOB', TRUE);
    write_output(l_trace || ' finish');
  end;

  --------------------------------------------------------------------------------
  -- enable_job_sync - включение режима синхронизации на джобах - не желательно
  --
  procedure enable_job_sync as
    l_trace varchar2(1000) := g_trace || 'enable_job_sync: ';
  begin
    write_output(l_trace || ' remove OPLDOK SALDOA rules');
    for c in (select rule_name,r.streams_name, decode(R.STREAMS_TYPE,1,'CAPTURE',3,'APPLY',null) streams_type from sys.STREAMS$_RULES r
              where streams_name like 'CB_%' and object_name in ('OPLDOK', 'SALDOA'))
    loop
       dbms_streams_adm.remove_rule(c.rule_name,c.streams_type,c.streams_name);
    end loop;

    write_output(l_trace || ' remove OPLDOK SALDOA apply dml handlers');
    for c in (select * from dba_apply_dml_handlers where apply_name='CB_APPLY' and object_name in ('ACC_TURNOVERS','ACC_TRANSACTIONS'))
    loop
      dbms_apply_adm.set_dml_handler(
        object_name          => c.object_owner||'.'||c.object_name,
        object_type          => 'TABLE',
        operation_name       => c.operation_name,
        error_handler        => case when c.error_handler='Y' then true else false end,
        user_procedure       => NULL,
        apply_name           => c.apply_name);
    end loop;
    manage_scheduler(g_action_drop, 'IBANK_SYNC_DOCUMENTS', TRUE);
    manage_scheduler(g_action_drop, 'IBANK_SYNC_DOCUMENTS_WEEK', TRUE);

    dbms_scheduler.create_job (
      job_name              => 'IBANK_SYNC_DOCUMENTS',
      job_type              => 'PLSQL_BLOCK',
      job_action            => 'begin barsaq.p_ibank_sync_documents; end;',
      number_of_arguments   => 0,
      start_date            => SYSDATE,
      repeat_interval       => 'FREQ=DAILY; BYHOUR=8,9,10,11,12,13,14,15,16,17,18,19,20,21; BYMINUTE=0,20,40',
      end_date              => NULL,
      job_class             => 'DEFAULT_JOB_CLASS',
      enabled               => TRUE,
      auto_drop             => TRUE,
      comments              => 'Завдання для затягування документів в інтернет банкінг');

    dbms_scheduler.create_job (
      job_name              => 'IBANK_SYNC_DOCUMENTS_WEEK',
      job_type              => 'PLSQL_BLOCK',
      job_action            => 'begin barsaq.p_ibank_sync_documents(5); end;',
      number_of_arguments   => 0,
      start_date            => SYSDATE,
      repeat_interval       => 'FREQ=DAILY; BYHOUR=5,6,7; BYMINUTE=0',
      end_date              => NULL,
      job_class             => 'DEFAULT_JOB_CLASS',
      enabled               => TRUE,
      auto_drop             => TRUE,
      comments              => 'Завдання для затягування документів в інтернет банкінг');

    write_output(l_trace || ' jobs created');
  end;

end ibank_mgr;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/ibank_mgr.sql =========*** End ***
 PROMPT ===================================================================================== 
 