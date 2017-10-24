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
prompt  ...


whenever sqlerror exit
prompt ...
prompt ... connecting as bars
prompt ...


conn  bars@&&dbname/&&bars_pass
whenever sqlerror continue

prompt TABLES
prompt ...Sql\Bars\Table\compen_portfolio_status.sql 
@Sql\Bars\Table\compen_portfolio_status.sql 
prompt ...Sql\Bars\Table\compen_portfolio.sql 
@Sql\Bars\Table\compen_portfolio.sql 
prompt ...Sql\Bars\Table\compen_portfolio_update.sql 
@Sql\Bars\Table\compen_portfolio_update.sql
prompt ...Sql\Bars\Table\compen_portfolio_status_old.sql
@Sql\Bars\Table\compen_portfolio_status_old.sql
prompt ...Sql\Bars\Table\compen_benef_update.sql
@Sql\Bars\Table\compen_benef_update.sql
prompt ...Sql\Bars\Table\compen_benef_code.sql 
@Sql\Bars\Table\compen_benef_code.sql
prompt ...Sql\Bars\Table\compen_benef.sql 
@Sql\Bars\Table\compen_benef.sql
prompt ...Sql\Bars\Table\compen_benef_update.sql
@Sql\Bars\Table\compen_benef_update.sql
prompt ...Sql\Bars\Table\compen_asvotypo.sql
@Sql\Bars\Table\compen_asvotypo.sql
prompt ...Sql\Bars\Table\compen_motions.sql 
@Sql\Bars\Table\compen_motions.sql
prompt ...Sql\Bars\Table\compen_ob22.sql
@Sql\Bars\Table\compen_ob22.sql
prompt ...Sql\Bars\Table\compen_clients.sql
@Sql\Bars\Table\compen_clients.sql
prompt ...Sql\Bars\Table\compen_batch.sql
@Sql\Bars\Table\compen_batch.sql
prompt ...Sql\Bars\Table\compen_payments_batch.sql
@Sql\Bars\Table\compen_payments_batch.sql
prompt ...Sql\Bars\Table\compen_registry_states.sql
@Sql\Bars\Table\compen_registry_states.sql
prompt ...Sql\Bars\Table\compen_registry_types.sql
@Sql\Bars\Table\compen_registry_types.sql
prompt ...Sql\Bars\Table\compen_payments_registry.sql
@Sql\Bars\Table\compen_payments_registry.sql
prompt ...Sql\Bars\Table\compen_oper_states.sql
@Sql\Bars\Table\compen_oper_states.sql
prompt ...Sql\Bars\Table\compen_oper_types.sql
@Sql\Bars\Table\compen_oper_types.sql
prompt ...Sql\Bars\Table\compen_oper.sql
@Sql\Bars\Table\compen_oper.sql
prompt ...Sql\Bars\Table\banks_ru.sql
@Sql\Bars\Table\banks_ru.sql
prompt ...Sql\Bars\Table\compen_recipients.sql
@Sql\Bars\Table\compen_recipients.sql
prompt ...Sql\Bars\Table\compen_param_types.sql
@Sql\Bars\Table\compen_param_types.sql
prompt ...Sql\Bars\Table\compen_params.sql
@Sql\Bars\Table\compen_params.sql
prompt ...Sql\Bars\Table\compen_params_data.sql
@Sql\Bars\Table\compen_params_data.sql
prompt ...Sql\Bars\Table\customer_crkr_update.sql
@Sql\Bars\Table\customer_crkr_update.sql
prompt ...Sql\Bars\Table\compen_oper_dbcode.sql
@Sql\Bars\Table\compen_oper_dbcode.sql
prompt ...Sql\Bars\Table\COMPEN_REGISTRY_QUEUE.sql
@Sql\Bars\Table\COMPEN_REGISTRY_QUEUE.sql
prompt ...Sql\Bars\Table\COMPEN_PORTFOLIO_DBCODE_OLD.sql
@Sql\Bars\Table\COMPEN_PORTFOLIO_DBCODE_OLD.sql
prompt ...@Sql\Bars\Table\compen_portfolio_rebran.sql
@Sql\Bars\Table\compen_portfolio_rebran.sql
prompt ...@Sql\Bars\Table\keytypes.sql
@Sql\Bars\Table\keytypes.sql
prompt ...@Sql\Bars\Table\ow_keys.sql
@Sql\Bars\Table\ow_keys.sql


