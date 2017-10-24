
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mgr_oschad_attr.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MGR_OSCHAD_ATTR is

  -- Copyryight : UNITY-BARS
  -- Author     : SERG
  -- Created    : 19.10.2011
  -- Purpose    : Пакет процедур для миграции одно-мфо в мульти-мфо в НБУ
  ----
  -- Работает с конкретным МФО через таблицы kf<mfo>.<table>
  ----

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.00 19/10/2011';

  USER_STATE_DELETED   constant number        :=  0;

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- get_kf - возвращает МФО мигрируемого филиала
  --
  function get_kf return varchar2;

  ----
  -- get_rowcount - возвращает кол-во строк в таблице p_table
  --
  function get_rowcount(p_table in varchar2)
  return number;

  ----------------------------------------------------------------------------------------------------------------------
  -- Начало: процедуры проверки перед миграцией
  ----------------------------------------------------------------------------------------------------------------------

  ----
  -- check_user_bars_exists - пользователь BARS существует с ID=1
  --
  procedure check_user_bars_exists;

  ----
  -- check_user_dummy_exists - пользователь DUMMY существует с ID=-1
  --
  procedure check_user_dummy_exists;

  ----
  -- check_tabn_exists - проверка на существование идентификаторов ключей
  --
  procedure check_tabn_exists;

  ----
  -- check_tabn_length_6 - проверка длины идентификатора ключа
  --
  procedure check_tabn_length_6;

  ----
  -- check_tabn_unique - проверка уникальности идентификаторов ключей
  --
  procedure check_tabn_unique;

  ----
  -- check_meta_tables_unique - проверка уникальности имен таблиц в META_TABLES
  --
  procedure check_meta_tables_unique;

  ----
  -- check_customer_sab_unique - проверка уникальности customer.sab
  --
  procedure check_customer_sab_unique;

  ----
  -- check_rang_absent - проверка полноты таблицы RANG
  --
  procedure check_rang_absent;

  ----
  -- check_ps_absent - проверка полноты таблицы PS
  --
  procedure check_ps_absent;

  ----
  -- check_tips_absent - проверка полноты таблицы TIPS
  --
  procedure check_tips_absent;

  ----
  -- check_vids_absent - проверка полноты таблицы VIDS
  --
  procedure check_vids_absent;

  ----
  -- check_tabval_absent - проверка полноты таблицы TABVAL
  --
  procedure check_tabval_absent;

  ----
  -- check_accounts_field - проверка полноты таблицы ACCOUNTS_FIELD
  --
  procedure check_accounts_field;

  ----
  -- check_accounts_rnk_null - проверка ACCOUNTS.RNK is null
  --
  procedure check_accounts_rnk_null;

  ----
  -- do_checks - выполняет проверки перед миграцией
  --
  procedure do_checks;

  ----------------------------------------------------------------------------------------------------------------------
  -- Окончание: процедуры проверки перед миграцией
  ----------------------------------------------------------------------------------------------------------------------

  ----
  -- clean_params - очищает таблицу params$base по мигрируемому МФО
  --
  procedure clean_params;

  ----
  -- fill_params - заполняет таблицу params$base
  -- можно при включенных внешних ключах
  --
  procedure fill_params;

  ----
  -- clean_branch - очищает таблицу branch по мигрируемому МФО
  --
  --
  procedure clean_branch;

  ----
  -- fill_branch - заполняет таблицу branch
  --
  --
  procedure fill_branch;

  ----
  -- clean_fdat - очищает fdat
  --
  --
  procedure clean_fdat;

  ----
  -- fill_fdat - заполняет таблицу fdat
  --
  --
  procedure fill_fdat;


  procedure drop_user_novalidate(p_userid    in  staff$base.id%type );
  ----
  -- clean_staff - удаление пользователей по мигрируемому МФО
  --
  --
  procedure clean_staff;

  ----
  -- fill_staff - создание пользователей
  --
  --
  procedure fill_staff;

  ----
  -- clean_customers - очистка клиентов
  --
  --
  procedure clean_customers;

  ----
  -- fill_customers - импорт клиентов
  --
  --
  procedure fill_customers;

  ----
  -- sync_ps - синхронизация плана счетов
  --
  procedure sync_ps;

  ----
  -- sync_ps_sparam - синхронизация ps_sparam
  --
  procedure sync_ps_sparam;

  ----
  -- sync_pos - синхронизирует таблицу pos
  --
  procedure sync_pos;

  ----
  -- sync_tips - синхронизирует таблицу tips
  --
  procedure sync_tips;

  ----
  -- sync_vids - синхронизирует таблицу vids
  --
  procedure sync_vids;

  ----
  -- sync_tabval$local - синхронизирует таблицу tabval$local
  --
  procedure sync_tabval$local;

  ----
  -- sync_accounts_field - синхронизирует таблицу accounts_field
  --
  procedure sync_accounts_field;

  ----
  -- sync_dpa_nbs - синхронизирует таблицу dpa_nbs
  --
  procedure sync_dpa_nbs;

  ----
  -- sync_brates - синхронизирует таблицу brates
  --
  procedure sync_brates;

  ----
  -- sync_banks$base - синхронизирует таблицу banks$base
  --
  procedure sync_banks$base;

  ----
  -- sync_basey - синхронизирует таблицу basey
  --
  procedure sync_basey;

  ----
  -- sync_sk - синхронизирует таблицу SK
  --
  procedure sync_sk;

  ----
  -- sync_int_metr - синхронизирует таблицу int_metr
  --
  procedure sync_int_metr;

  ----
  -- sync_sw_banks - синхронизирует таблицу sw_banks
  --
  procedure sync_sw_banks;

  ----
  -- clean_accounts - очистка счетов
  --
  --
  procedure clean_accounts;

  ----
  -- fill_accounts - импорт счетов
  --
  procedure fill_accounts;

  ----
  -- fill_groups_staff - Пользоиватели-Групы пользователей
  --
  procedure fill_groups_staff;

  ----
  -- clean_saldoa - очистка истории движения
  --
  --
  procedure clean_saldoa;

  ----
  -- fill_saldoa - импорт истории движения
  --
  --
  procedure fill_saldoa;

  procedure fill_saldoz;

  procedure clean_snap_balances;

  procedure fill_snap_balances;

  procedure clean_agg_monbals;

  procedure fill_agg_monbals;

  ----
  -- clean_oper - очистка oper
  --
  procedure clean_oper;

  ----
  -- fill_oper - импорт oper
  --
  procedure fill_oper(p_partitionway varchar2 default null, p_date date default null, p_date_end date default null);

  ----
  -- fill_oper_ext - импорт oper_ext
  --
  procedure clean_oper_ext;

  procedure fill_oper_ext;

  ----
  -- fill_op_field - импорт op_field
  --
   procedure fill_op_field;

  ----
  -- clean_operw - очистка operw
  --
  procedure clean_operw;

  ----
  -- fill_operw - импорт operw
  --
  procedure fill_operw;

  ----
  -- clean_oper_visa - очистка oper_visa
  --
  procedure clean_oper_visa;

  ----
  -- fill_oper_visa - импорт oper_visa
  --
  procedure fill_oper_visa;

  ----
  -- clean_opldok - очистка opldok
  --
  procedure clean_opldok;

  ----
  -- fill_opldok - импорт opldok
  --
 procedure fill_opldok(p_partitionway varchar2 default null, p_date date default null, p_date_end date default null);

  ----
  -- correct_opldok - корректировка opldok
  --
  procedure correct_opldok;

  ----
  -- clean_ref_que - очистка ref_que
  --
  procedure clean_ref_que;

  ----
  -- fill_ref_que - импорт ref_que
  --
  procedure fill_ref_que;

  ----
  -- clean_ref_lst - очистка ref_lst
  --
  procedure clean_ref_lst;

  ----
  -- fill_ref_lst - импорт ref_lst
  --
  procedure fill_ref_lst;

  ----
  -- clean_zag_a - очистка zag_a
  --
  procedure clean_zag_a;

  ----
  -- fill_zag_a - импорт zag_a
  --
  procedure fill_zag_a;

  ----
  -- clean_zag_b - очистка zag_b
  --
  procedure clean_zag_b;

  ----
  -- fill_zag_b - импорт zag_b
  --
  procedure fill_zag_b;

  ----
  -- clean_arc_rrp - очистка arc_rrp
  --
  procedure clean_arc_rrp;

  ----
  -- fill_arc_rrp - импорт arc_rrp
  --
  procedure fill_arc_rrp(p_partitionway varchar2 default null, p_date date default null, p_date_end date default null);

  ----
  -- clean_zag_k - очистка zag_k
  --
  procedure clean_zag_k;

  ----
  -- fill_zag_k - импорт zag_k
  --
  procedure fill_zag_k;

  ----
  -- clean_zag_f - очистка zag_f
  --
  procedure clean_zag_f;

  ----
  -- fill_zag_f - импорт zag_f
  --
  procedure fill_zag_f;

  ----
  -- clean_zag_g - очистка zag_g
  --
  procedure clean_zag_g;

  ----
  -- fill_zag_g - импорт zag_g
  --
  procedure fill_zag_g;

  ----
  -- clean_zag_l - очистка zag_l
  --
  procedure clean_zag_l;

  ----
  -- fill_zag_l - импорт zag_l
  --
  procedure fill_zag_l;

  ----
  -- clean_zag_mc - очистка zag_mc
  --
  procedure clean_zag_mc;

  ----
  -- fill_zag_mc - импорт zag_mc
  --
  procedure fill_zag_mc;

  ----
  -- clean_zag_p - очистка zag_p
  --
  procedure clean_zag_p;

  ----
  -- fill_zag_p - импорт zag_p
  --
  procedure fill_zag_p;

  ----
  -- clean_zag_r3 - очистка zag_r3
  --
  procedure clean_zag_r3;

  ----
  -- fill_zag_r3 - импорт zag_r3
  --
  procedure fill_zag_r3;

  ----
  -- sync_bopbank - синхронизация bopbank
  --
  procedure sync_bopbank;

