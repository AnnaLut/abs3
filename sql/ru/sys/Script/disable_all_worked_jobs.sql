delete from bars.tmp_all_enabled_jobs;
commit;
insert into bars.tmp_all_enabled_jobs(owner, job_type, job_name)
select owner, 'S', job_name from dba_scheduler_jobs where owner in ('BARS','BARSUPL','BARS_DM','DM', 'PFU') and state = 'SHEDULED'
union all
select  schema_user, 'J', to_char(job) from dba_jobs where broken = 'N';


begin
   for c in( select * from bars.tmp_all_enabled_jobs where job_name in ('IMPORT_DAY', 'IMPORT_MONTH') 
              or job_name like 'CIG%'
              or job_name like 'EAD%'
              or job_name like 'CRM_UPLOAD%') loop
       if c.job_type = 'S' then
          dbms_scheduler.disable(name => c.job_name, force => true);
       else
          dbms_ijob.broken( to_number(c.job_name), true);
       end if;
	   dbms_output.put_line('disabling job: '||c.job_name);
   end loop;       
end;
/

commit;