prompt ...Sql\Bars\Table\ussr2_acts_types.sql
@Sql\Bars\Table\ussr2_acts_types.sql
prompt ...Sql\Bars\Table\ussr2_act_states.sql
@Sql\Bars\Table\ussr2_act_states.sql
prompt ...Sql\Bars\Table\ussr2_actualizations.sql
@Sql\Bars\Table\ussr2_actualizations.sql
prompt ...Sql\Bars\Table\ussr2_act_client_data.sql
@Sql\Bars\Table\ussr2_act_client_data.sql
prompt ...Sql\Bars\Table\ussr2_act_dpt_data.sql
@Sql\Bars\Table\ussr2_act_dpt_data.sql
prompt ...Sql\Bars\Table\ussr2_act_payment_data.sql
@Sql\Bars\Table\ussr2_act_payment_data.sql

prompt SEQUENCES
prompt ...Sql\Bars\Sequence\S_COMPEN_BATCH.sql
@Sql\Bars\Sequence\S_COMPEN_BATCH.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_BENEF.sql
@Sql\Bars\Sequence\S_COMPEN_BENEF.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_BENEF_UPDATE.sql
@Sql\Bars\Sequence\S_COMPEN_BENEF_UPDATE.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_OPER.sql
@Sql\Bars\Sequence\S_COMPEN_OPER.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_PARAMS_DATA_ID.sql
@Sql\Bars\Sequence\S_COMPEN_PARAMS_DATA_ID.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_PARAMS_ID.sql
@Sql\Bars\Sequence\S_COMPEN_PARAMS_ID.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_PAYMENTS_REGISTRY.sql
@Sql\Bars\Sequence\S_COMPEN_PAYMENTS_REGISTRY.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_PORTFOLIO.sql
@Sql\Bars\Sequence\S_COMPEN_PORTFOLIO.sql
prompt ...Sql\Bars\Sequence\S_COMPEN_PORTFOLIO_UPDATE.sql
@Sql\Bars\Sequence\S_COMPEN_PORTFOLIO_UPDATE.sql
prompt ...Sql\Bars\Sequence\S_CUSTOMER_CRKR_UPDATE.sql
@Sql\Bars\Sequence\S_CUSTOMER_CRKR_UPDATE.sql
prompt ...Sql\Bars\Sequence\s_keytypes.sql
@Sql\Bars\Sequence\s_keytypes.sql
prompt ...Sql\Bars\Sequence\s_ow_keys.sql
@Sql\Bars\Sequence\s_ow_keys.sql

prompt SYNONYMS
prompt ...Sql\Bars\Synonym\crkr_compen_gr.sql 
@Sql\Bars\Synonym\crkr_compen_gr.sql

prompt PACKAGES
prompt ...Sql\Bars\Header\crkr_compen.pks
@Sql\Bars\Header\crkr_compen.pks
prompt ...Sql\Bars\Header\crkr_compen_web.pks
@Sql\Bars\Header\crkr_compen_web.pks
prompt ...Sql\Bars\Header\crkr_rep.pks
@Sql\Bars\Header\crkr_rep.pks
prompt ...Sql\Bars\Header\crypto_utl.pks
@Sql\Bars\Header\crypto_utl.pks


prompt ...Sql\Bars\Package\crkr_compen.pkb
@Sql\Bars\Package\crkr_compen.pkb
prompt ...Sql\Bars\Package\crkr_compen_web.pkb
@Sql\Bars\Package\crkr_compen_web.pkb
prompt ...Sql\Bars\Package\crkr_rep.pkb
@Sql\Bars\Package\crkr_rep.pkb
prompt ...Sql\Bars\Package\crypto_utl.pkb
@Sql\Bars\Package\crypto_utl.pkb


