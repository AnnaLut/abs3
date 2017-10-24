prompt alter imp_jobs timezone to 'Eu Kiev'
declare
  sd    TIMESTAMP;
  sd_tz timestamp with time zone;
begin
  sys.dbms_scheduler.get_attribute('BARS_DM.IMPORT_DAY', 'start_date', sd);
  sd_tz := from_tz(sd, 'Europe/Kiev');
  sys.dbms_scheduler.set_attribute('BARS_DM.IMPORT_DAY', 'start_date', sd_tz);
  dbms_output.put_line(sd);
  dbms_output.put_line(sd_tz);
end;
/
declare
  sd    TIMESTAMP;
  sd_tz timestamp with time zone;
begin
  sys.dbms_scheduler.get_attribute('BARS_DM.IMPORT_MONTH', 'start_date', sd);
  sd_tz := from_tz(sd, 'Europe/Kiev');
  sys.dbms_scheduler.set_attribute('BARS_DM.IMPORT_MONTH', 'start_date', sd_tz);
  dbms_output.put_line(sd);
  dbms_output.put_line(sd_tz);
end;
/