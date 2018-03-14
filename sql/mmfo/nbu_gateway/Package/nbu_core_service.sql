create or replace package nbu_core_service
is

    REQ_TYPE_PERSON                constant varchar2(30 char) := 'PERSON';
    REQ_TYPE_PERSON_DOCUMENT       constant varchar2(30 char) := 'PERSON_DOCUMENT';
    REQ_TYPE_PERSON_ADDRESS        constant varchar2(30 char) := 'PERSON_ADDRESS';
    REQ_TYPE_PERSON_WORKPLACE      constant varchar2(30 char) := 'PERSON_WORKPLACE';
    REQ_TYPE_PERSON_INCOME         constant varchar2(30 char) := 'PERSON_INCOME';
    REQ_TYPE_PERSON_FAMILY         constant varchar2(30 char) := 'PERSON_FAMILY';
    REQ_TYPE_COMPANY               constant varchar2(30 char) := 'COMPANY';
    REQ_TYPE_COMPANY_PERFORMANCE   constant varchar2(30 char) := 'COMPANY_PERFORMANCE';
    REQ_TYPE_COMPANY_GROUP         constant varchar2(30 char) := 'COMPANY_GROUP';
    REQ_TYPE_COMPANY_GROUP_PERF    constant varchar2(30 char) := 'COMPANY_GROUP_PERFORMANCE';
    REQ_TYPE_COMPANY_PARTNER       constant varchar2(30 char) := 'COMPANY_PARTNER';
    REQ_TYPE_COMPANY_PARTN_PERF    constant varchar2(30 char) := 'COMPANY_PARTNER_PERFORMANCE';
    REQ_TYPE_COMPANY_OWNER_PERS    constant varchar2(30 char) := 'COMPANY_OWNER_PERSON';
    REQ_TYPE_COMPANY_OWNER_COMP    constant varchar2(30 char) := 'COMPANY_OWNER_COMPANY';
    REQ_TYPE_PLEDGE                constant varchar2(30 char) := 'PLEDGE';
    -- REQ_TYPE_PLEDGE_DEPOSIT        constant varchar2(30 char) := 'PLEDGE_DEPOSIT';
    REQ_TYPE_LOAN                  constant varchar2(30 char) := 'LOAN';
    REQ_TYPE_LOAN_PLEDGE           constant varchar2(30 char) := 'LOAN_PLEDGE';
    REQ_TYPE_LOAN_TRANCHE          constant varchar2(30 char) := 'LOAN_TRANCHE';

    LT_CORE_REQUEST_STATE          constant varchar2(30 char) := 'NBU_601_CORE_REQUEST_STATE';
    REQ_STATE_NEW                  constant integer := 1;
    REQ_STATE_WAITING_FOR_DATA     constant integer := 2;
    REQ_STATE_GATHERING_DATA       constant integer := 3;
    REQ_STATE_GATHERING_DATA_FAIL  constant integer := 4;
    REQ_STATE_TRANSFERING_DATA     constant integer := 5;
    REQ_STATE_TRANSFER_DATA_FAIL   constant integer := 6;
    REQ_STATE_DATA_DELIVERED       constant integer := 7;
    REQ_STATE_FAILED               constant integer := 8;
    REQ_STATE_INCLUDED_IN_REPORT   constant integer := 9;

    type t_requests_series is table of number(38) index by varchar2(30 char);
    type t_branch_data_series is table of t_requests_series index by varchar2(6 char);

    procedure cor_data_request_type(
        p_data_type_code in varchar2,
        p_data_type_name in varchar2,
        p_gathering_data_block in varchar2,
        p_transfering_data_block in varchar2,
        p_is_active in integer);

    function get_request_type_id(
        p_data_type_code in varchar2)
    return integer;

    function get_request_type_code(
        p_data_type_id in integer)
    return varchar2;

    function get_request_type_name(
        p_data_type_id in integer)
    return varchar2;

    procedure set_branch_settings(
        p_kf in varchar2,
        p_branch_name in varchar2,
        p_is_internal in integer,
        p_service_base_url in varchar2,
        p_service_login_name in varchar2,
        p_service_password in varchar2,
        p_region_code in varchar2,
        p_is_active in integer);

    function get_core_service_url(
        p_kf in varchar2)
    return varchar2;

    function create_data_request(
        p_data_type_id in integer,
        p_kf in varchar2,
        p_reporting_date in date,
        p_reporting_person in varchar2 default null,
        p_reporting_time in date default null,
        p_report_id in integer default null)
    return integer;
