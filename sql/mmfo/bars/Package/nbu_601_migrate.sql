create or replace package nbu_601_migrate as

    REQ_STATE_NEW                  constant integer := 1;
    REQ_STATE_WAITING_FOR_DATA     constant integer := 2;
    REQ_STATE_GATHERING_DATA       constant integer := 3;
    REQ_STATE_GATHERING_DATA_FAIL  constant integer := 4;
    REQ_STATE_TRANSFERRING_DATA    constant integer := 5;
    REQ_STATE_TRANSFER_DATA_FAIL   constant integer := 6;
    REQ_STATE_DATA_DELIVERED       constant integer := 7;
    REQ_STATE_START_FAIL           constant integer := 8;

  procedure run_data_request(
        p_request_id in integer);

  procedure run_all_data_requests(
        p_report_id in integer,
        p_kf varchar2);

  procedure handle_data_request(
        p_request_id in integer);

  function read_branch(
        p_kf in varchar2,
        p_raise_ndf in boolean default true)
        return nbu_branch_601%rowtype;

  procedure create_data_request(
        P_KF in varchar2);

  procedure set_data_request_state(
        p_request_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2);

end;
/
create or replace package body nbu_601_migrate  as

    SCHEDULER_PROGRAM_NAME constant varchar2(30 char) := 'NBU_601_SCHEDULER';

function read_branch(
        p_kf in varchar2,
        p_raise_ndf in boolean default true)
    return nbu_branch_601%rowtype
    is
        l_branch_row nbu_branch_601%rowtype;
    begin
        select *
        into   l_branch_row
        from   NBU_BRANCH_601 t
        where  t.kf = p_kf;

        return l_branch_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Налаштування для взаємодії з регіоном АБС {' || p_kf || '} не знайдені');
             else return null;
             end if;
end;

function read_data_request_type(
        p_data_type_id in integer,
        p_raise_ndf in boolean default true)
    return nbu_data_type_601%rowtype
    is
        l_data_type_row nbu_data_type_601%rowtype;
    begin
        select *
        into   l_data_type_row
        from   nbu_data_type_601 t
        where  t.id = p_data_type_id;

        return l_data_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Тип даних з ідентифікатором {' || p_data_type_id || '} не знайдений');
             else return null;
             end if;
end;

function read_data_request_type(
        p_data_type_code in varchar2,
        p_raise_ndf in boolean default true)
    return nbu_data_type_601%rowtype
    is
        l_data_type_row nbu_data_type_601%rowtype;
    begin
        select *
        into   l_data_type_row
        from   nbu_data_type_601 t
        where  t.data_type_code = p_data_type_code;

        return l_data_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Тип даних з кодом {' || p_data_type_code || '} не знайдений');
             else return null;
             end if;
end;