prompt TRIGGERS
prompt ...Sql\Bars\Trigger\TBI_COMPEN_PARAMS_DATA.sql
@Sql\Bars\Trigger\TBI_COMPEN_PARAMS_DATA.sql

prompt VIEWS
prompt ...Sql\Bars\View\v_compens.sql
@Sql\Bars\View\v_compens.sql
prompt ...Sql\Bars\View\v_compen_actual_compens.sql
@Sql\Bars\View\v_compen_actual_compens.sql
prompt ...Sql\Bars\View\v_compen_actual_nopay.sql
@Sql\Bars\View\v_compen_actual_nopay.sql
prompt ...Sql\Bars\View\v_compen_ob22.sql
@Sql\Bars\View\v_compen_ob22.sql
prompt ...Sql\Bars\View\v_compen_params_data.sql
@Sql\Bars\View\v_compen_params_data.sql
prompt ...Sql\Bars\View\v_compen_payments_reg_bur.sql
@Sql\Bars\View\v_compen_payments_reg_bur.sql
prompt ...Sql\Bars\View\v_compen_payments_reg_dep.sql
@Sql\Bars\View\v_compen_payments_reg_dep.sql
prompt ...Sql\Bars\View\v_compen_ussr2_client_hist.sql
@Sql\Bars\View\v_compen_ussr2_client_hist.sql
prompt ...Sql\Bars\View\v_compen_ussr2_deposit_hist.sql
@Sql\Bars\View\v_compen_ussr2_deposit_hist.sql
prompt ...Sql\Bars\View\v_compen_ussr2_pay_hist.sql
@Sql\Bars\View\v_compen_ussr2_pay_hist.sql
prompt ...Sql\Bars\View\v_crca_confidant.sql
@Sql\Bars\View\v_crca_confidant.sql
prompt ...Sql\Bars\View\v_crca_heir.sql
@Sql\Bars\View\v_crca_heir.sql
prompt ...Sql\Bars\View\v_crca_pays.sql
@Sql\Bars\View\v_crca_pays.sql
prompt ...Sql\Bars\View\v_crca_portfolio.sql
@Sql\Bars\View\v_crca_portfolio.sql
prompt ...Sql\Bars\View\v_compen_actoper_for_visa.sql
@Sql\Bars\View\v_compen_actoper_for_visa.sql
prompt ...Sql\Bars\View\v_compen_actoper_for_visa_self.sql
@Sql\Bars\View\v_compen_actoper_for_visa_self.sql
prompt ...Sql\Bars\View\v_compen_choper_depend.sql
@Sql\Bars\View\v_compen_choper_depend.sql
prompt ...Sql\Bars\View\v_compen_choper_for_visa_self.sql
@Sql\Bars\View\v_compen_choper_for_visa_self.sql
prompt ...Sql\Bars\View\v_compen_choper_for_visa.sql
@Sql\Bars\View\v_compen_choper_for_visa.sql
prompt ...Sql\Bars\View\v_compen_operpay.sql
@Sql\Bars\View\v_compen_operpay.sql
prompt ...Sql\Bars\View\v_compen_passp.sql
@Sql\Bars\View\v_compen_passp.sql
prompt ...Sql\Bars\View\v_compen_passp_benef.sql
@Sql\Bars\View\v_compen_passp_benef.sql
prompt ...Sql\Bars\View\v_compen_wdioper_for_visa.sql
@Sql\Bars\View\v_compen_wdioper_for_visa.sql
prompt ...Sql\Bars\View\v_compen_wdioper_for_visa_self.sql
@Sql\Bars\View\v_compen_wdioper_for_visa_self.sql
prompt ...Sql\Bars\View\v_customer_compens.sql
@Sql\Bars\View\v_customer_compens.sql
prompt ...Sql\Bars\View\v_customer_compens_bur.sql
@Sql\Bars\View\v_customer_compens_bur.sql
prompt ...Sql\Bars\View\v_customer_crkr.sql
@Sql\Bars\View\v_customer_crkr.sql
prompt ...Sql\Bars\View\v_compen_actoper_err_bk_visa.sql
@Sql\Bars\View\v_compen_actoper_err_bk_visa.sql
prompt ...Sql\Bars\View\v_compen_wdioper_err_bk_visa.sql
@Sql\Bars\View\v_compen_wdioper_err_bk_visa.sql
prompt ...Sql\Bars\View\v_compen_choper_err_bk_visa.sql
@Sql\Bars\View\v_compen_choper_err_bk_visa.sql
prompt ...Sql\Bars\View\V_COUNTRY.sql
@Sql\Bars\View\V_COUNTRY.sql
prompt ...Sql\Bars\View\v_compen_reqdeact_for_visa.sql
@Sql\Bars\View\v_compen_reqdeact_for_visa.sql
prompt ...Sql\Bars\View\v_compen_reqdeact_for_visa_self.sql
@Sql\Bars\View\v_compen_reqdeact_for_visa_self.sql
prompt ...Sql\Bars\View\v_compen_reqdeact_err_bk_visa.sql
@Sql\Bars\View\v_compen_reqdeact_err_bk_visa.sql
prompt ...Sql\Bars\View\v_sex.sql
@Sql\Bars\View\v_sex.sql
prompt ...Sql\Bars\View\V_APP_RESOURCES_CONFIRM.sql
@Sql\Bars\View\V_APP_RESOURCES_CONFIRM.sql
prompt ...Sql\Bars\View\V_APPADM_APP_OPER_WEB.sql
@Sql\Bars\View\V_APPADM_APP_OPER_WEB.sql
prompt ...Sql\Bars\View\V_USER_RES.sql
@Sql\Bars\View\V_USER_RES.sql
prompt ...Sql\Bars\View\V_USERADM_USER_APPS_WEB.sql
@Sql\Bars\View\V_USERADM_USER_APPS_WEB.sql
prompt ...Sql\Bars\View\v_compen_benef_for_visa.sql
@Sql\Bars\View\v_compen_benef_for_visa.sql
prompt ...Sql\Bars\View\v_compen_benef_for_visa_self.sql
@Sql\Bars\View\v_compen_benef_for_visa_self.sql
prompt ...Sql\Bars\View\v_cust_compens_benef.sql
@Sql\Bars\View\v_cust_compens_benef.sql
prompt ...Sql\Bars\View\v_banks_ru.sql
@Sql\Bars\View\v_banks_ru.sql

