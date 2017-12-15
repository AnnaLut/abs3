-- ================================================================================
-- Module   : PRVN
-- Author   : BAA
-- Date     : 15.08.2017
-- ================================== <Comments> ==================================
-- 1) drop Not Null constraint CC_PRVNFINDEB_ACCSP_NN ( unique constraint
--    UK_PRVNFINDEB_ACCSP allows Null value and does not need modification )
-- 2) drop Not Null constraint CC_PRVNFINDEBARCH_ACCSP_NN
-- 3) add unique constraint UK_FINDEBT_NBSP on FIN_DEBT.NBS_P column
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

declare
  E_CNSTRN_NOT_EXIST exception;
  pragma exception_init(E_CNSTRN_NOT_EXIST,-02443);
begin
  execute immediate 'alter table PRVN_FIN_DEB drop constraint CC_PRVNFINDEB_ACCSP_NN';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXIST
  then null;
end;
/

declare
  E_CNSTRN_NOT_EXIST exception;
  pragma exception_init(E_CNSTRN_NOT_EXIST,-02443);
begin
  execute immediate 'alter table PRVN_FIN_DEB_ARCH drop constraint CC_PRVNFINDEBARCH_ACCSP_NN';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXIST
  then null;
end;
/

declare
  E_UNQ_KEY_EXISTS  exception;
  pragma exception_init( E_UNQ_KEY_EXISTS, -02261 );
  E_CANNOT_VALIDATE  exception;
  pragma exception_init( E_CANNOT_VALIDATE, -02299 );
BEGIN
  execute immediate 'alter table FIN_DEBT add constraint UK_FINDEBT_NBSP unique ( NBS_P )';
  dbms_output.put_line( 'Table altered.' );
EXCEPTION
  when E_UNQ_KEY_EXISTS 
  then null;
  when E_CANNOT_VALIDATE
  then dbms_output.put_line( 'Cannot crete unique constraint on "FIN_DEBT"."NBS_P" - duplicate keys found.' );
END;
/
