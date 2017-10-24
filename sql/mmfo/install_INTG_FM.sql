set verify off
set echo off
set serveroutput on size 1000000
spool log\install.log
set lines 3000

prompt ..........................................
prompt ...
prompt ... Install module FINMON    
prompt ...
prompt ..........................................


prompt ..........................................
prompt ...
prompt ... Loading params
prompt ...
prompt ..........................................

@params.sql

prompt ..........................................
prompt ...
prompt ... Conecting as SYS to database &&dbname
prompt ...
prompt ..........................................
WHENEVER SQLERROR EXIT
conn sys@&&dbname/&&sys_pass as sysdba
WHENEVER SQLERROR CONTINUE

prompt -- ======================================================
prompt -- Create User
prompt -- ======================================================
@Sql\Sys\User\finmon_01.sql

prompt -- ======================================================
prompt -- Grant
prompt -- ======================================================
@Sql\Sys\Grant\grant_bars_to_finmon.sql

disconnect;
prompt -- ===========================================
prompt -- Execution SYS user is completed.
prompt -- ===========================================

prompt ..........................................
prompt ...
prompt ... Conecting as BARS to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn bars/&&bars_pass@&&dbname
WHENEVER SQLERROR CONTINUE

prompt -- ======================================================
prompt -- Tables
prompt -- ======================================================
@Sql\Bars\Table\finmon_region_match.sql
@Sql\Bars\Table\finmon_doc_match.sql
@Sql\Bars\Table\FINMON_REFT_INPERR.sql
@Sql\Bars\Table\finmon_pep_customers.sql
@Sql\Bars\Table\finmon_pep_rels.sql
@Sql\Bars\Table\fm_category.sql
@Sql\Bars\Table\fm_klient.sql
@Sql\Bars\Table\fm_worker.sql
@Sql\Bars\Table\t_FINMON_PUBLIC_CUSTOMERS.sql
@Sql\Bars\Table\t_FINMON_PUBLIC_RELS.sql

prompt -- ======================================================
prompt -- Sequences
prompt -- ======================================================
--@Sql\Bars\Sequence\

prompt -- ======================================================
prompt -- Views
prompt -- ======================================================
@Sql\Bars\View\BARS_V_FM_FINMON_QUE.sql
@Sql\Bars\View\V_CUST_R.sql
@Sql\Bars\View\v_customer_rizik.sql
@Sql\Bars\View\V_CUSTW_R.sql
@Sql\Bars\View\V_FINMON_PUBLIC_RELS.sql
@Sql\Bars\View\v_fm_finmon_que.sql
@Sql\Bars\View\v_fm_klent.sql
@Sql\Bars\View\v_fm_osc_rule1.sql
@Sql\Bars\View\v_fm_osc_rule2.sql
@Sql\Bars\View\v_fm_osc_rule3.sql
@Sql\Bars\View\v_fm_osc_rule4.sql
@Sql\Bars\View\v_fm_osc_rule5.sql
@Sql\Bars\View\v_fm_osc_rule6.sql
@Sql\Bars\View\v_fm_osc_rule7.sql
@Sql\Bars\View\v_fm_osc_rule8.sql
@Sql\Bars\View\v_fm_osc_rule9.sql
@Sql\Bars\View\v_fm_osc_rule10.sql
@Sql\Bars\View\v_fm_osc_rule11.sql
@Sql\Bars\View\v_fm_osc_rule12.sql
@Sql\Bars\View\v_fm_osc_rule13.sql
@Sql\Bars\View\v_fm_osc_rule14.sql
@Sql\Bars\View\v_fm_osc_rule15.sql
@Sql\Bars\View\v_fm_osc_rule16.sql
@Sql\Bars\View\v_fm_osc_rule17.sql
@Sql\Bars\View\v_fm_osc_rule18.sql
@Sql\Bars\View\v_fm_osc_rule19.sql
@Sql\Bars\View\v_fm_osc_rule20.sql
@Sql\Bars\View\v_fm_osc_rule21.sql
@Sql\Bars\View\v_fm_osc_rule22.sql
@Sql\Bars\View\v_fm_osc_rule23.sql
@Sql\Bars\View\v_customer_rizik.sql

prompt -- ======================================================
prompt -- Synonym
prompt -- ======================================================
--@Sql\Bars\Synonym\

