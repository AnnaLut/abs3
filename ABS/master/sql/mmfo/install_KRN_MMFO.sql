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
prompt  dbname       = &&dbname
prompt  sys_pass     = &&sys_pass
prompt  bars_pass    = &&bars_pass
prompt  bars_def_tbs = &&bars_def_tbs
prompt  bars_tmp_tbs = &&bars_tmp_tbs


conn sys@&&dbname/&&sys_pass as sysdba
whenever sqlerror continue



@Sql\Sys\create_bars_user.sql  &&bars_def_tbs  &&bars_tmp_tbs



conn bars@&&dbname/&&bars_pass
whenever sqlerror continue


prompt ...
prompt ... отключение политик и тригерра на создание таблицы (если таковые имелись)
prompt ...
@Sql\Bars\Script\disable_ddl_crtab_trigger.sql
@Sql\Bars\Script\remove_all_policies.sql


prompt ...
prompt ... Роли
prompt ...

@Sql\Bars\Role\bars_access_defrole.sql



prompt ...
prompt ... Общие типы
prompt ...
@Sql\Bars\Type\number_list.sql
@Sql\Bars\Type\string_list.sql
@Sql\Bars\Type\date_list.sql
@Sql\Bars\Type\blob_list.sql
@Sql\Bars\Type\clob_list.sql
@Sql\Bars\Type\varchar2_list.sql
@Sql\Bars\Type\t_str_array.sql
@Sql\Bars\Type\t_dyn_filter_cond_line.sql
@Sql\Bars\Type\t_dyn_filter_cond_list.sql

prompt ...
prompt ... Розгортання допоміжних утиліт
prompt ...
@Sql\Bars\Header\tools.pks
@Sql\Bars\Package\tools.pkb
@Sql\Bars\Header\ddl_utl.pks
@Sql\Bars\Package\ddl_utl.pkb



prompt ...
prompt ... Аудит системы
prompt ...

@Sql\Bars\Table\sec_action.sql
@Sql\Bars\Table\sec_alarmque.sql
@Sql\Bars\Table\sec_rectype.sql
@Sql\Bars\Table\sec_logins.sql
@Sql\Bars\Table\sec_useraudit.sql
@Sql\Bars\Table\sec_audit.sql
@Sql\Bars\Trigger\tbi_seclogins.sql
@Sql\Bars\Trigger\tiu_sec_useraudit.sql
@Sql\Bars\Sequence\s_secaudit.sql
@Sql\Bars\Package\bars_audit.pkb
@Sql\Bars\Header\bars_audit.pks
@Sql\Bars\Package\bars_audit_adm.pkb
@Sql\Bars\Header\bars_audit_adm.pks
@Sql\Bars\View\v_sec_audit_ui.sql
@Sql\Bars\Data\dyn_filter_v_sec_audit.sql 

prompt ...
prompt ... Парамеры системы + бранчи
prompt ...

@Sql\Bars\Sequence\s_branch.sql
@Sql\Bars\Table\branch_tip.sql
@Sql\Bars\Table\branch.sql
@Sql\Bars\Data\branch_tip.sql
@Sql\Bars\Error\err_branch.sql
@Sql\Bars\Header\branch_utl.pks
@Sql\Bars\Package\branch_utl.pkb

@Sql\Bars\Script\rename_old_parameters.sql
@Sql\Bars\Table\branch_attribute_groups.sql
@Sql\Bars\Table\branch_attributes.sql
@Sql\Bars\Table\branch_attribute_values.sql
@Sql\Bars\View\v_branch_attributes.sql
@Sql\Bars\View\v_branch_attribute_values.sql
@Sql\Bars\Error\err_branch.sql
@Sql\Bars\Header\branch_attribute_utl.pks
@Sql\Bars\Package\branch_attribute_utl.pkb
-- для совместимости со старым кодом
@Sql\Bars\View\v_depricated_params$global.sql
@Sql\Bars\View\v_depricated_params$base.sql
@Sql\Bars\View\v_depricated_params.sql
@Sql\Bars\View\v_depricated_branch_parameters.sql
@Sql\Bars\View\v_depricated_branch_tags.sql
@Sql\Bars\Header\depricated_branch_usr.pks
@Sql\Bars\Package\depricated_branch_usr.pkb
@Sql\Bars\Header\depricated_branch_edit.pks
@Sql\Bars\Package\depricated_branch_edit.pkb

