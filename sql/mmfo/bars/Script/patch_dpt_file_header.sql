-- ======================================================================================
-- Module : 
-- Author : BAA
-- Date   : 24.05.2017
-- ======================================================================================
-- modify table DPT_FILE_HEADER
-- create foreign key FK_DPTFILEHDR_SOCAGNCTP
-- drop not null constraint CC_DPTFILEHDR_BRANCHCODE_NN
-- drop trigger TBI_DPTFILEHEADER
-- drop trigger TI_HEADER
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt --  modify table DPT_FILE_HEADER
prompt -- ======================================================

declare
  e_clmn_exsts  exception;
  pragma exception_init( e_clmn_exsts, -01430 );
begin
  execute immediate q'[alter table DPT_FILE_HEADER add kf varchar2(6)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_clmn_exsts then
    dbms_output.put_line( 'Column "KF" already exists in table.' );
end;
/

SET FEEDBACK ON

comment on column DPT_FILE_HEADER.KF is ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';

update DPT_FILE_HEADER
   set KF = SubStr( BRANCH, 2, 6 )
 where KF Is Null;

commit;

SET FEEDBACK OFF

declare
  e_already_nn           exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate q'[alter table DPT_FILE_HEADER modify KF constraint CC_DPTFILEHDR_KF_NN Not Null]';
  execute immediate q'[alter table DPT_FILE_HEADER modify KF default sys_context('bars_context','user_mfo')]';
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
  execute immediate q'[alter table DPT_FILE_HEADER add USR_ID number(38)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_clmn_exsts then
    dbms_output.put_line( 'Column "USR_ID" already exists in table.' );
end;
/

declare
  e_already_nn           exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate q'[alter table DPT_FILE_HEADER modify USR_ID constraint CC_DPTFILEHEADER_USRID_NN not null novalidate]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then
    dbms_output.put_line( 'Column "USR_ID" is already NOT NULL.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_DPTFILEHEADER on DPT_FILE_HEADER ( KF, HEADER_ID ) tablespace BRSBIGI]';
  dbms_output.put_line( 'Index "UK_DPTFILEHEADER" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "UK_DPTFILEHEADER" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "KF", "HEADER_ID" already indexed.' );
      else raise;
    end case;
end;
/

begin
  execute immediate q'[create index DPTFILEHDR_KF_DAT_TPID_USRID on DPT_FILE_HEADER ( KF, DAT, TYPE_ID, USR_ID ) tablespace BRSBIGI]';
  dbms_output.put_line( 'Index "DPTFILEHDR_KF_DAT_TPID_USRID" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "DPTFILEHDR_KF_DAT_TPID_USRID" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Columns "KF", "DAT", "TYPE_ID", "USR_ID" already indexed.' );
      else raise;
    end case;
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create index DPTFILEHDR_FILENM_SUM_INFLEN on DPT_FILE_HEADER ( KF, FILENAME, SUM, INFO_LENGTH )
  tablespace BRSBIGI
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index "DPTFILEHDR_FILENM_SUM_INFLEN" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'alter index DPTFILE_BRANCH rename to DPTFILEHDR_BRANCH';
  dbms_output.put_line( 'Index altered.' );
exception
  when E_IDX_NOT_EXISTS then
    null;
end;
/

declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index DPTFILE_DAT';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS then
    null;
end;
/

declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index DPTFILE_FVER';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS then
    null;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_HEADER', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

begin
  BPA.ALTER_POLICIES( 'DPT_FILE_HEADER' );
end;
/

commit;

prompt -- ======================================================
prompt -- create foreign key
prompt -- ======================================================

declare
  e_ref_cnstrn_exists    exception;
  pragma exception_init( e_ref_cnstrn_exists, -02275 );
begin
  execute immediate q'[alter table DPT_FILE_HEADER add constraint FK_DPTFILEHDR_STAFF foreign key ( USR_ID ) references STAFF$BASE ( ID ) ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS then
    null;
end;
/

exec BC.HOME;

Insert into BARS.SOCIAL_AGENCY_TYPE
  ( TYPE_ID, TYPE_NAME )
select distinct fh.AGENCY_TYPE, fh.AGENCY_TYPE
  from DPT_FILE_HEADER fh
  full outer
  join SOCIAL_AGENCY_TYPE at
    on ( at.TYPE_ID = fh.AGENCY_TYPE )
 where at.TYPE_ID is null;

commit;

SET FEEDBACK OFF

declare
  e_ref_cnstrn_exists    exception;
  pragma exception_init( e_ref_cnstrn_exists, -02275 );
begin
  execute immediate q'[alter table DPT_FILE_HEADER add constraint FK_DPTFILEHDR_SOCAGNCTP foreign key ( AGENCY_TYPE ) references SOCIAL_AGENCY_TYPE ( TYPE_ID ) ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_REF_CNSTRN_EXISTS then
    null;
end;
/

prompt -- ======================================================
prompt -- drop not null constraint
prompt -- ======================================================

declare
  e_cnstrn_not_exist     exception;
  pragma exception_init( e_cnstrn_not_exist, -02443 );
begin
  execute immediate q'[alter table DPT_FILE_HEADER drop constraint CC_DPTFILEHDR_BRANCHCODE_NN]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_cnstrn_not_exist then
    null;
end;
/

prompt -- ======================================================
prompt -- drop trigger
prompt -- ======================================================

declare
  l_trg_nm               varchar2(30);
  e_trg_not_exists       exception;
  pragma exception_init( e_trg_not_exists, -04080 );
begin
  l_trg_nm := 'TBI_DPTFILEHEADER';
  execute immediate 'drop trigger '||l_trg_nm;
  dbms_output.put_line( 'Trigger dropped.' );
exception
  when e_trg_not_exists then
    null;
end;
/

declare
  l_trg_nm               varchar2(30);
  e_trg_not_exists       exception;
  pragma exception_init( e_trg_not_exists, -04080 );
begin
  l_trg_nm := 'TI_HEADER';
  execute immediate 'drop trigger '||l_trg_nm;
  dbms_output.put_line( 'Trigger dropped.' );
exception
  when e_trg_not_exists then
    null;
end;
/

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