--new

  procedure sync_bopcode;
  procedure sync_BOPCOUNT;
  procedure sync_BP_REASON;
  procedure sync_RCUKRU;
  procedure sync_REP_PROC;
  procedure sync_REPORTSF;
  procedure sync_bic_acc;
  procedure sync_bank_acc;
  procedure sync_BP_BACK (p_delete boolean, p_mfo varchar2);
  procedure sync_BP_RRP;
  procedure sync_any_table (p_table varchar2, p_delete boolean, p_mfo varchar2, p_insert varchar2);
  procedure sync_any_table_auto (p_table varchar2, p_delete boolean, p_mfo varchar2);

  ----
  -- tabsync - вызов mgr_utl.tabsync
  --
  procedure tabsync(p_table varchar2);

  ----
  -- fill_perekr_r - наполнение perekr_r
  --
  procedure fill_perekr_r;

  ----
  -- fill_perekr_b - наполнение perekr_b
  --
  procedure fill_perekr_b;

  ----
  -- fill_perekr_b_update - наполнение perekr_b_update
  --
  procedure fill_perekr_b_update;

  ----
  -- fill_banks$settings - наполнение banks$settings
  --
  procedure fill_banks$settings;

  ----
  -- clean - очистка произвольной таблицы
  --
  procedure clean(p_table varchar2);

  ----
  -- fill_tts - наполнение tts и связных таблиц
  --
  procedure fill_tts;

  ----
  -- get_errinfo - возвращает описание типовых ошибок в таблице err$_*
  --
  function get_errinfo(p_errtable in varchar2)
  return varchar2;

  ----
  -- mantain_error_table - создает/очищает таблицу ошибок err$_<p_table>
  --
  procedure mantain_error_table(p_table in varchar2);


  ----
  -- clean_cur_rates - очистка cur_rates
  --
  procedure clean_cur_rates;

  ----
  -- fill_cur_rates - наполнение cur_rates
  --
  procedure fill_cur_rates;

  ----
  -- clean_dyn_filter - очистка dyn_filter
  --
  procedure clean_dyn_filter;

  ----
  -- fill_dyn_filter - наполнение dyn_filter
  --
  procedure fill_dyn_filter;

  ----
  -- fill_otdel - наполнение otdel
  --
  procedure fill_otdel;

  ---
  -- fill_otd_user - наполнение otd_user
  --
  procedure fill_otd_user;

  ----
  -- diff_zapros - создает протокол расхождений по таблице zapros
  --
  procedure diff_zapros;

  ----
  -- fill_operlist - наполнение operlist
  --
  procedure fill_operlist;


  procedure fill_operlist_deps;

  procedure fill_operlist_deps_acs;

  procedure fill_operlist_acspub;

  ----
  -- fill_applist - наполнение applist
  --
  procedure fill_applist;

  ----
  -- fill_operapp - наполнение operapp
  --
  procedure fill_operapp;

  ----
  -- fill_refapp - наполнение refapp
  --
  procedure fill_refapp;

  ----
  -- fill_app_rep - наполнение app_rep
  --
  procedure fill_app_rep;

  ----
  -- fill_applist_staff - наполнение applist_staff
  --
  procedure fill_applist_staff;

  ----
  -- fill_staff_tts - наполнение staff_tts
  --
  procedure fill_staff_tts;

  ----
  -- fill_staff_chk - наполнение staff_chk
  --
  procedure fill_staff_chk;

  ----
  -- fill_staff_klf00 - наполнение staff_klf00
  --
  procedure fill_staff_klf00;

  ----
  -- adjust_role_grants - выдает недостающие роли пользователям
  --
  procedure adjust_role_grants;

  ----
  -- check_local_tables - проверяет наличие данных в таблицах с полями KF, BRANCH, RFC и пр.
  --
  procedure check_local_tables;

 ---
 -- Процедура импорта NLK_REF
 --
 procedure fill_nlk_ref;

 procedure fill_nlk_ref_update;

  ---
 -- Процедура импорта ALIEN
 --
 procedure fill_alien;

  ---
  -- Импорт SPOT
  --
 procedure fill_spot;

 procedure fill_t902;

 procedure fill_klf00;

 procedure fill_sw_nostro_que;

 procedure fill_sos_track;

 procedure clean_sos_track;

 procedure fill_sos0que;

 procedure fill_tzapros;

 procedure fill_cash_open;

 procedure fill_cash_refque;

 procedure fill_cash_snapshot;

 procedure fill_fin_calculations;

 procedure fill_fin_obu_pawn;

 procedure fill_fin_fm;

 procedure fill_fin_fm_upd;

 procedure fill_fin_nd;

 procedure fill_fin_nd_upd;

 procedure fill_fin_rnk;



