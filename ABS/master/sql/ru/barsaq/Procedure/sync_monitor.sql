

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/SYNC_MONITOR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SYNC_MONITOR ***

  CREATE OR REPLACE PROCEDURE BARSAQ.SYNC_MONITOR 
    --
    -- Монитор модуля синхронизации с corp2
    -- отслеживает состояние потоков(streams) и заданий
    -- при изменении состояния отсылает уведомление по почте
    --
is
    C_CB_CAPTURE    constant varchar2(30)  := 'CB_CAPTURE';
    C_CB_APPLY      constant varchar2(30)  := 'CB_APPLY';
    C_JOB_IMPORT    constant varchar2(30)  := 'JOB_IMPORT';
    C_JOB_WHAT      constant varchar2(128) := 'data_import.full_import;';
    C_JOB_NAME      constant varchar2(30)  := 'FULL_IMPORT_JOB';
    C_JOB_BROKEN    constant varchar2(30)  := 'BROKEN';
    --
    C_SUBJECT       constant varchar2(128) := 'Модуль синхронізації АБС БАРС з corp2 потребує уваги';
    --
    C_STATUS_ABORTED  constant varchar2(30) := 'ABORTED';
    C_STATUS_ENABLED  constant varchar2(30) := 'ENABLED';
    C_STATUS_DISABLED constant varchar2(30) := 'DISABLED';
    --
    C_STREAM_TYPE_CAPTURE     constant varchar2(30) := 'CAPTURE';
    C_STREAM_TYPE_APPLY       constant varchar2(30) := 'APPLY';
    C_STREAM_TYPE_PROPAGATION constant varchar2(30) := 'PROPAGATION';
    --
    l_capture      dba_capture%rowtype;
    l_apply        dba_apply%rowtype;
    l_job          user_scheduler_jobs%rowtype;
    l_old_status   streams_statuses%rowtype;
    l_exists       boolean;
    l_old_saved    boolean;
    l_syncadm      bars.params.val%type;
    l_msgid        raw(16);
    l_body         clob;
    l_clob_created boolean := false;
    l_msg          varchar2(32767);
    l_errors       clob;
    l_import_activity  import_activity%rowtype;
    l_job_status   varchar2(30);
    l_user_error_number number;
    l_user_error_message varchar2(4000);
    l_last_date     date;
    --
    ----
    -- restore_capture - восстановление процесса CB_CAPTURE
    --
    procedure restore_capture
    is
        l_label constant varchar2(30) := 'SYNC_MONITOR';
        l_status            streams_statuses%rowtype;
        l_behavior          streams_error_behavior%rowtype;
        l_mindate           date := to_date('01.01.1970','DD.MM.YYYY');
        l_interval          number;
        l_errcode           number;
        l_enabled_period    number;
        l_greatest_time     date;
    begin
        -- читаем текущий статус потока
        begin
            select *
              into l_status
              from streams_statuses
             where streams_name = C_CB_CAPTURE;
        exception when no_data_found then
            return;
        end;
        -- читаем параметры поведения при ошибках (пока общие для всех)
        select *
          into l_behavior
          from streams_error_behavior
         where stream_type = C_STREAM_TYPE_CAPTURE
           and error_number = -1
           and user_error_number = -1;
        -- вычисляем интервал восстановления в минутах по выражению
        execute immediate 'select ('||l_behavior.retry_interval||')/24/60 from streams_statuses '
            ||'where streams_name='''||C_CB_CAPTURE||'''' into l_interval;
        l_enabled_period := l_behavior.enabled_period/24/60;
        -- обрабатываем только аварийные ситуации
        if l_status.status != C_STATUS_ABORTED
        then
            return;
        end if;
        --
        l_status.retry_time := nvl(l_status.retry_time, l_mindate);
        l_greatest_time := greatest(
            l_status.status_change_time,
            l_status.retry_time,
            nvl(l_status.monitor_error_time, l_mindate)
        );
        -- обнуляем кол-во попыток восстановления если последнее ENABLED-состояние было достаточно давно(>=l_enabled_period)
        if  sysdate - l_greatest_time >= l_enabled_period
        then
            l_status.retry_num := 0;
        end if;
        -- нужно возобновить работу ?
        if l_status.error_number is not null
        and l_status.retry_num < l_behavior.retry_count
        and (sysdate - l_status.retry_time) >= l_interval
        then
            begin
                dbms_capture_adm.start_capture(C_CB_CAPTURE);
                --
                update streams_statuses
                   set retry_num = l_status.retry_num + 1,
                       retry_time = sysdate
                 where streams_name = C_CB_CAPTURE;
                --
                logger.info(l_label||': Стартован поток '||C_CB_CAPTURE||' после ошибки: '||l_status.error_message);
                --
            exception when others then
                l_errcode := SQLCODE;
                update streams_statuses
                   set retry_num = l_status.retry_num + 1,
                       retry_time = sysdate,
                       monitor_error_number = l_errcode,
                       monitor_error_message = substr(dbms_utility.format_error_stack(), 1, 4000),
                       monitor_error_time = sysdate
                 where streams_name = C_CB_CAPTURE;
                --
                logger.error(l_label||': Неудачная попытка стартовать поток '||C_CB_CAPTURE||' после ошибки: '||l_status.error_message
                ||chr(10)||'Ошибка при выполнении процедуры старта: '||dbms_utility.format_error_stack());
                --
            end;
        end if;
        --
        commit;
        --
    end restore_capture;

    ----
    -- restore_apply - восстановление процесса CB_APPLY
    --
    procedure restore_apply
    is
        l_label constant varchar2(30) := 'SYNC_MONITOR';
        l_status            streams_statuses%rowtype;
        l_behavior          streams_error_behavior%rowtype;
        l_mindate           date := to_date('01.01.1970','DD.MM.YYYY');
        l_interval          number;
        l_errcode           number;
        l_enabled_period    number;
        l_greatest_time     date;
    begin
        -- читаем текущий статус потока
        begin
            select *
              into l_status
              from streams_statuses
             where streams_name = C_CB_APPLY;
        exception when no_data_found then
            return;
        end;
        -- читаем параметры поведения при ошибках (пока общие для всех)
        select *
          into l_behavior
          from streams_error_behavior
         where stream_type = C_STREAM_TYPE_APPLY
           and error_number = -1
           and user_error_number = -1;
        -- вычисляем интервал восстановления в минутах по выражению
        execute immediate 'select ('||l_behavior.retry_interval||')/24/60 from streams_statuses '
            ||'where streams_name='''||C_CB_APPLY||'''' into l_interval;
        l_enabled_period := l_behavior.enabled_period/24/60;
        -- обрабатываем только аварийные ситуации
        if l_status.status != C_STATUS_ABORTED
        then
            return;
        end if;
        --
        l_status.retry_time := nvl(l_status.retry_time, l_mindate);
        l_greatest_time := greatest(
            l_status.status_change_time,
            l_status.retry_time,
            nvl(l_status.monitor_error_time, l_mindate)
        );
        -- обнуляем кол-во попыток восстановления если последнее ENABLED-состояние было достаточно давно(>=l_enabled_period)
        if  sysdate - l_greatest_time >= l_enabled_period
        then
            l_status.retry_num := 0;
        end if;
        -- нужно возобновить работу ?
        if l_status.error_number is not null
        and l_status.retry_num < l_behavior.retry_count
        and (sysdate - l_status.retry_time) >= l_interval
        then
            -- цикл для выхода после неудачного выполнения пользовательских ошибок
            loop
                if l_status.user_error_number is not null
                then
                    -- пытаемся выполнить пользовательские ошибки
                    begin
                        dbms_apply_adm.execute_all_errors(C_CB_APPLY);
                        --
                        logger.info(l_label||': Выполены пользовательские ошибки процесса '||C_CB_APPLY
                            ||'. Текст первой ошибки: '||l_status.user_error_message);
                        --
                    exception when others then
                        l_errcode := SQLCODE;
                        update streams_statuses
                           set retry_num = l_status.retry_num + 1,
                               retry_time = sysdate,
                               monitor_error_number = l_errcode,
                               monitor_error_message = substr(dbms_utility.format_error_stack(), 1, 4000),
                               monitor_error_time = sysdate
                         where streams_name = C_CB_APPLY;
                        --
                        logger.error(l_label||': Неудачное выполнение пользовательских ошибок процесса '||C_CB_APPLY
                            ||': '||dbms_utility.format_error_stack()||chr(10)||'Текст первой ошибки: '
                            ||l_status.user_error_message
                        );
                        -- смысла стартовать процесс при наличии ошибок нет, выходим
                        exit;
                    end;
                end if;
                --
                begin
                    dbms_apply_adm.start_apply(C_CB_APPLY);
                    --
                    update streams_statuses
                       set retry_num = l_status.retry_num + 1,
                           retry_time = sysdate
                     where streams_name = C_CB_APPLY;
                    --
                    logger.info(l_label||': Стартован поток '||C_CB_APPLY||' после ошибки: '||l_status.error_message);
                    --
                exception when others then
                    l_errcode := SQLCODE;
                    update streams_statuses
                       set retry_num = l_status.retry_num + 1,
                           retry_time = sysdate,
                           monitor_error_number = l_errcode,
                           monitor_error_message = substr(dbms_utility.format_error_stack(), 1, 4000),
                           monitor_error_time = sysdate
                     where streams_name = C_CB_APPLY;
                    --
                    logger.error(l_label||': Неудачная попытка стартовать поток '||C_CB_APPLY||' после ошибки: '||l_status.error_message
                    ||chr(10)||'Ошибка при выполнении процедуры старта: '||dbms_utility.format_error_stack());
                    --
                end;
                --
                exit;
                --
            end loop;
            --
        end if;
        --
        commit;
        --
    end restore_apply;
    --
begin
    -- читаем параметр с перечнем адресов админов модуля синхронизации
    begin
        select val
          into l_syncadm
          from bars.params
         where par='SYNCADM';
    exception
        when no_data_found then
            raise_application_error(-20000, 'Не задано параметр SYNCADM');
    end;
    --
    dbms_lob.createtemporary(l_body, true, dbms_lob.call);
    l_clob_created := true;
    --
    -- CAPTURE
    --
    l_exists := false;
    begin
        select *
          into l_capture
          from dba_capture
         where capture_name = C_CB_CAPTURE;
        --
        l_exists := true;
    exception
        when no_data_found then
            delete
              from streams_statuses
             where streams_name = C_CB_CAPTURE;
            -- prepare message
            l_msg := 'Поток '||C_CB_CAPTURE||' не існує.'||chr(10);
            dbms_lob.writeappend(l_body, length(l_msg), l_msg);
    end;
    if l_exists
    then
        begin
            select *
              into l_old_status
              from streams_statuses
             where streams_name = C_CB_CAPTURE;
            l_old_saved := true;
            update streams_statuses
               set scan_time = sysdate,
                   status = l_capture.status,
                   status_change_time = l_capture.status_change_time,
                   last_enabled_time = decode(l_capture.status, C_STATUS_ENABLED, l_capture.status_change_time, last_enabled_time),
                   error_number = nvl(l_capture.error_number, error_number),
                   error_message = nvl(l_capture.error_message, error_message),
                   error_time = decode(l_capture.error_number, null, error_time, l_capture.status_change_time)
             where streams_name = C_CB_CAPTURE;
        exception
            when no_data_found then
                l_old_saved := false;
                insert
                  into streams_statuses (scan_time, streams_name, status, status_change_time, last_enabled_time,
                        error_number, error_message, error_time)
                values (sysdate, C_CB_CAPTURE, l_capture.status, l_capture.status_change_time,
                        decode(l_capture.status, C_STATUS_ENABLED, l_capture.status_change_time, null),
                        l_capture.error_number, l_capture.error_message,
                        decode(l_capture.error_number, null, null, l_capture.status_change_time)
                       );
        end;
        if l_capture.status=C_STATUS_ABORTED and not l_old_saved
        or l_capture.status=C_STATUS_ABORTED and l_old_saved and
           (l_old_status.status<>C_STATUS_ABORTED or
            l_old_status.status=C_STATUS_ABORTED and l_capture.status_change_time<>l_old_status.status_change_time)
        then
            l_msg := 'Поток '||C_CB_CAPTURE||' аварійно зупинився (STATUS=ABORTED).'
                   ||' Час зупинки '||to_char(l_capture.status_change_time, 'DD.MM.YYYY HH24:MI:SS')||'.'||chr(10)
                   ||'Опис помилки: '||l_capture.error_message||chr(10);
            dbms_lob.writeappend(l_body, length(l_msg), l_msg);
        end if;
    end if;
    --
    -- APPLY
    --
    l_exists := false;
    begin
        select *
          into l_apply
          from dba_apply
         where apply_name = C_CB_APPLY;
        --
        l_exists := true;
    exception
        when no_data_found then
            delete
              from streams_statuses
             where streams_name = C_CB_APPLY;
            l_msg := 'Поток '||C_CB_APPLY||' не існує.'||chr(10);
            dbms_lob.writeappend(l_body, length(l_msg), l_msg);
    end;
    if l_exists
    then
        -- определяем наличие пользовательских ошибок
		begin
            select error_number, error_message
              into l_user_error_number, l_user_error_message
              from (select *
                      from dba_apply_error
                     where apply_name = C_CB_APPLY
                     order by error_creation_time)
             where rownum = 1;
        exception
            when no_data_found then
                l_user_error_number  := null;
                l_user_error_message := null;
        end;
        --
        begin
            select *
              into l_old_status
              from streams_statuses
             where streams_name = C_CB_APPLY;
            l_old_saved := true;
            update streams_statuses
               set scan_time = sysdate,
                   status = l_apply.status,
                   status_change_time = l_apply.status_change_time,
                   last_enabled_time = decode(l_apply.status, C_STATUS_ENABLED, l_apply.status_change_time, last_enabled_time),
                   error_number = nvl(l_apply.error_number, error_number),
                   error_message = nvl(l_apply.error_message, error_message),
                   error_time = decode(l_apply.error_number, null, error_time, l_apply.status_change_time),
                   user_error_number = l_user_error_number,
                   user_error_message = l_user_error_message
             where streams_name = C_CB_APPLY;
        exception
            when no_data_found then
                l_old_saved := false;
                insert
                  into streams_statuses (scan_time, streams_name, status, status_change_time, last_enabled_time,
                    error_number, error_message, error_time, user_error_number, user_error_message)
                values (sysdate, C_CB_APPLY, l_apply.status, l_apply.status_change_time,
                    decode(l_apply.status, C_STATUS_ENABLED, l_apply.status_change_time, null),
                    l_apply.error_number, l_apply.error_message,
                    decode(l_apply.error_number, null, null, l_apply.status_change_time),
                    l_user_error_number, l_user_error_message
                    );
        end;
        if l_apply.status=C_STATUS_ABORTED and not l_old_saved
        or l_apply.status=C_STATUS_ABORTED and l_old_saved and
           (l_old_status.status<>C_STATUS_ABORTED or
            l_old_status.status=C_STATUS_ABORTED and l_apply.status_change_time<>l_old_status.status_change_time)
        then
            l_msg := 'Поток '||C_CB_APPLY||' аварійно зупинився (STATUS=ABORTED).'
                   ||' Час зупинки '||to_char(l_apply.status_change_time, 'DD.MM.YYYY HH24:MI:SS')||'.'||chr(10)
                   ||'Опис помилки: '||l_apply.error_message||chr(10);
            dbms_lob.writeappend(l_body, length(l_msg), l_msg);
            l_errors := retrieve_apply_errors();
            if dbms_lob.getlength(l_errors)>0
            then
                l_msg := chr(10);
                dbms_lob.writeappend(l_body, length(l_msg), l_msg);
                dbms_lob.append(l_body, l_errors);
                if dbms_lob.istemporary(l_errors)=1
                then
                    dbms_lob.freetemporary(l_errors);
                end if;
            end if;
        end if;
    end if;
    --
    -- JOB_IMPORT
    --
    l_exists := false;
    begin
        select *
          into l_job
          from user_scheduler_jobs
         where job_name = C_JOB_NAME;
        --
        l_exists := true;
        l_job_status := l_job.state;
        l_last_date := l_job.last_start_date;
    exception
        when no_data_found then
            delete
              from streams_statuses
             where streams_name = C_JOB_IMPORT;
            l_msg := 'Завдання(JOB) '||C_JOB_IMPORT||' не існує.'||chr(10);
            dbms_lob.writeappend(l_body, length(l_msg), l_msg);
    end;
    if l_exists
    then
        begin
            select *
              into l_old_status
              from streams_statuses
             where streams_name = C_JOB_IMPORT;
            l_old_saved := true;
            update streams_statuses
               set scan_time = sysdate,
                   status = l_job_status,
                   status_change_time = l_last_date
             where streams_name = C_JOB_IMPORT;
        exception
            when no_data_found then
                l_old_saved := false;
                insert
                  into streams_statuses (scan_time, streams_name, status, status_change_time)
                values (sysdate, C_JOB_IMPORT, l_job_status, l_last_date);
        end;
        if l_job_status=C_JOB_BROKEN and not l_old_saved
        or l_job_status=C_JOB_BROKEN and l_old_saved and
           (l_old_status.status<>C_JOB_BROKEN or
            l_old_status.status=C_JOB_BROKEN and l_last_date<>l_old_status.status_change_time)
        then
            l_msg := 'Завдання(JOB) '||C_JOB_IMPORT||' аварійно зупинено (STATUS=BROKEN).'
                   ||' Час зупинки '||to_char(l_last_date, 'DD.MM.YYYY HH24:MI:SS')||'.'||chr(10);
            dbms_lob.writeappend(l_body, length(l_msg), l_msg);
            -- читаем последнюю ошибку
            select additional_info
              into l_msg
              from user_scheduler_job_run_details
             where job_name='FULL_IMPORT_JOB'
               and log_id = (select max(log_id)
                               from user_scheduler_job_log
                              where job_name='FULL_IMPORT_JOB'
                                and operation='RUN'
                                and status='FAILED'
                            );
            dbms_lob.writeappend(l_body, length(l_msg), l_msg);
        end if;
    end if;
    --
    if dbms_lob.getlength(l_body)>0
    then
        -- помещаем сообщение в очередь
        bars.bars_mail.put_msg2queue2(
            p_name     => l_syncadm,
            p_addr     => l_syncadm,
            p_subject  => C_SUBJECT,
            p_body     => l_body,
            p_msgid    => l_msgid
        );
    end if;
    --
    commit;
    --
    dbms_lob.freetemporary(l_body);
    l_clob_created := false;
    --
    restore_capture;
    --
    restore_apply;
    --
exception
    when others then
        if l_clob_created
        then
            dbms_lob.freetemporary(l_body);
            l_clob_created := false;
        end if;
        raise_application_error(-20000, dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace());
end sync_monitor;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/SYNC_MONITOR.sql =========*** En
PROMPT ===================================================================================== 
