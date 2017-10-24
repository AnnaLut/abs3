
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_async_adm.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ASYNC_ADM is

  ------------------------------------------------------------------------------
  -- BARS_ASN_ADN - ����� ����������������� ������ ����������� ��������
  -- �����:               ����� �������
  -- ��������� ������:    18.11.2014
  -- ��������� ���������: 26.02.2015, ������ 1.2

  G_HEADER_VERSION  constant varchar2(64) := 'version 1.2 26.02.2015';
  ------------------------------------------------------------------------------
  -- header_version - ������ ���������
  ------------------------------------------------------------------------------
  function header_version return varchar2;

  ------------------------------------------------------------------------------
  -- header_version - ������ ���������
  ------------------------------------------------------------------------------
  function body_version return varchar2;

  ------------------------------------------------------------------------------
  -- drop_job     - �������� ������
  -- p_job_name   - ��� ������
  ------------------------------------------------------------------------------
  procedure drop_job(p_job_name in varchar2);

  ------------------------------------------------------------------------------
  -- drop_long_running_jobs - �������� ����� ������������� �����
  ------------------------------------------------------------------------------
  procedure drop_long_running_jobs;

  ------------------------------------------------------------------------------
  -- add_excl_mode_type - ���������� ���� ���������
  -- p_type   		 - ���
  -- p_name			 - �����
  ------------------------------------------------------------------------------
  procedure add_excl_mode_type(
    p_type in varchar2,
	p_description in varchar2 default null
  );

  ------------------------------------------------------------------------------
  -- add_param_type - ���������� ���� ���������
  -- p_param_type    - ��� ���������
  -- p_format_mask   - ����� ��������������
  -- p_name			 - �����
  ------------------------------------------------------------------------------
  procedure add_param_type(
    p_param_type in varchar2,
    p_format_mask in varchar2 default null,
	p_name in varchar2 default null
  );

  ------------------------------------------------------------------------------
  -- mod_param_type - ���������� ���� ���������
  -- p_param_type    - ��� ���������
  -- p_format_mask   - ����� ��������������
  -- p_name			 - �����
  ------------------------------------------------------------------------------
  procedure mod_param_type(
    p_param_type in varchar2,
    p_format_mask in varchar2,
	p_name in varchar2 default null
  );

  ------------------------------------------------------------------------------
  -- add_param - ���������� ���������
  -- p_param_name      - ��� ���������
  -- p_param_type      - ��� ���������
  -- p_default_value   - �������� ��-���������
  -- p_user_prompt     - ����������� ������������
  -- p_min              - �������� ��������
  -- p_nax              - ����������� ��������
  -- p_ui_type          - ��� �� �������� �����������
  -- p_directory        - ����� ������� ��������
  ------------------------------------------------------------------------------
  procedure add_param(
    p_param_name in varchar2,
    p_param_type in varchar2,
    p_default_value in varchar2 default null,
    p_user_prompt in varchar2 default null,
    p_min in varchar2 default null,
    p_max in varchar2 default null,
    p_ui_type in varchar2 default null,
    p_directory in varchar2 default null,
    p_param_id out number
  );

  ------------------------------------------------------------------------------
  -- set_param_type - ��������� ���� ���������
  -- p_param_name   - ��� ���������
  -- p_param_type   - ��� ���������
  ------------------------------------------------------------------------------
  procedure set_param_type(
    p_param_name in varchar2,
    p_param_type in varchar2
  );

  ------------------------------------------------------------------------------
  -- set_param_defval - ��������� �������� ��-��������� ���������
  -- p_param_name      - ��� ���������
  -- p_default_value   - �������� ��-���������
  ------------------------------------------------------------------------------
  procedure set_param_defval(
    p_param_name    in varchar2,
    p_default_value in varchar2
  );

  ------------------------------------------------------------------------------
  -- set_param_usrprom - ��������� ����������� ������������ ���������
  -- p_param_name    - ��� ���������
  -- p_user_prompt   - ����������� ������������
  ------------------------------------------------------------------------------
  procedure set_param_usrprom(
    p_param_name  in varchar2,
    p_user_prompt in varchar2
  );

  ------------------------------------------------------------------------------
  -- add_sql - �������� ��� �������� SQL-������
  -- p_sql_code          - ��� SQL-�������
  -- p_sql_text          - ����� SQL-�������
  -- p_exclusion_mode    - ������� ������������
  -- p_max_run_secs      - ������������ ������ ����������
  -- p_name              - ������������ ��������, ������� ����� ��������� � ����
  -- p_session_params    - ��������� ������
  -- p_parallel_params   - ��������� ������������� ����������
  -- p_description       - �������� ��������
  ------------------------------------------------------------------------------
  procedure add_sql(
    p_sql_code in varchar2,
    p_sql_text in varchar2,
    p_exclusion_mode in varchar2,
    p_max_run_secs in number,
    p_name in varchar2,
    p_session_params in varchar2 default null,
    p_parallel_params in varchar2 default null,
    p_description in varchar2 default null
  );

  ------------------------------------------------------------------------------
  -- set_sql - �������� ����� SQL-�������
  -- p_sql_code   - ��� SQL-�������
  -- p_sql_text   - ����� SQL-�������
  ------------------------------------------------------------------------------
  procedure set_sql(
    p_sql_code in varchar2,
    p_sql_text in varchar2
  );

  ------------------------------------------------------------------------------
  -- set_exclusion_mode - ��������� ������ ����������������
  -- p_action_code      - ��� ��������
  -- p_exclusion_mode   - ������� ����������������
  ------------------------------------------------------------------------------
  procedure set_exclusion_mode(
    p_action_code in varchar2,
    p_exclusion_mode in varchar2
  );

  ------------------------------------------------------------------------------
  -- set_max_run_secs - ��������� ������������� ������� ����������
  -- p_action_code    - ��� ��������
  -- p_max_run_secs   - ������������ ������ ����������
  ------------------------------------------------------------------------------
  procedure set_max_run_secs(
    p_action_code in varchar2,
    p_max_run_secs in number
  );

  ------------------------------------------------------------------------------
  -- set_description - ���������� �������� ��������
  --   p_action_code - ��� ��������
  --   p_description - �������� ��������
  ------------------------------------------------------------------------------
  procedure set_description(
    p_action_code in varchar2,
    p_description in varchar2
  );

  ------------------------------------------------------------------------------
  -- append_sql_param - �������� �������� SQL-�������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_id   - Id ���������
  ------------------------------------------------------------------------------
  procedure append_sql_param(
    p_sql_code in varchar2,
    p_param_id in number
  );

  ------------------------------------------------------------------------------
  -- �� ���������������, ���� ���� ����������������, ������ �������� � ������
  -- append_sql_param - �������� �������� SQL-�������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_name   - ��� ���������
  -- p_param_type   - ��� ���������
  ------------------------------------------------------------------------------
  procedure append_sql_param(
    p_sql_code in varchar2,
    p_param_name in varchar2,
    p_param_type in varchar2
  );

  ------------------------------------------------------------------------------
  -- del_param - ��������� �������� ����������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_name   - ��� ���������
  ------------------------------------------------------------------------------
  procedure del_param(
    p_sql_code in varchar2,
    p_param_name in varchar2
  );

  ------------------------------------------------------------------------------
  -- mod_sql_param - ����������� ��������� SQL-�������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_pos    - ������� ���������
  -- p_param_name   - ��� ���������
  -- p_param_type   - ��� ���������
  ------------------------------------------------------------------------------
  procedure mod_sql_param(
    p_sql_code in varchar2,
    p_param_pos in number,
    p_param_name in varchar2,
    p_param_type in varchar2
  );

  ------------------------------------------------------------------------------
  -- add_webui - �������� WEB-������
  -- p_webui_code   - ��� WEB-�������
  -- p_url          - URL WEB-�������
  -- p_params       - ��������� WEB-�������
  ------------------------------------------------------------------------------
  procedure add_webui(
    p_webui_code in varchar2,
    p_url in varchar2,
    p_params in varchar
  );

  ------------------------------------------------------------------------------
  -- add_action_type - �������� ��� ��������
  -- p_action_type   - ��� ��������
  ------------------------------------------------------------------------------
  procedure add_action_type(p_action_type in varchar2);

  ------------------------------------------------------------------------------
  -- add_run_obj_type - �������� ����� ��� ������������ �������
  -- p_obj_type_code   - ��� ������������ ����
  -- p_obj_type_desc   - �������� ������������ ����
  ------------------------------------------------------------------------------
  procedure add_run_obj_type(
    p_obj_type_code in varchar2,
    p_obj_type_desc in varchar2
  );

  ------------------------------------------------------------------------------
  -- add_run_state_type - �������� ����� ��� ������� ���������� �������
  -- p_obj_type_code   - ��� ������������ ����
  -- p_obj_type_desc   - �������� ������������ ����
  ------------------------------------------------------------------------------
  procedure add_run_state_type(
    p_type_code in varchar2,
    p_type_desc in varchar2
  );
  ------------------------------------------------------------------------------
  -- add_run_object - ���������� ������������ �������
  -- p_obj_type_code      - ��� ���� ������������ �������
  -- p_action_code        - ��� ������������ �������
  -- p_pre_action_code    - ��� �������������� ������������ �������
  -- p_post_action_code   - ��� ������������ ������������ �������
  -- p_scheduler_id       - ������������� ����������
  -- p_trace_level_id     - ������� �������
  -- p_user_message       - ��������� ������������
  ------------------------------------------------------------------------------
  procedure add_run_object(
    p_obj_type_code in varchar2,
    p_action_code in varchar2,
    p_pre_action_code in varchar2,
    p_post_action_code in varchar2,
    p_scheduler_id in number,
    p_trace_level_id in varchar2,
    p_user_message in varchar2
  );

  ------------------------------------------------------------------------------
  -- mod_user_message - ��������� ��������� ������������
  --   p_sql_code     - ��� ��������
  --   p_user_message - ��������� ������������
  ------------------------------------------------------------------------------
  procedure mod_user_message(
    p_sql_code in varchar2,
    p_user_message in varchar2
  );

  ------------------------------------------------------------------------------
  -- del_action - ��������� ��������
  --   p_action_id     - id ��������
  ------------------------------------------------------------------------------

  procedure del_action(
    p_action_id in number
  );

  ------------------------------------------------------------------------------
  -- del_action - ��������� ��������
  --   p_action_code     - ��� ��������
  ------------------------------------------------------------------------------

  procedure del_action(
    p_action_code in varchar2
  );

