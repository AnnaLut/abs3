begin
 dbms_scheduler.create_job(job_name  =>'RUN_FORMATED_XML',
                             program_name=>'RUN_FORMATED_XML_OBJECTS',
                             enabled => false,
                             auto_drop => false);
  exception when others then 
  if sqlcode=-955 then null;
  end if;
end;
/