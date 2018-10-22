
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/tms_utl.sql =========*** Run *** ===
PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.TMS_UTL 
is
    -------------------------------------------------------------------------------
    LT_TASK_GROUP                  constant varchar2(30 char) := 'BANKDATE_TASK_GROUP';
    TASK_GROUP_BEFORE_FINISH       constant integer := 1;
    TASK_GROUP_AFTER_START         constant integer := 2;
    TASK_GROUP_SWITCH_DATE         constant integer := 3;

    LT_BRANCH_STAGE                constant varchar2(30 char) := 'BANKDATE_BRANCH_STAGE';
    STAGE_OPERATIONAL              constant integer := 1;
    STAGE_ACTIVITY_ACCOMPLISHED    constant integer := 2;

    LT_BRANCH_PROCESSING_MODE      constant varchar2(30 char) := 'BANKDATE_BRANCH_PROC_MODE';
    BRANCH_PROC_MODE_WHOLE_BANK    constant integer := 1;
    BRANCH_PROC_MODE_SEQUENTIAL    constant integer := 2;
    BRANCH_PROC_MODE_PARALLEL_1    constant integer := 3;  -- parallel from brannhes of 1 level /xxxxxx/
    BRANCH_PROC_MODE_PARALLEL_2    constant integer := 4;  -- parallel from brannhes of 2 level /xxxxxx/xxxxxx/
    BRANCH_PROC_MODE_PARALLEL_3    constant integer := 5;  -- parallel from branches of 3 level /xxxxxx/xxxxxx/xxxxxx/



    LT_ACTION_ON_FAILURE           constant varchar2(30 char) := 'BANKDATE_ACTION_ON_FAILURE';
    ACTION_ON_FAILURE_PROCEED      constant integer := 1;
    ACTION_ON_FAILURE_INTERRUPT    constant integer := 2;

    LT_TASK_STATE                  constant varchar2(30 char) := 'BANKDATE_TASK_STATE';
    TASK_STATE_ACTIVE              constant integer := 1;
    TASK_STATE_DISABLED            constant integer := 2;

    LT_RUN_STATE                   constant varchar2(30 char) := 'BANKDATE_RUN_STATE';
    RUN_STATE_IDLE                 constant integer := 1;
    RUN_STATE_IN_PROGRESS          constant integer := 2;
    RUN_STATE_FINISHED             constant integer := 3;
    RUN_STATE_HAS_ERRORS           constant integer := 4;
    RUN_STATE_TERMINATED           constant integer := 5;

    LT_TASK_RUN_STATE              constant varchar2(30 char) := 'BANKDATE_TASK_RUN_STATE';
    TASK_RUN_STATE_IDLE            constant integer := 1;
    TASK_RUN_STATE_IN_PROGRESS     constant integer := 2;
    TASK_RUN_STATE_FINISHED        constant integer := 3;
    TASK_RUN_STATE_FAILED          constant integer := 4;
    TASK_RUN_STATE_TERMINATED      constant integer := 5;
    TASK_RUN_STATE_DISABLED        constant integer := 6;
    TASK_RUN_STATE_SKIP            constant integer := 7;
    TASK_RUN_STATE_WAIT_LEADING    constant integer := 8;

    function read_task(
        p_task_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_task%rowtype;

    function read_task(
        p_task_code in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_task%rowtype;

    function read_run(
        p_run_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_run%rowtype;

    function read_task_run(
        p_task_run_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_task_run%rowtype;

    procedure set_branch_stage(
        p_branch_code in varchar2,
        p_stage_id in integer);

    function create_task(
        p_task_code in varchar2,
        p_task_group_id in integer,
        p_sequence_number in integer,
        p_task_name in varchar2,
        p_task_description in varchar2,
        p_separate_by_branch_mode in integer,
        p_action_on_failure in integer,
        p_task_statement in varchar2)
    return integer;

    function create_or_replace_task(
        p_task_code in varchar2,
        p_task_group_id in integer,
        p_sequence_number in integer,
        p_task_name in varchar2,
        p_task_description in varchar2,
        p_separate_by_branch_mode in integer,
        p_action_on_failure in integer,
        p_task_statement in varchar2)
    return integer;

    function get_task_name(
        p_task_id in integer)
    return varchar2;

    function create_run(
        p_new_date in date)
    return integer;

    function deploy_task_run(
        p_new_date in date)
    return integer;

    procedure set_new_bank_date(
        p_run_id in integer,
        p_new_bank_date in date);

    procedure enable_task_for_run(
        p_run_id in integer,
        p_task_id in integer);

    procedure disable_task_for_run(
        p_run_id in integer,
        p_task_id in integer);

    procedure enable_task_for_branch(
        p_task_run_id in integer);

    procedure disable_task_for_branch(
        p_task_run_id in integer);

    procedure start_task_run_wrapper(
        p_task_run_id in integer);

    procedure start_run(
        p_run_id in integer);

    procedure proceed_run(
        p_run_id in integer);

    procedure disable_task_run(
        p_task_run_id in integer);

    procedure run_task_run(
        p_task_run_id in integer);

    procedure finish_run(
        p_run_id in integer);

    procedure terminate_task_run(
        p_task_run_id in integer);

    procedure job_event_handler(
        context  in raw,
        reginfo  in sys.aq$_reg_info,
        descr    in sys.aq$_descriptor,
        payload  in raw,
        payloadl in number);

    procedure switch_bank_date;

    procedure CLOSE_USER_SESSIONS(
        p_kf     in varchar2,
        p_bnk_dt in varchar2);

    procedure SET_BANK_DATE_ACCESS(
        p_kf     in fdat_kf.kf%type,
        p_closed in integer);

    function CHECK_ACCESS(
        p_kf    in     fdat_kf.kf%type)
    return integer;
    --result_cache;

    procedure SET_BANK_DATE_STATE(
        p_fdat   in date,
        p_stat   in integer);

    function GET_BANKDATE_STATE(
        p_fdat   in date)
    return integer
    result_cache;

end TMS_UTL;
/
CREATE OR REPLACE PACKAGE BODY BARS.TMS_UTL 
is

    TASK_RUN_WRAPPER_PROGRAM_NAME constant varchar2(30 char) := 'TMS_TASK_RUN_WRAPPER_PROGRAM';

    procedure log_message(
        p_procedure_name in varchar2 default null,
        p_log_message in varchar2,
        p_log_level in varchar2 default 'TRACE',
        p_object_id in varchar2 default null,
        p_object_type in varchar2 default null,
        p_log_details in clob default null)
    is
    begin
        bars_audit.log_info(p_procedure_name, p_log_message, p_object_id => p_object_id, p_make_context_snapshot => true);
    end;

    function read_task(
        p_task_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_task%rowtype
    is
        l_task_row tms_task%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_task_row
            from   tms_task t
            where  t.id = p_task_id
            for update;
        else
            select *
            into   l_task_row
            from   tms_task t
            where  t.id = p_task_id;
        end if;

        return l_task_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Регламентна процедура з ідентифікатором {' || p_task_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_task(
        p_task_code in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_task%rowtype
    is
        l_task_row tms_task%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_task_row
            from   tms_task t
            where  t.task_code = p_task_code
            for update;
        else
            select *
            into   l_task_row
            from   tms_task t
            where  t.task_code = p_task_code;
        end if;

        return l_task_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Регламентна процедура з кодом {' || p_task_code || '} не знайдена');
             else return null;
             end if;
    end;

    function read_run(
        p_run_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_run%rowtype
    is
        l_tms_run_row tms_run%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_tms_run_row
            from   tms_run t
            where  t.id = p_run_id
            for update;
        else
            select *
            into   l_tms_run_row
            from   tms_run t
            where  t.id = p_run_id;
        end if;

        return l_tms_run_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Процес зміни банківської дати з ідентифікатором {' || p_run_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_task_run(
        p_task_run_id in integer,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_task_run%rowtype
    is
        l_tms_task_run_row tms_task_run%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_tms_task_run_row
            from   tms_task_run t
            where  t.id = p_task_run_id
            for update;
        else
            select *
            into   l_tms_task_run_row
            from   tms_task_run t
            where  t.id = p_task_run_id;
        end if;

        return l_tms_task_run_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Запуск процедури при зміні банківської дати з ідентифікатором {' || p_task_run_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_run_branch_stage(
        p_run_id in integer,
        p_branch in varchar2,
        p_raise_ndf in boolean default true,
        p_lock in boolean default false)
    return tms_branch_stage%rowtype
    is
        l_branch_stage_row tms_branch_stage%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_branch_stage_row
            from   tms_branch_stage t
            where  t.run_id = p_run_id and
                   t.branch = p_branch
            for update;
        else
            select *
            into   l_branch_stage_row
            from   tms_branch_stage t
            where  t.run_id = p_run_id and
                   t.branch = p_branch;
        end if;

        return l_branch_stage_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Операційний статус відділення {' || p_branch ||
                                                 '} для запуску з ідентифікатором {' || p_run_id || '} не знайдений');
             else return null;
             end if;
    end;

    function get_task_name(
        p_task_id in integer)
    return varchar2
    is
    begin
        return read_task(p_task_id, p_raise_ndf => false).task_name;
    end;

    function get_last_run_id(
        p_include_states in number_list default null,
        p_exclude_states in number_list default null)
    return integer
    is
        l_last_run_id integer;
    begin
        select min(r.id) keep (dense_rank last order by r.id)
        into   l_last_run_id
        from   tms_run r
        where  (p_exclude_states is null or p_exclude_states is empty or
                r.state_id not in (select column_value from table(p_exclude_states))) and
               (p_include_states is null or p_include_states is empty or
                r.state_id in (select column_value from table(p_include_states)));

        return l_last_run_id;
    end;

    procedure track_task_run(
        p_task_run_id in integer,
        p_state_id in integer,
        p_details in clob)
    is
    begin
        insert into tms_task_run_tracking
        values (s_tms_task_run_tracking.nextval, p_task_run_id, p_state_id, sysdate, user_id(), p_details);
    end;

    function create_task(
        p_task_code in varchar2,
        p_task_group_id in integer,
        p_sequence_number in integer,
        p_task_name in varchar2,
        p_task_description in varchar2,
        p_separate_by_branch_mode in integer,
        p_action_on_failure in integer,
        p_task_statement in varchar2)
    return integer
    is
        l_task_id integer;
    begin
        insert into tms_task
        values (s_tms_task.nextval,
                p_task_code,
                1, -- тип задачі (1 - PL/SQL block, 2 - web url)
                p_task_group_id,
                p_sequence_number,
                p_task_name,
                p_task_description,
                p_separate_by_branch_mode,
                p_action_on_failure,
                p_task_statement,
                tms_utl.TASK_STATE_ACTIVE)
        returning id
        into l_task_id;

        return l_task_id;
    end;

    function create_or_replace_task(
        p_task_code in varchar2,
        p_task_group_id in integer,
        p_sequence_number in integer,
        p_task_name in varchar2,
        p_task_description in varchar2,
        p_separate_by_branch_mode in integer,
        p_action_on_failure in integer,
        p_task_statement in varchar2)
    return integer
    is
        l_task_row tms_task%rowtype;
    begin
        l_task_row := read_task(p_task_code, p_lock => true, p_raise_ndf => false);

        if (l_task_row.id is null) then
            insert into tms_task
            values (s_tms_task.nextval,
                    p_task_code,
                    1, -- тип задачі (1 - PL/SQL block, 2 - web url)
                    p_task_group_id,
                    p_sequence_number,
                    p_task_name,
                    p_task_description,
                    p_separate_by_branch_mode,
                    p_action_on_failure,
                    p_task_statement,
                    tms_utl.TASK_STATE_ACTIVE)
            returning id
            into l_task_row.id;
        else
            update tms_task t
            set    t.task_type_id           = 1, -- тип задачі (1 - PL/
                   t.task_group_id          = p_task_group_id,
                   t.sequence_number        = p_sequence_number,
                   t.task_name              = p_task_name,
                   t.task_description       = p_task_description,
                   t.branch_processing_mode = p_separate_by_branch_mode,
                   t.action_on_failure      = p_action_on_failure,
                   t.task_statement         = p_task_statement,
                   t.state_id               = tms_utl.TASK_STATE_ACTIVE
            where  t.task_code = p_task_code;
        end if;

        return l_task_row.id;
    end;

    function create_task_run(
        p_run_id in integer,
        p_task_id in integer,
        p_branch_code in varchar2,
        p_state_id in integer)
    return integer
    is
        l_task_run_id integer;
        l_wrapper_job_name varchar2(30 char);
    begin
        l_task_run_id := s_tms_task_run.nextval;

        l_wrapper_job_name := 'TMS_JOB_WRAPPER_' || l_task_run_id;

        insert into tms_task_run
        values (l_task_run_id,
                p_run_id,
                p_task_id,
                p_branch_code,
                l_wrapper_job_name,
                null,
                null,
                p_state_id)
        returning id
        into l_task_run_id;

        track_task_run(l_task_run_id, tms_utl.TASK_RUN_STATE_IDLE, null);

        return l_task_run_id;
    end;

    function create_run(
        p_new_date in date)
    return integer
    is
        l_run_id integer;
    begin
        insert into tms_run
        values (s_tms_run.nextval,
                bankdate(),
                p_new_date,
                tms_utl.RUN_STATE_IDLE,
                user_id())
        returning id
        into l_run_id;

        return l_run_id;
    end;

    procedure reset_run(
        p_run_row in tms_run%rowtype,
        p_previous_date in date,
        p_new_date in date,
        p_user_id in integer)
    is
    begin
        if (p_run_row.state_id <> tms_utl.RUN_STATE_IDLE) then
            raise_application_error(-20000, 'Вносити зміни в процедуру переводу банківського дня в стані {' ||
                                            list_utl.get_item_name(tms_utl.LT_RUN_STATE, p_run_row.state_id) || '} заборонено');
        end if;

        update tms_run t
        set    t.current_bank_date = p_previous_date,
               t.new_bank_date = p_new_date,
               t.user_id = p_user_id
        where  t.id = p_run_row.id;
    end;

    procedure set_branch_stage(
        p_branch_code in varchar2,
        p_stage_id in integer)
    is
        l_unfinished_run_id integer;
        l_unfinished_run_row tms_run%rowtype;
    begin
        l_unfinished_run_id := get_last_run_id(p_exclude_states => number_list(tms_utl.RUN_STATE_IDLE, tms_utl.RUN_STATE_FINISHED, tms_utl.RUN_STATE_HAS_ERRORS));

        if (l_unfinished_run_id is not null) then
            l_unfinished_run_row := read_run(l_unfinished_run_id);
            raise_application_error(-20000, 'Процес зміни дати з ' || to_char(l_unfinished_run_row.current_bank_date, 'dd.mm.yyyy') ||
                                            ' на ' || to_char(l_unfinished_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                            ' вже розпочався - заборонено редагувати флаг готовності РУ під час роботи процесу зміни дати');
        end if;

        merge into tms_branch_stage a
        using dual
        on (a.branch = p_branch_code and
            a.run_id is null)
        when matched then update
             set a.stage_id = p_stage_id,
                 a.sys_time = sysdate,
                 a.user_id = user_id()
        when not matched then insert
             values (p_branch_code,
                     p_stage_id,
                     sysdate,
                     user_id(),
                     null);
    end;

    procedure bind_branch_stages_to_run(
        p_run_id in integer)
    is
    begin
        update tms_branch_stage a
        set    a.run_id = p_run_id
        where  a.run_id is null;

        insert into tms_branch_stage
        select tr.branch, tms_utl.STAGE_OPERATIONAL, sysdate, user_id(), p_run_id
        from   tms_task_run tr
        where  tr.run_id = p_run_id and
               not exists (select 1 from tms_branch_stage a
                           where  a.branch = tr.branch and
                                  a.run_id = tr.run_id)
        group by tr.branch;
    end;

    procedure set_task_run_state(
        p_task_run_id in integer,
        p_state_id in integer,
        p_details in clob)
    is
    begin
        update tms_task_run t
        set    t.state_id = p_state_id
        where  t.id = p_task_run_id;

        track_task_run(p_task_run_id, p_state_id, p_details);
    end;

    procedure set_run_state(
        p_run_id in integer,
        p_state_id in integer,
        p_details in clob)
    is
    begin
        update tms_run t
        set    t.state_id = p_state_id
        where  t.id = p_run_id;
    end;

    procedure set_new_bank_date(
        p_run_id in integer,
        p_new_bank_date in date)
    is
        l_run_row tms_run%rowtype;
    begin
        l_run_row := read_run(p_run_id, p_lock => true);

        if (l_run_row.state_id <> tms_utl.RUN_STATE_IDLE) then
            raise_application_error(-20000, 'Вносити зміни в процедуру переводу банківського дня в стані {' ||
                                            list_utl.get_item_name(tms_utl.LT_RUN_STATE, l_run_row.state_id) || '} заборонено');
        end if;

        update tms_run r
        set    r.new_bank_date = p_new_bank_date
        where  r.id = p_run_id;
    end;

    
  --------------------------------------------------
  --  DEPLOY_RUN_TASKS
  --  
  --  СОздать очередб на віполнение заданий в разрезе филиалов и бранчей 
  --
  --
  procedure deploy_run_tasks(
        p_run_id in integer)
    is
    begin
        for i in (/*select t.id, case when k.kf is null then '/' else bars_context.make_branch(k.kf) end branch_code,
                         -- tms_utl.TASK_RUN_STATE_IDLE
                   */      
                   select t.id, branch_processing_mode, case when k.kf is null and r.branch is null then '/' else 
                                         case when r.branch is not null then r.branch else  bars_context.make_branch(k.kf) end 
                                     end branch_code,                                     
                         -- для задач, що виконуються по кожному відділенню окремо, перевіряємо стадію, на якій знаходиться відділення
                         case when t.branch_processing_mode in (tms_utl.BRANCH_PROC_MODE_SEQUENTIAL, tms_utl.BRANCH_PROC_MODE_PARALLEL_1,  tms_utl.BRANCH_PROC_MODE_PARALLEL_2 ) then
                                   -- якщо відділення повідомило про готовність до завершення дня (b.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED),
                                   -- задачі по ньому будуть очікувати на запуск
                                   case when b.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED then tms_utl.TASK_RUN_STATE_IDLE
                                        else -- якщо ж відділення не повідомило про свою готовність - ставимо його задачам статус "Пропустити виконання".
                                             -- Данна поведінка працює за замовчанням - технолог банку зможе включити або відмінити виконання задач вручну
                                             tms_utl.TASK_RUN_STATE_SKIP
                                   end
                              else tms_utl.TASK_RUN_STATE_IDLE
                         end state_id
                  from   tms_task t
                  left join mv_kf k on t.branch_processing_mode in (tms_utl.BRANCH_PROC_MODE_SEQUENTIAL, tms_utl.BRANCH_PROC_MODE_PARALLEL_1) and
                                                           not exists (select 1 from tms_task_exclusion ex 
                                                                        where ex.kf = k.kf and t.task_code = ex.task_code)
                  left join branch r           on t.branch_processing_mode in  (tms_utl.BRANCH_PROC_MODE_PARALLEL_2)   and not exists (select 1 from tms_task_exclusion ex 
                                                                                                      where ex.kf = branch_utl.get_kf_from_branch_code(r.branch) 
                                                                                                        and t.task_code = ex.task_code)
                                                                                                        and branch_utl.get_branch_level(r.branch) = 2
                  left join tms_branch_stage b on b.branch = case when k.kf is null and r.branch is null then '/' 
                                                                  else 
                                                                      case when r.branch is null then bars_context.make_branch(k.kf) 
                                                                           else bars_context.make_branch(branch_utl.get_kf_from_branch_code(r.branch)) 
                                                                      end
                                                             end 
                                      and b.run_id is null
                  where  t.state_id = tms_utl.TASK_STATE_ACTIVE) loop
            tools.hide_hint(create_task_run(p_run_id, i.id, i.branch_code, i.state_id));
        end loop;
    end;

    procedure redeploy_run_tasks(
        p_run_id in integer)
    is
    begin
        delete tms_task_run_tracking tr
        where  tr.task_run_id in (select t.id
                                  from   tms_task_run t
                                  where  t.run_id = p_run_id);

        delete tms_task_run tr
        where  tr.run_id = p_run_id;

        deploy_run_tasks(p_run_id);
    end;

    function deploy_task_run(
        p_new_date in date)
    return integer
    is
        l_run_id integer;
        l_unfinished_run_id integer;
        l_unfinished_run_row tms_run%rowtype;
    begin
        l_unfinished_run_id := get_last_run_id(p_exclude_states => number_list(tms_utl.RUN_STATE_FINISHED, tms_utl.RUN_STATE_HAS_ERRORS));

        if (l_unfinished_run_id is null) then

            l_run_id := create_run(p_new_date);
            deploy_run_tasks(l_run_id);

        else
            l_unfinished_run_row := read_run(l_unfinished_run_id, p_lock => true);

            if (l_unfinished_run_row.state_id = tms_utl.RUN_STATE_IDLE) then

                l_run_id := l_unfinished_run_id;
                reset_run(l_unfinished_run_row, bankdate(), p_new_date, user_id());
                redeploy_run_tasks(l_unfinished_run_row.id);

            else
                raise_application_error(-20000, 'Зміна дати з ' || to_char(l_unfinished_run_row.current_bank_date, 'dd.mm.yyyy') ||
                                                ' на ' || to_char(l_unfinished_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                                ' не завершена - необхідно дочекатися завершення роботи усіх процедур або відмінити їх');
            end if;
        end if;

        return l_run_id;
    end;

    procedure enable_task_for_run(
        p_run_id in integer,
        p_task_id in integer)
    is
        l_run_row tms_run%rowtype;
    begin
        l_run_row := read_run(p_run_id, p_lock => true);

        if (l_run_row.state_id <> tms_utl.RUN_STATE_IDLE) then
            raise_application_error(-20000, 'Вносити зміни в процедуру переводу банківського дня в стані {' ||
                                            list_utl.get_item_name(tms_utl.LT_RUN_STATE, l_run_row.state_id) || '} заборонено');
        end if;

        for i in (select * from tms_task_run tr
                  where  tr.run_id = p_run_id and
                         tr.task_id = p_task_id and
                         tr.state_id = tms_utl.TASK_RUN_STATE_DISABLED) loop
            set_task_run_state(i.id, tms_utl.TASK_RUN_STATE_IDLE, null);
        end loop;
    end;

    procedure disable_task_for_run(
        p_run_id in integer,
        p_task_id in integer)
    is
        l_run_row tms_run%rowtype;
    begin
        l_run_row := read_run(p_run_id, p_lock => true);

        if (l_run_row.state_id <> tms_utl.RUN_STATE_IDLE) then
            raise_application_error(-20000, 'Вносити зміни в процедуру переводу банківського дня в стані {' ||
                                            list_utl.get_item_name(tms_utl.LT_RUN_STATE, l_run_row.state_id) || '} заборонено');
        end if;

        for i in (select * from tms_task_run tr
                  where  tr.run_id = p_run_id and
                         tr.task_id = p_task_id and
                         tr.state_id = tms_utl.TASK_RUN_STATE_IDLE) loop
            set_task_run_state(i.id, tms_utl.TASK_RUN_STATE_DISABLED, null);
        end loop;
    end;

    procedure enable_task_for_branch(
        p_task_run_id in integer)
    is
        l_task_run_row tms_task_run%rowtype;
        l_run_row tms_run%rowtype;
    begin
        l_task_run_row := read_task_run(p_task_run_id, p_lock => true);

        if (l_task_run_row.state_id in (tms_utl.TASK_RUN_STATE_DISABLED, tms_utl.TASK_RUN_STATE_SKIP)) then
            l_run_row := read_run(l_task_run_row.run_id, p_lock => true);

            if (l_run_row.state_id <> tms_utl.RUN_STATE_IDLE) then
                raise_application_error(-20000, 'Вносити зміни в процедуру переводу банківського дня в стані {' ||
                                                list_utl.get_item_name(tms_utl.LT_RUN_STATE, l_run_row.state_id) || '} заборонено');
            end if;

            set_task_run_state(l_task_run_row.id, tms_utl.TASK_RUN_STATE_IDLE, null);
        elsif (l_task_run_row.state_id = tms_utl.TASK_RUN_STATE_IDLE) then
            null;
        else
            raise_application_error(-20000, 'Запуск процедури в стані {' ||
                                            list_utl.get_item_name(tms_utl.LT_TASK_RUN_STATE, l_run_row.state_id) || '} не може бути включений');
        end if;
    end;

    procedure disable_task_for_branch(
        p_task_run_id in integer)
    is
        l_task_run_row tms_task_run%rowtype;
        l_run_row tms_run%rowtype;
    begin
        l_task_run_row := read_task_run(p_task_run_id, p_lock => true);

        if (l_task_run_row.state_id = tms_utl.TASK_RUN_STATE_IDLE) then
            l_run_row := read_run(l_task_run_row.run_id, p_lock => true);

            if (l_run_row.state_id <> tms_utl.RUN_STATE_IDLE) then
                raise_application_error(-20000, 'Вносити зміни в процедуру переводу банківського дня в стані {' ||
                                                list_utl.get_item_name(tms_utl.LT_RUN_STATE, l_run_row.state_id) || '} заборонено');
            end if;

            set_task_run_state(l_task_run_row.id, tms_utl.TASK_RUN_STATE_DISABLED, null);
        elsif (l_task_run_row.state_id = tms_utl.TASK_RUN_STATE_DISABLED) then
            null;
        else
            raise_application_error(-20000, 'Запуск процедури в стані {' ||
                                            list_utl.get_item_name(tms_utl.LT_TASK_RUN_STATE, l_run_row.state_id) || '} не може бути відмінений');
        end if;
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
            where  t.program_name = TASK_RUN_WRAPPER_PROGRAM_NAME;

            if (l_prog_number_of_arguments <> 1) then
                if (l_program_availability = 'TRUE') then
                    dbms_scheduler.disable(name => TASK_RUN_WRAPPER_PROGRAM_NAME, force => true);
                    l_program_availability := 'FALSE';
                end if;

                sys.dbms_scheduler.set_attribute(name => TASK_RUN_WRAPPER_PROGRAM_NAME,
                                                 attribute => 'number_of_arguments',
                                                 value => 1);
            end if;
        exception
            when no_data_found then
                 dbms_scheduler.create_program(program_name        => TASK_RUN_WRAPPER_PROGRAM_NAME,
                                               program_type        => 'STORED_PROCEDURE',
                                               program_action      => p_action,
                                               number_of_arguments => 1,
                                               enabled             => false,
                                               comments            => p_description);
                 l_program_availability := 'FALSE';
        end;

        dbms_scheduler.define_program_argument(program_name      => TASK_RUN_WRAPPER_PROGRAM_NAME,
                                               argument_position => 1,
                                               argument_name     => 'p_task_run_id',
                                               argument_type     => 'number');

        if (l_program_availability = 'FALSE') then
            sys.dbms_scheduler.enable(name => TASK_RUN_WRAPPER_PROGRAM_NAME);
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
                                           program_name => TASK_RUN_WRAPPER_PROGRAM_NAME,
                                           auto_drop    => false,
                                           comments     => p_description,
                                           enabled      => false);
        end;

        dbms_scheduler.set_attribute(name      => p_job_name,
                                     attribute => 'RAISE_EVENTS',
                                     value     => /*dbms_scheduler.JOB_SUCCEEDED + */dbms_scheduler.JOB_FAILED + dbms_scheduler.JOB_STOPPED);
    end;

    procedure finish_task_run(
        p_task_run_row in tms_task_run%rowtype,
        p_state_id in integer,
        p_details in clob)
    is
    begin
        log_message('tms_utl.finish_task_run',
                    'p_task_run_id : ' || p_task_run_row.id || chr(10) ||
                    'p_state_id    : ' || p_state_id || chr(10) ||
                    'p_details     : ' || dbms_lob.substr(p_details, 1000) || chr(10) ||
                    dbms_utility.format_call_stack());

        set_task_run_state(p_task_run_row.id, p_state_id, p_details);

        update tms_task_run t
        set    t.finish_time = sysdate
        where  t.id = p_task_run_row.id;

        -- dbms_lock.sleep(60);

        proceed_run(p_task_run_row.run_id);
    end;

    procedure start_task_run_wrapper(
        p_task_run_id in integer)
    is
        pragma autonomous_transaction;
        l_task_run_row tms_task_run%rowtype;
        l_task_row tms_task%rowtype;
        l_run_row tms_run%rowtype;
    begin
        log_message('tms_utl.start_task_run_wrapper', 'p_task_run_id : ' || p_task_run_id);

        l_task_run_row := read_task_run(p_task_run_id, p_lock => true);
        l_task_row := read_task(l_task_run_row.task_id);
        l_run_row := read_run(l_task_run_row.run_id);

       log_message('tms_utl.start_task_run_wrapper0', 'p_task_run_id : ' || p_task_run_id||'  l_run_row.user_id='|| l_run_row.user_id|| ', glbl_cntx.user_id='||sys_context('bars_global','user_id')  );

       bars_login.login_user(sys_guid(), l_run_row.user_id, null, null);
       gl.param;

       log_message('tms_utl.start_task_run_wrapper1', 'p_task_run_id : ' || p_task_run_id ||chr(10)|| 'gl.auid :'||gl.auid || ', glbl_cntx.user_id='||sys_context('bars_global','user_id') );
        
        -- встановлюється відділення, по якому працює регламентна процедура
        bars_context.go(l_task_run_row.branch);

        log_message('tms_utl.start_task_run_wrapper2', 'p_task_run_id : ' || p_task_run_id||chr(10)|| 'gl.auid :'||gl.auid);

        -- встановлюється банківська дата, що відповідає попередньому або наступному банківському дню
        gl.pl_dat(case when l_task_row.task_group_id = tms_utl.TASK_GROUP_AFTER_START then l_run_row.new_bank_date
                       else l_run_row.current_bank_date
                  end);

        -- заповнюємо контекст сесії ідентифікатором запуску для того щоб будь-яка процедура могла
        -- отримати додаткові відомості про середовище, в якому її запущено
        pul.set_mas_ini('RUN_ID', l_run_row.id, '');
        pul.set_mas_ini('TASK_RUN_ID', l_task_run_row.id, '');

        log_message('tms_utl.start_task_run_wrapper (execute statement)',
                    'p_task_run_id : ' || p_task_run_id || chr(10) ||
                    'statement_text : ' || l_task_row.task_statement || chr(10) ||
                    'sid            : ' || sys_context('userenv', 'sid') || chr(10) ||
                    'sessionid      : ' || sys_context('userenv', 'sessionid') || chr(10) ||
                    'ora_login_user : ' || ora_login_user());

        execute immediate l_task_row.task_statement;

        finish_task_run(l_task_run_row, tms_utl.TASK_RUN_STATE_FINISHED, null);

        update tms_task_run t
        set    t.finish_time = sysdate
        where  t.id = l_task_run_row.id;

        commit;
    exception
        when others then
             rollback;
             finish_task_run(l_task_run_row, tms_utl.TASK_RUN_STATE_FAILED, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             commit;
    end;

    
    ------------------------------------------
    -- START_TASK_RUN
    --   
    --
    procedure start_task_run(
        p_task_run_id in integer)
    is
        pragma autonomous_transaction;
        l_task_run_row tms_task_run%rowtype;
        l_job_was_created boolean default false;
    begin
        log_message('tms_utl.start_task_run', 'p_task_run_id : ' || p_task_run_id);

        l_task_run_row := read_task_run(p_task_run_id, p_lock => true);

        if (l_task_run_row.state_id = tms_utl.TASK_RUN_STATE_IN_PROGRESS) then
            commit;
            return;
        end if;

        ensure_wrapper_job(l_task_run_row.wrapper_job_name,
                           'Службовий контейнер для встановлення контексту сесії перед запуском регламентної процедури відкриття/закриття банківського дня');

        l_job_was_created := true;

        dbms_scheduler.set_job_argument_value(job_name       => l_task_run_row.wrapper_job_name,
                                              argument_name  => 'p_task_run_id',
                                              argument_value => l_task_run_row.id);

        set_task_run_state(l_task_run_row.id, tms_utl.TASK_RUN_STATE_IN_PROGRESS, null);

        update tms_task_run t
        set    t.start_time = sysdate
        where  t.id = l_task_run_row.id;

        dbms_scheduler.run_job(job_name => l_task_run_row.wrapper_job_name, use_current_session => false);

        commit;

    exception
        when others then
             rollback;

             finish_task_run(l_task_run_row,
                             tms_utl.TASK_RUN_STATE_FAILED,
                             sqlerrm || chr(10) || dbms_utility.format_error_backtrace());

             commit;

             if (l_job_was_created) then
                 dbms_scheduler.drop_job(l_task_run_row.wrapper_job_name, force => true);
             end if;

             log_message('tms_utl.start_task_run (exception)',
                         'p_task_run_id : ' || p_task_run_id || chr(10) ||
                         sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                         'ERROR');
    end;

    -------------------------------------------------------
    -- START_TASK
    --  p_run_id - номер запуска ВЗД из tms_run.id
    --
    --  Для каждой задачи из всего чписка tms_task, запустить джобы по всем бранчам (паралельно или последовательно) из запланированного списка к віполнеию из 
    --  tms_task_run  
    --

    procedure start_task(
        p_run_id in integer,
        p_task_row in tms_task%rowtype)
    is
        l_task_run_list number_list;
        l_next_task_id integer;
        l_tasks_in_progress_count integer;
        l integer;
    begin
        log_message('tms_utl.start_task',
                    'p_run_id  : ' || p_run_id || chr(10) ||
                    'p_task_id : ' || p_task_row.id);

        if (p_task_row.branch_processing_mode = tms_utl.BRANCH_PROC_MODE_PARALLEL_1 or p_task_row.branch_processing_mode = tms_utl.BRANCH_PROC_MODE_PARALLEL_2  ) then
            select tr.id
            bulk collect into l_task_run_list
            from   tms_task_run tr
            where  tr.run_id = p_run_id and
                   tr.task_id = p_task_row.id and
                   tr.state_id in (tms_utl.TASK_RUN_STATE_IDLE, tms_utl.TASK_RUN_STATE_TERMINATED);

            if (l_task_run_list is not empty) then
                l := l_task_run_list.first();
                while (l is not null) loop
                    start_task_run(l_task_run_list(l));
                    l := l_task_run_list.next(l);
                end loop;
            end if;
        else
            -- послідовна обробка відділень
            -- перевіряємо наявність запущеної задачі по іншому РУ, якщо така існує - пропускаємо ітерацію, чекаємо завершення процедури
            select sum(case when tr.state_id = tms_utl.TASK_RUN_STATE_IN_PROGRESS then 1 else 0 end),
                   min(case when tr.state_id in (tms_utl.TASK_RUN_STATE_IDLE, tms_utl.TASK_RUN_STATE_TERMINATED) then tr.id else null end)
            into   l_tasks_in_progress_count, l_next_task_id
            from   tms_task_run tr
            where  tr.run_id = p_run_id and
                   tr.task_id = p_task_row.id and
                   tr.state_id in (tms_utl.TASK_RUN_STATE_IN_PROGRESS, tms_utl.TASK_RUN_STATE_IDLE, tms_utl.TASK_RUN_STATE_TERMINATED);

            if (l_tasks_in_progress_count = 0) then
                if (l_next_task_id is not null) then
                    start_task_run(l_next_task_id);
                end if;
            end if;
        end if;
    end;

    procedure clear_task_run_jobs(
        p_run_id in integer)
    is
        pragma autonomous_transaction;
    begin
        bars_audit.log_info('tms_utl.clear_task_run_jobs',
                            'Завершеня роботи процесу зміни банківської дати з ідентифікатором ' || p_run_id,
                            p_make_context_snapshot => true);
        for i in (select *
                  from   tms_task_run t
                  join   user_scheduler_jobs j on j.job_name = t.wrapper_job_name
                  where  t.run_id = p_run_id) loop
            begin
                dbms_scheduler.drop_job(job_name => i.wrapper_job_name, force => false);
            exception
                when others then
                     log_message('tms_utl.clear_task_run_jobs',
                                 'job_name : ' || i.wrapper_job_name || chr(10) ||
                                 sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                                 'ERROR');
            end;
        end loop;
    end;

    procedure finish_run(
        p_run_id in integer)
    is
    begin
        set_run_state(p_run_id, tms_utl.RUN_STATE_FINISHED, null);

        clear_task_run_jobs(p_run_id);
    end;

    --------------------------------------------------
    --  PROCEED_RUN 
    --  p_run_id - код запуска ВЗД, поле tms_run.id
    --
    --  Пройтись по заполненному списку tms_task_run задач на выполнение (уже в разрезе бранчей и филиалов)
    --
    
    procedure proceed_run(
        p_run_id in integer)
    is
        type t_task_list is table of tms_task%rowtype;
        type t_branch_state_list is table of varchar2(4000 byte) index by varchar2(30 char);
        l_run_row tms_run%rowtype;
        l_min_idle_group_id integer;
        l_min_active_group_id integer;
        l_task_list t_task_list;
        l_branch_state_list t_branch_state_list;
        l_global_stop_flag boolean default false;
        l_global_blocking_task varchar2(4000 byte);
        l integer;
        l_performing_task_flag char(1 byte);
    begin
        l_run_row := read_run(p_run_id, p_lock => true);

        for i in (select * from tms_task t order by t.sequence_number) loop
            -- для всех заданий по всем бранчам из запланированого списка в tms_task_run для запуска ВЗД № p_run_id
            for j in (select * from tms_task_run t where t.task_id = i.id and t.run_id = l_run_row.id) loop
               

                if (j.state_id = tms_utl.TASK_RUN_STATE_IDLE and (l_global_stop_flag or l_branch_state_list.exists(j.branch))) then
                    set_task_run_state(j.id,
                                       tms_utl.TASK_RUN_STATE_WAIT_LEADING,
                                       'Очікує на виконання задачі: ' || coalesce(l_global_blocking_task, l_branch_state_list(j.branch)));
                elsif (j.state_id = tms_utl.TASK_RUN_STATE_WAIT_LEADING and not l_global_stop_flag and not l_branch_state_list.exists(j.branch)) then
                    set_task_run_state(j.id,
                                       tms_utl.TASK_RUN_STATE_IDLE,
                                       null);
                end if;

                if (j.state_id in (tms_utl.TASK_RUN_STATE_FAILED/*, tms_utl.TASK_RUN_STATE_DISABLED, tms_utl.TASK_RUN_STATE_TERMINATED*/) and
                    i.action_on_failure = tms_utl.ACTION_ON_FAILURE_INTERRUPT) then
                    if (j.branch = '/') then
                        l_global_stop_flag := true;
                        l_global_blocking_task := i.task_name;
                    else
                        if (not l_branch_state_list.exists(j.branch)) then
                            l_branch_state_list(j.branch) := i.task_name;
                        end if;
                    end if;
                elsif (j.state_id = tms_utl.TASK_RUN_STATE_FINISHED) then
                    if (j.branch = '/') then
                        l_global_stop_flag := false;
                    else
                        if (l_branch_state_list.exists(j.branch)) then
                            l_branch_state_list.delete(j.branch);
                        end if;
                    end if;
                end if;
            end loop;
        end loop;

        commit;

        -- отримуємо мінімальний порядковий номер для завдань, що очікують на виконання
        -- (завдання з порядковим номером null - виконуватимуться в останню чергу)
        select min(t.sequence_number)
        into   l_min_idle_group_id
        from   tms_task t
        where  t.id in (select tr.task_id
                        from   tms_task_run tr
                        where  tr.run_id = p_run_id and
                               tr.state_id in (tms_utl.TASK_RUN_STATE_IDLE, tms_utl.TASK_RUN_STATE_TERMINATED));

        log_message('tms_utl.proceed_run', 'p_run_id : ' || p_run_id || chr(10) || 'l_min_idle_group_id : ' || l_min_idle_group_id);

        select min(t.sequence_number)
        into   l_min_active_group_id
        from   tms_task t
        where  t.id in (select tr.task_id
                        from   tms_task_run tr
                        where  tr.run_id = p_run_id and
                               tr.state_id in (tms_utl.TASK_RUN_STATE_IN_PROGRESS));

        log_message('tms_utl.proceed_run', 'p_run_id : ' || p_run_id || chr(10) || 'l_min_active_group_id : ' || l_min_active_group_id);

        select t.*
        bulk collect into l_task_list
        from   tms_task t
        where  t.state_id = tms_utl.TASK_STATE_ACTIVE and
               (t.sequence_number = l_min_idle_group_id or
                (t.sequence_number is null and l_min_idle_group_id is null)) and
               (l_min_active_group_id is null or l_min_active_group_id = l_min_idle_group_id);

        -- по каждой задаче из списка tms_task, у которых одинвковый sequence_number(т.е. выполняются паралельно)
        if (l_task_list is not empty) then
            l := l_task_list.first;
            while (l is not null) loop
                start_task(p_run_id, l_task_list(l));
                l := l_task_list.next(l);
            end loop;
        end if;

        select nvl(min('Y'), 'N')
        into   l_performing_task_flag
        from   tms_task_run t
        where  t.run_id = p_run_id and
               t.state_id not in (tms_utl.TASK_RUN_STATE_FAILED, tms_utl.TASK_RUN_STATE_FINISHED,
                                  tms_utl.TASK_RUN_STATE_DISABLED, tms_utl.TASK_RUN_STATE_TERMINATED,
                                  tms_utl.TASK_RUN_STATE_SKIP);

        if (l_performing_task_flag = 'N') then
            finish_run(p_run_id);
        end if;
    end;

    procedure start_run(
        p_run_id in integer)
    is
        l_run_row tms_run%rowtype;
    begin
        ensure_wrapper_program('bars.tms_utl.start_task_run_wrapper',
                               'Службовий контейнер для встановлення контексту сесії перед запуском регламентної процедури відкриття/закриття банківського дня');

        l_run_row := read_run(p_run_id, p_lock => true);

        if (l_run_row.state_id = tms_utl.RUN_STATE_IN_PROGRESS) then
            raise_application_error(-20000, 'Процедура зміни банківського дня {' ||
                                            to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' - ' ||
                                            to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') || '} вже запущена');
        end if;

        if (l_run_row.state_id in (tms_utl.RUN_STATE_FINISHED, tms_utl.RUN_STATE_HAS_ERRORS)) then
            raise_application_error(-20000, 'Процедура зміни банківського дня {' ||
                                            to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' - ' ||
                                            to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') || '} вже завершена');
        end if;

        bind_branch_stages_to_run(p_run_id);

        set_run_state(l_run_row.id, tms_utl.RUN_STATE_IN_PROGRESS, null);

        proceed_run(p_run_id);
    end;

    procedure job_event_handler(
        context  in raw,
        reginfo  in sys.aq$_reg_info,
        descr    in sys.aq$_descriptor,
        payload  in raw,
        payloadl in number)
    as
        dequeue_options    dbms_aq.dequeue_options_t;
        message_properties dbms_aq.message_properties_t;
        message_handle     raw(16);
        message            sys.scheduler$_event_info;

        l_task_run_row     tms_task_run%rowtype;
        l_run_row          tms_run%rowtype;
    begin
        log_message('tms_utl.job_event_handler',
                    'descr.msg_id        : ' || descr.msg_id || chr(10) ||
                    'descr.consumer_name : ' || descr.consumer_name || chr(10) ||
                    'ora_user_name       : ' || ora_login_user());

        dequeue_options.msgid := descr.msg_id;
        dequeue_options.consumer_name := descr.consumer_name;
        dequeue_options.dequeue_mode := dbms_aq.BROWSE;
        dequeue_options.visibility := dbms_aq.IMMEDIATE;

        dbms_aq.dequeue(queue_name         => descr.queue_name,
                        dequeue_options    => dequeue_options,
                        message_properties => message_properties,
                        payload            => message,
                        msgid              => message_handle);

        log_message('tms_utl.job_event_handler (message_dequeued)',
                    'message.object_name : ' || message.object_name || chr(10) ||
                    'message.event_type  : ' || message.event_type || chr(10) ||
                    'message.error_msg   : ' || message.error_msg || chr(10) ||
                    'ora_user_name       : ' || ora_login_user());

        begin
            select *
            into   l_task_run_row
            from   tms_task_run tr
            where  tr.wrapper_job_name = message.object_name
            for update;
        exception
            when no_data_found then
                 return;
        end;

        case (message.event_type)
/*        when 'JOB_SUCCEEDED' then
             finish_task_run(l_task_run_row, tms_utl.TASK_RUN_STATE_FINISHED, null);
*/        when 'JOB_FAILED' then
               l_run_row := read_run(l_task_run_row.run_id);
               bars_login.login_user(sys_guid(), l_run_row.user_id, null, null);
               finish_task_run(l_task_run_row, tms_utl.TASK_RUN_STATE_FAILED, message.error_msg);
               bars_login.logout_user();
        when 'JOB_STOPPED' then
               l_run_row := read_run(l_task_run_row.run_id);
               bars_login.login_user(sys_guid(), l_run_row.user_id, null, null);
               finish_task_run(l_task_run_row, tms_utl.TASK_RUN_STATE_FAILED, message.error_msg);
               bars_login.logout_user();
        end case;

        dequeue_options.dequeue_mode := dbms_aq.remove;

        dbms_aq.dequeue(queue_name         => descr.queue_name,
                        dequeue_options    => dequeue_options,
                        message_properties => message_properties,
                        payload            => message,
                        msgid              => message_handle);
    exception
        when others then
             log_message('tms_utl.job_event_handler (exception)',
                         sqlerrm || chr(10) || dbms_utility.format_error_backtrace(),
                         'ERROR');
             raise;
    end;

    procedure CLOSE_USER_SESSIONS
    ( p_kf     in     varchar2
    , p_bnk_dt in     varchar2
    ) is
    begin

      DBMS_MVIEW.REFRESH('MV_GLOBAL_CONTEXT');

      for u in ( select CLIENT_IDENTIFIER
                   from MV_GLOBAL_CONTEXT
                  where CURRENT_BRANCH like '/'||p_kf||'/%'
                    and CURRENT_BANK_DATE <> p_bnk_dt )
      loop
        BARS_LOGIN.CLEAR_SESSION( u.CLIENT_IDENTIFIER );
      end loop;

    end CLOSE_USER_SESSIONS;

    procedure CLOSES_ACCESS
    ( p_kf    in     fdat_kf.kf%type
    ) is
      l_bnk_dt varchar2(10);
    begin

      bars_audit.info( $$PLSQL_UNIT||'.CLOSES_ACCESS: ( kf='||p_kf||' ).' );
	  DBMS_APPLICATION_INFO.SET_ACTION( 'TMS_UTL.CLOSES_ACCESS' );
      -- set ban on logging in
      begin
        insert
          into FDAT_KF ( KF )
        values ( p_kf );
      exception
        when DUP_VAL_ON_INDEX then
          null;
      end;

      l_bnk_dt := BRANCH_ATTRIBUTE_UTL.GET_VALUE('BANKDATE');

      -- close all user sessions that logged in with previous bank date
      CLOSE_USER_SESSIONS( p_kf, l_bnk_dt );
	  DBMS_APPLICATION_INFO.set_action(null);
      -- accumulate a balance snapshot
      -- BARS_CONTEXT.SUBST_MFO( p_kf );
      -- DDRAPS( DAT_NEXT_U( to_date(l_bnk_dt,'MM/DD/YYYY'), -1 ) );
      -- BARS_CONTEXT.SET_CONTEXT;

    end CLOSES_ACCESS;

    procedure OPEN_ACCESS
    ( p_kf    in     fdat_kf.kf%type
    ) is
    begin
      
      bars_audit.info( $$PLSQL_UNIT||'.OPEN_ACCESS: ( kf='||p_kf||' ).' );
      
      delete FDAT_KF
       where KF = p_kf;

    end OPEN_ACCESS;

    procedure SET_BANK_DATE_ACCESS
    ( p_kf     in fdat_kf.kf%type
    , p_closed in integer
    ) is
    begin
      if ( p_closed = 1 )
      then
        CLOSES_ACCESS( p_kf );
      else
        OPEN_ACCESS( p_kf );
      end if;

    end SET_BANK_DATE_ACCESS;

    --
    --
    --
    function CHECK_ACCESS
    ( p_kf    in     fdat_kf.kf%type
    ) return integer
    --result_cache relies_on ( FDAT_KF )
    is
      l_access       number(1);
      l_kf           fdat_kf.kf%type;
    begin

      if ( p_kf Is Null )
      then
        l_kf := sys_context('bars_context','user_mfo');
      else
        l_kf := p_kf;
      end if;
	  
	  if ( sys_context('USERENV','ACTION') = 'TMS_UTL.CLOSES_ACCESS' ) then
        return 1;
      end if;
	  
      begin
        select 0
          into l_access
          from FDAT_KF
         where KF = l_kf;
      exception
        when NO_DATA_FOUND then
          l_access := 1;
      end;

      return l_access;

    end CHECK_ACCESS;

    procedure SET_BANK_DATE_STATE
    ( p_fdat  in date
    , p_stat  in integer
    ) is
    begin

      bars_audit.info( $$PLSQL_UNIT||'.SET_BANK_DATE_STATE: ( p_fdat='||to_char(p_fdat,'dd.mm.yyyy')||', p_stat='||to_char(p_stat)||' ).' );

      update FDAT
         set STAT    = case p_stat when 1 then 9 else 0 end
           , CHGDATE = sysdate
       where FDAT    = p_fdat;

    end SET_BANK_DATE_STATE;

    function GET_BANKDATE_STATE
    ( p_fdat   in date
    ) return integer
    result_cache
    is
      l_state     fdat.stat%type;
    begin

      begin
        select case STAT when 9 then 1 else 0 end
          into l_state
          from FDAT
         where FDAT = p_fdat;
      exception
        when NO_DATA_FOUND then
          l_state := 1;
      end;

      return l_state;

    end GET_BANKDATE_STATE;

        procedure switch_bank_date
    is
       l_run_id integer;
       l_run_row tms_run%rowtype;
    begin
        log_message('tms_utl.switch_bank_date',
                    'gl.auid           : ' || gl.auid || chr(10) ||
                    'sid               : ' || sys_context('userenv', 'sid') || chr(10) ||
                    'sessionid         : ' || sys_context('userenv', 'sessionid') || chr(10) ||
                    'ora_login_user    : ' || ora_login_user || chr(10) ||
                    'run_id            : ' || pul.get_mas_ini_val('RUN_ID'));

        l_run_id := pul.get_mas_ini_val('RUN_ID');
        l_run_row := read_run(l_run_id);

        bars_context.reload_context();
        bars_notifier_send(l_run_row.current_bank_date, 'CLOSED');

        branch_attribute_utl.set_attribute_value('/', 'BANKDATE', to_char(l_run_row.new_bank_date, 'mm/dd/yyyy'));
        branch_attribute_utl.set_attribute_value('/', 'RRPDAY', '1');


       log_message('tms_utl.switch_bank_date2',
                    'gl.auid           : ' || gl.auid || chr(10) ||
                    'sid               : ' || sys_context('userenv', 'sid') || chr(10) ||
                    'sessionid         : ' || sys_context('userenv', 'sessionid') || chr(10) ||
                    'ora_login_user    : ' || ora_login_user || chr(10) ||
                    'run_id            : ' || pul.get_mas_ini_val('RUN_ID'));

        merge into fdat a
        using dual
        on (a.fdat = l_run_row.new_bank_date)
        when matched then update
             set a.stat = 0,
                 a.chgdate = sysdate
        when not matched then insert
             values (l_run_row.new_bank_date, 0, sysdate);

        -- заимствовано из триггера ti_fdat_accm
        -- Внесение в очередь для синхронизации накопительных таблиц
        -- bars_accm_sync.enqueue_fdat(l_run_row.new_bank_date);

        -- Remove of the ban on logging in
        delete FDAT_KF;

        begin
            execute immediate 'begin bars.bars_login.login_user@crnv.grc.ua(null, null, null, null); end;';
            execute immediate 'begin bars.set_external_bankdate@crnv.grc.ua(:new_bank_date); end;' using to_char(l_run_row.new_bank_date, 'mm/dd/yyyy');
        exception
            when others then
                 bars_audit.log_error('tms_utl.switch_bank_date (exception)', sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
        end;

        begin
            execute immediate 'begin bars.bars_login.login_user@barsval.grc.ua(null, null, null, null); end;';
            execute immediate 'begin set_external_bankdate@barsval.grc.ua(:new_bank_date); end;' using to_char(l_run_row.new_bank_date, 'mm/dd/yyyy');
        exception
            when others then
                 bars_audit.log_error('tms_utl.switch_bank_date (exception)', sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
        end;

 
         log_message('tms_utl.switch_bank_date3',
                    'gl.auid           : ' || gl.auid || chr(10) ||
                    'sid               : ' || sys_context('userenv', 'sid') || chr(10) ||
                    'sessionid         : ' || sys_context('userenv', 'sessionid') || chr(10) ||
                    'ora_login_user    : ' || ora_login_user || chr(10) ||
                    'run_id            : ' || pul.get_mas_ini_val('RUN_ID'));
        bars_context.reload_context();

         log_message('tms_utl.switch_bank_date4',
                    'gl.auid           : ' || gl.auid || chr(10) ||
                    'sid               : ' || sys_context('userenv', 'sid') || chr(10) ||
                    'sessionid         : ' || sys_context('userenv', 'sessionid') || chr(10) ||
                    'ora_login_user    : ' || ora_login_user || chr(10) ||
                    'run_id            : ' || pul.get_mas_ini_val('RUN_ID'));


        bars_notifier_send(l_run_row.new_bank_date, 'OPENED');
    end;

    procedure disable_task_run(
        p_task_run_id in integer)
    is
        l_task_run_row tms_task_run%rowtype;
        l_run_row tms_run%rowtype;
    begin
        l_task_run_row := read_task_run(p_task_run_id);
        l_run_row := read_run(l_task_run_row.run_id, p_lock => true);

        if (l_task_run_row.state_id not in (tms_utl.TASK_RUN_STATE_IDLE)) then
            raise_application_error(-20000, 'Задача {' || get_task_name(l_task_run_row.task_id) ||
                                            '} перебуває в статусі {' || list_utl.get_item_name(tms_utl.LT_TASK_RUN_STATE, l_task_run_row.state_id) ||
                                            '} і не може бути відмінена');
        else
            if (l_run_row.state_id = tms_utl.RUN_STATE_IDLE) then
                raise_application_error(-20000, 'Перехід банківської дати з ' || to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' в ' ||
                                                                                 to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                                ' не запущений - зміна статусів процедур, що входять до його складу, заборонена');
            elsif (l_run_row.state_id in (tms_utl.RUN_STATE_FINISHED, tms_utl.RUN_STATE_HAS_ERRORS)) then
                raise_application_error(-20000, 'Перехід банківської дати з ' || to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' в ' ||
                                                                                 to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                                ' завершений - зміна статусів процедур, що входять до його складу, заборонена');
            end if;

            set_task_run_state(p_task_run_id, tms_utl.TASK_RUN_STATE_DISABLED, null);
        end if;
    end;

    procedure run_task_run(
        p_task_run_id in integer)
    is
        l_task_run_row tms_task_run%rowtype;
        l_run_row tms_run%rowtype;
    begin
        l_task_run_row := read_task_run(p_task_run_id);

        if (l_task_run_row.state_id in (tms_utl.TASK_RUN_STATE_IN_PROGRESS)) then
            return;
        else
            l_run_row := read_run(l_task_run_row.run_id, p_lock => true);
            if (l_run_row.state_id = tms_utl.RUN_STATE_IDLE) then
                raise_application_error(-20000, 'Перехід банківської дати з ' || to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' в ' ||
                                                                                 to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                                ' не запущений - зміна статусів процедур, що входять до його складу, заборонена');
            /*elsif (l_run_row.state_id in (tms_utl.RUN_STATE_FINISHED, tms_utl.RUN_STATE_HAS_ERRORS)) then
                raise_application_error(-20000, 'Перехід банківської дати з ' || to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' в ' ||
                                                                                 to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                                ' завершений - зміна статусів процедур, що входять до його складу, заборонена');
            */end if;

            log_message('tms_utl.run_task_run', 'p_task_run_id : ' || p_task_run_id);

            start_task_run(p_task_run_id);

        end if;
    end;

    procedure terminate_task_run(
        p_task_run_id in integer)
    is
        l_task_run_row tms_task_run%rowtype;
        l_run_row tms_run%rowtype;
    begin
        l_task_run_row := read_task_run(p_task_run_id);
        l_run_row := read_run(l_task_run_row.run_id, p_lock => true);
        if (l_task_run_row.state_id = tms_utl.TASK_RUN_STATE_IN_PROGRESS) then
            l_run_row := read_run(l_task_run_row.run_id, p_lock => true);
            if (l_run_row.state_id = tms_utl.RUN_STATE_IDLE) then
                raise_application_error(-20000, 'Перехід банківської дати з ' || to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' в ' ||
                                                                                 to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                                ' не запущений - зміна статусів процедур, що входять до його складу, заборонена');
            /*elsif (l_run_row.state_id in (tms_utl.RUN_STATE_FINISHED, tms_utl.RUN_STATE_HAS_ERRORS)) then
                raise_application_error(-20000, 'Перехід банківської дати з ' || to_char(l_run_row.current_bank_date, 'dd.mm.yyyy') || ' в ' ||
                                                                                 to_char(l_run_row.new_bank_date, 'dd.mm.yyyy') ||
                                                ' завершений - зміна статусів процедур, що входять до його складу, заборонена');*/
            end if;

            -- dbms_scheduler.stop_job(job_name => l_task_run_row.wrapper_job_name, force => true);
            set_task_run_state(p_task_run_id, tms_utl.TASK_RUN_STATE_TERMINATED, null);
        else
            raise_application_error(-20000, 'Процедура знаходиться в стані {' || list_utl.get_item_name(tms_utl.LT_TASK_RUN_STATE, l_task_run_row.state_id) ||
                                            '} - зупинити її виконання не можливо');
        end if;
    end;

end TMS_UTL;
/
show err;
 
PROMPT *** Create  grants  TMS_UTL ***
grant EXECUTE                                                                on TMS_UTL         to BARS_ACCESS_DEFROLE;

 
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/tms_utl.sql =========*** End *** ===
PROMPT ===================================================================================== 