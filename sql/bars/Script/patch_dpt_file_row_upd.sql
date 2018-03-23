-- ======================================================================================
-- Module : 
-- Author : BAA
-- Date   : 24.05.2017
-- ======================================================================================
-- modify table DPT_FILE_ROW_UPD
-- ======================================================

prompt -- ======================================================
prompt --  modify table DPT_FILE_ROW_UPD
prompt -- ======================================================

declare
  e_clmn_exsts  exception;
  pragma exception_init( e_clmn_exsts, -01430 );
begin
  execute immediate q'[alter table DPT_FILE_ROW_UPD add kf varchar2(6)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_clmn_exsts then
    dbms_output.put_line( 'Column "KF" already exists in table.' );
end;
/

SET FEEDBACK ON

comment on column DPT_FILE_ROW_UPD.KF is ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';

update DPT_FILE_ROW_UPD
   set KF = SubStr( BRANCH, 2, 6 )
 where KF Is Null;

commit;



declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate q'[alter table DPT_FILE_ROW_UPD modify KF constraint CC_DPTFILEROWUPD_KF_NN Not Null]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then
    dbms_output.put_line( 'Column "KF" is already NOT NULL.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create index IDX_DPTFILEROWUPD_KF_ROWID on DPT_FILE_ROW_UPD ( KF, ROW_ID ) tablespace BRSBIGI]';
  dbms_output.put_line( 'Index "IDX_DPTFILEROWUPD_KF_ROWID" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DPTFILEROWUPD_KF_ROWID" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "KF", "HEADER_ID" already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'DPT_FILE_ROW_UPD', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

begin
  BPA.ALTER_POLICIES( 'DPT_FILE_ROW_UPD' );
end;
/

commit;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
