set verify off
set echo off
set serveroutput on size 1000000
spool log\install.log
set lines 3000


prompt...
prompt ...
prompt ... loading params
prompt ...

@params.sql

prompt  ...
prompt  dbname     = &&dbname
prompt  sys_pass   = &&sys_pass
prompt  bars_pass  = &&bars_pass
prompt  ...


whenever sqlerror exit
prompt ...
prompt ... connecting as bars
prompt ...


prompt ...sql/bars/data/crsour_portfolio.sql 
@sql/bars/data/crsour_portfolio.sql 

prompt ...sql/bars/view/v_crsour_portfolio.sql 
@sql/bars/view/v_crsour_portfolio.sql 

prompt ...sql/bars/data/arm_mbdk.sql
@sql/bars/data/arm_mbdk.sql

prompt ...sql/bars/view/v_mbdk_portfolio.sql 
@sql/bars/view/v_mbdk_portfolio.sql 

prompt ...sql/bars/data/mbdk_portfolio.sql 
@sql/bars/data/mbdk_portfolio.sql 

prompt ...sql/bars/data/mbdk_cck_restr_v.sql 
@sql/bars/data/mbdk_cck_restr_v.sql 

@sql/bars/view/V_PAY_MBDK.sql 

@sql/bars/data/PAY_MBDK.sql 

@sql/bars/Procedure/pay_mbDk.prc

@sql/bars/data/mbdk_add_deal.sql 


@sql/bars/view/v_pay_crsour.sql  

@sql/bars/data/meta_v_pay_crsour.sql 


prompt ...Sql\Bars\View\v_sw_corrnls.sql  
@Sql\Bars\View\v_sw_corrnls.sql 

prompt ...Sql\Bars\Procedure\p_edit_bicacc.prc 
@Sql\Bars\Procedure\p_edit_bicacc.prc 

prompt ...Sql\Bars\Data\bmd_v_sw_corrnls.sql 
@Sql\Bars\Data\bmd_v_sw_corrnls.sql 


@sql/bars/data/crsour_add_deal.sql 

prompt ...Sql\Bars\View\v_resid_partners.sql 
@Sql\Bars\View\v_resid_partners.sql 

prompt ...Sql\Bars\Data\bmd_resid_partners.sql
@Sql\Bars\Data\bmd_resid_partners.sql  

prompt ...Sql\Bars\View\v_nonresid_partners.sql 
@Sql\Bars\View\v_nonresid_partners.sql 

prompt ...Sql\Bars\Data\bmd_nonresid_partners.sql 
@Sql\Bars\Data\bmd_nonresid_partners.sql 

prompt ...Sql\Bars\View\v_mbdk_edit_cc_id.sql 
@Sql\Bars\View\v_mbdk_edit_cc_id.sql 

prompt ...Sql\Bars\Data\bmd_mbdk_edit_cc_id.sql 
@Sql\Bars\Data\bmd_mbdk_edit_cc_id.sql 

prompt ...Sql\Bars\View\v_mbdk_prolongation.sql
@Sql\Bars\View\v_mbdk_prolongation.sql  

prompt ...Sql\Bars\Data\bmd_mbdk_prolongation.sq
@Sql\Bars\Data\bmd_mbdk_prolongation.sq

prompt ...Sql\MBDK\Sql\Bars\View\v_mbdk_account_model.sql 
@Sql\MBDK\Sql\Bars\View\v_mbdk_account_model.sql 

prompt ...Sql\Bars\Data\bmd_mbdk_account_model.sql 
@Sql\Bars\Data\bmd_mbdk_account_model.sql 

prompt ...Sql\Bars\View\v_mbdk_product.sql 
@Sql\Bars\View\v_mbdk_product.sql 

prompt ...Sql\Bars\View\v_mbdk_cc_pawn.sql 
@Sql\Bars\View\v_mbdk_cc_pawn.sql 

prompt ...Sql\Bars\Data\bmd_mbdk_cc_pawn.sql
@Sql\Bars\Data\bmd_mbdk_cc_pawn.sql 

prompt ...Sql\Bars\Data\bmd_mbdk_archive.sql
@Sql\Bars\Data\bmd_mbdk_archive.sql  

prompt ...Sql\Bars\View\v_mbdk_archive.sql 
@Sql\Bars\View\v_mbdk_archive.sql 

prompt ...Sql\MBDK\Sql\Bars\View\v_mbdk_portfolio.sql
@Sql\MBDK\Sql\Bars\View\v_mbdk_portfolio.sql

prompt ...Sql\Bars\Data\bmd_v_mbdk_portfolio.sql 
@Sql\Bars\Data\bmd_v_mbdk_portfolio.sql 

prompt ...Sql\MBDK\Sql\Bars\View\v_mbdk_cc_swtrace.sql
@Sql\MBDK\Sql\Bars\View\v_mbdk_cc_swtrace.sql 

prompt ...Sql\MBDK\Sql\Bars\Data\bmd_v_mbdk_cc_swtrace.sql 
@Sql\MBDK\Sql\Bars\Data\bmd_v_mbdk_cc_swtrace.sql 


spool off

quit