prompt -- ======================================================
prompt -- Context
prompt -- ======================================================
--@Sql\Bars\Context\

prompt -- ======================================================
prompt -- Data
prompt -- ======================================================
@Sql\Bars\Data\data_finmon_doc_match.sql
@Sql\Bars\Data\data_finmon_region_match.sql
@Sql\Bars\Data\bmp_FINMON_PUBLIC_RELS.sql
@Sql\Bars\Data\bmp_FINMON_PUBLIC_CUSTOMERS.sql
@Sql\Bars\Data\operlist_finmon_check_public.sql
@Sql\Bars\Data\operlist_finmon_import_public_figures.sql
@Sql\Bars\Data\operlist_finmon_import_terrorists.sql
@Sql\Bars\Data\operlist_finmon_public_customers.sql
@Sql\Bars\Data\operlist_finmon_terrorists_list.sql
@Sql\Bars\Data\operlist_v_fm_klient.sql
@Sql\Bars\Data\create_menu.sql
@Sql\Bars\Data\create_menu2.sql
@Sql\Bars\Data\add_func_import.sql
@Sql\Bars\Data\_BRS_SBM_REP_LICNLS.sql

prompt -- ======================================================
prompt -- Scripts
prompt -- ======================================================
@Sql\Bars\Script\rename_finmon_to_fimon1.sql
@Sql\Bars\Script\update_finmon_region_match.sql
@Sql\Bars\Script\staff$base_user_finmon.sql
@Sql\Bars\Script\add_func_import.sql
@Sql\Bars\Script\add_risk_criteria_3848.sql
@Sql\Bars\Script\operlist_finmon.sql
@Sql\Bars\Script\rename.sql
@Sql\Bars\Script\GET_FM_POLICIES.sql

prompt -- ======================================================
prompt -- Type
prompt -- ======================================================
@Sql\Bars\Type\T_KASDOC_REC.sql
@Sql\Bars\Type\T_KASDOC_TABLE.sql

set define off
prompt -- ======================================================
prompt -- Triggers
prompt -- ======================================================
@Sql\Bars\Trigger\TAIU_CUSTOMER_EXTERN_UPDATE.sql
prompt -- ======================================================
prompt -- Procedures
prompt -- ======================================================
@Sql\Bars\Procedure\finmon_import_files.sql
@Sql\Bars\Procedure\DELETE_BAD_OPER.sql
@Sql\Bars\Procedure\finmon_check_pep.sql
@Sql\Bars\Procedure\finmon_check_public.sql
@Sql\Bars\Procedure\FM_SET_RIZIK.prc
@Sql\Bars\Procedure\klient_is_reft.prc
@Sql\Bars\Procedure\p_after_edit_client.sql
@Sql\Bars\Procedure\P_COR_RISK.sql
@Sql\Bars\Procedure\p_fm_checkblk.sql
@Sql\Bars\Procedure\p_fm_extdoccheck.prc
@Sql\Bars\Procedure\p_fm_intdoccheck.prc

prompt -- ======================================================
prompt -- Functions
prompt -- ======================================================
@Sql\Bars\Function\finmon_is_public.sql
@Sql\Bars\Function\f_get_cust_hlist.sql
@Sql\Bars\Function\f_istr.sql


prompt -- ======================================================
prompt -- Packages
prompt -- ======================================================
@Sql\Bars\Header\finmon_export.pks
@Sql\Bars\Package\finmon_export.pkb

set define on

prompt -- ======================================================
prompt -- Grant
prompt -- ======================================================
@Sql\Bars\Grant\finmon_grant_bars.sql

prompt -- =======================
prompt -- Rebuilding schema ... 
prompt -- =======================
exec dbms_utility.compile_schema(schema=>user, compile_all=>false);

prompt -- =======================
prompt -- Show INVALID objects ... 
prompt -- =======================

column object_name format a30
column object_type format a30
select object_name,object_type
from user_objects
where status <> 'VALID';

disconnect;
prompt -- ===========================================
prompt -- Execution BARS user is completed.
prompt -- ===========================================

prompt ..........................................
prompt ...
prompt ... Conecting as FINMON to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn finmon/&&finmon_pass@&&dbname
WHENEVER SQLERROR CONTINUE

