
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_async.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ASYNC is

  ------------------------------------------------------------------------------
  -- BARS_ASN_ADN - Пакет администрирования модуля асинхронных запусков
  -- Автор:               Тарас Шеденко
  -- Начальная версия:    26.11.2014
  -- Последнее изменение: 22.06.2015, версия 1.2.1

  G_HEADER_VERSION constant varchar2(64) := 'version 1.2.1 22.06.2015';
  G_JOB_NAME varchar2(30);

  ------------------------------------------------------------------------------
  -- Типы для поддержки внешних систем
  ------------------------------------------------------------------------------
  type param_val is record(
    param_name     varchar2(40),
    param_num_val  number,
    param_date_val date,
    param_char_val varchar2(2000));

  type param_val_list_tt is table of param_val;

  ------------------------------------------------------------------------------
  -- header_version - Версия заголовка
  ------------------------------------------------------------------------------
  function header_version return varchar2;

  ------------------------------------------------------------------------------
  -- header_version - Версия заголовка
  ------------------------------------------------------------------------------
  function body_version return varchar2;

  ------------------------------------------------------------------------------
  -- add_user_message - Добавить сообщение пользователя в таблицу USER_MESSAGES
  -- p_job_name   - Название задачи планировщика
  -- p_msg        - Сообщение
  ------------------------------------------------------------------------------
  procedure add_user_message(p_job_name in varchar2, p_msg in varchar2);

  ------------------------------------------------------------------------------
  -- create_job - Создать задачу Планировщика из Асинхронного действия
  -- p_action_code   - Код действия
  ------------------------------------------------------------------------------
  function create_job(p_action_code in varchar2) return varchar2;

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип NUMBER) Задания Планировщика
  -- p_job_name   - Имя Задания Планировщика
  -- p_param      - Имя параметра
  -- p_value      - Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name in varchar2,
                              p_param    in varchar2,
                              p_value    in number);

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип DATE) Задания Планировщика
  -- p_job_name   - Имя Задания Планировщика
  -- p_param      - Имя параметра
  -- p_value      - Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name in varchar2,
                              p_param    in varchar2,
                              p_value    in date);

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип VARCHAR2) Задания Планировщика
  -- p_job_name   - Имя Задания Планировщика
  -- p_param      - Имя параметра
  -- p_value      - Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name in varchar2,
                              p_param    in varchar2,
                              p_value    in varchar2);

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип VARCHAR2) Задания Планировщика
  -- p_job_name            - Имя Задания Планировщика
  -- p_param_val_list      - Список пар Имя параметра/Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name       in varchar2,
                              p_param_val_list in param_val_list_tt);

  ------------------------------------------------------------------------------
  -- set_job_date_sate - Установка даты и состояния в ASYNC_RUN
  -- p_job_name   - Имя Задания Планировщика
  -- p_date       - Тип даты ('START', 'END')
  -- p_date_val   - Значение даты
  -- p_state      - Статус
  ------------------------------------------------------------------------------
  procedure set_job_date_state(p_job_name in varchar2,
                               p_date     in varchar2,
                               p_date_val in date,
                               p_state    in varchar2 default null);

  ------------------------------------------------------------------------------
  -- set_err_msg  - Установка сообщения об ошике
  -- p_job_name   - Название задания планировщика
  -- p_err_msg    - Сообщение об ошибке
  ------------------------------------------------------------------------------
  procedure set_err_msg(p_job_name in varchar2, p_err_msg in varchar2);

  ------------------------------------------------------------------------------
  -- run_job - Запустить Задачу Планировщика
  -- p_job_name   - Имя задачи планировщика
  ------------------------------------------------------------------------------
  procedure run_job(p_job_name in varchar2);

  ------------------------------------------------------------------------------
  -- run_job - Создать и запустить Задачу Планировщика
  -- p_action_code    - Код действия
  -- p_param_val_list - Список пар Имя параметра/Значение параметра
  ------------------------------------------------------------------------------
  procedure run_job(p_action_code    in varchar2,
                    p_param_val_list in param_val_list_tt);

  ------------------------------------------------------------------------------
  -- get_sql_params - Полусить список параметров SQL-запроса
  -- p_sql_code   - Код SQL-запроса
  -- p_params     - Список параметров SQL-запроса
  ------------------------------------------------------------------------------
  procedure get_sql_params(p_sql_code in varchar,
                           p_params   out sys_refcursor);

  ------------------------------------------------------------------------------
  -- set_progress_bar - Установить % выполнения задания
  -- p_percent        - % выполнения
  -- p_progres_text   - текст выполняющейся подзадачи
  ------------------------------------------------------------------------------
  procedure set_progress_bar(p_percent      in number,
                             p_progres_text in varchar2);

