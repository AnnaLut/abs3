prompt alter crm_upload_jobs timezone to 'Eu Kiev'
declare
  sd    TIMESTAMP;
  sd_tz timestamp with time zone;
begin
  sys.dbms_scheduler.get_attribute('BARSUPL.CRM_UPLOAD', 'start_date', sd);
  sd_tz := from_tz(sd, 'Europe/Kiev');
  sys.dbms_scheduler.set_attribute('BARSUPL.CRM_UPLOAD', 'start_date', sd_tz);
  dbms_output.put_line(sd);
  dbms_output.put_line(sd_tz);
end;
/
declare
  sd    TIMESTAMP;
  sd_tz timestamp with time zone;
begin
  sys.dbms_scheduler.get_attribute('BARSUPL.CRM_UPLOAD_FULL', 'start_date', sd);
  sd_tz := from_tz(sd, 'Europe/Kiev');
  sys.dbms_scheduler.set_attribute('BARSUPL.CRM_UPLOAD_FULL', 'start_date', sd_tz);
  dbms_output.put_line(sd);
  dbms_output.put_line(sd_tz);
end;
/