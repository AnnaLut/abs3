create or replace procedure jobs_files_processing
is

    l_job  varchar2(400):='FILES_PROCESSING_';

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
                                
   for c in ( select * from mv_kf)
                                
       loop 
            begin
                dbms_scheduler.create_job(job_name=>l_job||c.kf, job_type=>'PLSQL_BLOCK', job_action=>'begin bc.go('||c.kf||');ow_files_proc.files_processing('||c.kf||');end;',auto_drop=>false);
            exception when others then
              if (sqlcode = -27477) then null;
              else raise; end if;
            end;
       
            if not running(l_job||c.kf)
                then
                dbms_scheduler.run_job(l_job||c.kf, false);
            
            end if; 
            
       end loop;
       
end;    
  /