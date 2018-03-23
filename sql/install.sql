@params.sql

@params.sql

set verify off
set echo off
set trimspool on
set serveroutput on size 1000000
spool log\install_(&&dbname).log
set lines 3000
set SQLBL on
set timing on
set escchar @


define release_name=Release_2.1.39.2
prompt...
prompt ...
prompt ... loading params
prompt ...
@params.sql
whenever sqlerror exit
prompt ...
prompt ... connecting as bars 
prompt ...
conn bars@&&dbname/&&bars_pass
whenever sqlerror continue

prompt ... 
prompt ... invalid objects before install
prompt ... 

select owner, object_name, object_type         
from all_objects a where a.status = 'INVALID' and a.owner in ('BARS','BARSUPL','BARS_DM','DM','MGW_AGENT','PFU','SBON','SYS','BARSTRANS','BARS_INGR','MSP', 'CDB', 'IBMESB', 'NBU_GATEWAY')
order by owner, object_type;

prompt ...
prompt ... calculating checksum for bars objects before install
prompt ...

exec bars.bars_release_mgr.install_begin('&&release_name');

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           


prompt @bars\Script\drop_trigger.sql 
@bars\Script\drop_trigger.sql 

exec bars.bc.home;
prompt @bars\Package\fin_nbu.sql
set define off
@bars\Package\fin_nbu.sql
show err

exec bars.bc.home;
prompt @bars\Package\fin_obu.sql
set define off
@bars\Package\fin_obu.sql
show err

exec bars.bc.home;
prompt @bars\Data\fin_forma2m.sql
set define off
@bars\Data\fin_forma2m.sql

exec bars.bc.home;
prompt @bars\Data\MIDDLE_NAMES.sql
set define off
@bars\Data\MIDDLE_NAMES.sql

exec bars.bc.home;
prompt @bars\Procedure\int15_n.sql
set define off
@bars\Procedure\int15_n.sql

exec bars.bc.home;
prompt @bars\Script\add_rep_5709.SQL
set define off
@bars\Script\add_rep_5709.SQL

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBM_REP_LICNLS.sql
set define off
@bars\Data\report\_BRS_SBM_REP_LICNLS.sql

exec bars.bc.home;
prompt @bars\Data\bmd\kl_k140.bmd
set define off
@bars\Data\bmd\kl_k140.bmd

exec bars.bc.home;
prompt @bars\Data\fill_table\kl_k140.sql
set define off
@bars\Data\fill_table\kl_k140.sql

exec bars.bc.home;
prompt @bars\Script\ins_customer_field_k140.sql
set define off
@bars\Script\ins_customer_field_k140.sql

exec bars.bc.home;
prompt @bars\Table\kl_k140.sql
set define off
@bars\Table\kl_k140.sql

exec bars.bc.home;
prompt @bars\Table\LOCPAY_FEE_LOG.sql
set define off
@bars\Table\LOCPAY_FEE_LOG.sql

exec bars.bc.home;
prompt @bars\Table\obpc_salary_import_log.sql
set define off
@bars\Table\obpc_salary_import_log.sql

exec bars.bc.home;
prompt @bars\Sequence\s_obpc_salary_import.sql
set define off
@bars\Sequence\s_obpc_salary_import.sql

exec bars.bc.home;
prompt @bars\Package\obpc.sql
set define off
@bars\Package\obpc.sql
show err

exec bars.bc.home;
prompt @bars\Table\ins_mapping_purpose.sql
set define off
@bars\Table\ins_mapping_purpose.sql

exec bars.bc.home;
prompt @bars\Table\ins_partners.sql
set define off
@bars\Table\ins_partners.sql

exec bars.bc.home;
prompt @bars\Table\ins_w4_deals.sql
set define off
@bars\Table\ins_w4_deals.sql

exec bars.bc.home;
prompt @bars\Table\ins_w4_deals_arc.sql
set define off
@bars\Table\ins_w4_deals_arc.sql

exec bars.bc.home;
prompt @bars\Table\w4_card.sql
set define off
@bars\Table\w4_card.sql

exec bars.bc.home;
prompt @bars\View\cm_client.sql
set define off
@bars\View\cm_client.sql
show errors view cm_client 

exec bars.bc.home;
prompt @bars\Trigger\tiu_cmclient.sql
set define off
@bars\Trigger\tiu_cmclient.sql

exec bc.home;

exec bars.bc.home;
prompt @bars\Script\add_EWA_params.sql
set define off
@bars\Script\add_EWA_params.sql

exec bars.bc.home;
prompt @bars\Script\add_new_operwfield.sql
set define off
@bars\Script\add_new_operwfield.sql

exec bars.bc.home;
prompt @bars\Script\add_new_par_W4KKC.sql
set define off
@bars\Script\add_new_par_W4KKC.sql

exec bars.bc.home;
prompt @bars\Script\add_ow_EWA_params.sql
set define off
@bars\Script\add_ow_EWA_params.sql

exec bars.bc.home;
prompt @bars\Script\alter_ins_partners.sql
set define off
@bars\Script\alter_ins_partners.sql

exec bars.bc.home;
prompt @bars\Script\fill_ow_trans_mask.sql
set define off
@bars\Script\fill_ow_trans_mask.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_OWI.SQL
set define off
@bars\Data\tts\et_OWI.SQL

exec bars.bc.home;
prompt @bars\Data\bmd\V_BRANCH_OBU.sql
set define off
@bars\Data\bmd\V_BRANCH_OBU.sql

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Function\f_stop.sql
set define off
@bars\Function\f_stop.sql

exec bars.bc.home;
prompt @bars\Package\ins_pack.sql
set define off
@bars\Package\ins_pack.sql
show err

exec bars.bc.home;
prompt @bars\Package\ins_ewa_mgr.sql
set define off
@bars\Package\ins_ewa_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Data\tts\et_PNA.sql
set define off
@bars\Data\tts\et_PNA.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_PNB.SQL
set define off
@bars\Data\tts\et_PNB.SQL

exec bars.bc.home;
prompt @bars\Procedure\p_back_dok.sql
set define off
@bars\Procedure\p_back_dok.sql

exec bars.bc.home;
prompt @bars\Package\dpt_web.sql
set define off
@bars\Package\dpt_web.sql
show err

exec bars.bc.home;
prompt @bars\Script\err_skrn.sql
set define off
@bars\Script\err_skrn.sql

exec bars.bc.home;
prompt @bars\Table\skrn_msg.sql
set define off
@bars\Table\skrn_msg.sql

exec bars.bc.home;
prompt @bars\Package\safe_deposit.sql
set define off
@bars\Package\safe_deposit.sql
show err

exec bars.bc.home;
prompt @bars\View\v_safe_deposit.sql
set define off
@bars\View\v_safe_deposit.sql
show errors view v_safe_deposit 

exec bars.bc.home;
prompt @bars\Job\JOB_SKRN_SMS.sql
set define off
@bars\Job\JOB_SKRN_SMS.sql

exec bars.bc.home;
prompt @bars\Data\error\soc_errors.sql
set define off
@bars\Data\error\soc_errors.sql

exec bars.bc.home;
prompt @bars\Package\dpt_social.sql
set define off
@bars\Package\dpt_social.sql
show err

exec bars.bc.home;
prompt @bars\Script\patch_dpt_file_header.sql
set define off
@bars\Script\patch_dpt_file_header.sql

exec bars.bc.home;
prompt @bars\Script\patch_dpt_file_row.sql
set define off
@bars\Script\patch_dpt_file_row.sql

exec bars.bc.home;
prompt @bars\Script\patch_dpt_file_row_upd.sql
set define off
@bars\Script\patch_dpt_file_row_upd.sql

exec bars.bc.home;
prompt @bars\Script\patch_social_agency.sql
set define off
@bars\Script\patch_social_agency.sql

exec bars.bc.home;
prompt @bars\View\v_dpt_file_row.sql
set define off
@bars\View\v_dpt_file_row.sql
show errors view v_dpt_file_row 

exec bars.bc.home;
prompt @bars\Data\pfu_filetypes_data.sql
set define off
@bars\Data\pfu_filetypes_data.sql

exec bars.bc.home;
prompt @bars\Package\pfu_ru_file_utl.sql
set define off
@bars\Package\pfu_ru_file_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\pfu_ru_epp_utl.sql
set define off
@bars\Package\pfu_ru_epp_utl.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_brs_xxx_cac_14.sql
set define off
@bars\Data\report\_brs_xxx_cac_14.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sber_cck_799.sql
set define off
@bars\Data\report\_brs_sber_cck_799.sql

exec bars.bc.home;
prompt @bars\Script\ins_6133_ins_mapping_purpose.sql
set define off
@bars\Script\ins_6133_ins_mapping_purpose.sql

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Data\tts\et_bmy.sql
set define off
@bars\Data\tts\et_bmy.sql

exec bars.bc.home;
prompt @bars\Script\patch_ACCOUNTS.sql.sql
set define off
@bars\Script\patch_ACCOUNTS.sql.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd6348_spr_rnbo_codes.sql
set define off
@bars\Script\upd6348_spr_rnbo_codes.sql

exec bars.bc.home;
prompt @bars\Package\INS_EWA_MGR.sql
set define off
@bars\Package\INS_EWA_MGR.sql
show err

exec bars.bc.home;
prompt @bars\Script\ins_6133_ins_mapping_purpose.sql
set define off
@bars\Script\ins_6133_ins_mapping_purpose.sql

exec bars.bc.home;
prompt @bars\Script\patch_customer.sql
set define off
@bars\Script\patch_customer.sql

exec bars.bc.home;
prompt @bars\Script\patch_customer_update.sql
set define off
@bars\Script\patch_customer_update.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebkc_duplicate_groups.sql
set define off
@bars\Script\patch_ebkc_duplicate_groups.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebkc_gcif.sql
set define off
@bars\Script\patch_ebkc_gcif.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebkc_queue_updatecard.sql
set define off
@bars\Script\patch_ebkc_queue_updatecard.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebkc_rcif.sql
set define off
@bars\Script\patch_ebkc_rcif.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebkc_sendcards_hist.sql
set define off
@bars\Script\patch_ebkc_sendcards_hist.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebkc_slave.sql
set define off
@bars\Script\patch_ebkc_slave.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebk_duplicate_groups.sql
set define off
@bars\Script\patch_ebk_duplicate_groups.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebk_prc_quality.sql
set define off
@bars\Script\patch_ebk_prc_quality.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebk_queue_updatecard.sql
set define off
@bars\Script\patch_ebk_queue_updatecard.sql

exec bars.bc.home;
prompt @bars\Script\patch_ebk_rcif.sql
set define off
@bars\Script\patch_ebk_rcif.sql

exec bars.bc.home;
prompt @bars\Job\ebk_card_pacakges_job.sql
set define off
@bars\Job\ebk_card_pacakges_job.sql

exec bars.bc.home;
prompt @bars\Job\ebk_closed_card_job.sql
set define off
@bars\Job\ebk_closed_card_job.sql

exec bars.bc.home;
prompt @bars\Job\ebk_group_duplicate_job.sql
set define off
@bars\Job\ebk_group_duplicate_job.sql

exec bars.bc.home;
prompt @bars\Job\ebk_rcif_pacakges_job.sql
set define off
@bars\Job\ebk_rcif_pacakges_job.sql

exec bars.bc.home;
prompt @bars\Job\ebkc_send_legal_cards.sql
set define off
@bars\Job\ebkc_send_legal_cards.sql

exec bars.bc.home;
prompt @bars\Job\ebkc_send_priv_cards.sql
set define off
@bars\Job\ebkc_send_priv_cards.sql

exec bars.bc.home;
prompt @bars\Package\ebk_dup_request_utl.sql
set define off
@bars\Package\ebk_dup_request_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\ebk_dup_wform_utl.sql
set define off
@bars\Package\ebk_dup_wform_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\ebk_params.sql
set define off
@bars\Package\ebk_params.sql
show err

exec bars.bc.home;
prompt @bars\Package\ebk_request_utl.sql
set define off
@bars\Package\ebk_request_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\ebk_wforms_utl.sql
set define off
@bars\Package\ebk_wforms_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\ebkc_pack.sql
set define off
@bars\Package\ebkc_pack.sql
show err

exec bars.bc.home;
prompt @bars\Package\ebkc_wforms_utl.sql
set define off
@bars\Package\ebkc_wforms_utl.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\ebk_create_rcif.sql
set define off
@bars\Procedure\ebk_create_rcif.sql

exec bars.bc.home;
prompt @bars\Procedure\ebk_sendcardpackages.sql
set define off
@bars\Procedure\ebk_sendcardpackages.sql

exec bars.bc.home;
prompt @bars\Procedure\ebk_sendclosedcard.sql
set define off
@bars\Procedure\ebk_sendclosedcard.sql

exec bars.bc.home;
prompt @bars\Trigger\tiu_cus.sql
set define off
@bars\Trigger\tiu_cus.sql

exec bars.bc.home;
prompt @bars\Trigger\tiu_cusa.sql
set define off
@bars\Trigger\tiu_cusa.sql

exec bars.bc.home;
prompt @bars\Trigger\tiu_cusb.sql
set define off
@bars\Trigger\tiu_cusb.sql

exec bars.bc.home;
prompt @bars\View\ebk_closed_card_v.sql
set define off
@bars\View\ebk_closed_card_v.sql
show errors view ebk_closed_card_v 

exec bars.bc.home;
prompt @bars\View\ebk_cust_bd_info_v.sql
set define off
@bars\View\ebk_cust_bd_info_v.sql
show errors view ebk_cust_bd_info_v 

exec bars.bc.home;
prompt @bars\View\ebk_dup_child_list_v.sql
set define off
@bars\View\ebk_dup_child_list_v.sql
show errors view ebk_dup_child_list_v 

exec bars.bc.home;
prompt @bars\View\ebk_dup_grp_list_v.sql
set define off
@bars\View\ebk_dup_grp_list_v.sql
show errors view ebk_dup_grp_list_v 

exec bars.bc.home;
prompt @bars\View\v_customer_gcif.sql
set define off
@bars\View\v_customer_gcif.sql
show errors view v_customer_gcif 

exec bars.bc.home;
prompt @bars\View\v_ebkc_dup_child_list_private.sql
set define off
@bars\View\v_ebkc_dup_child_list_private.sql
show errors view v_ebkc_dup_child_list_private 

exec bars.bc.home;
prompt @bars\View\v_ebkc_dup_grp_list_legal.sql
set define off
@bars\View\v_ebkc_dup_grp_list_legal.sql
show errors view v_ebkc_dup_grp_list_legal 

exec bars.bc.home;
prompt @bars\View\v_ebkc_dup_grp_list_private.sql
set define off
@bars\View\v_ebkc_dup_grp_list_private.sql
show errors view v_ebkc_dup_grp_list_private 

exec bars.bc.home;
prompt @bars\View\v_ebkc_legal_person.sql
set define off
@bars\View\v_ebkc_legal_person.sql
show errors view v_ebkc_legal_person 

exec bars.bc.home;
prompt @bars\View\v_ebkc_priv_attr_list.sql
set define off
@bars\View\v_ebkc_priv_attr_list.sql
show errors view v_ebkc_priv_attr_list 

exec bars.bc.home;
prompt @bars\View\v_ebkc_private_ent.sql
set define off
@bars\View\v_ebkc_private_ent.sql
show errors view v_ebkc_private_ent 

exec bars.bc.home;
prompt @bars\View\v_ebkc_queue_updcard_private.sql
set define off
@bars\View\v_ebkc_queue_updcard_private.sql
show errors view v_ebkc_queue_updcard_private 

exec bars.bc.home;
prompt @bars\Data\fill_table\customer_field.sql
set define off
@bars\Data\fill_table\customer_field.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ebk_card_attributes.sql
set define off
@bars\Data\fill_table\ebk_card_attributes.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ebk_prc_quality.sql
set define off
@bars\Data\fill_table\ebk_prc_quality.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ebkc_card_attributes.sql
set define off
@bars\Data\fill_table\ebkc_card_attributes.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\web_barsconfig.sql
set define off
@bars\Data\fill_table\web_barsconfig.sql

exec bars.bc.home;
prompt @bars\Data\operlist_CDM.sql
set define off
@bars\Data\operlist_CDM.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_xxx_obp_180.sql
set define off
@bars\Data\report\_brs_xxx_obp_180.sql

exec bars.bc.home;
prompt @bars\Data\path_cobummfo_4611.sql
set define off
@bars\Data\path_cobummfo_4611.sql

exec bars.bc.home;
prompt @bars\Table\TABLE_lic_nbs_dksu.sql
set define off
@bars\Table\TABLE_lic_nbs_dksu.sql

exec bars.bc.home;
prompt @bars\Procedure\RPTLIC_NLS_3052.prc
set define off
@bars\Procedure\RPTLIC_NLS_3052.prc

exec bars.bc.home;
prompt @bars\Data\bmd\META_LIC_NBS_.sql
set define off
@bars\Data\bmd\META_LIC_NBS_.sql

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBR_XXX_3052.sql
set define off
@bars\Data\report\_BRS_SBR_XXX_3052.sql

exec bars.bc.home;
prompt @bars\Procedure\PAY_TERMINAL_CLEARING.sql
set define off
@bars\Procedure\PAY_TERMINAL_CLEARING.sql

exec bars.bc.home;
prompt @bars\Script\add_func_pos.sql
set define off
@bars\Script\add_func_pos.sql

exec bars.bc.home;
prompt @bars\Script\OP_FIELD_TRMNL.sql
set define off
@bars\Script\OP_FIELD_TRMNL.sql