prompt -- ======================================================
prompt -- Tables FINMON
prompt -- ======================================================
@Sql\FINMON\Table\finmon_table.sql
@Sql\FINMON\Table\finmon_constraint.sql
@Sql\FINMON\Table\finmon_index.sql
@Sql\FINMON\Table\opr_zv.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_decision.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_OPER.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_OPER_METALOOKUP_OPR_OBL_KOD.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_OPER_POPR_NOM.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_OPER_RI_NUMB.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_REQUEST.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_REQUEST_BRANCH.sql
@Sql\FINMON\Table\ALTER_TABLE_FINMON_REQUEST_TEXT.sql
@Sql\FINMON\Table\finmon_oper_alter.sql

prompt -- ======================================================
prompt -- Sequences FINMON
prompt -- ======================================================
@Sql\FINMON\Sequence\finmon_sequence.sql
@Sql\FINMON\Sequence\s_bank_ufile.sql
@Sql\FINMON\Sequence\s_decision_nls.sql
@Sql\FINMON\Sequence\s_file_attach.sql
@Sql\FINMON\Sequence\s_imp_pbank.sql
@Sql\FINMON\Sequence\s_reports.sql

prompt -- ======================================================
prompt -- Views FINMON
prompt -- ======================================================
@Sql\FINMON\View\finmon_view.sql

prompt -- ======================================================
prompt -- Synonym FINMON
prompt -- ======================================================
--@Sql\FINMON\Synonym\

prompt -- ======================================================
prompt -- Context FINMON
prompt -- ======================================================
--@Sql\Bars\Context\

prompt -- ======================================================
prompt -- Data FINMON
prompt -- ======================================================
@Sql\FINMON\Data\data_K_DFM01A.sql
@Sql\FINMON\Data\data_K_DFM01B.sql
@Sql\FINMON\Data\data_K_DFM01C.sql
@Sql\FINMON\Data\data_K_DFM01D.sql
@Sql\FINMON\Data\data_K_DFM01E.sql
@Sql\FINMON\Data\data_K_DFM02.sql
@Sql\FINMON\Data\data_K_DFM03.sql
@Sql\FINMON\Data\data_K_DFM04.sql
@Sql\FINMON\Data\data_K_DFM05.sql
@Sql\FINMON\Data\data_K_DFM06.sql
@Sql\FINMON\Data\data_K_DFM07.sql
@Sql\FINMON\Data\data_K_DFM08.sql
@Sql\FINMON\Data\data_K_DFM09.sql
@Sql\FINMON\Data\data_K_DFM10.sql
@Sql\FINMON\Data\data_K_DFM11.sql
@Sql\FINMON\Data\data_K_DFM12.sql
@Sql\FINMON\Data\data_K_DFM13.sql
@Sql\FINMON\Data\data_K_DFM14.sql
@Sql\FINMON\Data\data_METAAUTOID.sql
@Sql\FINMON\Data\data_METACOLS.sql
@Sql\FINMON\Data\data_METALOOKUP.sql
@Sql\FINMON\Data\data_METASORT.sql
@Sql\FINMON\Data\data_REPORTS.sql
@Sql\FINMON\Data\data_STATUS_FILE.sql
@Sql\FINMON\Data\data_STATUS_RECORD.sql
@Sql\FINMON\Data\data_ZAPROS_DEFAULT_VALUE.sql
@Sql\FINMON\Data\data_branch.sql
@Sql\FINMON\Data\data_user.sql
@Sql\FINMON\Data\BRANCH_SEQUENCE.sql
@Sql\FINMON\Data\SEQUENCE_FILE_PARAMS.sql
@Sql\FINMON\Data\METACOLS_decision.sql
@Sql\FINMON\Data\METACOLS_OPER.sql
@Sql\FINMON\Data\METALOOKUP_oper.sql
@Sql\FINMON\Data\finmon_alter_params.sql