/*
    procedure put_core_data_request(
        p_kf in varchar2,
        p_data_type_id in integer);

    procedure put_core_data_request(
        p_kf in varchar2);

    procedure run_data_request(
        p_request_id in integer);

    procedure run_all_data_requests(
        p_report_id in integer);
*/
    procedure handle_data_request(
        p_request_id in integer);

    function get_request_series(
        p_report_id in integer)
    return t_branch_data_series;

    function get_request_id_for_report(
        p_report_id in integer,
        p_data_type_code in varchar2,
        p_kf in varchar2)
    return integer;

    function get_active_data_request_id(
        p_data_type_code in varchar2,
        p_kf in varchar2,
        p_reporting_date in date,
        p_reporting_person in varchar2 default null,
        p_reporting_time in date default null)
    return integer;

    procedure set_data_request_state(
        p_request_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2);

    procedure include_request_to_report(
        p_request_id in integer,
        p_report_id in integer);

    function get_core_person_row(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return core_person_fo%rowtype;

    function get_core_person_documents(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return t_core_person_documents;

    function get_core_person_addresses(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return t_core_person_addresses;

    function get_core_person_workplaces(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return t_core_person_workplaces;

    function get_core_person_income_row(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return core_profit_fo%rowtype;

    function get_core_person_family_row(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return core_family_fo%rowtype;

    function get_core_company_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_person_uo%rowtype;

    function get_core_company_perf_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_finperformance_uo%rowtype;

    function get_core_company_group(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_group;

    function get_core_company_gr_perf_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_finperformancegr_uo%rowtype;

    function get_core_company_partners(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_partners;

    function get_core_company_part_perf_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_finperformancepr_uo%rowtype;

    function get_core_company_owner_persons(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_owner_persons;

    function get_core_company_owner_company(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_owner_companies;

    function get_core_pledge_row(
        p_report_id in integer,
        p_core_pledge_id in integer,
        p_core_pledge_kf in varchar2)
    return core_pledge_dep%rowtype;

    function get_core_credit_row(
        p_report_id in integer,
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return core_credit%rowtype;

    function get_core_credit_pledges(
        p_report_id in integer,
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return t_core_loan_pledges;

    function get_core_credit_tranches(
        p_report_id in integer,
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return t_core_loan_tranches;

    procedure set_core_company_state(
        p_request_id in integer,
        p_core_company_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_company_id in integer,
        p_default_company_kf in varchar2,
        p_company_object_id in integer);

    procedure set_core_person_state(
        p_request_id in integer,
        p_core_person_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_person_id in integer,
        p_default_person_kf in varchar2,
        p_person_object_id in integer);

    procedure set_core_pledge_state(
        p_request_id in integer,
        p_core_pledge_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_pledge_id in integer,
        p_default_pledge_kf in varchar2,
        p_pledge_object_id in integer);

    procedure set_core_credit_state(
        p_request_id in integer,
        p_core_credit_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_loan_id in integer,
        p_default_loan_kf in varchar2,
        p_loan_object_id in integer);
end;
/
create or replace package body nbu_core_service as

    type t_report_data_series is table of t_branch_data_series index by pls_integer;

    g_data_requests_series t_report_data_series;

    CORE_DATA_SCHED_PROGRAM_NAME constant varchar2(30 char) := 'NBU601_CORE_DATA_HANDLER';

    function read_core_branch(
        p_kf in varchar2,
        p_raise_ndf in boolean default true)
    return nbu_core_branch%rowtype
    is
        l_core_branch_row nbu_core_branch%rowtype;
    begin
        select *
        into   l_core_branch_row
        from   nbu_core_branch t
        where  t.kf = p_kf;

        return l_core_branch_row;
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
    return nbu_core_data_request_type%rowtype
    is
        l_data_type_row nbu_core_data_request_type%rowtype;
    begin
        select *
        into   l_data_type_row
        from   nbu_core_data_request_type t
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
    return nbu_core_data_request_type%rowtype
    is
        l_data_type_row nbu_core_data_request_type%rowtype;
    begin
        select *
        into   l_data_type_row
        from   nbu_core_data_request_type t
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
    return nbu_core_data_request%rowtype
    is
        l_request_row nbu_core_data_request%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_request_row
            from   nbu_core_data_request t
            where  t.id = p_request_id
            for update;
        else
            select *
            into   l_request_row
            from   nbu_core_data_request t
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

    function read_data_request(
        p_report_id in integer,
        p_data_type_id in integer,
        p_kf in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return nbu_core_data_request%rowtype
    is
        l_request_row nbu_core_data_request%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_request_row
            from   nbu_core_data_request t
            where  t.report_id = p_report_id and
                   t.data_type_id = p_data_type_id and
                   t.kf = p_kf
            for update;
        else
            select *
            into   l_request_row
            from   nbu_core_data_request t
            where  t.report_id = p_report_id and
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

    function get_core_service_url(
        p_kf in varchar2)
    return varchar2
    is
    begin
        return read_core_branch(p_kf).service_base_url;
    end;

    function get_request_type_id(
        p_data_type_code in varchar2)
    return integer
    is
    begin
        return read_data_request_type(p_data_type_code, p_raise_ndf => false).id;
    end;

    function get_request_type_code(
        p_data_type_id in integer)
    return varchar2
    is
    begin
        return read_data_request_type(p_data_type_id, p_raise_ndf => false).data_type_code;
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

    function get_data_request_kf(
        p_request_id in integer)
    return varchar2
    is
    begin
        return read_data_request(p_request_id, p_raise_ndf => false, p_lock => false).kf;
    end;

    procedure cor_data_request_type(
        p_data_type_code in varchar2,
        p_data_type_name in varchar2,
        p_gathering_data_block in varchar2,
        p_transfering_data_block in varchar2,
        p_is_active in integer)
    is
    begin
        merge into nbu_core_data_request_type a
        using dual
        on (a.data_type_code = p_data_type_code)
        when matched then update
             set a.data_type_name = p_data_type_name,
                 a.gathering_block = p_gathering_data_block,
                 a.transfering_block = p_transfering_data_block,
                 a.is_active = p_is_active
        when not matched then insert
             values (s_nbu_core_data_request_type.nextval,
                     p_data_type_code,
                     p_data_type_name,
                     p_gathering_data_block,
                     p_transfering_data_block,
                     p_is_active);
    end;

    procedure set_branch_settings(
        p_kf in varchar2,
        p_branch_name in varchar2,
        p_is_internal in integer,
        p_service_base_url in varchar2,
        p_service_login_name in varchar2,
        p_service_password in varchar2,
        p_region_code in varchar2,
        p_is_active in integer)
    is
    begin
        merge into nbu_core_branch a
        using dual
        on (a.kf = p_kf)
        when matched then update
             set a.branch_name = p_branch_name,
                 a.is_internal = p_is_internal,
                 a.service_base_url = p_service_base_url,
                 a.service_auth = case when p_service_login_name is null then null else p_service_login_name || ':' || p_service_password end,
                 a.region_code = p_region_code,
                 a.is_active = p_is_active
        when not matched then insert
             values (p_kf,
                     p_branch_name,
                     p_is_internal,
                     p_service_base_url,
                     p_service_login_name || ':' || p_service_password,
                     p_region_code,
                     p_is_active);
    end;

    procedure track_data_request(
        p_request_id in integer,
        p_state_id in integer,
        p_tracking_message in varchar2)
    is
    begin
        insert into nbu_core_data_request_tracking
        values (p_request_id, sysdate, p_state_id, substrb(p_tracking_message, 1, 4000));
    end;

    function create_data_request(
        p_data_type_id in integer,
        p_kf in varchar2,
        p_reporting_date in date,
        p_reporting_person in varchar2 default null,
        p_reporting_time in date default null,
        p_report_id in integer default null)
    return integer
    is
        l_request_id integer;
    begin
        insert into nbu_core_data_request
        values (s_nbu_core_data_request.nextval,
                p_data_type_id,
                p_kf,
                p_reporting_date,
                p_reporting_person,
                p_reporting_time,
                p_report_id,
                nbu_core_service.REQ_STATE_NEW)
        returning id
        into l_request_id;

        track_data_request(l_request_id, nbu_core_service.REQ_STATE_NEW, 'Сформовано запит на отримання даних з філії');

        return l_request_id;
    end;

    function get_active_data_request_id(
        p_data_type_code in varchar2,
        p_kf in varchar2,
        p_reporting_date in date,
        p_reporting_person in varchar2 default null,
        p_reporting_time in date default null)
    return integer
    is
        l_request_id integer;
        l_data_type_id integer;
    begin
        l_data_type_id := get_request_type_id(p_data_type_code);

        begin
            select id
            into   l_request_id
            from   nbu_core_data_request t
            where  t.data_type_id = l_data_type_id and
                   t.kf = p_kf and
                   t.reporting_date = p_reporting_date and/*
                   t.state_id in (nbu_core_service.REQ_STATE_NEW, nbu_core_service.REQ_STATE_WAITING_FOR_DATA,
                                  nbu_core_service.REQ_STATE_DATA_DELIVERED) and*/
                   (t.report_id is null or
                    exists (select 1 from nbu_report_instance r
                            where  r.id = t.report_id and
                                   r.stage_id in (nbu_data_service.REP_STAGE_NEW, nbu_data_service.REP_STAGE_RECEIVING_DATA)))
            for update;

            update nbu_core_data_request t
            set    t.reporting_person = p_reporting_person,
                   t.reporting_time = p_reporting_time
            where  t.id = l_request_id;

        exception
            when no_data_found then
                 l_request_id := create_data_request(l_data_type_id,
                                                     p_kf,
                                                     p_reporting_date,
                                                     p_reporting_person => p_reporting_person,
                                                     p_reporting_time => p_reporting_time);
        end;

        return l_request_id;
    end;

    procedure set_data_request_state(
        p_request_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2)
    is
    begin
        update nbu_core_data_request t
        set    t.state_id = p_state_id
        where  t.id = p_request_id;

        track_data_request(p_request_id, p_state_id, p_tracking_comment);
    end;

    procedure include_request_to_report(
        p_request_id in integer,
        p_report_id in integer)
    is
        l_request_row nbu_core_data_request%rowtype;
    begin
        l_request_row := read_data_request(p_request_id, p_lock => true);

        if (l_request_row.state_id <> nbu_core_service.REQ_STATE_DATA_DELIVERED) then
            raise_application_error(-20000, 'Пакет даних типу {' || get_request_type_name(l_request_row.data_type_id) ||
                                            '} з ідентифікатором {' || l_request_row.id || '} від РУ {' || l_request_row.kf ||
                                            '} за дату {' || to_char(l_request_row.reporting_date, 'dd.mm.yyyy') ||
                                            '} перебуває в стані {' || bars.list_utl.get_item_name(nbu_core_service.LT_CORE_REQUEST_STATE, l_request_row.state_id) ||
                                            '} і не може бути включеним до складу звіту');
        end if;

        update nbu_core_data_request t
        set    t.report_id = p_report_id
        where  t.id = l_request_row.id;

        set_data_request_state(l_request_row.id,
                               nbu_core_service.REQ_STATE_INCLUDED_IN_REPORT,
                               'Пакет даних від РУ включається до складу звіту {' || p_report_id || '}');
    end;

    procedure ensure_wrapper_program(
        p_action              in varchar2,
        p_description         in varchar2)
    is
        l_prog_number_of_arguments integer default 0;
        l_program_availability varchar2(30 char);
    begin
        begin
            select t.number_of_arguments, t.enabled
            into   l_prog_number_of_arguments, l_program_availability
            from   user_scheduler_programs t
            where  t.program_name = CORE_DATA_SCHED_PROGRAM_NAME;

            if (l_prog_number_of_arguments <> 1) then
                if (l_program_availability = 'TRUE') then
                    dbms_scheduler.disable(name => CORE_DATA_SCHED_PROGRAM_NAME, force => true);
                    l_program_availability := 'FALSE';
                end if;

                sys.dbms_scheduler.set_attribute(name => CORE_DATA_SCHED_PROGRAM_NAME,
                                                 attribute => 'number_of_arguments',
                                                 value => 1);
            end if;
        exception
            when no_data_found then
                 dbms_scheduler.create_program(program_name        => 'NBU_GATEWAY.' || CORE_DATA_SCHED_PROGRAM_NAME,
                                               program_type        => 'STORED_PROCEDURE',
                                               program_action      => p_action,
                                               number_of_arguments => 1,
                                               enabled             => false,
                                               comments            => p_description);
                 l_program_availability := 'FALSE';
        end;

        dbms_scheduler.define_program_argument(program_name      => CORE_DATA_SCHED_PROGRAM_NAME,
                                               argument_position => 1,
                                               argument_name     => 'p_request_id',
                                               argument_type     => 'number');

        if (l_program_availability = 'FALSE') then
            sys.dbms_scheduler.enable(name => CORE_DATA_SCHED_PROGRAM_NAME);
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
                                           program_name => CORE_DATA_SCHED_PROGRAM_NAME,
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

    function generate_job_name(
        p_kf in varchar2,
        p_data_type_code in varchar2)
    return varchar2
    is
    begin
        return 'NBU601_' || p_kf || '_' || substr(p_data_type_code, 1, 16);
    end;

    procedure run_data_request(
        p_request_id in integer)
    is
        pragma autonomous_transaction;
        l_request_row nbu_core_data_request%rowtype;
        l_core_branch_row nbu_core_branch%rowtype;
        l_job_name varchar2(30 char);
        l_request_mode varchar2(32767 byte);
        job_is_running exception;
        pragma exception_init(job_is_running, -27478);
    begin
        l_request_row := read_data_request(p_request_id, p_lock => true);

        l_request_mode := bars.branch_attribute_utl.get_attribute_value('/', 'NBU_601_CORE_DATA_REQUEST_MODE', p_raise_expt => 0, p_check_exist => 0);

        if (l_request_mode = 'CENTRALIZED') then

            l_core_branch_row := read_core_branch(l_request_row.kf);

            if (l_core_branch_row.is_internal = 1) then
                -- слід пам'ятати, що звернення до dbms_scheduler фіксує транзакцію
                -- (це означає, що використати savepoint в даному випадку не вдасться, тому вся процедура повністю виконується в атономній транзакції,
                -- для того щоб поведінка процедури була прогнозованою і повністю охоплювала весь процес обробки одного запиту даних)

                ensure_wrapper_program('nbu_core_service.handle_data_request',
                                       'Контейнер для запуску процедур підготовки даних регіонального управління, ' ||
                                           'їх перенесення в централізовану схему NBU_GATEWAY та підготовка до консолідації');

                l_job_name := generate_job_name(l_request_row.kf, get_request_type_code(l_request_row.data_type_id));
                ensure_wrapper_job(l_job_name, 'Джоб для обробки запитів на отримання даних для формування 601-ї форми з філії {' || l_request_row.kf ||
                                                   '} по типу даних {' || get_request_type_name(l_request_row.data_type_id) || '}');

                dbms_scheduler.set_job_argument_value(job_name       => l_job_name,
                                                      argument_name  => 'p_request_id',
                                                      argument_value => l_request_row.id);

                -- не виключений подвійний запуск джоба, якщо два користувачі одночасно запустять повторне отримання даних з РУ - другий виклик ігнорується
                begin
                    dbms_scheduler.run_job(job_name => l_job_name, use_current_session => false);
                exception
                    when job_is_running then
                         null;
                end;
            else

                raise_application_error(-20000, 'Робота з віддаленими регіональними управліннями не реалізована');

                /*l_unit_id := barstrans.transport_utl.create_transport_unit(
                                 p_unit_type_id => barstrans.transport_utl.get_unit_type_id(p_data_type),
                                 p_ext_id => '',
                                 p_receiver_url => get_core_service_url(p_kf),
                                 p_request_data => '<data>NBU_601_REGION_DATA_REQUEST</data>',
                                 p_hash => null,
                                 p_state => l_state,
                                 p_msg => l_message);
                if (not bars.tools.equals(l_state, 1)) then
                    raise_application_error(-20000, l_message);
                end if;*/
            end if;
        else
            set_data_request_state(l_request_row.id, nbu_core_service.REQ_STATE_WAITING_FOR_DATA, 'Очікує на отримання даних з філії');
        end if;

        commit;
    exception
        when others then
             rollback;
             bars_audit.log_error('nbu_core_service.run_core_data_request',
                                  sqlerrm || dbms_utility.format_error_backtrace(),
                                  p_object_id => p_request_id,
                                  p_make_context_snapshot => true);
             if (p_request_id is not null) then
                 set_data_request_state(p_request_id, nbu_core_service.REQ_STATE_FAILED, sqlerrm || dbms_utility.format_error_backtrace());
                 commit;
             else raise;
             end if;
    end;

    procedure run_all_data_requests(
        p_report_id in integer)
    is
    begin
        for i in (select * from nbu_core_data_request t
                  where  t.report_id = p_report_id and
                         t.state_id = nbu_core_service.REQ_STATE_NEW) loop
            run_data_request(i.id);
        end loop;
    end;

    procedure handle_data_request(
        p_request_id in integer)
    is
        l_data_type_row nbu_core_data_request_type%rowtype;
        l_request_row nbu_core_data_request%rowtype;
    begin
        bars.bars_audit.log_info('nbu_core_service.handle_core_data_request',
                                 'p_request_id : ' || p_request_id);

        l_request_row := read_data_request(p_request_id, p_lock => true);

        if (l_request_row.state_id in (nbu_core_service.REQ_STATE_GATHERING_DATA, nbu_core_service.REQ_STATE_TRANSFERING_DATA)) then
            return;
        end if;

        l_data_type_row := read_data_request_type(l_request_row.data_type_id);

        if (l_data_type_row.gathering_block is not null or l_data_type_row.transfering_block is not null) then
            bars.bars_login.login_user(sys_guid(), 1, null, 'NBU_601');
            bars.bars_context.go(l_request_row.kf);
        end if;

        if (l_data_type_row.gathering_block is not null) then
            set_data_request_state(l_request_row.id, nbu_core_service.REQ_STATE_GATHERING_DATA, '');

            commit;

            begin
                execute immediate l_data_type_row.gathering_block
                using l_request_row.id, l_request_row.kf;
            exception
                when others then
                     rollback;
                     set_data_request_state(l_request_row.id,
                                            nbu_core_service.REQ_STATE_GATHERING_DATA_FAIL,
                                            sqlerrm || dbms_utility.format_error_backtrace());
                     -- якщо виникла помилка при підготовці даних - перериваємо виконання процедури
                     return;
            end;
        end if;

        if (l_data_type_row.transfering_block is not null) then
            set_data_request_state(l_request_row.id, nbu_core_service.REQ_STATE_TRANSFERING_DATA, '');

            commit;

            begin
                execute immediate l_data_type_row.transfering_block
                using l_request_row.id, l_request_row.kf;
            exception
                when others then
                     rollback;
                     set_data_request_state(l_request_row.id,
                                            nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,
                                            sqlerrm || dbms_utility.format_error_backtrace());
                     -- якщо виникла помилка при транспортуванні даних - перериваємо виконання процедури
                     return;
            end;
        end if;

        set_data_request_state(l_request_row.id, nbu_core_service.REQ_STATE_DATA_DELIVERED, '');
    end;

    function get_request_series(
        p_report_id in integer)
    return t_branch_data_series
    is
    begin
        if (not g_data_requests_series.exists(p_report_id)) then
            for i in (select t.kf, t.data_type_id, max(t.id) request_id
                      from   nbu_core_data_request t
                      where  t.report_id <= p_report_id /*and
                             t.state_id in (nbu_core_service.REQ_STATE_DATA_DELIVERED)*/
                      group by t.kf, t.data_type_id) loop
                -- dbms_output.put_line(i.kf || ' ' || i.data_type_id);
                g_data_requests_series(p_report_id)(i.kf)(nbu_core_service.get_request_type_code(i.data_type_id)) := i.request_id;
            end loop;
        end if;

        if (g_data_requests_series.exists(p_report_id)) then
            return g_data_requests_series(p_report_id);
        else
            return cast(null as t_branch_data_series);
        end if;
    end;

    function get_request_id_for_report(
        p_report_id in integer,
        p_data_type_code in varchar2,
        p_kf in varchar2)
    return integer
    is
        l_data_requests_series t_branch_data_series;
    begin
        l_data_requests_series := get_request_series(p_report_id);
        if (l_data_requests_series.exists(p_kf) and l_data_requests_series(p_kf).exists(p_data_type_code)) then
            return l_data_requests_series(p_kf)(p_data_type_code);
        else
            return null;
        end if;
    end;

    function get_core_person_row(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return core_person_fo%rowtype
    is
        l_request_id integer;
        l_person_row core_person_fo%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_PERSON, p_core_person_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_person_row
        from   core_person_fo t
        where  t.rnk = p_core_person_id and
               t.request_id = l_request_id;

        return l_person_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_person_documents(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return t_core_person_documents
    is
        l_request_id integer;
        l_core_person_documents t_core_person_documents;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_PERSON_DOCUMENT, p_core_person_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_person_document(t.typed, t.seriya, t.nomerd, t.dtd)
        bulk collect into l_core_person_documents
        from   core_document_fo t
        where  t.rnk = p_core_person_id and
               t.request_id = l_request_id;

        return l_core_person_documents;
    end;

    function get_core_person_addresses(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return t_core_person_addresses
    is
        l_request_id integer;
        l_core_person_addresses t_core_person_addresses;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_PERSON_ADDRESS, p_core_person_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_person_address(substr(nvl(t.codregion, b.region_code), 1, 2),
                                     substr(t.area, 1, 100),
                                     substr(t.zip, 1, 10),
                                     substr(t.city, 1, 254),
                                     substr(t.streetaddress, 1, 254),
                                     substr(t.houseno, 1, 50),
                                     substr(t.adrkorp, 1, 10),
                                     substr(t.flatno, 1, 10))
        bulk collect into l_core_person_addresses
        from   core_address_fo t
        join   nbu_core_branch b on b.kf = t.kf
        where  t.rnk = p_core_person_id and
               t.request_id = l_request_id
        order by t.codregion, t.area, t.zip, t.city, t.streetaddress, t.houseno, t.flatno;

        return l_core_person_addresses;
    end;

    function get_core_person_workplaces(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return t_core_person_workplaces
    is
        l_request_id integer;
        l_core_person_workplaces t_core_person_workplaces;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_PERSON_WORKPLACE, p_core_person_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_person_workplace(t.typew, t.codedrpou, t.namew)
        bulk collect into l_core_person_workplaces
        from   core_organization_fo t
        where  t.rnk = p_core_person_id and
               t.request_id = l_request_id
        order by t.typew, t.codedrpou, t.namew;

        return l_core_person_workplaces;
    end;

    function get_core_person_income_row(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return core_profit_fo%rowtype
    is
        l_request_id integer;
        l_person_income_row core_profit_fo%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_PERSON_INCOME, p_core_person_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_person_income_row
        from   core_profit_fo t
        where  t.rnk = p_core_person_id and
               t.request_id = l_request_id;

        return l_person_income_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_person_family_row(
        p_report_id in integer,
        p_core_person_id in integer,
        p_core_person_kf in varchar2)
    return core_family_fo%rowtype
    is
        l_request_id integer;
        l_person_family_row core_family_fo%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_PERSON_INCOME, p_core_person_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_person_family_row
        from   core_family_fo t
        where  t.rnk = p_core_person_id and
               t.request_id = l_request_id;

        return l_person_family_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_company_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_person_uo%rowtype
    is
        l_request_id integer;
        l_company_row core_person_uo%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_company_row
        from   core_person_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id;

        return l_company_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_company_perf_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_finperformance_uo%rowtype
    is
        l_request_id integer;
        l_company_performance_row core_finperformance_uo%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY_PERFORMANCE, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_company_performance_row
        from   core_finperformance_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id;

        return l_company_performance_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_company_group(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_group
    is
        l_request_id integer;
        l_core_company_group t_core_company_group;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY_GROUP, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_company_group_member(t.whois, t.isrezgr, t.codedrpougr, t.nameurgr, t.countrycodgr)
        bulk collect into l_core_company_group
        from   core_groupur_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id
        order by t.codedrpougr, t.nameurgr;

        return l_core_company_group;
    end;

    function get_core_company_gr_perf_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_finperformancegr_uo%rowtype
    is
        l_request_id integer;
        l_company_group_perf_row core_finperformancegr_uo%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY_GROUP_PERF, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_company_group_perf_row
        from   core_finperformancegr_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id;

        return l_company_group_perf_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_company_partners(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_partners
    is
        l_request_id integer;
        l_core_company_partners t_core_company_partners;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY_PARTNER, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_company_partner(t.isrezpr, t.codedrpoupr, t.nameurpr, t.countrycodpr)
        bulk collect into l_core_company_partners
        from   core_partners_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id
        order by t.codedrpoupr, t.nameurpr;

        return l_core_company_partners;
    end;

    function get_core_company_part_perf_row(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return core_finperformancepr_uo%rowtype
    is
        l_request_id integer;
        l_company_partners_perf_row core_finperformancepr_uo%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY_PARTN_PERF, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_company_partners_perf_row
        from   core_finperformancepr_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id;

        return l_company_partners_perf_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_company_owner_persons(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_owner_persons
    is
        l_request_id integer;
        l_core_company_owner_persons t_core_company_owner_persons;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY_OWNER_PERS, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_company_owner_person(t.lastname, t.firstname, t.middlename, t.isrez, t.inn, t.countrycod, t.percent)
        bulk collect into l_core_company_owner_persons
        from   core_ownerpp_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id
        order by t.rnkb, t.lastname, t.firstname, t.middlename;

        return l_core_company_owner_persons;
    end;

    function get_core_company_owner_company(
        p_report_id in integer,
        p_core_company_id in integer,
        p_core_company_kf in varchar2)
    return t_core_company_owner_companies
    is
        l_request_id integer;
        l_core_company_owner_companies t_core_company_owner_companies;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_COMPANY_OWNER_PERS, p_core_company_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_company_owner_company(t.nameoj, t.isrezoj, t.codedrpouoj, t.registrydayoj, t.numberregistryoj, t.countrycodoj, t.percentoj)
        bulk collect into l_core_company_owner_companies
        from   core_ownerjur_uo t
        where  t.rnk = p_core_company_id and
               t.request_id = l_request_id
        order by t.rnkb, t.nameoj, t.codedrpouoj;

        return l_core_company_owner_companies;
    end;

    function get_core_pledge_row(
        p_report_id in integer,
        p_core_pledge_id in integer,
        p_core_pledge_kf in varchar2)
    return core_pledge_dep%rowtype
    is
        l_request_id integer;
        l_pledge_row core_pledge_dep%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_PLEDGE, p_core_pledge_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_pledge_row
        from   core_pledge_dep t
        where  t.acc = p_core_pledge_id and
               t.request_id = l_request_id;

        return l_pledge_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_core_credit_row(
        p_report_id in integer,
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return core_credit%rowtype
    is
        l_request_id integer;
        l_credit_row core_credit%rowtype;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_LOAN, p_core_loan_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select *
        into   l_credit_row
        from   core_credit t
        where  t.nd = p_core_loan_id and
               t.request_id = l_request_id;

        return l_credit_row;
    exception
        when no_data_found then
             return null;
    end;

    procedure set_core_company_state(
        p_request_id in integer,
        p_core_company_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_company_id in integer,
        p_default_company_kf in varchar2,
        p_company_object_id in integer)
    is
    begin
        update core_person_uo t
        set    t.status = p_state_code,
               t.status_message = p_state_message,
               t.default_company_id = p_default_company_id,
               t.default_company_kf = p_default_company_kf,
               t.company_object_id = nvl(p_company_object_id, t.company_object_id)
        where  t.request_id = p_request_id and
               t.rnk = p_core_company_id;
    end;

    procedure set_core_person_state(
        p_request_id in integer,
        p_core_person_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_person_id in integer,
        p_default_person_kf in varchar2,
        p_person_object_id in integer)
    is
    begin
        update core_person_fo t
        set    t.status = p_state_code,
               t.status_message = p_state_message,
               t.default_person_id = p_default_person_id,
               t.default_person_kf = p_default_person_kf,
               t.person_object_id = nvl(p_person_object_id, t.person_object_id)
        where  t.request_id = p_request_id and
               t.rnk = p_core_person_id;
    end;

    procedure set_core_pledge_state(
        p_request_id in integer,
        p_core_pledge_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_pledge_id in integer,
        p_default_pledge_kf in varchar2,
        p_pledge_object_id in integer)
    is
    begin
        update core_pledge_dep t
        set    t.status = p_state_code,
               t.status_message = p_state_message,
               t.default_pledge_kf = p_default_pledge_kf,
               t.default_pledge_id = p_default_pledge_id,
               t.pledge_object_id = nvl(p_pledge_object_id, t.pledge_object_id)
        where  t.request_id = p_request_id and
               t.acc = p_core_pledge_id;
    end;

    procedure set_core_credit_state(
        p_request_id in integer,
        p_core_credit_id in integer,
        p_state_code in varchar2,
        p_state_message in varchar2,
        p_default_loan_id in integer,
        p_default_loan_kf in varchar2,
        p_loan_object_id in integer)
    is
    begin
        update core_credit t
        set    t.status = p_state_code,
               t.status_message = p_state_message,
               t.default_loan_kf = p_default_loan_kf,
               t.default_loan_id = p_default_loan_id,
               t.loan_object_id = nvl(p_loan_object_id, t.loan_object_id)
        where  t.request_id = p_request_id and
               t.nd = p_core_credit_id;
    end;

    function get_core_credit_pledges(
        p_report_id in integer,
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return t_core_loan_pledges
    is
        l_request_id integer;
        l_core_loan_pledges t_core_loan_pledges;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_LOAN_PLEDGE, p_core_loan_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_loan_pledge(o.external_id, t.sumpledge, t.pricepledge)
        bulk collect into l_core_loan_pledges
        from   core_credit_pledge t
        join   nbu_reported_pledge p on p.core_pledge_kf = t.kf and
                                        p.core_pledge_id = t.acc
        join   nbu_reported_object o on o.id = p.id and
                                        o.external_id is not null
        where  t.nd = p_core_loan_id and
               t.request_id = l_request_id
        order by t.acc;

        return l_core_loan_pledges;
    end;

    function get_core_credit_tranches(
        p_report_id in integer,
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return t_core_loan_tranches
    is
        l_request_id integer;
        l_core_loan_tranches t_core_loan_tranches;
    begin
        l_request_id := get_request_id_for_report(p_report_id, nbu_core_service.REQ_TYPE_LOAN_TRANCHE, p_core_loan_kf);

        if (l_request_id is null) then
            return null;
        end if;

        select t_core_loan_tranche(t.numdogtr,
                                   t.dogdaytr,
                                   t.enddaytr,
                                   t.sumzagaltr,
                                   t.r030tr,
                                   t.proccredittr,
                                   t.periodbasetr,
                                   t.periodproctr,
                                   t.sumarrearstr,
                                   t.arrearbasetr,
                                   t.arrearproctr,
                                   t.daybasetr,
                                   t.dayproctr,
                                   t.factenddaytr,
                                   t.klasstr,
                                   t.risktr)
        bulk collect into l_core_loan_tranches
        from   core_credit_tranche t
        where  t.nd = p_core_loan_id and
               t.request_id = l_request_id
        order by t.numdogtr,
                 t.dogdaytr,
                 t.enddaytr,
                 t.sumzagaltr,
                 t.r030tr,
                 t.proccredittr,
                 t.periodbasetr,
                 t.periodproctr,
                 t.sumarrearstr,
                 t.arrearbasetr,
                 t.arrearproctr,
                 t.daybasetr,
                 t.dayproctr,
                 t.factenddaytr,
                 t.klasstr,
                 t.risktr;

        return l_core_loan_tranches;
    end;
end;
/
