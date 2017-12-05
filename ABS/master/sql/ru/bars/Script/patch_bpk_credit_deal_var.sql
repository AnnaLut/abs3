-- ======================================================================================
-- Author : BAA
-- Date   : 24.11.2016
-- ===================================== <Comments> =====================================
-- add column KF
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     ON
SET DEFINE       OFF
SET LINES        300
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON
set VERIFY       OFF

begin
  
  bpa.disable_policies('BPK_CREDIT_DEAL_VAR');
  
  bc.subst_mfo(F_OURMFO_G);
  
  execute immediate q'[alter table BPK_CREDIT_DEAL_VAR add KF VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo') CONSTRAINT CC_BPKCRDTDEALVAR_KF_NN NOT NULL]';
  
  dbms_output.put_line('Table altered.');
  
  bc.set_context;
  
  bpa.enable_policies('BPK_CREDIT_DEAL_VAR');
  
exception
  when OTHERS then
    bc.set_context;
    bpa.enable_policies('BPK_CREDIT_DEAL_VAR');
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column KF already exists in table.');
    else raise;
    end if;
end;
/

begin
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL_VAR', 'WHOLE' , NULL, 'E', 'E', 'E' );
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL_VAR', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

begin
  bpa.alter_policies('BPK_CREDIT_DEAL_VAR');
end;
/

commit;

COMMENT ON COLUMN BPK_CREDIT_DEAL.KF IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';
