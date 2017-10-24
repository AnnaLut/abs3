-- ======================================================================================
-- Module : XOZ
-- Author : BAA
-- Date   : 12.07.2017
-- ======================================================================================
-- BUSINESS RECEIVABLES ( BSN_RCVB )
-- ===================================== <Comments> =====================================
-- add column KF
-- add column ID
-- change primary key PK_XOZREF
-- create unque constraint UK_XOZREF
-- create trigger TBI_XOZ_REF
-- add policies
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK OFF

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table XOZ_REF add KF varchar2(6)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "KF" already exists in table.' );
end;
/

SET FEEDBACK ON

update XOZ_REF xz
   set xz.KF = ( select ac.KF from accounts ac where ac.ACC = xz.ACC )   
 where xz.KF IS Null;

commit;

update XOZ_REF xz set xz.kf = 
(select t.val from params$base t where t.par = 'MFO')
where xz.kf is null;

commit;

SET FEEDBACK OFF

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate q'[alter table XOZ_REF modify KF constraint CC_XOZRE_KF_NN Not Null]';
  execute immediate q'[alter table XOZ_REF modify KF default sys_context('bars_context','user_mfo')]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then
    dbms_output.put_line( 'Column "KF" is already NOT NULL.' );
end;
/

/*
begin
  bpa.alter_policy_info( 'XOZ_REF', 'WHOLE',  null, 'E', 'E', 'E' ); 
  bpa.alter_policy_info( 'XOZ_REF', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/
*/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table XOZ_REF add ID number(38)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "KF" already exists in table.' );
end;
/

SET FEEDBACK ON

update XOZ_REF
   set ID = bars_sqnc.get_nextval('S_CC_DEAL',KF)
 where ID IS Null;

commit;

SET FEEDBACK OFF

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate q'[alter table XOZ_REF modify ID constraint CC_XOZRE_ID_NN Not Null]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then
    dbms_output.put_line( 'Column "ID" is already NOT NULL.' );
end;
/

declare
  e_pk_not_exist  exception;
  pragma exception_init( e_pk_not_exist, -02441 );
begin
  execute immediate 'alter table XOZ_REF drop primary key drop index';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_PK_NOT_EXIST then
    dbms_output.put_line( 'Cannot drop nonexistent primary key.' );
end;
/

declare
  e_unq_key_exists  exception;
  pragma exception_init( e_unq_key_exists, -02261 );
BEGIN
  execute immediate 'alter table XOZ_REF add constraint UK_XOZREF unique (REF1, STMT1) using index tablespace BRSMDLI';
  dbms_output.put_line( 'Unique key UK_XOZREF created.' );
EXCEPTION
  when e_unq_key_exists then
    dbms_output.put_line( 'Such unique key already exists in the table.' );
END;
/

declare
  e_pk_exists  exception;
  pragma exception_init( e_pk_exists, -02260 );
begin
  execute immediate 'alter table XOZ_REF add constraint PK_XOZREF primary key ( ID ) using index tablespace BRSMDLI';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_PK_EXISTS then 
    dbms_output.put_line( 'Table can have only one primary key.' );
end;
/

/*
begin
  bpa.alter_policies( 'XOZ_REF' );
end;
/
*/
SET FEEDBACK ON
show errors;