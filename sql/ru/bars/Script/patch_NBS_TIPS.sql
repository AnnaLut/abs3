-- ================================================================================
-- Module   : GL
-- Author   : BAA
-- Date     : .mm.yyyy
-- ================================== <Comments> ==================================
-- COBUSUPABS-6084
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON
SET VERIFY       OFF

declare
  e_pk_not_exist  exception;
  pragma exception_init( e_pk_not_exist, -02441 );
begin
  execute immediate 'alter table NBS_TIPS drop primary key cascade drop index';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_PK_NOT_EXIST then
    dbms_output.put_line( 'Cannot drop nonexistent primary key.' );
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table NBS_TIPS add ( OB22 char(2) )';
  dbms_output.put_line('Table altered.');
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "OB22" already exists in table.' );
end;
/

declare
  e_unq_key_exists  exception;
  pragma exception_init( e_unq_key_exists, -02261 );
BEGIN
  execute immediate 'alter table NBS_TIPS add constraint UK_NBSTIPS unique ( NBS, OB22, TIP )';
  dbms_output.put_line( 'Unique key "UK_NBSTIPS" created.' );
EXCEPTION
  when e_unq_key_exists then
    dbms_output.put_line( 'Such unique or primary key already exists in the table.' );
END;
/

declare
  e_ref_cnstrn_exists exception;
  pragma exception_init( e_ref_cnstrn_exists, -02275 );
begin
  execute immediate q'[alter table NBS_TIPS add constraint FK_NBSTIPS_SBOB22 foreign key ( NBS, OB22 ) 
  references SB_OB22 ( R020, OB22 ) ]';
  dbms_output.put_line( 'Foreign key "FK_NBSTIPS_SBOB22" created.' );
exception
  when e_ref_cnstrn_exists then
    dbms_output.put_line('Such a referential constraint already exists in the table.');
end;
/