exec bars.bc.home;
prompt @bars\Procedure\rezerv_23.sql
set define off
@bars\Procedure\rezerv_23.sql

exec bars.bc.home;
prompt @bars\Table\meta_tables.sql
set define off
@bars\Table\meta_tables.sql

exec bars.bc.home;
prompt @bars\Package\bars_metabase.sql
set define off
@bars\Package\bars_metabase.sql
show err

exec bars.bc.home;
prompt @bars\Script\doprREC_VIPCL.SQL
set define off
@bars\Script\doprREC_VIPCL.SQL

exec bars.bc.home;
prompt @bars\Table\cust_access_fields.sql
set define off
@bars\Table\cust_access_fields.sql

exec bars.bc.home;
prompt @bars\Table\cust_access_types.sql
set define off
@bars\Table\cust_access_types.sql

exec bars.bc.home;
prompt @bars\Table\cust_access_userid.sql
set define off
@bars\Table\cust_access_userid.sql

exec bars.bc.home;
prompt @bars\Data\cust_access_fields.sql
set define off
@bars\Data\cust_access_fields.sql

exec bars.bc.home;
prompt @bars\Data\cust_access_types.sql
set define off
@bars\Data\cust_access_types.sql

exec bars.bc.home;
prompt @bars\Package\kl.sql
set define off
@bars\Package\kl.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Data\fm_risk_criteria_merge.sql
set define off
@bars\Data\fm_risk_criteria_merge.sql

exec bars.bc.home;
prompt @bars\Function\f_get_cust_hlist.sql
set define off
@bars\Function\f_get_cust_hlist.sql

exec bars.bc.home;
prompt @bars\Package\dpt_web.sql
set define off
@bars\Package\dpt_web.sql
show err

exec bars.bc.home;
prompt @bars\Script\err_skrn.sql
set define off
@bars\Script\err_skrn.sql

exec bars.bc.home;
prompt @bars\Table\skrn_msg.sql
set define off
@bars\Table\skrn_msg.sql

exec bars.bc.home;
prompt @bars\Package\safe_deposit.sql
set define off
@bars\Package\safe_deposit.sql
show err

exec bars.bc.home;
prompt @bars\View\v_safe_deposit.sql
set define off
@bars\View\v_safe_deposit.sql
show errors view v_safe_deposit 

exec bars.bc.home;
prompt @bars\Job\JOB_SKRN_SMS.sql
set define off
@bars\Job\JOB_SKRN_SMS.sql

exec bars.bc.home;
prompt @bars\Script\script_upd_tel.sql
set define off
@bars\Script\script_upd_tel.sql

exec bars.bc.home;
prompt @bars\Table\tgr.sql
set define off
@bars\Table\tgr.sql

exec bars.bc.home;
prompt @bars\Data\bmd\tgr.bmd
set define off
@bars\Data\bmd\tgr.bmd

exec bars.bc.home;
prompt @bars\Data\tgr.sql
set define off
@bars\Data\tgr.sql

exec bars.bc.home;
prompt @bars\Table\escr_reg_obj_state.sql
set define off
@bars\Table\escr_reg_obj_state.sql

exec bars.bc.home;
prompt @bars\Function\F_TARIF_CAA.sql
set define off
@bars\Function\F_TARIF_CAA.sql

exec bars.bc.home;
prompt @bars\Trigger\taiu_staff_substitute_corp2.sql
set define off
@bars\Trigger\taiu_staff_substitute_corp2.sql

exec bars.bc.home;
prompt @bars\Table\ow_oic_atransfers_hist.sql
set define off
@bars\Table\ow_oic_atransfers_hist.sql

exec bars.bc.home;
prompt @bars\Table\ow_oic_atransfers_data.sql
set define off
@bars\Table\ow_oic_atransfers_data.sql

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbr_dpt_4000.sql
set define off
@bars\Data\report\_brs_sbr_dpt_4000.sql

exec bars.bc.home;
prompt @bars\Data\operlist_ref_list.sql
set define off
@bars\Data\operlist_ref_list.sql

exec bars.bc.home;
prompt @bars\Script\spot.sql
set define off
@bars\Script\spot.sql

exec bars.bc.home;
prompt @bars\Procedure\spot_p.sql
set define off
@bars\Procedure\spot_p.sql

exec bars.bc.home;
prompt @bars\Data\bmd\v_spot.bmd
set define off
@bars\Data\bmd\v_spot.bmd

exec bars.bc.home;
prompt @bars\Table\cc_deal_update.sql
set define off
@bars\Table\cc_deal_update.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Data\dm_obj.sql
set define off
@bars_dm\Data\dm_obj.sql

prompt @bars_dm\Table\credits_zal.sql
set define off
@bars_dm\Table\credits_zal.sql

prompt @bars_dm\Table\customers.sql
set define off
@bars_dm\Table\customers.sql

prompt @bars_dm\Table\customers_plt.sql
set define off
@bars_dm\Table\customers_plt.sql

prompt @bars_dm\Table\deposits.sql
set define off
@bars_dm\Table\deposits.sql

prompt @bars_dm\Table\deposit_plt.sql
set define off
@bars_dm\Table\deposit_plt.sql

prompt @bars_dm\Table\custur_rel.sql
set define off
@bars_dm\Table\custur_rel.sql

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_sql.sql
set define off
@barsupl\Data\upl_sql.sql

prompt @barsupl\Data\upl_files.sql
set define off
@barsupl\Data\upl_files.sql

prompt @barsupl\Data\upl_columns_credits_zal.sql
set define off
@barsupl\Data\upl_columns_credits_zal.sql

prompt @barsupl\Data\upl_columns_cust_rel_s.sql
set define off
@barsupl\Data\upl_columns_cust_rel_s.sql

prompt @barsupl\Data\upl_columns_custrel_XRM.sql
set define off
@barsupl\Data\upl_columns_custrel_XRM.sql

prompt @barsupl\Data\upl_filegroups_rln.sql
set define off
@barsupl\Data\upl_filegroups_rln.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Procedure\dpt_inv.sql
set define off
@bars\Procedure\dpt_inv.sql

exec bars.bc.home;
prompt @bars\Package\pfu_ru_file_utl.sql
set define off
@bars\Package\pfu_ru_file_utl.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\paytt.sql
set define off
@bars\Procedure\paytt.sql

exec bars.bc.home;
prompt @bars\Procedure\pay_2620.sql
set define off
@bars\Procedure\pay_2620.sql

exec bars.bc.home;
prompt @bars\Sequence\S_CCK_CC_LIM_COPY.sql
set define off
@bars\Sequence\S_CCK_CC_LIM_COPY.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as BARS             
conn BARS@&&dbname/&&BARS_pass  
whenever sqlerror continue                           

prompt @BARS\Package\escr.sql
set define off
@BARS\Package\escr.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\View\v_ow_iic_msgcode.sql
set define off
@bars\View\v_ow_iic_msgcode.sql
show errors view v_ow_iic_msgcode 

exec bars.bc.home;
prompt @bars\Data\bmd\v_ow_iic_msgcode.bmd
set define off
@bars\Data\bmd\v_ow_iic_msgcode.bmd

exec bars.bc.home;
prompt @bars\Data\ow_iic_msgcode.sql
set define off
@bars\Data\ow_iic_msgcode.sql

exec bars.bc.home;
prompt @bars\Data\operlist_ref_list.sql
set define off
@bars\Data\operlist_ref_list.sql

exec bars.bc.home;
prompt @bars\Table\attribute_kind.sql
set define off
@bars\Table\attribute_kind.sql

exec bars.bc.home;
prompt @bars\Table\dwh_log.sql
set define off
@bars\Table\dwh_log.sql

exec bars.bc.home;
prompt @bars\Package\segmentation_pack.sql
set define off
@bars\Package\segmentation_pack.sql
show err

exec bars.bc.home;
prompt @bars\Package\tools.sql
set define off
@bars\Package\tools.sql
show err

exec bars.bc.home;
exec bars.bc.home;
prompt @bars\Script\COBUSUPABS-5813_CREATE_ATTRIBUTES.sql
set define off
@bars\Script\COBUSUPABS-5813_CREATE_ATTRIBUTES.sql

exec bars.bc.home;
prompt @bars\Script\COBUSUPABS-6102-6105_CREATE_ATTRIBUTES.sql
set define off
@bars\Script\COBUSUPABS-6102-6105_CREATE_ATTRIBUTES.sql

exec bars.bc.home;
prompt @bars\View\v_customer_segments.sql
set define off
@bars\View\v_customer_segments.sql
show errors view v_customer_segments 

exec bars.bc.home;
prompt @bars\View\v_customer_segments_capacity.sql
set define off
@bars\View\v_customer_segments_capacity.sql
show errors view v_customer_segments_capacity 

exec bars.bc.home;
prompt @bars\View\v_customer_segments_history.sql
set define off
@bars\View\v_customer_segments_history.sql
show errors view v_customer_segments_history 

exec bars.bc.home;
prompt @bars\Package\mway_mgr.sql
set define off
@bars\Package\mway_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Table\mbm_rel_customers.sql
set define off
@bars\Table\mbm_rel_customers.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsaq             
conn barsaq@&&dbname/&&barsaq_pass  
whenever sqlerror continue                           

prompt @barsaq\Grant\grants_to_bars.sql
set define off
@barsaq\Grant\grants_to_bars.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Package\ead_pack.sql
set define off
@bars\Package\ead_pack.sql
show err

exec bars.bc.home;
prompt @bars\Package\ead_integration.sql
set define off
@bars\Package\ead_integration.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_24_02.sql
set define off
@bars\Data\report\_brs_sbm_rep_24_02.sql

exec bars.bc.home;
prompt @bars\Script\patch_person.sql
set define off
@bars\Script\patch_person.sql

exec bars.bc.home;
prompt @bars\Function\f_stop.sql
set define off
@bars\Function\f_stop.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_PNB.SQL
set define off
@bars\Data\tts\et_PNB.SQL

exec bars.bc.home;
prompt @bars\Table\brm_install_log.sql
set define off
@bars\Table\brm_install_log.sql

exec bars.bc.home;
prompt @bars\Package\bars_release_mgr.sql
set define off
@bars\Package\bars_release_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Package\mbm_payments.sql
set define off
@bars\Package\mbm_payments.sql
show err

exec bars.bc.home;
prompt @bars\View\v_ins_grt_deals.sql
set define off
@bars\View\v_ins_grt_deals.sql
show errors view v_ins_grt_deals 

exec bars.bc.home;
prompt @bars\Data\fill_table\insert_ins_ewa_document_types.sql
set define off
@bars\Data\fill_table\insert_ins_ewa_document_types.sql

exec bars.bc.home;
prompt @bars\View\v_fm_osc_rule2.sql
set define off
@bars\View\v_fm_osc_rule2.sql
show errors view v_fm_osc_rule2 

exec bars.bc.home;
prompt @bars\View\v_fm_osc_rule22.sql
set define off
@bars\View\v_fm_osc_rule22.sql
show errors view v_fm_osc_rule22 

exec bars.bc.home;
prompt @bars\View\v_fm_osc_rule5.sql
set define off
@bars\View\v_fm_osc_rule5.sql
show errors view v_fm_osc_rule5 

exec bars.bc.home;
prompt @bars\View\v_fm_osc_rule6.sql
set define off
@bars\View\v_fm_osc_rule6.sql
show errors view v_fm_osc_rule6 

exec bars.bc.home;
prompt @bars\Script\update_passp_OBUMMFO-4884.sql
set define off
@bars\Script\update_passp_OBUMMFO-4884.sql

exec bars.bc.home;
prompt @bars\View\v_ise.sql
set define off
@bars\View\v_ise.sql
show errors view v_ise 

exec bars.bc.home;
prompt @bars\Data\bmd\v_ise.bmd
set define off
@bars\Data\bmd\v_ise.bmd

exec bars.bc.home;
prompt @bars\Script\Update_Customer_ISE_COBUSUPABS-6333.sql
set define off
@bars\Script\Update_Customer_ISE_COBUSUPABS-6333.sql

exec bars.bc.home;
prompt @bars\Function\f_stop.sql
set define off
@bars\Function\f_stop.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_columns_BPK2.sql
set define off
@barsupl\Data\upl_columns_BPK2.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Table\brm_install_log.sql
set define off
@bars\Table\brm_install_log.sql

exec bars.bc.home;
prompt @bars\Package\bars_release_mgr.sql
set define off
@bars\Package\bars_release_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Package\bms.sql
set define off
@bars\Package\bms.sql
show err

exec bars.bc.home;
prompt @bars\Script\chklistDPJ.sql
set define off
@bars\Script\chklistDPJ.sql

exec bars.bc.home;
prompt @bars\Package\neruhomi.sql
set define off
@bars\Package\neruhomi.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_loss_events.sql
set define off
@bars\Package\bars_loss_events.sql
show err

exec bars.bc.home;
prompt @bars\View\v_fm_osc_rule23.sql
set define off
@bars\View\v_fm_osc_rule23.sql
show errors view v_fm_osc_rule23 

exec bars.bc.home;
prompt @bars\Script\RKO_TTS_CL125.sql
set define off
@bars\Script\RKO_TTS_CL125.sql

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBM_REP_5009.sql
set define off
@bars\Data\report\_BRS_SBM_REP_5009.sql

exec bars.bc.home;
prompt @bars\Function\f_rep_5009.sql
set define off
@bars\Function\f_rep_5009.sql

exec bars.bc.home;
prompt @bars\Package\pfu_ru_epp_utl.sql
set define off
@bars\Package\pfu_ru_epp_utl.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBR_REP_5501.sql
set define off
@bars\Data\report\_BRS_SBR_REP_5501.sql

exec bars.bc.home;
prompt @bars\Data\operlist_ref_list.sql
set define off
@bars\Data\operlist_ref_list.sql

exec bars.bc.home;
prompt @bars\Table\sec_audit.sql
set define off
@bars\Table\sec_audit.sql

exec bars.bc.home;
prompt @bars\Package\bars_audit_adm.sql
set define off
@bars\Package\bars_audit_adm.sql
show err

exec bars.bc.home;
prompt @bars\Job\daily_compress_audit.sql
set define off
@bars\Job\daily_compress_audit.sql

--exec bars.bc.home;
prompt @bars\Script\compress_old_sec_audit.sql
--set define off
--@bars\Script\compress_old_sec_audit.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_filegroups_rln.sql
set define off
@barsupl\Data\upl_filegroups_rln.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Data\tts\et_IP1.sql
set define off
@bars\Data\tts\et_IP1.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_IP2.sql
set define off
@bars\Data\tts\et_IP2.sql

exec bars.bc.home;
prompt @bars\Procedure\PAY_TERMINAL_CLEARING.sql
set define off
@bars\Procedure\PAY_TERMINAL_CLEARING.sql

exec bars.bc.home;
prompt @bars\Script\add_par_w4_sparam.sql
set define off
@bars\Script\add_par_w4_sparam.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbr_rep_5502.sql
set define off
@bars\Data\report\_brs_sbr_rep_5502.sql

exec bars.bc.home;
prompt @bars\Script\tts65656571.sql
set define off
@bars\Script\tts65656571.sql

exec bars.bc.home;
prompt @bars\Function\F_TARIF_CAA.sql
set define off
@bars\Function\F_TARIF_CAA.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f6b_nn.sql
set define off
@bars\Procedure\p_f6b_nn.sql

exec bars.bc.home;
prompt @bars\Script\deb_6B_RU.sql
set define off
@bars\Script\deb_6B_RU.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f6b_nn.sql
set define off
@bars\Procedure\p_f6b_nn.sql

exec bars.bc.home;
prompt @bars\Script\deb_6B_RU.sql
set define off
@bars\Script\deb_6B_RU.sql

exec bars.bc.home;
exec bars.bc.home;
prompt @bars\Script\upd_paytt_no.sql
set define off
@bars\Script\upd_paytt_no.sql

exec bars.bc.home;
prompt @bars\Package\bars_release_mgr.sql
set define off
@bars\Package\bars_release_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Table\attribute_kind.sql
set define off
@bars\Table\attribute_kind.sql

exec bars.bc.home;
prompt @bars\Table\dwh_log.sql
set define off
@bars\Table\dwh_log.sql

exec bars.bc.home;
prompt @bars\Package\segmentation_pack.sql
set define off
@bars\Package\segmentation_pack.sql
show err

exec bars.bc.home;
prompt @bars\Package\tools.sql
set define off
@bars\Package\tools.sql
show err

exec bars.bc.home;
prompt @bars\Script\COBUSUPABS-5813_CREATE_ATTRIBUTES.sql
set define off
@bars\Script\COBUSUPABS-5813_CREATE_ATTRIBUTES.sql

exec bars.bc.home;
prompt @bars\Script\COBUSUPABS-6102-6105_CREATE_ATTRIBUTES.sql
set define off
@bars\Script\COBUSUPABS-6102-6105_CREATE_ATTRIBUTES.sql

exec bars.bc.home;
prompt @bars\View\v_customer_segments.sql
set define off
@bars\View\v_customer_segments.sql
show errors view v_customer_segments 

exec bars.bc.home;
prompt @bars\View\v_customer_segments_capacity.sql
set define off
@bars\View\v_customer_segments_capacity.sql
show errors view v_customer_segments_capacity 

exec bars.bc.home;
prompt @bars\View\v_customer_segments_history.sql
set define off
@bars\View\v_customer_segments_history.sql
show errors view v_customer_segments_history 

