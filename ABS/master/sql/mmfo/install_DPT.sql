set verify off
set echo off
set serveroutput on size 1000000
spool log\install.log
set lines 3000
 
prompt Load params.sql
@params.sql
@defs.sql
 
WHENEVER SQLERROR EXIT
prompt Перевірка логіну під BARS@&&database
conn bars/&&bars_pass@&&database
WHENEVER SQLERROR CONTINUE

prompt '---install DPT-module ---'
prompt '---create DPT types---'
@sql/type/type_DEPOSITREC.sql
@sql/type/type_DEPOSITSET.sql
@sql/type/type_PENALTYREC.sql
@sql/type/type_PENALTYSET.sql

prompt '---create DPT tables---'
@sql/table/t_DPT_ACCOUNTS.sql
@sql/table/t_DPT_DEPOSIT_ALL.sql
@sql/table/t_DPT_DEPOSIT_DETAILS.sql
@sql/table/t_DPT_REQ_TYPES.sql
@sql/table/t_DPT_VIDD_FLAGS.sql
@sql/table/t_DPT_REQUESTS.sql
@sql/table/t_DPT_TRUSTEE.sql
@sql/table/t_DPT_AGREEMENTS.sql
@sql/table/t_DPT_AGRW.sql
@sql/table/t_DPT_OP.sql
@sql/table/t_DPT_SHSROK.sql
@sql/table/t_DPT_SHOST.sql
@sql/table/t_DPT_SHTYPE.sql
@sql/table/t_DPT_STOP.sql
@sql/table/t_DPT_SHTERM.sql
@sql/table/t_DPT_STOP_A.sql
@sql/table/t_TAX_SETTINGS.sql
@sql/table/t_DPT_DICT_VIDD_DEBTRANS.sql
@sql/table/t_DPT_INHERITORS.sql
@sql/table/t_DPT_DEPOSIT_ACTION.sql
@sql/table/t_DPT_BONUSES.sql
@sql/table/t_DPT_REQUEST_STATES.sql
@sql/table/t_DPT_BONUS_REQUESTS.sql
@sql/table/t_DPT_EXTCONSENT.sql
@sql/table/t_DPT_IMMOBILE.sql
@sql/table/t_DPT_IMMOBILE_OB22.sql
@sql/table/t_DPT_REQ_CHGINTS.sql
@sql/table/t_DPT_REQ_DELDEALS.sql
@sql/table/t_DPT_TYPES.sql
@sql/table/t_DPT_VIDD_EXTYPES.sql
@sql/table/t_DPT_VIDD.sql
@sql/table/t_DPT_DEPOSIT_CLOS.sql
@sql/table/t_DPT_TECHACCOUNTS.sql
@sql/table/t_DPT_VIDD_TAGS.sql
@sql/table/t_DPT_VIDD_EXCLUSIVE.sql
@sql/table/t_DPT_VIDD_PARAMS.sql
@sql/table/t_DPT_VIDD_SCHEME.sql
@sql/table/t_DPT_FIELD.sql
@sql/table/t_DPT_DEPOSITW.sql
@sql/table/t_DPT_PAYMENTS.sql
@sql/table/t_TMP_INTARC.sql
@sql/table/t_EAD_STRUCT_CODES.sql
@sql/table/t_EAD_DOCS.sql
@sql/table/t_DPT_DEPOSIT.sql

prompt '---create DPT views---'
@sql/view/v_dpt_0.sql
@sql/view/v_dpt_30.sql
@sql/view/v_dpt_auto_extend.sql
@sql/view/v_ebk_cust_bd_info_v.sql                            
@sql/view/v_dpt_159.sql
@sql/view/v_dpt_accounts.sql
@sql/view/v_dpt_agr_dat.sql
@sql/view/v_dpt_bonus_requests.sql
@sql/view/v_dpt_bonuses_free.sql
@sql/view/v_dpt_chgintreq_active.sql
@sql/view/v_dpt_in_bonus_queue.sql
@sql/view/v_dpt_inheritors.sql
@sql/view/v_dpt_move2dmnd.sql
@sql/view/v_dpt_portfolio_active.sql
@sql/view/v_dpt_portfolio_all_active.sql
@sql/view/v_dpt_portfolio_all_closed.sql
@sql/view/v_dpt_tech_accounts.sql
@sql/view/v_dptext_pretenders.sql
@sql/view/v_dptext_refusreqs.sql
@sql/view/v_dptreviewratedeals.sql
@sql/view/v_techacc_operations.sql

prompt '---create DPT triggers---'

@sql/trigger/ead_docs_sign.sql
@sql/trigger/taiud_dptdepositw_update.sql
@sql/trigger/tau_dpttypes_flactive.sql
@sql/trigger/tbd_dpt_deposit.sql
@sql/trigger/tbiu_dptvidd_flag.sql
@sql/trigger/tbi_dptdepositclos.sql
@sql/trigger/tbi_dptdepositclos_bdate.sql
@sql/trigger/tbi_dpt_bonuses.sql
@sql/trigger/tbi_dpt_deposit.sql
@sql/trigger/tbi_dpt_trustee.sql
@sql/trigger/tbi_dpt_vidd.sql
@sql/trigger/tbi_dpt_vidd_scheme.sql
@sql/trigger/tiud_dpt_deposit.sql
@sql/trigger/tiud_dpt_vidd.sql
@sql/trigger/tiu_acc_balance_changes.sql
@sql/trigger/ead_docs_sign.sql

prompt '---create DPT sequences---'
@sql/sequence/s_dptreqs.sql
@sql/sequence/s_dpt_agreements.sql
@sql/sequence/s_dpt_deposit_clos.sql
@sql/sequence/s_dpt_trustee.sql



prompt '---create DPT functions---'
@sql/function/f_dpt_freq.sql
@sql/function/f_verify_cellphone.sql
@sql/function/f_verify_cellphone_byrnk.sql
@sql/function/f_is_pensioner.sql
@sql/function/f_get_dptamount.sql
@sql/function/f_get_deal_penalty.sql
@sql/function/f_dpt_stop.sql
@sql/function/f_dpt_get_transit.sql
@sql/function/f_dpt_get_s_transit.sql
@sql/function/f_dpt_hasno35agrmnt.sql
@sql/function/f_dpt_irrevocable.sql
@sql/function/f_mpno_ex.sql
@sql/function/f_get_taxrate.sql
@sql/function/f_dpt_trusty_options.sql
@sql/function/f_doc_dpt.sql
@sql/function/f_tickets_dpt.sql
@sql/function/f_get_dptagr_tarif.sql
@sql/function/f_get_dpt_metal_description.sql

prompt '---create DPT procedures---'


prompt '---create DPT pachages---'

prompt '---create DPT bmds ---'
@sql/data/bmd_DPT_DICT_VIDD_DEBTRANS.sql


prompt '---fill dictionaries ---'
@sql/data/data_DPT_REQ_TYPES.sql

spool off
exit
