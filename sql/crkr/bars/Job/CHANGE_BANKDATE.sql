declare
 e_job_exists exception;
 pragma exception_init( e_job_exists, -27477 );
begin
  DBMS_SCHEDULER.CREATE_JOB
  ( job_name        => 'CHANGE_BANKDATE',
    job_type        => 'STORED_PROCEDURE',
    job_action      => 'CHANGE_BANKING_DATE',
    start_date      => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY;BYDAY=MON,TUE,WED,THU,FRI,SAT;BYHOUR=0;BYMINUTE=1;BYSECOND=0',
    comments        => 'Автоматична зміна банкіської дати.',
    enabled         => TRUE );
exception
  when e_job_exists 
  then dbms_output.put_line( 'Job "BARS.CHANGE_BANKDATE" already exists.' );
end;
/