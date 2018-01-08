 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/gl_ui.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.GL_UI is

    g_type_message_dialog constant varchar2(100) :='DIALOG'; -- OK CANCEL
    g_type_message_info constant varchar2(100) :='INFO';     --OK
    g_type_message_error constant varchar2(100) :='ERROR';   --CLOSE

    function get_current_bank_date
    return date;

    function get_next_bank_date
    return date;

    procedure open_bank_date(
        p_next_bank_date in date);

    procedure close_bank_date;

    function deploy_run(
        p_next_date in date)
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

    procedure start_run(
        p_run_id in integer);

    procedure start_task_run(
        p_task_run_id in integer);

    procedure disable_task_run(
        p_task_run_id in integer);

    procedure terminate_task_run(
        p_task_run_id in integer);

    procedure repeat_task_run(
        p_task_run_id in integer);

    function get_all_branch_stages
    return sys_refcursor;

    function get_branch_stages
    return sys_refcursor;

    function get_task_list(
        p_run_id in integer)
    return sys_refcursor;

    function get_task_branch_list(
        p_run_id in integer,
        p_task_id in integer)
    return sys_refcursor;

    procedure get_task_monitor(
        p_run_id in integer,
        p_current_date out date,
        p_new_date out date,
        p_run_state_id out integer,
        p_run_state_name out varchar2,
        p_task_data out sys_refcursor);

    function get_branch_stage_directory
    return sys_refcursor;

    procedure set_branch_stage(
        p_branch_code in varchar2,
        p_stage_id in integer);

    function get_task_run_report_data(
        p_task_run_id in integer)
    return clob;

    function get_task_run_button_flags(
        p_task_run_id in integer,
        p_task_run_state_id in integer,
        p_run_state_id in integer,
        p_run_current_date in date,
        p_run_new_date in date)
    return number_list;

    procedure doc_input_validation(
        p_dictionary_main in t_dictionary,
        p_dictionary in out  t_dictionary,
        p_message out varchar2,
        p_type_message out varchar2);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.GL_UI as

    function get_current_bank_date_utl
    return date
    is
    begin
        return to_date(branch_attribute_utl.get_value('/', 'BANKDATE'), 'mm/dd/yyyy');
    end;

    procedure check_if_date_already_closed(
        p_date in date)
    is
        l_date_state integer;
    begin
        select t.stat
        into   l_date_state
        from   fdat t
        where  t.fdat = p_date;

        if (l_date_state = 9) then
            raise_application_error(-20000, 'Банківський день {' || to_char(p_date, 'dd.mm.yyyy') || '} вже закритий - повторне відкриття банківського дня заборонено');
        end if;
    exception
        when no_data_found then
             null;
    end;

    procedure fill_fdat(
        p_bank_date in date)
    is
    begin
        insert into fdat (fdat, stat)
        select p_bank_date, 0
        from   dual
        where not exists (select 1
                          from   fdat f
                          where  f.fdat = p_bank_date);
    end;

    function get_current_bank_date
    return date
    is
    begin
        if (getglobaloption('RRPDAY') = '1') then
            return get_current_bank_date_utl();
        else
            return null;
        end if;
    end;

    function get_next_bank_date
    return date
    is
        l_bankdate date;
    begin
        l_bankdate := get_current_bank_date_utl();
        /*if (getglobaloption('RRPDAY') = '1') then
            return l_bankdate;
        else*/
            return dat_next_u(l_bankdate, 1);
        --end if;
    end;

    procedure open_bank_date(
        p_next_bank_date in date)
    is
        l_bankdate date;
    begin
        if (getglobaloption('RRPDAY') = '1') then
            l_bankdate := get_current_bank_date_utl();
            if (l_bankdate = p_next_bank_date) then
                raise_application_error(-20000, 'Поточний банківський {' || l_bankdate ||
                                                '} день не закритий - відкриття нового банківського дня заборонено');
            end if;
        else
            check_if_date_already_closed(p_next_bank_date);

            branch_attribute_utl.set_attribute_value('/', 'BANKDATE', to_char(p_next_bank_date, 'mm/dd/yyyy'));
            branch_attribute_utl.set_attribute_value('/', 'RRPDAY', '1');

            fill_fdat(p_next_bank_date);

            bars_context.reload_context();
            bars_notifier_send(p_next_bank_date, 'OPENED');
        end if;
    end;

    procedure close_bank_date
    is
    begin
        if (getglobaloption('RRPDAY') = '1') then
            branch_attribute_utl.set_attribute_value('/', 'RRPDAY', '0');

            bars_context.reload_context();
            bars_notifier_send(get_current_bank_date_utl(), 'CLOSED');
        else
            raise_application_error(-20000, 'Банківський день не відкритий - закриття дня заборонено');
        end if;
    end;

    function get_all_branch_stages
    return sys_refcursor
    is
        l_cursor sys_refcursor;
    begin
        open l_cursor for
        select b.branch,
               b.name branch_name,
               list_utl.get_item_name(tms_utl.LT_BRANCH_STAGE, nvl(s.stage_id, tms_utl.STAGE_OPERATIONAL)) stage_name,
               case when s.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED then s.sys_time else null end stage_time,
               case when s.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED then user_utl.get_user_name(s.user_id) else null end stage_user,
               case when s.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED then 1 else 0 end is_ready
        from   branch b
        left join tms_branch_stage s on s.branch = b.branch and
                                        s.run_id is null
        where  regexp_like(b.branch, '^/\d{6}/$') and
               b.date_closed is null
        order by b.name;

        return l_cursor;
    end;

    function get_branch_stages
    return sys_refcursor
    is
        l_cursor sys_refcursor;
    begin
        open l_cursor for
        select b.branch,
               b.name branch_name,
               list_utl.get_item_name(tms_utl.LT_BRANCH_STAGE, nvl(s.stage_id, tms_utl.STAGE_OPERATIONAL)) stage_name,
               case when s.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED then s.sys_time else null end stage_time,
               case when s.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED then user_utl.get_user_name(s.user_id) else null end stage_user,
               case when s.stage_id = tms_utl.STAGE_ACTIVITY_ACCOMPLISHED then 1 else 0 end is_ready
        from   branch b
        left join tms_branch_stage s on s.branch = b.branch and
                                        s.run_id is null
        where  regexp_like(b.branch, '^/\d{6}/$') and
               b.branch like sys_context('bars_context', 'user_branch_mask') and
               b.date_closed is null
        order by b.name;

        return l_cursor;
    end;

    function deploy_run(
        p_next_date in date)
    return integer
    is
    begin
        return tms_utl.deploy_task_run(p_next_date);
    end;

    procedure set_new_bank_date(
        p_run_id in integer,
        p_new_bank_date in date)
    is
    begin
        tms_utl.set_new_bank_date(p_run_id, p_new_bank_date);
    end;

    procedure enable_task_for_run(
        p_run_id in integer,
        p_task_id in integer)
    is
    begin
        bars_audit.info('gl_ui.enable_task_for_run' || chr(10) ||
                        'p_run_id  : ' || p_run_id || chr(10) ||
                        'p_task_id : ' || p_task_id);

        tms_utl.enable_task_for_run(p_run_id, p_task_id);
    end;

    procedure disable_task_for_run(
        p_run_id in integer,
        p_task_id in integer)
    is
    begin
        tms_utl.disable_task_for_run(p_run_id, p_task_id);
    end;

    procedure enable_task_for_branch(
        p_task_run_id in integer)
    is
    begin
        tms_utl.enable_task_for_branch(p_task_run_id);
    end;

    procedure disable_task_for_branch(
        p_task_run_id in integer)
    is
    begin
        tms_utl.disable_task_for_branch(p_task_run_id);
    end;

    procedure start_run(
        p_run_id in integer)
    is
    begin
        tms_utl.start_run(p_run_id);
    end;

    procedure start_task_run(
        p_task_run_id in integer)
    is
    begin
        bars_audit.info('gl_ui.start_task_run' || chr(10) || 'p_task_run_id : ' || p_task_run_id);
        tms_utl.run_task_run(p_task_run_id);
    end;

    procedure disable_task_run(
        p_task_run_id in integer)
    is
    begin
        bars_audit.info('gl_ui.disable_task_run' || chr(10) || 'p_task_run_id : ' || p_task_run_id);
        tms_utl.disable_task_run(p_task_run_id);
    end;

    procedure terminate_task_run(
        p_task_run_id in integer)
    is
    begin
        bars_audit.info('gl_ui.terminate_task_run' || chr(10) || 'p_task_run_id : ' || p_task_run_id);
        tms_utl.terminate_task_run(p_task_run_id);
    end;

    procedure repeat_task_run(
        p_task_run_id in integer)
    is
    begin
        bars_audit.info('gl_ui.repeat_task_run' || chr(10) || 'p_task_run_id : ' || p_task_run_id);
        tms_utl.run_task_run(p_task_run_id);
    end;

    function get_task_list(
        p_run_id in integer)
    return sys_refcursor
    is
        l_cursor sys_refcursor;
    begin
        open l_cursor for
        select d.task_id,
               t.sequence_number,
               t.task_name,
               case when d.enabled_task_count = 0 then 0
                    else 1
               end is_on,
               case when t.branch_processing_mode = tms_utl.BRANCH_PROC_MODE_WHOLE_BANK then 0 else 1 end show_branches
        from   (select tr.task_id,
                       sum(case when tr.state_id in (tms_utl.TASK_RUN_STATE_DISABLED, tms_utl.TASK_RUN_STATE_SKIP) then 0 else 1 end) enabled_task_count,
                       sum(case when tr.state_id in (tms_utl.TASK_RUN_STATE_DISABLED, tms_utl.TASK_RUN_STATE_SKIP) then 1 else 0 end) disabled_task_count
                from   tms_task_run tr
                where  tr.run_id = p_run_id
                group by tr.task_id) d
        join tms_task t on t.id = d.task_id
        order by t.sequence_number, t.task_name;

        return l_cursor;
    end;

    function get_task_branch_list(
        p_run_id in integer,
        p_task_id in integer)
    return sys_refcursor
    is
        l_cursor sys_refcursor;
    begin
        open l_cursor for
        select tr.id task_run_id,
               tr.branch branch_code,
               b.name branch_name,
               case when tr.state_id in (tms_utl.TASK_RUN_STATE_DISABLED, tms_utl.TASK_RUN_STATE_SKIP) then 0
                    else 1
               end is_on,
               list_utl.get_item_name(tms_utl.LT_TASK_RUN_STATE, tr.state_id) task_run_state
        from   tms_task_run tr
        join   branch b on b.branch = tr.branch
        where  tr.run_id = p_run_id and
               tr.task_id = p_task_id
        order by tr.branch;

        return l_cursor;
    end;

    function get_task_run_report_data(
        p_task_run_id in integer)
    return clob
    is
        l_task_run_row tms_task_run%rowtype;
        l_report_data clob;
    begin
        l_task_run_row := tms_utl.read_task_run(p_task_run_id);

        select tt.details
        into   l_report_data
        from   tms_task_run_tracking tt
        where  tt.rowid = (select min(t.rowid) keep (dense_rank last order by t.id)
                           from   tms_task_run_tracking t
                           where  t.task_run_id = l_task_run_row.id and
                                  t.state_id = l_task_run_row.state_id);

        return l_report_data;
    end;

    function get_task_run_button_flags(
        p_task_run_id in integer,
        p_task_run_state_id in integer,
        p_run_state_id in integer,
        p_run_current_date in date,
        p_run_new_date in date)
    return number_list
    is
        l_button_flags number_list := number_list(0, 0, 0, 0, 0);
        l_current_bank_date date;
        l_report_data clob;
    begin
        l_current_bank_date := get_current_bank_date_utl();

        -- Переглянути деталі
        begin
            select tt.details
            into   l_report_data
            from   tms_task_run_tracking tt
            where  tt.rowid = (select min(t.rowid) keep (dense_rank last order by t.id)
                               from   tms_task_run_tracking t
                               where  t.task_run_id = p_task_run_id and
                                      t.state_id = p_task_run_state_id);

            l_button_flags(1) := case when l_report_data is null or dbms_lob.getlength(l_report_data) = 0 then 0 else 1 end;
        exception
            when no_data_found then
                 null;
        end;

        -- Виконати зараз
        if (p_task_run_state_id in (tms_utl.TASK_RUN_STATE_IDLE, tms_utl.TASK_RUN_STATE_DISABLED,
                                    tms_utl.TASK_RUN_STATE_SKIP, tms_utl.TASK_RUN_STATE_WAIT_LEADING) and
            (p_run_state_id in (tms_utl.RUN_STATE_IN_PROGRESS) or l_current_bank_date in (p_run_current_date, p_run_new_date))) then
            l_button_flags(2) := 1;
        end if;

        -- Перервати виконання
        if (p_task_run_state_id in (tms_utl.TASK_RUN_STATE_IN_PROGRESS)) then
            l_button_flags(3) := 1;
        end if;

        -- Відмінити виконання
        if (p_task_run_state_id in (tms_utl.TASK_RUN_STATE_IDLE, tms_utl.TASK_RUN_STATE_WAIT_LEADING,
                                    tms_utl.TASK_RUN_STATE_TERMINATED) and
            p_run_state_id in (tms_utl.RUN_STATE_IN_PROGRESS)) then
            l_button_flags(4) := 1;
        end if;

        -- Повторити виконання
        if (p_task_run_state_id in (tms_utl.TASK_RUN_STATE_FAILED, tms_utl.TASK_RUN_STATE_FINISHED,
                                    tms_utl.TASK_RUN_STATE_WAIT_LEADING, tms_utl.TASK_RUN_STATE_TERMINATED) and
            (p_run_state_id in (tms_utl.RUN_STATE_IN_PROGRESS) or l_current_bank_date in (p_run_current_date, p_run_new_date))) then
            l_button_flags(5) := 1;
        end if;

        return l_button_flags;
    end;

    procedure get_task_monitor(
        p_run_id in integer,
        p_current_date out date,
        p_new_date out date,
        p_run_state_id out integer,
        p_run_state_name out varchar2,
        p_task_data out sys_refcursor)
    is
        l_run_row tms_run%rowtype;
    begin
        l_run_row := tms_utl.read_run(p_run_id);

        p_current_date := l_run_row.current_bank_date;
        p_new_date := l_run_row.new_bank_date;
        p_run_state_id := l_run_row.state_id;
        p_run_state_name := list_utl.get_item_name(tms_utl.LT_RUN_STATE, l_run_row.state_id);

        open p_task_data for
        select tr.id,
               t.sequence_number,
               t.task_name,
               tr.branch branch_code,
               case when tr.branch = '/' then 'Весь банк' else b.name end branch_name,
               tr.start_time,
               tr.finish_time,
               list_utl.get_item_name(tms_utl.LT_TASK_RUN_STATE, tr.state_id) task_run_state,
               get_task_run_button_flags(tr.id, tr.state_id, r.state_id, r.current_bank_date, r.new_bank_date) button_flags
        from   tms_task_run tr
        join   tms_task t on t.id = tr.task_id
        join   tms_run r on r.id = tr.run_id
        join   branch b on b.branch = tr.branch
        where  tr.run_id = p_run_id
        order by t.sequence_number, t.task_name;
    end;

    function get_branch_stage_directory
    return sys_refcursor
    is
        l_cursor sys_refcursor;
    begin
        open l_cursor for
        select li.list_item_id,
               li.list_item_name
        from   list_item li
        where  li.list_type_id = list_utl.get_list_id(tms_utl.LT_BRANCH_STAGE);

        return l_cursor;
    end;

    procedure set_branch_stage(
        p_branch_code in varchar2,
        p_stage_id in integer)
    is
    begin
        tms_utl.set_branch_stage(p_branch_code, p_stage_id);
    end;

    function validate_d9#70(p_value operw.value%type) return number is
      l_flag number;
    begin
      begin
        select case
                 when p_value in (select b010 from cim_risk_bank) then
                  1
                 else
                  0
               end as n
          into l_flag
          from dual;
      exception
        when no_data_found then
          l_flag := 0;
      end;
      return l_flag;
    end validate_d9#70;

    procedure validate_Kod_BGN (p_tt             in oper.tt%type,
                                p_ca             in number,
                                p_kod_b          in bopbank.regnum%type,
                                p_kod_g          in bopcount.kodc%type,
                                p_kod_n          in bopcode.transcode%type,
                                p_message        out varchar2,
                                p_type_message   out varchar2
                                )
      as
        l_query       varchar2(1000);
        l_result      number;

        function create_sql(p_query in varchar2,
                             p_kod_b in varchar2,
                             p_kod_g in varchar2,
                             p_kod_n in varchar2)
                            return varchar2
        is
        begin
         return  replace(replace(replace(p_query,':l_Kod_B',nvl(p_kod_b,'null')),':l_Kod_G',nvl(p_kod_g,'null')),':l_Kod_N',nvl(p_kod_n,'null')) ;
        end;

      begin
        for cur in (select PV.TAG, PV.CASE sCASE, PV.DESCRIPTION from PARAMS_VALIDATION PV where pv.tt=p_tt and pv.is_ca=p_ca and pv.tag in ('KOD_B','KOD_G','KOD_N'))
        loop
          logger.info('dict:: loop');
          if cur.scase is not null  and p_type_message is null then ---необходима валидация и еще не было ошибки
            l_query:='select 1 from dual where '||cur.scase;
            l_query:= create_sql(l_query,p_kod_b,p_kod_g,p_kod_n);
            l_result:=0;
             if cur.TAG = 'KOD_B' then
               logger.info('dict:: KOD_B' || l_query);
               begin
               execute immediate l_query
               into l_result;
               exception when no_data_found then
                 p_message       :=cur.description|| '  (Не виконана умова по "Kod_B")';
                 p_type_message  :=g_type_message_error;
               end;
             elsif cur.TAG = 'KOD_G' then
               logger.info('dict:: KOD_G' || l_query);
               begin
               execute immediate l_query
               into l_result;
               exception when no_data_found then
                 p_message       :=cur.description|| '  (Не виконана умова по "Kod_G")';
                 p_type_message  :=g_type_message_error;
               end;
             elsif cur.TAG = 'KOD_N' then
               logger.info('dict:: Kod_N' || l_query);
               begin
               execute immediate l_query
               into l_result;
               exception when no_data_found then
                 p_message       :=cur.description|| '  (Не виконана умова по "Kod_N")';
                 p_type_message  :=g_type_message_error;
               end;
             end if;
          end if;
        end loop;

      end;


      procedure validate_manual_operation(
          p_tt in varchar2,
          p_message out varchar2,
          p_type_message out varchar2)
      is
          l_tts_row tts%rowtype;
      begin
          if (bars_context.is_mfo(sys_context('bars_context', 'user_branch')) = 1) then
              select *
              into   l_tts_row
              from   tts t
              where  t.tt = p_tt;

              if (substr(l_tts_row.flags, 1, 1) = '1') then  -- операція дозволена для ручного вводу
                  p_message := 'Заборонено вводити операцію на рівні МФО';
                  p_type_message := g_type_message_error;
              end if;
          end if;
      end;

      procedure doc_input_validation(p_dictionary_main in t_dictionary,
                                   p_dictionary      in out t_dictionary,
                                   p_message         out varchar2,
                                   p_type_message    out varchar2) is
     --если хоть на каком-то этапе появилась критичная ошибка, то дальше ничего не проверяем а выводим ее.
      l_tt           varchar2(32767 byte);
      l_kod_b        varchar2(32767 byte);
      l_kod_g        varchar2(32767 byte);
      l_kod_n        varchar2(32767 byte);
      l_message_bgn  varchar2(1000);
      l_type_message varchar2(100);
      l_BGN          number(17):=0;
      l_ca           number(1) := 0;
    begin
      for c in (select * from table(p_dictionary_main)) loop
        logger.info('dict_main:: c.key=' || c.key || ', c.value=' || c.value);
        if c.key = 'tt' then
          l_tt := c.value;
        end if;
      end loop;

      validate_manual_operation(l_tt, p_message, p_type_message);
      if (p_type_message = g_type_message_error) then
          return;
      end if;

      select decode(/*f_ourmfo_g*/sys_context('bars_gl', 'mfo'), '300465', 1, 0) into l_ca from dual;

      for c in (select upper(key) key, value from table(p_dictionary)) loop
        logger.info('dict_req:: c.key=' || c.key || ', c.value=' || c.value);
        if c.key = 'D9#70' then
          if (validate_d9#70(c.value) = 1) then
            p_dictionary   := t_dictionary(t_dictionary_item(c.key, c.value));
            p_message      := 'Банк проводить ризикові фін. операції (пост. НБУ 369 від 15.08.2016р.), потрібні додаткові документи!';
            p_type_message := g_type_message_dialog;
          end if;
        elsif c.key = 'KOD_B'  then
          l_kod_b := c.value;
          l_BGN:=l_BGN+1;
        elsif c.key = 'KOD_G'  then
          l_kod_g := c.value;
          l_BGN:=l_BGN+1;
        elsif c.key = 'KOD_N'  then
          l_kod_n := c.value;
          l_BGN:=l_BGN+1;
        end if;
      end loop;

      --обрабатываем в самом конце, ибо для проверки нужны сразу все 3 парамерта
      if (p_type_message <>g_type_message_error or p_type_message is null ) and l_BGN>0 then  --не было еще критичных ошибок и есть необходимость проверки доп. реквизитов
        logger.info('dict:: validate_Kod_BGN');
        validate_Kod_BGN(l_tt,l_ca,l_kod_b,l_kod_g,l_kod_n,l_message_bgn,l_type_message);
        if l_type_message =  g_type_message_error then  --в результате валидации возникла критичная ошибка. Ее и выводим
          p_type_message:= l_type_message;
          p_message     := l_message_bgn;
        end if;
      end if;
      logger.info('dict:: l_BGN=' || l_BGN || ', p_type_message=' || p_type_message || ', p_message=' || p_message);

    end;

end;
/
 show err;
 
PROMPT *** Create  grants  GL_UI ***
grant EXECUTE                                                                on GL_UI           to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/gl_ui.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 
