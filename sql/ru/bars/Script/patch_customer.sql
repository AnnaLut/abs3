-- ======================================================================================
-- Module : ALL
-- Author : BAA
-- Date   : 
-- ======================================================================================
-- modify table CUSTOMER
-- ======================================================


prompt -- ======================================================
prompt --  modify table CUSTOMER
prompt -- ======================================================

declare
  e_col_exsts  exception;
  pragma exception_init( e_col_exsts, -01430 );
begin
  
  bpa.disable_policies('CUSTOMER');
  
  bc.subst_mfo(f_ourmfo_g);
  
  execute immediate q'[alter table CUSTOMER add KF VARCHAR2(6) default sys_context('bars_context','user_mfo') constraint CC_CUSTOMER_KF_NN Not Null]';
  
  dbms_output.put_line( 'Table CUSTOMER altered.' );
  
  bc.home;
  
  bpa.enable_policies('CUSTOMER');
  
exception
  when e_col_exsts then
    bc.home;
    bpa.enable_policies('CUSTOMER');
end;
/



prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on column CUSTOMER.KF        IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';
