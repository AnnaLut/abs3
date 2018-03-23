-- ======================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 20.08.2016
-- ======================================================================================
-- modify table EBKC_DUPLICATE_GROUPS
-- ======================================================

prompt -- ======================================================
prompt --  modify table EBKC_DUPLICATE_GROUPS
prompt -- ======================================================

declare
  e_clmn_exsts  exception;
  pragma exception_init( e_clmn_exsts, -01430 );
begin
  execute immediate q'[alter table BARS.EBKC_DUPLICATE_GROUPS add KF varchar2(6)]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_clmn_exsts then
    dbms_output.put_line( 'Column "KF" already exists in table.' );
end;
/

SET FEEDBACK ON

update BARS.EBKC_DUPLICATE_GROUPS d
   set d.KF = ( select c.KF
                  from BARS.CUSTOMER c
                 where c.RNK = d.M_RNK )
 where d.KF Is Null;

commit;



declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate q'[alter table BARS.EBKC_DUPLICATE_GROUPS modify KF constraint CC_EBKCDUPLICATEGROUPS_KF_NN Not Null]';
  execute immediate q'[alter table BARS.EBKC_DUPLICATE_GROUPS modify KF default sys_context('bars_context','user_mfo')]';
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
  execute immediate q'[create index BARS.UK_EBKCDUPLICATEGROUPS on BARS.EBKC_DUPLICATE_GROUPS ( KF, M_RNK, D_RNK ) tablespace BRSMDLI]';
  dbms_output.put_line( 'Index "UK_EBKCDUPLICATEGROUPS" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "UK_EBKCDUPLICATEGROUPS" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "KF", "M_RNK", "D_RNK" already indexed.');
      else raise;
    end case;
end;
/

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