@Sql\Bars\Synonym\branch_tags.sql
@Sql\Bars\Synonym\branch_parameters.sql
@Sql\Bars\Synonym\params$global.sql
@Sql\Bars\Synonym\params$base.sql
@Sql\Bars\Synonym\branch_adm.sql
@Sql\Bars\Synonym\branch_usr.sql
@Sql\Bars\Synonym\branch_edit.sql



prompt ........
prompt ... Общего назначения часть1
prompt ...
@Sql\Bars\Table\table_alias.sql
@Sql\Bars\Table\table_col_alias.sql

prompt ...
prompt ... Система пользовательских ошибок
prompt ...


@Sql\Bars\Table\err_langs.sql
@Sql\Bars\Table\err_codes.sql
@Sql\Bars\Table\err_modules.sql
@Sql\Bars\Table\err_texts.sql
@Sql\Bars\Table\s_er.sql
@Sql\Bars\Header\bars_error.pks
@Sql\Bars\Package\bars_error.pkb


prompt ...
prompt ... Политики доступа (oracle row level security )
prompt ...

@Sql\Bars\Table\policy_types.sql
@Sql\Bars\Table\policy_groups.sql
@Sql\Bars\Table\policy_mnemonics.sql
@Sql\Bars\Table\policy_responsible.sql
@Sql\Bars\Table\policy_exclude_tables.sql
@Sql\Bars\Table\policy_table_lt.sql
@Sql\Bars\View\policy_table_base.sql
@Sql\Bars\View\policy_table.sql
@Sql\Bars\Table\tmp_policy_errors.sql
@Sql\Bars\Trigger\tddl_crtab.sql
@Sql\Bars\Procedure\wm$tbiu_policytable_io.sql
@Sql\Bars\Procedure\wm$taiu_policy_table.sql
@Sql\Bars\Trigger\lt_ad_34.sql
@Sql\Bars\Trigger\lt_au_35.sql
@Sql\Bars\Trigger\ovm_insert_33.sql
@Sql\Bars\Trigger\ovm_update_33.sql
@Sql\Bars\Trigger\ovm_delete_33.sql
@Sql\Bars\Header\bars_policy.pks
@Sql\Bars\Header\bars_policy_adm.pks
@Sql\Bars\Package\bars_policy.pkb
@Sql\Bars\Package\bars_policy_adm.pkb
@Sql\Bars\Synonym\bpa.sql



prompt ........
prompt ... Общего назначения 2
prompt ...

@Sql\Bars\Context\bars_pool.sql
@Sql\Bars\Header\bars_pool.pks
@Sql\Bars\Package\bars_pool.pkb
@Sql\Bars\Table\roles$base.sql
@Sql\Bars\Table\table_alias.sql
@Sql\Bars\Table\table_col_alias.sql
@Sql\Bars\Table\imp_file.sql
@Sql\Bars\Table\frontend.sql
@Sql\Bars\Function\getglobaloption.sql




prompt ...
prompt ... Універсальні списки
prompt ...
@Sql\Bars\Table\list_tables.sql
@Sql\Bars\Header\list_utl.pks
@Sql\Bars\Package\list_utl.pkb


prompt ...
prompt ... Механізм об''єктів АБС
prompt ...
@Sql\Bars\Table\object_tables.sql
@Sql\Bars\Header\object_utl.pks
@Sql\Bars\Package\object_utl.pkb
@Sql\Bars\Header\attribute_utl.pks
@Sql\Bars\Package\attribute_utl.pkb
@Sql\Bars\Data\fill_attributes.sql




prompt ...
prompt ... управління користувачами АБС
prompt ...
@Sql\Bars\Table\staff_tables.sql
@Sql\Bars\Header\user_utl.pks
@Sql\Bars\Package\user_utl.pkb
@Sql\Bars\Header\user_login.pks
@Sql\Bars\Package\user_login.pkb
@Sql\Bars\Synonym\bars_login.sql
@Sql\Bars\View\v_staff_user.sql
@Sql\Bars\Context\bars_global.sql
@Sql\Bars\Context\bars_local.sql
@Sql\Bars\Data\staff_user.sql