prompt -- ======================================================
prompt -- Scripts FINMON
prompt -- ======================================================
@Sql\FINMON\Script\copy_k_dfm.sql
@Sql\FINMON\Script\upd_k_dfm01a.sql
@Sql\FINMON\Script\upd_k_dfm01b.sql
@Sql\FINMON\Script\upd_k_dfm01c.sql
@Sql\FINMON\Script\upd_k_dfm01d.sql
@Sql\FINMON\Script\upd_k_dfm01e.sql
@Sql\FINMON\Script\upd_k_dfm02.sql
@Sql\FINMON\Script\upd_k_dfm03.sql
@Sql\FINMON\Script\upd_k_dfm04.sql
@Sql\FINMON\Script\upd_k_dfm05.sql
@Sql\FINMON\Script\upd_k_dfm06.sql
@Sql\FINMON\Script\upd_k_dfm07.sql
@Sql\FINMON\Script\upd_k_dfm08.sql
@Sql\FINMON\Script\upd_k_dfm09.sql
@Sql\FINMON\Script\upd_k_dfm10.sql
@Sql\FINMON\Script\upd_k_dfm11.sql
@Sql\FINMON\Script\upd_k_dfm14.sql
@Sql\FINMON\Script\upd_k_dfm15.sql
@Sql\FINMON\Script\upd_k_dfm16.sql
@Sql\FINMON\Script\finmon_SEQUENCE.sql
@Sql\FINMON\Script\finmon_REQUEST_metacol.sql
@Sql\FINMON\Script\finmon_create_user_type.sql
@Sql\FINMON\Script\add_branch_id.sql
@Sql\FINMON\Script\alter_oper_opr_nom.sql
@Sql\FINMON\Script\fm_policies.sql
@Sql\FINMON\Script\set_BANK.sql

prompt -- ======================================================
prompt -- Type FINMON
prompt -- ======================================================
--@Sql\FINMON\Type\

set define off
prompt -- ======================================================
prompt -- Triggers FINMON
prompt -- ======================================================
@Sql\FINMON\Trigger\finmon_trigger.sql
@Sql\FINMON\Trigger\finmon_ti_oper_klid.sql
@Sql\FINMON\Trigger\oper_TIU_HOLD_STATUS_AUTONUM.sql
@Sql\FINMON\Trigger\tbi_decision_nls..sql
@Sql\FINMON\Trigger\tbi_file_attach..sql
@Sql\FINMON\Trigger\tbiud_oper_branch..sql
@Sql\FINMON\Trigger\tbiud_oper_notes_branch..sql
@Sql\FINMON\Trigger\tbiud_person..sql
@Sql\FINMON\Trigger\tbiud_person_oper_branch..sql
@Sql\FINMON\Trigger\tbiud_person_oper_nos_branch..sql
@Sql\FINMON\Trigger\td_bank_ufile_modid..sql
@Sql\FINMON\Trigger\td_oper_modid..sql
@Sql\FINMON\Trigger\ti_oper_klid..sql
@Sql\FINMON\Trigger\ti_reports..sql
@Sql\FINMON\Trigger\tiu_hold_status_autonum..sql
@Sql\FINMON\Trigger\tr_fm_sequence..sql

prompt -- ======================================================
prompt -- Procedures FINMON
prompt -- ======================================================
@Sql\FINMON\Procedure\finmon_procedure.sql
@Sql\FINMON\Procedure\delete_bad_oper.sql
@Sql\FINMON\Procedure\kl_date_verify.sql

prompt -- ======================================================
prompt -- Functions FINMON
prompt -- ======================================================
@Sql\FINMON\Function\finmon_function.sql
@Sql\FINMON\Function\GET_BRANCH_ID.sql
@Sql\FINMON\Function\ISD_BRANCH.sql
@Sql\FINMON\Function\check_string_charset.sql
@Sql\FINMON\Function\f_pol_finmon_person.sql

prompt -- ======================================================
prompt -- Packages FINMON
prompt -- ======================================================
--@Sql\FINMON\Header\
--@Sql\FINMON\Package\

set define on

prompt -- ======================================================
prompt -- Grant FINMON
prompt -- ======================================================
@Sql\FINMON\Grant\finmon_grant.sql
@Sql\FINMON\Table\oper_xpk.sql

prompt -- =======================
prompt -- Rebuilding schema ... 
prompt -- =======================
exec dbms_utility.compile_schema(schema=>user, compile_all=>false);

prompt -- =======================
prompt -- Show INVALID objects ... 
prompt -- =======================

column object_name format a30
column object_type format a30
select object_name,object_type
from user_objects
where status <> 'VALID';

prompt ..........................................
prompt ...
prompt ... Conecting as BARS to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn bars/&&bars_pass@&&dbname
WHENEVER SQLERROR CONTINUE

prompt Sql/Bars/Table/001add_position_r.sql
@Sql/Bars/Table/001add_position_r.sql

prompt Sql/Bars/Data/rename.sql
@Sql/Bars/Data/rename.sql