end bars_async;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ASYNC is

 ------------------------------------------------------------------------------
 -- BARS_ASN_ADN - Пакет администрирования модуля асинхронных запусков
 -- Автор: Тарас Шеденко
 -- Начальная версия: 26.11.2014
 -- Последнее изменение: 22.06.2015, версия 1.2.1

 G_BODY_VERSION constant varchar2(64) := 'version 1.2.1 22.06.2015';
 G_MODULE constant varchar2(4) := 'ASN';

 -- OBJ_NOT_FOUND constant number := -1; -- Результат для фунций поиска если ничего не найдено

 ------------------------------------------------------------------------------
 -- header_version - Версия заголовка
 ------------------------------------------------------------------------------
 function header_version return varchar2 is
 begin
 return g_header_version;
 end header_version;

 ------------------------------------------------------------------------------
 -- header_version - Версия заголовка
 ------------------------------------------------------------------------------
 function body_version return varchar2 is
 begin
 return g_body_version;
 end body_version;

 ------------------------------------------------------------------------------
 -- get_param_type - Облегченная кеширующая функия определения типа параметрв
 -- p_param_name - Имя параметра
 function get_param_type(p_param_name in varchar2) return varchar2 result_cache is
 l_res async_param.param_type%type;
 begin
 select param_type
 into l_res
 from async_param
 where param_name = p_param_name;
 end get_param_type;

 -- get_param_val - Получение значения параметра запуска
 -- p_job_name - Идентификатор запуска
 -- p_param - Параметр
 function get_param_val(p_job_name in varchar2, p_param in varchar2)
 return varchar2 is
 l_param_type async_param_type.param_type%type;
 l_param_format async_param_type.format_mask%type;
 l_retval async_run_param_val.param_val%type;
 begin

 select pv.param_val, pt.param_type, pt.format_mask
 into l_retval, l_param_type, l_param_format
 from async_run r
 join async_run_param_val pv
 on (pv.run_id = r.run_id)
 join async_param p
 on (p.param_id = pv.param_id)
 join async_param_type pt
 on (pt.param_type = p.param_type)
 where r.job_name = p_job_name
 and p.param_name = p_param;

 if l_param_type = 'DATE' then
 l_retval := to_char(to_date(l_retval, l_param_format), 'dd.mm.yyyy');
 end if;

 return l_retval;
 exception
 when others then
 return substr(p_param, 2);
 end get_param_val;

 ------------------------------------------------------------------------------
 -- add_user_message - Добавить сообщение пользователя в таблицу USER_MESSAGES
 -- p_job_name - Идентификатор запуска
 -- p_msg - Сообщение
 ------------------------------------------------------------------------------
 procedure add_user_message(p_job_name in varchar2, p_msg in varchar2) is
 l_param async_param.param_name%type;
 l_msg varchar2(4000) := p_msg;
 l_user_id number;
 begin

 while regexp_like(l_msg, ':[a-zA-Z]+\w*') loop
 l_param := regexp_substr(l_msg, ':[a-zA-Z]+\w*');
 l_msg := replace(l_msg,
 get_param_val(p_job_name, substr(l_param, 2)));
 end loop;

 select user_id
 into l_user_id
 from async_run
 where job_name = p_job_name;

 insert into user_messages
 (msg_id,
 user_id,
 msg_sender_id,
 msg_subject,
 msg_text,
 msg_date,
 msg_done,
 msg_type_id,
 msg_act_date)
 values
 (s_user_messages.nextval,
 sys_context('bars_global', 'user_id'),
 nvl(l_user_id, sys_context('bars_global', 'user_id')),
 'Паралельний запуск завершено',
 l_msg,
 sysdate,
 0,
 4,
 sysdate);

 commit;
 end add_user_message;

 ------------------------------------------------------------------------------
 -- run_plsql - Запуск PL/SQL-блока через Планировщик
 -- p_action - Строка ASYNC_ACTION для запуска
 -- Результат - Имя Задания Планировщика (USER_SCHEDULER_JOBS.JOB_NAME)
 ------------------------------------------------------------------------------
 function run_plsql(p_action in async_action%rowtype) return varchar2 is
 l_trace varchar2(2000) := G_MODULE || '.run_plsql: ';
 l_sql async_sql%rowtype;
 l_job_name varchar2(200);
 l_job_sql varchar2(4000);
 l_run_id number := s_async.nextval;
 -- l_user_msg varchar2(4000); Добавление сообщения перенесено в RUN_JOB
 l_excl_chk number;
 l_excl_val async_run.exclmode_value%type;
 begin
 bars_audit.info(l_trace ||
 'Создание задания планировщика для PL/SQL-блока для ACTION_CODE = "' ||
 p_action.action_code || '"');

 l_excl_val := case p_action.exclusion_mode
 when 'USER' then
 sys_context(bars_context.global_ctx,
 bars_context.ctxpar_userid)
 when 'BRANCH' then
 sys_context(bars_context.context_ctx,
 bars_context.ctxpar_userbranch)
 when 'FILIAL' then
 sys_context(bars_context.context_ctx,
 bars_context.ctxpar_usermfo)
 when 'WHOLE' then
 'WHOLE'
 else
 null
 end;

 -- Проверка эксклюзивности запуска
 select count(*)
 into l_excl_chk
 from async_run
 where action_id = p_action.action_id
 and state in ('NEW', 'RUNNING')
 and exclmode_value = l_excl_val;

 if l_excl_chk > 0 then
 bars_audit.error(l_trace || 'Задание "' || p_action.action_code ||
 '" уже запущено');
 bars_error.raise_nerror(G_MODULE,
 'EXCLUSION_ERROR',
 p_action.action_code);
 end if;

 select * into l_sql from async_sql where sql_id = p_action.sql_id;
 bars_audit.trace(l_trace || 'SQL = ' || chr(10) || l_sql.sql_text);

 /* Добавление сообщения перенесено в RUN_JOB
 select user_message
 into l_user_msg
 from async_run_object
 where action_id = p_action.action_id;
 */

 l_job_name := dbms_scheduler.generate_job_name(p_action.action_code || '_');

 bars_audit.trace(l_trace || 'JOB_NNAME = ' || l_job_name);

 l_job_sql := 'begin ' || chr(10) || 'BARS.bars_async.set_job_date_state(''' ||
 l_job_name || ''', ''START'', sysdate, ''RUNNING'');' ||
 chr(10);

 l_job_sql := l_job_sql || 'BARS_ASYNC.G_JOB_NAME:=''' || l_job_name ||
 ''';' || chr(10);

 if p_action.bars_login = 'Y' then
 l_job_sql := l_job_sql || 'bars_login.login_user(''' ||
 substr(sys_guid(), 1, 32) || ''', ' ||
 sys_context('bars_global', 'user_id') || ', ''' ||
 sys_context('userenv', 'terminal') ||
 ''', ''ASYNC_JOB'');' || chr(10) || 'bc.subst_branch(''' ||
 sys_context('bars_context', 'user_branch') || ''');' ||
 chr(10);
 end if;

 if l_sql.use_hprof = 'Y' then
 l_job_sql := l_job_sql ||
 'dbms_hprof.start_profiling (location => ''PROFILER_DIR'', filename => ''' ||
 l_job_name || '.txt'');' || chr(10);
 end if;

 --добавляємо sql запит
 l_job_sql := l_job_sql || ' execute immediate q''[' || l_sql.sql_text || ']'';' || chr(10);

 if l_sql.use_hprof = 'Y' then
 l_job_sql := l_job_sql || 'dbms_hprof.stop_profiling;' || chr(10) ||
 'update async_run' || chr(10) || 'set dbmshp_runid = ' ||
                   'dbms_hprof.analyze(' ||
                   'location => ''PROFILER_DIR'', filename => ''' ||
                   l_job_name || '.txt'', run_comment => ''' || l_job_name ||
                   ''')' || chr(10) || 'where job_name = ''' || l_job_name ||
                   ''';' || chr(10);
    end if;

    /* Добавление сообщения перенесено в RUN_JOB
    if l_user_msg is not null then
      l_job_sql := l_job_sql||
      'bars_async.add_user_message('''||l_job_name||''', '''||l_user_msg||''');'||chr(10);
    end if;
    */

    l_job_sql := l_job_sql || 'bars_async.set_job_date_state(''' ||
                 l_job_name || ''', ''END'', sysdate, ''FINISHED'');' ||
                 chr(10) || 'exception when others then' || chr(10) ||
                 'bars_async.set_job_date_state(''' || l_job_name ||
                 ''', ''END'', sysdate, ''ERROR'');' || chr(10) ||
                 'bars_async.set_err_msg(''' || l_job_name ||
                 ''', dbms_utility.format_error_stack ||dbms_utility.format_error_backtrace);' || chr(10)
                 || 'bars_async.add_user_message(''' || l_job_name || ''',''Виконання завдання ' || l_job_name ||
                 ' завершилося з помикою'');' || chr(10) || 'end;';

    insert into async_run
      (run_id,
       action_id,
       job_name,
       job_sql,
       exclmode_value,
       state,
       user_id)
    values
      (l_run_id,
       p_action.action_id,
       l_job_name,
       l_job_sql,
       l_excl_val,
       'NEW',
       sys_context('bars_global', 'user_id'));

    commit;
    return l_job_name;
  end run_plsql;

  ------------------------------------------------------------------------------
  -- create_job - Создать задания Планировщика из Асинхронного действия
  -- p_action_code   - Код действия
  -- Результат       - Имя Задания Планировщика (USER_SCHEDULER_JOBS.JOB_NAME)
  function create_job(p_action_code in varchar2) return varchar2 is
    l_trace    varchar2(2000) := G_MODULE || '.create_job: ';
    l_action   async_action%rowtype;
    l_job_name varchar2(200);
  begin
    bars_audit.info(l_trace ||
                    'Создание задания Планировщика из Действия ACTION_CODE = "' ||
                    p_action_code || '"');

    select *
      into l_action
      from async_action
     where action_code = p_action_code;

    case l_action.action_type
      when 'SQL' then
        l_job_name := run_plsql(l_action);
      when 'PLSQL' then
        l_job_name := run_plsql(l_action);
      else
        null;
    end case;

    return l_job_name;
  end create_job;

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип NUMBER) Задания Планировщика
  -- p_job_name   - Имя Задания Планировщика
  -- p_param      - Имя параметра
  -- p_value      - Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name in varchar2,
                              p_param    in varchar2,
                              p_value    in number) is
    l_trace        varchar2(2000) := G_MODULE || '.set_job_param_val: ';
    l_run_id       number;
    l_param_id     number;
    l_param_type   async_param_type.param_type%type;
    l_param_format async_param_type.format_mask%type;
  begin
    bars_audit.info(l_trace ||
                    'Установка значения параметра: JOB_NAME = "' ||
                    p_job_name || '", PARAM = "' || p_param ||
                    '", VALUE = "' || p_value || '"');

    select run_id into l_run_id from async_run where job_name = p_job_name;

    select ap.param_id, ap.param_type, apt.format_mask
      into l_param_id, l_param_type, l_param_format
      from async_param ap
      join async_param_type apt
        on (apt.param_type = ap.param_type)
     where param_name = upper(trim(p_param));

    if (l_param_type <> 'NUMBER') then
      bars_audit.error(l_trace ||
                       'Несоответствие типа параметра: ожидалось ' ||
                       l_param_type || ', получено NUMBER');
      raise_application_error(-20000,
                              'Несоответствие типа параметра: ожидалось ' ||
                              l_param_type || ', получено NUMBER');
    end if;

    update async_run
       set job_sql = regexp_replace(job_sql,
                                    ':' || p_param,
                                    p_value,
                                    1,
                                    0,
                                    'i')
     where job_name = p_job_name;

    insert into async_run_param_val
      (param_val_id, run_id, param_id, param_val)
    values
      (s_async.nextval,
       l_run_id,
       l_param_id,
       to_char(p_value, l_param_format));

    commit;
  exception
    when others then
      rollback;

      bars_audit.error(l_trace ||
                       'Ошибка при установке значения параметра: JOB_NAME = "' ||
                       p_job_name || '", PARAM = "' || p_param ||
                       '", VALUE = "' || p_value || '"' || chr(10) ||
                       dbms_utility.format_error_stack ||
                       dbms_utility.format_error_backtrace);

      bars_error.raise_nerror(G_MODULE,
                              'ASYNC_ERR',
                              'Ошибка при установке значения параметра: JOB_NAME = "' ||
                              p_job_name || '", PARAM = "' || p_param ||
                              '", VALUE = "' || p_value || '"');

  end set_job_param_val;

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип DATE) Задания Планировщика
  -- p_job_name   - Имя Задания Планировщика
  -- p_param      - Имя параметра
  -- p_value      - Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name in varchar2,
                              p_param    in varchar2,
                              p_value    in date) is
    l_trace        varchar2(2000) := G_MODULE || '.set_job_param_val: ';
    l_run_id       number;
    l_param_id     number;
    l_param_type   async_param_type.param_type%type;
    l_param_format async_param_type.format_mask%type;
  begin
    bars_audit.info(l_trace ||
                    'Установка значения параметра: JOB_NAME = "' ||
                    p_job_name || '", PARAM = "' || p_param ||
                    '", VALUE = "' || p_value || '"');

    select run_id into l_run_id from async_run where job_name = p_job_name;

    select ap.param_id, ap.param_type, apt.format_mask
      into l_param_id, l_param_type, l_param_format
      from async_param ap
      join async_param_type apt
        on (apt.param_type = ap.param_type)
     where param_name = upper(trim(p_param));

    if (l_param_type <> 'DATE') then
      bars_audit.error(l_trace ||
                       'Несоответствие типа параметра: ожидалось ' ||
                       l_param_type || ', получено DATE');
      raise_application_error(-20000,
                              'Несоответствие типа параметра: ожидалось ' ||
                              l_param_type || ', получено DATE');
    end if;

    update async_run
       set job_sql = regexp_replace(job_sql,
                                    ':' || p_param,
                                    'to_date(''' ||
                                    to_char(p_value, l_param_format) ||
                                    ''', ''' || l_param_format || ''')',
                                    1,
                                    0,
                                    'i')
     where job_name = p_job_name;

    insert into async_run_param_val
      (param_val_id, run_id, param_id, param_val)
    values
      (s_async.nextval,
       l_run_id,
       l_param_id,
       to_char(p_value, l_param_format));

    commit;
  exception
    when others then
      rollback;

      bars_audit.error(l_trace ||
                       'Ошибка при установке значения параметра: JOB_NAME = "' ||
                       p_job_name || '", PARAM = "' || p_param ||
                       '", VALUE = "' || p_value || '"' || chr(10) ||
                       dbms_utility.format_error_stack ||
                       dbms_utility.format_error_backtrace);

      bars_error.raise_nerror(G_MODULE,
                              'ASYNC_ERR',
                              'Ошибка при установке значения параметра: JOB_NAME = "' ||
                              p_job_name || '", PARAM = "' || p_param ||
                              '", VALUE = "' || p_value || '"');

  end set_job_param_val;

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип VARCHAR2) Задания Планировщика
  -- p_job_name   - Имя Задания Планировщика
  -- p_param      - Имя параметра
  -- p_value      - Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name in varchar2,
                              p_param    in varchar2,
                              p_value    in varchar2) is
    l_trace      varchar2(2000) := G_MODULE || '.set_job_param_val: ';
    l_run_id     number;
    l_param_id   number;
    l_param_type async_param_type.param_type%type;
  begin
    bars_audit.info(l_trace ||
                    'Установка значения параметра: JOB_NAME = "' ||
                    p_job_name || '", PARAM = "' || p_param ||
                    '", VALUE = "' || p_value || '"');

    select run_id into l_run_id from async_run where job_name = p_job_name;

    select param_id, param_type
      into l_param_id, l_param_type
      from async_param
     where param_name = upper(trim(p_param));

    if (l_param_type <> 'VARCHAR2') then
      bars_audit.error(l_trace ||
                       'Несоответствие типа параметра: ожидалось ' ||
                       l_param_type || ', получено VARCHAR2');
      raise_application_error(-20000,
                              'Несоответствие типа параметра: ожидалось ' ||
                              l_param_type || ', получено VARCHAR2');
    end if;

    update async_run
       set job_sql = regexp_replace(job_sql,
                                    ':' || p_param,
                                    '''' || p_value || '''',
                                    1,
                                    0,
                                    'i')
     where job_name = p_job_name;

    insert into async_run_param_val
      (param_val_id, run_id, param_id, param_val)
    values
      (s_async.nextval, l_run_id, l_param_id, p_value);

    commit;
  exception
    when others then
      rollback;

      bars_audit.error(l_trace ||
                       'Ошибка при установке значения параметра: JOB_NAME = "' ||
                       p_job_name || '", PARAM = "' || p_param ||
                       '", VALUE = "' || p_value || '"' || chr(10) ||
                       dbms_utility.format_error_stack ||
                       dbms_utility.format_error_backtrace);

      bars_error.raise_nerror(G_MODULE,
                              'ASYNC_ERR',
                              'Ошибка при установке значения параметра: JOB_NAME = "' ||
                              p_job_name || '", PARAM = "' || p_param ||
                              '", VALUE = "' || p_value || '"');

  end set_job_param_val;

  ------------------------------------------------------------------------------
  -- set_job_param_val - Установить значение параметра (тип VARCHAR2) Задания Планировщика
  -- p_job_name            - Имя Задания Планировщика
  -- p_param_val_list      - Список пар Имя параметра/Значение параметра
  ------------------------------------------------------------------------------
  procedure set_job_param_val(p_job_name       in varchar2,
                              p_param_val_list in param_val_list_tt) is
    l_trace varchar2(2000) := G_MODULE || '.set_job_param_val: ';
  begin
    bars_audit.info(l_trace || 'Установка параметров задания JOB_NAME = "' ||
                    p_job_name || '"');

    if p_param_val_list is not null and p_param_val_list.count > 0 then
      for i in p_param_val_list.first .. p_param_val_list.last loop

        case get_param_type(p_param_val_list(i).param_name)
          when 'NUMBER' then
            set_job_param_val(p_job_name,
                              p_param_val_list(i).param_name,
                              p_param_val_list(i).param_num_val);
          when 'DATE' then
            set_job_param_val(p_job_name,
                              p_param_val_list(i).param_name,
                              p_param_val_list(i).param_date_val);
          else
            set_job_param_val(p_job_name,
                              p_param_val_list(i).param_name,
                              p_param_val_list(i).param_char_val);
        end case;

      end loop;
    end if;

  end set_job_param_val;

  ------------------------------------------------------------------------------
  -- set_job_date_sate - Установка даты и состояния в ASYNC_RUN
  -- p_job_name   - Имя Задания Планировщика
  -- p_date       - Тип даты ('START', 'END')
  -- p_date_val   - Значение даты
  -- p_state      - Статус
  ------------------------------------------------------------------------------
  procedure set_job_date_state(p_job_name in varchar2,
                               p_date     in varchar2,
                               p_date_val in date,
                               p_state    in varchar2 default null) is
    l_trace varchar2(2000) := G_MODULE || '.set_job_date_state: ';
  begin
    bars_audit.info('Для запуска "' || p_job_name || '" установка даты "' ||
                    p_date || '" в значение "' ||
                    to_char(p_date_val, 'YYYY-MM-DD') || '"');
    update async_run
       set start_date = case p_date
                          when 'START' then
                           p_date_val
                          else
                           start_date
                        end,
           end_date   = case p_date
                          when 'END' then
                           p_date_val
                          else
                           end_date
                        end,
           state      = p_state
     where job_name = p_job_name;
    commit;
  end set_job_date_state;

  ------------------------------------------------------------------------------
  -- set_err_msg  - Установка сообщения об ошике
  -- p_job_name   - Название задания планировщика
  -- p_err_msg    - Сообщение об ошибке
  ------------------------------------------------------------------------------
  procedure set_err_msg(p_job_name in varchar2, p_err_msg in varchar2) is
    pragma autonomous_transaction;
  begin
    update async_run
       set error_message = substr(p_err_msg, 1, 4000)
     where job_name = p_job_name;
    commit;
  exception
    when others then
      rollback;
      raise;
  end set_err_msg;

  ------------------------------------------------------------------------------
  -- run_job - Запустить Задачу Планировщика
  -- p_job_name   - Имя задачи планировщика
  ------------------------------------------------------------------------------
  procedure run_job(p_job_name in varchar2) is
    l_trace     varchar2(2000) := G_MODULE || '.run_job: ';
    l_sql       async_run.job_sql%type;
    l_user_msg  varchar2(4000);
    l_msg_param varchar2(200);
  begin
    bars_audit.info(l_trace || 'Запуск задачи Планировщика JOB_NAME = "' ||
                    p_job_name);

    select job_sql into l_sql from async_run where job_name = p_job_name;

    select user_message
      into l_user_msg
      from async_run ar
      join async_run_object aro
        on (aro.action_id = ar.action_id)
     where ar.job_name = p_job_name;

    -- Доустановить параметры значениями по-умолчанию
    for rc in (select ap.param_name,
                      ap.default_value,
                      apt.param_type,
                      apt.format_mask
                 from async_run ar
                 join async_action aa
                   on ar.action_id = aa.action_id
                 join async_sql_param asp
                   on asp.sql_id = aa.sql_id
                 join async_param ap
                   on ap.param_id = asp.param_id
                 join async_param_type apt
                   on apt.param_type = ap.param_type
                where ar.job_name = p_job_name
                  and ap.default_value is not null) loop

      case rc.param_type
        when 'DATE' then
          set_job_param_val(p_job_name,
                            rc.param_name,
                            to_date(rc.default_value, rc.format_mask));
        when 'NUMBER' then
          set_job_param_val(p_job_name,
                            rc.param_name,
                            to_number(rc.default_value, rc.format_mask));
        else
          set_job_param_val(p_job_name,
                            rc.param_name,
                            to_char(rc.default_value));
      end case;

    end loop;

    -- Проверить, все ли параметры установлены
    if regexp_instr(l_sql, ':[a-zA-Z]+\w*') > 0 then
      bars_audit.error(l_trace || 'Не все параметры установлены');
      bars_error.raise_nerror(G_MODULE,
                              'ASYNC_ERR',
                              'Не все параметры установлены для JOB_NAME = "' ||
                              p_job_name || '"');
    end if;

    -- Добавление сообщения
    if l_user_msg is not null then

      -- Подстановка параметров сообщения
      while regexp_like(l_user_msg, ':[a-zA-Z]+\w*') loop
        l_msg_param := regexp_substr(l_user_msg, ':[a-zA-Z]+\w*');
        l_user_msg  := regexp_replace(l_user_msg,
                                      l_msg_param,
                                      get_param_val(p_job_name,
                                                    substr(l_msg_param, 2)));
      end loop;

      l_sql := 'begin' || chr(10) || l_sql || chr(10) ||
               'bars_async.add_user_message(''' || p_job_name || ''', ''' ||
               l_user_msg || ''');' || chr(10) || 'end;';

    end if;

    update async_run set job_sql = l_sql where job_name = p_job_name;

    dbms_scheduler.create_job(job_name   => p_job_name,
                              job_type   => 'PLSQL_BLOCK',
                              job_action => l_sql,
                              start_date => systimestamp,
                              enabled    => true);
    commit;
  end run_job;

  ------------------------------------------------------------------------------
  -- run_job - Создать и запустить Задачу Планировщика
  -- p_action_code    - Код действия
  -- p_param_val_list - Список пар Имя параметра/Значение параметра
  ------------------------------------------------------------------------------
  procedure run_job(p_action_code    in varchar2,
                    p_param_val_list in param_val_list_tt) is
    l_trace    varchar2(2000) := G_MODULE || '.get_sql_params: ';
    l_job_name varchar2(30);
  begin
    bars_audit.trace(l_trace ||
                     'Создание и запуск Задачи из Действия ACTION_CODE = "' ||
                     p_action_code || '"');

    l_job_name := create_job(p_action_code);
    set_job_param_val(l_job_name, p_param_val_list);
    run_job(l_job_name);

  end run_job;

  ------------------------------------------------------------------------------
  -- get_sql_params - Полусить список параметров SQL-запроса
  -- p_sql_code   - Код SQL-запроса
  -- p_params     - Список параметров SQL-запроса
  ------------------------------------------------------------------------------
  procedure get_sql_params(p_sql_code in varchar,
                           p_params   out sys_refcursor) is
    l_trace varchar2(2000) := G_MODULE || '.get_sql_params: ';
  begin
    bars_audit.trace(l_trace ||
                     'Получить спиок параметров для SQL_CODE = "' ||
                     p_sql_code || '"');

    open p_params for
      select asp.param_pos,
             ap.param_name,
             ap.param_type,
             ap.default_value,
             ap.user_prompt
        from async_action aa
        join async_sql asq
          on asq.sql_id = aa.sql_id
        join async_sql_param asp
          on (asp.sql_id = asq.sql_id)
        join async_param ap
          on (ap.param_id = asp.param_id)
       where aa.action_code = p_sql_code
       order by asp.param_pos;

  end get_sql_params;

  ------------------------------------------------------------------------------
  -- set_progress_bar - Установить % выполнения задания
  -- p_percent        - % выполнения
  -- p_progres_text   - текст выполняющейся подзадачи
  ------------------------------------------------------------------------------
  procedure set_progress_bar(p_percent      in number,
                             p_progres_text in varchar2) is
    pragma autonomous_transaction;
  begin
    bars_audit.info(G_MODULE || '.set_progress_bar(p_percent=' ||
                    p_percent || ',G_JOB_NAME=' || G_JOB_NAME || ' );');

    if p_percent > 100 then
      raise_application_error(-20000,
                              'Максимальнодопустимий відсоток 100!');
    end if;

    update ASYNC_RUN
       set progress_bar = p_percent, progress_text = p_progres_text
     where job_name = G_JOB_NAME;

    commit;

  end set_progress_bar;

end bars_async;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_async.sql =========*** End *** 
 PROMPT ===================================================================================== 
 