prompt ...
prompt ... Асинхронное выполнение (async execution functional)
prompt ...


@Sql\Bars\Sequence\s_async.sql
@Sql\Bars\Table\async_exclusion_mode_type.sql
@Sql\Bars\Table\async_param_type.sql
@Sql\Bars\Table\async_param.sql
@Sql\Bars\Table\async_sql.sql
@Sql\Bars\Table\async_sql_param.sql
@Sql\Bars\Table\async_webui.sql
@Sql\Bars\Table\async_action_type.sql
@Sql\Bars\Table\async_action.sql
@Sql\Bars\Table\async_run_obj_type.sql
@Sql\Bars\Table\async_run_state_type.sql
@Sql\Bars\Table\async_run_object.sql
@Sql\Bars\Table\async_run.sql
@Sql\Bars\Table\async_run_param_val.sql
@Sql\Bars\Header\bars_async_adm.pks
@Sql\Bars\Package\bars_async_adm.pkb
@Sql\Bars\Header\bars_async.pks
@Sql\Bars\Package\bars_async.pkb
@Sql\Bars\View\v_async_action_param.sql
@Sql\Bars\grant\async_grants.sql
@Sql\Bars\Error\err_async.sql
@Sql\Bars\Data\async_bars_reps.sql
@Sql\Bars\Data\async_nbu_reps.sql
@Sql\Bars\Data\async_reserve_nbu23.sql
@Sql\Bars\Data\async_refdata.sql

/*
prompt ...
prompt ... Ресурсы - функции
prompt ...

@Sql\Bars\Table\operlist.sql
@Sql\Bars\Table\operlist_acspub.sql
@Sql\Bars\Table\operlist_schedule_members.sql
@Sql\Bars\Sequence\s_operlist_schedule_members.sql
@Sql\Bars\Trigger\tbi_operlist_shedules.sql
@Sql\Bars\Table\operlist_shedule_groups.sql
@Sql\Bars\Trigger\tbi_operlist_shedule_groups.sql
@Sql\Bars\Sequence\s_operlist_shedule_groups.sql
@Sql\Scripts\drop_list_funcset.sql
*/



prompt ...
prompt ... База метаданных (metabase)
prompt ...
@Sql\Bars\Sequence\s_meta_dependency_cols.sql
@Sql\Bars\Table\meta_dep_actiontype.sql
@Sql\Bars\Table\meta_dep_event.sql
@Sql\Bars\Table\meta_dependency_cols.sql
@Sql\Bars\Data\fill_meta_dep_actiontype.sql
@Sql\Bars\Data\fill_meta_dep_event.sql
@Sql\Bars\Table\meta_actioncodes.sql
@Sql\Bars\Table\meta_icons.sql
@Sql\Bars\Table\meta_access_codes.sql
@Sql\Bars\Table\meta_month.sql
@Sql\Bars\Table\meta_reltypes.sql
@Sql\Bars\Table\meta_tables.sql
@Sql\Bars\Table\meta_coltypes.sql
@Sql\Bars\Table\meta_regentry.sql
@Sql\Bars\Table\meta_taccess.sql
@Sql\Bars\Table\meta_filtercodes.sql
@Sql\Bars\Table\meta_actiontbl.sql
@Sql\Bars\Table\meta_columns.sql
@Sql\Bars\Table\meta_browsetbl.sql
@Sql\Bars\Table\meta_extrnval.sql
@Sql\Bars\Table\meta_filtertbl.sql
@Sql\Bars\Table\meta_sortorder.sql
@Sql\Bars\Table\meta_spltbl.sql
@Sql\Bars\Table\meta_tblcolor.sql
@Sql\Bars\Table\meta_nsifunction.sql
@Sql\Bars\Table\meta_mandatory_flags.sql
@Sql\Bars\Table\meta_mandatory_flags.sql
@Sql\Bars\Table\meta_col_intl_filters.sql
@Sql\Bars\View\v_meta_tables.sql
@Sql\Bars\Sequence\s_meta_col_intl_filters.sql
@Sql\Bars\Sequence\s_metatables.sql
@Sql\Bars\Header\bars_metabase.pks
@Sql\Bars\Package\bars_metabase.pkb
@Sql\Bars\Error\err_bmd.sql
@Sql\Bars\Trigger\tbi_meta_col_intl_filters.sql