prompt Sql/Bars/Data/add_cust_field_pep.sql
@Sql/Bars/Data/add_cust_field_pep.sql

prompt Sql/Bars/Data/err_cac.sql
@Sql/Bars/Data/err_cac.sql

prompt Sql/Bars/Table/FINMON_PEP_CUSTOMERS.sql
@Sql/Bars/Table/FINMON_PEP_CUSTOMERS.sql

PROMPT Sql/Bars/Table/FINMON_PEP_RELS.sql
@Sql/Bars/Table/FINMON_PEP_RELS.sql

PROMPT Sql/Bars/Table/FM_PEP.sql
@Sql/Bars/Table/FM_PEP.sql

PROMPT Sql/Bars/Data/add_func.sql
@Sql/Bars/Data/add_func.sql

PROMPT Sql/Bars/Data/fill_fm_pep.sql
@Sql/Bars/Data/fill_fm_pep.sql

PROMPT Sql/Bars/Procedure/finmon_check_pep.sql
@Sql/Bars/Procedure/finmon_check_pep.sql

PROMPT Sql/Bars/Procedure/finmon_import_pep.prc
@Sql/Bars/Procedure/finmon_import_pep.prc

PROMPT Sql/Bars/Data/FINMON_PEP_CUSTOMERS.sql
@Sql/Bars/Data/FINMON_PEP_CUSTOMERS.sql

PROMPT Sql/Bars/Data/FINMON_PEP_RELS.sql
@Sql/Bars/Data/FINMON_PEP_RELS.sql

PROMPT Sql/Bars/Data/FM_PEP.sql
@Sql/Bars/Data/FM_PEP.sql

PROMPT Sql/Bars/Procedure/P_AFTER_EDIT_CLIENT.prc
@Sql/Bars/Procedure/P_AFTER_EDIT_CLIENT.prc

PROMPT Sql/Bars/Function/FINMON_IS_PUBLIC.sql
@Sql/Bars/Function/FINMON_IS_PUBLIC.sql

PROMPT Sql/Bars/View/v_finmon_que_oper.sql
@Sql/Bars/View/v_finmon_que_oper.sql

PROMPT Sql/Bars/View/V_CUST_RELATION_DATA.sql
@Sql/Bars/View/V_CUST_RELATION_DATA.sql

PROMPT Sql/Bars/Procedure/p_back_dok.prc
@Sql/Bars/Procedure/p_back_dok.prc

PROMPT Sql/Bars/Data/kas997.sql
@Sql/Bars/Data/kas997.sql

PROMPT Sql/Bars/Scripts/r_recompile.sql
@Sql/Bars/Scripts/r_recompile.sql

prompt -- =======================
prompt -- Rebuilding schema ... 
prompt -- =======================
exec dbms_utility.compile_schema(schema=>user, compile_all=>false);

prompt -- =======================
prompt -- Show INVALID objects ... 
prompt -- =======================

column object_name format a30
column object_type format a30
select object_name,object_type
from user_objects
where status <> 'VALID';

disconnect;
prompt -- ===========================================
prompt -- Execution BARS user is completed.
prompt -- ===========================================

prompt ..........................................
prompt ...
prompt ... Conecting as FINMON to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn finmon/&&finmon_pass@&&dbname
WHENEVER SQLERROR CONTINUE

PROMPT Sql/FINMON/Data/validate_opr_vid2.sql
@Sql/FINMON/Data/validate_opr_vid2.sql
PROMPT Sql/FINMON/Table/DICT_TABLES.sql
@Sql/FINMON/Table/DICT_TABLES.sql
PROMPT Sql/FINMON/Table/K_DFM_COPY.sql
@Sql/FINMON/Table/K_DFM_COPY.sql
PROMPT Sql/FINMON/Table/DICT_TABLES.sql
@Sql/FINMON/Table/DICT_TABLES.sql
PROMPT Sql/FINMON/Table/CREATE_INDEX.sql
@Sql/FINMON/Table/CREATE_INDEX.sql
PROMPT Sql/FINMON/Table/CONSTRAINTS.sql
@Sql/FINMON/Table/CONSTRAINTS.sql
PROMPT Sql/FINMON/Trigger/CREATE_TRIGGER.sql
@Sql/FINMON/Trigger/CREATE_TRIGGER.sql
PROMPT Sql/FINMON/Grant/GRANTS.sql
@Sql/FINMON/Grant/GRANTS.sql
PROMPT Sql/FINMON/Table/COMMENTS.sql
@Sql/FINMON/Table/COMMENTS.sql

