SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET TIMING       ON
SET TRIMSPOOL    ON

declare
  e_pcd_not_exists       exception;
  pragma exception_init( e_pcd_not_exists, -04043 );
begin
  execute immediate 'drop procedure EBK_CREATE_RCIF';
  dbms_output.put_line( 'Procedure dropped.' );
exception
  when e_pcd_not_exists
  then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBKC_RCIF';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists 
  then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBK_RCIF';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBKC_SENDCARDS_HIST';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBK_CLIENT_ANALYSIS_ERRORS';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table EBK_QUEUE_UPDATECARD';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_job_not_exists       exception;
  pragma exception_init( e_job_not_exists, -27475 );
begin
  DBMS_SCHEDULER.DROP_JOB
  ( job_name  => 'EBK_RCIF_PACAKGES_JOB'
  , force     => TRUE );
  dbms_output.put_line( 'Job dropped.' );
exception
  when e_job_not_exists 
  then null;
end;
/
