PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_EXECUTE_JOB.sql =========*** R
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE DPT_EXECUTE_JOB(p_jobcode in dpt_jobs_list.job_code%type,
                                            p_jobmode in number default null) is
  -- ho - с обслуживанием вкладов в выходные и праздничные дни
  g_modcode    varchar2(3) := 'DPT';
  title        varchar2(60);
  l_initbdate  date;
  l_bdate      date;
  l_userid     staff.id%type := gl.auid;
  l_jobrec     dpt_jobs_list%rowtype;
  l_curkf      banks.mfo%type;
  l_kf         banks.mfo%type;
  l_runid      dpt_jobs_jrnl.run_id%type;
  l_plsqlblock varchar2(250);
  type t_branchlist is table of branch.branch%type;
  l_branchlist t_branchlist;
  l_cursor     integer;
  l_tmpnum     integer;
  exptnobd exception;

  l_task_name     varchar2(1000);
  l_task_status   number;
  l_chunk_sql     clob; -- varchar2(1000);
  l_sql_stmt      clob; --varchar2(2000);
  l_try           number;
  l_status        number;
  l_saldoho_char  varchar2(100);
  l_last_mnth_dat date;
  l_skip          boolean := false;

  -- version 2.0 -- изменено Лившицем для Оптимизации ВЗД (распараллеливание процессов по бранчам)
  --
  -- поиск банк.даты в данном мфо
  --
  FUNCTION GET_BANKDATE(p_mfo banks.mfo%type) return date is
    l_par   params.par%type := 'BANKDATE';
    l_bdate date;
  begin
    select to_date(val, 'MM-DD-YYYY')
      into l_bdate
      from params$base
     where par = l_par
       and kf = p_mfo;
    return l_bdate;
  exception
    when no_data_found then
      raise exptnobd;
  end get_bankdate;
  ---