exec bars.bc.home;
prompt @bars\Data\bmd\ins_ewa_types.bmd
set define off
@bars\Data\bmd\ins_ewa_types.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\ins_types.bmd
set define off
@bars\Data\bmd\ins_types.bmd

exec bars.bc.home;
prompt @bars\Script\add_to_references.sql
set define off
@bars\Script\add_to_references.sql

exec bars.bc.home;
prompt @bars\Script\add_to_arm.sql
set define off
@bars\Script\add_to_arm.sql

exec bars.bc.home;
prompt @bars\Grant\grant_ins.sql
set define off
@bars\Grant\grant_ins.sql

exec bars.bc.home;
prompt @bars\Package\gerc_payments.sql
set define off
@bars\Package\gerc_payments.sql
show err

exec bars.bc.home;
prompt @bars\Package\ow_utl.sql
set define off
@bars\Package\ow_utl.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_brs_prvx_xxx_5504.sql
set define off
@bars\Data\report\_brs_prvx_xxx_5504.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_prvx_xxx_5505.sql
set define off
@bars\Data\report\_brs_prvx_xxx_5505.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_24_02.sql
set define off
@bars\Data\report\_brs_sbm_rep_24_02.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_xxx_obp_180.sql
set define off
@bars\Data\report\_brs_xxx_obp_180.sql

exec bars.bc.home;
prompt @bars\Script\PKR_2909_82.SQL
set define off
@bars\Script\PKR_2909_82.SQL

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbr_rep_5502.sql
set define off
@bars\Data\report\_brs_sbr_rep_5502.sql

exec bars.bc.home;
prompt @bars\Package\cck_dpk.sql
set define off
@bars\Package\cck_dpk.sql
show err

exec bars.bc.home;
prompt @bars\Package\cck.sql
set define off
@bars\Package\cck.sql
show err

exec bars.bc.home;
prompt @bars\Data\ow_iic_msgcode.sql
set define off
@bars\Data\ow_iic_msgcode.sql

exec bars.bc.home;
prompt @bars\Script\tts65836584.sql
set define off
@bars\Script\tts65836584.sql

exec bars.bc.home;
prompt @bars\Script\tts65656571.sql
set define off
@bars\Script\tts65656571.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_columns_CLIENTFO2.sql
set define off
@barsupl\Data\upl_columns_CLIENTFO2.sql

prompt @barsupl\Data\upl_columns_customers_plt.sql
set define off
@barsupl\Data\upl_columns_customers_plt.sql

prompt @barsupl\Data\upl_filegroups_rln.sql
set define off
@barsupl\Data\upl_filegroups_rln.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Script\upd_cl_ib_tts.sql
set define off
@bars\Script\upd_cl_ib_tts.sql

exec bars.bc.home;
prompt @bars\Data\applist\codeapp_KWT.sql
set define off
@bars\Data\applist\codeapp_KWT.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_2924.sql
set define off
@bars\Data\report\_brs_sbm_rep_2924.sql

exec bars.bc.home;
prompt @bars\Script\proc_PFU.sql
set define off
@bars\Script\proc_PFU.sql

exec bars.bc.home;
prompt @bars\Script\StNBU_100.sql
set define off
@bars\Script\StNBU_100.sql

exec bars.bc.home;
prompt @bars\Script\StNBU_100.sql
set define off
@bars\Script\StNBU_100.sql

exec bars.bc.home;
prompt @bars\Script\upd6409_customer_field.sql
set define off
@bars\Script\upd6409_customer_field.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f6b_nn.sql
set define off
@bars\Procedure\p_f6b_nn.sql

exec bars.bc.home;
prompt @bars\Script\dptvidd643.sql
set define off
@bars\Script\dptvidd643.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_columns_BPK2.sql
set define off
@barsupl\Data\upl_columns_BPK2.sql

prompt @barsupl\Data\upl_filegroups_rln.sql
set define off
@barsupl\Data\upl_filegroups_rln.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Function\check_blkd.sql
set define off
@bars\Function\check_blkd.sql

exec bars.bc.home;
prompt @bars\Script\upd_nbs_tips.sql
set define off
@bars\Script\upd_nbs_tips.sql

exec bars.bc.home;
prompt @bars\Function\nbs_ob22_rko.sql
set define off
@bars\Function\nbs_ob22_rko.sql

exec bars.bc.home;
prompt @bars\Package\rko.sql
set define off
@bars\Package\rko.sql
show err

exec bars.bc.home;
prompt @bars\Function\nbs_ob22_rko.sql
set define off
@bars\Function\nbs_ob22_rko.sql

exec bars.bc.home;
prompt @bars\Function\finmon_is_public.sql
set define off
@bars\Function\finmon_is_public.sql

exec bars.bc.home;
prompt @bars\Package\ead_pack.sql
set define off
@bars\Package\ead_pack.sql
show err

exec bars.bc.home;
prompt @bars\Script\pstts5107.sql
set define off
@bars\Script\pstts5107.sql

exec bars.bc.home;
prompt @bars\Script\tts65836584.sql
set define off
@bars\Script\tts65836584.sql

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Table\test_many.sql
set define off
@bars\Table\test_many.sql

exec bars.bc.home;
prompt @bars\Table\test_many_cck_df.sql
set define off
@bars\Table\test_many_cck_df.sql

exec bars.bc.home;
prompt @bars\Table\test_many_cck_dh.sql
set define off
@bars\Table\test_many_cck_dh.sql

exec bars.bc.home;
prompt @bars\Script\upd_E_TARID-COBUSUPABS-5617.sql
set define off
@bars\Script\upd_E_TARID-COBUSUPABS-5617.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_G07.sql
set define off
@bars\Data\tts\et_G07.sql

exec bars.bc.home;
prompt @bars\View\V_REPLACEMENT_ASSET.sql
set define off
@bars\View\V_REPLACEMENT_ASSET.sql
show errors view V_REPLACEMENT_ASSET 

exec bars.bc.home;
prompt @bars\Data\bmd\V_REPLACEMENT_ASSET.bmd
set define off
@bars\Data\bmd\V_REPLACEMENT_ASSET.bmd

exec bars.bc.home;
prompt @bars\Script\add_cc_tag_asset.sql
set define off
@bars\Script\add_cc_tag_asset.sql

exec bars.bc.home;
prompt @bars\Script\add_vid_restr_18_19.sql
set define off
@bars\Script\add_vid_restr_18_19.sql

exec bars.bc.home;
prompt @bars\Package\bars_xmlklb_imp.sql
set define off
@bars\Package\bars_xmlklb_imp.sql
show err

exec bars.bc.home;
prompt @bars\View\sto_sbon_imp_files.sql
set define off
@bars\View\sto_sbon_imp_files.sql
show errors view sto_sbon_imp_files 

exec bars.bc.home;
prompt @bars\Trigger\tiud_dpt_deposit.sql
set define off
@bars\Trigger\tiud_dpt_deposit.sql

--exec bars.bc.home;
prompt @bars\Script\dpt_deposit_clos_actual_wb.sql
--set define off
--@bars\Script\dpt_deposit_clos_actual_wb.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_columns_BPK2.sql
set define off
@barsupl\Data\upl_columns_BPK2.sql

prompt @barsupl\Data\upl_sql.sql
set define off
@barsupl\Data\upl_sql.sql

prompt @barsupl\Data\upl_filegroups_rln.sql
set define off
@barsupl\Data\upl_filegroups_rln.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Data\bmd\V1_OVRN.bmd
set define off
@bars\Data\bmd\V1_OVRN.bmd

exec bars.bc.home;
prompt @bars\Script\tts65836584.sql
set define off
@bars\Script\tts65836584.sql

exec bars.bc.home;
prompt @bars\Table\TMP_LINK_GROUP.sql
set define off
@bars\Table\TMP_LINK_GROUP.sql

exec bars.bc.home;
prompt @bars\Table\OTCN_CUST_PRINS.sql
set define off
@bars\Table\OTCN_CUST_PRINS.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd8_nn.sql
set define off
@bars\Procedure\p_fd8_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd9_nn.sql
set define off
@bars\Procedure\p_fd9_nn.sql

exec bars.bc.home;
prompt @bars\Package\kwt_2924.sql
set define off
@bars\Package\kwt_2924.sql
show err

exec bars.bc.home;
prompt @bars\Script\del_ttsap_N.sql
set define off
@bars\Script\del_ttsap_!!N.sql

exec bars.bc.home;
prompt @bars\Function\zvt_f.sql
set define off
@bars\Function\zvt_f.sql

exec bars.bc.home;
prompt @bars\Package\gerc_payments.sql
set define off
@bars\Package\gerc_payments.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\View\v_ow_oicrevfiles_form.sql
set define off
@bars\View\v_ow_oicrevfiles_form.sql
show errors view v_ow_oicrevfiles_form 

-- exec bars.bc.home;
-- prompt @bars\Script\upd5348_kl_f00.sql
-- set define off
-- @bars\Script\upd5348_kl_f00.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\Data\pfu_filetypes_data.sql
set define off
@bars\Data\pfu_filetypes_data.sql

exec bars.bc.home;
prompt @bars\Package\pfu_ru_epp_utl.sql
set define off
@bars\Package\pfu_ru_epp_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\pfu_ru_file_utl.sql
set define off
@bars\Package\pfu_ru_file_utl.sql
show err

exec bars.bc.home;
prompt @bars\Script\cc_zayavka_code2c.sql
set define off
@bars\Script\cc_zayavka_code2c.sql

exec bars.bc.home;
prompt @bars\Package\gerc_payments.sql
set define off
@bars\Package\gerc_payments.sql
show err

exec bars.bc.home;
prompt @bars\Script\FK_CUSTOMERIMGS_RNK.SQL
set define off
@bars\Script\FK_CUSTOMERIMGS_RNK.SQL

exec bars.bc.home;
prompt @bars\Table\fm_poss.sql
set define off
@bars\Table\fm_poss.sql

exec bars.bc.home;
prompt @bars\Data\fm_poss.sql
set define off
@bars\Data\fm_poss.sql

exec bars.bc.home;
prompt @bars\Data\bmd\customer_field.bmd
set define off
@bars\Data\bmd\customer_field.bmd

exec bars.bc.home;
prompt @bars\Package\sto_payment_utl.sql
set define off
@bars\Package\sto_payment_utl.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_24_02.sql
set define off
@bars\Data\report\_brs_sbm_rep_24_02.sql

exec bars.bc.home;
prompt @bars\Trigger\tddl_grant.sql
set define off
@bars\Trigger\tddl_grant.sql

exec bars.bc.home;
prompt @bars\Table\customer_address.sql
set define off
@bars\Table\customer_address.sql

exec bars.bc.home;
prompt @bars\Data\FM_BLK.sql
set define off
@bars\Data\FM_BLK.sql

exec bars.bc.home;
prompt @bars\Script\raise_fm_blk.sql
set define off
@bars\Script\raise_fm_blk.sql

exec bars.bc.home;
prompt @bars\Script\update_k_dfm03_COBUSUPABS-6729.sql
set define off
@bars\Script\update_k_dfm03_COBUSUPABS-6729.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as finmon             
conn finmon@&&dbname/&&finmon_pass  
whenever sqlerror continue                           

prompt @finmon\Script\update_k_dfm03_COBUSUPABS-6729.sql
set define off
@finmon\Script\update_k_dfm03_COBUSUPABS-6729.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Package\xoz.sql
set define off
@bars\Package\xoz.sql
show err

exec bars.bc.home;
prompt @bars\View\v_ow_iicfiles_form_sto.sql
set define off
@bars\View\v_ow_iicfiles_form_sto.sql
show errors view v_ow_iicfiles_form_sto 

exec bars.bc.home;
prompt @bars\View\v_more70_fm.sql
set define off
@bars\View\v_more70_fm.sql
show errors view v_more70_fm 

exec bars.bc.home;
prompt @bars\Package\gerc_payments.sql
set define off
@bars\Package\gerc_payments.sql
show err

exec bars.bc.home;
prompt @bars\Package\ESCR.sql
set define off
@bars\Package\ESCR.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Script\alter_okpof659.sql
set define off
@bars\Script\alter_okpof659.sql

exec bars.bc.home;
prompt @bars\Table\okpof659.sql
set define off
@bars\Table\okpof659.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\form_stru.sql
set define off
@bars\Data\fill_table\form_stru.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3b_nn.sql
set define off
@bars\Procedure\p_f3b_nn.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_lic1010.sql
set define off
@bars\Data\report\_brs_sbm_rep_lic1010.sql

exec bars.bc.home;
prompt @bars\Procedure\p_clt_sendsms.sql
set define off
@bars\Procedure\p_clt_sendsms.sql

exec bars.bc.home;
prompt @bars\Procedure\cck_to_bpk.sql
set define off
@bars\Procedure\cck_to_bpk.sql

exec bars.bc.home;
prompt @bars\View\v_fm_osc_rule21.sql
set define off
@bars\View\v_fm_osc_rule21.sql
show errors view v_fm_osc_rule21 

exec bars.bc.home;
prompt @bars\Table\fin_fm.sql
set define off
@bars\Table\fin_fm.sql

exec bars.bc.home;
prompt @bars\Table\fin_forma3_ref.sql
set define off
@bars\Table\fin_forma3_ref.sql

exec bars.bc.home;
prompt @bars\Table\fin_forma3_dm.sql
set define off
@bars\Table\fin_forma3_dm.sql

exec bars.bc.home;
prompt @bars\data\fill_table\fin_forma3_ref.sql
set define off
@bars\data\fill_table\fin_forma3_ref.sql

exec bars.bc.home;
prompt @bars\Package\fin_formaf3.sql
set define off
@bars\Package\fin_formaf3.sql
show err

exec bars.bc.home;
prompt @bars\data\7_funcs_fin_nbu.sql
set define off
@bars\data\7_funcs_fin_nbu.sql

-- exec bars.bc.home;
-- prompt @bars\Script\upd5348_kl_f00.sql
-- set define off
-- @bars\Script\upd5348_kl_f00.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\Function\is_date.sql
set define off
@bars\Function\is_date.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2c_nn.sql
set define off
@bars\Procedure\p_f2c_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd5606_p_l_2c.sql
set define off
@bars\Script\upd5606_p_l_2c.sql

exec bars.bc.home;
prompt @bars\Package\rko.sql
set define off
@bars\Package\rko.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Data\fill_table\dyn_filter_customer_rizik.sql
set define off
@bars\Data\fill_table\dyn_filter_customer_rizik.sql

exec bars.bc.home;
--prompt @bars\Data\fill_table\SPARAMLIST_BPK_PROECT.sql
--set define off
--@bars\Data\fill_table\SPARAMLIST_BPK_PROECT.sql

exec bars.bc.home;
prompt @bars\View\v_ead_docs.sql
set define off
@bars\View\v_ead_docs.sql
show errors view v_ead_docs 

exec bars.bc.home;
prompt @bars\Table\meta_tables.sql
set define off
@bars\Table\meta_tables.sql

exec bars.bc.home;
prompt @bars\Table\dyn_filter.sql
set define off
@bars\Table\dyn_filter.sql

exec bars.bc.home;
prompt @bars\Table\meta_actioncodes.sql
set define off
@bars\Table\meta_actioncodes.sql

exec bars.bc.home;
prompt @bars\Table\meta_actiontbl.sql
set define off
@bars\Table\meta_actiontbl.sql

exec bars.bc.home;
prompt @bars\Table\meta_reltypes.sql
set define off
@bars\Table\meta_reltypes.sql

exec bars.bc.home;
prompt @bars\Table\meta_coltypes.sql
set define off
@bars\Table\meta_coltypes.sql

exec bars.bc.home;
prompt @bars\Table\meta_columns.sql
set define off
@bars\Table\meta_columns.sql

exec bars.bc.home;
prompt @bars\Table\meta_browsetbl.sql
set define off
@bars\Table\meta_browsetbl.sql

exec bars.bc.home;
prompt @bars\Table\meta_icons.sql
set define off
@bars\Table\meta_icons.sql

exec bars.bc.home;
prompt @bars\Table\meta_nsifunction.sql
set define off
@bars\Table\meta_nsifunction.sql

exec bars.bc.home;
prompt @bars\Table\meta_call_settings.sql
set define off
@bars\Table\meta_call_settings.sql

exec bars.bc.home;
prompt @bars\Table\meta_col_intl_filters.sql
set define off
@bars\Table\meta_col_intl_filters.sql

exec bars.bc.home;
prompt @bars\Table\meta_dep_actiontype.sql
set define off
@bars\Table\meta_dep_actiontype.sql

exec bars.bc.home;
prompt @bars\Table\meta_dep_event.sql
set define off
@bars\Table\meta_dep_event.sql

exec bars.bc.home;
prompt @bars\Table\meta_dependency_cols.sql
set define off
@bars\Table\meta_dependency_cols.sql

exec bars.bc.home;
prompt @bars\Table\meta_extrnval.sql
set define off
@bars\Table\meta_extrnval.sql

exec bars.bc.home;
prompt @bars\Table\meta_filtercodes.sql
set define off
@bars\Table\meta_filtercodes.sql

exec bars.bc.home;
prompt @bars\Table\meta_filtertbl.sql
set define off
@bars\Table\meta_filtertbl.sql

exec bars.bc.home;
prompt @bars\Table\meta_func_settings.sql
set define off
@bars\Table\meta_func_settings.sql

exec bars.bc.home;
prompt @bars\Table\meta_mandatory_flags.sql
set define off
@bars\Table\meta_mandatory_flags.sql

