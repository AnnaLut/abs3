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

select to_char(sysdate,'DD/MM/YYYY HH24:MI:SS') "Start at"
  from dual;

prompt ...sql/bars/data/forex_all.sql 
@sql/bars/data/forex_all.sql 

prompt ...sql/bars/data/forex_close.sql 
@sql/bars/data/forex_close.sql 

prompt ...sql/bars/data/forex_dynsmic_month.sql  
@sql/bars/data/forex_dynsmic_month.sql 

prompt ...sql/bars/data/forex_dynsmic_product.sql 
@sql/bars/data/forex_dynsmic_product.sql 

prompt ...sql/bars/data/forex_fin_rez_A0P.sql 
@sql/bars/data/forex_fin_rez_A0P.sql 

prompt ...sql/bars/data/forex_fin_rez_A1S.sql 
@sql/bars/data/forex_fin_rez_A1S.sql 
 
prompt ...sql/bars/data/forex_fin_rez_A2D.sql 
@sql/bars/data/forex_fin_rez_A2D.sql 

prompt ...sql/bars/data/forex_fin_rez_A3K.sql
@sql/bars/data/forex_fin_rez_A3K.sql 

prompt ...sql/bars/data/forex_fin_rez_A4V.sql 
@sql/bars/data/forex_fin_rez_A4V.sql 

prompt ...sql/bars/data/forex_finish.sql 
@sql/bars/data/forex_finish.sql 

prompt ...sql/bars/data/forex_ob22.sql 
@sql/bars/data/forex_ob22.sql 

prompt ...sql/bars/data/forex_pay_A00.sql 
@sql/bars/data/forex_pay_A00.sql 

prompt ...sql/bars/data/forex_payed_calendar.sql 
@sql/bars/data/forex_payed_calendar.sql 

prompt ...sql/bars/data/forex_peeoc_netting_0.sql  
@sql/bars/data/forex_peeoc_netting_0.sql 

prompt ...sql/bars/data/forex_peeoc_netting_1.sql  
@sql/bars/data/forex_peeoc_netting_1.sql 

prompt ...sql/bars/data/forex_peeoc_spot.sql  
@sql/bars/data/forex_peeoc_spot.sql 

prompt ...sql/bars/data/forex_specparam.sql  
@sql/bars/data/forex_specparam.sql 

prompt ...sql/bars/data/forex_start_deposwop.sql  
@sql/bars/data/forex_start_deposwop.sql 

prompt...@sql/bars/Trigger/tv_forex_netting.sql 
@sql/bars/Trigger/tv_forex_netting.sql  

@sql/bars/table/tmp_irr_user.sql  
@sql/bars/table/tmp_fx_netting.sql  
@sql/bars/view/v_for_net_pro.sql
@sql/bars/view/v_saldo_dsw.sql 
@sql/bars/procedure/p_net_pro_update_row.sql 
@sql/bars/procedure/p_forex_netting.sql 

@sql/bars/procedure/p_netting_forex_row_update.sql 

@sql/bars/data/FOREX_NETTING_DEAL_META.sql 

@Sql\Bars\Package\forex.pkb 

prompt ...Sql\Bars\View\v_forex_account_model.sql 
@Sql\Bars\View\v_forex_account_model.sql 

prompt ...Sql\Bars\Data\bmd_v_forex_account_model.sql 
@Sql\Bars\Data\bmd_v_forex_account_model.sql 

prompt ..Sql\FXS\Sql\Bars\View\v_forex_deal_documents.sql 
@Sql\FXS\Sql\Bars\View\v_forex_deal_documents.sql 

prompt ... Sql\Bars\Data\bmd_v_forex_deal_documents.sql 
@Sql\Bars\Data\bmd_v_forex_deal_documents.sql 

prompt ... Sql\FXS\Sql\Bars\View\v_forex_swift.sql 
@Sql\FXS\Sql\Bars\View\v_forex_swift.sql 

prompt... Sql\Bars\View\operlist_v_for_net_pro.sql 
@Sql\Bars\View\operlist_v_for_net_pro.sql 

@Sql\Bars\Data\bmd_v_for_net_pro.sql 

@Sql\Bars\Data\update_operlist_name.sql 

prompt...@sql\Bars\Script\df_v_frx_archive.sql 
@sql\Bars\Script\df_v_frx_archive.sql 

prompt...Sql\Bars\Data\fil_forex_val_part.sql 
@Sql\Bars\Data\fil_forex_val_part.sql 

select to_char(sysdate,'DD/MM/YYYY HH24:MI:SS') "End at"
  from dual;


spool off

quit

