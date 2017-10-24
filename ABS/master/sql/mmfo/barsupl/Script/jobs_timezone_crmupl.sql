prompt alter crm_upload_jobs timezone to 'Eu Kiev'
declare
  sd    TIMESTAMP;
  sd_tz timestamp with time zone;
begin
  for rec in (select job_name from user_scheduler_jobs where job_name like '%CRM_UPLOAD%')
  loop
  sys.dbms_scheduler.get_attribute('BARSUPL.'||rec.job_name, 'start_date', sd);
  sd_tz := from_tz(sd, 'Europe/Kiev');
  sys.dbms_scheduler.set_attribute('BARSUPL.'||rec.job_name, 'start_date', sd_tz);
  dbms_output.put_line(sd);
  dbms_output.put_line(sd_tz);  
  end loop;
end;
/