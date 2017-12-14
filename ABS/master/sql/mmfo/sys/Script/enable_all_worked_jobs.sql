begin
   for c in( select * from bars.tmp_all_enabled_jobs where job_name in ('IMPORT_DAY', 'IMPORT_MONTH') 
              or job_name like 'CIG%'
              or job_name like 'EAD%'
              or job_name like 'CRM_UPLOAD%') loop
       if c.job_type = 'S' then
          dbms_scheduler.enable(name => c.job_name);
       else
          dbms_ijob.broken( to_number(c.job_name), false);
       end if;
	   dbms_output.put_line('enabling job: '||c.job_name);
   end loop;       
end;
/
commit;
