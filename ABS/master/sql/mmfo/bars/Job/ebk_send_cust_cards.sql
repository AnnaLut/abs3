SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        200
SET PAGES        200
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create job EBK_SEND_CUST_CARDS
prompt -- ======================================================

declare
  l_job_nm               varchar2(30);
  e_job_not_exists       exception;
  pragma exception_init( e_job_not_exists, -27475 );
  e_job_exists           exception;
  pragma exception_init( e_job_exists,     -27477 );
begin
  l_job_nm := 'EBK_SEND_CUST_CARDS';
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
  , job_action      => 'BARS.EBK_REQUEST_UTL.SEND_CUST_CARDS'
  , start_date      =>  TO_TIMESTAMP_TZ('2015/06/17 01:00:00 +03:00','yyyy/mm/dd HH24:MI:SS TZH:TZM')
  , repeat_interval => 'FREQ=DAILY'
  , comments        => 'Надсилання даних карток клієнтів до ЄБК'
  , enabled         => TRUE );
  dbms_output.put_line( 'Job "'||l_job_nm||'" created.' );
exception
  when e_job_exists 
  then dbms_output.put_line( 'Job "'||l_job_nm||'" already exists.' );
end;
/

prompt -- ======================================================
prompt -- drop old jobs
prompt -- ======================================================

declare
  l_job_nm               varchar2(30);
  e_job_not_exists       exception;
  pragma exception_init( e_job_not_exists, -27475 );
begin

  l_job_nm := 'EBKC_SEND_LEGAL_CARDS';
  begin
    DBMS_SCHEDULER.DROP_JOB
    ( job_name        => l_job_nm
    , force           => TRUE );
    dbms_output.put_line( 'Job "'||l_job_nm||'" dropped.' );
  exception
    when e_job_not_exists 
    then null;
  end;

  l_job_nm := 'EBKC_SEND_PRIV_CARDS';
  begin
    DBMS_SCHEDULER.DROP_JOB
    ( job_name        => l_job_nm
    , force           => TRUE );
    dbms_output.put_line( 'Job "'||l_job_nm||'" dropped.' );
  exception
    when e_job_not_exists 
    then null;
  end;

  l_job_nm := 'EBK_CARD_PACAKGES_JOB';
  begin
    DBMS_SCHEDULER.DROP_JOB
    ( job_name        => l_job_nm
    , force           => TRUE );
    dbms_output.put_line( 'Job "'||l_job_nm||'" dropped.' );
  exception
    when e_job_not_exists 
    then null;
  end;

end;
/