exec bars.bc.home;
prompt @bars\Table\meta_month.sql
set define off
@bars\Table\meta_month.sql

exec bars.bc.home;
prompt @bars\Table\meta_regentry.sql
set define off
@bars\Table\meta_regentry.sql

exec bars.bc.home;
prompt @bars\Table\meta_sortorder.sql
set define off
@bars\Table\meta_sortorder.sql

exec bars.bc.home;
prompt @bars\Table\meta_taccess.sql
set define off
@bars\Table\meta_taccess.sql

exec bars.bc.home;
prompt @bars\Table\meta_tblcolor.sql
set define off
@bars\Table\meta_tblcolor.sql

exec bars.bc.home;
prompt @bars\Type\t_dyn_filter_cond_line.sql
set define off
@bars\Type\t_dyn_filter_cond_line.sql

exec bars.bc.home;
prompt @bars\Type\t_dyn_filter_cond_list.sql
set define off
@bars\Type\t_dyn_filter_cond_list.sql

exec bars.bc.home;
prompt @bars\Package\bars_metabase.sql
set define off
@bars\Package\bars_metabase.sql
show err

exec bars.bc.home;
prompt @bars\Data\fill_table\meta_icons.sql
set define off
@bars\Data\fill_table\meta_icons.sql

exec bars.bc.home;
prompt @bars\Procedure\p_inv_cck_fl_23.sql
set define off
@bars\Procedure\p_inv_cck_fl_23.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

-- exec bars.bc.home;
-- prompt @bars\Script\upd6762_kl_f20.sql
-- set define off
-- @bars\Script\upd6762_kl_f20.sql

exec bars.bc.home;
prompt @bars\Procedure\P_F20.sql
set define off
@bars\Procedure\P_F20.sql

exec bars.bc.home;
prompt @bars\Function\f_ret_type_r013.sql
set define off
@bars\Function\f_ret_type_r013.sql

exec bars.bc.home;
prompt @bars\Procedure\fm_set_rizik.sql
set define off
@bars\Procedure\fm_set_rizik.sql

-- exec bars.bc.home;
-- prompt @bars\Script\upd6762_kl_f20.sql
-- set define off
-- @bars\Script\upd6762_kl_f20.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_koddz.sql
set define off
@bars\Procedure\p_koddz.sql

exec bars.bc.home;
prompt @bars\Function\is_date.sql
set define off
@bars\Function\is_date.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2c_nn.sql
set define off
@bars\Procedure\p_f2c_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd5606_p_l_2c.sql
set define off
@bars\Script\upd5606_p_l_2c.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fa7_nn.sql
set define off
@bars\Procedure\p_fa7_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd5348_for_2K.sql
set define off
@bars\Script\upd5348_for_2K.sql

exec bars.bc.home;
prompt @bars\Table\kf_ru.sql
set define off
@bars\Table\kf_ru.sql

exec bars.bc.home;
prompt @bars\Table\d8_cust_link_groups.sql
set define off
@bars\Table\d8_cust_link_groups.sql

exec bars.bc.home;
prompt @bars\Script\remove_d8_cust_link_groups_update.sql
set define off
@bars\Script\remove_d8_cust_link_groups_update.sql

exec bars.bc.home;
prompt @bars\Procedure\p_d8_041.sql
set define off
@bars\Procedure\p_d8_041.sql

exec bars.bc.home;
prompt @bars\Procedure\p_clear_tmp_link_groups.sql
set define off
@bars\Procedure\p_clear_tmp_link_groups.sql

exec bars.bc.home;
prompt @bars\Procedure\p_set_link_groups.sql
set define off
@bars\Procedure\p_set_link_groups.sql

exec bars.bc.home;
prompt @bars\Data\operlist_COBUSUPABS-6160.sql
set define off
@bars\Data\operlist_COBUSUPABS-6160.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

-- exec bars.bc.home;
-- prompt @bars\Script\upd6121_form_stru_#C5.sql
-- set define off
-- @bars\Script\upd6121_form_stru_#C5.sql

exec bars.bc.home;
prompt @bars\Function\f_ret_nbsr_rez.sql
set define off
@bars\Function\f_ret_nbsr_rez.sql

exec bars.bc.home;
prompt @bars\Function\f_ret_type_r013.sql
set define off
@bars\Function\f_ret_type_r013.sql

exec bars.bc.home;
prompt @bars\Procedure\p_analiz_r013_calc.sql
set define off
@bars\Procedure\p_analiz_r013_calc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fc5.sql
set define off
@bars\Procedure\p_fc5.sql

exec bars.bc.home;
prompt @bars\Script\upd6121_form_stru_#3A.sql
set define off
@bars\Script\upd6121_form_stru_#3A.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3a_nn.sql
set define off
@bars\Procedure\p_f3a_nn.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_lic1010.sql
set define off
@bars\Data\report\_brs_sbm_rep_lic1010.sql

exec bars.bc.home;
prompt @bars\Table\ins_ewa_part_okpo.sql
set define off
@bars\Table\ins_ewa_part_okpo.sql

exec bars.bc.home;
prompt @bars\Table\ins_ewa_purp_mval.sql
set define off
@bars\Table\ins_ewa_purp_mval.sql

exec bars.bc.home;
prompt @bars\Table\ins_ewa_purp_m.sql
set define off
@bars\Table\ins_ewa_purp_m.sql

exec bars.bc.home;
prompt @bars\Table\ins_ewa_purp.sql
set define off
@bars\Table\ins_ewa_purp.sql

exec bars.bc.home;
prompt @bars\Table\ins_ewa_refs.sql
set define off
@bars\Table\ins_ewa_refs.sql

exec bars.bc.home;
prompt @bars\Table\ins_ewa_prod_pack.sql
set define off
@bars\Table\ins_ewa_prod_pack.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ins_ewa_types.sql
set define off
@bars\Data\fill_table\ins_ewa_types.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ins_ewa_part_okpo.sql
set define off
@bars\Data\fill_table\ins_ewa_part_okpo.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ins_ewa_purp_mval.sql
set define off
@bars\Data\fill_table\ins_ewa_purp_mval.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ins_ewa_purp_m.sql
set define off
@bars\Data\fill_table\ins_ewa_purp_m.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ins_ewa_purp.sql
set define off
@bars\Data\fill_table\ins_ewa_purp.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\ins_ewa_prod_pack.sql
set define off
@bars\Data\fill_table\ins_ewa_prod_pack.sql

exec bars.bc.home;
prompt @bars\View\INS_EWA_PURP_MASK.sql
set define off
@bars\View\INS_EWA_PURP_MASK.sql
show errors view INS_EWA_PURP_MASK 

exec bars.bc.home;
prompt @bars\Data\BMD\ins_ewa_part_okpo.bmd
set define off
@bars\Data\BMD\ins_ewa_part_okpo.bmd

exec bars.bc.home;
prompt @bars\Data\BMD\INS_EWA_PURP_MVAL.bmd
set define off
@bars\Data\BMD\INS_EWA_PURP_MVAL.bmd

exec bars.bc.home;
prompt @bars\Data\BMD\INS_EWA_PURP_M.bmd
set define off
@bars\Data\BMD\INS_EWA_PURP_M.bmd

exec bars.bc.home;
prompt @bars\Data\BMD\INS_EWA_PURP_MASK.bmd
set define off
@bars\Data\BMD\INS_EWA_PURP_MASK.bmd

exec bars.bc.home;
prompt @bars\Data\BMD\INS_EWA_PURP.bmd
set define off
@bars\Data\BMD\INS_EWA_PURP.bmd

exec bars.bc.home;
prompt @bars\Data\BMD\ins_ewa_prod_pack.bmd
set define off
@bars\Data\BMD\ins_ewa_prod_pack.bmd

exec bars.bc.home;
prompt @bars\Package\INS_EWA_MGR.sql
set define off
@bars\Package\INS_EWA_MGR.sql
show err

exec bars.bc.home;
prompt @bars\Package\BARS_OW.sql
set define off
@bars\Package\BARS_OW.sql
show err

exec bars.bc.home;
prompt @bars\Data\add_ewa_tab_to_arm_ru.sql
set define off
@bars\Data\add_ewa_tab_to_arm_ru.sql

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_owesk.sql
set define off
@bars\Package\bars_owesk.sql
show err

exec bars.bc.home;
prompt @bars\Data\tts\et_19B.sql
set define off
@bars\Data\tts\et_19B.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_301.sql
set define off
@bars\Data\tts\et_301.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_416.sql
set define off
@bars\Data\tts\et_416.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_417.sql
set define off
@bars\Data\tts\et_417.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_418.sql
set define off
@bars\Data\tts\et_418.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_cl1.sql
set define off
@bars\Data\tts\et_cl1.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_cl2.sql
set define off
@bars\Data\tts\et_cl2.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_cl5.sql
set define off
@bars\Data\tts\et_cl5.sql

exec bars.bc.home;
prompt @bars\Data\InsTar_VIP_RU.sql
set define off
@bars\Data\InsTar_VIP_RU.sql

exec bars.bc.home;
prompt @bars\Function\zvt_f.sql
set define off
@bars\Function\zvt_f.sql

exec bars.bc.home;
prompt @bars\View\v_rc_bnk.sql
set define off
@bars\View\v_rc_bnk.sql
show errors view v_rc_bnk 

exec bars.bc.home;
prompt @bars\Procedure\p_koddz.sql
set define off
@bars\Procedure\p_koddz.sql

exec bars.bc.home;
prompt @bars\View\our_branch.sql
set define off
@bars\View\our_branch.sql
show errors view our_branch 

exec bars.bc.home;
prompt @bars\View\v_branch_obu.sql
set define off
@bars\View\v_branch_obu.sql
show errors view v_branch_obu 

exec bars.bc.home;
prompt @bars\Package\bars_xmlklb_imp.sql
set define off
@bars\Package\bars_xmlklb_imp.sql
show err

exec bars.bc.home;
prompt @bars\View\sto_sbon_imp_files.sql
set define off
@bars\View\sto_sbon_imp_files.sql
show errors view sto_sbon_imp_files 

exec bars.bc.home;
prompt @bars\Package\dpt_views.sql
set define off
@bars\Package\dpt_views.sql
show err

exec bars.bc.home;
prompt @bars\Script\patch_person_update.sql
set define off
@bars\Script\patch_person_update.sql

exec bars.bc.home;
prompt @bars\Procedure\cck_osbb.sql
set define off
@bars\Procedure\cck_osbb.sql

exec bars.bc.home;
prompt @bars\Data\ACCOUNTS_FIELD_data_COBUPRVNIX_92.sql
set define off
@bars\Data\ACCOUNTS_FIELD_data_COBUPRVNIX_92.sql

exec bars.bc.home;
prompt @bars\Data\bpk_tags_data_COBUPRVNIX_92.sql
set define off
@bars\Data\bpk_tags_data_COBUPRVNIX_92.sql

exec bars.bc.home;
prompt @bars\Data\cc_tag_data_COBUPRVNIX_92.sql
set define off
@bars\Data\cc_tag_data_COBUPRVNIX_92.sql

exec bars.bc.home;
prompt @bars\Data\ps_sparam_data_COBUPRVNIX_92.sql
set define off
@bars\Data\ps_sparam_data_COBUPRVNIX_92.sql

exec bars.bc.home;
prompt @bars\Data\sparam_list_ru_COBUPRVNIX_92.sql
set define off
@bars\Data\sparam_list_ru_COBUPRVNIX_92.sql

--exec bars.bc.home;
prompt @bars\Script\dpt_deposit_clos_actual_wb.sql
--set define off
--@bars\Script\dpt_deposit_clos_actual_wb.sql

exec bars.bc.home;
prompt @bars\Data\FM_BLK.sql
set define off
@bars\Data\FM_BLK.sql

exec bars.bc.home;
prompt @bars\Script\raise_fm_blk.sql
set define off
@bars\Script\raise_fm_blk.sql

exec bars.bc.home;
prompt @bars\Script\Drop_constraint_FK_CIGCUSTIND_REGTERRIT.sql
set define off
@bars\Script\Drop_constraint_FK_CIGCUSTIND_REGTERRIT.sql

exec bars.bc.home;
prompt @bars\Table\brm_objects_hash.sql
set define off
@bars\Table\brm_objects_hash.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as sys             
conn sys@&&dbname/&&sys_pass  as sysdba
whenever sqlerror continue                           

prompt @sys\Script\create_user.sql
set define off
@sys\Script\create_user.sql

prompt @sys\Script\create_user_bars_intgr.sql
set define off
@sys\Script\create_user_bars_intgr.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barstrans             
conn barstrans@&&dbname/&&barstrans_pass  
whenever sqlerror continue                           

prompt @barstrans\Table\transport_tracking.sql
set define off
@barstrans\Table\transport_tracking.sql

prompt @barstrans\Table\transport_unit_type.sql
set define off
@barstrans\Table\transport_unit_type.sql

prompt @barstrans\Table\transport_unit.sql
set define off
@barstrans\Table\transport_unit.sql

prompt @barstrans\Sequence\s_transport_tracking.sql
set define off
@barstrans\Sequence\s_transport_tracking.sql

prompt @barstrans\Sequence\s_transport_unit.sql
set define off
@barstrans\Sequence\s_transport_unit.sql

prompt @barstrans\Sequence\s_transport_unit_type.sql
set define off
@barstrans\Sequence\s_transport_unit_type.sql

prompt @barstrans\Data\fill_table\add_unit_type.sql
set define off
@barstrans\Data\fill_table\add_unit_type.sql

prompt @barstrans\Package\file_utl.sql
set define off
@barstrans\Package\file_utl.sql
show err

prompt @barstrans\Package\transport_utl.sql
set define off
@barstrans\Package\transport_utl.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Table\staff_ad_user_mapping.sql
set define off
@bars\Table\staff_ad_user_mapping.sql

exec bars.bc.home;
prompt @bars\Package\branch_utl.sql
set define off
@bars\Package\branch_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_context.sql
set define off
@bars\Package\bars_context.sql
show err

exec bars.bc.home;
prompt @bars\Table\W4_ACC_REQUEST.sql
set define off
@bars\Table\W4_ACC_REQUEST.sql

exec bars.bc.home;
prompt @bars\Sequence\S_W4_ACC_REQUEST.sql
set define off
@bars\Sequence\S_W4_ACC_REQUEST.sql

exec bars.bc.home;
prompt @bars\Table\ow_oic_atransfers_data.sql
set define off
@bars\Table\ow_oic_atransfers_data.sql

exec bars.bc.home;
prompt @bars\Sequence\S_OW_CNG_TYPES.sql
set define off
@bars\Sequence\S_OW_CNG_TYPES.sql

exec bars.bc.home;
prompt @bars\Trigger\TBI_ow_cng_types.sql
set define off
@bars\Trigger\TBI_ow_cng_types.sql

exec bars.bc.home;
prompt @bars\View\v_w4_balance_txt.sql
set define off
@bars\View\v_w4_balance_txt.sql
show errors view v_w4_balance_txt 

exec bars.bc.home;
prompt @bars\Data\bmd\bmd_ref_OW_CNG_TYPES.sql
set define off
@bars\Data\bmd\bmd_ref_OW_CNG_TYPES.sql

exec bars.bc.home;
prompt @bars\Data\bmd\bmd_ref_V_W4_BALANCE_TXT.sql
set define off
@bars\Data\bmd\bmd_ref_V_W4_BALANCE_TXT.sql

exec bars.bc.home;
prompt @bars\Table\XRMSW_AUDIT.sql
set define off
@bars\Table\XRMSW_AUDIT.sql

exec bars.bc.home;
prompt @bars\Table\XRMSW_VERSION.sql
set define off
@bars\Table\XRMSW_VERSION.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_card_trans.sql
set define off
@bars\Table\xrmsw_card_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_customer_trans.sql
set define off
@bars\Table\xrmsw_customer_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_depositsign_trans.sql
set define off
@bars\Table\xrmsw_depositsign_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_deposit_trans.sql
set define off
@bars\Table\xrmsw_deposit_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_operation_types.sql
set define off
@bars\Table\xrmsw_operation_types.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_instantcardorder_trans.sql
set define off
@bars\Table\xrmsw_instantcardorder_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_getsetcardparam_trans.sql
set define off
@bars\Table\xrmsw_getsetcardparam_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_dkbo_trans.sql
set define off
@bars\Table\xrmsw_dkbo_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_depositagreement_trans.sql
set define off
@bars\Table\xrmsw_depositagreement_trans.sql

exec bars.bc.home;
prompt @bars\Table\XRMSW_SBON_TRANS.sql
set define off
@bars\Table\XRMSW_SBON_TRANS.sql

exec bars.bc.home;
prompt @bars\Table\XRMSW_FREESBON_TRANS.sql
set define off
@bars\Table\XRMSW_FREESBON_TRANS.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_query_log.sql
set define off
@bars\Table\xrmsw_query_log.sql

exec bars.bc.home;
prompt @bars\Script\xrmsw_operation_types_data.sql
set define off
@bars\Script\xrmsw_operation_types_data.sql

exec bars.bc.home;
prompt @bars\Package\ow_utl.sql
set define off
@bars\Package\ow_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\xrm_ui_oe.sql
set define off
@bars\Package\xrm_ui_oe.sql
show err

exec bars.bc.home;
prompt @bars\Package\sto_ui.sql
set define off
@bars\Package\sto_ui.sql
show err

exec bars.bc.home;
prompt @bars\Table\xrmsw_regular_trans.sql
set define off
@bars\Table\xrmsw_regular_trans.sql

