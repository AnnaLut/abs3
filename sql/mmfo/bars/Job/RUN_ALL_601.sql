 begin
 dbms_scheduler.create_job(job_name  =>'RUN_ALL_601',
                             program_name=>'RUN_ALL_601_OBJECTS',
                             enabled => false,
                             auto_drop => false);
  exception when others then 
  if sqlcode=-955 then null;
  end if;
end;
/