function read_data_request(
        p_request_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return nbu_data_request_601%rowtype
    is
        l_request_row nbu_data_request_601%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_request_row
            from   nbu_data_request_601 t
            where  t.id = p_request_id
            for update;
        else
            select *
            into   l_request_row
            from   nbu_data_request_601 t
            where  t.id = p_request_id;
        end if;

        return l_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит даних АБС з ідентифікатором {' || p_request_id || '} не знайдений');
             else return null;
             end if;
end;

function get_request_type_name(
        p_data_type_id in integer)
    return varchar2
    is
    begin
        return read_data_request_type(p_data_type_id, p_raise_ndf => false).data_type_name;
    end;

    function get_request_type_name(
        p_data_type_code in varchar2)
    return varchar2
    is
    begin
        return read_data_request_type(p_data_type_code, p_raise_ndf => false).data_type_name;
end;



function read_data_request(
        p_report_id in integer,
        p_data_type_id in integer,
        p_kf in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return nbu_data_request_601%rowtype
    is
        l_request_row nbu_data_request_601%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_request_row
            from   nbu_data_request_601 t
            where  t.report_instance_id = p_report_id and
                   t.data_type_id = p_data_type_id and
                   t.kf = p_kf
            for update;
        else
            select *
            into   l_request_row
            from   nbu_data_request_601 t
            where  t.report_instance_id = p_report_id and
                   t.data_type_id = p_data_type_id and
                   t.kf = p_kf;
        end if;

        return l_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Запит на отримання даних типу {' || get_request_type_name(p_data_type_id) ||
                                                 '} для філії {' || p_kf ||
                                                 '} для звіту з ідентифікатором {' || p_report_id || '} не знайдений');
             else return null;
             end if;
end;


procedure ensure_wrapper_program(
        p_action              in varchar2,
        p_description         in varchar2)
    is
        l_prog_number_of_arguments integer default 0;
        l_program_availability varchar2(30 char);
    begin
        /*bars.bars_audit.log_info('bars',
                                 sys_context('userenv', 'session_user'),
                                 p_make_context_snapshot => true);*/
        begin
            select t.number_of_arguments, t.enabled
            into   l_prog_number_of_arguments, l_program_availability
            from   user_scheduler_programs t
            where  t.program_name = SCHEDULER_PROGRAM_NAME;

            if (l_prog_number_of_arguments <> 1) then
                if (l_program_availability = 'TRUE') then
                    dbms_scheduler.disable(name => SCHEDULER_PROGRAM_NAME, force => true);
                    l_program_availability := 'FALSE';
                end if;

                sys.dbms_scheduler.set_attribute(name => SCHEDULER_PROGRAM_NAME,
                                                 attribute => 'number_of_arguments',
                                                 value => 1);
            end if;
        exception
            when no_data_found then
                 dbms_scheduler.create_program(program_name        => 'BARS.' || SCHEDULER_PROGRAM_NAME,
                                               program_type        => 'STORED_PROCEDURE',
                                               program_action      => p_action,
                                               number_of_arguments => 1,
                                               enabled             => false,
                                               comments            => p_description);
                 l_program_availability := 'FALSE';
        end;

        dbms_scheduler.define_program_argument(program_name      => SCHEDULER_PROGRAM_NAME,
                                               argument_position => 1,
                                               argument_name     => 'p_request_id',
                                               argument_type     => 'number');

        if (l_program_availability = 'FALSE') then
            sys.dbms_scheduler.enable(name => SCHEDULER_PROGRAM_NAME);
        end if;
end;

procedure ensure_wrapper_job(
        p_job_name in varchar2,
        p_description in varchar2)
    is
        l_job_existance_flag integer;
    begin
        begin
            select 1
            into   l_job_existance_flag
            from   user_scheduler_jobs t
            where  t.job_name = p_job_name;
        exception
            when no_data_found then
                 dbms_scheduler.create_job(job_name     => p_job_name,
                                           program_name => SCHEDULER_PROGRAM_NAME,
                                           auto_drop    => false,
                                           comments     => p_description,
                                           enabled      => false);
        end;
/*
        dbms_scheduler.set_attribute(name      => p_job_name,
                                     attribute => 'RAISE_EVENTS',
                                     value     => \*dbms_scheduler.JOB_SUCCEEDED + *\dbms_scheduler.JOB_FAILED + dbms_scheduler.JOB_STOPPED);
*/
end;

procedure track_data_request(
        p_request_id in integer,
        p_state_id in integer,
        p_tracking_message in varchar2)
    is
    begin
        insert into nbu_data_request_tracking_601
        values (p_request_id, sysdate, p_state_id, substrb(p_tracking_message, 1, 4000));
end;

procedure set_data_request_state(
        p_request_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2)
    is
    begin
        update nbu_data_request_601 t
        set    t.state_id = p_state_id
        where  t.id = p_request_id;

        track_data_request(p_request_id, p_state_id, p_tracking_comment);
end;


function generate_job_name(
        p_kf in varchar2,
        p_data_type_code in varchar2)
    return varchar2
    is
    begin
        return 'NBU601_' || p_kf || '_' || substr(p_data_type_code, 1, 16);
    end;

     function get_request_type_code(
        p_data_type_id in integer)
    return varchar2
    is
    begin
        return read_data_request_type(p_data_type_id, p_raise_ndf => false).data_type_code;
end;

procedure run_data_request(
        p_request_id in integer)
    is
        pragma autonomous_transaction;
        l_request_row nbu_data_request_601%rowtype;
        l_job_name varchar2(30 char);
       -- l_request_mode varchar2(32767 byte);
        job_is_runing exception;
        pragma exception_init(job_is_runing, -27478);
    begin
        l_request_row := read_data_request(p_request_id, p_lock => true);

        -- слід пам'ятати, що звернення до dbms_scheduler фіксує транзакцію
        -- (це означає, що використати savepoint в даному випадку не вдасться, тому вся процедура повністю виконується в атономній транзакції,
        -- для того щоб поведінка процедури була прогнозованою і повністю охоплювала весь процес обробки одного запиту даних)

        ensure_wrapper_program('nbu_601_migrate.handle_data_request',
                               'Запуск сбора данных для 601 отчета');

        l_job_name := generate_job_name(l_request_row.kf, get_request_type_code(l_request_row.data_type_id));
        ensure_wrapper_job(l_job_name, 'Джоб для обробки запитів на отримання даних для формування 601-ї форми з філії {' || l_request_row.kf ||
                                           '} по типу даних {' || get_request_type_name(l_request_row.data_type_id) || '}');

        dbms_scheduler.set_job_argument_value(job_name       => l_job_name,
                                              argument_name  => 'p_request_id',
                                              argument_value => l_request_row.id);
        set_data_request_state(l_request_row.id, nbu_601_migrate.REQ_STATE_WAITING_FOR_DATA, 'Очікує на отримання даних з філії');

        -- не виключений подвійний запуск джоба, якщо два користувачі одночасно запустять повторне отримання даних з РУ - другий виклик ігнорується
        begin
            dbms_scheduler.run_job(job_name => l_job_name, use_current_session => false);
        exception
            when job_is_runing then
                 null;
        end;

        commit;
    exception
        when others then
             rollback;
            /* bars_audit.log_error('nbu_601_migrate.run_data_request',
                                  sqlerrm || dbms_utility.format_error_backtrace(),
                                  p_object_id => p_request_id,
                                  p_make_context_snapshot => true);*/
             if (p_request_id is not null) then
                 set_data_request_state(p_request_id, nbu_601_migrate.REQ_STATE_START_FAIL, sqlerrm || dbms_utility.format_error_backtrace());
                 commit;
             else raise;
             end if;
end;

procedure run_all_data_requests(
        p_report_id in integer,
        P_KF in varchar2)
    is
    l_request_id_w4_bpk int;
    l_request_id_person_fo int;
    l_request_id_document_fo int;
    l_request_id_address_fo int;
    l_request_id_person_uo int;
    l_request_id_fin_uo int;
    l_request_id_fingr_uo int;
    begin
     begin
     bars.nbu_601_request_data_ru.p_nbu_w4_bpk(P_KF);
       select id into l_request_id_w4_bpk from nbu_data_request_601 t where  t.report_instance_id= (select max(report_instance_id) from nbu_data_request_601 where data_type_id=19 and kf=p_kf) and
           data_type_id=19 and kf=p_kf;
         set_data_request_state(l_request_id_w4_bpk,nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
         commit;
         exception
         when others then
         set_data_request_state(l_request_id_w4_bpk,10,sqlerrm ||' '||dbms_utility.format_error_backtrace());
         commit;
      end;
      ---
      begin
      bars.nbu_601_request_data_ru.p_nbu_person_fo(P_KF);
       select id into l_request_id_person_fo from nbu_data_request_601 t where  t.report_instance_id= (select max(report_instance_id) from nbu_data_request_601 where data_type_id=1 and kf=p_kf) and
           data_type_id=1 and kf=p_kf;
             set_data_request_state(l_request_id_person_fo,nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
             commit;
             exception
             when others then
             set_data_request_state(l_request_id_person_fo,10,sqlerrm ||' '||dbms_utility.format_error_backtrace());
             commit;
      end;
      ---
      begin
      bars.nbu_601_request_data_ru.p_nbu_document_fo(P_KF);
        select id into l_request_id_document_fo from nbu_data_request_601 t where  t.report_instance_id= (select max(report_instance_id) from nbu_data_request_601 where data_type_id=2 and kf=p_kf) and
           data_type_id=2 and kf=p_kf;
            set_data_request_state(l_request_id_document_fo,nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
            commit;
             exception
             when others then
             set_data_request_state(l_request_id_document_fo,10,sqlerrm ||' '||dbms_utility.format_error_backtrace());
             commit;
      end;
      ---
      begin
      bars.nbu_601_request_data_ru.p_nbu_address_fo(P_KF);
         select id into l_request_id_address_fo from nbu_data_request_601 t where  t.report_instance_id= (select max(report_instance_id) from nbu_data_request_601 where data_type_id=3 and kf=p_kf) and
           data_type_id=3 and kf=p_kf;
           set_data_request_state(l_request_id_address_fo,nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
           commit;
            exception
            when others then
            set_data_request_state(l_request_id_address_fo,10,sqlerrm ||' '||dbms_utility.format_error_backtrace());
            commit;
      end;
      ----
      begin
      bars.nbu_601_request_data_ru.p_nbu_person_uo(P_KF);
       select id into l_request_id_person_uo from nbu_data_request_601 t where  t.report_instance_id= (select max(report_instance_id) from nbu_data_request_601 where data_type_id=7 and kf=p_kf) and
           data_type_id=7 and kf=p_kf;
           set_data_request_state(l_request_id_person_uo,nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
           commit;
            exception
            when others then
            set_data_request_state(l_request_id_person_uo,10,sqlerrm ||' '||dbms_utility.format_error_backtrace());
            commit;
      end;
      --
      begin
      bars.nbu_601_request_data_ru.p_nbu_finperformance_uo(P_KF);
      select id
      into   l_request_id_fin_uo
      from   nbu_data_request_601 t
      where  t.report_instance_id= (select max(report_instance_id)from nbu_data_request_601 where data_type_id=8 and kf=p_kf) and data_type_id=8 and kf=p_kf;
             set_data_request_state( l_request_id_fin_uo,nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
           commit;
           exception
             when others then
              set_data_request_state( l_request_id_fin_uo,10,sqlerrm ||' '|| dbms_utility.format_error_backtrace());
              commit;
      end;
      --
      begin
      bars.nbu_601_request_data_ru.p_nbu_finperformancegr_uo(P_KF);
      select id
      into   l_request_id_fingr_uo
      from   nbu_data_request_601 t
      where  t.report_instance_id= (select max(report_instance_id)from nbu_data_request_601 where data_type_id=10 and kf=p_kf) and data_type_id=10 and kf=p_kf;
             set_data_request_state(l_request_id_fingr_uo,nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
           commit;
           exception
             when others then
              set_data_request_state(l_request_id_fingr_uo,10,sqlerrm ||' '|| dbms_utility.format_error_backtrace());
              commit;
      end;

 for i in (select * from nbu_data_request_601 t
                  where  t.report_instance_id = p_report_id and
                         t.state_id = nbu_601_migrate.REQ_STATE_NEW and
                         t.kf=p_kf  and
                         t.id not in (l_request_id_w4_bpk,l_request_id_person_fo,l_request_id_document_fo,l_request_id_address_fo,l_request_id_person_uo,l_request_id_fingr_uo, l_request_id_fin_uo)
                         ) loop
            run_data_request(i.id);
        end loop;
      commit;
end;

procedure handle_data_request(
        p_request_id in integer)
    is
        l_data_type_row nbu_data_type_601%rowtype;
        l_request_row nbu_data_request_601%rowtype;
    begin
       /* bars.bars_audit.log_info('nbu_601_migrate.handle_data_request',
                                 'p_request_id : ' || p_request_id);*/

        l_request_row := read_data_request(p_request_id, p_lock => true);

        if (l_request_row.state_id in (nbu_601_migrate.REQ_STATE_GATHERING_DATA, nbu_601_migrate.REQ_STATE_TRANSFERRING_DATA)) then
            return;
        end if;

        l_data_type_row := read_data_request_type(l_request_row.data_type_id);

        if (l_data_type_row.gathering_block is not null or l_data_type_row.transfering_block is not null) then
            bars.bars_login.login_user(sys_guid(), 1, null, 'NBU_601');
            bars.bars_context.go(l_request_row.kf);
        end if;

        if (l_data_type_row.gathering_block is not null) then
            set_data_request_state(l_request_row.id, nbu_601_migrate.REQ_STATE_GATHERING_DATA, '');

            commit;

            begin
                execute immediate l_data_type_row.gathering_block
                using l_request_row.id, l_request_row.kf;
            exception
                when others then
                     rollback;
                     set_data_request_state(l_request_row.id,
                                            nbu_601_migrate.REQ_STATE_GATHERING_DATA_FAIL,
                                            sqlerrm || dbms_utility.format_error_backtrace());
                     -- якщо виникла помилка при підготовці даних - перериваємо виконання процедури
                     return;
            end;
        end if;

        if (l_data_type_row.transfering_block is not null) then
            set_data_request_state(l_request_row.id, nbu_601_migrate.REQ_STATE_TRANSFERRING_DATA, '');

            commit;
            begin
                execute immediate l_data_type_row.transfering_block
                using --l_request_row.id,
                 l_request_row.kf;
            exception
                when others then
                     rollback;
                     set_data_request_state(l_request_row.id,
                                            nbu_601_migrate.REQ_STATE_TRANSFER_DATA_FAIL,
                                            sqlerrm || dbms_utility.format_error_backtrace());
                     -- якщо виникла помилка при транспортуванні даних - перериваємо виконання процедури
                     return;
            end;
        end if;

        set_data_request_state(l_request_row.id, nbu_601_migrate.REQ_STATE_DATA_DELIVERED, 'Дані отримано');
end;

procedure create_data_request(P_KF in varchar2)
    is
    l_request_id int;
    l_instance_id integer ;
    job_is_runing exception;
    pragma exception_init (job_is_runing,-27478);    
    
   begin
      select nvl(max(report_instance_id),0)+1 into l_instance_id from nbu_data_request_601 where kf=p_kf;

     for report_instance_form_first in (select distinct t.id from nbu_data_type_601 t order by  t.id)
      loop
           insert into nbu_data_request_601
           values (S_NBU_601_request_id.nextval,l_instance_id, p_kf,report_instance_form_first.id, nbu_601_migrate.REQ_STATE_NEW)
           returning id
           into l_request_id;
           track_data_request(l_request_id, nbu_601_migrate.REQ_STATE_NEW, 'Сформовано запит на отримання даних з філії');
       end loop;

    commit;
    dbms_scheduler.set_job_argument_value(job_name          =>'RUN_ALL_601',
                                          argument_position =>1,
                                          argument_value    => l_instance_id );
    dbms_scheduler.set_job_argument_value(job_name          =>'RUN_ALL_601',
                                         argument_position =>2,
                                         argument_value    => p_kf ) ;

    begin
    dbms_scheduler.run_job(job_name =>'RUN_ALL_601', use_current_session => false);
     exception when job_is_runing 
               then null;
    end;
    
 end;
end;
/
grant execute on nbu_601_request_data_ru to barstrans;
grant execute on nbu_601_request_data_ru to bars_access_defrole;