exec bars.bc.home;
prompt @bars\Table\xrmsw_version.sql
set define off
@bars\Table\xrmsw_version.sql

exec bars.bc.home;
prompt @bars\Package\as_zip.sql
set define off
@bars\Package\as_zip.sql
show err

exec bars.bc.home;
prompt @bars\Sequence\s_ow_batch_files.sql
set define off
@bars\Sequence\s_ow_batch_files.sql

exec bars.bc.home;
prompt @bars\Table\ow_batch_files.sql
set define off
@bars\Table\ow_batch_files.sql

exec bars.bc.home;
prompt @bars\Table\ow_batch_open_data.sql
set define off
@bars\Table\ow_batch_open_data.sql

exec bars.bc.home;
prompt @bars\Table\ow_batch_photo.sql
set define off
@bars\Table\ow_batch_photo.sql

exec bars.bc.home;
prompt @bars\Package\OW_BATCH_OPENING.sql
set define off
@bars\Package\OW_BATCH_OPENING.sql
show err

exec bars.bc.home;
prompt @bars\Package\dpt_views.sql
set define off
@bars\Package\dpt_views.sql
show err

exec bars.bc.home;
prompt @bars\Package\XRM_INTEGRATION_OE.sql
set define off
@bars\Package\XRM_INTEGRATION_OE.sql
show err

exec bars.bc.home;
prompt @bars\Job\batch_porcessing_job.sql
set define off
@bars\Job\batch_porcessing_job.sql

exec bars.bc.home;
prompt @bars\Data\error\xrm_errors.sql
set define off
@bars\Data\error\xrm_errors.sql

exec bars.bc.home;
prompt @bars\View\v_op_field.sql
set define off
@bars\View\v_op_field.sql
show errors view v_op_field 

exec bars.bc.home;
prompt @bars\View\v_op_rules_xrm.sql
set define off
@bars\View\v_op_rules_xrm.sql
show errors view v_op_rules_xrm 

exec bars.bc.home;
prompt @bars\View\v_staff_chk_xrm.sql
set define off
@bars\View\v_staff_chk_xrm.sql
show errors view v_staff_chk_xrm 

exec bars.bc.home;
prompt @bars\View\v_staff_tts_xrm.sql
set define off
@bars\View\v_staff_tts_xrm.sql
show errors view v_staff_tts_xrm 

exec bars.bc.home;
prompt @bars\View\v_tts_xrm.sql
set define off
@bars\View\v_tts_xrm.sql
show errors view v_tts_xrm 

exec bars.bc.home;
prompt @bars\Package\lob_utl.sql
set define off
@bars\Package\lob_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\xrm_dyn_dict.sql
set define off
@bars\Package\xrm_dyn_dict.sql
show err

exec bars.bc.home;
prompt @bars\Package\xrm_maintenance.sql
set define off
@bars\Package\xrm_maintenance.sql
show err


@bars\View\V_VISALIST_XRM.sql
@bars\View\v_docs_tobo_out.sql

exec bars.bc.home;
prompt @bars\Package\xrm_intg_cashdesk.sql
set define off
@bars\Package\xrm_intg_cashdesk.sql
show err

exec bars.bc.home;
prompt @bars\Table\staff_ad_user_mapping.sql
set define off
@bars\Table\staff_ad_user_mapping.sql

exec bars.bc.home;
prompt @bars\View\v_tts_vob_xrm.sql
set define off
@bars\View\v_tts_vob_xrm.sql
show errors view v_tts_vob_xrm 

exec bars.bc.home;
prompt @bars\View\v_deal_type_xrm.sql
set define off
@bars\View\v_deal_type_xrm.sql
show errors view v_deal_type_xrm 

exec bars.bc.home;
prompt @bars\View\v_banks_xrm.sql
set define off
@bars\View\v_banks_xrm.sql
show errors view v_banks_xrm 

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_intgr             
conn bars_intgr@&&dbname/&&bars_intgr_pass  
whenever sqlerror continue                           

prompt @bars_intgr\View\VW_REF_STAFF_TTS.sql
set define off
@bars_intgr\View\VW_REF_STAFF_TTS.sql
show errors view VW_REF_STAFF_TTS 

prompt @bars_intgr\View\VW_REF_USER2GROUPS.sql
set define off
@bars_intgr\View\VW_REF_USER2GROUPS.sql
show errors view VW_REF_USER2GROUPS 

prompt @bars_intgr\View\VW_REF_BANKS.sql
set define off
@bars_intgr\View\VW_REF_BANKS.sql
show errors view VW_REF_BANKS 

prompt @bars_intgr\View\VW_REF_DEAL_TYPE.sql
set define off
@bars_intgr\View\VW_REF_DEAL_TYPE.sql
show errors view VW_REF_DEAL_TYPE 

prompt @bars_intgr\View\VW_REF_TTS_VOB.sql
set define off
@bars_intgr\View\VW_REF_TTS_VOB.sql
show errors view VW_REF_TTS_VOB 

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Script\transform_deposit_accounts.sql
set define off
@bars\Script\transform_deposit_accounts.sql

exec bars.bc.home;
prompt @bars\Package\dpt_utils.sql
set define off
@bars\Package\dpt_utils.sql
show err

exec bars.bc.home;
prompt @bars\Package\dpu_utils.sql
set define off
@bars\Package\dpu_utils.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff4_nn.sql
set define off
@bars\Procedure\p_ff4_nn.sql

exec bars.bc.home;
prompt @bars\Package\bars_loss_events.sql
set define off
@bars\Package\bars_loss_events.sql
show err

exec bars.bc.home;
prompt @bars\Package\dpt.sql
set define off
@bars\Package\dpt.sql
show err

exec bars.bc.home;
prompt @bars\Script\upd6687_lock_acc.sql
set define off
@bars\Script\upd6687_lock_acc.sql

exec bars.bc.home;
prompt @bars\Table\cim_f504.sql
set define off
@bars\Table\cim_f504.sql

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f504.bmd
set define off
@bars\Data\bmd\cim_f504.bmd

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

-- exec bars.bc.home;
-- prompt @bars\Data\fill_table\kl_f20.sql
-- set define off
-- @bars\Data\fill_table\kl_f20.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f20.sql
set define off
@bars\Procedure\p_f20.sql

exec bars.bc.home;
prompt @bars\Package\elt.sql
set define off
@bars\Package\elt.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_fa7_nn.sql
set define off
@bars\Procedure\p_fa7_nn.sql

exec bars.bc.home;
prompt @bars\Script\cim_credit_type.sql
set define off
@bars\Script\cim_credit_type.sql

exec bars.bc.home;
prompt @bars\Script\cim_creditor_type.sql
set define off
@bars\Script\cim_creditor_type.sql

exec bars.bc.home;
prompt @bars\Script\trunc_cim_credit_borrower.sql
set define off
@bars\Script\trunc_cim_credit_borrower.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_borrower.sql
set define off
@bars\Table\cim_credit_borrower.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_reorganization.sql
set define off
@bars\Table\cim_credit_reorganization.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_state_calc.sql
set define off
@bars\Table\cim_credit_state_calc.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_type.sql
set define off
@bars\Table\cim_credit_type.sql

exec bars.bc.home;
prompt @bars\Table\cim_creditor_type.sql
set define off
@bars\Table\cim_creditor_type.sql

exec bars.bc.home;
prompt @bars\Table\cim_f504.sql
set define off
@bars\Table\cim_f504.sql

exec bars.bc.home;
prompt @bars\View\v_cim_f503_reason.sql
set define off
@bars\View\v_cim_f503_reason.sql
show errors view v_cim_f503_reason 

exec bars.bc.home;
prompt @bars\View\v_cim_kod_34_2.sql
set define off
@bars\View\v_cim_kod_34_2.sql
show errors view v_cim_kod_34_2 

exec bars.bc.home;
prompt @bars\View\v_cim_kod_6a_3.sql
set define off
@bars\View\v_cim_kod_6a_3.sql
show errors view v_cim_kod_6a_3 

exec bars.bc.home;
prompt @bars\View\v_cim_kod_z200.sql
set define off
@bars\View\v_cim_kod_z200.sql
show errors view v_cim_kod_z200 

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_creditor_type.sql
set define off
@bars\Data\fill_table\cim_creditor_type.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_type.sql
set define off
@bars\Data\fill_table\cim_credit_type.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_state_calc.sql
set define off
@bars\Data\fill_table\cim_credit_state_calc.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_reorganization.sql
set define off
@bars\Data\fill_table\cim_credit_reorganization.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_prepay.sql
set define off
@bars\Data\fill_table\cim_credit_prepay.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_period.sql
set define off
@bars\Data\fill_table\cim_credit_period.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_f503_purpose.sql
set define off
@bars\Data\fill_table\cim_credit_f503_purpose.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_borrower.sql
set define off
@bars\Data\fill_table\cim_credit_borrower.sql

exec bars.bc.home;
prompt @bars\Data\bmd\v_cim_kod_6a_3.bmd
set define off
@bars\Data\bmd\v_cim_kod_6a_3.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f504.bmd
set define off
@bars\Data\bmd\cim_f504.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f503.bmd
set define off
@bars\Data\bmd\cim_f503.bmd

exec bars.bc.home;
prompt @bars\Package\dpt.sql
set define off
@bars\Package\dpt.sql
show err

exec bars.bc.home;
prompt @bars\Package\fin_rep.sql
set define off
@bars\Package\fin_rep.sql
show err

exec bars.bc.home;
prompt @bars\Table\cck_r011.sql
set define off
@bars\Table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Table\cck_r013.sql
set define off
@bars\Table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Table\sparam_list.sql
set define off
@bars\Table\sparam_list.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r011.sql
set define off
@bars\Data\fill_table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r013.sql
set define off
@bars\Data\fill_table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\sparam_list.sql
set define off
@bars\Data\fill_table\sparam_list.sql

exec bars.bc.home;
prompt @bars\Data\bmd\cck_r011.bmd
set define off
@bars\Data\bmd\cck_r011.bmd

prompt @bars\Data\tts\et_dui.sql
exec bars.bc.home;
@bars\Data\tts\et_dui.sql

prompt @bars\Data\tts\et_duj.sql
exec bars.bc.home;
@bars\Data\tts\et_duj.sql

prompt @bars\Sequence\s_accounts_rsrv.sql
@bars\Sequence\s_accounts_rsrv.sql

exec bars.bc.home;
prompt @bars\Table\ACCOUNTS_RSRV.sql
@bars\Table\ACCOUNTS_RSRV.sql

prompt @bars\View\v_reserved_acc.sql
@bars\View\v_reserved_acc.sql

prompt @bars\Function\f_newnls.sql
@bars\Function\f_newnls.sql

prompt @bars\Function\f_newnls2.sql
@bars\Function\f_newnls2.sql

prompt @bars\Function\f_newnls2old.sql
@bars\Function\f_newnls2old.sql

prompt @bars\Function\f_newnls3.sql
@bars\Function\f_newnls3.sql

prompt @bars\Procedure\branch_o.sql
@bars\Procedure\branch_o.sql

exec bars.bc.home;
@bars\Data\fill_table\doc_attr.sql

exec bars.bc.home;
@bars\Data\fill_table\doc_scheme.sql

exec bars.bc.home;
@bars\Data\fill_table\groups.sq

prompt @bars\Script\patch_accounts_rsrv.sql
@bars\Script\patch_accounts_rsrv.sql

exec bars.bc.home;
prompt @bars\Package\accreg.sql
set define off
@bars\Package\accreg.sql
show err

exec bars.bc.home;
prompt @bars\Package\cck.sql
set define off
@bars\Package\cck.sql
show err

exec bars.bc.home;
prompt @bars\Script\add_I1_NBUR_KOR_BALANCES.sql
set define off
@bars\Script\add_I1_NBUR_KOR_BALANCES.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f02_NN.sql
set define off
@bars\Procedure\p_f02_NN.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe2_nn.sql
set define off
@bars\Procedure\p_fe2_nn.sql

exec bars.bc.home;
prompt @bars\Package\dpt.sql
set define off
@bars\Package\dpt.sql
show err

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#D6.sql
-- set define off
-- @bars\Script\update_form_stru_#D6.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd6_nn.sql
set define off
@bars\Procedure\p_fd6_nn.sql

-- exec bars.bc.home;
-- prompt @bars\Script\alter_specparam_k072.sql
-- set define off
-- @bars\Script\alter_specparam_k072.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#08.sql
-- set define off
-- @bars\Script\update_form_stru_#08.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f08_nn.sql
set define off
@bars\Procedure\p_f08_nn.sql

exec bars.bc.home;
prompt @bars\Package\ead_integration.sql
set define off
@bars\Package\ead_integration.sql
show err

exec bars.bc.home;
prompt @bars\Package\ead_pack.sql
set define off
@bars\Package\ead_pack.sql
show err

exec bars.bc.home;
prompt @bars\Trigger\ead_docs_sign.sql
set define off
@bars\Trigger\ead_docs_sign.sql

exec bars.bc.home;
prompt @bars\Table\cck_r011.sql
set define off
@bars\Table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Table\cck_r013.sql
set define off
@bars\Table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r011.sql
set define off
@bars\Data\fill_table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r013.sql
set define off
@bars\Data\fill_table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Package\accreg.sql
set define off
@bars\Package\accreg.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\op_reg_lock.sql
set define off
@bars\Procedure\op_reg_lock.sql

exec bars.bc.home;
prompt @bars\Procedure\p_cck_update_sparams.sql
set define off
@bars\Procedure\p_cck_update_sparams.sql

exec bars.bc.home;
prompt @bars\Data\tms_task.sql
set define off
@bars\Data\tms_task.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#D5.sql
-- set define off
-- @bars\Script\update_form_stru_#D5.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd5_nn.sql
set define off
@bars\Procedure\p_fd5_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd6409_customer_field.sql
set define off
@bars\Script\upd6409_customer_field.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#07.sql
-- set define off
-- @bars\Script\update_form_stru_#07.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f07_nn.sql
set define off
@bars\Procedure\p_f07_nn.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Table\customers_plt.sql
set define off
@bars_dm\Table\customers_plt.sql

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_columns_CLIENTFO2.sql
set define off
@barsupl\Data\upl_columns_CLIENTFO2.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Procedure\p_f22sb.sql
set define off
@bars\Procedure\p_f22sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f27sb.sql
set define off
@bars\Procedure\p_f27sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f28sb.sql
set define off
@bars\Procedure\p_f28sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f32sb.sql
set define off
@bars\Procedure\p_f32sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f67sb.sql
set define off
@bars\Procedure\p_f67sb.sql

exec bars.bc.home;
prompt @bars\Table\swi_mti_list.sql
set define off
@bars\Table\swi_mti_list.sql

exec bars.bc.home;
prompt @bars\Script\update_SWI_MTI_LIST_5886.sql
set define off
@bars\Script\update_SWI_MTI_LIST_5886.sql

exec bars.bc.home;
prompt @bars\Table\SW_SYSTEM.sql
set define off
@bars\Table\SW_SYSTEM.sql

exec bars.bc.home;
prompt @bars\Table\SW_FILES.sql
set define off
@bars\Table\SW_FILES.sql

exec bars.bc.home;
prompt @bars\Table\SW_IMPORT.sql
set define off
@bars\Table\SW_IMPORT.sql

exec bars.bc.home;
prompt @bars\Table\SW_CA_FILES.sql
set define off
@bars\Table\SW_CA_FILES.sql

exec bars.bc.home;
prompt @bars\Table\SW_RU_FILES.sql
set define off
@bars\Table\SW_RU_FILES.sql

exec bars.bc.home;
prompt @bars\Table\SW_OWN.sql
set define off
@bars\Table\SW_OWN.sql

exec bars.bc.home;
prompt @bars\Table\SW_COMPARE.sql
set define off
@bars\Table\SW_COMPARE.sql

exec bars.bc.home;
prompt @bars\Table\SW_BRANCH_WS_PARAMETERS.sql
set define off
@bars\Table\SW_BRANCH_WS_PARAMETERS.sql

exec bars.bc.home;
prompt @bars\Table\SW_RU_FILES_HIST.sql
set define off
@bars\Table\SW_RU_FILES_HIST.sql

exec bars.bc.home;
prompt @bars\Table\SW_CA_FILES_HIST.sql
set define off
@bars\Table\SW_CA_FILES_HIST.sql

exec bars.bc.home;
prompt @bars\Table\SW_FILES_HIST.sql
set define off
@bars\Table\SW_FILES_HIST.sql

exec bars.bc.home;
prompt @bars\Table\SW_OPERATION.sql
set define off
@bars\Table\SW_OPERATION.sql

exec bars.bc.home;
prompt @bars\Table\SW_TT_OPER.SQL
set define off
@bars\Table\SW_TT_OPER.SQL

exec bars.bc.home;
prompt @bars\Table\SW_CAUSE_ERR.sql
set define off
@bars\Table\SW_CAUSE_ERR.sql

exec bars.bc.home;
prompt @bars\Table\SW_TT_OPER_KOM.sql
set define off
@bars\Table\SW_TT_OPER_KOM.sql

exec bars.bc.home;
prompt @bars\Sequence\S_SW_RU_FILES.sql
set define off
@bars\Sequence\S_SW_RU_FILES.sql

exec bars.bc.home;
prompt @bars\Sequence\S_SW_FILES.sql
set define off
@bars\Sequence\S_SW_FILES.sql

exec bars.bc.home;
prompt @bars\Sequence\S_SW_COMPARE.sql
set define off
@bars\Sequence\S_SW_COMPARE.sql