prompt Sql/FINMON/Table/finmon_upd_dictDFM.sql
@Sql/FINMON/Table/finmon_upd_dictDFM.sql
prompt Sql/FINMON/Table/clear_dict.sql
@Sql/FINMON/Table/clear_dict.sql
prompt Sql/FINMON/Table/DICT_K_DFM01D.sql
@Sql/FINMON/Table/DICT_K_DFM01D.sql
prompt Sql/FINMON/Table/DICT_K_DFM01E.sql
@Sql/FINMON/Table/DICT_K_DFM01E.sql
prompt Sql/FINMON/Table/DICT_K_DFM02.sql
@Sql/FINMON/Table/DICT_K_DFM02.sql
prompt Sql/FINMON/Table/DICT_K_DFM03.sql
@Sql/FINMON/Table/DICT_K_DFM03.sql
prompt Sql/FINMON/Table/DICT_K_DFM05.sql
@Sql/FINMON/Table/DICT_K_DFM05.sql
prompt Sql/FINMON/Table/DICT_K_DFM07.sql
@Sql/FINMON/Table/DICT_K_DFM07.sql
prompt Sql/FINMON/Table/DICT_K_DFM09.sql
@Sql/FINMON/Table/DICT_K_DFM09.sql
prompt Sql/FINMON/Table/DICT_K_DFM10.sql
@Sql/FINMON/Table/DICT_K_DFM10.sql
prompt Sql/FINMON/Table/DICT_K_DFM16.sql
@Sql/FINMON/Table/DICT_K_DFM16.sql
prompt Sql/FINMON/Table/merge_dicts.sql
@Sql/FINMON/Table/merge_dicts.sql

prompt -- =======================
prompt -- Rebuilding schema ... 
prompt -- =======================
exec dbms_utility.compile_schema(schema=>user, compile_all=>false);

prompt -- =======================
prompt -- Show INVALID objects ... 
prompt -- =======================

column object_name format a30
column object_type format a30
select object_name,object_type
from user_objects
where status <> 'VALID';

prompt ..........................................
prompt ...
prompt ... Conecting as BARS to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn bars/&&bars_pass@&&dbname
WHENEVER SQLERROR CONTINUE

prompt Sql/Bars/Data/bars_upd_dictDFM.sql
@Sql/Bars/Data/bars_upd_dictDFM.sql
prompt Sql/Bars/Data/merge_dicts_bars.sql
@Sql/Bars/Data/merge_dicts_bars.sql
PROMPT Sql/Bars/Procedure/p_back_dok.sql
@Sql/Bars/Procedure/p_back_dok.sql
prompt Bars/Data/rep_brs_sbm_997.sql
@Bars/Data/rep_brs_sbm_997.sql
prompt Bars/Data/rep_brs_sbm_998.sql
@Bars/Data/rep_brs_sbm_998.sql
PROMPT Sql/Bars/Table/finmon_que_default.sql
@Sql/Bars/Table/finmon_que_default.sql
PROMPT Sql/Bars/Table/CBIREP_QUERIES_FK_DISABLE.sql
@Sql/Bars/Table/CBIREP_QUERIES_FK_DISABLE.sql
prompt Bars/Data/v_cust_r_meta_chgdate.sql
@Bars/Data/v_cust_r_meta_chgdate.sql
prompt Bars/View/v_fm_func_kontr.sql
@Bars/View/v_fm_func_kontr.sql
prompt Bars/View/v_fm_func_oper.sql
@Bars/View/v_fm_func_oper.sql
prompt Bars/View/v_finmon_que_oper.sql
@Bars/View/v_finmon_que_oper.sql
prompt Bars/Data/V_FINMON_QUE_OPER_meta.sql
@Bars/Data/V_FINMON_QUE_OPER_meta.sql
PROMPT Sql/Bars/Procedure/p_back_dok.sql
@Sql/Bars/Procedure/p_back_dok.sql
PROMPT Sql/Bars/Trigger/TBIU_FINMON_REFT_AKALIST_HASH.sql
@Sql/Bars/Trigger/TBIU_FINMON_REFT_AKALIST_HASH.sql