-----
--Импорт DPT
-----
  procedure  fill_dpt_deposit_all;

  procedure  fill_dpt_deposit;

  procedure  fill_dpt_deposit_clos;

  procedure  fill_dpt_payments;

  procedure  fill_dpt_accounts;

  procedure  fill_dpt_deposit_details;

  procedure  fill_dpt_bonus_requests;

  procedure  fill_dpt_requests;

  procedure  fill_dpt_trustee;

  procedure  fill_dpt_inheritors;

  procedure  fill_dpt_depositw;

  procedure  fill_dpt_extconsent;

  procedure  fill_dpt_req_chgints;

  procedure  fill_dpt_req_deldeals;

  procedure  fill_dpt_techaccounts;

  procedure  fill_dpt_immobile;

  procedure  fill_dpt_agreements;

  procedure  fill_dpt_agrw;

  procedure  fill_ead_docs;

  procedure  fill_acc_balance_changes;

  procedure  fill_acc_balance_chng_upd;

  procedure  fill_dpt_soc_turns;

  procedure  fill_dpt_jobs_jrnl;

  procedure  fill_dpt_jobs_log;

  procedure fill_cust_req_access;

  procedure fill_cust_requests;

  procedure fill_person_val_doc_upd;

   procedure fill_person_valid_document;

  procedure  dpt_reset_sqnc;