exec bars.bc.home;
prompt @bars\Script\error_log_5886.sql
set define off
@bars\Script\error_log_5886.sql

exec bars.bc.home;
prompt @bars\Script\create_user_5886.sql
set define off
@bars\Script\create_user_5886.sql

exec bars.bc.home;
prompt @bars\Script\INS_WEB_BARSCONFIG_5886.sql
set define off
@bars\Script\INS_WEB_BARSCONFIG_5886.sql

exec bars.bc.home;
prompt @bars\View\v_sw_compare.sql
set define off
@bars\View\v_sw_compare.sql
show errors view v_sw_compare 

exec bars.bc.home;
prompt @bars\View\v_sw_compare_list.sql
set define off
@bars\View\v_sw_compare_list.sql
show errors view v_sw_compare_list 

exec bars.bc.home;
prompt @bars\View\v_swi_mti_list.sql
set define off
@bars\View\v_swi_mti_list.sql
show errors view v_swi_mti_list 

exec bars.bc.home;
prompt @bars\View\v_sw_branch_ws_parameters.sql
set define off
@bars\View\v_sw_branch_ws_parameters.sql
show errors view v_sw_branch_ws_parameters 

exec bars.bc.home;
prompt @bars\View\v_swi_mti_list_light.sql
set define off
@bars\View\v_swi_mti_list_light.sql
show errors view v_swi_mti_list_light 

exec bars.bc.home;
prompt @bars\Data\SW_SYSTEM.sql
set define off
@bars\Data\SW_SYSTEM.sql

exec bars.bc.home;
prompt @bars\Data\SW_BRANCH_WS_PARAMETERS.sql
set define off
@bars\Data\SW_BRANCH_WS_PARAMETERS.sql

exec bars.bc.home;
prompt @bars\Data\SW_OPERATION.sql
set define off
@bars\Data\SW_OPERATION.sql

exec bars.bc.home;
prompt @bars\Data\SW_TT_OPER.sql
set define off
@bars\Data\SW_TT_OPER.sql

exec bars.bc.home;
prompt @bars\Data\SW_CAUSE_ERR.sql
set define off
@bars\Data\SW_CAUSE_ERR.sql

exec bars.bc.home;
prompt @bars\Data\SW_TT_OPER_KOM.sql
set define off
@bars\Data\SW_TT_OPER_KOM.sql

exec bars.bc.home;
prompt @bars\Package\pkg_sw_compare.sql
set define off
@bars\Package\pkg_sw_compare.sql
show err

exec bars.bc.home;
prompt @bars\Grant\COBUSUPABS-5886.sql
set define off
@bars\Grant\COBUSUPABS-5886.sql

exec bars.bc.home;
prompt @bars\Data\tts\et_D.sql
set define off
@bars\Data\tts\et_!!D.sql

exec bars.bc.home;
prompt @bars\Script\bp_rule_333.sql
set define off
@bars\Script\bp_rule_333.sql

exec bars.bc.home;
prompt @bars\Script\related_operations.sql
set define off
@bars\Script\related_operations.sql

exec bars.bc.home;
prompt @bars\Script\ins_mway_err.sql
set define off
@bars\Script\ins_mway_err.sql

exec bars.bc.home;
prompt @bars\Function\f_stop.sql
set define off
@bars\Function\f_stop.sql

exec bars.bc.home;
prompt @bars\Function\f_dpt_stop.sql
set define off
@bars\Function\f_dpt_stop.sql

exec bars.bc.home;
prompt @bars\Function\f_stop_dpt_sep.sql
set define off
@bars\Function\f_stop_dpt_sep.sql

exec bars.bc.home;
prompt @bars\Package\mway_mgr.sql
set define off
@bars\Package\mway_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Table\IBX_FILES.sql
@bars\Table\IBX_FILES.sql

exec bars.bc.home;
prompt @bars\Table\IBX_RECS.sql
@bars\Table\IBX_RECS.sql

exec bars.bc.home;
prompt @bars\Table\ibx_types.sql
@bars\Table\ibx_types.sql

exec bars.bc.home;
prompt @bars\Table\test_ibx_xml.sql
@bars\Table\test_ibx_xml.sql

exec bars.bc.home;
prompt @bars\Table\ibx_limits.sql
@bars\Table\ibx_limits.sql

exec bars.bc.home;
prompt @bars\Table\ibx_trade_point.sql
@bars\Table\ibx_trade_point.sql

exec bars.bc.home;
prompt @bars\Table\ibx_tp_params_lst.sql
@bars\Table\ibx_tp_params_lst.sql

exec bars.bc.home;
prompt @bars\Table\ibx_tp_params.sql
@bars\Table\ibx_tp_params.sql

exec bars.bc.home;
prompt @bars\Package\IBX_PACK.sql
set define off
@bars\Package\IBX_PACK.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBM_REP_699.sql
set define off
@bars\Data\report\_BRS_SBM_REP_699.sql

exec bars.bc.home;
prompt @bars\Procedure\p_sal_snp.sql
set define off
@bars\Procedure\p_sal_snp.sql

exec bars.bc.home;
prompt @bars\Data\report\BRS_SBR_DPT_3053_RU.sql
set define off
@bars\Data\report\BRS_SBR_DPT_3053_RU.sql

exec bars.bc.home;
prompt @bars\Table\xoz_ref_update.sql
set define off
@bars\Table\xoz_ref_update.sql

exec bars.bc.home;
prompt @bars\Sequence\s_xoz_ref_update.sql
set define off
@bars\Sequence\s_xoz_ref_update.sql

exec bars.bc.home;
prompt @bars\Trigger\taiud_xoz_ref_update.sql
set define off
@bars\Trigger\taiud_xoz_ref_update.sql

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBER_ICCK.sql
set define off
@bars\Data\report\_BRS_SBER_ICCK.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_24_02.sql
set define off
@bars\Data\report\_brs_sbm_rep_24_02.sql

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBR_REP_5501.sql
set define off
@bars\Data\report\_BRS_SBR_REP_5501.sql

exec bars.bc.home;
prompt @bars\View\v_sto_sbon_closed_accounts.sql
set define off
@bars\View\v_sto_sbon_closed_accounts.sql
show errors view v_sto_sbon_closed_accounts 

exec bars.bc.home;
prompt @bars\Function\zvt_f.sql
set define off
@bars\Function\zvt_f.sql

exec bars.bc.home;
prompt @bars\Data\InsTar_VIP_RU.sql
set define off
@bars\Data\InsTar_VIP_RU.sql

exec bars.bc.home;
prompt @bars\Procedure\form_saldoz.sql
set define off
@bars\Procedure\form_saldoz.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_lic1010.sql
set define off
@bars\Data\report\_brs_sbm_rep_lic1010.sql

exec bars.bc.home;
prompt @bars\Script\transform_deposit_accounts.sql
set define off
@bars\Script\transform_deposit_accounts.sql

exec bars.bc.home;
prompt @bars\Package\dpt_utils.sql
set define off
@bars\Package\dpt_utils.sql
show err

exec bars.bc.home;
prompt @bars\Package\dpu_utils.sql
set define off
@bars\Package\dpu_utils.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff4_nn.sql
set define off
@bars\Procedure\p_ff4_nn.sql

exec bars.bc.home;
prompt @bars\Package\bars_loss_events.sql
set define off
@bars\Package\bars_loss_events.sql
show err

exec bars.bc.home;
prompt @bars\Package\dpt.sql
set define off
@bars\Package\dpt.sql
show err

exec bars.bc.home;
prompt @bars\Script\upd6687_lock_acc.sql
set define off
@bars\Script\upd6687_lock_acc.sql

exec bars.bc.home;
prompt @bars\Table\cim_f504.sql
set define off
@bars\Table\cim_f504.sql

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f504.bmd
set define off
@bars\Data\bmd\cim_f504.bmd

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\Table\kol_nd_dat.sql
set define off
@bars\Table\kol_nd_dat.sql

exec bars.bc.home;
prompt @bars\Table\nd_kol_otc.sql
set define off
@bars\Table\nd_kol_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_set_kol_nd.sql
set define off
@bars\Procedure\p_set_kol_nd.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_otc.sql
set define off
@bars\Procedure\p_kol_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_cck_otc.sql
set define off
@bars\Procedure\p_kol_cck_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_cp_otc.sql
set define off
@bars\Procedure\p_kol_cp_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_deb_otc.sql
set define off
@bars\Procedure\p_kol_deb_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_nd_bpk_otc.sql
set define off
@bars\Procedure\p_kol_nd_bpk_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_nd_mbdk_otc.sql
set define off
@bars\Procedure\p_kol_nd_mbdk_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_nd_over_otc.sql
set define off
@bars\Procedure\p_kol_nd_over_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_nd_otc.sql
set define off
@bars\Procedure\p_kol_nd_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_nd_open.sql
set define off
@bars\Procedure\p_nd_open.sql

-- exec bars.bc.home;
-- prompt @bars\Data\fill_table\kl_f20.sql
-- set define off
-- @bars\Data\fill_table\kl_f20.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f20.sql
set define off
@bars\Procedure\p_f20.sql

exec bars.bc.home;
prompt @bars\Package\elt.sql
set define off
@bars\Package\elt.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_fa7_nn.sql
set define off
@bars\Procedure\p_fa7_nn.sql

exec bars.bc.home;
prompt @bars\Script\cim_credit_type.sql
set define off
@bars\Script\cim_credit_type.sql

exec bars.bc.home;
prompt @bars\Script\cim_creditor_type.sql
set define off
@bars\Script\cim_creditor_type.sql

exec bars.bc.home;
prompt @bars\Script\trunc_cim_credit_borrower.sql
set define off
@bars\Script\trunc_cim_credit_borrower.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_borrower.sql
set define off
@bars\Table\cim_credit_borrower.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_reorganization.sql
set define off
@bars\Table\cim_credit_reorganization.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_state_calc.sql
set define off
@bars\Table\cim_credit_state_calc.sql

exec bars.bc.home;
prompt @bars\Table\cim_credit_type.sql
set define off
@bars\Table\cim_credit_type.sql

exec bars.bc.home;
prompt @bars\Table\cim_creditor_type.sql
set define off
@bars\Table\cim_creditor_type.sql

exec bars.bc.home;
prompt @bars\Table\cim_f504.sql
set define off
@bars\Table\cim_f504.sql

exec bars.bc.home;
prompt @bars\View\v_cim_f503_reason.sql
set define off
@bars\View\v_cim_f503_reason.sql
show errors view v_cim_f503_reason 

exec bars.bc.home;
prompt @bars\View\v_cim_kod_34_2.sql
set define off
@bars\View\v_cim_kod_34_2.sql
show errors view v_cim_kod_34_2 

exec bars.bc.home;
prompt @bars\View\v_cim_kod_6a_3.sql
set define off
@bars\View\v_cim_kod_6a_3.sql
show errors view v_cim_kod_6a_3 

exec bars.bc.home;
prompt @bars\View\v_cim_kod_z200.sql
set define off
@bars\View\v_cim_kod_z200.sql
show errors view v_cim_kod_z200 

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_creditor_type.sql
set define off
@bars\Data\fill_table\cim_creditor_type.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_type.sql
set define off
@bars\Data\fill_table\cim_credit_type.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_state_calc.sql
set define off
@bars\Data\fill_table\cim_credit_state_calc.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_reorganization.sql
set define off
@bars\Data\fill_table\cim_credit_reorganization.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_prepay.sql
set define off
@bars\Data\fill_table\cim_credit_prepay.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_period.sql
set define off
@bars\Data\fill_table\cim_credit_period.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_f503_purpose.sql
set define off
@bars\Data\fill_table\cim_credit_f503_purpose.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cim_credit_borrower.sql
set define off
@bars\Data\fill_table\cim_credit_borrower.sql

exec bars.bc.home;
prompt @bars\Data\bmd\v_cim_kod_6a_3.bmd
set define off
@bars\Data\bmd\v_cim_kod_6a_3.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f504.bmd
set define off
@bars\Data\bmd\cim_f504.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f503.bmd
set define off
@bars\Data\bmd\cim_f503.bmd

exec bars.bc.home;
prompt @bars\Package\dpt.sql
set define off
@bars\Package\dpt.sql
show err

exec bars.bc.home;
prompt @bars\Package\fin_rep.sql
set define off
@bars\Package\fin_rep.sql
show err

exec bars.bc.home;
prompt @bars\Table\rez_cr.sql
set define off
@bars\Table\rez_cr.sql

exec bars.bc.home;
prompt @bars\Table\rez_par_9200.sql
set define off
@bars\Table\rez_par_9200.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\nbs_OB22_par_rez.sql
set define off
@bars\Data\fill_table\nbs_OB22_par_rez.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\SREZERV_OB22.sql
set define off
@bars\Data\fill_table\SREZERV_OB22.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\tmp_nbs_2401.sql
set define off
@bars\Data\fill_table\tmp_nbs_2401.sql

exec bars.bc.home;
prompt @bars\Function\f_bv_sna.sql
set define off
@bars\Function\f_bv_sna.sql

exec bars.bc.home;
prompt @bars\Function\rez_oznaka.sql
set define off
@bars\Function\rez_oznaka.sql

exec bars.bc.home;
prompt @bars\Procedure\pay_23.sql
set define off
@bars\Procedure\pay_23.sql

exec bars.bc.home;
prompt @bars\Procedure\pay_23_ob22.sql
set define off
@bars\Procedure\pay_23_ob22.sql

exec bars.bc.home;
prompt @bars\Procedure\p_2400.sql
set define off
@bars\Procedure\p_2400.sql

exec bars.bc.home;
prompt @bars\Procedure\p_2400_23.sql
set define off
@bars\Procedure\p_2400_23.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_deb.sql
set define off
@bars\Procedure\p_kol_deb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_nbu23_cr.sql
set define off
@bars\Procedure\p_nbu23_cr.sql

exec bars.bc.home;
prompt @bars\Procedure\rezerv_23.sql
set define off
@bars\Procedure\rezerv_23.sql

exec bars.bc.home;
prompt @bars\Procedure\rez_9200.sql
set define off
@bars\Procedure\rez_9200.sql

exec bars.bc.home;
prompt @bars\Procedure\rez_nd_val_1200.sql
set define off
@bars\Procedure\rez_nd_val_1200.sql

exec bars.bc.home;
prompt @bars\Procedure\cck_351.sql
set define off
@bars\Procedure\cck_351.sql

exec bars.bc.home;
prompt @bars\Procedure\cp_351.sql
set define off
@bars\Procedure\cp_351.sql

exec bars.bc.home;
prompt @bars\Package\z23.sql
set define off
@bars\Package\z23.sql
show err

exec bars.bc.home;
prompt @bars\Trigger\tiu_pawn_acc_nbs.sql
set define off
@bars\Trigger\tiu_pawn_acc_nbs.sql

exec bars.bc.home;
prompt @bars\View\v_351_fdat.sql
set define off
@bars\View\v_351_fdat.sql
show errors view v_351_fdat 

exec bars.bc.home;
prompt @bars\Data\bmd\v_351_fdat.bmd
set define off
@bars\Data\bmd\v_351_fdat.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\nbu23_rez_p.bmd
set define off
@bars\Data\bmd\nbu23_rez_p.bmd

exec bars.bc.home;
prompt @bars\Script\cc_accp_5207.sql
set define off
@bars\Script\cc_accp_5207.sql

exec bars.bc.home;
prompt @bars\Script\rez_par_9200.sql
set define off
@bars\Script\rez_par_9200.sql

exec bars.bc.home;
prompt @bars\Table\cck_r011.sql
set define off
@bars\Table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Table\cck_r013.sql
set define off
@bars\Table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Table\sparam_list.sql
set define off
@bars\Table\sparam_list.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r011.sql
set define off
@bars\Data\fill_table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r013.sql
set define off
@bars\Data\fill_table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\sparam_list.sql
set define off
@bars\Data\fill_table\sparam_list.sql

exec bars.bc.home;
prompt @bars\Data\bmd\cck_r011.bmd
set define off
@bars\Data\bmd\cck_r011.bmd

exec bars.bc.home;
prompt @bars\Package\accreg.sql
set define off
@bars\Package\accreg.sql
show err

exec bars.bc.home;
prompt @bars\Package\cck.sql
set define off
@bars\Package\cck.sql
show err

exec bars.bc.home;
prompt @bars\Script\add_I1_NBUR_KOR_BALANCES.sql
set define off
@bars\Script\add_I1_NBUR_KOR_BALANCES.sql

exec bars.bc.home;
prompt @bars\Script\populate_kor_turns.sql
set define off
@bars\Script\populate_kor_turns.sql

exec bars.bc.home;
prompt @bars\Procedure\NBUR_PREPARE_TURNS.sql
set define off
@bars\Procedure\NBUR_PREPARE_TURNS.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f02_NN.sql
set define off
@bars\Procedure\p_f02_NN.sql

exec bars.bc.home;
prompt @bars\Script\patch_w4_acc_update_0.sql
set define off
@bars\Script\patch_w4_acc_update_0.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe2_nn.sql
set define off
@bars\Procedure\p_fe2_nn.sql

exec bars.bc.home;
prompt @bars\Package\dpt.sql
set define off
@bars\Package\dpt.sql
show err

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#D6.sql
-- set define off
-- @bars\Script\update_form_stru_#D6.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd6_nn.sql
set define off
@bars\Procedure\p_fd6_nn.sql

