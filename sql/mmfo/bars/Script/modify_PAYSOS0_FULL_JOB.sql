begin
  sys.dbms_scheduler.disable(name => 'BARS.PAYSOS0_FULL_JOB',force => true);
end;
/

begin
  sys.dbms_scheduler.disable(name => 'BARS.PAYSOS0_FULL_PROGRAM',force => true);
  sys.dbms_scheduler.set_attribute(name => 'BARS.PAYSOS0_FULL_PROGRAM', attribute => 'program_type', value => 'PLSQL_BLOCK');
  sys.dbms_scheduler.set_attribute(name => 'BARS.PAYSOS0_FULL_PROGRAM', attribute => 'program_action', value => 'declare
  
      l_job  varchar2(400):=''PAYSOS0_'';
      l_userid number;
      l_jobact varchar2(10000);
      function running(p_job varchar2)
        return boolean
        is
        l_state varchar2(400);
      begin
  
            select state into l_state
            from dba_scheduler_jobs
            where job_name=upper(p_job);
  
  
            if l_state=''RUNNING''
            then
               return true;
            else
               return false;
            end if;
  
      end running;
  begin
    -- Шукаємо технічого користувач від якого будемо працювати
  
    for c in (select * from mv_kf)
    
     loop
      l_jobact := null;
      begin
        l_jobact := ''begin bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                              p_userid    => 1,
                                              p_hostname  => null,
                                              p_appname   => ''''PAYSOS0'''');
                     bc.go('' || c.kf || ''); gl.PAYSOS0(); end;'';
        dbms_scheduler.create_job(job_name   => l_job || c.kf,
                                  job_type   => ''PLSQL_BLOCK'',
                                  job_action => l_jobact,
                                  auto_drop  => false);
      exception
        when others then
          if (sqlcode = -27477) then
            null;
          else
            raise;
          end if;
      end;
    
      if not running(l_job || c.kf) then
        if l_jobact is not null then
          dbms_scheduler.set_attribute(name      => l_job || c.kf,
                                       attribute => ''job_action'',
                                       value     => l_jobact);
        end if;
        dbms_scheduler.run_job(l_job || c.kf, false);
      
      end if;
    
    end loop;
  
  end;');
  sys.dbms_scheduler.enable(name => 'BARS.PAYSOS0_FULL_PROGRAM');
end;
/

begin
  sys.dbms_scheduler.set_attribute(name => 'BARS.PAYSOS0_FULL_JOB', attribute => 'schedule_name', value => 'BARS.INTERVAL_5_MINUTES');
end;
/

begin
  sys.dbms_scheduler.enable(name => 'BARS.PAYSOS0_FULL_JOB');
end;
/