PROMPT Sql/Bars/Data/_BRS_SBM_REP_LICNLS.sql
@Sql/Bars/Data/_BRS_SBM_REP_LICNLS.sql
PROMPT Sql/Bars/Procedure/rptlic_nls.sql
@Sql/Bars/Procedure/rptlic_nls.sql
PROMPT Sql/Bars/View/V_RPTLIC2.sql
@Sql/Bars/View/V_RPTLIC2.sql
PROMPT Sql/Bars/Function/f_escape.sql
@Sql/Bars/Function/f_escape.sql

PROMPT COBUSUPABS-4920
PROMPT Sql/Bars/Table/fm_klient.sql
@Sql/Bars/Table/fm_klient.sql
PROMPT Sql/Bars/View/v_fm_klient.sql
@Sql/Bars/View/v_fm_klient.sql
PROMPT Sql/Bars/Procedure/klient_is_reft.sql
@Sql/Bars/Procedure/klient_is_reft.sql
PROMPT Sql/Bars/Data/V_FM_KLIENT_meta.sql
@Sql/Bars/Data/V_FM_KLIENT_meta.sql

PROMPT COBUSUPABS-5017
PROMPT Sql/Bars/Data/risk_criteria_72.sql
@Sql/Bars/Data/risk_criteria_72.sql
PROMPT Sql/Bars/Data/risk_filter_rizik_4.sql
@Sql/Bars/Data/risk_filter_rizik_4.sql

PROMPT COBUSUPABS-4805
PROMPT Sql/Bars/Data/fm_risk_criteria_data_upd.sql
@Sql/Bars/Data/fm_risk_criteria_data_upd.sql
PROMPT Sql/Bars/Function/f_get_cust_hlist.sql
@Sql/Bars/Function/f_get_cust_hlist.sql

PROMPT COBUSUPABS-4830
PROMPT Sql/Bars/Data/cust_post_kontr_upd.sql
@Sql/Bars/Data/cust_post_kontr_upd.sql

PROMPT COBUSUPABS-5168
PROMPT Sql/Bars/Data/fm_rule30.sql
@Sql/Bars/Data/fm_rule30.sql
PROMPT Sql/Bars/View/V_FM_OSC_RULE30.sql
@Sql/Bars/View/V_FM_OSC_RULE30.sql

PROMPT Sql/Bars/Procedure/p_set_rizik.sql
@Sql/Bars/Procedure/p_set_rizik.sql

PROMPT COBUSUPABS-4207
prompt @Table\FM_STABLE_PARTNER_TMP.sql
@Sql\Bars\Table\FM_STABLE_PARTNER_TMP.sql

prompt @Table\FM_STABLE_PARTNER_ARC.sql
@Sql\Bars\Table\FM_STABLE_PARTNER_ARC.sql

prompt @Function\concat_rnk.sql
@Sql\Bars\Function\concat_rnk.sql

prompt @Procedure\p_fm_getpartner.sql
@Sql\Bars\Procedure\p_fm_getpartner.sql


prompt ..........................................
prompt ...
prompt ... Conecting as FINMON to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn finmon/&&finmon_pass@&&dbname
WHENEVER SQLERROR CONTINUE

PROMPT Sql/FINMON/Script/decision_oper_reference.sql
@Sql/FINMON/Script/decision_oper_reference.sql
PROMPT Sql/FINMON/Table/oper_new_oper_nom.sql
@Sql/FINMON/Table/oper_new_oper_nom.sql
PROMPT Sql/FINMON/Trigger/TI_OPER_NEWOPRNOM.sql
@Sql/FINMON/Trigger/TI_OPER_NEWOPRNOM.sql
PROMPT Sql/FINMON/Trigger/td_oper_modid..sql
@Sql/FINMON/Trigger/td_oper_modid..sql


prompt ..........................................
prompt ...
prompt ... Conecting as BARS to database &&dbname
prompt ...
prompt ..........................................

WHENEVER SQLERROR EXIT
conn bars/&&bars_pass@&&dbname
WHENEVER SQLERROR CONTINUE

@Sql\Bars\Data\func_rizik_cnt_rename.sql
@Sql\Bars\Procedure\p_bulk_set_rizik.sql
@Sql\Bars\Data\nsi_bulk_rizik.sql

prompt -- ===========================================
prompt -- Execution is completed.
prompt -- Check log file for error.
prompt -- ===========================================

spool off

quit