BEGIN
  l_task_name := p_jobcode || '_' || bc.current_mfo;
  title       := 'dpt_execute_job(' || lower(l_task_name) || '):';
  bars_audit.trace('%s entry with %s/%s',
                   title,
                   p_jobcode,
                   to_char(p_jobmode));
  bars_audit.info(title || ' start. Mode:' || to_char(p_jobmode));

  l_initbdate := gl.bdate;
  bars_audit.trace('%s init gl.bdate - %s',
                   title,
                   to_char(l_initbdate, 'dd.mm.yyyy'));
  bars_audit.info(title || ' init gl.bdate - ' ||
                  to_char(l_initbdate, 'dd.mm.yyyy'));

  -- поиск задания по символьному коду
  begin
    select * into l_jobrec from dpt_jobs_list where job_code = p_jobcode;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'JOB_NOT_FOUND', p_jobcode);
  end;
  bars_audit.trace('%s job № %s, %s',
                   title,
                   to_char(l_jobrec.job_id),
                   l_jobrec.job_proc);
  bars_audit.info(title || ' job № ' || to_char(l_jobrec.job_id) || ',' ||
                  l_jobrec.job_proc);

  if p_jobmode is null then
    l_plsqlblock := 'begin ' || l_jobrec.job_proc ||
                    '(:dptid, :runid, :branch, :date); end;';
  else
    l_plsqlblock := 'begin ' || l_jobrec.job_proc ||
                    '(:dptid, :runid, :branch, :date, :mode); end;';
  end if;

  -- фиксация запуска автомат.задания в журнале
  dpt_jobs_audit.p_start_job(p_jobid  => l_jobrec.job_id,
                             p_branch => sys_context('bars_context',
                                                     'user_branch'),
                             p_bdate  => l_initbdate,
                             p_user   => l_userid,
                             p_run_id => l_runid);
  bars_audit.trace('%s runid = %s', title, to_char(l_runid));
  bars_audit.info(title || ' runid = ' || to_char(l_runid));

  select branch
    bulk collect
    into l_branchlist
    from our_branch
   where branch <> '/';

  -- определяем последнюю банк.дату месяца
  select dat_next_u(add_months(trunc(l_initbdate, 'MM'), 1), -1)
    into l_last_mnth_dat
    from dual;

  -- накопление врем.таблицы saldo_holiday для ускорения работы процедуры
  -- начисления процентов по календарным датам движения средств
  -- выполняется только для процедуры начисления %% в конце месяца (и только, если это, действительно, конец месяца)
  l_saldoho_char := 'acrn.set_collect_salho(0); ';

  IF p_jobcode = 'JOB_MINT' THEN

    if l_last_mnth_dat = l_initbdate then
      l_jobrec.job_proc := 'dpt_web.auto_make_int_monthly_opt';
      l_plsqlblock      := 'begin dpt_web.auto_make_int_monthly_opt(:dptid, :runid, :branch, :date, :mode); end;';
      bars_audit.info(title || ' start collect saldo_holiday');
      collect_saldoholiday;
      l_saldoho_char := 'acrn.set_collect_salho(1); ';
      bars_audit.info(title || ' finish collect saldo_holiday');
    else
      l_skip := true;
    end if;

  ELSIF (p_jobcode = 'JOB_CLOS') THEN
    l_jobrec.job_proc := 'dpt_web.dpt_web.auto_move2archive_opt';
    l_plsqlblock      := 'begin dpt_web.auto_move2archive_opt(:runid, :date); end;';
  END IF;

  bars_audit.info(title || ' start update accounts (class 7) set opt = 1');
  -- устанавливаем пакетную оплату для 7-го класса счетов по депозитам
  update accounts a
     set opt = 1
   where (dazs is null or dazs > sysdate)
     and opt is null
     and nbs like '7%'
     and exists (select null
            from dpt_ob22 do
           where do.nbs_exp like '7%'
             and do.nbs_exp = a.nbs
             and do.ob22_exp = a.ob22);
  commit;
  bars_audit.info(title || ' finish update accounts (class 7) set opt = 1');

  IF NOT l_skip THEN
    IF l_jobrec.run_lvl = -1 THEN
      -- lvl -1 -- старая методика без распараллеливания
      -- цикл по подразделениям банка
      <<branch_loop>>
      for i in 1 .. l_branchlist.count loop

        bars_audit.trace('%s branch = %s', title, l_branchlist(i));
        bars_audit.info(title || ' branch = ' || l_branchlist(i));

        begin

          l_kf := bars_context.extract_mfo(l_branchlist(i));
          -- поиск банк.даты для 1-го подразделения очередного филиала
          if (l_curkf is null or l_curkf <> l_kf) then
            l_bdate  := get_bankdate(l_kf);
            l_curkf  := l_kf;
            gl.bdate := l_bdate;
            bars_audit.trace('%s gl.bdate := %s',
                             title,
                             to_char(l_bdate, 'dd.mm.yyyy'));
            bars_audit.info(title || ' gl.bdate := ' ||
                            to_char(l_bdate, 'dd.mm.yyyy'));
          end if;
          bars_context.subst_branch(l_branchlist(i));

          bars_audit.info(title || ' L_BRANCHLIST(I) := ' ||
                          l_branchlist(i) || ' L_BDATE := ' || l_bdate);

          l_cursor := dbms_sql.open_cursor;
          begin
            dbms_sql.parse(l_cursor, l_plsqlblock, dbms_sql.native);
            dbms_sql.bind_variable(l_cursor, 'dptid', 0);
            dbms_sql.bind_variable(l_cursor, 'runid', l_runid);
            dbms_sql.bind_variable(l_cursor, 'branch', l_branchlist(i));
            dbms_sql.bind_variable(l_cursor, 'date', l_bdate);
            if p_jobmode is not null then
              dbms_sql.bind_variable(l_cursor, 'mode', p_jobmode);
            end if;
            l_tmpnum := dbms_sql.execute(l_cursor);
            dbms_sql.close_cursor(l_cursor);
          exception
            when others then
              dbms_sql.close_cursor(l_cursor);
              raise;
          end;

        exception
          when exptnobd then
            bars_audit.error(title || ' не найдена банк.дата для МФО ' || l_kf);
        end;

      end loop branch_loop;

    ELSIF l_jobrec.run_lvl = 1 THEN
      -- lvl 1 -- запуск на уровне МФО
      bars_audit.info(title || ' started');
      l_cursor := dbms_sql.open_cursor;
      begin
        dbms_sql.parse(l_cursor, l_plsqlblock, dbms_sql.native);
        dbms_sql.bind_variable(l_cursor, 'runid', l_runid);
        dbms_sql.bind_variable(l_cursor, 'date', l_initbdate);
        l_tmpnum := dbms_sql.execute(l_cursor);
        dbms_sql.close_cursor(l_cursor);
      exception
        when others then
          dbms_sql.close_cursor(l_cursor);
          raise;
      end;
      bars_audit.info(title || ' finished ');

    ELSIF l_jobrec.run_lvl = 2 THEN
      -- lvl 2   -- запуск задач на бранчах 2-го уровня

      -- чтоб не слетала сессия (и, как результат, контекст), устанавливаем ей параметр для большого таймаута
      bars_login.set_long_session();
      l_bdate := l_initbdate;
      bars_audit.trace('%s gl.bdate := %s',
                       title,
                       to_char(l_bdate, 'dd.mm.yyyy'));
      bars_audit.info(title || ' jobcode = ' || p_jobcode ||
                      ' gl.bdate := ' || to_char(l_bdate, 'dd.mm.yyyy'));
      -- определяем уникальное имя таски
      l_task_name := p_jobcode || '_' || bc.current_mfo;
      -- проверяем, есть ли уже такая созданная
      begin
        select dbms_parallel_execute.task_status(l_task_name)
          into l_task_status
          from dual;
      exception
        when others then
          l_task_status := -1;
      end;
      -- если есть, удаляем
      if l_task_status > 0 then
        dbms_parallel_execute.drop_task(l_task_name);
        bars_audit.info(title || ' task ' || l_task_name || ' droped');
      end if;
      -- создаем таску
      dbms_parallel_execute.create_task(task_name => l_task_name);

      bars_audit.info(title || ' task ' || l_task_name || ' created');
      -- определяем чанку - выборка бранчей второго уровня
      l_chunk_sql := 'SELECT DISTINCT REPLACE(BRANCH,''/'') BR, REPLACE(BRANCH,''/'') BR ' ||
                     'FROM OUR_BRANCH ' ||
                     'WHERE BRANCH <> ''/'' AND (DATE_CLOSED IS NULL OR DATE_CLOSED > SYSDATE) AND BARS.BRANCH_UTL.GET_BRANCH_LEVEL(BRANCH) = 2';

      bars_audit.info(title || 'chunk sql = ' || l_chunk_sql);
      -- создаем чанку
      dbms_parallel_execute.create_chunks_by_sql(task_name => l_task_name,
                                                 sql_stmt  => l_chunk_sql,
                                                 by_rowid  => false);

      bars_audit.info(title || ' chunks for task ' || l_task_name ||
                      'created');
      -- код, который будет выполняться в параллели
      l_sql_stmt := 'DECLARE L_BRANCH VARCHAR2(32); ' || chr(10) ||
                    'L_BDATE DATE := to_date('''||to_char(l_bdate, 'DD.MM.YYYY') ||''',''DD.MM.YYYY''); ' || chr(10) ||
                    'BEGIN' || chr(10) ||
                    'BARS_LOGIN.LOGIN_USER(SUBSTR(SYS_GUID(),1,32), ' ||to_char(user_id) || ', NULL, NULL); ' || chr(10) ||
                    l_saldoho_char || chr(10) ||
                    'L_BRANCH := to_char(:start_id);' || chr(10) ||
                    'L_BRANCH := to_char(:end_id);' || chr(10) ||
                    'SELECT ''/''||substr(l_branch,1,6)||''/''||substr(l_branch,7,6)||''/'' INTO L_BRANCH FROM DUAL;' || chr(10) ||
                    'BC.GO(L_BRANCH); ' || chr(10) ||
                    'GL.PL_DAT(L_BDATE); ' || chr(10) ||
                    'BARS_AUDIT.INFO(''' || title ||' - chunk start with branch ''||L_BRANCH ); ' || chr(10) ||
                    l_jobrec.job_proc || '(0, ' || to_char(l_runid) ||', L_BRANCH, L_BDATE' ||
                    case
                      when p_jobmode is not null then
                       ', ' || to_char(p_jobmode)
                      else
                       ''
                      end || '); ' || chr(10) ||
                    'BARS_AUDIT.INFO(''' || title ||' - chunk finished with branch ''||L_BRANCH ); ' || chr(10) ||
                    'COMMIT; ' || chr(10) ||
                    'BC.HOME; ' || chr(10) ||
                    'BARS_LOGIN.LOGOUT_USER; ' || chr(10) ||
                    'EXCEPTION WHEN OTHERS THEN' || chr(10) ||
                    'BARS_AUDIT.ERROR(''' || title ||' - chunk exception - ''|| sqlerrm || '' '' || dbms_utility.format_error_backtrace); ' || chr(10) ||
                    'BARS_LOGIN.LOGOUT_USER; ' || chr(10) ||
                    'END;';

      bars_audit.info(title || 'sql_statement: ' || l_sql_stmt);
      -- запуск таски
      dbms_parallel_execute.run_task(task_name      => l_task_name,
                                     sql_stmt       => l_sql_stmt,
                                     language_flag  => dbms_sql.native,
                                     parallel_level => 10);
      bars_audit.info(title || ' task runed');
      -- проверка окончания работы таски
      l_try    := 0;
      l_status := dbms_parallel_execute.task_status(l_task_name);
      while (l_try < 2 and l_status != dbms_parallel_execute.finished) loop
        l_try := l_try + 1;
        dbms_parallel_execute.resume_task(l_task_name);
        l_status := dbms_parallel_execute.task_status(l_task_name);
      end loop;
      -- удаляем таску
      dbms_parallel_execute.drop_task(l_task_name);
      -- возвращаем параметр сессии на обычный
      if bars_login.is_long_session then
        bars_login.cleare_long_session;
      end if;

      bars_audit.info(title || ' task ' || l_task_name || ' finished');

    ELSIF l_jobrec.run_lvl = 3 THEN
      -- lvl 3 -- запуск задач на бранчах 3-го уровня
      -- чтоб не слетала сессия (и, как результат, контекст), устанавливаем ей параметр для большого таймаута
      bars_login.set_long_session();
      l_bdate := l_initbdate;

      bars_audit.trace('%s gl.bdate := %s',
                       title,
                       to_char(l_bdate, 'dd.mm.yyyy'));
      bars_audit.info(title || ' jobcode = ' || p_jobcode ||
                      ' gl.bdate := ' || to_char(l_bdate, 'dd.mm.yyyy'));
      -- определяем уникальное имя таски
      l_task_name := p_jobcode || '_' || bc.current_mfo;
      -- проверяем, есть ли уже такая созданная
      begin
        select dbms_parallel_execute.task_status(l_task_name)
          into l_task_status
          from dual;
      exception
        when others then
          l_task_status := -1;
      end;
      -- если есть, удаляем
      if l_task_status > 0 then
        dbms_parallel_execute.drop_task(l_task_name);
        bars_audit.info(title || ' task ' || l_task_name || ' droped');
      end if;
      -- создаем таску
      dbms_parallel_execute.create_task(task_name => l_task_name);

      bars_audit.info(title || ' task ' || l_task_name || ' created');
      -- определяем чанку - выборка бранчей второго уровня
      l_chunk_sql := 'SELECT DISTINCT REPLACE(BRANCH,''/'') BR, REPLACE(BRANCH,''/'') BR ' ||
                     'FROM OUR_BRANCH ' ||
                     'WHERE BRANCH <> ''/'' AND (DATE_CLOSED IS NULL OR DATE_CLOSED > SYSDATE) AND BARS.BRANCH_UTL.GET_BRANCH_LEVEL(BRANCH) = 2';

      bars_audit.info(title || 'chunk sql = ' || l_chunk_sql);
      -- создаем чанку
      dbms_parallel_execute.create_chunks_by_sql(task_name => l_task_name,
                                                 sql_stmt  => l_chunk_sql,
                                                 by_rowid  => false);

      bars_audit.info(title || ' chunks for task ' || l_task_name ||
                      'created');
      -- код, который будет выполняться в параллели (в нем цикл, бегущий по бранчам 3-го уровня)
      l_sql_stmt := 'DECLARE L_BRANCH VARCHAR2(32); ' || chr(10) ||
                    'L_BDATE DATE := to_date('''||to_char(l_bdate, 'DD.MM.YYYY') ||''',''DD.MM.YYYY''); ' || chr(10) ||
                    'BEGIN' || chr(10) ||
                    'BARS_LOGIN.LOGIN_USER(SUBSTR(SYS_GUID(),1,32), ' || to_char(user_id) || ', NULL, NULL); ' || chr(10) ||
                    l_saldoho_char || chr(10) ||
                    'L_BRANCH := to_char(:start_id);' || chr(10) ||
                    'L_BRANCH := to_char(:end_id);' || chr(10) ||
                    'SELECT ''/''||substr(l_branch,1,6)||''/''||substr(l_branch,7,6)||''/'' INTO L_BRANCH FROM DUAL;' || chr(10) ||
                    'BC.GO(L_BRANCH); ' || chr(10) ||
                    'GL.PL_DAT(L_BDATE); ' || chr(10) ||
                    'BARS_AUDIT.INFO(''' || title ||' - chunk start with branch ''||L_BRANCH ); ' || chr(10) ||
                    'FOR BR IN (SELECT * FROM OUR_BRANCH WHERE (DATE_CLOSED IS NULL OR DATE_CLOSED > L_BDATE) AND BRANCH_UTL.GET_BRANCH_LEVEL(BRANCH) = 3) LOOP' || chr(10) ||
                    'BARS_AUDIT.INFO(''' || title ||' ---===--- branch ''||BR.BRANCH ); ' || chr(10) ||
                    l_jobrec.job_proc || '(0, ' || to_char(l_runid) ||', BR.BRANCH, L_BDATE' ||
                    case
                      when p_jobmode is not null then
                       ', ' || to_char(p_jobmode)
                      else
                       ' '
                    end || '); ' || chr(10) ||
                    'END LOOP; ' || chr(10) ||
                    'BARS_AUDIT.INFO(''' || title ||' - chunk finished with branch ''||L_BRANCH ); ' || chr(10) ||
                    'COMMIT; ' || chr(10) ||
                    'BC.HOME; ' || chr(10) ||
                    'BARS_LOGIN.LOGOUT_USER; ' || chr(10) ||
                    'EXCEPTION WHEN OTHERS THEN' || chr(10) ||
                    'BARS_AUDIT.ERROR(''' || title ||' - chunk exception - ''|| sqlerrm || '' '' || dbms_utility.format_error_backtrace); ' || chr(10) ||
                    'BARS_LOGIN.LOGOUT_USER; ' || chr(10) ||
                    'END;';

      bars_audit.info(title || 'sql_statement: ' || l_sql_stmt);
      -- запуск таски
      dbms_parallel_execute.run_task(task_name      => l_task_name,
                                     sql_stmt       => l_sql_stmt,
                                     language_flag  => dbms_sql.native,
                                     parallel_level => 10);
      bars_audit.info(title || ' task runed');
      -- проверка окончания работы таски
      l_try    := 0;
      l_status := dbms_parallel_execute.task_status(l_task_name);
      while (l_try < 2 and l_status != dbms_parallel_execute.finished) loop
        l_try := l_try + 1;
        dbms_parallel_execute.resume_task(l_task_name);
        l_status := dbms_parallel_execute.task_status(l_task_name);
      end loop;
      -- удаляем таску
      dbms_parallel_execute.drop_task(l_task_name);
      -- возвращаем параметр сессии на обычный
      if bars_login.is_long_session then
        bars_login.cleare_long_session;
      end if;

      bars_audit.info(title || ' task ' || l_task_name || ' finished');
    END IF; -- lvl

  ELSE
    bars_audit.info(title ||' Procedure skipped');
  END IF; -- l_skip

  bars_context.set_context;
  gl.bdate := l_initbdate;
  bars_audit.trace('%s gl.bdate := %s',
                   title,
                   to_char(l_initbdate, 'dd.mm.yyyy'));
  bars_audit.info(title || ' gl.bdate := ' ||
                  to_char(l_initbdate, 'dd.mm.yyyy'));

  bars_audit.info(title || ' успешно выполнена процедура ' ||
                  l_jobrec.job_name);

  -- фиксация успешного окончания автомат.задания в журнале
  dpt_jobs_audit.p_finish_job(l_runid);

  commit;

