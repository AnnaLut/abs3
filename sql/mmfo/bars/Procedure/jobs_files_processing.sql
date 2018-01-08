create or replace procedure jobs_files_processing
is

    l_job  varchar2(400):='FILES_PROCESSING_';
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


          if l_state='RUNNING'
          then
             return true;
          else
             return false;
          end if;

    end running;
begin
   -- Шукаємо технічого користувач від якого будемо працювати
   
   begin
     select t.user_id
       into l_userid
       from V_WEB_USERMAP t
      where t.webuser = 'tech_bpk';
   exception
     when no_data_found then
       l_userid := 1;
   end;
   for c in ( select * from mv_kf)

       loop
            l_jobact := null;
            begin
                l_jobact := 'begin bc.go('||c.kf||');ow_files_proc.files_processing('||c.kf||','||l_userid||');end;';
                dbms_scheduler.create_job(job_name=>l_job||c.kf, job_type=>'PLSQL_BLOCK', job_action=>l_jobact,auto_drop=>false);
            exception when others then
              if (sqlcode = -27477) then null;
              else raise; end if;
            end;

            if not running(l_job||c.kf)
                then
                if l_jobact is not null then
                    dbms_scheduler.set_attribute(name => l_job||c.kf, attribute => 'job_action', value => l_jobact);
                end if;
                dbms_scheduler.run_job(l_job||c.kf, false);

            end if;

       end loop;

end;
/