-- ======================================================================================
-- Module : ALL
-- Author : BAA
-- Date   : 
-- ======================================================================================
-- modify table CUSTOMER_UPDATE
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt --  modify table CUSTOMER_UPDATE
prompt -- ======================================================

declare
  e_col_exsts  exception;
  pragma exception_init( e_col_exsts, -01430 );
begin
  
  bpa.disable_policies('CUSTOMER_UPDATE');
  
  bc.subst_mfo(f_ourmfo_g);
  
  execute immediate q'[alter table CUSTOMER_UPDATE add KF varchar2(6) default sys_context('bars_context','user_mfo') constraint CC_CUSTOMERUPD_KF_NN Not Null]';
  
  dbms_output.put_line( 'Table CUSTOMER_UPDATE altered.' );
  
  bc.home;
  
  bpa.enable_policies('CUSTOMER_UPDATE');
  
exception
  when e_col_exsts then
    bc.home;
    bpa.enable_policies('CUSTOMER_UPDATE');
end;
/



prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on column CUSTOMER_UPDATE.KF IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';