-- exec bars.bc.home;
-- prompt @bars\Script\alter_specparam_k072.sql
-- set define off
-- @bars\Script\alter_specparam_k072.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#08.sql
-- set define off
-- @bars\Script\update_form_stru_#08.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f08_nn.sql
set define off
@bars\Procedure\p_f08_nn.sql

exec bars.bc.home;
prompt @bars\Package\ead_integration.sql
set define off
@bars\Package\ead_integration.sql
show err

exec bars.bc.home;
prompt @bars\Package\ead_pack.sql
set define off
@bars\Package\ead_pack.sql
show err

exec bars.bc.home;
prompt @bars\Trigger\ead_docs_sign.sql
set define off
@bars\Trigger\ead_docs_sign.sql

exec bars.bc.home;
prompt @bars\Table\cck_r011.sql
set define off
@bars\Table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Table\cck_r013.sql
set define off
@bars\Table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r011.sql
set define off
@bars\Data\fill_table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r013.sql
set define off
@bars\Data\fill_table\cck_r013.sql

exec bars.bc.home;
prompt @bars\Package\accreg.sql
set define off
@bars\Package\accreg.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\op_reg_lock.sql
set define off
@bars\Procedure\op_reg_lock.sql

exec bars.bc.home;
prompt @bars\Procedure\p_cck_update_sparams.sql
set define off
@bars\Procedure\p_cck_update_sparams.sql

exec bars.bc.home;
prompt @bars\Data\tms_task.sql
set define off
@bars\Data\tms_task.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#D5.sql
-- set define off
-- @bars\Script\update_form_stru_#D5.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd5_nn.sql
set define off
@bars\Procedure\p_fd5_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd6409_customer_field.sql
set define off
@bars\Script\upd6409_customer_field.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#07.sql
-- set define off
-- @bars\Script\update_form_stru_#07.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f07_nn.sql
set define off
@bars\Procedure\p_f07_nn.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Table\customers_plt.sql
set define off
@bars_dm\Table\customers_plt.sql

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_columns_CLIENTFO2.sql
set define off
@barsupl\Data\upl_columns_CLIENTFO2.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Procedure\p_f22sb.sql
set define off
@bars\Procedure\p_f22sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f27sb.sql
set define off
@bars\Procedure\p_f27sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f28sb.sql
set define off
@bars\Procedure\p_f28sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f32sb.sql
set define off
@bars\Procedure\p_f32sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f67sb.sql
set define off
@bars\Procedure\p_f67sb.sql

exec bars.bc.home;
prompt @bars\Package\dpu.sql
set define off
@bars\Package\dpu.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_f13_nn.sql
set define off
@bars\Procedure\p_f13_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fa7_nn.sql
set define off
@bars\Procedure\p_fa7_nn.sql

exec bars.bc.home;
prompt @bars\Package\prvn_flow.sql
set define off
@bars\Package\prvn_flow.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_fe2_nn.sql
set define off
@bars\Procedure\p_fe2_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f27sb.sql
set define off
@bars\Procedure\p_f27sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f28sb.sql
set define off
@bars\Procedure\p_f28sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd6_nn.sql
set define off
@bars\Procedure\p_fd6_nn.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as sys             
conn sys@&&dbname/&&sys_pass  as sysdba
whenever sqlerror continue                           

prompt @sys\User\IBMESB.sql
set define off
@sys\User\IBMESB.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Data\bmd\cck_r011.bmd
set define off
@bars\Data\bmd\cck_r011.bmd

exec bars.bc.home;
prompt @bars\Data\fill_table\cck_r011.sql
set define off
@bars\Data\fill_table\cck_r011.sql

exec bars.bc.home;
prompt @bars\Package\accreg.sql
set define off
@bars\Package\accreg.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_f08_nn.sql
set define off
@bars\Procedure\p_f08_nn.sql

exec bars.bc.home;
prompt @bars\Data\tms_task.sql
set define off
@bars\Data\tms_task.sql

exec bars.bc.home;
prompt @bars\Procedure\p_cck_update_sparams.sql
set define off
@bars\Procedure\p_cck_update_sparams.sql

exec bars.bc.home;
prompt @bars\Package\accreg.sql
set define off
@bars\Package\accreg.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\op_reg_lock.sql
set define off
@bars\Procedure\op_reg_lock.sql

exec bars.bc.home;
prompt @bars\Procedure\p_inv_cck_fl_23.sql
set define off
@bars\Procedure\p_inv_cck_fl_23.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f27sb.sql
set define off
@bars\Procedure\p_f27sb.sql

exec bars.bc.home;
prompt @bars\Script\insert_nbur_lnk_type_r020.sql
set define off
@bars\Script\insert_nbur_lnk_type_r020.sql

exec bars.bc.home;
prompt @bars\Table\cim_f503.sql
set define off
@bars\Table\cim_f503.sql

exec bars.bc.home;
prompt @bars\Table\cim_f504.sql
set define off
@bars\Table\cim_f504.sql

exec bars.bc.home;
prompt @bars\Package\cim_reports.sql
set define off
@bars\Package\cim_reports.sql
show err

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f503_auto_change_hist.bmd
set define off
@bars\Data\bmd\cim_f503_auto_change_hist.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f504_auto_change_hist.bmd
set define off
@bars\Data\bmd\cim_f504_auto_change_hist.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f503.bmd
set define off
@bars\Data\bmd\cim_f503.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f504.bmd
set define off
@bars\Data\bmd\cim_f504.bmd

exec bars.bc.home;
prompt @bars\Data\fill_table\CC_PAWN.sql
set define off
@bars\Data\fill_table\CC_PAWN.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\CC_PAWN23ADD.sql
set define off
@bars\Data\fill_table\CC_PAWN23ADD.sql

exec bars.bc.home;
prompt @bars\Table\inv_cck.sql
set define off
@bars\Table\inv_cck.sql

exec bars.bc.home;
prompt @bars\Data\bmd\inv_cck.bmd
set define off
@bars\Data\bmd\inv_cck.bmd

exec bars.bc.home;
prompt @bars\Data\bmd\INV_V_ZAL.bmd
set define off
@bars\Data\bmd\INV_V_ZAL.bmd

exec bars.bc.home;
prompt @bars\Function\f_acc8.sql
set define off
@bars\Function\f_acc8.sql

exec bars.bc.home;
prompt @bars\Function\f_cur.sql
set define off
@bars\Function\f_cur.sql

exec bars.bc.home;
prompt @bars\Function\f_nd_procn.sql
set define off
@bars\Function\f_nd_procn.sql

exec bars.bc.home;
prompt @bars\Function\inv_f_days.sql
set define off
@bars\Function\inv_f_days.sql

exec bars.bc.home;
prompt @bars\Function\inv_f_val.sql
set define off
@bars\Function\inv_f_val.sql

exec bars.bc.home;
prompt @bars\Procedure\inv_p_cck.sql
set define off
@bars\Procedure\inv_p_cck.sql

exec bars.bc.home;
prompt @bars\View\inv_v_zal.sql
set define off
@bars\View\inv_v_zal.sql
show errors view inv_v_zal 

exec bars.bc.home;
prompt @bars\Script\operlist_COBUSUPABS-5487.sql
set define off
@bars\Script\operlist_COBUSUPABS-5487.sql

exec bars.bc.home;
prompt @bars\Table\tmp_file03.sql
set define off
@bars\Table\tmp_file03.sql

exec bars.bc.home;
prompt @bars\Table\otcn_saldo.sql
set define off
@bars\Table\otcn_saldo.sql

exec bars.bc.home;
prompt @bars\Function\f_pop_otcn_snp.sql
set define off
@bars\Function\f_pop_otcn_snp.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f75sb.sql
set define off
@bars\Procedure\p_f75sb.sql

exec bars.bc.home;
prompt @bars\View\opl.sql
set define off
@bars\View\opl.sql
show errors view opl 

exec bars.bc.home;
prompt @bars\Function\f_ret_nbsr_rez.sql
set define off
@bars\Function\f_ret_nbsr_rez.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd5_nn.sql
set define off
@bars\Procedure\p_fd5_nn.sql

exec bars.bc.home;
prompt @bars\Package\cck_dpk.sql
set define off
@bars\Package\cck_dpk.sql
show err

exec bars.bc.home;
prompt @bars\Trigger\tbu_ccdeal_eib10.sql
set define off
@bars\Trigger\tbu_ccdeal_eib10.sql

exec bars.bc.home;
prompt @bars\Data\bmd\v_atmref17.bmd
set define off
@bars\Data\bmd\v_atmref17.bmd

exec bars.bc.home;
prompt @bars\Script\StNBU_100.sql
set define off
@bars\Script\StNBU_100.sql

-- exec bars.bc.home;
-- prompt @bars\Script\upd6299_kl_f3_29.sql
-- set define off
-- @bars\Script\upd6299_kl_f3_29.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f6b_nn.sql
set define off
@bars\Procedure\p_f6b_nn.sql

exec bars.bc.home;
prompt @bars\Script\alter6296_otc_history.sql
set define off
@bars\Script\alter6296_otc_history.sql

-- exec bars.bc.home;
-- prompt @bars\Script\upd6296_kl_f3_29.sql
-- set define off
-- @bars\Script\upd6296_kl_f3_29.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#F8.sql
-- set define off
-- @bars\Script\update_form_stru_#F8.sql

exec bars.bc.home;
prompt @bars\Table\otc_ff7_history_acc.sql
set define off
@bars\Table\otc_ff7_history_acc.sql

exec bars.bc.home;
prompt @bars\Table\otc_ff8_history_acc.sql
set define off
@bars\Table\otc_ff8_history_acc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff7.sql
set define off
@bars\Procedure\p_ff7.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff8.sql
set define off
@bars\Procedure\p_ff8.sql

-- exec bars.bc.home;
-- prompt @bars\Script\ddd_6b.sql
-- set define off
-- @bars\Script\ddd_6b.sql

exec bars.bc.home;
prompt @bars\Package\dpt.sql
set define off
@bars\Package\dpt.sql
show err

exec bars.bc.home;
prompt @bars\Script\alter6296_otc_history.sql
set define off
@bars\Script\alter6296_otc_history.sql

--exec bars.bc.home;
--prompt @bars\Script\upd6296_kl_f3_29.sql
--set define off
--@bars\Script\upd6296_kl_f3_29.sql

exec bars.bc.home;
prompt @bars\Script\update_form_stru_#F8.sql
set define off
@bars\Script\update_form_stru_#F8.sql

exec bars.bc.home;
prompt @bars\Table\otc_ff7_history_acc.sql
set define off
@bars\Table\otc_ff7_history_acc.sql

exec bars.bc.home;
prompt @bars\Table\otc_ff8_history_acc.sql
set define off
@bars\Table\otc_ff8_history_acc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff7.sql
set define off
@bars\Procedure\p_ff7.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff8.sql
set define off
@bars\Procedure\p_ff8.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f51_nn.sql
set define off
@bars\Procedure\p_f51_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff8.sql
set define off
@bars\Procedure\p_ff8.sql

-- exec bars.bc.home;
-- prompt @bars\Script\update_form_stru_#D8.sql
-- set define off
-- @bars\Script\update_form_stru_#D8.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fD8_nn.sql
set define off
@bars\Procedure\p_fD8_nn.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Table\customers_plt.sql
set define off
@bars_dm\Table\customers_plt.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\upl_columns_CLIENTFO2.sql
set define off
@barsupl\Data\upl_columns_CLIENTFO2.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Procedure\p_fe8_nn.sql
set define off
@bars\Procedure\p_fe8_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd9_nn.sql
set define off
@bars\Procedure\p_fd9_nn.sql

exec bars.bc.home;
prompt @bars\Function\f_pop_otcn_snp.sql
set define off
@bars\Function\f_pop_otcn_snp.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff7.sql
set define off
@bars\Procedure\p_ff7.sql

exec bars.bc.home;
prompt @bars\Table\nbur_ref_risk_s580.sql
set define off
@bars\Table\nbur_ref_risk_s580.sql

exec bars.bc.home;
prompt @bars\Data\nbur_ref_risk_s580.sql
set define off
@bars\Data\nbur_ref_risk_s580.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fc5.sql
set define off
@bars\Procedure\p_fc5.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f75sb.sql
set define off
@bars\Procedure\p_f75sb.sql

exec bars.bc.home;
prompt @bars\Trigger\tbu_ccdeal_eib10.sql
set define off
@bars\Trigger\tbu_ccdeal_eib10.sql

exec bars.bc.home;
prompt @bars\Script\alter_otcn_f71_cust.sql
set define off
@bars\Script\alter_otcn_f71_cust.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd8_nn.sql
set define off
@bars\Procedure\p_fd8_nn.sql

exec bars.bc.home;
prompt @bars\Table\otcn_f71_cust.sql
set define off
@bars\Table\otcn_f71_cust.sql

exec bars.bc.home;
prompt @bars\Table\rez_w4_bpk.sql
set define off
@bars\Table\rez_w4_bpk.sql

exec bars.bc.home;
prompt @bars\Table\rez_xoz_tip.sql
set define off
@bars\Table\rez_xoz_tip.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\SREZERV_OB22.sql
set define off
@bars\Data\fill_table\SREZERV_OB22.sql

exec bars.bc.home;
prompt @bars\Function\f_tip_xoz.sql
set define off
@bars\Function\f_tip_xoz.sql

exec bars.bc.home;
prompt @bars\Procedure\cp_351.sql
set define off
@bars\Procedure\cp_351.sql

exec bars.bc.home;
prompt @bars\Procedure\deb_351.sql
set define off
@bars\Procedure\deb_351.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_deb.sql
set define off
@bars\Procedure\p_kol_deb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_kol_deb_otc.sql
set define off
@bars\Procedure\p_kol_deb_otc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_nbu23_cr.sql
set define off
@bars\Procedure\p_nbu23_cr.sql

exec bars.bc.home;
prompt @bars\Data\tts\g01.sql
set define off
@bars\Data\tts\g01.sql

exec bars.bc.home;
prompt @bars\Data\tts\g02.sql
set define off
@bars\Data\tts\g02.sql

exec bars.bc.home;
prompt @bars\Package\gl.sql
set define off
@bars\Package\gl.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_fD8_nn.sql
set define off
@bars\Procedure\p_fD8_nn.sql

-- exec bars.bc.home;
-- prompt @bars\Script\add_nbs_fe8_30012018.sql
-- set define off
-- @bars\Script\add_nbs_fe8_30012018.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe8_nn.sql
set define off
@bars\Procedure\p_fe8_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fc5.sql
set define off
@bars\Procedure\p_fc5.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fa7_nn.sql
set define off
@bars\Procedure\p_fa7_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

-- exec bars.bc.home;
-- prompt @bars\Script\upd6296_kl_f3_29.sql
-- set define off
-- @bars\Script\upd6296_kl_f3_29.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff7.sql
set define off
@bars\Procedure\p_ff7.sql

exec bars.bc.home;
prompt @bars\Procedure\p_ff8.sql
set define off
@bars\Procedure\p_ff8.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f75sb.sql
set define off
@bars\Procedure\p_f75sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe8_nn.sql
set define off
@bars\Procedure\p_fe8_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd9_nn.sql
set define off
@bars\Procedure\p_fd9_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe2_nn.sql
set define off
@bars\Procedure\p_fe2_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fD8_nn.sql
set define off
@bars\Procedure\p_fD8_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd_for_7705.sql
set define off
@bars\Script\upd_for_7705.sql

exec bars.bc.home;
prompt @bars\View\v_ob22nu_n.sql
set define off
@bars\View\v_ob22nu_n.sql
show errors view v_ob22nu_n 

exec bars.bc.home;
prompt @bars\View\v_ob22nu80.sql
set define off
@bars\View\v_ob22nu80.sql
show errors view v_ob22nu80 

exec bars.bc.home;
prompt @bars\Procedure\p_f87sbr.sql
set define off
@bars\Procedure\p_f87sbr.sql

exec bars.bc.home;
prompt @bars\Procedure\int15_n.sql
set define off
@bars\Procedure\int15_n.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f02_nn.sql
set define off
@bars\Procedure\p_f02_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f1a_nn.sql
set define off
@bars\Procedure\p_f1a_nn.sql

exec bars.bc.home;
prompt @bars\Script\update_form_stru_int_@77.sql
set define off
@bars\Script\update_form_stru_int_@77.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f13_nn.sql
set define off
@bars\Procedure\p_f13_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\return_tranfer.sql
set define off
@bars\Procedure\return_tranfer.sql

exec bars.bc.home;
prompt @bars\Package\ebk_dup_request_utl.sql
set define off
@bars\Package\ebk_dup_request_utl.sql
show err

exec bars.bc.home;
prompt @bars\Package\ebkc_pack.sql
set define off
@bars\Package\ebkc_pack.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_f2k_nn.sql
set define off
@bars\Procedure\p_f2k_nn.sql

exec bars.bc.home;
prompt @bars\View\ebk_cust_bd_info_v.sql
set define off
@bars\View\ebk_cust_bd_info_v.sql
show errors view ebk_cust_bd_info_v 

exec bars.bc.home;
prompt @bars\View\ebk_queue_updatecard_v.sql
set define off
@bars\View\ebk_queue_updatecard_v.sql
show errors view ebk_queue_updatecard_v 

