SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create job MWAY_PAY_REVERSAL
prompt -- ======================================================

declare
  l_job_nm               varchar2(30);
  e_job_not_exists  exception;
  pragma exception_init( e_job_not_exists, -27475 );
  e_job_exists           exception;
  pragma exception_init( e_job_exists, -27477 );
begin
  l_job_nm := 'MWAY_PAY_REVERSAL';
  begin
    DBMS_SCHEDULER.DROP_JOB
    ( job_name        => l_job_nm
    , force           => TRUE );
    dbms_output.put_line( 'Job "'||l_job_nm||'" dropped.' );
  exception
    when e_job_not_exists 
    then null;
  end;
  DBMS_SCHEDULER.CREATE_JOB
  ( job_name        => l_job_nm
  , job_type        => 'STORED_PROCEDURE'
  , job_action      => 'BARS.MWAY_MGR.PAY_REVERSAL'
  , start_date      => trunc(SYSTIMESTAMP,'HH24') + INTERVAL '1' HOUR
  , repeat_interval => 'FREQ=HOURLY; INTERVAL=2'
  , comments        => 'Сторнування реверсалів'
  , enabled         => TRUE );
  dbms_output.put_line( 'Job "'||l_job_nm||'" created.' );
exception
  when e_job_exists 
  then dbms_output.put_line( 'Job "'||l_job_nm||'" already exists.' );
end;
/