prompt ........
prompt ... Справочники
prompt ...
@Sql\Bars\Table\reference_types.sql
@Sql\Bars\Data\insert_reftypes.sql
@Sql\Bars\Table\reference_filters.sql
@Sql\Bars\Table\references.sql
@Sql\Bars\Sequence\s_reference_filters.sql
@Sql\Bars\Trigger\tbi_reference_filters.sql

prompt ........
prompt ... Шаблоны договоров
prompt ...
@Sql\Bars\Table\doc_attr.sql
@Sql\Bars\Table\doc_scheme.sql


prompt ........
prompt ... Уведомления(BMS)
prompt ...

@Sql\Bars\Sequence\bms_message_seq.sql
@Sql\Bars\Table\bms_message_type.sql
@Sql\Bars\Table\bms_message.sql
@Sql\Bars\Header\bms.pks
@Sql\Bars\Package\bms.pkb

prompt ........
prompt ... Лицензия
prompt ...

@Sql\Bars\View\v_staff_lic.sql
set define off
@Sql\Bars\Header\bars_lic.pks
@Sql\Bars\Package\bars_lic.pkb
set define on

prompt ........
prompt ... Веб сервисы
prompt ...
@Sql\Bars\Header\wsm_mgr.pks
@Sql\Bars\Package\wsm_mgr.pkb

prompt ........
prompt ... Отчетность
prompt ...
@Sql\Bars\Table\cbirep_queries.sql
@Sql\Bars\Table\CBIREP_QUERIES_DATA.SQL
@Sql\Bars\Table\cbirep_query_statuses.sql
@Sql\Bars\Data\cbirep_query_statuses.sql
@Sql\Bars\Table\cbirep_query_statuses_history.sql
@Sql\Bars\Table\RS_TMP_REPORT_ATTR.SQL
@Sql\Bars\Table\rs_tmp_report_data.SQL
@Sql\Bars\Table\rs_tmp_session_data.SQL
@Sql\Bars\Table\zapros_attr.sql
@Sql\Bars\Data\zapros_attr.sql
@Sql\Bars\Synonym\REFAPP.sql
@Sql\Bars\Synonym\REPORTS.sql
@Sql\Bars\Synonym\REPORTSF.sql
@Sql\Bars\Table\REFAPP.sql
@Sql\Bars\Table\rep_types.sql
@Sql\Bars\Table\report_forms.sql
@Sql\Bars\Table\REPORTS.sql
@Sql\Bars\Table\REPORTSF.sql
@Sql\Bars\Table\zapros.sql
@Sql\Bars\Table\zapros_fmt.sql
@Sql\Bars\Table\zapros_users.sql
@Sql\Bars\Table\task_method.sql
@Sql\Bars\Table\task_list.sql
@Sql\Bars\Table\task_staff.sql
@Sql\Bars\View\V_RS_TMP_REP_DATA_PART.SQL
@Sql\Bars\View\V_CBIREP_QUERIES_DATA.SQL
@Sql\Bars\Trigger\ti_rs_tmp_report_data.sql
@Sql\Bars\Trigger\TBI_REPORTS.sql
@Sql\Bars\Trigger\TBI_ZAPROS.sql
@Sql\Bars\Trigger\tbiu_reports_param.sql
@Sql\Bars\Trigger\TBU_REFAPP.sql
@Sql\Bars\Trigger\TIU_ZAPROS_LAST_UPDATED.sql
@Sql\Bars\DBMS Scheduler\job\CBIREP_CLEAN_RS_PART.sql
@Sql\Bars\Header\rs.pks
@Sql\Bars\Package\rs.pkb
@Sql\Bars\Header\bars_report.pks
@Sql\Bars\Package\bars_report.pkb

