-- ======================================================================================
-- Author : BAA
-- Date   : 29.12.2017
-- ===================================== <Comments> =====================================
-- add column KF to BPK_CREDIT_DEAL_VAR
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     ON
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON
set VERIFY       OFF

declare
  l_kf                   varchar2(6);
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  
  l_kf := F_OURMFO_G;
  
  begin
    
    bpa.disable_policies('BPK_CREDIT_DEAL_VAR');
    
    bc.subst_mfo( l_kf );
    
    execute immediate q'[alter table BPK_CREDIT_DEAL_VAR add KF VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo') CONSTRAINT CC_BPKCRDTDEALVAR_KF_NN NOT NULL]';
    
    dbms_output.put_line('Table altered.');
    
    bc.set_context;
    
    bpa.enable_policies('BPK_CREDIT_DEAL_VAR');
  exception
    when e_col_exists
    then
      dbms_output.put_line( 'Column "KF" already exists in table.' );
      update BPK_CREDIT_DEAL_VAR
         set KF = l_kf
       where KF is Null;
      dbms_output.put_line( to_char(sql%rowcount)||' row(s) updated.' );
      commit;
  end;
  
  bc.set_context;
  bpa.enable_policies('BPK_CREDIT_DEAL_VAR');
  
end;
/

begin
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL_VAR', 'WHOLE',  null, null, null, null );
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL_VAR', 'FILIAL', null, null, null, null );
end;
/

commit;

begin
  bpa.alter_policies('BPK_CREDIT_DEAL_VAR');
end;
/

commit;

COMMENT ON COLUMN BPK_CREDIT_DEAL.KF IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';
