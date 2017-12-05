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
  
  bpa.disable_policies('W4_ACC');
  
  bc.subst_mfo(F_OURMFO_G);
  
  execute immediate q'[alter table W4_ACC add KF VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo') CONSTRAINT CC_W4ACC_KF_NN NOT NULL]';
  
  dbms_output.put_line('Table altered.');
  
  bc.set_context;
  
  bpa.enable_policies('W4_ACC');
  
exception
  when OTHERS then
    bc.set_context;
    bpa.enable_policies('W4_ACC');
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column KF already exists in table.');
    else raise;
    end if;
end;
/

begin
  bpa.alter_policy_info( 'W4_ACC', 'WHOLE' , NULL, 'E', 'E', 'E' );
  bpa.alter_policy_info( 'W4_ACC', 'FILIAL',  'M', 'M', 'M', 'M' );
end;
/

commit;

begin
  bpa.alter_policies('W4_ACC');
end;
/

commit;

COMMENT ON COLUMN W4_ACC.KF IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';
