

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_EXECUTE_JOB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_EXECUTE_JOB ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_EXECUTE_JOB 
 (p_jobcode  in  dpt_jobs_list.job_code%type,
  p_jobmode  in  number default null)
is
  -- HO - с обслуживанием вкладов в выходные и праздничные дни
  g_modcode    varchar2(3)    := 'DPT';
  title        varchar2(60);
  l_initbdate  date;
  l_bdate      date;
  l_userid     staff.id%type  := gl.aUID;
  l_jobrec     dpt_jobs_list%rowtype;
  l_curkf      banks.mfo%type;
  l_kf         banks.mfo%type;
  l_runid      dpt_jobs_jrnl.run_id%type;
  l_plsqlblock varchar2(250);
  type         t_branchlist is table of branch.branch%type;
  l_branchlist t_branchlist;
  l_cursor     integer;
  l_tmpnum     integer;
  exptNoBD     exception;
  --
  -- поиск банк.даты в данном МФО
  --
  function get_bankdate (p_mfo banks.mfo%type)
    return date
  is
    l_par   params.par%type := 'BANKDATE';
    l_bdate date;
  begin
    select to_date(val, 'MM-DD-YYYY')
      into l_bdate
      from params$base
     where par = l_par
       and kf  = p_mfo;
    return l_bdate;
  exception
    when no_data_found then
      raise exptNoBD;
  end get_bankdate;
  ---
begin

  title := 'dpt_execute_job('||lower(p_jobcode)||'):';

  bars_audit.trace('%s entry with %s/%s', title, p_jobcode, to_char(p_jobmode));

  -- установка контекста
  bars_context.set_context;
  l_initbdate := gl.bdate;
  bars_audit.trace('%s init gl.bdate - %s', title, to_char(l_initbdate,'dd.mm.yyyy'));

  -- поиск задания по символьному коду
  begin
    select * into l_jobrec from dpt_jobs_list where job_code = p_jobcode;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'JOB_NOT_FOUND', p_jobcode);
  end;
  bars_audit.trace('%s job № %s, %s', title, to_char(l_jobrec.job_id), l_jobrec.job_proc);

  if p_jobmode is null then
     l_plsqlblock := 'begin '||l_jobrec.job_proc||'(:dptid, :runid, :branch, :date); end;';
  else
     l_plsqlblock := 'begin '||l_jobrec.job_proc||'(:dptid, :runid, :branch, :date, :mode); end;';
  end if;

  -- фиксация запуска автомат.задания в журнале
  dpt_jobs_audit.p_start_job (p_jobid  => l_jobrec.job_id,
                              p_branch => sys_context('bars_context','user_branch'),
                              p_bdate  => l_initbdate,
                              p_user   => l_userid,
                              p_run_id => l_runid);
  bars_audit.trace('%s runid = %s', title, to_char(l_runid));

  select branch bulk collect into l_branchlist from our_branch where branch <> '/';

  -- накопление врем.таблицы saldo_holiday для ускорения работы процедуры
  -- начисления процентов по календарным датам движения средств
  if p_jobcode in ('JOB_INTX', 'JOB_INTF', 'JOB_MINT') then
     collect_saldoholiday;
  end if;

  -- для нарахування відсотків ОЩАДБАНКу
  if (getglobaloption('BANKTYPE') = 'SBER') and (p_jobcode = 'JOB_MINT') then

    l_plsqlblock := 'begin dpt_web.auto_make_int_monthly_opt(:dptid, :runid, :branch, :date, :mode); end;';

    bars_audit.info(title||l_plsqlblock);
    bars_audit.trace('%s branch = /all_branch/, bdate = %s', title, to_char(l_bdate,'dd.mm.yyyy'));

    l_bdate := gl.bdate; -- glb_bankdate;

    l_cursor := dbms_sql.open_cursor;

    begin
      dbms_sql.parse(l_cursor, l_plsqlblock, dbms_sql.native);
      dbms_sql.bind_variable(l_cursor, 'dptid',  0              );
      dbms_sql.bind_variable(l_cursor, 'runid',  l_runid        );
      dbms_sql.bind_variable(l_cursor, 'branch', '/all_branch/' );
      dbms_sql.bind_variable(l_cursor, 'date',   l_bdate        );
      if p_jobmode is not null then
         dbms_sql.bind_variable(l_cursor, 'mode', p_jobmode     );
      end if;
      l_tmpnum := dbms_sql.execute(l_cursor);
      dbms_sql.close_cursor(l_cursor);
    exception
      when others then
        dbms_sql.close_cursor(l_cursor);
        raise;
    end;

  else

    -- цикл по подразделениям банка
    <<branch_loop>>
    for i in 1..l_branchlist.count loop

      bars_audit.trace('%s branch = %s', title, l_branchlist(i));

      begin

        l_kf := bars_context.extract_mfo(l_branchlist(i));
        -- поиск банк.даты для 1-го подразделения очередного филиала
        if (l_curkf is null or l_curkf <> l_kf) then
            l_bdate  := get_bankdate (l_kf);
            l_curkf  := l_kf;
            gl.bdate := l_bdate;
            bars_audit.trace('%s gl.bdate := %s', title, to_char(l_bdate,'dd.mm.yyyy'));
        end if;
        bars_context.subst_branch (l_branchlist(i));

        l_cursor := dbms_sql.open_cursor;
        begin
          dbms_sql.parse(l_cursor, l_plsqlblock, dbms_sql.native);
          dbms_sql.bind_variable(l_cursor, 'dptid',  0              );
          dbms_sql.bind_variable(l_cursor, 'runid',  l_runid        );
          dbms_sql.bind_variable(l_cursor, 'branch', l_branchlist(i));
          dbms_sql.bind_variable(l_cursor, 'date',   l_bdate        );
          if p_jobmode is not null then
             dbms_sql.bind_variable(l_cursor, 'mode', p_jobmode     );
          end if;
          l_tmpnum := dbms_sql.execute(l_cursor);
          dbms_sql.close_cursor(l_cursor);
        exception
          when others then
            dbms_sql.close_cursor(l_cursor);
            raise;
        end;

      exception
        when exptNoBD then
          bars_audit.error(title||' не найдена банк.дата для МФО '||l_kf);
      end;

    end loop branch_loop;

  end if;

  bars_context.set_context;
  gl.bdate := l_initbdate;
  bars_audit.trace('%s gl.bdate := %s', title, to_char(l_initbdate,'dd.mm.yyyy'));

  bars_audit.info(title||' успешно выполнена процедура '||l_jobrec.job_name);

  -- фиксация успешного окончания автомат.задания в журнале
  dpt_jobs_audit.p_finish_job (l_runid);

  commit;

exception
  when others then
    bars_context.set_context;
    gl.bdate := l_initbdate;
    bars_audit.trace('%s gl.bdate := %s', title, to_char(l_initbdate,'dd.mm.yyyy'));
    bars_error.raise_error(g_modcode, 999, substr(title||' '||sqlerrm, 1, 254));
    -- фиксация окончания автомат.задания с ошибкой в журнале
    dpt_jobs_audit.p_finish_job (l_runid, substr(sqlerrm, 1, 254));
    rollback;
end;
/
show err;

PROMPT *** Create  grants  DPT_EXECUTE_JOB ***
grant EXECUTE                                                                on DPT_EXECUTE_JOB to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_EXECUTE_JOB to DPT_ADMIN;
grant EXECUTE                                                                on DPT_EXECUTE_JOB to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_EXECUTE_JOB.sql =========*** E
PROMPT ===================================================================================== 