-----
--Импорт DPU
-----

  procedure  fill_dpu_deal;

  procedure  fill_dpu_deal_upd;

  procedure  fill_dpu_jobs_jrnl;

  procedure  fill_dpu_jobs_log;

  procedure  fill_dpu_deal_swtags;

  procedure  fill_dpu_dealw;

  procedure  fill_dpu_dealw_update;

  procedure  fill_dpu_agreements;

  procedure  fill_dpu_payments;

  procedure  fill_dpu_accounts;

  procedure  dpu_reset_sqnc;

  ----

  procedure  fill_sto_grp;

  procedure  fill_sto_lst;

  procedure  fill_sto_det;

  procedure  fill_sto_det_agr;

  procedure fill_sto_operw;

  procedure fill_sto_dat;

  procedure fill_sto_det_upd;

  procedure fill_sto_dat_upd;

  procedure fill_zayavka;

  procedure fill_zayavka_ru;

  procedure fill_zay_baop;

  procedure fill_zay_currency_income;

  procedure fill_zay_comiss;

  procedure fill_zay_currency_income_ru;

  procedure fill_zay_data_transfer;

  procedure fill_zay_data_transfer_log;

  procedure fill_zay_debt;

  procedure fill_zay_debt_klb;

  procedure fill_zay_que;

  procedure fill_zay_track;

  procedure fill_zay_track_ru;

  procedure  zay_reset_sqnc;

  ---

  procedure fill_meta_tables;

  procedure fill_meta_filtercodes;

  procedure fill_meta_actiontbl;

  procedure fill_meta_columns;

  procedure fill_meta_browsetbl;

  procedure fill_meta_extrnval;

  procedure fill_meta_filtertbl;

  procedure fill_meta_sortorder;

  procedure fill_meta_tblcolor;

  procedure fill_meta_nsifunction;

  procedure fill_skrynka_nd;

  procedure fill_skrynka_nd_upd;

  procedure fill_skrynka_nd_acc;

  procedure fill_skrynka_nd_arc;

  procedure fill_skrynka_nd_ref;

  procedure fill_skrynka_visit;

  procedure fill_skrynka_sync_queue;

  procedure fill_skrynka_attorney;

  procedure fill_skrynka_nd_branch;

  procedure fill_cc_deal;

  procedure fill_cc_add;

  procedure fill_nd_acc;

  procedure fill_nd_txt;

  procedure fill_mbd_k_r;

  procedure fill_proc_dr;

  procedure fill_cdb_deal_comment;

  procedure fill_sto_sbon;

  procedure clean_sto_sbon;

  procedure grant_sto_sbon;

  ---

  procedure fill_xml_impfiles;

  procedure fill_xml_impdocs;

  procedure fill_xml_impdocsw;

  ---

  ----
  -- Друковані звіти та каталогізовані запити
  --
  procedure fill_zapros;

  procedure fill_zapros_attr;

  procedure fill_reports;
  ----------------------------

  procedure fill_sparam_list;

  ---
  procedure fill_br_tier_edit;

  procedure fill_br_normal_edit;

  procedure fill_references;

  procedure fill_int_accn;

  procedure fill_int_ratn;

  procedure fill_int_ratn_arc;

  ---------------------------------
  procedure fill_wcs_bck_reports;
  procedure fill_wcs_bck_results;
  procedure fill_wcs_subproduct_branches;
  procedure fill_wcs_subproduct_macs;
  procedure fill_wcs_user_responsibility;
  ---------------------------------
  procedure fill_cp_dat;
  procedure fill_cp_dat_update;
  procedure fill_cc_accp;
  procedure fill_cp_deal;
  procedure fill_cp_deal_update;
  procedure fill_pawn_acc;
  procedure fill_cp_arch;
  procedure fill_cp_forw;
  procedure fill_cp_accounts;
  procedure fill_cp_payments;
  procedure fill_cp_zal;
  procedure fill_cp_many_dat;
  procedure fill_cp_many_upd;
  procedure fill_cp_many_update;
  procedure fill_otcn_f42_cp;
  procedure fill_specparam_cp_ob;
  procedure fill_cp_ticket;
  procedure fill_cp_ref_acc;
  procedure fill_cp_rates_sb;
  procedure fill_cp_emiw;
  ------------------------------------
  procedure fill_mbk_cp;
  procedure fill_sw_journal;
  procedure fill_fx_deal;
  procedure fill_fx_deal_acc;
  procedure fill_mb_plan;
  procedure fill_fx_deal_ref;
  procedure fill_fx_in_mt;
  procedure fill_forex_a;
  -----------------------------
  procedure fill_acc_over;
  procedure fill_acc_over_arch;
  procedure fill_acc_over_par;
  procedure fill_acc_over_update;
  procedure fill_acc_over_deal;
  -----------------------------
  procedure fill_cc_trans_update;
  procedure fill_cc_trans;
  procedure fill_cc_trans_ref;
  procedure fill_cc_tag;
  procedure fill_cc_swtrace;
  procedure fill_cc_svk;
  procedure fill_cc_sparam;
  procedure fill_cc_source;
  procedure fill_cc_sob_update;
  procedure fill_cc_sob;
  procedure fill_cc_sec;
  procedure fill_cc_refv;
  procedure fill_cc_raz_komis_tarif;
  procedure fill_cc_prol;
  procedure fill_cc_peny_start;
  procedure fill_cc_overdue_dates;
  procedure fill_cc_many;
  procedure fill_cc_lim_update;
  procedure fill_cc_lim_arc;
  procedure fill_cc_lim;
  procedure fill_cc_docs;
  procedure fill_cc_deal_update;
  procedure fill_cc_add_update;
  procedure fill_cc_accp_update;
  procedure fill_CC_989917_REF;
  procedure fill_cck_sum_pog;
  procedure fill_cck_restr_update;
  procedure fill_cck_restr_acc;
  procedure fill_cck_restr;
  procedure fill_cck_isp_nls;
  procedure fill_cc_kol_sp;
  procedure fill_cc_grt_update;
  procedure fill_cc_grt;
  procedure fill_inv_cck_fl;
  procedure fill_inv_cck_fl_23;
  procedure fill_inv_cck_fl_bpkk;
  procedure fill_inv_cck_fl_bpkk_23;

  procedure sync_banks$settings;
  procedure sync_nd_txt;
  procedure sync_dpu_jobs_log;

    procedure sync_zay_mfo_nls29;

    procedure execute_statement(
        p_statement in varchar2,
        p_log_label in varchar2);
end;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mgr_oschad_attr.sql =========*** End
 PROMPT ===================================================================================== 
 