prompt Procedures
prompt ...Sql\Bars\Procedure\CHANGE_BANKING_DATE.sql
@Sql\Bars\Procedure\CHANGE_BANKING_DATE.sql

prompt DATA
prompt ...Sql\Bars\Data\COMPEN_ASVOTYPO.sql
@Sql\Bars\Data\COMPEN_ASVOTYPO.sql
prompt ...Sql\Bars\Data\COMPEN_OB22.sql
@Sql\Bars\Data\COMPEN_OB22.sql
prompt ...Sql\Bars\Data\COMPEN_OPER_STATES.sql
@Sql\Bars\Data\COMPEN_OPER_STATES.sql
prompt ...Sql\Bars\Data\COMPEN_OPER_TYPES.sql
@Sql\Bars\Data\COMPEN_OPER_TYPES.sql
prompt ...Sql\Bars\Data\COMPEN_PARAM_TYPES.sql
@Sql\Bars\Data\COMPEN_PARAM_TYPES.sql
prompt ...Sql\Bars\Data\COMPEN_PARAMS.sql
@Sql\Bars\Data\COMPEN_PARAMS.sql
prompt ...Sql\Bars\Data\COMPEN_PARAMS_DATA.sql
@Sql\Bars\Data\COMPEN_PARAMS_DATA.sql	
prompt ...Sql\Bars\Data\COMPEN_PORTFOLIO_STATUS.sql
@Sql\Bars\Data\COMPEN_PORTFOLIO_STATUS.sql
prompt ...Sql\Bars\Data\COMPEN_REGISTRY_STATES.sql
@Sql\Bars\Data\COMPEN_REGISTRY_STATES.sql
prompt ...Sql\Bars\Data\COMPEN_REGISTRY_TYPES.sql
@Sql\Bars\Data\COMPEN_REGISTRY_TYPES.sql
prompt ...Sql\Bars\Data\COMPEN_RECIPIENTS.sql
@Sql\Bars\Data\COMPEN_RECIPIENTS.sql
prompt ...Sql\Bars\Data\compen_param.sql
@Sql\Bars\Data\compen_param.sql
prompt ...Sql\Bars\Data\operlist_CRCC.sql
@Sql\Bars\Data\operlist_CRCC.sql
prompt ...Sql\Bars\Data\operlist_CRCO.sql
@Sql\Bars\Data\operlist_CRCO.sql
prompt ...Sql\Bars\Data\operlist_CRCK.sql
@Sql\Bars\Data\operlist_CRCK.sql
prompt ...Sql\Bars\Data\operlist_crct.sql
@Sql\Bars\Data\operlist_crct.sql
prompt ...Sql\Bars\Data\operlist_CRCA.sql
@Sql\Bars\Data\operlist_CRCA.sql
prompt ...Sql\Bars\Data\passp.sql
@Sql\Bars\Data\passp.sql
prompt REM...Sql\Bars\Data\compen_portfolio.sql
prompt REM@Sql\Bars\Data\compen_portfolio.sql
prompt ...Sql\Bars\Data\CHANGE_BANKDATE_TO_SYSDATE.sql
@Sql\Bars\Data\CHANGE_BANKDATE_TO_SYSDATE.sql
prompt ...Sql\Bars\Data\compen_benef_code.sql
@Sql\Bars\Data\compen_benef_code.sql

