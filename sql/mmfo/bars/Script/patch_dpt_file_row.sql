-- ======================================================================================
-- Module : 
-- Author : BAA
-- Date   : 24.05.2017
-- ======================================================================================
-- modify table DPT_FILE_ROW
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt --  modify table DPT_FILE_ROW
prompt -- ======================================================

declare
  e_clmn_exsts  exception;
  pragma exception_init( e_clmn_exsts, -01430 );
begin
  execute immediate q'[alter table DPT_FILE_ROW add KF varchar2(6)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_clmn_exsts then
    dbms_output.put_line( 'Column "KF" already exists in table.' );
end;
/

SET FEEDBACK ON

comment on column DPT_FILE_ROW.KF is 'Код фiлiалу (МФО)';

update DPT_FILE_ROW
   set KF = SubStr( BRANCH, 2, 6 )
 where KF Is Null;

commit;

SET FEEDBACK OFF

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate q'[alter table DPT_FILE_ROW modify KF constraint CC_DPTFILEROW_KF_NN Not Null]';
  execute immediate q'[alter table DPT_FILE_ROW modify KF default sys_context('bars_context','user_mfo')]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then
    dbms_output.put_line( 'Column "KF" is already NOT NULL.' );
end;
/

declare
  e_clmn_exsts  exception;
  pragma exception_init( e_clmn_exsts, -01430 );
begin
  execute immediate q'[alter table DPT_FILE_ROW add ERR_MSG varchar2(256)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_clmn_exsts then
    dbms_output.put_line( 'Column "ERR_MSG" already exists in table.' );
end;
/

SET FEEDBACK ON

comment on column DPT_FILE_ROW.ERR_MSG is 'Повідомлення про помилку';

SET FEEDBACK OFF

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  E_IDX_NOT_EXIST        exception;
  pragma exception_init( E_IDX_NOT_EXIST, -01418 );
begin
  execute immediate 'drop index I_DPTFILEROW';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXIST then
    null;
end;
/

declare
  E_IDX_NOT_EXIST        exception;
  pragma exception_init( E_IDX_NOT_EXIST, -01418 );
begin
  execute immediate 'drop index IDX_DPTFILEROW_KF_HDRID';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXIST then
    dbms_output.put_line( 'Specified index does not exist.' );
end;
/

begin
  execute immediate q'[create index IDX_DPTFILEROW_HDRID_KF on DPT_FILE_ROW ( HEADER_ID, KF ) tablespace BRSBIGI]';
  dbms_output.put_line( 'Index "IDX_DPTFILEROW_HDRID_KF" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DPTFILEROW_HDRID_KF" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "HEADER_ID", "KF" already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

begin
  BPA.ALTER_POLICIES( 'DPT_FILE_ROW' );
end;
/

commit;

prompt -- ======================================================
prompt -- drop referential constraint
prompt -- ======================================================

declare
  e_cnstrn_not_exist     exception;
  pragma exception_init( e_cnstrn_not_exist, -02443 );
begin
  execute immediate q'[alter table DPT_FILE_ROW drop constraint FK_DPTFILEROW_OPERALL]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_cnstrn_not_exist then
    null;
end;
/

prompt -- ======================================================
prompt -- create referential constraint
prompt -- ======================================================

declare
  e_ref_cnstrn_exists    exception;
  pragma exception_init( e_ref_cnstrn_exists, -02275 );
begin
  execute immediate q'[alter table DPT_FILE_ROW add constraint FK_DPTFILEROW_OPER foreign key (REF) references OPER (REF) novalidate]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS then
    null;
end;
/

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