exec bars.bc.home;
prompt @bars\Procedure\p_f75sb.sql
set define off
@bars\Procedure\p_f75sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f07_nn.sql
set define off
@bars\Procedure\p_f07_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f08_nn.sql
set define off
@bars\Procedure\p_f08_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\cck_osbb.sql
set define off
@bars\Procedure\cck_osbb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f27sb.sql
set define off
@bars\Procedure\p_f27sb.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd8_nn.sql
set define off
@bars\Procedure\p_fd8_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd8_nn.sql
set define off
@bars\Procedure\p_fd8_nn.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_lic1010.sql
set define off
@bars\Data\report\_brs_sbm_rep_lic1010.sql

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBR_REP_5501.sql
set define off
@bars\Data\report\_BRS_SBR_REP_5501.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f75sb.sql
set define off
@bars\Procedure\p_f75sb.sql

exec bars.bc.home;
prompt @bars\Package\dpt_web.sql
set define off
@bars\Package\dpt_web.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_fd8_nn.sql
set define off
@bars\Procedure\p_fd8_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f2d_nn.sql
set define off
@bars\Procedure\p_f2d_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f37sb.sql
set define off
@bars\Procedure\p_f37sb.sql

exec bars.bc.home;
prompt @bars\Package\bars_zay.sql
set define off
@bars\Package\bars_zay.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_f07_nn.sql
set define off
@bars\Procedure\p_f07_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f08_nn.sql
set define off
@bars\Procedure\p_f08_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd5_nn.sql
set define off
@bars\Procedure\p_fd5_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fd6_nn.sql
set define off
@bars\Procedure\p_fd6_nn.sql

exec bars.bc.home;
prompt @bars\Script\add_nbs_fe8_14022018.sql
set define off
@bars\Script\add_nbs_fe8_14022018.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe8_nn.sql
set define off
@bars\Procedure\p_fe8_nn.sql

exec bars.bc.home;
prompt @bars\Data\report\_brs_sbm_rep_lic1010.sql
set define off
@bars\Data\report\_brs_sbm_rep_lic1010.sql

exec bars.bc.home;
prompt @bars\Data\InsTar_VIP_RU.sql
set define off
@bars\Data\InsTar_VIP_RU.sql

exec bars.bc.home;
prompt @bars\Procedure\p_cck_update_sparams.sql
set define off
@bars\Procedure\p_cck_update_sparams.sql

exec bars.bc.home;
prompt @bars\Script\Upd_5686.SQL
set define off
@bars\Script\Upd_5686.SQL

exec bars.bc.home;
prompt @bars\Function\F_TARIF_CAA.sql
set define off
@bars\Function\F_TARIF_CAA.sql

exec bars.bc.home;
prompt @bars\Function\F_TARIF_DPV.sql
set define off
@bars\Function\F_TARIF_DPV.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f70_nn.sql
set define off
@bars\Procedure\p_f70_nn.sql

exec bars.bc.home;
prompt @bars\Table\fm_poss.sql
set define off
@bars\Table\fm_poss.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\customer_field.sql
set define off
@bars\Data\fill_table\customer_field.sql

exec bars.bc.home;
prompt @bars\Data\bmd\fm_poss.bmd
set define off
@bars\Data\bmd\fm_poss.bmd

exec bars.bc.home;
prompt @bars\Data\fm_poss.sql
set define off
@bars\Data\fm_poss.sql

exec bars.bc.home;
prompt @bars\Package\cck_dop.sql
set define off
@bars\Package\cck_dop.sql
show err

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBER_ICCK.sql
set define off
@bars\Data\report\_BRS_SBER_ICCK.sql

exec bars.bc.home;
prompt @bars\Data\report\_BRS_SBER_ICCK2.sql
set define off
@bars\Data\report\_BRS_SBER_ICCK2.sql

exec bars.bc.home;
prompt @bars\Table\cim_f504.sql
set define off
@bars\Table\cim_f504.sql

exec bars.bc.home;
prompt @bars\Data\bmd\cim_f504.bmd
set define off
@bars\Data\bmd\cim_f504.bmd

exec bars.bc.home;
prompt @bars\Package\cim_reports.sql
set define off
@bars\Package\cim_reports.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Package\mway_mgr.sql
set define off
@bars\Package\mway_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Script\upd6914_zapros.sql
set define off
@bars\Script\upd6914_zapros.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f70_nn.sql
set define off
@bars\Procedure\p_f70_nn.sql

exec bars.bc.home;
prompt @bars\Script\patch_ACCOUNTS.sql.sql
set define off
@bars\Script\patch_ACCOUNTS.sql.sql

exec bars.bc.home;
prompt @bars\Function\f_nbu_rpt_xml_row.sql
set define off
@bars\Function\f_nbu_rpt_xml_row.sql

exec bars.bc.home;
prompt @bars\Procedure\P_F3KX_NN.sql
set define off
@bars\Procedure\P_F3KX_NN.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barstrans             
conn barstrans@&&dbname/&&barstrans_pass  
whenever sqlerror continue                           

prompt @barstrans\Script\modify_tru_Id.sql
set define off
@barstrans\Script\modify_tru_Id.sql

prompt @barstrans\Table\transport_unit.sql
set define off
@barstrans\Table\transport_unit.sql

prompt @barstrans\Table\transport_tracking.sql
set define off
@barstrans\Table\transport_tracking.sql

prompt @barstrans\Package\transport_utl.sql
set define off
@barstrans\Package\transport_utl.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Package\xrm_integration_oe.sql
set define off
@bars\Package\xrm_integration_oe.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Script\tts191992.sql
set define off
@bars\Script\tts191992.sql

exec bars.bc.home;
prompt @bars\Script\update_r011_nbs2620.sql
set define off
@bars\Script\update_r011_nbs2620.sql

exec bars.bc.home;
prompt @bars\Table\fin_deb_arc.sql
set define off
@bars\Table\fin_deb_arc.sql

exec bars.bc.home;
prompt @bars\Package\z23.sql
set define off
@bars\Package\z23.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_nbu23_cr.sql
set define off
@bars\Procedure\p_nbu23_cr.sql

exec bars.bc.home;
prompt @bars\Procedure\rezerv_23.sql
set define off
@bars\Procedure\rezerv_23.sql

-- exec bars.bc.home;
-- prompt @bars\Script\Create_file_f3V_ru.sql
-- set define off
-- @bars\Script\Create_file_f3V_ru.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3V_nn.sql
set define off
@bars\Procedure\p_f3V_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3V_nc.sql
set define off
@bars\Procedure\p_f3V_nc.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3V_ng.sql
set define off
@bars\Procedure\p_f3V_ng.sql

exec bars.bc.home;
prompt @bars\Package\dpu.sql
set define off
@bars\Package\dpu.sql
show err

exec bars.bc.home;
prompt @bars\Script\updatetts7090.sql
set define off
@bars\Script\updatetts7090.sql

exec bars.bc.home;
prompt @bars\Package\mbm_payments.sql
set define off
@bars\Package\mbm_payments.sql
show err

exec bars.bc.home;
prompt @bars\Table\TMP_CL_PAYMENT.sql
set define off
@bars\Table\TMP_CL_PAYMENT.sql

exec bars.bc.home;
prompt @bars\Package\bars_ow.sql
set define off
@bars\Package\bars_ow.sql
show err

exec bars.bc.home;
prompt @bars\Package\rep_inflation_court.sql
set define off
@bars\Package\rep_inflation_court.sql
show err

exec bars.bc.home;
prompt @bars\Table\f092.sql
set define off
@bars\Table\f092.sql

exec bars.bc.home;
prompt @bars\Data\fill_table\f092.sql
set define off
@bars\Data\fill_table\f092.sql

exec bars.bc.home;
prompt @bars\Data\bmd\f092.sql
set define off
@bars\Data\bmd\f092.sql

exec bars.bc.home;
prompt @bars\Script\add6251_opfield_F092.sql
set define off
@bars\Script\add6251_opfield_F092.sql

exec bars.bc.home;
prompt @bars\Script\add6251_oprules_F092.sql
set define off
@bars\Script\add6251_oprules_F092.sql

-- exec bars.bc.home;
-- prompt @bars\Script\create6251_#3K.sql
-- set define off
-- @bars\Script\create6251_#3K.sql

exec bars.bc.home;
prompt @bars\Function\f_nbu_rpt_xml_row.sql
set define off
@bars\Function\f_nbu_rpt_xml_row.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3kx_nn.sql
set define off
@bars\Procedure\p_f3kx_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3kx_nc.sql
set define off
@bars\Procedure\p_f3kx_nc.sql

exec bars.bc.home;
prompt @bars\Script\grant_tmp_cl_payment.sql
set define off
@bars\Script\grant_tmp_cl_payment.sql

exec bars.bc.home;
prompt @bars\Table\zayavka.sql
set define off
@bars\Table\zayavka.sql

exec bars.bc.home;
prompt @bars\View\v_zay.sql
set define off
@bars\View\v_zay.sql
show errors view v_zay 

exec bars.bc.home;
prompt @bars\View\v_zay_queue.sql
set define off
@bars\View\v_zay_queue.sql
show errors view v_zay_queue 

exec bars.bc.home;
prompt @bars\View\v_zay_buyform.sql
set define off
@bars\View\v_zay_buyform.sql
show errors view v_zay_buyform 

exec bars.bc.home;
prompt @bars\View\v_zay_salform.sql
set define off
@bars\View\v_zay_salform.sql
show errors view v_zay_salform 

exec bars.bc.home;
prompt @bars\Package\bars_zay.sql
set define off
@bars\Package\bars_zay.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\rnk2rnk.sql
set define off
@bars\Procedure\rnk2rnk.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f3kx_nn.sql
set define off
@bars\Procedure\p_f3kx_nn.sql

exec bars.bc.home;
prompt @bars\Table\rez_xoz_tip.sql
set define off
@bars\Table\rez_xoz_tip.sql

-- exec bars.bc.home;
-- prompt @bars\Procedure\p_fa7_nn.sql
-- set define off
-- @bars\Procedure\p_fa7_nn.sql

exec bars.bc.home;
prompt @bars\Script\constraint_INTRT_ND_REST_RU.sql
set define off
@bars\Script\constraint_INTRT_ND_REST_RU.sql

exec bars.bc.home;
prompt @bars\Function\f_nbu_rpt_xml_row.sql
set define off
@bars\Function\f_nbu_rpt_xml_row.sql

exec bars.bc.home;
prompt @bars\Procedure\P_F3KX_NN.sql
set define off
@bars\Procedure\P_F3KX_NN.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe8_nn.sql
set define off
@bars\Procedure\p_fe8_nn.sql

exec bars.bc.home;
prompt @bars\Procedure\p_f1p_nn.sql
set define off
@bars\Procedure\p_f1p_nn.sql

exec bars.bc.home;
prompt @bars\Script\upd6914_zapros2.sql
set define off
@bars\Script\upd6914_zapros2.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars_dm             
conn bars_dm@&&dbname/&&bars_dm_pass  
whenever sqlerror continue                           

prompt @bars_dm\Table\bpk.sql
set define off
@bars_dm\Table\bpk.sql

prompt @bars_dm\Table\bpk_plt.sql
set define off
@bars_dm\Table\bpk_plt.sql

prompt @bars_dm\Table\credits_stat.sql
set define off
@bars_dm\Table\credits_stat.sql

prompt @bars_dm\Table\deposit_plt.sql
set define off
@bars_dm\Table\deposit_plt.sql

prompt @bars_dm\Table\deposits.sql
set define off
@bars_dm\Table\deposits.sql

prompt @bars_dm\Table\dm_accounts.sql
set define off
@bars_dm\Table\dm_accounts.sql

prompt @bars_dm\Package\dm_import.sql
set define off
@bars_dm\Package\dm_import.sql
show err

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as barsupl             
conn barsupl@&&dbname/&&barsupl_pass  
whenever sqlerror continue                           

prompt @barsupl\Data\BPK.sql
set define off
@barsupl\Data\BPK.sql

prompt @barsupl\Data\BPK2.sql
set define off
@barsupl\Data\BPK2.sql

prompt @barsupl\Data\Credits_s.sql
set define off
@barsupl\Data\Credits_s.sql

prompt @barsupl\Data\crm_accounts.sql
set define off
@barsupl\Data\crm_accounts.sql

prompt @barsupl\Data\deposits.sql
set define off
@barsupl\Data\deposits.sql

prompt @barsupl\Data\deposits2.sql
set define off
@barsupl\Data\deposits2.sql

prompt ...                                           
prompt ... loading params                            
prompt ...                                           
@params.sql                                          
whenever sqlerror exit                               
prompt ...                                           
prompt ... connecting as bars             
conn bars@&&dbname/&&bars_pass  
whenever sqlerror continue                           

exec bars.bc.home;
prompt @bars\Data\report\BRS_SBR_DPT_3053_RU.sql
set define off
@bars\Data\report\BRS_SBR_DPT_3053_RU.sql

exec bars.bc.home;
prompt @bars\Script\Proc_RU.SQL
set define off
@bars\Script\Proc_RU.SQL

exec bars.bc.home;
prompt @bars\Script\StavkaNBU_RU.SQL
set define off
@bars\Script\StavkaNBU_RU.SQL

exec bars.bc.home;
prompt @bars\Procedure\p_f3kx_nn.sql
set define off
@bars\Procedure\p_f3kx_nn.sql

exec bars.bc.home;
prompt @bars\Script\xoz_ref_arc.sql
set define off
@bars\Script\xoz_ref_arc.sql

exec bars.bc.home;
prompt @bars\Table\zayavka.sql
set define off
@bars\Table\zayavka.sql

exec bars.bc.home;
prompt @bars\View\v_zay_queue.sql
set define off
@bars\View\v_zay_queue.sql
show errors view v_zay_queue 

exec bars.bc.home;
prompt @bars\Data\applist\codeapp_ZAY2122.sql
set define off
@bars\Data\applist\codeapp_ZAY2122.sql

exec bars.bc.home;
prompt @bars\Data\error\mod_zay.sql
set define off
@bars\Data\error\mod_zay.sql

exec bars.bc.home;
prompt @bars\Procedure\p_fe8_nn.sql
set define off
@bars\Procedure\p_fe8_nn.sql

exec bars.bc.home;
prompt @bars\Data\applist\codeapp_ZAY2122.sql
set define off
@bars\Data\applist\codeapp_ZAY2122.sql

exec bars.bc.home;
prompt @bars\Package\bars_zay.sql
set define off
@bars\Package\bars_zay.sql
show err

exec bars.bc.home;
prompt @bars\Script\upd6251_form_stru.sql
set define off
@bars\Script\upd6251_form_stru.sql

exec bars.bc.home;
prompt @bars\Package\mway_mgr.sql
set define off
@bars\Package\mway_mgr.sql
show err

exec bars.bc.home;
prompt @bars\Package\bars_zay.sql
set define off
@bars\Package\bars_zay.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_fe8_nn.sql
set define off
@bars\Procedure\p_fe8_nn.sql

exec bars.bc.home;
prompt @bars\View\v_zay_salform.sql
set define off
@bars\View\v_zay_salform.sql
show errors view v_zay_salform 

exec bars.bc.home;
prompt @bars\Procedure\p_f3kx_nn.sql
set define off
@bars\Procedure\p_f3kx_nn.sql

exec bars.bc.home;
prompt @bars\Package\rep_inflation_court.sql
set define off
@bars\Package\rep_inflation_court.sql
show err

exec bars.bc.home;
prompt @bars\Procedure\p_f3kx_nn.sql
set define off
@bars\Procedure\p_f3kx_nn.sql

prompt @bars\Script\modify_MBM_REL_CUSTOMERS.sql
@bars\Script\modify_MBM_REL_CUSTOMERS.sql


exec bars.bc.home;
prompt @bars\Script\modify_CITY_CODE.sql
@bars\Script\modify_CITY_CODE.sql

grant select, insert, update, delete, alter, debug on FM_POSS to start1;

prompt...
prompt ...
prompt ... loading params
prompt ...
@params.sql
whenever sqlerror exit
prompt ...
prompt ... connecting as sys
prompt ...
conn sys@&&dbname/&&sys_pass as sysdba
whenever sqlerror continue



prompt ... 
prompt ... compaling schemas
prompt ... 

prompt  >> schema BARS

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('BARS');
prompt  >> schema BARSUPL

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('BARSUPL');
prompt  >> schema BARS_DM

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('BARS_DM');
prompt  >> schema DM

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('DM');
prompt  >> schema MGW_AGENT

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('MGW_AGENT');
prompt  >> schema PFU

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('PFU');
prompt  >> schema SBON

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('SBON');

prompt  >> schema BARSTRANS

EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('BARSTRANS');

prompt  >> schema BARS_INTGR
EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('BARS_INTGR');

prompt  >> schema MSP
EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('MSP');

prompt  >> schema CDB
EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('CDB');

prompt  >> schema  IBMESB
EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('IBMESB');

prompt  >> schema  IBMESB
EXECUTE sys.UTL_RECOMP.RECOMP_SERIAL('NBU_GATEWAY');



prompt ... 
prompt ... invalid objects after install
prompt ... 

prompt ...
prompt ... calculating checksum for bars objects after install
prompt ...

exec bars.bars_release_mgr.install_end('&&release_name');

select owner, object_name, object_type 
from all_objects a where a.status = 'INVALID' and a.owner in ('BARS','BARSUPL','BARS_DM','DM','MGW_AGENT','PFU','SBON','SYS','BARSTRANS','BARS_INGR','MSP', 'CDB', 'IBMESB', 'NBU_GATEWAY')
order by owner, object_type;

prompt ...
prompt ... errors for invalid objects
prompt ...

set line 10000
set trimspool on
set pagesize 10000

prompt ...
prompt ... errors for invalid objects
prompt ...

select owner, type,  name , line, position, text, sequence
from all_errors
order by  owner, type, name;


spool off
quit