prompt ........
prompt ... Управление текстами сообщений
prompt ...

@Sql\Bars\Table\MSG_CODES.sql
@Sql\Bars\Table\MSG_TEXTS.sql
@Sql\Bars\Header\bars_msg.pks
@Sql\Bars\Package\bars_msg.pkb
@Sql\Bars\Sequence\s_msgcodes.sql
@Sql\Bars\Synonym\BARS_MSG.sql
@Sql\Bars\Synonym\MSG_CODES.sql
@Sql\Bars\Synonym\MSG_TEXTS.sql
@Sql\Bars\Data\msg_codes.sql
@Sql\Bars\Grant\BARS_MSG_TO_START1.sql

prompt ........
prompt ... Смс информирование
prompt ...

@Sql\Bars\Table\msg_submit_data.sql
@Sql\Bars\Table\sms_query_data.sql
@Sql\Bars\Type Body\sms_provider_smpp.sql
@Sql\Bars\Type\sms_provider.sql
@Sql\Bars\Type\sms_provider_smpp.sql
@Sql\Bars\Function\f_translate_kmu.sql
@Sql\Bars\Sequence\s_msgid.sql
@Sql\Bars\Header\bars_sms.pks
@Sql\Bars\Header\bars_sms_smpp.pks
@Sql\Bars\Package\bars_sms.pkb
@Sql\Bars\Package\bars_sms_smpp.pkb



prompt ........
prompt ... Механізм запуску функцій фінішу\старту\регламентних банківського дня
prompt ...
@Sql\Bars\Table\tms_task_groups.sql
@Sql\Bars\Table\tms_list_tasks.sql
@Sql\Bars\Table\tms_task_default_params.sql
@Sql\Bars\Table\tms_group_log.sql
@Sql\Bars\Table\tms_task_log.sql

@Sql\Bars\Sequence\tms_seq.sql

@Sql\Bars\Data\tms_task_groups_data.sql

@Sql\Bars\Type\t_task_list_info.sql
@Sql\Bars\Type\tms_tab_list_info.sql

@Sql\Bars\Header\tms_utl.pks
@Sql\Bars\Package\tms_utl.pkb

@Sql\Bars\Procedure\tms_job_notification.sql

@Sql\Bars\Data\APPLIST_TMS.SQL


prompt ........
prompt ... Отчеты
prompt ...
@Sql\Bars\Data\_BRS_SBR_ADM_3040.sql

*/

prompt ........
prompt ... WebApp
prompt ...

@Sql\Bars\Header\web_utl.pks
@Sql\Bars\Package\web_utl.pkb


prompt ...
prompt ... Журнал аудита
prompt ...

@Sql\Bars\Header\secaudit_utl.pks
@Sql\Bars\Package\secaudit_utl.pkb
@Sql\Bars\Error\err_jau.sql
conn sys@&&dbname/&&sys_pass
whenever sqlerror continue
@Sql\sys\Directory\secaudit_arch_dir.sql
conn bars@&&dbname/&&bars_pass
whenever sqlerror continue
@Sql\Bars\Table\sec_audit_arch.sql
@Sql\bars\View\v_sec_audit_ui.sql
@Sql\bars\View\v_sec_audit_arch_ui.sql


prompt ...
prompt ... Функции модуля
prompt ...
@Sql\Bars\Data\oper_list.sql

prompt ...
prompt ... Парамеры системы + бранчи
prompt ...

alter trigger ddl_trigger disable;

@Sql\Bars\Sequence\s_branch.sql
@Sql\Bars\Table\branch_tip.sql
@Sql\Bars\Table\branch.sql
@Sql\Bars\Data\branch_tip.sql

@Sql\Bars\Header\branch_utl.pks
@Sql\Bars\Package\branch_utl.pkb

@Sql\Bars\Table\branch_attributes.sql
@Sql\Bars\Table\branch_attribute_values.sql

@Sql\Bars\Header\branch_attribute_utl.pks
@Sql\Bars\Package\branch_attribute_utl.pkb