EXCEPTION
  when others then
    bars_context.set_context;
    gl.bdate := l_initbdate;
    bars_audit.trace('%s gl.bdate := %s',
                     title,
                     to_char(l_initbdate, 'dd.mm.yyyy'));
    bars_audit.error(title || sqlerrm || ' ' ||
                     dbms_utility.format_error_backtrace);
    bars_error.raise_error(g_modcode,
                           999,
                           substr(title || ' ' || sqlerrm, 1, 254));
    dbms_parallel_execute.drop_task(l_task_name);
    if bars_login.is_long_session then
      bars_login.cleare_long_session;
    end if;
    bars_audit.info(title || ' task ' || l_task_name ||
                    ' droped (by exception)');
    -- фиксация окончания автомат.задания с ошибкой в журнале
    dpt_jobs_audit.p_finish_job(l_runid, substr(sqlerrm, 1, 254));
    rollback;
END;
/
show err;

PROMPT *** Create  grants  DPT_EXECUTE_JOB ***
grant EXECUTE                                                                on DPT_EXECUTE_JOB to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_EXECUTE_JOB to DPT_ADMIN;
grant EXECUTE                                                                on DPT_EXECUTE_JOB to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARS/Procedure/DPT_EXECUTE_JOB.sql ========*** End ***
PROMPT ===================================================================================== 