prompt Functions
prompt ...Sql\Bars\Function\f_ost_compen.sql
@Sql\Bars\Function\f_ost_compen.sql

prompt REPORTS
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3103.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3103.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3104.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3104.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3105.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3105.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3106.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3106.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3107.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3107.sql

prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3108.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3108.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3109.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3109.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3110.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3110.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3111.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3111.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3112.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3112.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3113.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3113.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3114.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3114.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3115.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3115.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3116.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3116.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3117.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3117.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3118.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3118.sql
prompt ...Sql\Bars\Report\sql\_BRS_SBER_CRCA_3120.sql
@Sql\Bars\Report\sql\_BRS_SBER_CRCA_3120.sql


prompt ...Sql\Bars\Report\sql\include_rep_arm.sql
@Sql\Bars\Report\sql\include_rep_arm.sql
prompt ...Sql\Bars\Report\sql\meta_banks_ru.sql
@Sql\Bars\Report\sql\meta_banks_ru.sql
prompt ...Sql\Bars\Report\sql\meta_compen_oper_states.sql
@Sql\Bars\Report\sql\meta_compen_oper_states.sql
prompt ...Sql\Bars\Report\sql\meta_compen_types.sql
@Sql\Bars\Report\sql\meta_compen_types.sql


prompt JOB
prompt ...Sql\Bars\Job\job_BARS_COMPEN_STATE_OPER.sql
@Sql\Bars\Job\job_BARS_COMPEN_STATE_OPER.sql
prompt ...Sql\Bars\Job\CHANGE_BANKDATE.sql
@Sql\Bars\Job\CHANGE_BANKDATE.sql

prompt Grant
prompt ...Sql\Bars\Grant\number_list.sql
@Sql\Bars\Grant\number_list.sql

prompt Script
prompt ...Sql\Bars\Script\key_transfer.sql
@Sql\Bars\Script\key_transfer.sql


spool off

quit