@Sql\Bars\View\v_depricated_params$global.sql
@Sql\Bars\View\v_depricated_params$base.sql
@Sql\Bars\View\v_depricated_params.sql
@Sql\Bars\View\v_depricated_branch_parameters.sql
@Sql\Bars\View\v_depricated_branch_tags.sql

@Sql\Bars\Script\rename_old_parameters.sql
@Sql\Bars\Script\import_old_values.sql

@Sql\Bars\Synonym\branch_tags.sql
@Sql\Bars\Synonym\branch_parameters.sql
@Sql\Bars\Synonym\params$global.sql
@Sql\Bars\Synonym\params$base.sql
@Sql\Bars\Synonym\params.sql

@Sql\Bars\Header\depricated_branch_usr.pks
@Sql\Bars\Package\depricated_branch_usr.pkb

@Sql\Bars\Header\depricated_branch_edit.pks
@Sql\Bars\Package\depricated_branch_edit.pkb

@Sql\Bars\Script\drop_old_packages.sql

@Sql\Bars\Synonym\branch_usr.sql
@Sql\Bars\Synonym\branch_edit.sql

alter trigger ddl_trigger enable;

@Sql\Bars\Table\t_sfda.sql

prompt ...
prompt ... Пакет PUL
prompt ...
@Sql\Bars\Header\PUL.pks
@Sql\Bars\Package\PUL.pkb
@Sql\Bars\Context\bars_pul.sql

prompt ...
prompt ... Процедура PUL_DAT
prompt ...
@Sql\Bars\Procedure\PUL_DAT.prc

prompt ...
prompt ... Адміністрування користувачів (БМД)
prompt ...
@\KRN\Sql\Bars\View\v_staff_user_adm_meta.sql
@\KRN\Sql\Bars\View\v_staff_user_adm_meta_add.sql
@\KRN\Sql\Bars\View\v_staff_user_ora_roles.sql
@\KRN\Sql\Bars\Data\bmd_v_staff_user_adm.sql
@\KRN\Sql\Bars\Data\bmd_v_staff_user_adm_meta.sql
@\KRN\Sql\Bars\Data\bmd_v_staff_user_adm_meta_add.sql.sql
@\KRN\Sql\Bars\Data\bmd_v_staff_user_ora_roles.sql
@\KRN\Sql\Bars\Data\bmd_v_staff_user_role.sql
@\KRN\Sql\Bars\Data\bmd_dyn_filter.sql
@\KRN\Sql\Bars\Data\operlist_adm.sql

prompt ...
prompt ... Формування DBF з каталогізованих запитів
prompt ...

@\KRN\sql\bars\Data\add_zapros.sql
@\KRN\sql\bars\Sequence\s_tmp_export_to_dbf.sql
@\KRN\sql\bars\Table\tmp_export_to_dbf.sql
@\KRN\sql\bars\Table\tmp_zapros_variable.sql
@\KRN\sql\bars\Procedure\p_export_to_dbf_web.sql
@\KRN\sql\bars\Procedure\p_zapros_parse_variable.sql


prompt ...
prompt ... Аудит функций
prompt ...

@\KRN\Sql\Bars\Table\operlist_audit.sql 
@\KRN\Sql\Bars\Trigger\tu_operlist_audit.sql 

prompt ...
prompt ... Конструктор ролей
prompt ...

@KRN\Sql\Bars\Function\FILTR_ROLE.sql
\KRN\Sql\Bars\Function\NOT_ROLE.sql
\KRN\Sql\Bars\Function\SEM_ROLE.sql
\KRN\Sql\Bars\Procedure\DEL_FROM_ROLE.sql
\KRN\Sql\Bars\Procedure\ADD_TO_ROLE.sql 
\KRN\Sql\Bars\View\30_M_ROLE.vie 
\KRN\Sql\Bars\Data\40_M_ROLE.bmd 
\KRN\Sql\Bars\Data\41_M_ROLE.bmd 
\KRN\Sql\Bars\Data\42_M_ROLE.bmd 
\KRN\Sql\Bars\Script\43_Dyn_Tabname.bmd 
\KRN\Sql\Bars\Script\50_M_ROLE.adm


spool off

quit