end bars_async_adm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ASYNC_ADM is

  ------------------------------------------------------------------------------
  -- BARS_ASN_ADN - ����� ����������������� ������ ����������� ��������
  -- �����:               ����� �������
  -- ��������� ������:    18.11.2014
  -- ��������� ���������: 26.02.2015, ������ 1.2

  G_BODY_VERSION  constant varchar2(64) := 'version 1.2 26.02.2015';
  G_MODULE        constant varchar2(4) := 'ASN';

  OBJ_NOT_FOUND   constant number := -1; -- ��������� ��� ������ ������ ���� ������ �� �������

  ------------------------------------------------------------------------------
  -- header_version - ������ ���������
  ------------------------------------------------------------------------------
  function header_version return varchar2 is
  begin
    return g_header_version;
  end header_version;

  ------------------------------------------------------------------------------
  -- header_version - ������ ���������
  ------------------------------------------------------------------------------
  function body_version return varchar2 is
  begin
    return g_body_version;
  end;

  ------------------------------------------------------------------------------
  -- drop_job     - �������� ������
  -- p_job_name   - ��� ������
  ------------------------------------------------------------------------------
  procedure drop_job(p_job_name in varchar2) is
    l_trace     varchar2(4000) := G_MODULE||'.drop_job: ';
    l_job_state varchar2(16);
  begin
    bars_audit.info(l_trace||'�������� ������ "'||p_job_name||'"');

    begin
      select state
      into l_job_state
      from async_run
      where job_name = p_job_name;
    exception when others then
      bars_audit.error(l_trace||'������ ��� ������ ��� �������� ������ "'||p_job_name||chr(10)||
        dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    end;

    -- �������� ������� ������ ������������� ������
    if l_job_state <> 'RUNNING' then
      return;
    end if;

    dbms_scheduler.drop_job(p_job_name, force => true);
	exception when others then
		if ( sqlcode = -27475 ) then null;
		else raise;
		end if;
    bars_async.set_job_date_state(p_job_name, 'END', sysdate, 'STOPPED');
    bars_async.set_err_msg(p_job_name, '������������ �������������');
    bars_async.add_user_message(p_job_name, '������ �������� '||p_job_name||' �������');

  end drop_job;

  ------------------------------------------------------------------------------
  -- drop_long_running_jobs - �������� ����� ������������� �����
  ------------------------------------------------------------------------------
  procedure drop_long_running_jobs
  is
    l_trace varchar2(4000) := G_MODULE||'.drop_long_running_jobs: ';
  begin
    bars_audit.info(l_trace||
      '������� �����, ����������� ����������� �� ������� ������. ����� �������: '||to_char(sysdate, 'dd.mm.yyyy'));

    for rc in (
      select job_name
      from async_run ar
      join async_action aa on (aa.action_id = ar.action_id)
      where state = 'RUNNING'
      and (sysdate-start_date)*24*60*60 > max_run_secs
    ) loop

      bars_audit.info(l_trace||'�������� ������ '||rc.job_name);
      dbms_scheduler.drop_job(rc.job_name, force => true);
      bars_async.set_job_date_state(rc.job_name, 'END', sysdate, 'STOPPED');
      bars_async.set_err_msg(rc.job_name, '������������ �� ����-����');

    end loop;

  end drop_long_running_jobs;

  ------------------------------------------------------------------------------
  -- add_excl_mode_type - ���������� ���� ���������
  -- p_type    - ���
  -- p_name			 - �����
  ------------------------------------------------------------------------------
  procedure add_excl_mode_type(
    p_type in varchar2,
	p_description in varchar2 default null
  ) is
    l_trace varchar2(2000) := G_MODULE||'.add_excl_mode_type: ';

  begin
    bars_audit.trace(
		l_trace||'���������� ������ ���� ���������: PARAM_TYPE = "'||
		p_type);

    begin
		insert into async_exclusion_mode_type (type, description)
		values(upper(trim(p_type)), p_description);

    exception when dup_val_on_index then
      update async_exclusion_mode_type
      set description = p_description
      where type = upper(trim(p_type));

    end;

  end add_excl_mode_type;

  ------------------------------------------------------------------------------
  -- add_param_type - ���������� ���� ���������
  -- p_param_type    - ��� ���������
  -- p_format_mask   - ����� ��������������
  -- p_name			 - �����
  ------------------------------------------------------------------------------
  procedure add_param_type(
    p_param_type in varchar2,
    p_format_mask in varchar2 default null,
	p_name in varchar2 default null
  ) is
    l_trace varchar2(2000) := G_MODULE||'.add_param_type: ';

  begin
    bars_audit.trace(l_trace||'���������� ������ ���� ���������: PARAM_TYPE = "'||
      p_param_type||'", FORMAT_MASK = "'||p_format_mask||'"');

    begin
      insert into async_param_type(param_type, format_mask, name)
      values(upper(trim(p_param_type)), p_format_mask, p_name);

    exception when dup_val_on_index then
      update async_param_type
      set format_mask = p_format_mask,
		name = p_name
      where param_type = upper(trim(p_param_type));

    end;

  end add_param_type;

  ------------------------------------------------------------------------------
  -- mod_param_type - ���������� ���� ���������
  -- p_param_type    - ��� ���������
  -- p_format_mask   - ����� ��������������
  -- p_name			 - �����
  ------------------------------------------------------------------------------
  procedure mod_param_type(
    p_param_type in varchar2,
    p_format_mask in varchar2,
	p_name in varchar2 default null
  ) is
    l_trace varchar2(2000) := G_MODULE||'.mod_param_type: ';
  begin
    bars_audit.trace(l_trace||'���������� ������ ���� ���������: PARAM_TYPE = "'||
      p_param_type||'", FORMAT_MASK = "'||p_format_mask||'"');

    update async_param_type
    set format_mask = p_format_mask,
		name = p_name
    where param_type = upper(trim(p_param_type));

  end mod_param_type;

  ------------------------------------------------------------------------------
  -- add_param - ���������� ���������
  -- p_param_name      - ��� ���������
  -- p_param_type      - ��� ���������
  -- p_default_value   - �������� ��-���������
  -- p_user_prompt     - ����������� ������������
  -- p_min              - �������� ��������
  -- p_nax              - ����������� ��������
  -- p_ui_type          - ��� �� �������� �����������
  -- p_directory        - ����� ������� ��������
  ------------------------------------------------------------------------------
  procedure add_param(
    p_param_name in varchar2,
    p_param_type in varchar2,
    p_default_value in varchar2 default null,
    p_user_prompt in varchar2 default null,
    p_min in varchar2 default null,
    p_max in varchar2 default null,
    p_ui_type in varchar2 default null,
    p_directory in varchar2 default null,
    p_param_id out number
  ) is
    l_trace         varchar2(2000) := G_MODULE||'.add_param: ';
    l_param_id      number;
  begin
    bars_audit.trace(l_trace);

    /*
    insert into async_param
      (param_id, param_type, param_name, default_value, user_prompt)
    values (s_async.nextval, upper(trim(p_param_type)),
      upper(trim(p_param_name)), p_default_value, p_user_prompt);
    */

    select s_async.nextval into l_param_id from dual;

    merge into async_param dst
    using(
      select
        upper(trim(p_param_name)) param_name,
        upper(trim(p_param_type)) param_type
      from dual) src
    on (dst.param_name = src.param_name and dst.param_type = src.param_type)
    when matched then update
      set dst.default_value = p_default_value,
        dst.user_prompt = p_user_prompt,
        dst.min = p_min,
        dst.max = p_max,
        dst.ui_type = p_ui_type,
        dst.directory = p_directory
    when not matched then insert(
        param_id,
        param_name,
        param_type,
        default_value,
        user_prompt,
        min,
        max,
        ui_type,
        directory)
    values (
        l_param_id,
        src.param_name,
        src.param_type,
        p_default_value,
        p_user_prompt,
        p_min,
        p_max,
        p_ui_type,
        p_directory);

    p_param_id := l_param_id;
  exception when others then
    bars_audit.error(l_trace||
      dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    raise_application_error(-20000, '��� ��������� '||p_param_type||' �� ��������');

  end add_param;

  ------------------------------------------------------------------------------
  -- set_param_type - ��������� ���� ���������
  -- p_param_name   - ��� ���������
  -- p_param_type   - ��� ���������
  ------------------------------------------------------------------------------
  procedure set_param_type(
    p_param_name in varchar2,
    p_param_type in varchar2
  ) is
    l_trace         varchar2(2000) := G_MODULE||'.set_param_type:';
  begin
    bars_audit.trace(l_trace||' PARAM_NAME = "'||p_param_name||'", PARAM_TYPE = "'||p_param_type||'"');

    update async_param
    set param_type = upper(trim(param_type))
    where param_name = p_param_name
    and param_type <> upper(trim(p_param_type));

  exception when others then
    bars_audit.error(l_trace||
      dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    raise_application_error(-20000, '��� ��������� '||p_param_type||' �� ������');

  end set_param_type;

  ------------------------------------------------------------------------------
  -- set_param_defval - ��������� �������� ��-��������� ���������
  -- p_param_name      - ��� ���������
  -- p_default_value   - �������� ��-���������
  ------------------------------------------------------------------------------
  procedure set_param_defval(
    p_param_name    in varchar2,
    p_default_value in varchar2
  ) is
    l_trace varchar2(2000) := G_MODULE||'.set_param_defval:';
  begin
    bars_audit.trace(l_trace||' PARAM_NAME = "'||p_param_name||'", DEFAULT_VALUE = "'||p_default_value||'"');

    update async_param
    set default_value = p_default_value
    where param_name = p_param_name;

  end;

    ------------------------------------------------------------------------------
  -- set_param_usrprom - ��������� ����������� ������������ ���������
  -- p_param_name    - ��� ���������
  -- p_user_prompt   - ����������� ������������
  ------------------------------------------------------------------------------
  procedure set_param_usrprom(
    p_param_name  in varchar2,
    p_user_prompt in varchar2
  )is
    l_trace varchar2(2000) := G_MODULE||'.set_param_usrprm:';
  begin
    bars_audit.trace(l_trace||' PARAM_NAME = "'||p_param_name||'", USER_PROMPT = "'||p_user_prompt||'"');

    update async_param
    set user_prompt = p_user_prompt
    where param_name = p_param_name;

  end;

------------------------------------------------------------------------------
  -- get_param - �������� �������� �� ����� � ����,
  --             ���� �� ������ - �������
  -- p_param_name   - ��� ���������
  -- p_param_type   - ��� ���������
  ------------------------------------------------------------------------------
  function get_param(p_param_name in varchar2, p_param_type in varchar2) return number
  is
    l_trace    varchar2(2000) := G_MODULE||'.get_param: ';
    l_param_id number;
  begin
    bars_audit.trace(l_trace||'PARAM_NAME ="'||p_param_name||'"; PARAM_TYPE = "'||p_param_type||'"');

    begin
      select param_id
      into l_param_id
      from async_param
      where param_name = upper(trim(p_param_name))
      and param_type = upper(trim(p_param_type));

    exception when no_data_found then
      bars_audit.trace(l_trace||'��������� ������ ���������');

      insert into async_param
        (param_id, param_type, param_name)
      values (s_async.nextval, upper(trim(p_param_type)), upper(trim(p_param_name)))
      returning param_id into l_param_id;

    end;

    return l_param_id;
  end get_param;

  ------------------------------------------------------------------------------
  -- add_sql - �������� ��� �������� SQL-������
  -- p_sql_code          - ��� SQL-�������
  -- p_sql_text          - ����� SQL-�������
  -- p_exclusion_mode    - ������� ������������
  -- p_max_run_secs      - ������������ ������ ����������
  -- p_name              - ������������ ��������, ������� ����� ��������� � ����
  -- p_session_params    - ��������� ������
  -- p_parallel_params   - ��������� ������������� ����������
  -- p_description       - �������� ��������

------------------------------------------------------------------------------
  procedure add_sql(
    p_sql_code in varchar2,
    p_sql_text in varchar2,
    p_exclusion_mode in varchar2,
    p_max_run_secs in number,
    p_name in varchar2,
    p_session_params in varchar2 default null,
    p_parallel_params in varchar2 default null,
    p_description in varchar2 default null
  ) is
    l_trace  varchar2(2000) := G_MODULE||'.add_sql: ';
    l_sql_id number;

  begin
    bars_audit.trace(substr(l_trace||'SQL:'||chr(10)||p_sql_text, 4000));
    bars_audit.trace(l_trace||'SQL_CODE: '||p_sql_code);
    bars_audit.trace(l_trace||'SESSION: '||p_session_params);
    bars_audit.trace(l_trace||'PARALLEL'||p_parallel_params);

    -- ���� SQL-������ � �������� SQL_CODE ��� ����������, �� �������� ����� �������
    -- ����� - ������� ��������� �����
    begin

      select sql_id
      into l_sql_id
      from async_action
      where action_code = p_sql_code;

      update async_action
      set exclusion_mode = p_exclusion_mode,
        max_run_secs = p_max_run_secs,
        name = p_name
      where action_code = p_sql_code;

      update async_sql
      set sql_text = p_sql_text
      where sql_id = l_sql_id;

    exception when no_data_found then

      insert into async_sql(sql_id, sql_text,
        session_params, parallel_params)
      values (s_async.nextval, p_sql_text,
        p_session_params, p_parallel_params)
      returning sql_id into l_sql_id;

      insert into async_action(
        action_id, action_code, action_type, sql_id,
        exclusion_mode, max_run_secs, description, name
      ) values (
        s_async.nextval, p_sql_code, 'SQL', l_sql_id,
        p_exclusion_mode, p_max_run_secs, p_description, p_name
      );

    end;

  exception when others then
    bars_audit.error(l_trace||chr(10)||
      dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    raise;
  end add_sql;

  ------------------------------------------------------------------------------
  -- set_sql - �������� ����� SQL-�������
  -- p_sql_code   - ��� SQL-�������
  -- p_sql_text   - ����� SQL-�������
  ------------------------------------------------------------------------------
  procedure set_sql(
    p_sql_code in varchar2,
    p_sql_text in varchar2
  ) is
    l_trace varchar2(2000) := G_MODULE||'.set_sql: ';
  begin
    bars_audit.trace(l_trace||'��������� SQL-������� �������� action_code="'||p_sql_code||'"');

    update async_sql
    set sql_text = p_sql_text
    where sql_id in (
      select sql_id
      from async_action
      where action_code = upper(p_sql_code)
    );

  end set_sql;

  ------------------------------------------------------------------------------
  -- set_exclusion_mode - ��������� ������ ����������������
  --   p_action_code    - ��� ��������
  --   p_exclusion_mode - ������� ����������������
  ------------------------------------------------------------------------------
  procedure set_exclusion_mode(
    p_action_code in varchar2,
    p_exclusion_mode in varchar2
  ) is
    l_trace varchar2(2000) := G_MODULE||'.set_exclusion_mode: ';
  begin
    bars_audit.trace(l_trace||'��������� ������ ���������������� �������� "'||
      upper(p_action_code)||'" �� "'||upper(p_exclusion_mode)||'"');

    update async_action
    set exclusion_mode = upper(p_exclusion_mode)
    where action_code = upper(p_action_code);

  end set_exclusion_mode;

  ------------------------------------------------------------------------------
  -- set_max_run_secs - ��������� ������������� ������� ����������
  -- p_action_code    - ��� ��������
  -- p_max_run_secs   - ������������ ������ ����������
  ------------------------------------------------------------------------------
  procedure set_max_run_secs(
    p_action_code in varchar2,
    p_max_run_secs in number
  ) is
    l_trace varchar2(2000) := G_MODULE||'.set_max_run_secs: ';
  begin
    bars_audit.trace(l_trace||'��������� ������������� ������� ���������� �������� p_action_code="'||upper(p_action_code)||'"');

    update async_action
    set max_run_secs = p_max_run_secs
    where action_code = upper(p_action_code);

  end set_max_run_secs;

  ------------------------------------------------------------------------------
  -- set_description - ���������� �������� ��������
  --   p_action_code - ��� ��������
  --   p_description - �������� ��������
  ------------------------------------------------------------------------------
  procedure set_description(
    p_action_code in varchar2,
    p_description in varchar2
  ) is
    l_trace varchar2(2000) := G_MODULE||'.set_description: ';
  begin
    bars_audit.trace(l_trace||'��������� �������� �������� p_action_code="'||upper(p_action_code)||'"');

    update async_action
    set description = p_description
    where action_code = p_action_code;

  end set_description;

  ------------------------------------------------------------------------------
  -- append_sql_param - �������� �������� SQL-�������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_id   - Id ���������
  ------------------------------------------------------------------------------
  procedure append_sql_param(
    p_sql_code in varchar2,
    p_param_id in number
  ) is
    l_trace          varchar2(2000) := G_MODULE||'.append_sql_param: ';
    l_sql_id         number;
    l_last_param_pos number;
    l_param_id       number;
    l_chk            number;
  begin
      bars_audit.trace(l_trace||'���������� ��������� "'||
        p_param_id||'" �� SQL-������� "'||p_sql_code||'"');

        -- �������� ���� �� ��� �������� � SQL
        select count(*)
            into l_chk
        from async_action aa
            join async_sql_param sp on (sp.sql_id = aa.sql_id)
            join async_param ap on (ap.param_id = sp.param_id)
        where aa.action_code = upper(p_sql_code)
            and ap.param_name = (select upper(param_name) from async_param where param_id = p_param_id);

        if l_chk > 0 then
            raise_application_error(-20000, '�������� � ����� �� ������ �� �  "'||p_param_id||'" ��� � � ������� "'||p_sql_code||'"');
        end if;

        begin
            select sql_id
                into l_sql_id
            from
                async_action
            where action_code = p_sql_code
                and sql_id is not null;
            exception when no_data_found then
                bars_audit.error(l_trace||'�� ������ SQL-������ � ����� "'||p_sql_code||'"');
                raise;
        end;

        select nvl(max(param_pos), 0)
            into l_last_param_pos
        from
            async_sql_param
        where sql_id = l_sql_id;

        insert into async_sql_param
            (sql_param_id, sql_id, param_id, param_pos)
        values
            (s_async.nextval, l_sql_id, p_param_id, l_last_param_pos+1);
  end append_sql_param;

  ------------------------------------------------------------------------------
  -- �� ���������������, ������ �� ������ ���� �����������
  -- append_sql_param - �������� �������� SQL-�������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_name   - ��� ���������
  -- p_param_type   - ��� ���������
  ------------------------------------------------------------------------------
  procedure append_sql_param(
    p_sql_code in varchar2,
    p_param_name in varchar2,
    p_param_type in varchar2
  ) is
    l_trace          varchar2(2000) := G_MODULE||'.append_sql_param: ';
    l_sql_id         number;
    l_last_param_pos number;
    l_param_id       number;
    l_chk            number;
  begin
    bars_audit.trace(l_trace||'���������� ��������� "'||
      p_param_name||'" ���� "'||p_param_type||'" SQL-������� "'||p_sql_code||'"');

    -- �������� ���� �� ��� �������� � SQL
    select count(*)
    into l_chk
    from async_action aa
    join async_sql_param sp on (sp.sql_id = aa.sql_id)
    join async_param ap on (ap.param_id = sp.param_id)
    where aa.action_code = upper(p_sql_code)
    and ap.param_name = upper(p_param_name);

    if l_chk > 0 then
      raise_application_error(-20000, '�������� "'||p_param_name||'" ��� ���� � ������� "'||p_sql_code||'"');
    end if;

    begin
      select sql_id
      into l_sql_id
      from async_action
      where action_code = p_sql_code
      and sql_id is not null;
    exception when no_data_found then
      bars_audit.error(l_trace||'�� ������ SQL-������ � ����� "'||p_sql_code||'"');
      raise;
    end;

    select nvl(max(param_pos), 0)
    into l_last_param_pos
    from async_sql_param
    where sql_id = l_sql_id;

    l_param_id := get_param(p_param_name, p_param_type);

    insert into async_sql_param(sql_param_id, sql_id, param_id, param_pos)
    values (s_async.nextval, l_sql_id, l_param_id, l_last_param_pos+1);

  end append_sql_param;

  ------------------------------------------------------------------------------
  -- del_param - ��������� �������� ����������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_name   - ��� ���������
  ------------------------------------------------------------------------------
  procedure del_param(
    p_sql_code in varchar2,
    p_param_name in varchar2
  ) is
    l_trace         varchar2(2000) := G_MODULE||'.del_param: ';
    l_sql_id        number;
    l_sql_param_id  number;
    l_sql_param_pos number;
  begin

    if p_param_name is not null then
      bars_audit.trace(l_trace||'�������� ��������� "'||p_param_name||'" SQL-������� "'||p_sql_code||'"');

      select asp.sql_id, asp.sql_param_id, param_pos
      into l_sql_id, l_sql_param_id, l_sql_param_pos
      from async_action act
      join async_sql_param asp on asp.sql_id = act.sql_id
      join async_param apr on apr.param_id = asp.param_id
      where act.action_code = upper(p_sql_code)
      and apr.param_name = upper(p_param_name);

      delete from async_sql_param
      where sql_param_id = l_sql_param_id;

      update async_sql_param
      set param_pos = param_pos - 1
      where sql_id = l_sql_id
      and param_pos > l_sql_param_pos;

    else
      bars_audit.trace(l_trace||'�������� ���� �������������������� SQL-������� "'||p_sql_code||'"');

      delete from async_sql_param
      where sql_id in(
        select sql_id
        from async_action
        where action_code = upper(p_sql_code)
      );

    end if;

  end del_param;

  ------------------------------------------------------------------------------
  -- mod_sql_param - ����������� ��������� SQL-�������
  -- p_sql_code     - ��� SQL-�������
  -- p_param_pos    - ������� ���������
  -- p_param_name   - ��� ���������
  -- p_param_type   - ��� ���������
  ------------------------------------------------------------------------------
  procedure mod_sql_param(
    p_sql_code in varchar2,
    p_param_pos in number,
    p_param_name in varchar2,
    p_param_type in varchar2
  ) is
    l_trace    varchar2(2000) := G_MODULE||'.mod_sql_param: ';
    l_sql_id   number;
    l_param_id number;
  begin
    bars_audit.trace(l_trace||'��������� ��������� � "'||p_param_pos||'" SQL-������� "'||p_sql_code||
      '"����� ��� "'||p_param_name||'"; ����� ��� "'||p_param_type||'"');

    begin
      select sql_id
      into l_sql_id
      from async_action
      where action_code = p_sql_code
      and sql_id is not null;
    exception when no_data_found then
      bars_audit.error(l_trace||'�� ������ SQL-������ � ����� "'||p_sql_code||'"');
      raise;
    end;

    l_param_id := get_param(p_param_name, p_param_type);

    update async_sql_param
    set param_id = l_param_id
    where sql_id = l_sql_id
    and param_pos = p_param_pos
    and param_id <> l_param_id;

  end mod_sql_param;

  ------------------------------------------------------------------------------
  -- add_webui - �������� WEB-������
  -- p_webui_code   - ��� WEB-�������
  -- p_url          - URL WEB-�������
  -- p_params       - ��������� WEB-�������
  ------------------------------------------------------------------------------
  procedure add_webui(
    p_webui_code in varchar2,
    p_url in varchar2,
    p_params in varchar
  ) is
    l_trace    varchar2(2000) := G_MODULE||'.add_webui: ';
    l_webui_id number;
  begin
    bars_audit.trace(l_trace||'�������� ���-�������, CODE = "'||
      p_webui_code||'", URL = "'||p_url||'", PARAMS = "'||p_params||'"');

    insert into async_webui(webui_id, webui_url, params)
    values (s_async.nextval, p_url, p_params)
    returning webui_id into l_webui_id;

    insert into async_action(action_id, action_code, action_type, webui_id)
    values (s_async.nextval, p_webui_code, 'WEBUI', l_webui_id);

  exception when others then
    bars_audit.error(l_trace||chr(10)||
      dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    raise;
  end add_webui;

  ------------------------------------------------------------------------------
  -- add_action_type - �������� ��� ��������
  -- p_action_type   - ��� ��������
  ------------------------------------------------------------------------------
  procedure add_action_type(p_action_type in varchar2)
  is
    l_trace varchar2(2000) := G_MODULE||'.add_action_type: ';
  begin
    bars_audit.trace(l_trace||'���������� ���� �������� ACTION_TYPE = "'||p_action_type||'"');

    insert into async_action_type(action_type)
    values (upper(trim(p_action_type)));

  exception when dup_val_on_index then null;
  when others then
    bars_audit.error(l_trace||chr(10)||
      dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    raise;
  end add_action_type;

  ------------------------------------------------------------------------------
  -- find_action - ����� �������� �� ����, ���� ������ �� ������� - ������� OBJ_NOT_FOUND
  -- p_action_code   - ��� ��������
  function find_action(p_action_code in varchar2) return number
  is
    l_trace     varchar2(2000) := G_MODULE||'.find_action: ';
    l_action_id number;
  begin
    bars_audit.trace(l_trace||'����� �������� ACTION_CODE = "'||p_action_code||'"');

    select action_id
    into l_action_id
    from async_action
    where action_code = upper(trim(p_action_code));

    return l_action_id;
  exception when no_data_found then
    return OBJ_NOT_FOUND;
  end find_action;

  ------------------------------------------------------------------------------
  -- add_run_obj_type - �������� ����� ��� ������������ �������
  -- p_obj_type_code   - ��� ������������ ����
  -- p_obj_type_desc   - �������� ������������ ����
  ------------------------------------------------------------------------------
  procedure add_run_obj_type(
    p_obj_type_code in varchar2,
    p_obj_type_desc in varchar2
  ) is
    l_trace varchar2(2000) := G_MODULE||'.add_run_obj_type: ';
  begin
    bars_audit.trace(l_trace||'���������� ���� ������������ �������');

    merge into async_run_obj_type dst
    using (
      select p_obj_type_code as obj_type_code, p_obj_type_desc as obj_type_desc
      from dual) src
    on (dst.obj_type_code = src.obj_type_code)
    when matched then update
      set dst.obj_type_desc = src.obj_type_desc
    when not matched then insert
      (obj_type_id, obj_type_code, obj_type_desc)
      values (s_async.nextval, src.obj_type_code, src.obj_type_desc);

  exception when dup_val_on_index then null;
  when others then
    bars_audit.error(l_trace||chr(10)||
      dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    raise;
  end add_run_obj_type;

  ------------------------------------------------------------------------------
  -- add_run_state_type - �������� ����� ��� ������� ���������� �������
  -- p_obj_type_code   - ��� ������������ ����
  -- p_obj_type_desc   - �������� ������������ ����
  ------------------------------------------------------------------------------
  procedure add_run_state_type(
    p_type_code in varchar2,
    p_type_desc in varchar2
  ) is
    l_trace varchar2(2000) := G_MODULE||'.add_run_state_type: ';
  begin
    bars_audit.trace(l_trace||'���������� ���� ������� ���������� �������');

    begin
      insert into async_run_state_type(state_type, description)
      values(upper(trim(p_type_code)), p_type_desc);

    exception when dup_val_on_index then
      update async_run_state_type
      set description = p_type_desc
      where state_type = upper(trim(p_type_code));

    end;

  end add_run_state_type;

  ------------------------------------------------------------------------------
  -- get_run_obj_type - �������� ������������� ���� ������������ �������,
  --                    ���� �� ������ - ������� �����
  -- p_obj_type_code   - ��� ���� ������������ �������
  ------------------------------------------------------------------------------
  function get_run_obj_type(p_obj_type_code in varchar2) return number is
    l_trace       varchar2(2000) := G_MODULE||'.get_run_obj_type: ';
    l_obj_type_id number;
  begin
    bars_audit.trace(l_trace||' ����� ���� ������������ ������� RUN_OBJ_TYPE = "'||p_obj_type_code||'"');

    select obj_type_id
    into l_obj_type_id
    from async_run_obj_type
    where obj_type_code = upper(trim(p_obj_type_code));

    return l_obj_type_id;

  exception when no_data_found then
    insert into async_run_obj_type(obj_type_id, obj_type_code)
    values (s_async.nextval, p_obj_type_code)
    returning obj_type_id into l_obj_type_id;

    return l_obj_type_id;
  end get_run_obj_type;

  ------------------------------------------------------------------------------
  -- add_run_object - ���������� ������������ �������
  -- p_obj_type_code      - ��� ���� ������������ �������
  -- p_action_code        - ��� ������������ �������
  -- p_pre_action_code    - ��� �������������� ������������ �������
  -- p_post_action_code   - ��� ������������ ������������ �������
  -- p_scheduler_id       - ������������� ����������
  -- p_trace_level_id     - ������� �������
  -- p_user_message       - ��������� ������������
  ------------------------------------------------------------------------------
  procedure add_run_object(
    p_obj_type_code in varchar2,
    p_action_code in varchar2,
    p_pre_action_code in varchar2,
    p_post_action_code in varchar2,
    p_scheduler_id in number,
    p_trace_level_id in varchar2,
    p_user_message in varchar2
  ) is
    l_trace          varchar2(2000) := G_MODULE||'.get_run_obj_type: ';
    l_obj_type_id    number;
    l_action_id      number;
    l_pre_action_id  number;
    l_post_action_id number;

  begin
    bars_audit.trace(l_trace||' ���������� ������������ �������'||
      'OBJ_TYPE_CODE = "'||p_obj_type_code||'", ACTION_CODE = "'||p_action_code||
      '", PRE_ACTION_CODE = "'||p_pre_action_code||'", POST_ACTION_CODE = "'||p_post_action_code||
      '", SCHEDULER_ID = "'||p_scheduler_id||'", TRACE_LEVEL_ID = "'||p_trace_level_id||
      '", USER_MESSAGE = "'||p_user_message||'"');

    l_obj_type_id := get_run_obj_type(p_obj_type_code);

    l_action_id := find_action(p_action_code);
    if l_action_id = OBJ_NOT_FOUND then
      bars_audit.error(l_trace||'�������� ACTION_CODE = "'||p_action_code||'" �� �������');
      bars_error.raise_nerror(G_MODULE, 'ACTION_NOT_FOUND', p_action_code);
    end if;

    if p_pre_action_code is not null then
      l_pre_action_id := find_action(p_pre_action_code);
      if l_pre_action_id = OBJ_NOT_FOUND then
        bars_audit.error(l_trace||'�������� ACTION_CODE = "'||p_pre_action_code||'" �� �������');
        bars_error.raise_nerror(G_MODULE, 'ACTION_NOT_FOUND', p_pre_action_code);
      end if;
    end if;

    if p_post_action_code is not null then
      l_post_action_id := find_action(p_post_action_code);
      if l_post_action_id = OBJ_NOT_FOUND then
        bars_audit.error(l_trace||'�������� ACTION_CODE = "'||p_post_action_code||'" �� �������');
        bars_error.raise_nerror(G_MODULE, 'ACTION_NOT_FOUND', p_post_action_code);
      end if;
    end if;

    insert into async_run_object(object_id, obj_type_id,
      action_id, pre_action_id, post_action_id,
      scheduler_id, trace_level_id, user_message)
    values (s_async.nextval, l_obj_type_id,
    l_action_id, l_pre_action_id, l_post_action_id,
    p_scheduler_id, p_trace_level_id, p_user_message);

  exception when dup_val_on_index then null;
  when others then
    bars_audit.error(l_trace||chr(10)||
      dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
    raise;
  end add_run_object;

  ------------------------------------------------------------------------------
  -- mod_user_message - ��������� ��������� ������������
  --   p_sql_code     - ��� ��������
  --   p_user_message - ��������� ������������
  ------------------------------------------------------------------------------
  procedure mod_user_message(
    p_sql_code in varchar2,
    p_user_message in varchar2
  ) is
    l_trace varchar2(2000) := G_MODULE||'.mod_user_message: ';
  begin
    bars_audit.trace(l_trace || '��������� ��������� ������������ ��� �������� "'||p_sql_code||'"');
    update async_run_object
    set user_message = p_user_message
    where action_id in (
      select action_id
      from async_action
      where action_code = upper(p_sql_code)
    );

  end mod_user_message;

  ------------------------------------------------------------------------------
  -- del_action - ��������� ��������
  --   p_action_id     - id ��������
  ------------------------------------------------------------------------------

  procedure del_action(
    p_action_id in number
  ) is
	l_trace varchar2(2000) := G_MODULE||'.del_action: ';
	l_count_run_obj number ;
    l_sql_id number;
  begin
	bars_audit.trace(l_trace || '��������� �������� �� id = "'||p_action_id||'"');

	select count(*) into l_count_run_obj from async_run where action_id = p_action_id;
	if l_count_run_obj != 0 then
		raise_application_error(-20000, '��������� ��������� �������� ��� ��� �����������');
	end if;

    select sql_id into l_sql_id from async_action where action_id = p_action_id;

	delete from async_run_object where action_id = p_action_id;
 	delete from async_action where action_id = p_action_id;

    delete from async_sql_param where sql_id = l_sql_id;
    delete from async_sql where sql_id = l_sql_id;
  end del_action;

  ------------------------------------------------------------------------------
  -- del_action - ��������� ��������
  --   p_action_code     - ��� ��������
  ------------------------------------------------------------------------------

  procedure del_action(
    p_action_code in varchar2
  ) is
	l_trace varchar2(2000) := G_MODULE||'.del_action: ';
	l_action_id number;
  begin
	bars_audit.trace( l_trace ||'��������� �������� �� code = "'||p_action_code||'"');
	select action_id into l_action_id from async_action where action_code = p_action_code;

	del_action(l_action_id);

  end del_action;

end bars_async_adm;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_async_adm.sql =========*** End 
 PROMPT ===================================================================================== 
 