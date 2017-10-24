
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mgr_commerc2.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MGR_COMMERC2 is
  ---------------------------------------------------------------------------
  -- Copyryight : UNITY-BARS
  -- Author     : MOS
  -- Created    : 05.04.2013
  -- Purpose    : Пакет процедур для миграции комерческих банков в схему ММФО
  ---------------------------------------------------------------------------
  ----
  -- Работает с помощью DB-link
  ----

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.00 05/04/2013';


  ---
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ---
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ---
  -- Отключение тригеров
  --
  procedure before_fill(p_tables in varchar2);

  ----
  -- before_clean - выполняет предварительные действия со списком таблиц перед их очисткой
  --                отключает внешние ключи, триггера
  procedure before_clean(p_tables in varchar2);

  ---
  -- finalize
  --
  procedure finalize;

  ---
  -- Процедура синхронизации таблицы
  --
  procedure tabsync(p_table varchar2);

  ---
  -- Очистка произвольной таблички
  --
  procedure clean(p_table varchar2);

  ---
  --Довыдача не хватающих ролей
  --
  procedure adjust_role_grants;

  ---
  -- Пропуск через проходную
  --
  procedure vaxta;

  ---
  -- fill_params - заполняет таблицу params$base
  -- можно при включенных внешних ключах
  --
  procedure fill_params;

  ---
  -- fill_fdat - заполняет fdat
  --
  procedure fill_fdat;

  ---
  -- Процедура импорта пользователей
  --
  procedure fill_staff;

  ---
  -- clean_staff
  --
  procedure clean_staff;

  ---
  -- fill_operlist
  --
  procedure fill_operlist;

  ---
  -- clean_operlist
  --
  procedure clean_operlist;

  ---
  -- fill_vob
  --
  procedure fill_vob;

  ---
  --fill_tts
  --
  procedure fill_tts;

  ---
  --clean_tts
  --
  procedure clean_tts;

  ---
  -- sync stmt
  --
  procedure fill_stmt;

  ---
  -- sync prinsider
  --
  procedure fill_prinsider;

  ---
  -- sync sed
  --
  procedure fill_sed;

  ---
  -- sync customer_field
  --
  procedure fill_customer_field;

  ---
  -- Импорт клиентов
  --
  procedure fill_customers;

  ---
  -- clean_customers - очистка клиентов
  --
  procedure clean_customers;

  ---
  --Доимпорт TABVAL
  --
  procedure fill_tabval;

  ---
  --fill_tips
  --
  procedure fill_tips;

  ---
  -- sync brates
  --
  procedure fill_brates;

  ---
  --Импорт счетов
  --
  procedure fill_accounts;

  ---
  -- Очистка счетов
  --
  procedure clean_accounts;

  ---
  -- fill_saldoa - импорт оборотов
  --
  procedure fill_saldoa;

  ---
  -- Очистка оборотов
  --
  procedure clean_saldoa;

  ---
  -- fill_oper - импорт oper
  --
  procedure fill_oper;

  ---
  -- fill_operN - импорт oper (по рекомендациям Кикотя И.)
  --
  procedure fill_operN (p_name  varchar2);

  ---
  -- clean_oper - очистка oper
  --
  procedure clean_oper;

  ---
  -- fill_oper_part - импорт oper(если есть партиции)
  --
  procedure fill_oper_part;

   ---
 -- clean_oper_part
 --
 procedure clean_oper_part;

 procedure fill_operw;

 procedure fill_operwN (p_name  varchar2);

 procedure clean_operw;

  ---
  -- Импорт opldok
  --
  procedure fill_opldok;

  ---
  -- Импорт opldok
  --
  procedure fill_opldokN (p_name  varchar2);

  ---
  -- Clean opldok
  --
  procedure clean_opldok;

  ---
  -- fill_opldok_part - импорт opldok
  --
  procedure fill_opldok_part;

  ---
  -- clean_opldok_part - очистка opldok
  --
  procedure clean_opldok_part;

  ---
  -- Импорт OPER_VISA
  --
  procedure fill_oper_visa;

  ---
  -- Очистка OPER_VISA
  --
  procedure clean_oper_visa;

  ---
  -- Импорт REF_QUE
  --
  procedure fill_ref_que;

  ---
  -- clean_ref_que - очистка ref_que
  --
    procedure clean_ref_que;

  ---
  -- fill_ref_lst - импорт ref_lst
  --
  procedure fill_ref_lst;

  ---
  -- clean_ref_lst - очистка ref_lst
  --
  procedure clean_ref_lst;

  ---
  -- clean_zag_a - очистка zag_a
  --
  procedure clean_zag_a;

  ---
  -- fill_zag_a - импорт zag_a
  --
  procedure fill_zag_a;

  ---
  -- clean_zag_b - очистка zag_b
  --
  procedure clean_zag_b;

  ---
  -- fill_zag_b - импорт zag_b
  --
  procedure fill_zag_b;

  ---
  -- fill_arc_rrp - импорт arc_rrp
  --
  procedure fill_arc_rrp;

  procedure fill_arc_rrpN (p_name  varchar2);

  procedure fill_arc_rrp2;

  ---
  -- Очистка arc_rrp
  --
  procedure clean_arc_rrp;

  ---
  -- fill_arc_rrp_part
  --
  procedure fill_arc_rrp_part;

  ---
  -- clean_arc_rrp_part
  --
  procedure clean_arc_rrp_part;

  ---
  -- clean_zag_k - очистка zag_k
  --
  procedure clean_zag_k;

  ---
  -- fill_zag_k - импорт zag_k
  --
  procedure fill_zag_k;

  ---
  -- clean_zag_f - очистка zag_f
  --
  --
  procedure clean_zag_f;

  ---
  -- fill_zag_f - импорт zag_f
  --
  procedure fill_zag_f;

  ---
  -- clean_zag_mc - очистка zag_mc
  --
  procedure clean_zag_mc;

  ---
  -- fill_zag_mc - импорт zag_mc
  --
  procedure fill_zag_mc;

  ---
  -- очистка banks$settings
  --
  procedure clean_banks$settings;

  ---
 -- Импорт fill_banks$settings
 --
 procedure fill_banks$settings;

 procedure clean_banks$base;

 procedure fill_banks$base;

  ---
  -- очистка lkl_rrp
  --
  procedure clean_lkl_rrp;

 ---
 -- Импорт fill_banks$settings
 --
 procedure fill_lkl_rrp;

  ---
  -- очистка t902
  --
  procedure clean_t902;

 ---
 -- Импорт fill_banks$settings
 --
 procedure fill_t902;

  ---
  -- очистка tzapros
  --
  procedure clean_tzapros;

 ---
 -- Импорт fill_tzapros
 --
 procedure fill_tzapros;

 ---
 -- Clean vp_list
 --
 procedure clean_vp_list;

 ---
 -- Fill vp_list
 --
 procedure fill_vp_list;

  ---
  -- clean_cur_rates - очистка cur_rates
  --
  procedure clean_cur_rates;

  ---
  -- fill_cur_rates - наполнение cur_rates
  --
  procedure fill_cur_rates;

  ---
  -- clean_bp_rrp - очистка бизнес-правил
  --
  procedure clean_bp_rrp;

  ---
  -- fill_bp_rrp
  --
procedure fill_bp_rrp;

  ---
  -- Clean perekr_a
  --
procedure clean_perekr_a;

  ---
  -- Fill Perekr_a
  --

procedure fill_perekr_a;

  ---
  -- Clean perekr_b
  --
procedure clean_perekr_b;

  ---
  -- Fill Perekr_b
  --
procedure fill_perekr_b;

  ---
  -- Clean perekr_g
  --
procedure clean_perekr_g;

  ---
  -- Fill Perekr_g
  --
procedure fill_perekr_g;

  ---
  -- Clean perekr_j
  --
procedure clean_perekr_j;

  ---
  -- Fill Perekr_j
  --
procedure fill_perekr_j;

  ---
  -- Clean perekr_r
  --
procedure clean_perekr_r;

  ---
  -- Fill Perekr_r
  --
procedure fill_perekr_r;

  ---
  -- Clean perekr_s
  --
procedure clean_perekr_s;

  ---
  -- Fill Perekr_s
  --
procedure fill_perekr_s;

---
-- Импорт АРМов
--
--procedure fill_applist;

---
--fill_doc_scheme
--
procedure fill_doc_scheme;

---
-- fill_dpt_deposit
--
procedure fill_dpt_deposit;

---
--fill_cc_docs
--
procedure fill_cc_docs;

---
--fill_cc_tipd
--
procedure fill_cc_tipd;

---
--fill_cc_vidd
--
procedure fill_cc_vidd;

---
-- Fill_DPT_DEPOSIT_CLOS
--
procedure fill_dpt_deposit_clos;

---
-- Импорт мета описания и справочников
--
procedure fill_meta_tables;
procedure fill_dyn_filter;
procedure fill_meta_columns;
procedure fill_meta_sortorder;
procedure fill_meta_extrnval;
procedure fill_meta_browsetbl;
procedure fill_meta_filtercodes;
procedure fill_meta_filtertbl;
procedure fill_references;
procedure fill_meta_actiontbl;
procedure fill_dbf_sync_tabs;
-----------------------------------------

---
-- fill_refapp
--
procedure fill_refapp;

---
-- Досоздание нехватающих ролей
--
procedure create_role;

---
-- Import zapros
--
procedure fill_zapros;

---
--Import reports
--
procedure fill_reports;

---
-- Выдача грантов таблицам и вьюшкам у которых нет ни одного гранта
--
procedure add_grant;

----
    -- reset_sequence - сбрасывает значение последовательности
    --
    procedure reset_sequence (seq_name in varchar2, startvalue in pls_integer);

end mgr_commerc2;
/
CREATE OR REPLACE PACKAGE BODY BARS.MGR_COMMERC2 is
  -----------------------------------------------------------------------
  -- Copyryight : UNITY-BARS
  -- Author     : MOS
  -- Created    : 05.04.2013
  -- Purpose    : Пакет процедур для миграции комерческих банков в схему ММФО
  -----------------------------------------------------------------------
  -- Работает с помощью DB-link  (Название линка должно быть заполнено в параметре "MGR_LINK")
  -- В таблице BRANCH должно быть добавлено и заполнено поле TOBO
  ----
  -- Перед началом миграции сделать в SQLPLUS SQL>@trace или
  /*
  set feed off echo off term off
  set serveroutput on size unlimited
  exec logger.set_log_level(8);
  exec logger.set_output(1);
  exec logger.set_trace_objects('ALL');
  set feed on echo on term on
  */
  --
  ----
  ----
    ----
    -- Для очистки еталона от старых бранчей
    ----
    --alter table branch add tobo number
    --
    --delete from cur_rates$base where length(branch)>1
    --
    --delete from corps
    --
    --delete from customerw
    --
    --delete from customerw_update
    --
    --delete from customer_address
    --
    --delete from customer_update
    --
    --delete from ins_partner_types
    --
    --delete from ins_partners
    --
    --delete from customer
    --
    --delete from dpt_jobs_jrnl
    --
    --delete from kl_f00$local
    --
    --delete from sos_track
    --
    --exec bpa.disable_policies('oper')
    --
    --delete from oper
    --
    --exec bpa.enable_policies('oper')
    --
    --delete from sec_journal
    --
    --update staff$base
    --set branch='/', policy_group='WHOLE'
    --
    --delete from kl_f00_int$local
    --
    --exec bpa.disable_policies('sec_audit')
    --
    --truncate table sec_audit
    --
    --exec bpa.enable_policies('sec_audit')
    --
    --delete from CUR_RATE_KOM_UPD
    --
    --delete from branch_parameters
    --
    --delete from br_normal_edit
    --
    --delete from br_tier_edit
    --
    --delete from proc_dr$base
    --
    --delete from DPT_FILE_SUBST
    --
    --delete from wcs_subproduct_macs
    --
    --delete from wcs_subproduct_branches
    --
    --delete from bank_mon
    --
    --delete from bank_mon_upd
    --
    --delete from bank_slitky
    --
    --delete from rez_protocol
    --
    --DELETE from branch
    --WHERE length(branch)>1
    --
    --commit;
    --

  ----
  -- Очистка основных таблиц
  ----
  --
      /*В схеме BARSAQ
      delete from cust_individuals;
      delete from cust_companies;
      delete from customers;
      delete from ibank_rnk;
      delete from accounts;
      delete from ibank_acc;
      */
 ---BARS
 -- exec mgr_commerc.clean_customers;
  -- exec mgr_commerc.clean_accounts;
  -- exec mgr_commerc.clean_saldoa;
  -- exec mgr_commerc.clean_oper;         --без партиций
  -- exec mgr_commerc.clean_oper_part;    --партиционированый
  -- exec mgr_commerc.clean_opldok;       --без партиций
  -- exec mgr_commerc.clean_opldok_part;  --партиционированый
  -- exec mgr_commerc.clean_oper_visa;
  -- exec mgr_commerc.clean_ref_que;
  -- exec mgr_commerc.clean_ref_lst;
  -- exec mgr_commerc.clean_zag_a;
  -- exec mgr_commerc.clean_zag_b;
  -- exec mgr_commerc.clean_arc_rrp;      --без партиций
  -- exec mgr_commerc.clean_arc_rrp_part; --партиционированый
  -- exec mgr_commerc.clean_zag_k;
  -- exec mgr_commerc.clean_zag_f;
  -- exec mgr_commerc.clean_zag_mc;
  -- exec mgr_commerc.clean_banks$settings;
  -- exec mgr_commerc.clean_lkl_rrp;
  -- exec mgr_commerc.clean_t902;
  -- exec mgr_commerc.clean_tzapros;
  -- exec mgr_commerc.clean_vp_list;
  -- exec mgr_commerc.clean_cur_rates;
  -- exec mgr_commerc.clean_bp_rrp;
  -- exec mgr_commerc.clean_perekr_a;
  -- exec mgr_commerc.clean_perekr_b;
  -- exec mgr_commerc.clean_perekr_j;
  -- exec mgr_commerc.clean_perekr_r;
  ----
  -- Также есть процедура clean для чистки простых таблиц например
  ----
  --exec mgr_commerc.clean('np');
  ----
  ----
  -- Порядок миграции
  ----
  -- exec mgr_commerc.fill_params;
  -- exec mgr_commerc.fill_fdat;
  -- exec mgr_commerc.fill_staff;
  -- exec mgr_commerc.fill_stmt;
  -- exec mgr_commerc.fill_prinsider;
  -- exec mgr_commerc.fill_sed;
  -- exec mgr_commerc.fill_customer_field;
  -- exec mgr_commerc.fill_customers;
  -- exec mgr_commerc.fill_tabval;
  -- exec mgr_commerc.fill_tips;
  -- exec mgr_commerc.fill_brates;
  -- exec mgr_commerc.fill_accounts;
  -- exec mgr_commerc.fill_saldoa;
  -- exec mgr_commerc.fill_oper;       --без партиций
  -- exec mgr_commerc.fill_oper_part;  --партиционированый
  -- exec mgr_commerc.fill_opldok;     --без партиций
  -- exec mgr_commerc.fill_opldok_part;--партиционированый
  -- exec mgr_commerc.fill_operw;
  -- exec mgr_commerc.fill_oper_visa;
  -- exec mgr_commerc.fill_ref_que;
  -- exec mgr_commerc.fill_ref_lst;
  -- exec mgr_commerc.fill_zag_a;
  -- exec mgr_commerc.fill_zag_b;
  -- exec mgr_commerc.fill_arc_rrp;      -- без партиций
  -- exec mgr_commerc.fill_arc_rrp_part; -- партиционированый
  -- exec mgr_commerc.fill_zag_k;
  -- exec mgr_commerc.fill_zag_f;
  -- exec mgr_commerc.fill_zag_mc;
  -- exec mgr_commerc.fill_banks$settings;
  -- exec mgr_commerc.fill_lkl_rrp;
  -- exec mgr_commerc.fill_t902;
  -- exec mgr_commerc.fill_tzapros;
  -- exec mgr_commerc.fill_vp_list;
  -- exec mgr_commerc.fill_cur_rates;
  -- exec mgr_commerc.fill_bp_rrp;
  -- exec mgr_commerc.fill_perekr_a;
  -- exec mgr_commerc.fill_perekr_b;
  -- exec mgr_commerc.fill_perekr_j;
  -- exec mgr_commerc.fill_perekr_r;
  --
  -- Также есть процедура tabsync для миграции простых таблиц например
  --exec mgr_commerc.tabsync('np');
  --exec bpa.disable_policies('TARIF');
  --exec mgr_commerc.tabsync('TARIF');
  --exec bpa.enable_policies('TARIF');
  --exec mgr_commerc.tabsync('ACC_TARIF');
  --
  ----
  -- Депозиты ЮО
  ----
  --****** Очистка*********
  --exec mgr_commerc.clean('dpu_accounts');
  --exec mgr_commerc.clean('dpu_deal');
  --exec mgr_commerc.clean('dpu_deal_update');
  --exec mgr_commerc.clean('DPU_VIDD_RATE');
  --exec mgr_commerc.clean('DPU_VIDD_COMB');
  --exec mgr_commerc.clean('DPU_VIDD');
  --exec mgr_commerc.clean('DPU_TYPES')
  ----
  --******Заливка**********
  ----
  -- Импорт пока не делаем так как в УКООП эти таблицы пустые
  -- Допишем перед импортом Петрокомерца
  ----
  --
  --
  ----
  -- Депозиты ФО
  ----
  --****** Очистка*********
  --exec mgr_commerc.clean('dpt_accounts');
  --exec mgr_commerc.clean('DPT_DEPOSIT_ALL');
  --exec mgr_commerc.clean('dpt_deposit');
  --exec mgr_commerc.clean('dpt_deposit_clos');
  --exec mgr_commerc.clean('DPT_VIDD_FIELD');
  --exec mgr_commerc.clean('DPT_FIELD');
  --exec mgr_commerc.clean('DPT_VIDD_PARAMS');
  --exec mgr_commerc.clean('DPT_VIDD_SCHEME');
  --exec mgr_commerc.clean('DPT_TTS_VIDD');
  --exec mgr_commerc.clean('DPT_VIDD_UPDATE');
  --exec mgr_commerc.clean('DPT_VIDD');
  --exec mgr_commerc.clean('DPT_TYPES');
  --exec mgr_commerc.clean_perekr_s;
  --exec mgr_commerc.clean_perekr_g;
  --exec mgr_commerc.clean('DOC_ROOT');
  --exec mgr_commerc.clean('DOC_SCHEME');
  --exec mgr_commerc.clean('DPT_VIDD_EXTDESC');
  --exec mgr_commerc.clean('DPT_VIDD_EXTYPES');
  ----
  --******Заливка*********
  --exec mgr_commerc.fill_perekr_s;
  --exec mgr_commerc.fill_perekr_g;
  --exec mgr_commerc.fill_cc_tipd;
  --exec mgr_commerc.fill_cc_vidd;
  --exec mgr_commerc.fill_DOC_SCHEME;
  --exec mgr_commerc.tabsync('DOC_ROOT');
  --exec mgr_commerc.tabsync('DPT_FIELD');
  --exec mgr_commerc.tabsync('DPT_VIDD_EXTYPES');
  --exec mgr_commerc.tabsync('DPT_TYPES');
  --exec mgr_commerc.tabsync('dpt_vidd');
  --exec mgr_commerc.tabsync('DPT_VIDD_EXTDESC');
  --exec mgr_commerc.tabsync('DPT_VIDD_TAGS');
  --exec mgr_commerc.tabsync('DPT_VIDD_PARAMS');
  --exec mgr_commerc.tabsync('DPT_VIDD_FIELD');
  --delete from DPT_VIDD_SCHEME@<<DB_LINK>>  where vidd is null; commit;
  --exec mgr_commerc.tabsync('DPT_VIDD_SCHEME');
  --exec mgr_commerc.fill_dpt_deposit;
  ----
  --Если в удаленной таблице cc_docs поле text имеет тип даных long raw
  --то нужно преоборазовать его в Clob
  /*
    whenever sqlerror exit
        create table tmp_cc_docs
        as
        select ID, ND, ADDS, VERSION, STATE, to_lob(text) text
          from cc_docs
        /
        whenever sqlerror continue
        alter table cc_docs drop column text
        /
        alter table cc_docs add text blob
        /
        whenever sqlerror exit
        update cc_docs d
           set text = (select text
                             from tmp_cc_docs
                            where id = d.id and nd=d.nd and adds=d.adds and version=d.version )
        /
        commit
        /
        whenever sqlerror continue
        drop table tmp_cc_docs
        /
        declare
        MAX_LEN   constant number := 2000;
        l_colType   varchar2(30);   --         Тип столбца
        l_pos       number;         --     Текущая позиция
        l_len       number;         -- Размер объекта BLOB
        l_blob      blob;           --  Значение поля BLOB
        l_clob      clob;           --  Значение поля CLOB
        l_blobPart  raw(2002);
        l_clobPart  varchar2(2002);
        begin
            select data_type into l_colType
              from user_tab_columns
             where table_name  = 'CC_DOCS'
               and column_name = 'TEXT';
            -- Выходим если столбец уже переконвертирован
            if (l_colType != 'BLOB') then
                return;
            end if;
            -- Переименовываем существующий и добавляем новый
            execute immediate 'alter table cc_docs rename column text to text_old';
            execute immediate 'alter table cc_docs add text clob';
            -- конвертируем
            for i in (select id, nd, adds, version
                        from cc_docs )
            loop
                -- Блокируем строку
                execute immediate 'select text_old' || chr(13) || chr(10) ||
                                  '  from cc_docs '  || chr(13) || chr(10) ||
                                  ' where id = :id and nd=:nd and adds=:adds and version = :version '|| chr(13) || chr(10) ||
                                  '   for update'
                into l_blob using i.id, i.nd, i.adds, i.version;
                if (l_blob is not null) then
                    execute immediate 'update cc_docs '             || chr(13) || chr(10) ||
                                      '   set text = empty_clob()' || chr(13) || chr(10) ||
                                      ' where id = :id and nd=:nd and adds=:adds and version = :version '
                    using i.id, i.nd, i.adds, i.version;
                    execute immediate 'select text'    || chr(13) || chr(10) ||
                                      '  from cc_docs ' || chr(13) || chr(10) ||
                                      ' where id = :id and nd=:nd and adds=:adds and version = :version '   || chr(13) || chr(10) ||
                                      '   for update'
                     into l_clob using i.id, i.nd, i.adds, i.version;
                     l_pos := 1;
                     l_len := dbms_lob.getlength(l_blob);
                     loop
                         if (l_pos + MAX_LEN >= l_len) then
                            l_blobPart := dbms_lob.substr(l_blob, l_len - l_pos + 1, l_pos);
                            l_pos := l_len;
                        else
                            l_blobPart := dbms_lob.substr(l_blob, MAX_LEN, l_pos);
                            l_pos := l_pos + MAX_LEN;
                        end if;
                        l_clobPart := utl_raw.cast_to_varchar2(l_blobPart);
                        dbms_lob.append(l_clob, l_clobPart);
                        exit when l_pos >= l_len;
                     end loop;
                     execute immediate 'update cc_docs '         || chr(13) || chr(10) ||
                                       '   set text = :lobdata' || chr(13) || chr(10) ||
                                       ' where id = :id and nd=:nd and adds=:adds and version = :version '
                     using l_clob, i.id, i.nd, i.adds, i.version;
                     commit;
                end if;
            end loop;
            execute immediate 'alter table cc_docs drop column text_old';
        end;
        /
  */
  ----
  -- только потом импортим таблицу cc_docs
  --
  --exec mgr_commerc.fill_cc_docs;
  --exec mgr_commerc.fill_dpt_deposit_clos;
  --
  ----
  ----
  -- Очиска КП
  ----
  --exec mgr_commerc.clean('cc_lim');
  --exec mgr_commerc.clean('nd_txt');
  --exec mgr_commerc.clean('nd_txt_update');
  --exec mgr_commerc.clean('cc_sob');
  --exec mgr_commerc.clean('cc_sob_update');
  --exec mgr_commerc.clean('cc_accp');
  --exec mgr_commerc.clean('nd_acc');
  --exec mgr_commerc.clean('cc_prol');
  --exec mgr_commerc.clean('cc_many');
  --exec mgr_commerc.clean('cc_add');
  --exec mgr_commerc.clean('cc_deal');
  ----
  ----
  -- Заливка КП
  ----
  --alter table cc_deal modify constraint R_CC_ID_SDATE_CCDEAL disable;
  --drop index R_CC_ID_SDATE_CCDEAL;
  --alter table cc_deal modify constraint CC_CCDEAL_PROD_NN disable;
  --exec mgr_commerc.tabsync('cc_deal');
  --exec mgr_commerc.tabsync('cc_aim');
  --exec mgr_commerc.tabsync('cc_add');
  --exec mgr_commerc.tabsync('cc_many');
  --exec mgr_commerc.tabsync('cc_prol');
  --exec mgr_commerc.tabsync('nd_acc');
  --exec mgr_commerc.tabsync('cc_accp');
  --exec mgr_commerc.tabsync('cc_sob');
  --exec mgr_commerc.tabsync('nd_txt');
  --exec mgr_commerc.tabsync('cc_lim');
  ----
  --
  --
  --
  --
  ----
  --ГОУ Ощадбанк(тест)
  --
    --                   exec mgr_commerc.tabsync('STAFF_CLASS');
    --                   exec mgr_commerc.fill_staff;
    --                   exec mgr_commerc.tabsync('APPLIST');
    --                   exec mgr_commerc.fill_operlist;
    --                   exec mgr_commerc.tabsync('OPERLIST_DEPS');
    --                   exec mgr_commerc.tabsync('OPERAPP');
    --                   exec mgr_commerc.tabsync('APPLIST_STAFF');
    --                   exec mgr_commerc.tabsync('CHKLIST');
    --                   exec mgr_commerc.tabsync('FOLDERS');
    --                   exec mgr_commerc.tabsync('OP_FIELD');
    --                   exec mgr_commerc.fill_vob;
    --                   exec mgr_commerc.fill_tabval;
    --                   alter table tts modify constraint CC_TTS_NLSM_CC disable;
    --                   alter table tts modify constraint CC_TTS_S7201_NULL disable;
    --                   alter table tts modify constraint CC_TTS_S6201_NULL disable;
    --                   alter table tts modify constraint CC_TTS_FLR disable;
    --                   exec mgr_commerc.tabsync('STAFF_TTS');
    --                   exec mgr_commerc.tabsync('GROUPS');
    --                   exec mgr_commerc.tabsync('GROUPS_STAFF');
    --                   exec mgr_commerc.create_role;
    --                   exec mgr_commerc.adjust_role_grants;
    --                   exec mgr_commerc.vaxta;
    --                   exec mgr_commerc.fill_fdat;
    --                   exec mgr_commerc.fill_params;
    --                   exec mgr_commerc.fill_meta_tables;
    --                   exec mgr_commerc.fill_dyn_filter;
    --                   exec mgr_commerc.fill_meta_columns;
    --                   exec mgr_commerc.fill_meta_sortorder
    --                   exec mgr_commerc.fill_meta_extrnval;
    --                   exec mgr_commerc.fill_meta_browsetbl;
    --                   exec mgr_commerc.fill_meta_filtercodes;
    --                   exec mgr_commerc.fill_meta_filtertbl;
    --                   exec mgr_commerc.fill_references;
    --                   exec mgr_commerc.fill_meta_actiontbl;
    --                   exec mgr_commerc.fill_dbf_sync_tabs;
    --                   exec mgr_commerc.fill_refapp;
    --                   exec mgr_commerc.fill_zapros;
    --                   exec mgr_commerc.fill_reports;
    --                   exec mgr_commerc.fill_zapros;
    --                   exec mgr_commerc.tabsync('APP_REP');
    --                   exec mgr_commerc.tabsync('SW_BANKS');

    ---///
    /*exec mgr_commerc.tabsync('CUST_ZAY')
     exec mgr_commerc.tabsync('ZAY_AIMS')
     exec mgr_commerc.tabsync('ZAY_BACK')
     exec mgr_commerc.tabsync('ZAY_BAL')
     exec mgr_commerc.tabsync('ZAY_BAOP')
     exec mgr_commerc.tabsync('ZAY_COMISS')
     exec mgr_commerc.tabsync('ZAY_DEBT')
     exec mgr_commerc.tabsync('ZAY_DEBT_KLB')
     exec mgr_commerc.tabsync('ZAY_PF')
     exec mgr_commerc.tabsync('ZAY_PRIORITY')
     exec mgr_commerc.tabsync('ZAYAVKA')
    --
    insert
      into ZAYAVKA (RNK, DK, ACC0, ACC1, FDAT, S2, KURS_Z, KURS_F, MFOP, NLSP, SOS, KV2, KOM, SKOM, VDATE, REF, MFO0, NLS0, OKPOP, OKPO0, CONTRACT, DAT_VMD, DAT2_VMD, VIZA, META, DAT5_VMD, RNK_PF, PRIORITY, COUNTRY, BASIS, ID, FNAMEKB, IDENTKB, IDBACK, PID, TIPKB, DATEDOKKB, ND, DATT, OBZ, DATZ, FL_PF, FL_KURSZ, BENEFCOUNTRY, BANK_CODE, BANK_NAME, S3, LIM, ISP, TOBO, PRODUCT_GROUP, NUM_VMD)
    select z.RNK, z.DK, z.ACC0, z.ACC1, z.FDAT, z.S2, z.KURS_Z, z.KURS_F, z.MFOP, z.NLSP, z.SOS,
    z.KV2, z.KOM, z.SKOM, z.VDATE, z.REF, z.MFO0, z.NLS0, z.OKPOP, z.OKPO0,
    z.CONTRACT, z.DAT_VMD, z.DAT2_VMD, z.VIZA, z.META, z.DAT5_VMD, z.RNK_PF,
    z.PRIORITY, z.COUNTRY, z.BASIS, z.ID, z.FNAMEKB, z.IDENTKB, z.IDBACK, z.PID,
    z.TIPKB, z.DATEDOKKB, z.ND, z.DATT, z.OBZ, z.DATZ, z.FL_PF,
    z.FL_KURSZ, z.BENEFCOUNTRY, z.BANK_CODE, z.BANK_NAME, z.S3, z.LIM, z.ISP, b.branch, z.PRODUCT_GROUP, z.NUM_VMD
      from ZAYAVKA@BARS11 z, branch b
      where z.tobo=b.tobo
      --
     exec mgr_commerc.tabsync('ZAY_QUEUE')

     exec bpa.disable_policies('ZAY_TRACK')
     exec mgr_commerc.tabsync('ZAY_TRACK')
     exec bpa.enable_policies('ZAY_TRACK')*/
    ---///
    --
  ----
  ----------------------------------------------------------------

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.00 05/04/2013';

  -- Название пакета
  G_PKG constant varchar2(30) := 'mgr_commerc';

  -- операция очистки таблиц
  C_OPERATION_CLEAN constant integer := 0;

  -- операция наполнения таблиц
  C_OPERATION_FILL  constant integer := 1;

  -- Код модуля для ошибок и сообщений
  MODCODE           constant varchar2(3) := 'ADM';
  PARAMV_SKIPLIC    constant varchar2(1)  := 'Y';
  PARAM_SKIPLIC     constant varchar2(8)  := '_SKIPLIC';

  C_TAB_LOCAL_RFC      constant varchar2(30) := 'LOCAL_RFC';
  C_TAB_LOCAL_KF       constant varchar2(30) := 'LOCAL_KF';      -- локальная с полем kf
  C_TAB_LOCAL_BRANCH   constant varchar2(30) := 'LOCAL_BRANCH';  -- локальная с полем branch
  C_TAB_GLOBAL         constant varchar2(30) := 'GLOBAL';
  C_TAB_MIXED          constant varchar2(30) := 'MIXED';

  --Имя  линка
  g_link    varchar2(64);

  --МФО банка
  g_glb_mfo varchar2(64);

  -- Флаг для before_fill
  g_operation integer;
  --
  g_tables varchar2(4000);
  --
  g_error_msg varchar2(4000);
  --
  ref_part_restriction exception;
  pragma exception_init(ref_part_restriction, -14650);
  --
  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header mgr_commerc '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body mgr_commerc '||G_BODY_VERSION;
  end body_version;

 ---
 -- Возвращает значение параметра
 --
  function get_param(
                 p_parname in params.par%type ) return params.val%type
    is
        l_res   params.val%type;   /* установленное значение */
    begin
        select val into l_res
          from params
         where par = p_parname;

        return l_res;
    exception
        when NO_DATA_FOUND then return null;
    end get_param;

  ---
  -- raise_error - выбрасывает ошибку, если переменная непустая
  --
  procedure raise_error
  is
  begin
    --
    logger.trace('raise_error()');
    --
    if g_error_msg is not null
    then
        raise_application_error(-20000, g_error_msg);
    end if;
    --
  end raise_error;

   ------------------------------------------------------------------
   -- PRINTF()
   --
   --     Процедура форматирования строки сообщения. Если в строку
   --     включены описания, то производится подстановка переданных
   --     аргументов в строку сообщения
   --
   --
    function printf(
        p_message  in varchar2,
        p_args     in logger.args     ) return varchar2
    is

    l_src     varchar2(4000);
    l_message varchar2(4000);
    l_argc    number;                      -- количество элементов массива
    l_argn    number           default 1;  -- текущий элемент массива
    l_pos     number           default 0;

    begin

        if (instr(p_message, '%') = 0 and instr(p_message, '\') = 0 )
        then
           return p_message;
        end if;

        --
        -- Получаем кол-во аргументов и строку для разбора
        --
        l_argc := p_args.count;
        l_src  := p_message;

        --
        -- Ищем и образатываем указатели на подстановку аргументов
        --

        loop

            --
            -- получаем первую позицию символа %s
            --
            l_pos := instr(l_src, '%s');

            --
            -- Выходим, если символа нет (0, null) или уже
            -- подставили все возможные аргументы
            --
            exit when (l_pos = 0 or l_pos is null or l_argn > l_argc);

            --
            -- Переносим часть до указателя и текущий аргумент
            -- в выходное сообщение
            --
            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || p_args(l_argn), 1, 4000);
            l_src     := substr(l_src, l_pos+2);
            l_argn    := l_argn + 1;

        end loop;

        -- Переносим полученный текст сообщения в исходное
        -- и начинаем поиск символов перевода строки
        --
        l_src     := substr(l_message || l_src, 1, 4000);
        l_message := null;

        --
        -- Ищем и обрабатываем указатели перевода строки
        --

        loop
            --
            -- получаем первую позицию символов \n
            --
            l_pos := instr(l_src, '\n');

            --
            -- Выходим, если символов нет (0, null)
            --
            exit when (l_pos = 0 or l_pos is null);

            l_message := substr(l_message || substr(l_src, 1, l_pos-1) || chr(10), 1, 4000);
            l_src := substr(l_src, l_pos+2);

        end loop;

        --
        -- Переносим оставшийся кусок исходного сообщения
        --
        l_message := substr(l_message || l_src, 1, 4000);

        return l_message;

    end printf;

   ---
   -- trace
   --
    procedure trace(
         p_msg  in  varchar2,
         p_arg1 in  varchar2  default null,
         p_arg2 in  varchar2  default null,
         p_arg3 in  varchar2  default null,
         p_arg4 in  varchar2  default null,
         p_arg5 in  varchar2  default null,
         p_arg6 in  varchar2  default null,
         p_arg7 in  varchar2  default null,
         p_arg8 in  varchar2  default null,
         p_arg9 in  varchar2  default null )
     is

     l_recid   number(38);
     l_msg     sec_audit.rec_message%type;
     l_object  varchar2(100);

     begin
          logger.trace(p_msg, p_arg1, p_arg2, p_arg3, p_arg4, p_arg5, p_arg6, p_arg7, p_arg8, p_arg9);

          -- обрабатываем параметры
          l_msg := printf(p_msg,logger.args(substr(p_arg1, 1, 2000),
                                     substr(p_arg2, 1, 2000),
                                     substr(p_arg3, 1, 2000),
                                     substr(p_arg4, 1, 2000),
                                     substr(p_arg5, 1, 2000),
                                     substr(p_arg6, 1, 2000),
                                     substr(p_arg7, 1, 2000),
                                     substr(p_arg8, 1, 2000),
                                     substr(p_arg9, 1, 2000) ));

          dbms_application_info.set_client_info(l_msg);

      end trace;

  ---
  -- get_errmsg - возвращает полный стек ошибки
  --
  function get_errmsg return varchar2
  is
  begin
    return dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace();
  end get_errmsg;


  ----
    -- reset_sequence - сбрасывает значение последовательности
    --
    procedure reset_sequence (seq_name in varchar2, startvalue in pls_integer)
    is
        cval   integer;
        inc_by varchar2(25);
    begin

      execute immediate 'ALTER SEQUENCE ' ||seq_name||' MINVALUE 0';

      execute immediate 'SELECT ' ||seq_name ||'.NEXTVAL FROM DUAL'
      into cval;

      cval := cval - startvalue + 1;
      if cval < 0 then
        inc_by := ' INCREMENT BY ';
        cval:= abs(cval);
      else
        inc_by := ' INCREMENT BY -';
      end if;

      if cval=0
      then
        return;
      end if;

      execute immediate 'ALTER SEQUENCE ' || seq_name || inc_by ||
      cval;

      execute immediate 'SELECT ' ||seq_name ||'.NEXTVAL FROM DUAL'
      into cval;

      execute immediate 'ALTER SEQUENCE ' || seq_name ||
      ' INCREMENT BY 1';

    end reset_sequence;



  ---
  -- disable_table_triggers
  --
  procedure disable_table_triggers(p_table in varchar2, p_exclude in varchar2 default null)
    is
        l_errors    boolean := false;
        l_stmt      varchar2(200);
    begin
        --
        logger.trace('disable_table_triggers(''%s'',%s)', p_table,
            case when p_exclude is not null then ''''||p_exclude||'''' else 'null' end
        );
        -- выключаем все триггера
        begin
            l_stmt := 'alter table '||p_table||' disable all triggers';
            logger.trace(l_stmt);
            execute immediate l_stmt;
        exception
            when others then
                l_errors := true;
                logger.error(get_errmsg());
        end;
        -- включаем триггера по списку p_exclude
        for c in (select upper(trim(token)) as trigger_name
                    from ( select regexp_substr(p_exclude,'[^,]+', 1, level) token
                             from dual
                          connect by regexp_substr(p_exclude, '[^,]+', 1, level) is not null
                         )
                   where upper(trim(token)) is not null
                 )
        loop
            begin
                l_stmt := 'alter trigger '||c.trigger_name||' enable';
                logger.trace(l_stmt);
                execute immediate l_stmt;
            exception
                when others then
                    l_errors := true;
                    logger.error(get_errmsg());
            end;
        end loop;
        if l_errors
        then
            raise_application_error(-20000, 'При выключении триггеров на таблице '||p_table||' возникли ошибки. См. журнал.');
        end if;
        --
        logger.trace('disable_table_triggers: finish point');
        --
    end disable_table_triggers;

    ----
    -- enable_table_triggers - включает все отключенные триггера на таблице p_table
    --
    procedure enable_table_triggers(p_table in varchar2)
    is
        l_errors    boolean := false;
        l_stmt      varchar2(200);
    begin
        --
        logger.trace('enable_table_triggers(''%s'')', p_table);
        --
        begin
            l_stmt := 'alter table '||p_table||' enable all triggers';
            logger.trace(l_stmt);
            execute immediate l_stmt;
        exception
            when others then
                l_errors := true;
                logger.error(get_errmsg());
        end;
        if l_errors
        then
            raise_application_error(-20000, 'При включении триггеров на таблице '||p_table||' возникли ошибки. См. журнал.');
        end if;
        --
        logger.trace('enable_table_triggers: finish point');
        --
    end enable_table_triggers;

  ---
  -- rebuild_unusable_indexes - перестраиваем неиспользуемые индексы на таблице
  --
  procedure rebuild_unusable_indexes(p_table varchar2)
  is
    l_stmt  varchar2(256);
  begin
    for c in (select *
                from user_indexes
               where table_owner='BARS'
                 and table_name=p_table
                 and status='UNUSABLE'
             )
    loop
        l_stmt := 'alter index '||c.index_name||' rebuild parallel';
        --
        trace(l_stmt);
        --
        execute immediate l_stmt;
        --
    end loop;
    --
  end rebuild_unusable_indexes;

  ---
    -- disable fk
    --
      procedure disable_foreign_keys(p_table in varchar2 default null)
      is
        l_stmt  varchar2(200);
      begin
        --
        logger.trace('disable_foreign_keys: start point');
        --
        for c in (select r.table_name, r.constraint_name
                    from user_constraints r, user_constraints p
                   where r.constraint_type = 'R'
                     and r.status = 'ENABLED'
                     and r.r_constraint_name = p.constraint_name
                     and p.table_name like case when p_table is null then '%' else upper(p_table) end
                  )
        loop
            begin
                l_stmt := 'alter table '||rpad(c.table_name,30)||' modify constraint '||rpad(c.constraint_name,30)||' disable';
                --
                logger.trace(l_stmt);
                --
                execute immediate l_stmt;
                --
            exception when ref_part_restriction then
                --
                logger.error(get_errmsg());
                --
            end;
        end loop;
        --
        logger.trace('disable_foreign_keys: finish point');
        --
      end disable_foreign_keys;

  ---
  -- clean_error - очищает переменную ошибки
  --
  procedure clean_error
  is
  begin
    --
    logger.trace('clean_error()');
    --
    g_error_msg := null;
    --
  end clean_error;

  ---
  -- save_error - сохраняет последнюю ошибку в переменную пакета
  --
  procedure save_error
  is
  begin
    --
    logger.trace('save_error()');
    --
    g_error_msg := substr(get_errmsg(),1,4000);
    --
    if g_error_msg=chr(10)
    then
        g_error_msg := null;
    else
        logger.error(g_error_msg);
    end if;
    --
  end save_error;

   ---
   -- Отключение тригеров на таблице
   --
  procedure before_fill(p_tables in varchar2)
  is
  begin
    --
    --
    if g_operation is not null
    then
        raise_application_error(-20000, 'Нарушена последовательность вызова служебных процедур.'
                             ||chr(10)||'Выполните SQL> exec mgr_commerc.finalize;');
    end if;
    --
    g_operation := C_OPERATION_FILL;
    g_tables    := p_tables;
    --
    clean_error();
    --
    for c in (select upper(trim(token)) atable
                from ( select regexp_substr(g_tables,'[^,]+', 1, level) token
                         from dual
                      connect by regexp_substr(g_tables, '[^,]+', 1, level) is not null
                     )
               where upper(trim(token)) is not null
             )
    loop
        disable_table_triggers (c.atable);
    end loop;
    --
  end before_fill;

  ----
  -- before_clean - выполняет предварительные действия со списком таблиц перед их очисткой
  --                отключает внешние ключи, триггера
  procedure before_clean(p_tables in varchar2)
  is
  begin
    --
    if g_operation is not null
    then
        raise_application_error(-20000, 'Нарушена последовательность вызова служебных процедур.'
                             ||chr(10)||'Выполните SQL> exec mgr_utl.finalize;');
    end if;
    --
    g_operation := C_OPERATION_CLEAN;
    g_tables    := p_tables;
    --
    clean_error();
    --
    for c in (select upper(trim(token)) atable
                from ( select regexp_substr(g_tables,'[^,]+', 1, level) token
                         from dual
                      connect by regexp_substr(g_tables, '[^,]+', 1, level) is not null
                     )
               where upper(trim(token)) is not null
             )
    loop
        disable_table_triggers (c.atable);
        disable_foreign_keys   (c.atable);
    end loop;
    --
  end before_clean;

  ---
  --finalize
  --
   procedure finalize
  is
  begin
    if g_operation is null
    then
        raise_application_error(-20000, 'Нарушена последовательность вызова служебных процедур.');
    end if;
    --
    for c in (select upper(trim(token)) atable
                from ( select regexp_substr(g_tables,'[^,]+', 1, level) token
                         from dual
                      connect by regexp_substr(g_tables, '[^,]+', 1, level) is not null
                     )
               where upper(trim(token)) is not null
             )
    loop
        if      g_operation = C_OPERATION_CLEAN
        then
            enable_table_triggers (c.atable);
            --
        elsif   g_operation = C_OPERATION_FILL
        then
            enable_table_triggers (c.atable);
        else
            raise_application_error(-20000, 'Неизвестный тип операции: '||to_char(g_operation));
        end if;
        --
        rebuild_unusable_indexes(c.atable);
        --
    end loop;
    --
    g_operation := null;
    g_tables    := null;
    --
    raise_error();
    --
  end finalize;


  ---
  -- инициализация
  --
  procedure init
  is
  begin
   begin
    -- DB-LINK
    execute immediate 'select ''@''||substr(val,1,250) from params where par=''MGR_LINK'''
           into g_link;
     --
        exception when no_data_found
                then raise_application_error(-20000, 'Не заполнен параметр "MGR_LINK" - название DB-link для миграции!');
     --
   end;

   begin
    --GLB-MFO
    execute immediate 'select substr(val,1,250) from params where par=''GLB-MFO'''
       into g_glb_mfo;
     --
        exception when no_data_found
                then raise_application_error(-20000, 'Не заполнен параметр "GLB-MFO"!');
     --

   end;

   end init;

  ---
  --Переход в МФО
  --
  procedure to_mfo
    is
  begin
   --
    bc.subst_mfo(g_glb_mfo);
   --
  end;

  ---
  -- Переход в корень
  --
  procedure to_root
    is
   begin
    --
     bc.set_context;
    --
   end;

  ---
  -- int_clean_table - очистка произвольной таблицы
  --
  procedure int_clean_table(p_table varchar2, p_table_type varchar2)
  is
    l_table varchar2(30) := upper(p_table);
    l_stmt  varchar2(4000);
  begin
      --
      init();
      --
      before_clean(l_table);
      --

      begin
          l_stmt := 'delete from '||l_table;
          --
          case
          when p_table_type = C_TAB_GLOBAL
          then
                null;
          when p_table_type = C_TAB_LOCAL_KF
          then
                l_stmt := l_stmt || ' where kf = sys_context(''bars_context'',''user_mfo'')';
          when p_table_type = C_TAB_LOCAL_RFC
            then
                    l_stmt := l_stmt || ' where rfc = sys_context(''bars_context'',''rfc'')';
                --
          when p_table_type = C_TAB_LOCAL_BRANCH
          then
                l_stmt := l_stmt || ' where sys_context(''bars_context'',''user_branch'')=''/'' and branch=''/'''
                ||' or sys_context(''bars_context'',''user_branch'')<>''/'' and branch like sys_context(''bars_context'',''user_mfo_mask'')';
                --
          when p_table_type = C_TAB_MIXED
          then
            -- чистим локальные данные
            l_stmt := l_stmt || ' where branch like ''/'||g_glb_mfo||'/%''';
            -- для головного банка чистим также глобальные данные

            -- Корень чистим тоже
            l_stmt := l_stmt || ' or branch=''/''';

          end case;
          --
          trace(l_stmt);
          --
          execute immediate l_stmt;
          --
          trace('удалено %s строк', to_char(sql%rowcount));
          --
          commit;
          --
      exception when others then
          rollback;
          save_error();
      end;
      --
      finalize();
      --
  end int_clean_table;

  ---
  -- get_table_type - возвращает тип таблицы: локальная/глобальная/смешанная
  --
  function get_table_type(p_table varchar2) return varchar2
  is
    l_table_type    varchar2(30);
    l_num           number;
    is_pk_contains_branch  boolean;
  begin
    --
    -- тип таблицы(локальная/глобальная/смешанная) определяем по наличию полей KF и BRANCH
    --
    begin
        -- ищем поле KF
        select 1
          into l_num
          from user_tab_columns
         where table_name=p_table
           and column_name ='KF'
           and rownum=1;
        -- тип таблицы - локальная с полем KF
        l_table_type := C_TAB_LOCAL_KF;
        --
    exception
        when no_data_found then
        begin
            select 1
          into l_num
          from user_tab_columns
         where table_name=p_table
           and column_name ='RFC'
           and rownum=1;
        -- тип таблицы - локальная с полем RFC
        l_table_type := C_TAB_LOCAL_RFC;
        exception when no_data_found then
            -- ищем поле BRANCH
            begin
                select 1
                  into l_num
                  from user_tab_columns
                 where table_name=p_table
                   and column_name='BRANCH'
                   and rownum=1;
                -- нашли, смотрим входит ли оно в первичный ключ
                begin
                    select 1
                      into l_num
                      from user_constraints p, user_cons_columns c
                     where p.table_name=p_table
                       and p.constraint_type='P'
                       and p.constraint_name=c.constraint_name
                       and c.column_name='BRANCH';
                    --
                    is_pk_contains_branch := true;
                    --
                exception when no_data_found then
                    --
                    is_pk_contains_branch := false;
                    --
                end;
                --
                if is_pk_contains_branch
                then
                    -- тип таблицы - локальная с полем BRANCH
                    l_table_type := C_TAB_LOCAL_BRANCH;
                else
                    -- тип таблицы - смешанная
                    l_table_type := C_TAB_MIXED;
                end if;
                --
            exception
                when no_data_found then
                    -- тип таблицы - глобальная
                    l_table_type := C_TAB_GLOBAL;
            end;

         end;
    end;
    --
    trace('get_table_type(''%s'')=>''%s''', p_table, l_table_type);
    --
    return l_table_type;
    --
  end get_table_type;

  ----
  -- clean - очистка произвольной таблицы
  --
  procedure clean(p_table varchar2)
  is
    l_table         varchar2(30) := upper(p_table);
    l_kf            varchar2(6);
    l_num           number;
    l_table_type    varchar2(30);
  begin
    --
    init();
    --
    l_table_type := get_table_type(l_table);
    --
    if l_table_type in (C_TAB_GLOBAL, C_TAB_MIXED)
    then
        l_kf := null;
    else
        l_kf := g_glb_mfo;
    end if;
    --
    trace('l_kf = ''%s''', nvl(l_kf, 'null'));
    --
    if l_kf is not null
    then
      logger.trace('to_mfo -->''%s''', l_kf);
      to_mfo();
    else
      logger.trace('to_root()');
      to_root();
    end if;

    int_clean_table(l_table, l_table_type);

    if l_kf is not null
    then
      logger.trace('to_root()');
      to_root();
    end if;

  exception when others
  then
    --
    rollback;
    logger.trace('to_root()');
    to_root();
    raise_application_error(-20000, get_errmsg());
    --
  end clean;


  ----
  -- sync_table - синхронизирует таблицу с данными по указанному SQL-выражению
  --
  procedure sync_table(p_table varchar2, p_stmt clob, p_delete boolean default false)
  is
    p       constant varchar2(62) := G_PKG||'.sync_table';
    l_table varchar2(30) := upper(p_table);
    l_stmt  varchar2(4000);
    l_kf    varchar2(6);
    l_num   number;
    l_table_type    varchar2(30);
  begin
    --
    trace('%s(''%s'', p_stmt): entry point', p, p_table);
    --
    init();
    --
    l_table_type := get_table_type(l_table);
    --
    if l_table_type in (C_TAB_GLOBAL, C_TAB_MIXED)
    then
        l_kf := null;
    else
        l_kf := g_glb_mfo;
    end if;
    --
    trace('l_kf = ''%s''', nvl(l_kf, 'null'));
    --
    if l_kf is not null
    then
      logger.trace('to_mfo-->''%s''', l_kf);
      to_mfo();
    else
      logger.trace('to_root()');
      to_root();
    end if;
    --
    -- очистка
    --
    if p_delete
    then
      int_clean_table(l_table, l_table_type);
    end if;
    --
    -- наполнение
    --
    before_fill(l_table);
    --
    begin
        --
        trace(chr(10)||p_stmt);
        --
        execute immediate p_stmt;
        --
        trace('вставлено %s строк', to_char(sql%rowcount));
        --
        commit;
        --

    exception when others then
        rollback;
        save_error();
    end;
    --
    if l_kf is not null
    then
      logger.trace('to_root()');
      to_root();
    end if;
    --
    finalize();
    --
    trace('%s: finish point', p);
    --
  end sync_table;

  ---
  -- sync_table_auto - синхронизирует таблицу с данными
  --
  procedure sync_table_auto(
    p_table varchar2,
    p_delete boolean default false,
    p_column_replace varchar2 default null
  )
  is
    p          constant varchar2(62) := G_PKG||'.sync_table_auto';
    l_table    varchar2(30) := upper(p_table);
    l_stmt     varchar2(4000);
    l_ins_cols varchar2(4000);
    l_sel_cols varchar2(4000);
    l_col      varchar2(256);
    l_kf       varchar2(6);
    l_include       boolean;
    l_tab_exists    number;
    l_tab_length    BINARY_INTEGER;
    l_array         DBMS_UTILITY.lname_array;
    type t_colrep is table of varchar2(4000) index by varchar2(30);
    l_colrep        t_colrep;
    l_index         pls_integer;
    l_column        varchar2(30);
    l_replace       varchar2(4000);
    l_nullable      varchar2(1);
    l_datadefault   varchar2(1024);
  begin
    --
    trace('%s(''%s'',%s): entry point', p, p_table, case when p_delete then 'true' else 'false' end);
    --
    init();
    --
    l_kf := g_glb_mfo;
    -- посмотрим существует ли исходная таблица
    begin

     execute immediate 'select 1  from all_tables'||g_link||'
         where  table_name='''||l_table||'''' into l_tab_exists;

        exception when no_data_found then   l_tab_exists := 0;
     --
    end;
    --
    if l_tab_exists=0
    then
        raise_application_error(-20000, 'Таблица '||l_table||g_link||' не существует. Импорт не выполняем.');
    end if;
    --
    -- обрабатываем p_column_replace
    --
    if p_column_replace is not null
    then
        dbms_utility.comma_to_table(
            list    => p_column_replace,
            tablen  => l_tab_length,
            tab     => l_array
        );
        l_index := 1;
        while l_index < l_tab_length
        loop
            l_column := upper(trim(l_array(l_index)));
            l_replace := trim(l_array(l_index+1));
            if l_replace like '"%"'
            then
                l_replace := substr(l_replace, 2, length(l_replace)-2);
            end if;
            l_colrep(l_column) := l_replace;
            trace('Колонка %s будет заменена на выражение %s', l_column, l_replace);
            l_index := l_index + 2;
        end loop;
    end if;
    --
    -- формируем sql-выражение для вставки
    -- список колонок с автозаменой
    for t in (select *
                from user_tab_columns
               where table_name=l_table
                 and column_name not in ('KF','BRANCH')
               order by column_id
             )
    loop
        --trace('обрыбатываем колонку '||t.column_name);
        -- ищем аналогичную колонку в исходной таблице kf<mfo>.table_name
        begin

            execute immediate 'select column_name, nullable from all_tab_columns'||g_link||'
                                  where table_name ='''||l_table||'''
                                    and column_name='''||t.column_name||''''
                                    into l_col, l_nullable;


           --
            l_include := true;
           --
         exception when no_data_found then
            -- колонку в исходной таблице не нашли, в списки колонок включать не будем
            l_include := false;
            --
            logger.warning('Колонка '||t.column_name||' не найдена в исходной таблице '||l_table||g_link);
            --

          --
        end;
        --
        if l_include
        then
            begin
                select c.column_name
                  into l_col
                  from user_cons_columns c, user_constraints s, user_constraints p
                 where c.table_name=l_table
                   and c.column_name=t.column_name
                   and c.owner=s.owner
                   and c.constraint_name=s.constraint_name
                   and s.constraint_type='R'
                   and s.r_owner=p.owner
                   and s.r_constraint_name=p.constraint_name
                   and p.constraint_type in ('P','U');
            exception
                when no_data_found then
                    l_col := t.column_name;
                    -- спец.обработка поля STMT типа NUMBER: его тоже перекодируем
                    if t.column_name='STMT' and t.data_type='NUMBER'
                    then
                        l_col := t.column_name;
                    end if;
            end;
            --
            if t.nullable='N' and l_nullable='Y' and t.data_default is not null
            then
                trace('подмена not null колонки %s', t.column_name);
                l_datadefault := t.data_default;
                l_col := 'nvl2('||t.column_name||', '||l_col||', '||l_datadefault||')';
                trace('l_col = %s', l_col);
            end if;
            --
            l_ins_cols := l_ins_cols || case when l_ins_cols is null then null else ', ' end || t.column_name;
            -- подменяем колонку, если просят
            if l_colrep.exists(l_col)
            then
                trace('подменяем колонку %s на выражение %s', l_col, l_colrep(l_col));
                l_col := l_colrep(l_col);
            end if;
            --
            l_sel_cols := l_sel_cols || case when l_sel_cols is null then null else ', ' end || l_col;
            --
        end if;
        --
    end loop;
    --
    l_stmt :=   'insert/*+ append */ '||chr(10)
              ||'  into '||l_table||' ('||l_ins_cols||')'||chr(10)
              ||'select '||l_sel_cols||chr(10)
              ||'  from '||l_table||g_link;
    --
    --trace(l_stmt);
    -- зовем младшего брата
    sync_table(l_table, l_stmt, p_delete);
    --
    trace('%s: finish point', p);
    --
  end sync_table_auto;

  ----
  -- tabsync - вызов sync_table_auto(p_table, true)
  --
  procedure tabsync(p_table varchar2)
  is
  begin
    sync_table_auto(p_table, true);
  end tabsync;

  ---
  -- Удаление пользователей
  --

  procedure drop_user_novalidate(
       p_userid    in  staff$base.id%type )
    is

    l_usrlogname staff$base.logname%type;    /*       имя учетной записи в БД */
    l_cnt        number;                     /*       признак налич. таблицы  */
    l_skiplic    params.val%type;            /* парам.: не вып. пересчет лиц. */

    begin
        bars_audit.trace('useradm.usrdrp: entry point par[0]=>%s', to_char(p_userid));

        -- получаем имя учетной записи
        begin
            select logname into l_usrlogname
              from staff$base
             where id = p_userid;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'USER_NOT_FOUND', to_char(p_userid));
        end;

        -- Проверяем чтобы не удалили наши схемы
        if (l_usrlogname in ('BARS', 'HIST', 'FINMON')) then
            bars_error.raise_nerror(MODCODE, 'CANT_DELETE_SPECIAL_USER', l_usrlogname);
        end if;

        -- Если отклоняем запрос на создание
        delete from staff_storage
         where id = p_userid;

        begin
            execute immediate 'drop user "' || l_usrlogname || '" cascade';
            bars_audit.trace('useradm.rmusr: user account in db removed.');
        exception
            when OTHERS then
                if (sqlcode = -1918) then
                    bars_audit.trace('useradm.rmusr: user account in db already removed');
                else raise;
                end if;
        end;

        -- устанавливаем признак удаления
        update staff$base
           set active = 0
         where id = p_userid;
        bars_audit.trace('useradm.rmusr: user state is set (deleted).');

        bars_lic.set_user_license(l_usrlogname);
        bars_audit.trace('useradm.rmusr: user license revoked.');
        commit;

        bars_audit.security(bars_msg.get_msg(MODCODE, 'USER_ACCOUNT_DELETED', l_usrlogname));

        --
        -- выполняем обновление лицензионной инф. пользователей
        -- (в это время временные учетные записи могут стать постоянными)
        --
        l_skiplic := get_param(PARAM_SKIPLIC);

        if (l_skiplic is not null and l_skiplic = PARAMV_SKIPLIC) then
            bars_audit.trace('useradm.rmusr: skip lic rvld.');
        else
            bars_audit.trace('useradm.rmusr: revalidate usr lics ...');
-- NONONO   bars_lic.revalidate_lic;
            bars_audit.trace('useradm.rmusr: revalidate usr lics completed.');
        end if;

        bars_audit.trace('useradm.rmusr: succ end');

    end drop_user_novalidate;

     ----
  -- mantain_error_table - создает/очищает таблицу ошибок err$_<p_table>
  --
  procedure mantain_error_table(p_table in varchar2)
  is
      p constant varchar2(61) := G_PKG||'.'||'manerrtab';
      l_table       varchar2(30) := upper(p_table);
      l_errtable    varchar2(30) := 'ERR$_'||substr(l_table,1,25);
      l_num         number;
  begin
      --
      logger.trace('%s: start', p);
      --
      begin
        select 1
          into l_num
          from user_tables
         where table_name=l_errtable;
        --
        execute immediate 'truncate table '||l_errtable;
        logger.trace('%s: table %s truncated', p, l_errtable);
      exception
        when no_data_found then
            dbms_errlog.create_error_log(l_table);
            logger.trace('%s: table %s created', p, l_errtable);
      end;
      --
      logger.trace('%s: finish', p);
      --
  end mantain_error_table;

  ----
  -- get_errinfo - возвращает описание типовых ошибок в таблице err$_*
  --
  function get_errinfo(p_errtable in varchar2)
  return varchar2
  is
    l_errinfo varchar2(1000);
    l_errnums   dbms_sql.number_table;
    l_errmsgs   dbms_sql.varchar2_table;
    l_cnts      dbms_sql.number_table;
  begin
    execute immediate
    'select *
       from (select ora_err_number$, ora_err_mesg$, count(*) cnt
               from '||p_errtable||'
              group by rollup((ora_err_number$, ora_err_mesg$))
              order by 3 desc, 1 desc
            )
      where rownum <= 4'
    bulk collect into l_errnums, l_errmsgs, l_cnts;
    --
    for i in 1..l_cnts.count
    loop
        --
        l_errinfo := l_errinfo || chr(10) ||
        case
        when l_errnums(i) is null then 'Всего ошибок: '||lpad(to_char(l_cnts(i)),5)
        else 'ORA-'||lpad(to_char(l_errnums(i)),5,'0')||': '||substr(l_errmsgs(i),1,50)
           ||'    '||lpad(to_char(l_cnts(i)),5)
        end
        ;
    end loop;
    --
    return l_errinfo;
    --
  end get_errinfo;

  ----
  -- adjust_role_grants - выдает недостающие роли пользователям
  --
  procedure adjust_role_grants
  is
  begin
    for c in
    (-- роли, которые должны быть выданы
        select unique grantee, granted_role
        from
        (
        select logname as grantee, rolename as granted_role
        from staff$base s, applist_staff ss, operapp p, operlist f
        where s.id=ss.id
          and ss.codeapp=p.codeapp
          and p.codeoper=f.codeoper
          and f.rolename is not null
        union all
        select s.logname as grantee, r.role2edit as granted_role
        from staff$base s, applist_staff ss, refapp p, references r
        where s.id=ss.id
          and ss.codeapp=p.codeapp
          and p.tabid=r.tabid
          and r.role2edit is not null
        )
        minus
        -- реально выданные роли
        select unique p.grantee, p.granted_role
        from all_users u, DBA_ROLE_PRIVS p, staff$base s
        where u.username=p.grantee
          and u.username=s.logname
  )
  loop
   begin
      execute immediate 'grant '||c.granted_role||' to '||c.grantee;
      exception when others then null;
    end;
  end loop;
  --
  end adjust_role_grants;

   procedure vaxta
    is
        l_stmt clob;
   begin
    --
        init();
    --
        l_stmt:=
        'begin
            for k in(
                     select s.id, nvl(k.bax,0) bax from staff$base s, staff'||g_link||' k
                        where upper(s.logname)=upper(nvl(k.logname,''UNDEFINED''))
                          and upper(s.logname) not in (''BARS'', ''HIST'', ''FINMON''))
             loop
                 update staff$base
                    set bax=k.bax
                    where id=k.id;
             end loop;
            commit;
        end;';
    --
        execute immediate l_stmt;
    --

   end;


  ---
  -- fill_params - заполняет таблицу params$base
  --
  procedure fill_params
  is
    p   constant varchar2(62) := G_PKG||'.fill_params';
    l_cnt   number;
  begin
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_fill('params$base, params$global');
    --
    begin

        --
        execute immediate
        'insert
           into params$base(par, val, comm, kf)
         select par, val, comm, :g_glb_mfo
           from params'||g_link||'
          where par not in (select par
                              from params$global
                            union all
                           select par
                              from params$base
                           )'
        using g_glb_mfo;

        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_params;


  ---
  -- fill_fdat - заполняет fdat
  --
    procedure fill_fdat
  is
    p   constant varchar2(62) := G_PKG||'.fill_fdat';
  begin
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('fdat');
    --
    begin
        -- наполняем
        execute immediate
        'insert
          into fdat (fdat, stat, kf)
        select fdat, stat, :g_glb_mfo
          from fdat'||g_link
        using g_glb_mfo;
        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
        to_root();
    --
        finalize();
    --
    trace('%s: finished', p);
    --
  end fill_fdat;

  ---
  -- Импорт пользователей
  --
  procedure fill_staff
  is
    p   constant varchar2(62) := G_PKG||'.fill_staff';
    l_staff     staff$base%rowtype;
    l_max_id    staff$base.id%type;
    type t_staff_row is record(
      id           number,
      fio          varchar2(60),
      logname      varchar2(30),
      type         integer,
      tabn         varchar2(10),
      bax          number(1),
      tbax         date,
      disable      number(1),
      adate1       date,
      adate2       date,
      rdate1       date,
      rdate2       date,
      clsid        number,
      blk          char(1),
      tblk         date,
      kf           varchar2(6),
      tobo         varchar2(12),
      countconn    integer,
      countpass    integer,
      web_profile  varchar2(30),
      profile      varchar2(30),
      approve      number(1),
      usearc       number(1),
      cschema      varchar2(30)
    );
    c           t_staff_row;
    l_cursor    sys_refcursor;
    l_web_profile   varchar2(30);
  begin
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('staff$base');
    --
    begin
        -- поле WEB_PROFILE есть не у всех, обрабатываем эту ситуацию
        begin
            select column_name
              into l_web_profile
              from all_tab_columns
             where owner=g_glb_mfo
               and table_name='STAFF'
               and column_name='WEB_PROFILE';
        exception
            when no_data_found then
                l_web_profile := '''DEFAULT_PROFILE''';
        end;
        open l_cursor for
        'select  id,
                          fio,
                          nvl(logname,''UNDEFINED'') as logname,
                          type,
                          tabn,
                          bax,
                          tbax,
                          disable,
                          adate1,
                          adate2,
                          rdate1,
                          rdate2,
                          clsid,
                          blk,
                          tblk,
                          kf,
                          tobo,
                          countconn,
                          countpass,
                          '||l_web_profile||',
                          null profile,
                          approve,
                          usearc,
                          cschema
                    from staff'||g_link||'
                   where id>0
                     and nvl(logname,''UNDEFINED'') not in (''DUMMY'',''BARS'',''RS_DUMP'',''JBOSS_USR'',''QOWNER'', ''FINMON'', ''BARSAQ'', ''TEST'')
                     and upper(logname) not in
                                   (select upper(logname)
                                      from staff$base
                                   )
                     and id not in(select id from staff$base)
                   order by id';

        --
        while true
        loop
            fetch l_cursor into c;
            exit when l_cursor%notfound;
            -- id and logname
            l_staff.id      := c.id;
            l_staff.logname := c.logname;
            -- branch
            select branch
              into l_staff.branch
              from branch
             where tobo = nvl(c.tobo, '0');
            --
            l_staff.fio         := c.fio;
            l_staff.tabn        := rpad(substr(trim(c.tabn),1,6),6,'0');
            l_staff.clsid       := nvl(c.clsid,0);
            l_staff.type        := nvl(c.type,0);
            l_staff.usearc      := c.usearc;
            l_staff.usegtw      := 0;
            l_staff.web_profile := 'DEFAULT_PROFILE';
            l_staff.profile     := null;
            -- создаем пользователя
            bars_useradm.create_user(
                p_usrfio      =>  l_staff.fio,
                p_usrtabn     =>  l_staff.tabn,
                p_usrtype     =>  l_staff.clsid,
                p_usraccown   =>  l_staff.type,
                p_usrbranch   =>  l_staff.branch,
                p_usrusearc   =>  l_staff.usearc,
                p_usrusegtw   =>  l_staff.usegtw,
                p_usrwprof    =>  l_staff.web_profile,
                p_reclogname  =>  l_staff.logname,
                p_recpasswd   =>  'qwerty',
                p_recappauth  =>  'APPSERVER',
                p_recprof     =>  null,
                p_recdefrole  =>  'BARS_CONNECT',
                p_recrsgrp    =>  null,
                p_usrid       =>  l_staff.id,
                p_gtwpasswd   =>  null,
                p_canselectbranch => null,
                p_chgpwd      =>  null,
                p_tipid       =>  null );
            --
            commit;
            --

        end loop;
        --
        close l_cursor;
        --
        --
        -- подстраиваем сиквенс под максимальное значение
        --
        select trunc(nvl(max(id),1)/100)+1
          into l_max_id
          from staff$base;
        --
        reset_sequence('S_STAFF', l_max_id);
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_staff;

  ---
  -- clean_staff - удаление пользователей
  --
  procedure clean_staff
  is
    p   constant varchar2(62) := G_PKG||'.clean_staff';
    x               SYS_REFCURSOR;
    TYPE imp_rec IS RECORD(id number(38));
    c imp_rec;
  begin
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_clean('staff$base');
    --
    begin
        open x for 'select id from staff$base
                   where upper(logname) in(select upper(logname) from staff'||g_link||')
                   and upper(logname)not in (''DUMMY'',''BARS'',''RS_DUMP'',''JBOSS_USR'',''QOWNER'', ''FINMON'', ''BARSAQ'')';
        loop
         FETCH x into c;
          EXIT WHEN x%NOTFOUND;
            drop_user_novalidate(c.id);
        end loop;

        bars_lic.revalidate_lic;
        --
        execute immediate 'delete
          from staff$base
          where upper(logname) in(select upper(logname) from staff'||g_link||')
          and upper(logname)not in (''DUMMY'',''BARS'',''RS_DUMP'',''JBOSS_USR'',''QOWNER'', ''FINMON'', ''BARSAQ'', ''TEST'')';
        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_staff;

  ---
  -- fill_operlist
  --
   procedure fill_operlist
  is
    p   constant varchar2(62) := G_PKG||'.fill_operlist';
    l_stmt  clob;

  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --

     l_stmt:=  'insert
          into bars.operlist (
               codeoper,
               name,
               dlgname,
               funcname,
               semantic,
               runable,
               parentid,
               rolename,
               frontend,
               usearc)
        select
               codeoper ,
               name,
               dlgname,
               funcname,
               semantic,
               runable,
               parentid,
               upper(rolename),
               frontend,
               usearc
        from operlist'||g_link||chr(10)||
      'where funcname is not null';

    begin

      execute immediate l_stmt;

     commit;
    --
       exception when others then
            rollback;
            save_error();
     --
     end;
    --
     trace('%s: finished', p);
    --

    --
  end fill_operlist;

  procedure clean_operlist
  is
    p           constant varchar2(62) := G_PKG||'.clean_operlist';

  begin
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_clean('operlist');
    --
    begin
        delete
          from operlist;
        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_operlist;


  ---
 -- sync fill_stmt
 --
  procedure fill_vob
    is
   l_stmt varchar2(4000);
   p   constant varchar2(62) := G_PKG||'.fill_vob';

   begin
    --
    trace('%s: entry point', p);
    --
     init();
    --
    begin
    --
     l_stmt:='insert into vob(vob, name, flv, REP_PREFIX, OVRD4IPMT)
                                    select vob, nvl(name,''EMPTY''), nvl(flv,1), REP_PREFIX,
                                    case when OVRD4IPMT=''Y'' then ''Y'' when  OVRD4IPMT=''N'' then ''N'' else null end
                                    from vob'||g_link;
    --
        execute immediate l_stmt;
    --
       commit;
    --
       exception when others then
            rollback;
            save_error();
     --
     end;
    --
     trace('%s: finished', p);
    --
   end fill_vob;

   ---
   -- fill_tts
   --

   procedure fill_tts
  is
    l_inscnt    number;
  begin
    trace('fill_tts start');
    --
    mantain_error_table('TTS');
    mantain_error_table('CHKLIST_TTS');
    mantain_error_table('FOLDERS_TTS');
    mantain_error_table('OP_RULES');
    mantain_error_table('PS_TTS');
    mantain_error_table('TTSAP');
    mantain_error_table('TTS_VOB');
    --
    init();
    --
    to_root();
    --
    -- TTS
    --
    execute immediate
   'insert
      into bars.tts (
           tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr,
           s, s2, sk, proc, s3800, s6201, s7201, rang, flags, nazn)
    select tt, substr(:g_glb_mfo||'' - ''||name,1,70), dk, nlsm, kv, nlsk, kvk, nlss,
           nlsa, nlsb, mfob, nvl(flc,0), nvl(fli,0), nvl(flv,0), nvl(flr,0),
           s, s2, sk, proc, s3800, s6201, s7201, rang, flags, nazn
      from tts'||g_link||' t
    log errors reject limit unlimited'
    using g_glb_mfo;
    --
    l_inscnt := sql%rowcount;
    --
    trace('TTS: %s строк вставлено %s', to_char(l_inscnt), get_errinfo('err$_tts'));
    --
    commit;
    --

    --
    -- CHKLIST_TTS
    --
    execute immediate
    'insert
       into bars.chklist_tts(
            tt, idchk, priority, f_big_amount, sqlval, f_in_charge, flags)
     select tt, idchk, nvl(priority,1), f_big_amount, sqlval, f_in_charge, flags
       from chklist_tts'||g_link||' t
      log errors reject limit unlimited';
    --
    l_inscnt := sql%rowcount;
    --
    trace('CHKLIST_TTS: %s строк вставлено %s',
        to_char(l_inscnt), get_errinfo('err$_chklist_tts')
    );
    --
    commit;

    --
    -- FOLDERS_TTS
    --
    execute immediate
    'insert
       into bars.folders_tts(idfo, tt)
     select idfo, tt
       from folders_tts'||g_link||' t
      log errors reject limit unlimited';
    --
    l_inscnt := sql%rowcount;
    --
    trace('FOLDERS_TTS: %s строк вставлено %s',
        to_char(l_inscnt), get_errinfo('err$_folders_tts')
    );
    --
    commit;
    --
    -- OP_RULES
    --
    execute immediate
    'insert
       into bars.op_rules(tt, tag, opt, used4input, ord, val, nomodify)
     select tt, tag, nvl(opt,''O''), nvl(used4input,0), ord, val, null as nomodify
       from op_rules'||g_link||' t
      log errors reject limit unlimited';
    --
    l_inscnt := sql%rowcount;
    --
    trace('OP_RULES: %s строк вставлено %s',
        to_char(l_inscnt), get_errinfo('err$_op_rules')
    );
    --
    commit;
    --
    --
    -- PS_TTS
    --
    execute immediate
    'insert
       into bars.ps_tts(tt, nbs, dk)
     select tt, nbs, dk
       from ps_tts'||g_link||' t
      log errors reject limit unlimited';
    --
    l_inscnt := sql%rowcount;
    --
    trace('PS_TTS: %s строк вставлено %s',
        to_char(l_inscnt), get_errinfo('err$_ps_tts')
    );
    --
    commit;

    --
    -- TTSAP
    --
    execute immediate
    'insert
       into bars.ttsap(tt, ttap, dk)
     select tt, ttap, dk
       from ttsap'||g_link||' t
      log errors reject limit unlimited';
     --
    l_inscnt := sql%rowcount;
    --
    trace('TTSAP: %s строк вставлено %s',
        to_char(l_inscnt), get_errinfo('err$_ttsap')
    );
    --
    commit;

    --
    -- TTS_VOB
    --
    execute immediate
    'insert
       into bars.tts_vob(tt, vob, ord)
     select tt, vob, ord
       from tts_vob'||g_link||' t
      log errors reject limit unlimited';

    --
    l_inscnt := sql%rowcount;
    --
    trace('TTS_VOB: %s строк вставлено %s',
        to_char(l_inscnt), get_errinfo('err$_tts_vob')
    );
    --
    commit;

    to_root();
    --
    trace('fill_tts finish');
    --
  end fill_tts;

  ---
  --Очистка клиентов
  --
  procedure clean_tts
  is
    p           constant varchar2(62) := G_PKG||'.clean_tts';

  begin
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_clean('tts, chklist_tts, folders_tts, op_rules, ps_tts, ttsap, tts_vob');
    --
    begin
        delete
          from tts_vob;
        --
        delete
          from ttsap;
        --
        delete
          from ps_tts;
        --
        delete
          from op_rules;
        --
        delete
          from folders_tts;
        --
        delete
          from chklist_tts;
        --
        delete
          from tts;
        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    to_root();
    --
    finalize();
    --

    trace('%s: finished', p);
    --
  end clean_tts;


 ---
 -- sync fill_stmt
 --
  procedure fill_stmt
    is
   l_stmt varchar2(4000);
   p   constant varchar2(62) := G_PKG||'.fill_stmt';

   begin
    --
    trace('%s: entry point', p);
    --
     init();
    --
    begin
    --
     l_stmt:='insert into stmt(stmt, freq, name) select stmt, freq, name from stmt'||g_link||' where stmt not in(select stmt from stmt)';
    --
        execute immediate l_stmt;
    --
       commit;
    --
       exception when others then
            rollback;
            save_error();
     --
     end;
    --
     trace('%s: finished', p);
    --
   end fill_stmt;

   ---
   -- sync prinsider
   --
   procedure fill_prinsider
    is
    l_stmt varchar2(4000);
    p  constant varchar2(62) := G_PKG||'.fill_prinsider';
    begin
    --
    trace('%s: entry point', p);
    --
     init();
    --
     begin
     --
     l_stmt:='insert into prinsider (prinsider, prinsiderlv1, name)
                select prinsider, prinsiderlv1, name from prinsider'||g_link||
                ' where prinsider not in(select prinsider from prinsider)';
    --
        execute immediate l_stmt;
    --
       commit;
    --
       exception when others then
            rollback;
            save_error();
     --
     end;
    --
     trace('%s: finished', p);
    --
    end fill_prinsider;

   ---
   -- sync sed
   --
   procedure fill_sed
    is
    l_stmt varchar2(4000);
    p  constant varchar2(62) := G_PKG||'.fill_sed';
    begin
    --
    trace('%s: entry point', p);
    --
     init();
    --
     begin

     l_stmt:='insert into sed (sed, name, d_close)
              select sed, name, d_close from sed'||g_link||
              ' where sed not in(select sed from sed)';
    --
        execute immediate l_stmt;
    --
       commit;
    --
       exception when others then
            rollback;
            save_error();

     end;
    --
     trace('%s: finished', p);
    --
    end fill_sed;

   ---
  -- sync customer_field
  --
  procedure fill_customer_field
    is
     l_stmt varchar2(4000);
     p  constant varchar2(62) := G_PKG||'.fill_customer_field';
     l_parid number;
   begin
    --
    trace('%s: entry point', p);
    --
     init();
    --
     before_fill('customer_field');
    --
     begin

     l_stmt:='insert into customer_field(tag, name, b,u,f,tabname, byisp, type, opt, code, not_to_edit)
        select tag, name, b,u,f,tabname, byisp, type, opt, code, not_to_edit from customer_field'||g_link||
        ' where tag not in(select tag from customer_field)';
    --
        execute immediate l_stmt;
    --
       commit;
    --
       exception when others then
            rollback;
            save_error();

     end;
    --
     finalize();
    --
     trace('%s: finished', p);
    --
   end fill_customer_field;

  ----
  -- fill_customers - импорт клиентов
  --
  procedure fill_customers
  is
    p   constant varchar2(62) := G_PKG||'.fill_customers';

    l_new_rnk   integer;
    l_max_rnk   integer;
    l_new_rnkp  integer;
    l_branch    branch.branch%type;
    l_isp       customer.isp%type;
    l_iter      integer := 0;
    l_old_rnk   integer;
    l_cursor    sys_refcursor;
    l_c_reg     number;
    l_c_dst     number;
    type t_customer_row is record(
      rnk        number,
      tgr        number,
      custtype   number,
      country    number,
      nmk        varchar2(70),
      nmkv       varchar2(70),
      nmkk       varchar2(38),
      codcagent  number,
      prinsider  number,
      okpo       varchar2(14),
      adr        varchar2(70),
      sab        char(4),
      c_reg      number,
      c_dst      number,
      rgtax      varchar2(30),
      datet      date,
      adm        varchar2(70 ),
      datea      date,
      stmt       number,
      date_on    date,
      date_off   date,
      notes      varchar2(140),
      notesec    varchar2(256),
      crisk      number,
      pincode    varchar2(10),
      nd         varchar2(10),
      rnkp       number,
      ise        char(5),
      fs         char(2),
      oe         char(5),
      ved        char(5),
      sed        char(4),
      mb         char(1),
      lim        number(38),
      rgadm      varchar2(30),
      bc         number,
      tobo       varchar2(12),
      isp        number,
      taxf       varchar2(12),
      nompdv     varchar2(9),
      k050        varchar2(3) 
    );
    c   t_customer_row;
    type t_rnkp_row is record(
        rnk     number,
        rnkp    number
    );
    r   t_rnkp_row;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('customer, customerw, customer_update, customerw_update, custbank, corps, person');
    --
    begin
        open l_cursor for
        'select   rnk,
                  tgr,
                  custtype,
                  country,
                  nmk,
                  nmkv,
                  nmkk,
                  codcagent,
                  prinsider,
                  okpo,
                  adr,
                  sab,
                  c_reg,
                  c_dst,
                  rgtax,
                  datet,
                  adm,
                  datea,
                  stmt,
                  date_on,
                  date_off,
                  notes,
                  notesec,
                  crisk,
                  pincode,
                  nd,
                  rnkp,
                  ise,
                  fs,
                  oe,
                  ved,
                  sed,
                  mb,
                  lim,
                  rgadm,
                  bc,
                  tobo,
                  isp,
                  taxf,
                  nompdv,k050
           from customer'||g_link||' order by rnk';
        while true
        loop
            fetch l_cursor into c;
            exit when l_cursor%notfound;
            --
            l_iter := l_iter + 1;
            trace('%s: iteration %s', p, to_char(l_iter));

            l_new_rnk := c.rnk;
            --
            if l_new_rnk is null
            then
                raise_application_error(-20000, 'new_rnk is null');
            end if;
            -- маппим бранч
            begin
             select branch into  l_branch from branch where tobo=nvl(c.tobo, '0');
                exception when no_data_found
                                    then l_branch:='/'||g_glb_mfo||'/';
            end;
/*
            begin
              select c_reg, c_dst into l_c_reg, l_c_dst
                     from customer where rnk=l_new_rnk and (c_reg, c_dst) in (select c_reg, c_dst from spr_reg);
               exception when no_data_found then
                              l_c_reg:=-1;
                              l_c_dst:=-1;
            end;
*/
            -- маппим код исполнителя
            if c.isp is not null
            then
                l_isp := c.isp;
            else
                l_isp := null;
            end if;
            --
            insert
              into customer (
                   rnk,
                   tgr,
                   custtype,
                   country,
                   nmk,
                   nmkv,
                   nmkk,
                   codcagent,
                   prinsider,
                   okpo,
                   adr,
                   sab,
                   c_reg,
                   c_dst,
                   rgtax,
                   datet,
                   adm,
                   datea,
                   stmt,
                   date_on,
                   date_off,
                   notes,
                   notesec,
                   crisk,
                   pincode,
                   nd,
                   rnkp,
                   ise,
                   fs,
                   oe,
                   ved,
                   sed,
                   lim,
                   mb,
                   rgadm,
                   bc,
                   branch,
                   tobo,
                   isp,
                   taxf,
                   nompdv,
                   k050)
            values (
                   l_new_rnk,
                   c.tgr,
                   c.custtype,
                   c.country,
                   c.nmk,
                   c.nmkv,
                   c.nmkk,
                   c.codcagent,
                   c.prinsider,
                   c.okpo,
                   c.adr,
                   c.sab,
                   c.c_reg,
                   c.c_dst,
                   c.rgtax,
                   c.datet,
                   c.adm,
                   c.datea,
                   c.stmt,
                   nvl(c.date_on, to_date('01.01.1970','dd.mm.yyyy')),
                   c.date_off,
                   c.notes,
                   c.notesec,
                   c.crisk,
                   c.pincode,
                   c.nd,
                   null, --rnkp
                   c.ise,
                   c.fs,
                   c.oe,
                   c.ved,
                   c.sed,
                   c.lim,
                   c.mb,
                   c.rgadm,
                   c.bc,
                   l_branch,
                   l_branch,
                   l_isp,
                   c.taxf,
                   c.nompdv,
                   c.k050
            );

            -- в зависимости от типа клиента заполняем соотв. таблицы физлиц, юрлиц ии банков
            if c.custtype = 1 or c.custtype is null-- Банк
            then
                execute immediate
                '
                insert
                  into custbank (
                       rnk,
                       mfo,
                       alt_bic,
                       bic,
                       rating,
                       kod_b,
                       dat_nd,
                       ruk,
                       telr,
                       buh,
                       telb
                       )
                select :l_new_rnk,
                       mfo,
                       alt_bic,
                       bic,
                       rating,
                       kod_b,
                       null,
                       ruk,
                       telr,
                       buh,
                       telb
                  from custbank'||g_link||'
                 where rnk = :crnk ' 
                 /*where rnk = :crnk and mfo in (select mfo from banks)' */
               using l_new_rnk, c.rnk;
                --
            elsif c.custtype = 2 -- Юрлицо
            then
                execute immediate
                '
                insert
                  into corps (
                       rnk,
                       nmku,
                       ruk,
                       telr,
                       buh,
                       telb,
                       dov,
                       bdov,
                       edov,
                       nlsnew,
                       mainnls,
                       mainmfo,
                       mfonew,
                       tel_fax,
                       e_mail,
                       seal_id,
                       nmk)
                select :l_new_rnk,
                       nmku,
                       ruk,
                       telr,
                       buh,
                       telb,
                       null, --dov,
                       null, --bdov,
                       null, --edov,
                       null, --nlsnew,
                       null, --mainnls,
                       null, --mainmfo,
                       null, --mfonew,
                       tel_fax,
                       e_mail,
                       null,
                       null
                  from corps'||g_link||'
                 where rnk = :crnk'
                using l_new_rnk, c.rnk;
                --
            elsif c.custtype = 3 -- Физлицо
            then
                execute immediate
                '
                insert
                  into person (
                       rnk,
                       sex,
                       passp,
                       ser,
                       numdoc,
                       pdate,
                       organ,
                       bday,
                       bplace,
                       teld,
                       telw,
                       dov,
                       bdov,
                       edov)
                select :l_new_rnk,
                       sex,
                       passp,
                       ser,
                       numdoc,
                       case when pdate<=bday then bday+(16*65) else pdate end,
                       organ,
                       bday,
                       bplace,
                       teld,
                       telw,
                       dov,
                       bdov,
                       edov
                  from person'||g_link||'
                 where rnk = :crnk'
                using l_new_rnk, c.rnk;
                --
            else
                raise_application_error(-20000, 'Неизвестный тип клиента');
            end if;

        end loop;
        --
        -- пишем доп.реквизиты
          execute immediate
            '
            insert
              into customerw(rnk, tag, isp, value)
            select rnk, tag, isp, value
              from customerw'||g_link;
        --
        close l_cursor;

        l_new_rnk := null;
        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    --
    -- подстраиваем сиквенс под максимальное значение
    --
    select trunc(nvl(max(rnk),1)/100)+1
      into l_max_rnk
      from customer;
    --
    reset_sequence('S_CUSTOMER', l_max_rnk);
    --
    trace('%s: finished', p);
    --
  end fill_customers;

  ---
  --Очистка клиентов
  --
  procedure clean_customers
  is
    p           constant varchar2(62) := G_PKG||'.clean_customers';
    l_max_rnk   integer;
  begin
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('customer, customerw, customer_update, customerw_update, custbank, corps, person');
    --
    begin
        delete
          from custbank;
        --
        delete
          from corps;
        --
        delete
          from person;
        --
        delete
          from customerw;
        --
        delete
          from customer;
        --
        delete
          from customerw_update;
        --
        delete
          from customer_update;
        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
        --
        -- подстраиваем сиквенс под максимальное значение
        --
        select trunc(nvl(max(rnk),1)/100)+1
          into l_max_rnk
          from customer;
        --
        reset_sequence('S_CUSTOMER', l_max_rnk);

    trace('%s: finished', p);
    --
  end clean_customers;

  ----
  -- sync_tabval$local - синхронизирует таблицу tabval$local
  --
  procedure fill_tabval
  is
    p   constant varchar2(62) := G_PKG||'.fill_tabval';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_fill('tabval$local, tabval$global');
    --
    begin

        execute immediate
        '
        insert
          into tabval$global (kv, grp, name, lcv, nominal, sv, dig, unit,  gender, d_close, denom)
        select kv, grp, name, lcv, nominal, sv, dig, unit, gender, d_close, denom
          from tabval'||g_link||' where kv not in(select kv from tabval$global)';

        execute immediate
        '
        insert
          into tabval$local (
               kf, kv, skv,
               s0000, s3800, s3801,
               s3802, s6201, s7201,
               s9282, s9280, s9281,
               s0009, g0000)
        select :g_glb_mfo, kv, skv,
               s0000, s3800, s3801,
               s3802, s6201, s7201,
               s9282, s9280, s9281,
               s0009, null
          from tabval'||g_link||' where kv not in(select kv from tabval$local)'
        using g_glb_mfo;
        --
        commit;
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_tabval;

  ---
  --
  --
   procedure fill_tips
    is
    l_stmt varchar2(4000);
    p  constant varchar2(62) := G_PKG||'.fill_tips';
    begin
    --
    trace('%s: entry point', p);
    --
     init();
    --
     begin

     before_fill('tips');

     l_stmt:='insert into tips (tip, name, ord)
              select tip, name, ord from tips'||g_link||
              ' where tip not in(select tip from tips)';
    --
        execute immediate l_stmt;
    --
       commit;
    --
       exception when others then
            rollback;
            save_error();

     end;
    --
    finalize;
    --
     trace('%s: finished', p);
    --
    end fill_tips;

  ---
  -- sync brates
  --
 procedure fill_brates
    is
     l_del  varchar2(4000);
     l_stmt varchar2(4000);
    p  constant varchar2(62) := G_PKG||'.fill_brates';
   begin
    --
    trace('%s: entry point', p);
    --
     init();
    --
    to_root();
    --
    before_fill('brates');
    --
    disable_foreign_keys('brates');
    --
    begin

    l_del :='delete from brates';

    l_stmt:='insert into brates(br_id, br_type, name, formula, inuse, comm)
                         select br_id, br_type, nvl(name, ''Empty''), formula, inuse, comm
                         from brates'||g_link;

    --
        execute immediate l_del;
    --
        execute immediate l_stmt;
    --
       commit;
    --
       exception when others then
            rollback;
            save_error();
    end;
    --
      finalize;
    --
     trace('%s: finished', p);
    --
   end;


  ---
  -- fill_accounts - импорт счетов
  --
  procedure fill_accounts
  is
    p               constant varchar2(62) := G_PKG||'.fill_accounts';
    l_iter          integer := 0;
    l_old_acc       accounts.acc%type;
    l_new_acc       accounts.acc%type;
    l_max_acc       accounts.acc%type;
    l_branch        accounts.branch%type;
    l_isp           accounts.isp%type;
    l_rnk           accounts.rnk%type;
    l_acc_cnt       number;
    --l_accs          dbms_sql.number_table;
    l_scn           number;
    l_txname        varchar2(256);
    l_txnames       sys.txname_array := sys.txname_array();
    l_txfix         boolean := false;
    l_errmsg        varchar2(4000);
    l_max_idupd     number;
    l_cnt           number;
    type t_rn is record (rn number, acc number);
    l_rn    t_rn;
    l_cursor    sys_refcursor;
    l_ins_idu       varchar2(60);
    l_sel_idu       varchar2(60);
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill(
        'int_ratn, int_accn, bic_acc, bank_acc, accountsw, accounts_all, accounts_update,'
      ||'specparam, specparam_update, specparam_int, accounts'
    );
    --
    begin
        -- кол-во импортируемых счетов
        execute immediate
        '
        select count(*)
          from accounts'||g_link
        into l_acc_cnt;
        --
        trace('l_acc_cnt=%s'||to_char(l_acc_cnt));
        --

        -- начинаем именованную транзакцию
        --
        trace('выполняем вставку в accounts');
        --
        --
        execute immediate
        '
        insert
          into accounts (  acc, kf, nls, kv, branch, nlsalt, nbs, nbs2, daos, dapp, isp, nms, lim,
                           ostb, ostc, ostf, ostq, dos, kos, dosq, kosq, pap, tip, vid, trcn, mdate, dazs, sec,
                           accc, blkd, blkk, pos, seci, seco, grp, ostx, rnk, notifier_ref, tobo, bdate, opt, ob22, dappq)
        select     a.acc as acc,     --  acc,
                   :g_glb_mfo as kf,    --  kf,
                   a.nls,         --  nls,
                   case when substr(a.nls,1,1) in (6,7) and a.kv is null then 280 else a.kv end,          --  kv(В ГОУ е рах 7 класу без валюти),
                   b.branch as branch,      --  branch,
                   a.nlsalt,      --  nlsalt,
                   a.nbs,         --  nbs,
                   a.nbs2,        --  nbs2,
                   a.daos,        --  daos,
                   a.dapp,        --  dapp,
                   nvl(a.isp,1) as isp,         --  isp,
                   nvl(a.nms,''NMS is NULL''),         --  nms,
                   nvl(a.lim,0) as lim,         --  lim,
                   a.ostb,        --  ostb,
                   a.ostc,        --  ostc,
                   a.ostf,        --  ostf,
                   a.ostq,        --  ostq,
                   a.dos,         --  dos,
                   a.kos,         --  kos,
                   a.dosq,        --  dosq,
                   a.kosq,        --  kosq,
                   a.pap,         --  pap,
                   a.tip,         --  tip,
                   a.vid,         --  vid,
                   nvl(a.trcn,0),        --  trcn,
                   a.mdate,       --  mdate,
                   a.dazs,        --  dazs,
                   null, --a.sec,         --  sec,
                   a.accc as accc,          --  accc,
                   nvl(a.blkd,0) as blkd,        --  blkd,
                   nvl(a.blkk,0) as blkk,        --  blkk,
                   a.pos,         --  pos,
                   a.seci,        --  seci,
                   a.seco,        --  seco,
                   a.grp,         --  grp,
                   a.ostx,        --  ostx,
                   nvl(a.rnk,1) as rnk,         --  rnk,
                   null as notifier_ref,          --  notifier_ref
                   b.branch as tobo,      --  tobo,
                   null as bdate,          --  bdate,
                   null as opt,          --  opt,
                   null as ob22,          --  ob22,
                   null as dappq          --  dappq
          from  accounts'||g_link||' a, branch b where nvl(a.tobo,''0'')=b.tobo(+) and acc not in(select acc from accounts) and acc>0
         order by a.acc'
        using g_glb_mfo;
        --
        trace('таблица accounts заполнена');
        --
        commit;
        --
       -- trace('собираем статистику по accounts');
        --
        -- подстраиваем последовательность s_accounts_update
        to_root();
        --
        select nvl(max(acc),1)
          into l_max_idupd
          from accounts;
        --
        to_mfo();
        --
        trace('%s: sequence max(accounts.acc)=%s', p, to_char(l_max_idupd));
        --
        reset_sequence('s_accounts', l_max_idupd+1);
        --
        trace('%s: sequence S_ACCOUNTS adjusted', p);
        --
        trace('%s: filling accounts_update ...', p);
        --
        execute immediate
        '
        insert
          into accounts_update (
               idupd, acc, nls, nlsalt,
               kv,
                nbs, nbs2, daos, isp, nms, pap, vid, dazs, blkd, blkk,
               chgdate, chgaction, pos, tip, grp, seci, seco, doneby, lim, accc, tobo, branch, mdate, ostx, sec, rnk, kf)
        select  s_accounts_update.nextval, c.* from (
               select a.acc, a.nls, a.nlsalt, case when substr(a.nls,1,1) in (6,7) and a.kv is null then 280 else a.kv end, a.nbs, a.nbs2, b.daos, nvl(a.isp,1) as isp,
               nvl(a.nms,''Не задано''), a.pap, a.vid, a.dazs, a.blkd, a.blkk,
               a.chgdate, nvl(decode(a.chgaction,9,2,a.chgaction),2), case when a.pos=0 then null else a.pos end, a.tip, a.grp, a.seci, a.seco,
               --ruuser(nvl(a.doneby,''BARS'')) as doneby,
               nvl((select logname from staff$base where logname=a.doneby),''BARS'') as doneby,
               a.lim, b.accc as accc, b.branch as tobo, b.branch as branch, b.mdate, null, b.sec,
               b.rnk, :g_glb_mfo
          from accounts_update'||g_link||' a, accounts b
         where a.acc=b.acc order by a.idupd) c'
        using g_glb_mfo;
        --
        commit;
        --
       select nvl(max(idupd),1)
          into l_max_idupd
          from accounts_update;
        --
        to_mfo();
        --
        trace('%s: sequence max(accounts_update.idupd)=%s', p, to_char(l_max_idupd));
        --
        reset_sequence('s_accounts_update', l_max_idupd+1);
        --
        trace('%s: sequence S_ACCOUNTS_update adjusted', p);
        --
        trace('%s: filling BANK_ACC table', p);
        --
        execute immediate
        '
        insert
          into bank_acc( acc, mfo)
        select  acc, mfo
          from bank_acc'||g_link||'';
        --
        trace('%s: filling BIC_ACC table', p);
        --
        execute immediate
        '
        insert
          into bic_acc (bic, acc, transit, their_acc, kf)
        select bic, acc, transit, their_acc, :g_glb_mfo
          from bic_acc'||g_link
        using g_glb_mfo;
        --

        trace('%s: filling INT_ACCN table', p);
        --
        execute immediate
        '
        insert
          into int_accn (
               acc,
               id,
               metr,
               basem,
               basey,
               freq,
               stp_dat,
               acr_dat,
               apl_dat,
               tt,
               acra,
               acrb,
               s,
               ttb,
               kvb,
               nlsb,
               mfob,
               namb,
               nazn,
               io,
               idu,
               idr,
               kf,
               okpo)
        select b.acc,
               b.id,
               nvl(b.metr,0),
               b.basem,
               nvl(b.basey,0), -- 0=Факт/Факт
               nvl(b.freq,2),  -- 2=Вільне
               b.stp_dat,
               nvl(b.acr_dat,to_date(''01.01.1900'',''dd.mm.yyyy'')),
               b.apl_dat,
               nvl(b.tt,''%%1'') as tt,  -- TODO допустимо ли умолчательное значение %%1
               b.acra  as acra,
               b.acrb  as acrb,
               nvl(b.s,0),
               b.ttb as ttb,
               b.kvb,
               b.nlsb,
               b.mfob,
               b.namb,
               b.nazn,
               nvl(b.io,0),
               null as idu,
               null as idr, --idr,
               :g_glb_mfo,
               null --okpo
          from int_accn'||g_link||' b where nvl(kvb,840) in (select kv from tabval)'
        using g_glb_mfo;
        --
         trace('%s: filling INT_RATN table', p);
        --

        execute immediate
        '
        insert
          into int_ratn (
               acc,
               id,
               bdat,
               ir,
               br,
               op,
               idu,
               kf)
        select b.acc,
               b.id,
               b.bdat,
               b.ir,
               b.br,
               b.op,
               nvl(b.idu,1) as idu,
               :g_glb_mfo
          from int_ratn'||g_link||' b where (acc, id) in(select acc, id from int_accn)'
        using g_glb_mfo;
        --
        trace('%s: filling ACCOUNTSW table', p);
        --

            execute immediate
           'insert
              into accountsw (acc, tag, value, kf)
            select a.acc, a.tag, a.value, :g_glb_mfo
              from accountsw'||g_link||' a'
             using g_glb_mfo;

        --
        trace('%s: filling SPECPARAM table', p);
        --
        execute immediate
        '
        insert
          into specparam (
               acc, r011, r013, s080, s180, s181, s190, s200, s230, s240, d020, kekd, ktk, kvk, idg,
               ids, sps, kbk,  s120, s130, s250, nkd, s031, s182, istval, r014, k072, s090, kf, s270,
               s260, k150, r114, s280, s290, s370, d1#f9, nf#f9, z290, dp1)
        select a.acc, a.r011, a.r013, a.s080, a.s180, a.s181, a.s190, a.s200, a.s230, a.s240, a.d020, a.kekd, a.ktk,
               a.kvk, a.idg,  a.ids, a.sps, a.kbk, null as s120, null as s130, null as s250, null as nkd, null as s031,
               null as s182, null as istval, null as r014, a.k072, null as s090, :g_glb_mfo as kf, null as s270,
               null as s260, null as k150, null as r114, null as s280, null as s290, null as s370,
               null as d1#f9, null as nf#f9, null as z290, null as dp1
          from specparam'||g_link||' a'
        using g_glb_mfo;
        --
        commit;
        --
        trace('собираем статистику');
        --
        trace('%s: filling SPECPARAM_UPDATE table', p);
        --
        trace('подстраиваем сиквенс s_specparam_update под максимальное значение');
        --
        to_root();
        --
        select nvl(max(idupd),1)+1
          into l_max_idupd
          from specparam_update;
        --
        to_mfo();
        --
        trace('новое значение последовательности s_specparam_update: %s', to_char(l_max_idupd));
        --
        reset_sequence('s_specparam_update', l_max_idupd);
        --
        execute immediate
        '
        insert
          into specparam_update (
               acc, r011, r013, s080, s180, s181, s190, s200, s230, s240, d020, fdat, user_name, idupd, kf,
               s260, s270, r014, k072, z290, s250, s090, nkd, s031, k150, r114, s280, s290, s370
               )
        select a.acc, a.r011, a.r013, a.s080, a.s180, a.s181, a.s190, a.s200, a.s230, a.s240, a.d020, a.fdat,
               nvl((select upper(logname) from staff'||g_link||' where upper(logname)=upper(a.user_name)),''BARS'') as user_name,
               s_specparam_update.nextval, :g_glb_mfo as kf,
               null as s260, null as s270, null as r014, null as k072, null as z290, null as s250,
               null as s090, null as nkd, null as s031, null as k150, null as r114, null as s280, null as s290, null as s370
          from specparam_update'||g_link||' a, accounts'||g_link||' aa
         where a.acc=aa.acc'
        using g_glb_mfo;
        --
        commit;
        --
        trace('собираем статистику');
        --
        trace('%s: filling SPECPARAM_INT table', p);
        --
        -- TODO:
        --
        commit;
        --
        to_root();
        --
        trace('собираем статистику');
        --
        trace('подстраиваем сиквенс под максимальное значение');
        --
        select trunc(nvl(max(acc),1)/100)+1
          into l_max_acc
          from accounts;
        --
        reset_sequence('S_ACCOUNTS', l_max_acc);
        --
        trace('%s: sequence S_ACCOUNTS adjusted', p);
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
    end fill_accounts;

  ---
  -- clean_accounts - очистка счетов
  --
  procedure clean_accounts
  is
    p           constant varchar2(62) := G_PKG||'.clean_accounts';
    l_max_acc   integer;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    -- проверки
   to_mfo();
    --
    before_clean(
        'int_ratn, int_accn, bic_acc, bank_acc, accountsw, accounts_all, accounts_update,'
      ||'specparam, specparam_update, specparam_int, specparam_int_update, accounts'
    );
    --
    begin
        --
        trace('%s: deleting INT_RATN', p);
        --
        delete
          from int_ratn
         where kf = g_glb_mfo;
        --
        trace('%s: deleting INT_ACCN', p);
        --
        delete
          from int_accn
         where kf = g_glb_mfo;
        --
        trace('%s: deleting BIC_ACC', p);
        --
        delete
          from bic_acc
         where kf = g_glb_mfo;
        --
        trace('%s: deleting ACCOUNTSW', p);
        --
        delete
          from accountsw
         where kf = g_glb_mfo;
        --
        trace('%s: deleting ACCOUNTS_ALL', p);
        --
        delete
          from accounts_all
         where kf = g_glb_mfo;
        --
        trace('%s: deleting BANK_ACC', p);
        --
        delete
          from bank_acc;
        --
        trace('%s: deleting specparam', p);
        --
        delete
          from specparam
         where kf = g_glb_mfo;
        --
        trace('%s: deleting specparam_update', p);
        --
        delete
          from specparam_update
         where kf = g_glb_mfo;
        --
        trace('%s: deleting specparam_int', p);
        --
        delete
          from specparam_int
         where kf = g_glb_mfo;
        --
        trace('%s: deleting specparam_int_update', p);
        --
        delete
          from specparam_int_update
         where kf = g_glb_mfo;
        --
        --
        trace('%s: deleting ACCOUNTS', p);
        --
        delete
          from accounts
         where kf = g_glb_mfo;
        --
        trace('%s: deleting ACCOUNTS_UPDATE', p);
        --
        delete
          from accounts_update
         where kf = g_glb_mfo;
        --
        commit;
        --
        to_root();
        --
        -- подстраиваем сиквенс под максимальное значение
        --
        select nvl(max(acc),1)
          into l_max_acc
          from accounts;
        --
        reset_sequence('S_ACCOUNTS', l_max_acc);
        --
    exception when others then
        rollback;
        save_error();
    end;
    --
    bc.home;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_accounts;

  ---
  -- fill_saldoa - импорт оборотов
  --
  procedure fill_saldoa
  is
    p               constant varchar2(62) := G_PKG||'.fill_saldoa';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('saldoa');
    --
    begin
        --
        execute immediate
        '
        insert /*+ append */
          into saldoa (
               acc,
               fdat,
               pdat,
               ostf,
               dos,
               kos,
               trcn,
               ostq,
               dosq,
               kosq,
               kf )
        select to_number(s.acc),
               s.fdat,
               s.pdat,
               nvl(s.ostf,0),
               nvl(s.dos,0),
               nvl(s.kos,0),
               nvl(s.trcn,1),
               nvl(s.ostq,0),
               nvl(s.dosq,0),
               nvl(s.kosq,0),
               '''||g_glb_mfo||''' as kf
          from saldoa'||g_link||' s where acc>0';
         --
         commit;
         --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
    end fill_saldoa;

  ---
  -- Очистка оборотов
  --
  procedure clean_saldoa
  is
    p           constant varchar2(62) := G_PKG||'.clean_saldoa';
  begin
    --
    dbms_output.enable(1000000);
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('saldoa');
    --
    begin
        --
        trace('%s: deleting SALDOA', p);
        --
        delete
          from saldoa;
        --
        commit;
        --
    exception
        when others then
            rollback;
            --
            save_error();
            --
    end;
    --
    to_root;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_saldoa;

  ---
  -- fill_oper - импорт oper
  --
  procedure fill_oper
  is
    p               constant varchar2(62) := G_PKG||'.fill_oper';
    l_max_ref       integer;
    l_stmt          varchar2(4000);
    l_minref        number;
    l_trace         varchar2(4000) :='MGR.fill_oper: ';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('oper');
    --
    -- переводим отдельные ограничения целостности в отложенный режим
    --l_stmt := 'set constraint fk_oper_oper deferred';
    --trace(l_stmt);
    --execute immediate l_stmt;
    --
    begin

           trace(l_trace||'start to move ');

        --    execute immediate 'select min(ref) from  oper'||g_link||'  where pdat >= to_date(''01012012'',''ddmmyyyy'')' into l_minref;

        l_minref := 70166592;


            trace(l_trace||'start to unusable indexes on OPER');
            for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'OPER'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                              )
                        where constraint_type is null
                     ) loop
                execute immediate 'alter index '||c.index_name||' unusable';
            end loop;


            trace(l_trace||'start to transfer ');

             execute immediate '
            insert /*+ append */
              into oper(ref, deal_tag, tt, vob, nd, pdat, vdat, kv, dk, s, sq, sk,
                   datd, datp, nam_a, nlsa, mfoa, nam_b, nlsb, mfob, nazn,
                   d_rec, id_a, id_b, id_o, sign, sos, vp, chk, s2, kv2, kvq, refl,
                   prty, sq2, currvisagrp, nextvisagrp, ref_a, tobo, otm, signed, branch, userid, respid, kf,
                   bis, sos_tracker, next_visa_branches, sos_change_time)
            select
                   o.ref, o.deal_tag, o.tt, o.vob, o.nd, o.pdat, o.vdat, o.kv, o.dk, o.s, o.sq, o.sk,
                   o.datd, o.datp, o.nam_a, o.nlsa, o.mfoa, o.nam_b, o.nlsb, o.mfob, o.nazn,
                   o.d_rec, o.id_a, o.id_b, o.id_o, o.sign, o.sos, o.vp, o.chk, o.s2,
                   case when o.kv2=0 then null else o.kv2 end as kv2, o.kvq, nvl2(o.refl, to_number(o.refl), null) refl,
                   o.prty,
                   0,
                   o.currvisagrp, o.nextvisagrp, o.ref_a, b.branch as tobo, null as otm, o.signed,
                   b.branch as branch, decode(o.userid,null,null,1,1,to_number(o.userid)) as userid,
                   decode(o.respid,null,null,1,1,to_number(o.respid)) as respid, '''||g_glb_mfo||''' as kf,
                   o.bis, 0 as sos_tracker, null as next_visa_branches, o.pdat as sos_change_time
              from oper'||g_link||' o,  branch b
             where o.ref>= '||l_minref||' and
             o.pdat >= to_date(''01012012'',''ddmmyyyy'') and
             b.tobo(+) = nvl(o.tobo,''0'')';

            trace('MGR: transfer completed');
            --
            commit;
          /*
            -- наполняем данные
            execute immediate
            'declare
             i number :=0;
            begin
             for k in(select to_number(o.ref) ref, o.deal_tag, o.tt, o.vob, o.nd, o.pdat, o.vdat, o.kv, o.dk, o.s, o.sq, o.sk,
                   o.datd, o.datp, o.nam_a, o.nlsa, o.mfoa, o.nam_b, o.nlsb, o.mfob, o.nazn,
                   o.d_rec, o.id_a, o.id_b, o.id_o, o.sign, o.sos, o.vp, o.chk, o.s2,
                   case when o.kv2=0 then null else o.kv2 end as kv2, o.kvq, nvl2(o.refl, to_number(o.refl), null) refl,
                   o.prty,
                   --o.sq2,
                   o.currvisagrp, o.nextvisagrp, o.ref_a, b.branch as tobo, null as otm, o.signed,
                   b.branch as branch, decode(o.userid,null,null,1,1,to_number(o.userid)) as userid,
                   decode(o.respid,null,null,1,1,to_number(o.respid)) as respid, :g_glb_mfo as kf,
                   o.bis, 0 as sos_tracker, null as next_visa_branches, o.pdat as sos_change_time
              from oper'||g_link||' o, branch b
             where b.tobo(+) = nvl(o.tobo,''0'')
             and not exists (select 1 from oper where ref=o.ref)
             and o.ref>=70161957
             )

             loop

              insert
              into oper (
                   ref, deal_tag, tt, vob, nd, pdat, vdat, kv, dk, s, sq, sk,
                   datd, datp, nam_a, nlsa, mfoa, nam_b, nlsb, mfob, nazn,
                   d_rec, id_a, id_b, id_o, sign, sos, vp, chk, s2, kv2, kvq, refl,
                   prty, sq2, currvisagrp, nextvisagrp, ref_a, tobo, otm, signed, branch, userid, respid, kf,
                   bis, sos_tracker, next_visa_branches, sos_change_time)
              values(k.ref, k.deal_tag, k.tt, k.vob, k.nd, k.pdat, k.vdat, k.kv, k.dk, k.s, k.sq, k.sk,
                   k.datd, k.datp, k.nam_a, k.nlsa, k.mfoa, k.nam_b, k.nlsb, k.mfob, k.nazn,
                   k.d_rec, k.id_a, k.id_b, k.id_o, k.sign, k.sos, k.vp, k.chk, k.s2, k.kv2, k.kvq, k.refl,
                   k.prty,
                   0,
                   --k.sq2,
                   k.currvisagrp, k.nextvisagrp, k.ref_a, k.tobo, k.otm, k.signed, k.branch, k.userid, k.respid, k.kf,
                   k.bis, k.sos_tracker, k.next_visa_branches, k.sos_change_time);

                   i:=i+1;

                   if mod(i, 101) = 100
                    then commit;
                   end if;

                   DBMS_APPLICATION_INFO.SET_CLIENT_INFO(''Заімпортовано записів: ''||i);

              end loop;
            end;' using g_glb_mfo;


            --
            commit;
            --*/

            to_root();

        execute immediate ' select trunc(nvl(max(ref),0)/100)+1 from oper'||g_link into l_max_ref;
        trace(l_trace||'get max ref');
        --
        reset_sequence('S_OPER', l_max_ref);
        trace(l_trace||'sequence recreated');
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_oper;


  procedure fill_operN (p_name  varchar2)
  is
    p               constant varchar2(62) := G_PKG||'.fill_operN';
    l_maxref        number;
    l_stmt          varchar2(4000);
    l_minref        number;
    l_trace         varchar2(4000) :='MGR.fill_operN: ';
    i               number;
    l_cnt           number;
    l_prc           number;

  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    --Представляемся
    to_mfo();
    --
    -- Отключаем констрейнты
    before_fill('oper');
    --
    begin

      trace(l_trace||'start to move ');
      -- Берем предварительно вычитанные референсы по партициям
      select nvl2(refcommit_opr,refcommit_opr+1,rmin), rmax  into l_minref, l_maxref from imp_fill where pname = p_name;

      trace(l_trace||'start to unusable indexes on OPER');
      -- Дизейблим констрейнты
       /*for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'OPER'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                              )
                        where constraint_type is null
                     )
            loop
               begin
                execute immediate 'alter index '||c.index_name||' unusable';
               exception when others then
                  if sqlcode = -26026 then null; else raise; end if;
               end;
            end loop;*/

            trace(l_trace||'start to transfer OPER');

      -- Начинаем импорт
      i:= l_minref;
      while i < l_maxref
          loop
            i :=  least(i + 100000, l_maxref);
            execute immediate '
            insert /*+ append */
              into oper(ref, deal_tag, tt, vob, nd, pdat, vdat, kv, dk, s, sq, sk,
                   datd, datp, nam_a, nlsa, mfoa, nam_b, nlsb, mfob, nazn,
                   d_rec, id_a, id_b, id_o, sign, sos, vp, chk, s2, kv2, kvq, refl,
                   prty, sq2, currvisagrp, nextvisagrp, ref_a, tobo, otm, signed, branch, userid, respid, kf,
                   bis, sos_tracker, next_visa_branches, sos_change_time)
            select
                   o.ref, o.deal_tag, o.tt, o.vob, o.nd, o.pdat, o.vdat, o.kv, o.dk, o.s, o.sq, o.sk,
                   o.datd, o.datp, o.nam_a, o.nlsa, o.mfoa, o.nam_b, o.nlsb, o.mfob, o.nazn,
                   o.d_rec, o.id_a, o.id_b, o.id_o, o.sign, o.sos, o.vp, o.chk, o.s2,
                   case when o.kv2=0 then null else o.kv2 end as kv2, o.kvq, nvl2(o.refl, to_number(o.refl), null) refl,
                   o.prty,
                   0,
                   o.currvisagrp, o.nextvisagrp, o.ref_a, ''/300465/'' as tobo, null as otm, o.signed,
                   ''/300465/'' as branch, decode(o.userid,null,null,1,1,to_number(o.userid)) as userid,
                   decode(o.respid,null,null,1,1,to_number(o.respid)) as respid, '''||g_glb_mfo||''' as kf,
                   o.bis, 0 as sos_tracker, null as next_visa_branches, o.pdat as sos_change_time
              from oper'||g_link||' o
             where o.ref>= '||l_minref||' and o.ref< '||i||' and
             o.pdat >= to_date(''01012012'',''ddmmyyyy'')';
            --
            commit;
            update imp_fill set refcommit_opr = i where pname = p_name;
            l_cnt := i - l_minref;
            l_minref := i;
            select nvl(round((refcommit_opr - rmin)*100/((rmax-rmin)),2),0) into l_prc from imp_fill where pname = p_name;
            DBMS_APPLICATION_INFO.SET_CLIENT_INFO('Заімпортовано записів(oper): '||l_prc||'% до реф '||l_minref);
          end loop;

      trace('MGR: transfer completed');

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_operN;




  ---
  -- Очистка oper
  --
  procedure clean_oper
  is
    p           constant varchar2(62) := G_PKG||'.clean_oper';
  begin
    --
    dbms_output.enable(1000000);
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('oper');
    --
   -- execute immediate 'set constraint fk_oper_oper deferred';
    --
    begin
        --
        trace('%s: deleting OPER', p);
        --
        delete
          from oper where ref>=70161957; -- min ref to date 01/01/2012

        --
        commit;
        --
    exception
        when others then
            rollback;
            --
            save_error();
            --
    end;
    --
    to_root;
    --
   -- execute immediate 'set constraint fk_oper_oper immediate';
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_oper;

  ---
  -- fill_oper_part - импорт oper(если есть партиции)
  --
  procedure fill_oper_part
    is
   p               constant varchar2(62) := G_PKG||'.fill_oper_part';
    l_errmsg        varchar2(4000);
    l_min_pdat      date;
    l_max_pdat      date;
    l_exists        boolean;
    l_num           number;
    l_max_ref       integer;
    l_stmt          varchar2(4000);
    x               SYS_REFCURSOR;
    TYPE imp_rec IS RECORD(partition_name varchar2(120), partitioned varchar2(20), partition_position number,
              partition_stmt VARCHAR2(150));
   c imp_rec;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('oper');
    --
    begin
        --
        open x for 'select ''NONE'' as partition_name, partitioned, 0 as partition_position, null as partition_stmt
                    from all_tables'||g_link||'
                   where owner=''BARS''
                     and table_name=''OPER''
                     and partitioned=''NO''
                   union all
                  select partition_name, ''YES'' as partitioned, partition_position, ''partition(''||partition_name||'')'' as partition_stmt
                    from all_tab_partitions'||g_link||'
                   where table_owner=''BARS''
                     and table_name=''OPER''
                   order by partition_position asc';
      --
         loop
          FETCH x INTO c;
           EXIT WHEN x%NOTFOUND;
        -- проверяем наличие в OPER данных партиции
            execute immediate 'select min(pdat), max(pdat) from oper'||g_link||' '||c.partition_stmt into l_min_pdat, l_max_pdat;
            --
            l_exists := false;
            begin
                select 1
                  into l_num
                  from oper
                 where pdat between l_min_pdat and l_max_pdat
                   and rownum=1;
                --
                l_exists := true;
            exception
                when no_data_found then
                    null;
            end;
            --
            if l_exists
            then
                trace('Данные oper'||g_link||' '||c.partition_stmt||' уже импортированы в OPER, пропускаем');
                continue;
            end if;
            -- наполняем данные партиции
            execute immediate
            '
            insert
              into oper (
                   ref, deal_tag, tt, vob, nd, pdat, vdat, kv, dk, s, sq, sk,
                   datd, datp, nam_a, nlsa, mfoa, nam_b, nlsb, mfob, nazn,
                   d_rec, id_a, id_b, id_o, sign, sos, vp, chk, s2, kv2, kvq, refl,
                   prty, sq2, currvisagrp, nextvisagrp, ref_a, tobo, otm, signed, branch, userid, respid, kf,
                   bis, sos_tracker, next_visa_branches, sos_change_time)
            select to_number(o.ref) ref, o.deal_tag, ''МГР'' tt, o.vob, o.nd, o.pdat, o.vdat, o.kv, o.dk, o.s, o.sq, o.sk,
                   o.datd, o.datp, o.nam_a, o.nlsa, o.mfoa, o.nam_b, o.nlsb, o.mfob, o.nazn,
                   o.d_rec, o.id_a, o.id_b, o.id_o, o.sign, o.sos, o.vp, o.chk, o.s2,
                   case when o.kv2=0 then null else o.kv2 end as kv2, o.kvq, nvl2(o.refl, to_number(o.refl), null) refl,
                   o.prty, o.sq2, o.currvisagrp, o.nextvisagrp, o.ref_a, b.branch as tobo, null as otm, o.signed,
                   b.branch as branch, decode(o.userid,null,null,1,1,to_number(o.userid)) as userid,
                   decode(o.respid,null,null,1,1,to_number(o.respid)) as respid, :g_glb_mfo as kf,
                   o.bis, 0 as sos_tracker, null as next_visa_branches, o.pdat as sos_change_time
              from oper'||g_link||' '||c.partition_stmt||' o, branch b
             where b.tobo(+) = nvl(o.tobo,''0'')'  using g_glb_mfo;
            --
            commit;
            --
            trace('импортирована таблица/партиция %s', c.partition_stmt);
            --
        end loop;
        --
        to_root();
        --
        select trunc(nvl(max(ref),0)/100)+1
          into l_max_ref
          from oper;
        --
        reset_sequence('S_OPER', l_max_ref);
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
   end fill_oper_part;

 ---
 -- clean_oper_part
 --
 procedure clean_oper_part
  is
    p           constant varchar2(62) := G_PKG||'.clean_oper_part';
    l_stmt      varchar2(1024);
    x               SYS_REFCURSOR;
    TYPE imp_rec IS RECORD(partition_name varchar2(120));
   c imp_rec;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('oper');
    --
    begin
        --
        trace('%s: truncating OPER', p);
        --
        open x for  'select partition_name
                      from user_tab_partitions'||g_link||'
                     where table_name=''OPER''
                      order by partition_name desc';

        loop
         --
         FETCH x INTO c;
         --
           EXIT WHEN x%NOTFOUND;
         --
            l_stmt := 'alter table oper truncate partition '||c.partition_name||' update indexes';
         --
            trace(l_stmt);
         --
            execute immediate l_stmt;
            --
        end loop;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_oper_part;

 ---
 -- fill_operw
 --
   procedure fill_operw
  is
    p               constant varchar2(62) := G_PKG||'.fill_operw';
    l_stmt          varchar2(4000);

  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('operw');
    --

    --
    begin

            trace(p||'start to unusable indexes on OPERW');
            for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'OPERW'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                              )
                        where constraint_type is null
                     ) loop
                execute immediate 'alter index '||c.index_name||' unusable';
            end loop;


            trace(p||'start to transfer ');



            execute immediate '
            insert /*+ append */
              into operw(ref, tag, value, kf)
            select ref, tag, value, '''||g_glb_mfo||'''  from operw'||g_link||' o';

            trace('MGR: transfer completed');

            -- наполняем данные
          /*  execute immediate
            'declare
             i number :=0;
            begin
             for k in(select ref, tag, value from operw'||g_link||'
             )

             loop

             insert into operw (ref, tag, value, kf) values (k.ref, k.tag, k.value, :g_glb_mfo);

                   i:=i+1;

                   if mod(i, 1001) = 1000
                    then commit;
                   end if;

                   DBMS_APPLICATION_INFO.SET_CLIENT_INFO(''Заімпортовано записів(operw): ''||i);

              end loop;
            end;' using g_glb_mfo;
            */

            --
            commit;
            --
            to_root();
            --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_operw;

  procedure fill_operwN (p_name  varchar2)
  is
    p               constant varchar2(62) := G_PKG||'.fill_operwN';
    l_maxref        number;
    l_stmt          varchar2(4000);
    l_minref        number;
    l_trace         varchar2(4000) :='MGR.fill_operwN: ';
    i               number;
    l_cnt           number;
    l_prc           number;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    --Представляемся
    to_mfo();
    --
    -- Отключаем констрейнты
    before_fill('operw');
    --
    begin

      trace(l_trace||'start to move ');
      -- Берем предварительно вычитанные референсы по партициям
      select nvl2(refcommit_oprw,refcommit_oprw+1,rmin), rmax  into l_minref, l_maxref from imp_fill where pname = p_name;

      trace(l_trace||'start to unusable indexes on OPERW');
      -- Дизейблим констрейнты
       for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'OPERW'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                              )
                        where constraint_type is null
                     )
            loop
               begin
                execute immediate 'alter index '||c.index_name||' unusable';
               exception when others then
                  if sqlcode = -26026 then null; else raise; end if;
               end;
            end loop;

            trace(l_trace||'start to transfer OPER');

      -- Начинаем импорт
      i:= l_minref;
      while i < l_maxref
          loop
            i :=  least(i + 100000, l_maxref);
            execute immediate '
            insert /*+ append */
              into operw(ref, tag, value, kf)
            select ref, tag, value, '''||g_glb_mfo||'''  from operw'||g_link||' o
             where o.ref>= '||l_minref||' and o.ref< '||i||' ';
            --
            commit;
            update imp_fill set refcommit_oprw = i where pname = p_name;
            l_cnt := i - l_minref;
            l_minref := i;
            select nvl(round((refcommit_oprw - rmin)*100/((rmax-rmin)),2),0) into l_prc from imp_fill where pname = p_name;
            DBMS_APPLICATION_INFO.SET_CLIENT_INFO('Заімпортовано записів(operw): '||l_prc||'% до реф '||l_minref);
          end loop;

      trace('MGR: transfer completed');

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_operwN;

  ---
  -- Очистка operw
  --
  procedure clean_operw
  is
    p           constant varchar2(62) := G_PKG||'.clean_operw';
  begin
    --
    dbms_output.enable(1000000);
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('operw');
    --
   -- execute immediate 'set constraint fk_oper_oper deferred';
    --
    begin
        --
        trace('%s: deleting OPERW', p);
        --
        delete
          from operw;
        --
        commit;
        --
    exception
        when others then
            rollback;
            --
            save_error();
            --
    end;
    --
    to_root;
    --
   -- execute immediate 'set constraint fk_oper_oper immediate';
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_operw;

  ---
  -- Импорт opldok
  --
   procedure fill_opldok
  is
    p               constant varchar2(62) := G_PKG||'.fill_opldok';
    l_max_stmt      integer;
    l_stmt          varchar2(4000);
    l_minref        number;
    l_trace         varchar2(4000) :='MGR.fill_opldok: ';
  begin
    --
    trace(l_trace||'%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('opldok');
    --
    begin
            -- наполняем данные

/*            execute immediate
            'declare
             i number :=0;
            begin
             for k in(select to_number(o.ref) ref, o.tt, o.dk, to_number(o.acc) as acc, o.fdat, o.s, o.sq, o.txt,
                   to_number(o.stmt) stmt,
                   nvl(o.sos,1) as sos, null as otm from opldok'||g_link||' o
                   where not exists (select 1 from opldok where ref=o.ref and stmt=o.stmt and dk=o.dk)
                   and o.ref>=70161957
             )

             loop

             insert
              into opldok (
                       ref, tt, dk, acc, fdat, s, sq, txt, stmt, sos, kf, otm)
              values(k.ref,k.tt, k.dk, k.acc, k.fdat, k.s, k.sq, k.txt, k.stmt, k.sos, :g_glb_mfo, k.otm);

                   i:=i+1;

                   if mod(i, 101) = 100
                    then commit;
                   end if;

                   DBMS_APPLICATION_INFO.SET_CLIENT_INFO(''Заімпортовано записів: ''||i);

              end loop;
            end;' using g_glb_mfo;

             opldok

            */

            trace(l_trace||'start to move ');

            execute immediate 'select min(ref) from  opldok'||g_link||'  where fdat >= to_date(''01012012'',''ddmmyyyy'')' into l_minref;

            trace(l_trace||'start to unusable indexes on OPLDOK');
            for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'OPLDOK'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                              )
                        where constraint_type is null
                     ) loop
                execute immediate 'alter index '||c.index_name||' unusable';
            end loop;


            trace(l_trace||'start to transfer ');

            execute immediate '
            insert /*+ append */
              into opldok(ref, tt, dk, acc, fdat, s, sq, txt, stmt, sos, kf, otm)
            select ref, tt, dk, o.acc, o.fdat, o.s, o.sq, o.txt,
                   o.stmt,  nvl(o.sos,1) , '''||g_glb_mfo||''',otm  from opldok'||g_link||' o
             where o.ref>= '||l_minref||' and fdat >= to_date(''01012012'',''ddmmyyyy'')';

            trace('MGR: transfer completed');
            --
            commit;


            --
            to_root();

        -- подстраиваем последовательность S_STMT

        execute immediate ' select trunc(nvl(max(stmt),0)/100)+1 from opldok'||g_link into l_max_stmt;
        trace(l_trace||'get max stmt');
        --
        reset_sequence('S_STMT', l_max_stmt);
        trace(l_trace||'sequence recreated');
        --

        -- for c in (select index_name from user_indexes where table_name = 'OPLDOK') loop
        --     execute immediate 'alter index '||c.index_name||' usable';
        -- end loop;

        --for c in ( select partition_name from user_tab_partitions  t
        --            where table_name  = 'OPLDOK'
        --              and  (partition_name like '%2012%' or partition_name like '%2013%' or partition_name like '%2011_Q4%')
        --         ) loop
        --
        --      dbms_stats.gather_table_stats(ownname=> 'BARS',tabname=>'OPLDOK', partname=>c.partition_name);
        --end loop;



    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_opldok;


  procedure fill_opldokN (p_name  varchar2)
  is
    p               constant varchar2(62) := G_PKG||'.fill_opldokN';
    l_maxref        number;
    l_stmt          varchar2(4000);
    l_minref        number;
    l_trace         varchar2(4000) :='MGR.fill_opldokN: ';
    i               number;
    l_cnt           number;
    l_prc           number;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    --Представляемся
    to_mfo();
    --
    -- Отключаем констрейнты
    before_fill('opldok');
    --
    begin

      trace(l_trace||'start to move ');
      -- Берем предварительно вычитанные референсы по партициям
      select nvl2(refcommit_opl,refcommit_opl+1,rmin), rmax  into l_minref, l_maxref from imp_fill where pname = p_name;

      trace(l_trace||'start to unusable indexes on OPLDOK');
      -- Дизейблим констрейнты
       for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'OPLDOK'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                              )
                        where constraint_type is null
                     )
            loop
               begin
                execute immediate 'alter index '||c.index_name||' unusable';
               exception when others then
                  if sqlcode = -26026 then null; else raise; end if;
               end;
            end loop;

            trace(l_trace||'start to transfer OPLDOK');

      -- Начинаем импорт
      i:= l_minref;
      while i < l_maxref
          loop
            i :=  least(i + 100000, l_maxref);
            execute immediate '
            insert /*+ append */
              into opldok(ref, tt, dk, acc, fdat, s, sq, txt, stmt, sos, kf, otm)
            select ref, tt, dk, o.acc, o.fdat, o.s, o.sq, o.txt,
                   o.stmt,  nvl(o.sos,1) , '''||g_glb_mfo||''',otm  from opldok'||g_link||' o
             where o.ref>= '||l_minref||' and o.ref< '||i||' and fdat >= to_date(''01012012'',''ddmmyyyy'')';
            --
            commit;
            update imp_fill set refcommit_opl = i where pname = p_name;
            l_cnt := i - l_minref;
            l_minref := i;
            select nvl(round((refcommit_opl - rmin)*100/((rmax-rmin)),2),0) into l_prc from imp_fill where pname = p_name;
            DBMS_APPLICATION_INFO.SET_CLIENT_INFO('Заімпортовано записів(opldok): '||l_prc||'% до реф '||l_minref);
          end loop;

      trace('MGR: transfer completed');

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_opldokN;

  ---
  -- Очистка opldok
  --
  procedure clean_opldok
  is
    p           constant varchar2(62) := G_PKG||'.clean_opldok';
  begin
    --
    dbms_output.enable(1000000);
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('opldok');
    --

    begin
        --
        trace('%s: deleting OPLDOK', p);
        --
        delete
          from opldok where ref>=70161957;
        --
        commit;
        --
    exception
        when others then
            rollback;
            --
            save_error();
            --
    end;
    --
    to_root;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_opldok;

  ---
  -- fill_opldok_part - импорт opldok
  --
  procedure fill_opldok_part
  is
    p               constant varchar2(62) := G_PKG||'.fill_opldok_part';
    l_errmsg        varchar2(4000);
    l_min_fdat      date;
    l_max_fdat      date;
    l_exists        boolean;
    l_num           number;
    l_max_stmt      opldok.stmt%type;
    x               SYS_REFCURSOR;
    TYPE imp_rec IS RECORD(partition_name varchar2(120), partitioned varchar2(20), partition_position number,
              partition_stmt VARCHAR2(150));
   c imp_rec;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('opldok');
    --
    begin
        --
        open x for 'select ''NONE'' as partition_name, partitioned, 0 as partition_position, null as partition_stmt
                    from all_tables'||g_link||'
                   where owner=''BARS''
                     and table_name=''OPLDOK''
                     and partitioned=''NO''
                   union all
                  select partition_name, ''YES'' as partitioned, partition_position, ''partition(''||partition_name||'')'' as partition_stmt
                    from all_tab_partitions'||g_link||'
                   where table_owner=''BARS''
                     and table_name=''OPLDOK''
                   order by partition_position asc';

        loop
          FETCH x INTO c;
           EXIT WHEN x%NOTFOUND;
            -- проверяем наличие в OPLDOK данных партиции KF<>.OPLDOK
            execute immediate 'select min(fdat), max(fdat) from opldok'||g_link||' '||c.partition_stmt into l_min_fdat, l_max_fdat;
            --
            l_exists := false;
            begin
                select 1
                  into l_num
                  from opldok
                 where fdat between l_min_fdat and l_max_fdat
                   and rownum=1;
                --
                l_exists := true;
            exception
                when no_data_found then
                    null;
            end;
            --
            if l_exists
            then
                trace('Данные opldok'||g_link||' '||c.partition_stmt||' уже импортированы в OPLDOK, пропускаем');
                continue;
            end if;
            -- наполняем данные партиции
            execute immediate
            'insert
              into opldok (
                       ref, tt, dk, acc, fdat, s, sq, txt, stmt, sos, kf, otm)
              select to_number(o.ref) ref, ''МГР'' as tt, o.dk, to_number(o.acc) as acc, o.fdat, o.s, o.sq, o.txt,
                   to_number(o.stmt) stmt,
                   nvl(o.sos,1) as sos, :g_glb_mfo, null as otm from opldok'||g_link||' '||c.partition_stmt||' o' using g_glb_mfo;
            --
            commit;
            --
            trace('импортирована партиция %s', c.partition_name);
            --
        end loop;
        --
        to_root();
        -- подстраиваем последовательность S_STMT
        select trunc(nvl(max(stmt),0)/100)+1
          into l_max_stmt
          from opldok;
        --
        reset_sequence('S_STMT', l_max_stmt);
        --
     exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_opldok_part;

  ---
  -- clean_opldok_part - очистка opldok
  --
  procedure clean_opldok_part
  is
    p           constant varchar2(62) := G_PKG||'.clean_opldok_part';
    l_stmt      varchar2(1024);
    x               SYS_REFCURSOR;
    TYPE imp_rec IS RECORD(partition_name varchar2(120));
    c imp_rec;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    -- предварительные проверки
    to_mfo();
    --
    before_clean('opldok');
    --
    begin
        --
        trace('%s: deleting OPLDOK', p);
        --
        open x for  'select partition_name
                      from user_tab_partitions'||g_link||'
                     where table_name=''OPLDOK''
                       order by partition_name desc';
        loop
         --
          FETCH x INTO c;
         --
           EXIT WHEN x%NOTFOUND;

            --
            execute immediate 'alter table opldok truncate subpartition '||c.partition_name||' update indexes';
            --
            trace(l_stmt);
            --

        end loop;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_opldok_part;

  ---
  -- fill_oper_visa - импорт oper_visa
  --
  procedure fill_oper_visa
  is
    p               constant varchar2(62) := G_PKG||'.fill_oper_visa';
    l_max_sqnc      number;
    l_rows          number;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    select nvl(max(sqnc),0)
      into l_max_sqnc
      from oper_visa;
    --
    to_mfo();
    --
    before_fill('oper_visa');
    --
    begin
        trace('inserting into OPER_VISA');
        --
        execute immediate
        '
        insert /*+ append */
          into oper_visa (
               ref, dat, userid, groupid, status, sqnc,
               passive, keyid, sign, username, usertabn, groupname,
               f_in_charge, check_ts, check_code, check_msg, kf, passive_reasonid)
        select to_number(v.ref), v.dat, decode(v.userid,null,null,1,1,to_number(v.userid)),
               v.groupid, v.status, :l_max_sqnc+rownum,
               v.passive, v.keyid, v.sign,
               v.username,
               v.usertabn, v.groupname,
               v.f_in_charge, v.check_ts, v.check_code, v.check_msg, :g_glb_mfo, v.passive_reasonid
          from oper_visa'||g_link||' v where v.ref>=70161957 order by v.sqnc'
        using l_max_sqnc, g_glb_mfo;
        --
        l_rows := sql%rowcount;
        --
        trace('%s rows inserted', to_char(l_rows));
        --
        commit;
        --
        reset_sequence('S_VISA', l_max_sqnc+l_rows+1);
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_oper_visa;

  ---
  -- Очистка oper_visa
  --
  procedure clean_oper_visa
  is
    p           constant varchar2(62) := G_PKG||'.clean_oper_visa';
  begin
    --
    dbms_output.enable(1000000);
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('oper_visa');
    --

    begin
        --
        trace('%s: deleting oper_visa', p);
        --
        delete
          from oper_visa where ref>=70161957;
        --
        commit;
        --
    exception
        when others then
            rollback;
            --
            save_error();
            --
    end;
    --
    to_root;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_oper_visa;

  ---
  -- Импорт REF_QUE
  --
  procedure fill_ref_que
  is
    p               constant varchar2(62) := G_PKG||'.fill_ref_que';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('ref_que');
    --
    begin
        trace('inserting into ref_que');
        --
        execute immediate
        '
        insert
          into ref_que(ref, fmcheck, kf, otm)
        select to_number(ref), null, :g_glb_mfo, otm
          from ref_que'||g_link
        using g_glb_mfo;
        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_ref_que;

  ---
  -- clean_ref_que - очистка ref_que
  --
    procedure clean_ref_que
  is
    p           constant varchar2(62) := G_PKG||'.clean_ref_que';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('ref_que');
    --
    begin
        --
        trace('deleting from ref_que');
        --
        delete
          from ref_que;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_ref_que;


  ---
  -- fill_ref_lst - импорт ref_lst
  --
  procedure fill_ref_lst
  is
    p               constant varchar2(62) := G_PKG||'.fill_ref_lst';
  begin
    --
    trace('%s: entry point', p);
   --
    init();
   --
    to_mfo();
    --
    before_fill('ref_lst');
    --
    begin
        trace('inserting into ref_lst');
        --
        execute immediate
        '
        insert
          into ref_lst(
               datd, nd, mfoa,
               nlsa, mfob, nlsb,
               s, ref, rec)
        select datd, nd, mfoa,
               nlsa, mfob, nlsb,
               s, to_number(ref), rec
          from ref_lst'||g_link;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_ref_lst;

  ---
  -- clean_ref_lst - очистка ref_lst
  --
  procedure clean_ref_lst
  is
    p           constant varchar2(62) := G_PKG||'.clean_ref_lst';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('ref_lst');
    --
    begin
        --
        trace('deleting from ref_lst');
        --
        delete
          from ref_lst;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_ref_lst;

  ---
  -- clean_zag_a - очистка zag_a
  --
  procedure clean_zag_a
  is
    p           constant varchar2(62) := G_PKG||'.clean_zag_a';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('zag_a');
    --
    begin
        --
        trace('deleting from zag_a');
        --
        delete
          from zag_a;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_zag_a;

  ---
  -- fill_zag_a - импорт zag_a
  --
  procedure fill_zag_a
  is
    p               constant varchar2(62) := G_PKG||'.fill_zag_a';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('zag_a');
    --
    begin
        trace('inserting into zag_a');
        --
        execute immediate
        '
        insert/*+ append */
          into zag_a (
               fn, dat, ref, kv, n, sde,
               skr, datk, dat_2, otm, sign, sign_key)
        select z.fn, z.dat, nvl2(z.ref, to_number(z.ref), null), z.kv, z.n, z.sde,
               z.skr, z.datk, z.dat_2, z.otm, z.sign, z.sign_key
          from zag_a'||g_link||' z';
        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_zag_a;

  ---
  -- clean_zag_b - очистка zag_b
  --
  procedure clean_zag_b
  is
    p           constant varchar2(62) := G_PKG||'.clean_zag_b';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('zag_b');
    --
    begin
        --
        trace('deleting from zag_b');
        --
        delete
          from zag_b;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_zag_b;

  ---
  -- fill_zag_b - импорт zag_b
  --
  procedure fill_zag_b
  is
    p               constant varchar2(62) := G_PKG||'.fill_zag_b';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('zag_b');
    --
    begin
        trace('inserting into zag_b');
        --
        execute immediate
        '
        insert/*+ append */
          into zag_b (
               fn, dat, ref, kv, n, sde, skr, datk, dat_2, otm,
               sign, sign_key, ssp_sign_key, ssp_sign, k_er)
        select z.fn, z.dat, nvl2(z.ref, to_number(z.ref), null), z.kv, z.n, z.sde, z.skr, z.datk, z.dat_2, z.otm,
               z.sign, z.sign_key, z.ssp_sign_key, z.ssp_sign, k_er
          from zag_b'||g_link||' z';
        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_zag_b;

  ---
  -- fill_arc_rrp - импорт arc_rrp
  --
  procedure fill_arc_rrp
  is
    p               constant varchar2(62) := G_PKG||'.fill_arc_rrp';
    l_max_rec      number;
    l_num          number;
    l_minrec        number;
    l_trace         varchar2(4000) :='MGR.fill_opldok: ';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('arc_rrp');
    --
    begin

         trace(l_trace||'start to move ');

            execute immediate 'select min(rec) from  arc_rrp'||g_link||'  where dat_a >= to_date(''01012012'',''ddmmyyyy'')' into l_minrec;

            trace(l_trace||'start to unusable indexes on ARC_RRP');
            for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'ARC_RRP'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                              )
                        where constraint_type is null
                     ) loop
                execute immediate 'alter index '||c.index_name||' unusable';
            end loop;

        trace('inserting into ARC_RRP');
        --
         execute immediate
            '
            insert /*+ append */
              into arc_rrp (
                   rec, ref, mfoa, nlsa, mfob, nlsb,
                   dk, s, vob, nd, kv, datd, datp, nam_a, nam_b,
                   nazn, naznk, nazns, id_a, id_b, id_o, ref_a, bis, sign,
                   fn_a, dat_a, rec_a, fn_b, dat_b, rec_b, d_rec, blk, sos,
                   prty, fa_name, fa_ln, fa_t_arm3, fa_t_arm2, fc_name,
                   fc_ln, fc_t1_arm2, fc_t2_arm2, fb_name, fb_ln, fb_t_arm2,
                   fb_t_arm3, fb_d_arm3, kf)
            select to_number(a.rec), nvl2(a.ref, to_number(a.ref), null), substr(a.mfoa,1,12), substr(a.nlsa,1,15), substr(a.mfob,1,12), substr(a.nlsb,1,15),
                   substr(a.dk,1,1), a.s, substr(a.vob,1,3) as vob, substr(a.nd,1,10), substr(a.kv,1,3), a.datd, trunc(a.datp) as datp, substr(a.nam_a,1,38), substr(a.nam_b,1,38),
                   substr(a.nazn,1,160), substr(a.naznk,1,3), substr(a.nazns,1,2), substr(a.id_a,1,14), substr(a.id_b,1,14), substr(a.id_o,1,6), substr(a.ref_a,1,9), substr(a.bis,1,10), a.sign,
                   substr(a.fn_a,1,12), a.dat_a, a.rec_a, substr(a.fn_b,1,12), a.dat_b, a.rec_b, substr(a.d_rec,1,80), substr(a.blk,1,4), substr(a.sos,1,1),
                   substr(a.prty,1,1), substr(a.fa_name,1,12), substr(a.fa_ln,1,10), substr(a.fa_t_arm3,1,4), substr(a.fa_t_arm2,1,4), substr(a.fc_name,1,12),
                   substr(a.fc_ln,1,10), substr(a.fc_t1_arm2,1,4), substr(a.fc_t2_arm2,1,4), substr(a.fb_name,1,12), substr(a.fb_ln,1,10), substr(a.fb_t_arm2,1,4),
                   substr(a.fb_t_arm3,1,4), a.fb_d_arm3, '''||g_glb_mfo||''' as kf
              from arc_rrp'||g_link||' a
              where a.rec>= '||l_minrec||' and dat_a>= to_date(''01012012'',''ddmmyyyy'')';
            --
               trace('MGR: transfer completed');
            --
            commit;
           --
           to_root();
        --
        trace('Обновляем значение S_ARC_RRP');
        execute immediate ' select trunc(nvl(max(rec),0)/100)+1 from arc_rrp'||g_link into l_max_rec;
        trace(l_trace||'get max rec');
        --
        reset_sequence('S_ARC_RRP', l_max_rec);
        --
        trace(l_trace||'sequence recreated');
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_arc_rrp;


  procedure fill_arc_rrpN (p_name  varchar2)
  is
    p               constant varchar2(62) := G_PKG||'.fill_arc_rrpN';
    l_maxref        number;
    l_stmt          varchar2(4000);
    l_minref        number;
    l_trace         varchar2(4000) :='MGR.fill_arc_rrpN: ';
    i               number;
    l_cnt           number;
    l_prc           number;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    --Представляемся
    to_mfo();
    --
    -- Отключаем констрейнты
    before_fill('arc_rrp');
    --
    begin

      trace(l_trace||'start to move ');
      -- Берем предварительно вычитанные референсы по партициям
      select nvl2(refcommit_arc,refcommit_arc+1,rmin), rmax  into l_minref, l_maxref from imp_fill where pname = p_name;

      trace(l_trace||'start to unusable indexes on ARC_RRP');
      -- Дизейблим констрейнты
       for c in (select index_name
                        from ( select i.index_name,  c.constraint_type
                                 from user_indexes i, user_constraints c
                                where i.table_name = 'ARC_RRP'
                                  and i.table_name = c.table_name (+)
                                  and i.index_name = c.index_name (+)
                                  and c.constraint_type(+) = 'P'
                                  and i.index_name<>'UK_ARCRRP'
                              )
                        where constraint_type is null
                     )
            loop
               begin
                execute immediate 'alter index '||c.index_name||' unusable';
               exception when others then
                  if sqlcode = -26026 then null; else raise; end if;
               end;
            end loop;

      trace(l_trace||'start to transfer into ARC_RRP');

      -- Начинаем импорт
      i:= l_minref;
      while i < l_maxref
          loop
            i :=  least(i + 100000, l_maxref);
            execute immediate '
            insert /*+ append */
              into arc_rrp (
                   rec, ref, mfoa, nlsa, mfob, nlsb,
                   dk, s, vob, nd, kv, datd, datp, nam_a, nam_b,
                   nazn, naznk, nazns, id_a, id_b, id_o, ref_a, bis, sign,
                   fn_a, dat_a, rec_a, fn_b, dat_b, rec_b, d_rec, blk, sos,
                   prty, fa_name, fa_ln, fa_t_arm3, fa_t_arm2, fc_name,
                   fc_ln, fc_t1_arm2, fc_t2_arm2, fb_name, fb_ln, fb_t_arm2,
                   fb_t_arm3, fb_d_arm3, kf)
            select to_number(a.rec), nvl2(a.ref, to_number(a.ref), null), substr(a.mfoa,1,12), substr(a.nlsa,1,15), substr(a.mfob,1,12), substr(a.nlsb,1,15),
                   substr(a.dk,1,1), a.s, substr(a.vob,1,3) as vob, substr(a.nd,1,10), substr(a.kv,1,3), a.datd, trunc(a.datp) as datp, substr(a.nam_a,1,38), substr(a.nam_b,1,38),
                   substr(a.nazn,1,160), substr(a.naznk,1,3), substr(a.nazns,1,2), substr(a.id_a,1,14), substr(a.id_b,1,14), substr(a.id_o,1,6), substr(a.ref_a,1,9), substr(a.bis,1,10), a.sign,
                   substr(a.fn_a,1,12), a.dat_a, a.rec_a, substr(a.fn_b,1,12), a.dat_b, a.rec_b, substr(a.d_rec,1,80), substr(a.blk,1,4), substr(a.sos,1,1),
                   substr(a.prty,1,1), substr(a.fa_name,1,12), substr(a.fa_ln,1,10), substr(a.fa_t_arm3,1,4), substr(a.fa_t_arm2,1,4), substr(a.fc_name,1,12),
                   substr(a.fc_ln,1,10), substr(a.fc_t1_arm2,1,4), substr(a.fc_t2_arm2,1,4), substr(a.fb_name,1,12), substr(a.fb_ln,1,10), substr(a.fb_t_arm2,1,4),
                   substr(a.fb_t_arm3,1,4), a.fb_d_arm3, '''||g_glb_mfo||''' as kf
              from arc_rrp'||g_link||' a
              where a.rec>= '||l_minref||' and a.rec< '||i||' and dat_a>= to_date(''01012012'',''ddmmyyyy'')';
            --
            commit;
            update imp_fill set refcommit_arc = i where pname = p_name;
            l_cnt := i - l_minref;
            l_minref := i;
            select nvl(round((refcommit_arc - rmin)*100/((rmax-rmin)),2),0) into l_prc from imp_fill where pname = p_name;
            DBMS_APPLICATION_INFO.SET_CLIENT_INFO('Заімпортовано записів(arc_rrp): '||l_prc||'% до рек '||l_minref);
          end loop;

      trace('MGR: transfer completed');

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_arc_rrpN;

  ---
  -- Вариант 2
  --
   procedure fill_arc_rrp2
  is
    p               constant varchar2(62) := G_PKG||'.fill_arc_rrp2';
    l_stmt          varchar2(4000);

  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('arc_rrp');
    --

    --
    begin
            -- наполняем данные
            execute immediate
            'declare
             i number :=0;
            begin
             for k in( select to_number(a.rec) rec, nvl2(a.ref, to_number(a.ref), null) ref , substr(a.mfoa,1,12) mfoa, substr(a.nlsa,1,15) nlsa, substr(a.mfob,1,12) mfob, substr(a.nlsb,1,15) nlsb,
                   substr(a.dk,1,1) dk, a.s s, substr(a.vob,1,3) as vob, substr(a.nd,1,10) nd, substr(a.kv,1,3) kv, a.datd datd, trunc(a.datp) as datp, substr(a.nam_a,1,38) nam_a, substr(a.nam_b,1,38) nam_b,
                   substr(a.nazn,1,160) nazn, substr(a.naznk,1,3) naznk, substr(a.nazns,1,2) nazns, substr(a.id_a,1,14) id_a, substr(a.id_b,1,14) id_b, substr(a.id_o,1,6) id_o, substr(a.ref_a,1,9) ref_a, substr(a.bis,1,10) bis, a.sign sign,
                   substr(a.fn_a,1,12) fn_a, a.dat_a dat_a, a.rec_a rec_a, substr(a.fn_b,1,12) fn_b, a.dat_b dat_b, a.rec_b rec_b, substr(a.d_rec,1,80) d_rec, substr(a.blk,1,4) blk, substr(a.sos,1,1) sos,
                   substr(a.prty,1,1) prty, substr(a.fa_name,1,12) fa_name, substr(a.fa_ln,1,10) fa_ln, substr(a.fa_t_arm3,1,4) fa_t_arm3, substr(a.fa_t_arm2,1,4) fa_t_arm2, substr(a.fc_name,1,12) fc_name,
                   substr(a.fc_ln,1,10) fc_ln, substr(a.fc_t1_arm2,1,4) fc_t1_arm2, substr(a.fc_t2_arm2,1,4) fc_t2_arm2, substr(a.fb_name,1,12) fb_name, substr(a.fb_ln,1,10) fb_ln, substr(a.fb_t_arm2,1,4) fb_t_arm2,
                   substr(a.fb_t_arm3,1,4) fb_t_arm3, a.fb_d_arm3 fb_d_arm3, :g_glb_mfo as kf
              from arc_rrp'||g_link||' a
             )

             loop

             insert into arc_rrp (rec, ref, mfoa, nlsa, mfob, nlsb,
                   dk, s, vob, nd, kv, datd, datp, nam_a, nam_b,
                   nazn, naznk, nazns, id_a, id_b, id_o, ref_a, bis, sign,
                   fn_a, dat_a, rec_a, fn_b, dat_b, rec_b, d_rec, blk, sos,
                   prty, fa_name, fa_ln, fa_t_arm3, fa_t_arm2, fc_name,
                   fc_ln, fc_t1_arm2, fc_t2_arm2, fb_name, fb_ln, fb_t_arm2,
                   fb_t_arm3, fb_d_arm3, kf)
                   values (k.rec, k.ref, k.mfoa, k.nlsa, k.mfob, k.nlsb,
                   k.dk, k.s, k.vob, k.nd, k.kv, k.datd, k.datp, k.nam_a, k.nam_b,
                   k.nazn, k.naznk, k.nazns, k.id_a, k.id_b, k.id_o, k.ref_a, k.bis, k.sign,
                   k.fn_a, k.dat_a, k.rec_a, k.fn_b, k.dat_b, k.rec_b, k.d_rec, k.blk, k.sos,
                   k.prty, k.fa_name, k.fa_ln, k.fa_t_arm3, k.fa_t_arm2, k.fc_name,
                   k.fc_ln, k.fc_t1_arm2, k.fc_t2_arm2, k.fb_name, k.fb_ln, k.fb_t_arm2,
                   k.fb_t_arm3, k.fb_d_arm3, k.kf);

                   i:=i+1;

                   if mod(i, 1001) = 1000
                    then commit;
                   end if;

                   DBMS_APPLICATION_INFO.SET_CLIENT_INFO(''Заімпортовано записів(arc_rrp): ''||i);

              end loop;
            end;' using g_glb_mfo;


            --
            commit;
            --
            to_root();
            --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_arc_rrp2;

  ---
  -- Очистка arc_rrp
  --
  procedure clean_arc_rrp
  is
    p           constant varchar2(62) := G_PKG||'.clean_arc_rrp';
  begin
    --
    dbms_output.enable(1000000);
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('arc_rrp');
    --

    begin
        --
        trace('%s: deleting arc_rrp', p);
        --
        delete
          from arc_rrp;
        --
          trace('%s записей удалено', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            --
            save_error();
            --
    end;
    --
    to_root;
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_arc_rrp;

  ---
  -- fill_arc_rrp_part
  --
  procedure fill_arc_rrp_part
  is
    p               constant varchar2(62) := G_PKG||'.fill_arc_rrp_part';
    l_errmsg        varchar2(4000);
    l_min_data      date;
    l_max_data      date;
    l_exists        boolean;
    l_num           number;
    l_max_rec       number;
    x               SYS_REFCURSOR;
    TYPE imp_rec IS RECORD(partition_name varchar2(120), partitioned varchar2(20), partition_position number,
              partition_stmt VARCHAR2(150));
   c imp_rec;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('arc_rrp');
    --
    begin
        --
        open x for 'select ''NONE'' as partition_name, partitioned, 0 as partition_position, null as partition_stmt
                    from all_tables'||g_link||'
                   where owner=''BARS''
                     and table_name=''ARC_RRP''
                     and partitioned=''NO''
                   union all
                  select partition_name, ''YES'' as partitioned, partition_position, ''partition(''||partition_name||'')'' as partition_stmt
                    from all_tab_partitions'||g_link||'
                   where table_owner=''BARS''
                     and table_name=''ARC_RRP''
                   order by partition_position asc';
        loop
         FETCH x INTO c;
           EXIT WHEN x%NOTFOUND;
            -- проверяем наличие в arc_rrp данных партиции
            execute immediate 'select min(dat_a), max(dat_a) from arc_rrp'||g_link||' '||c.partition_stmt into l_min_data, l_max_data;
            --
            l_exists := false;
            begin
                select 1
                  into l_num
                  from arc_rrp
                 where dat_a between l_min_data and l_max_data
                   and rownum=1;
                --
                l_exists := true;
            exception
                when no_data_found then
                    null;
            end;
            --
            if l_exists
            then
                trace('Данные arc_rrp'||g_link||' '||c.partition_stmt||' уже импортированы в arc_rrp, пропускаем');
                continue;
            end if;
            -- наполняем данные партиции
             execute immediate
            '
            insert
              into arc_rrp (
                   rec, ref, mfoa, nlsa, mfob, nlsb,
                   dk, s, vob, nd, kv, datd, datp, nam_a, nam_b,
                   nazn, naznk, nazns, id_a, id_b, id_o, ref_a, bis, sign,
                   fn_a, dat_a, rec_a, fn_b, dat_b, rec_b, d_rec, blk, sos,
                   prty, fa_name, fa_ln, fa_t_arm3, fa_t_arm2, fc_name,
                   fc_ln, fc_t1_arm2, fc_t2_arm2, fb_name, fb_ln, fb_t_arm2,
                   fb_t_arm3, fb_d_arm3, kf)
            select to_number(a.rec), nvl2(a.ref, to_number(a.ref), null), substr(a.mfoa,1,12), substr(a.nlsa,1,15), substr(a.mfob,1,12), substr(a.nlsb,1,15),
                   substr(a.dk,1,1), a.s, substr(a.vob,1,3) as vob, substr(a.nd,1,10), substr(a.kv,1,3), a.datd, trunc(a.datp) as datp, substr(a.nam_a,1,38), substr(a.nam_b,1,38),
                   substr(a.nazn,1,160), substr(a.naznk,1,3), substr(a.nazns,1,2), substr(a.id_a,1,14), substr(a.id_b,1,14), substr(a.id_o,1,6), substr(a.ref_a,1,9), substr(a.bis,1,10), a.sign,
                   substr(a.fn_a,1,12), a.dat_a, a.rec_a, substr(a.fn_b,1,12), a.dat_b, a.rec_b, substr(a.d_rec,1,80), substr(a.blk,1,4), substr(a.sos,1,1),
                   substr(a.prty,1,1), substr(a.fa_name,1,12), substr(a.fa_ln,1,10), substr(a.fa_t_arm3,1,4), substr(a.fa_t_arm2,1,4), substr(a.fc_name,1,12),
                   substr(a.fc_ln,1,10), substr(a.fc_t1_arm2,1,4), substr(a.fc_t2_arm2,1,4), substr(a.fb_name,1,12), substr(a.fb_ln,1,10), substr(a.fb_t_arm2,1,4),
                   substr(a.fb_t_arm3,1,4), a.fb_d_arm3, :g_glb_mfo as kf
              from arc_rrp'||g_link||' '||c.partition_stmt||' a'
            using g_glb_mfo;
            --
            trace('%s записей вставлено', to_char(sql%rowcount));
            --
            commit;
            --
            trace('импортирована таблица/партиция %s', c.partition_stmt);
            --
        end loop;
        --
        to_root();
        --
        -- заново узнаем максимальный REC в ARC_RRP
        select trunc(nvl(max(rec),0)/100)+1
          into l_max_rec
          from arc_rrp;
        -- выставляем последовательность s_arc_rrp
        reset_sequence('S_ARC_RRP', l_max_rec);

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_arc_rrp_part;

  ---
  -- clean_arc_rrp_part;
  --
  procedure clean_arc_rrp_part
  is
    p           constant varchar2(62) := G_PKG||'.clean_arc_rrp';
    l_stmt      varchar2(1024);
    x               SYS_REFCURSOR;
    TYPE imp_rec IS RECORD(partition_name varchar2(120));
    c imp_rec;
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('arc_rrp');
    --
    begin
        --
        trace('%s: deleting arc_rrp', p);
        --
        --
        open x for  'select partition_name
              from user_tab_partitions
             where table_name=''ARC_RRP''
              order by partition_name desc';
        loop
         --
         FETCH x INTO c;
         --
           EXIT WHEN x%NOTFOUND;
            --
            l_stmt := 'alter table arc_rrp truncate partition '||c.partition_name||' update indexes';
            --
            trace(l_stmt);
            --
            execute immediate l_stmt;
            --
        end loop;

        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_arc_rrp_part;

  ---
  -- clean_zag_k - очистка zag_k
  --
  procedure clean_zag_k
  is
    p           constant varchar2(62) := G_PKG||'.clean_zag_k';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('zag_k');
    --
    begin
        --
        trace('deleting from zag_k');
        --
        delete
          from zag_k;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_zag_k;

  ---
  -- fill_zag_k - импорт zag_k
  --
  procedure fill_zag_k
  is
    p               constant varchar2(62) := G_PKG||'.fill_zag_k';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('zag_k');
    --
    begin
        --
        trace('inserting into zag_k');
        --
        execute immediate
        '
        insert
          into zag_k (
               ref, kv, fn, dat, n, sde, skr,
               datk, dat_2, k_er, otm, sign, sign_key)
        select nvl2(ref, to_number(ref), null), kv, fn, dat, n, sde, skr,
               datk, dat_2, k_er, otm, sign, sign_key
          from zag_k'||g_link;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_zag_k;

  ---
  -- clean_zag_f - очистка zag_f
  --
  --
  procedure clean_zag_f
  is
    p           constant varchar2(62) := G_PKG||'.clean_zag_f';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('zag_f');
    --
    begin
        --
        trace('deleting from zag_f');
        --
        delete
          from zag_f;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_zag_f;

  ---
  -- fill_zag_f - импорт zag_f
  --
  procedure fill_zag_f
  is
    p               constant varchar2(62) := G_PKG||'.fill_zag_f';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('zag_f');
    --
    begin
        --
        trace('inserting into zag_f');
        --
        execute immediate
        'insert
          into zag_f (
               fn, dat, n, otm, datk, err, kf)
        select fn, dat, n, otm, datk, err, :g_glb_mfo
          from zag_f'||g_link
          using g_glb_mfo;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_zag_f;

  ---
  -- clean_zag_mc - очистка zag_mc
  --
  procedure clean_zag_mc
 is
    p           constant varchar2(62) := G_PKG||'.clean_zag_mc';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('zag_mc');
    --
    begin
        --
        trace('deleting from zag_mc');
        --
        delete
          from zag_mc;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_zag_mc;

  ---
  -- fill_zag_mc - импорт zag_mc
  --
  procedure fill_zag_mc
    is
    p               constant varchar2(62) := G_PKG||'.fill_zag_mc';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('zag_mc');
    --
    begin
        --
        trace('inserting into zag_mc');
        --
        execute immediate
        'insert
          into zag_mc (
               fn, dat, n, sign_key, sign, fn2, dat2, otm, datk, sab, counter, dat_fm, kf)
        select fn, dat, n, sign_key, sign, fn2, dat2, otm, datk, sab, counter, dat_fm, :g_glb_mfo
          from zag_mc'||g_link
          using g_glb_mfo;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_zag_mc;

  ---
  -- очистка banks$settings
  --
  procedure clean_banks$settings
 is
    p           constant varchar2(62) := G_PKG||'.clean_banks$settings';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('banks$settings');
    --
    begin
        --
        trace('deleting from banks$settings');
        --
        delete
          from banks$settings;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_banks$settings;


 ---
 -- Импорт fill_banks$settings
 --
 procedure fill_banks$settings
    is
    p               constant varchar2(62) := G_PKG||'.fill_banks$settings';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('banks$settings');
    --
    begin
        --
        trace('inserting into banks$settings');
        --
        execute immediate
       'insert
       into banks$settings (mfo, fmi, fmo, pm, kodn, mfop)
             select mfo, fmi, fmo, pm, kodn, mfop
               from banks'||g_link||'
              where kodn is not null';

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --

  end fill_banks$settings;


 procedure clean_banks$base
 is
    p           constant varchar2(62) := G_PKG||'.clean_banks$base';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('banks$base');
    --
    begin
        --
        trace('deleting from banks$base');
        --
        delete
          from banks$base;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_banks$base;

 ---
 -- Импорт fill_banks$base
 --
 procedure fill_banks$base
    is
    p               constant varchar2(62) := G_PKG||'.fill_banks$base';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('banks$base');
    --
    begin
        --
        trace('inserting into banks$base');
        --
        execute immediate
       'insert
       into banks$base (mfo, sab, nb, kodg, blk, mfou, ssp, nmo)
             select mfo, sab, nb, kodg, blk, mfou, ssp, nmo
               from banks'||g_link;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --

  end fill_banks$base;


  ---
  -- очистка lkl_rrp
  --
  procedure clean_lkl_rrp
 is
    p           constant varchar2(62) := G_PKG||'.clean_lkl_rrp';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('lkl_rrp');
    --
    begin
        --
        trace('deleting from lkl_rrp');
        --
        delete
          from lkl_rrp;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_lkl_rrp;

 ---
 -- Импорт fill_banks$settings
 --
 procedure fill_lkl_rrp
    is
    p               constant varchar2(62) := G_PKG||'.fill_lkl_rrp';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('lkl_rrp');
    --
    begin
        --
        trace('inserting into lkl_rrp');
        --
        execute immediate
       'insert into lkl_rrp(mfo, dat, ostf, lim, lno, kn, bn, dat_r, rn, idr, pfn, dr_date, pcn, pqn, prn, ssp_date, ssp_sn, ssp_pn, trouble, kv, blk, bn_ssp, file_encoding)
                     select mfo, dat, ostf, lim, lno, kn, bn, dat_r, rn, idr, pfn, dr_date, pcn, pqn, prn, ssp_date, ssp_sn, ssp_pn, trouble, kv, blk, bn_ssp, file_encoding
                     from lkl_rrp'||g_link;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --

  end fill_lkl_rrp;


  ---
  -- очистка t902
  --
  procedure clean_t902
 is
    p           constant varchar2(62) := G_PKG||'.clean_t902';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('t902');
    --
    begin
        --
        trace('deleting from t902');
        --
        delete
          from t902;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_t902;

 ---
 -- Импорт fill_t902
 --
 procedure fill_t902
    is
    p               constant varchar2(62) := G_PKG||'.fill_t902';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('t902');
    --
    begin
        --
        trace('inserting into t902');
        --
        execute immediate
       'insert into bars.t902(ref, rec, otm, dat, rec_o, s, stmp, blk)
                select nvl2(ref, ref,null),
                nvl2(rec,rec,null), otm, dat,
                nvl2(rec_o,rec_o,null), s, stmp, blk
                from t902'||g_link;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --

  end fill_t902;


  ---
  -- очистка tzapros
  --
  procedure clean_tzapros
 is
    p           constant varchar2(62) := G_PKG||'.clean_tzapros';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('tzapros');
    --
    begin
        --
        trace('deleting from tzapros');
        --
        delete
          from tzapros;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_tzapros;

 ---
 -- Импорт fill_tzapros
 --
 procedure fill_tzapros
    is
    p               constant varchar2(62) := G_PKG||'.fill_tzapros';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('tzapros');
    --
    begin
        --
        trace('inserting into tzapros');
        --
        execute immediate
       'insert into bars.tzapros(rec, otm, dat, stmp)
                select nvl2(rec,rec,null),
                otm, dat, stmp from tzapros'||g_link;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --

  end fill_tzapros;

  ---
  -- очистка vp_list
  --
  procedure clean_vp_list
 is
    p           constant varchar2(62) := G_PKG||'.clean_vp_list';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('vp_list');
    --
    begin
        --
        trace('deleting from vp_list');
        --
        delete
          from vp_list;
        --
        trace('%s rows deleted', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_vp_list;

 ---
 -- Импорт fill_vp_list
 --
 procedure fill_vp_list
    is
    p               constant varchar2(62) := G_PKG||'.fill_vp_list';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('vp_list');
    --
    begin
        --
        trace('inserting into vp_list');
        --
        execute immediate
           'insert into vp_list(acc3800, acc3801, acc6204, comm, acc_rrd, acc_rrr, acc_rrs, kf)
                        select acc3800, acc3801, acc6204, comm, acc_rrd, acc_rrr, acc_rrs, :g_glb_mfo from vp_list'||g_link
                        using g_glb_mfo;

        --
        trace('%s rows inserted', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --

  end fill_vp_list;


  ---
  -- clean_cur_rates - очистка cur_rates
  --
  procedure clean_cur_rates
  is
    p           constant varchar2(62) := G_PKG||'.clean_cur_rates';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_clean('cur_rates$base');
    --
    -- отключаем политику, она не дает удалить данные
    bpa.disable_policies('cur_rates$base');
    --
    begin
        --
        trace('deleting from cur_rates$base');
        --
        delete
          from cur_rates$base;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    -- включаем политику
    bpa.enable_policies('cur_rates$base');
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_cur_rates;

  ---
  -- fill_cur_rates - наполнение cur_rates
  --
  procedure fill_cur_rates
  is
    p               constant varchar2(62) := G_PKG||'.fill_cur_rates';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('cur_rates$base');
    --
    begin
        trace('inserting into cur_rates$base');
        --
        execute immediate
       'insert
          into cur_rates$base (
               kv, vdate, bsum, rate_o, rate_b, rate_s,
               rate_spot, rate_forward, lim_pos, branch, otm)
        select c.kv, c.vdate, c.bsum, c.rate_o, c.rate_b, c.rate_s,
               c.rate_spot, c.rate_forward, c.lim_pos, b.branch, ''Y''
          from cur_rates'||g_link||' c, branch b';
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_cur_rates;


  ---
  -- clean_bp_rrp - очистка бизнес-правил
  --
  procedure clean_bp_rrp
  is
    p           constant varchar2(62) := G_PKG||'.clean_bp_rrp';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('bp_rrp');
    --

    begin
        --
        trace('deleting from bp_rrp');
        --
        delete
          from bp_rrp;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end clean_bp_rrp;

  ---
  -- fill_bp_rrp
  --
   procedure fill_bp_rrp
  is
    p               constant varchar2(62) := G_PKG||'.fill_bp_rrp';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('bp_rrp');
    --
    begin
        trace('inserting into bp_rrp');
        --
        execute immediate
       'insert
           into BP_RRP(RULE, MFO, FA, BODY, NAME)
                select RULE, MFO, FA, BODY, NAME
                                 from BP_RRP'||g_link||'
                      where rule is not null';
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_bp_rrp;

  ---
  -- Clean perekr_a
  --
procedure clean_perekr_a
    is
    p           constant varchar2(62) := G_PKG||'.clean_perekr_a';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('perekr_a');
    --

    begin
        --
        trace('deleting from perekr_a');
        --
        delete
          from perekr_a;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end clean_perekr_a;

---
--fill_perekr_a
--
procedure fill_perekr_a
  is
    p               constant varchar2(62) := G_PKG||'.fill_perekr_a';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('perekr_a');
    --
    begin
        trace('inserting into perekr_a');
        --
        execute immediate
       'insert into perekr_a(idg, ids, acc, sps)
                      select idg, ids, acc, sps from perekr_a'||g_link;
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_perekr_a;

  ---
  -- Clean perekr_b
  --
procedure clean_perekr_b
    is
    p           constant varchar2(62) := G_PKG||'.clean_perekr_b';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('perekr_b');
    --

    begin
        --
        trace('deleting from perekr_b');
        --
        delete
          from perekr_b;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end clean_perekr_b;

---
--fill_perekr_b
--
procedure fill_perekr_b
  is
    p               constant varchar2(62) := G_PKG||'.fill_perekr_b';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('perekr_b');
    --
    begin
        trace('inserting into perekr_b');
        --
        execute immediate
       'insert into perekr_b(id, ids, tt, mfob, nlsb, polu, nazn, kv, s, okpo, idr, koef, vob)
              select s_perekr_b.NEXTVAL, ids, tt, mfob, nlsb, polu, nazn, kv, s, okpo, nvl(idr,1), koef, vob from perekr_b'||g_link;
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_perekr_b;


  ---
  -- Clean perekr_g
  --
procedure clean_perekr_g
    is
    p           constant varchar2(62) := G_PKG||'.clean_perekr_g';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('perekr_g');
    --

    begin
        --
        trace('deleting from perekr_g');
        --
        delete
          from perekr_g;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end clean_perekr_g;

---
--fill_perekr_g
--
procedure fill_perekr_g
  is
    p               constant varchar2(62) := G_PKG||'.fill_perekr_g';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('perekr_g');
    --
    begin
        trace('inserting into perekr_g');
        --
        execute immediate
       'insert into perekr_g(idg,name)
              select idg, name from perekr_g'||g_link;
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_perekr_g;

  ---
  -- Clean perekr_j
  --
procedure clean_perekr_j
    is
    p           constant varchar2(62) := G_PKG||'.clean_perekr_j';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('perekr_j');
    --

    begin
        --
        trace('deleting from perekr_j');
        --
        delete
          from perekr_j;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end clean_perekr_j;

---
--fill_perekr_j
--
procedure fill_perekr_j
  is
    p               constant varchar2(62) := G_PKG||'.fill_perekr_j';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('perekr_j');
    --
    begin
        trace('inserting into perekr_j');
        --
        execute immediate 'insert into perekr_j(acc, accs) select acc, accs from perekr_j'||g_link;
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_perekr_j;

  ---
  -- Clean perekr_r
  --
procedure clean_perekr_r
    is
    p           constant varchar2(62) := G_PKG||'.clean_perekr_r';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('perekr_r');
    --

    begin
        --
        trace('deleting from perekr_r');
        --
        delete
          from perekr_r;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end clean_perekr_r;

---
--fill_perekr_r
--
procedure fill_perekr_r
  is
    p               constant varchar2(62) := G_PKG||'.fill_perekr_r';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('perekr_r');
    --
    begin
        trace('inserting into perekr_r');
        --
        execute immediate 'insert into perekr_r(idr, name) select idr, name from perekr_r'||g_link;
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_perekr_r;

  ---
  -- Clean perekr_s
  --
procedure clean_perekr_s
    is
    p           constant varchar2(62) := G_PKG||'.clean_perekr_s';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_clean('perekr_s');
    --

    begin
        --
        trace('deleting from perekr_s');
        --
        delete
          from perekr_s;
        --
        trace('%s rows deleted ', to_char(sql%rowcount));
        --
        commit;
        --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end clean_perekr_s;

---
--fill_perekr_s
--
procedure fill_perekr_s
  is
    p               constant varchar2(62) := G_PKG||'.fill_perekr_s';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('perekr_s');
    --
    begin
        trace('inserting into perekr_s');
        --
        execute immediate 'insert into perekr_s(ids, name) select ids, name from perekr_s'||g_link;
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --
        to_root();
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
  end fill_perekr_s;

---
-- Импорт АРМов (пока закоментарим, наверное их АРМы брать не будем)
--
/*
procedure fill_applist
 is
    p               constant varchar2(62) := G_PKG||'.fill_applist';
begin
--
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_fill('applist');
    --
    begin
        trace('inserting into applist');
        --
        execute immediate 'insert into applist(codeapp, name, hotkey, frontend)
                                        select codeapp, name, hotkey, frontend from applist'||g_link||'
                                         where codeapp not in(select codeapp from applist)';
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
end fill_applist;
*/

---
--fill_doc_scheme
--
procedure fill_doc_scheme
is
    p               constant varchar2(62) := G_PKG||'.fill_doc_scheme';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_fill('doc_scheme');
    --
    begin
        trace('inserting into doc_scheme');
        --
        execute immediate 'insert into DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, D_CLOSE)
                                            select ID, nvl(NAME, ID), 0, null from DOC_SCHEME'||g_link;
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end fill_doc_scheme;

---
-- fill_dpt_deposit
--
procedure fill_dpt_deposit
is
    p               constant varchar2(62) := G_PKG||'.fill_dpt_deposit';
    l_stmt          varchar2(4000);

  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('dpt_deposit,dpt_accounts,dpt_depositw');

    --
    begin
            -- наполняем данные
            execute immediate
            'declare
                 l_branch  branch.branch%type;
                 l_acra    accounts.acc%type;
                 l_isp     accounts.isp%type;
                 i number :=0;

            begin
             for k in(select * from dpt_deposit'||g_link||'  where acc not in(
             select acc from (
                select acc, count(*) from dpt_deposit'||g_link||'
                group by acc
                having count(*)>1)
             )
             )

             loop
               i:=i+1;
--              select branch, nvl(isp,1)
--                  into l_branch, l_isp
--                  from accounts
--                 where acc = k.acc;

                 insert into dpt_deposit
                  ( DEPOSIT_ID, VIDD, ACC, KV, RNK, DATZ, DAT_BEGIN, DAT_END, LIMIT, ND,
                    COMMENTS, CNT_DUBL, FREQ, STATUS, STOP_ID, USERID, BRANCH,
                    MFO_P, NLS_P, NAME_P, OKPO_P, MFO_D, NLS_D, NMS_D, OKPO_D, DPT_D, ACC_D )
                values
                  ( k.DEPOSIT_ID, k.VIDD, k.ACC, k.KV, k.RNK, nvl(k.DATZ, k.DAT_BEGIN), k.DAT_BEGIN, k.DAT_END, k.LIMIT, k.ND,
                    k.COMMENTS, k.CNT_DUBL, k.FREQ, k.STATUS, 0, k.userid, ''/300465/'',
                    k.MFO_P, k.NLS_P, k.NAME_P, k.OKPO_P, k.MFO_D, k.NLS_D, k.NMS_D, k.OKPO_D, k.DPT_D, k.ACC_D );

                    insert into dpt_accounts
                      (dptid, accid)
                    values
                      (k.deposit_id, k.acc);
                 begin
                  select acra
                      into l_acra
                      from int_accn
                     where acc = k.acc
                       and id = 1;
                 exception when no_data_found then l_acra:=null;
                 end;

                 if l_acra is not null then
                     begin
                        insert into dpt_accounts
                              (dptid, accid)
                            values
                              (k.deposit_id, l_acra);
                        exception when dup_val_on_index then null;
                      end;
                  end if;

                insert into DPT_DEPOSITW
                  ( DPT_ID, TAG, VALUE )
                select DPT_ID, TAG, VALUE
                  from DPT_DEPOSITW'||g_link||'
                 where dpt_id = k.deposit_id;

                 DBMS_APPLICATION_INFO.SET_CLIENT_INFO(''Заімпортовано записів(dpt_deposit): ''||i);

              end loop;
            end;';


            --
            commit;
            --
            to_root();
            --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end fill_dpt_deposit;

---
--fill_cc_docs
--
procedure fill_cc_docs
is
    p               constant varchar2(62) := G_PKG||'.fill_cc_docs';
    l_stmt          varchar2(4000);

  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('cc_docs');

    --
    begin
            -- наполняем данные
            execute immediate
            'insert /* +append */ into CC_DOCS
                      (ID, ND, ADDS, VERSION, STATE, TEXT)
                  select ID, ND, ADDS, VERSION, STATE, TEXT from cc_docs'||g_link;

            --
            commit;
            --
            to_root();
            --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end fill_cc_docs;

---
--fill_cc_tipd
--
procedure fill_cc_tipd
is
    p               constant varchar2(62) := G_PKG||'.fill_cc_tipd';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_fill('cc_tipd');
    --
    begin
        trace('inserting into cc_tipd');
        --
        execute immediate 'insert into cc_tipd select * from cc_tipd'||g_link||'
                         where tipd not in (select tipd from cc_tipd)';
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end fill_cc_tipd;

---
--fill_cc_vidd
--
procedure fill_cc_vidd
is
    p               constant varchar2(62) := G_PKG||'.fill_cc_vidd';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_root();
    --
    before_fill('cc_vidd');
    --
    begin
        trace('inserting into cc_vidd');
        --
        execute immediate 'insert into CC_VIDD
                          (VIDD, CUSTTYPE, TIPD, NAME, SPS)
                        select VIDD, nvl(CUSTTYPE, 1), nvl(TIPD, 1), NAME, SPS
                          from cc_vidd'||g_link||'
                         where vidd not in (select vidd from cc_vidd)';
        --
        trace('%s rows inserted ', to_char(sql%rowcount));
        --
        commit;
        --

    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end fill_cc_vidd;

---
-- Fill_DPT_DEPOSIT_CLOS
--
procedure fill_dpt_deposit_clos
is
    p               constant varchar2(62) := G_PKG||'.fill_dpt_deposit_clos';
    l_stmt          varchar2(4000);
    l_max_id number;

  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --
    to_mfo();
    --
    before_fill('dpt_deposit_clos,dpt_deposit_all');

    --
    begin
            --
              select trunc(nvl(max(idupd),1)/100)+1
                  into l_max_id
              from DPT_DEPOSIT_CLOS;
            --
             reset_sequence('S_DPT_DEPOSIT_CLOS', l_max_id);
            -- наполняем данные
            execute immediate
            'declare
                l_branch  branch.branch%type;
                l_isp      accounts.isp%type;
                l_dazs   accounts.dazs%type;
                i number :=0;
             begin
             tuda;
                 for k in(select * from DPT_DEPOSIT_CLOS'||g_link||'  where acc is not null)

             loop
              i:=i+1;
                begin
                  insert into DPT_DEPOSIT_ALL (DEPOSIT_ID)
                  values (k.DEPOSIT_ID);
                exception
                  when dup_val_on_index then null;
                end;

--                begin
--                select branch, nvl(isp,1), dazs
--                  into l_branch, l_isp , l_dazs
--                  from accounts
--                 where acc = k.acc and kf=sys_context(''bars_context'',''user_mfo'');
--                 exception when no_data_found then
--                 l_branch:=null;
--                 l_isp:=null;
--                 l_dazs:=null;
--                 end;

                begin
                  Insert into BARS.DPT_DEPOSIT_CLOS
                    ( DEPOSIT_ID, VIDD, ACC, KV, RNK, DAT_BEGIN, DAT_END, "LIMIT", ACTION_ID, ACTIION_AUTHOR,
                      "WHEN", DATZ, FREQ, ND, BRANCH, IDUPD, BDATE, STOP_ID, USERID )
                  Values
                    ( k.DEPOSIT_ID, k.VIDD, k.ACC, k.KV, k.RNK, k.DAT_BEGIN, k.DAT_END, k."LIMIT", k.ACTION_ID, k.ACTIION_AUTHOR,
                      k."WHEN", nvl(k.DATZ,trunc(sysdate)), k.FREQ, k.ND, ''/300465/'',s_dpt_deposit_clos.nextval, k.BDATE, 0, k.userid );
                   exception when dup_val_on_index then null;
                end;
                DBMS_APPLICATION_INFO.SET_CLIENT_INFO(''Заімпортовано записів(dpt_deposit_clos): ''||i);
              end loop;
              suda;
            end;';

            --
            commit;
            --
            to_root();
            --
    exception
        when others then
            rollback;
            save_error();
    end;
    --
    to_root();
    --
    finalize();
    --
    trace('%s: finished', p);
    --
end fill_dpt_deposit_clos;

---
-- Процедура импорта meta_table
--
procedure fill_meta_tables
is
p               constant varchar2(62) := G_PKG||'.fill_meta_tables';
begin
    --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
            'insert into meta_tables
             select
                         s_metatables.nextval,
                         upper(m.tabname),
                         m.semantic,
                         m.tabrelation,
                         m.tabldel
                from meta_tables'||g_link||' m where upper(tabname) not in (select upper(tabname) from meta_tables)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
end fill_meta_tables;

---
-- Процедура импорта фильтров
--
 procedure fill_dyn_filter
 is
 p               constant varchar2(62) := G_PKG||'.fill_dyn_filter';
 begin
  --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
        'insert into dyn_filter
            --
            select
            --
             s_dyn_filter.nextval,
             --
              m.tabid tabid,
            --
             d.userid userid,
             --
             nvl(d.semantic,''Не заполнено''),
             d.from_clause,
             d.where_clause,
             null pkey
              from dyn_filter'||g_link||' d , meta_tables'||g_link||'  km, meta_tables m
              where d.where_clause is not null
               and   d.tabid=km.tabid
               and km.tabname=m.tabname
               and upper(d.where_clause) not in(select upper(where_clause) from dyn_filter)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
 end fill_dyn_filter;

 ---
 -- Проедура импорта meta_columns
 --
procedure fill_meta_columns
  is
  p               constant varchar2(62) := G_PKG||'.fill_meta_columns';
begin
   --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
           '
           insert into meta_columns(tabid,
              colid,
              colname,
              coltype,
              semantic,
              showwidth,
              showmaxchar,
              showpos,
              showin_ro,
              showretval,
              instnssemantic,
              extrnval,
              showrel_ctype,
              showformat,
              showin_fltr,
              showref,
              showresult,
              case_sensitive,
              not_to_edit,
              not_to_show,
              simple_filter)
       select * from(
        select
              s.tabid,
              m.colid,
              m.colname,
              m.coltype,
              m.semantic,
              m.showwidth,
              m.showmaxchar,
              m.showpos,
              m.showin_ro,
              m.showretval,
              m.instnssemantic,
              m.extrnval,
              m.showrel_ctype,
              m.showformat,
              m.showin_fltr,
              m.showref,
              m.showresult,
             null  case_sensitive,
             0 not_to_edit,
             0 not_to_show,
             0 simple_filter
                 from meta_columns'||g_link||' m, meta_tables'||g_link||' t, meta_tables s
             where m.tabid=t.tabid
             and upper(t.tabname)=upper(s.tabname)
             ) a
             where (tabid, upper(colname)) not in(select tabid, upper(colname) from meta_columns)
             and (tabid, colid) not in(select tabid, colid from meta_columns)
             ';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
  end fill_meta_columns;

  ---
  --  Import meta_sortorder
  --
  procedure fill_meta_sortorder
  is
  p               constant varchar2(62) := G_PKG||'.fill_meta_sortorder';
  begin
    --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
      'insert into meta_sortorder
            --
          select * from(
           select
            --
            s.tabid,
            --
            m.colid,
            m.sortorder,
            m.sortway
            from meta_sortorder'||g_link||' m, meta_tables'||g_link||' t, meta_tables s
             where m.tabid=t.tabid
             and upper(t.tabname)=upper(s.tabname))
             where (tabid, colid) not in (select tabid, colid from meta_sortorder)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
  end fill_meta_sortorder;

  ---
  -- Import meta_extrnval
  --

  procedure fill_meta_extrnval
  is
   p               constant varchar2(62) := G_PKG||'.fill_meta_extrnval';
  begin
     --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
     ' insert into meta_extrnval(TABID,
                                 COLID,
                                 SRCTABID,
                                 SRCCOLID,
                                 TAB_ALIAS,
                                 TAB_COND)
                select * from(select
                 s.tabid,
                 m.colid,
                 k.tabid SRCTABID,
                 m.srccolid,
                 m.tab_alias,
                 m.tab_cond
                 from meta_extrnval'||g_link||' m , meta_tables'||g_link||' t, meta_tables s  , meta_tables k, meta_tables'||g_link||' n
             where m.tabid=t.tabid
             and upper(t.tabname)=upper(s.tabname)
             and m.srctabid=n.tabid
             and upper(n.tabname)=upper(k.tabname)
             )
             where (tabid, colid) not in (select tabid, colid from meta_extrnval)
             and (tabid, colid)  in (select tabid, colid from meta_columns)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
  end fill_meta_extrnval;

  ---
  --Import  meta_browsetbl
  --

   procedure fill_meta_browsetbl
   is
    p               constant varchar2(62) := G_PKG||'.fill_meta_browsetbl';
   begin
     --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
     'insert into meta_browsetbl(
             HOSTTABID,
             ADDTABID,
             ADDTABALIAS,
             HOSTCOLKEYID,
             ADDCOLKEYID,
             VAR_COLID,
             COND_TAG )
            select * from(
            select
             s.tabid HOSTTABID,
             k.tabid ADDTABID,
             m.addtabalias,
             m.hostcolkeyid,
             m.addcolkeyid,
             m.var_colid,
             m.cond_tag
            from meta_browsetbl'||g_link||' m  , meta_tables'||g_link||' t, meta_tables s , meta_tables k, meta_tables'||g_link||' n
             where m.hosttabid=t.tabid
             and upper(t.tabname)=upper(s.tabname)
             and m.addtabid=n.tabid
             and upper(n.tabname)=upper(k.tabname))
             where (HOSTTABID, HOSTCOLKEYID, ADDTABID, ADDCOLKEYID, VAR_COLID) not in(select HOSTTABID, HOSTCOLKEYID, ADDTABID, ADDCOLKEYID, VAR_COLID from meta_browsetbl)
             and (ADDTABID, VAR_COLID) in(select tabid, colid from meta_columns)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
    end fill_meta_browsetbl;

    ---
    -- Import meta_filtercodes
    --

    procedure fill_meta_filtercodes
    is
     p               constant varchar2(62) := G_PKG||'.fill_meta_filtercodes';
    begin
         --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
        ' insert into meta_filtercodes
              select m.*
                from meta_filtercodes'||g_link||' m
               where code not in (select code from meta_filtercodes)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
    end fill_meta_filtercodes;

    ---
    -- Import meta_filtertbl
    --

procedure fill_meta_filtertbl
      is
       p               constant varchar2(62) := G_PKG||'.fill_meta_filtertbl';
begin
        --
         --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
        'insert into meta_filtertbl(TABID,
                                    COLID,
                                    FILTER_TABID,
                                    FILTER_CODE)
         select * from(select
         s.tabid,
         m.colid,
         k.tabid FILTER_TABID,
         m.filter_code
         from meta_filtertbl'||g_link||' m, meta_tables'||g_link||' t, meta_tables s , meta_tables k, meta_tables'||g_link||' n
             where m.tabid=t.tabid
             and upper(t.tabname)=upper(s.tabname)
             and m.filter_tabid=n.tabid
             and upper(n.tabname)=upper(k.tabname))
             where (tabid, colid) not in(select tabid, colid from meta_filtertbl)'
             ;

         --
         commit;
         --
         to_root();
         --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
end fill_meta_filtertbl;
      ---
      -- Процедура импорта справоников
      --

procedure fill_references
is
p               constant varchar2(62) := G_PKG||'.fill_references';
begin
         --
    trace('%s: entry point', p);
    --
    init();
    --

   begin
       execute immediate
        'insert into references
            select
            t2.tabid  tabid,
            nvl(m.type,99),
            m.dlgname,
            upper(m.role2edit)
            from references'||g_link||' m, meta_tables'||g_link||' t , meta_tables t2
            where m.tabid=t.tabid
            and upper(t.tabname)=t2.tabname
            and t2.tabid not in(select tabid from references)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
        --
end fill_references;

---
-- Import META_ACTIONTBL
--
procedure fill_meta_actiontbl
is
p               constant varchar2(62) := G_PKG||'.fill_meta_sortorder';
begin
             --
    trace('%s: entry point', p);
    --
    init();
    --

   begin
       execute immediate
            'insert into meta_actiontbl
             select
                       s.tabid,
                       m.action_code,
                       m.action_proc
             from meta_actiontbl'||g_link||' m , meta_tables'||g_link||' t, meta_tables s
             where m.tabid=t.tabid
             and upper(t.tabname)=upper(s.tabname)
             and (s.tabid, m.action_code) not in(select tabid, action_code from meta_actiontbl)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
end fill_meta_actiontbl;

 ---
 -- Импорт синхронизируемых таблиц
 --
procedure fill_dbf_sync_tabs
is
p               constant varchar2(62) := G_PKG||'.fill_dbf_sync_tabs';
 begin
         --
    trace('%s: entry point', p);
    --
    init();
    --

     begin
       execute immediate
        ' insert into  dbf_sync_tabs
                       select m.tabid,
                                t.s_select,
                                t.s_insert,
                                t.s_update,
                                t.s_delete,
                                t.file_date,
                                t.sync_flag,
                                t.encode,
                                t.file_name
                       from dbf_sync_tabs'||g_link||' t, meta_tables'
                                ||g_link||' km,
                               meta_tables m
                  where  t.tabid=km.tabid
                    and km.tabname=m.tabname
                    and m.tabid not in(select tabid from dbf_sync_tabs)';

                --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
      end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
 end fill_dbf_sync_tabs;


---
-- fill_refapp
--
procedure fill_refapp
  is
    l_errtab    constant varchar2(30) := 'ERR$_REFAPP';
  begin
   --
   init();
   --
    mantain_error_table('REFAPP');
   --
    sync_table(
       'REFAPP',
       'insert
          into bars.refapp (
               tabid,
               codeapp,
               acode,
               approve,
               adate1,
               adate2,
               rdate1,
               rdate2,
               revoked,
               grantor)
        select c.tabid,
               d.codeapp,
               nvl(a.acode,''RO''),
               a.approve,
               a.adate1,
               a.adate2,
               a.rdate1,
               a.rdate2,
               a.revoked,
               decode(a.grantor, null, null, 1, 1, to_number(to_char(a.grantor))) as grantor
               from refapp'||g_link||' a, meta_tables'||g_link||' b, bars.meta_tables c, bars.applist d
         where a.tabid=b.tabid
           and upper(b.tabname)=c.tabname
           and a.codeapp = d.codeapp
        log errors reject limit unlimited
       '
       ,
       true
    );
    --
    trace('%s', get_errinfo(l_errtab));
    --
  end fill_refapp;

---
-- Досоздание нехватающих ролей
--
procedure create_role
is
begin
    for c in(select role_name from roles$base
              where role_name not in(select role from dba_roles))
loop
 begin
  --
    execute immediate 'create role '||c.role_name;
  --
  exception when others then null;
  end;
end loop;
end create_role;

  ---
  -- fill_zapros - наполнение zapros
  --
procedure fill_zapros
  is
    l_stmt   varchar2(1024);
    l_zapros           clob;
    p               constant varchar2(62) := G_PKG||'.fill_zapros';
 begin
   --
   trace('иногда встречаются левые значения в zapros.id, чистим');
   --
   init();
   --
   begin
      --
       l_stmt :=  'update zapros'||g_link||' set id=1 where nvl(id,1) not in (select id from staff'||g_link||')';
      --
       trace(l_stmt);
      --
       execute immediate l_stmt;
      --
       trace('%s rows updated', to_char(sql%rowcount));
      --
       commit;
      --
   end;
   --
   begin
     --
     trace('%s: started', p);
     --
      execute immediate 'INSERT
            INTO BARS.ZAPROS (
                   KODZ, ID, NAME,
                   NAMEF, BINDVARS, CREATE_STMT,
                   RPT_TEMPLATE, KODR, FORM_PROC,
                   DEFAULT_VARS, CREATOR, BIND_SQL,
                   XSL_DATA, TXT, XSD_DATA,
                   XML_ENCODING, PKEY)
             SELECT
                    kodz,
                    nvl(ID,1),
                    nvl(NAME, ''Empty''),
                    NAMEF,
                    BINDVARS,
                    CREATE_STMT,
                    RPT_TEMPLATE,
                    KODR,
                    FORM_PROC,
                    DEFAULT_VARS,
                    nvl(CREATOR,1),
                    BIND_SQL,
                    XSL_DATA,
                    TXT,
                    XSD_DATA,
                    XML_ENCODING,
                    PKEY
            FROM zapros'||g_link||' z
           where z.pkey not in (select pkey from zapros)';
        --
                commit;
                --
                to_root();
                --
        exception
            when others then
                rollback;
                save_error();
    end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
  end fill_zapros;

  ---
  -- fill_reports - наполнение reports
  --
procedure fill_reports
  is
    l_zapros           clob;
    p               constant varchar2(62) := G_PKG||'.fill_reports';
 begin
   --
   init();
   --
   begin
     --
     trace('%s: started', p);
     --
      execute immediate' insert into reports(id,
                                             name,
                                             description,
                                             form,
                                             param,
                                             ndat,
                                             wt,
                                             mask,
                                             namew,
                                             path,
                                             wt2,
                                             idf,
                                             nodel,
                                             dbtype,
                                             emptyfiles,
                                             usearc)
        select
         r.id,
         r.name,
         nvl(r.description, ''Empty''),
         r.form,
         r.param,
         r.ndat,
         r.wt,
         r.mask,
         r.namew,
         r.path,
         r.wt2,
         r.idf,
         r.nodel,
         r.dbtype,
         0 emptyfiles,
         0 user_arc
        from reports'||g_link||' r
        where r.id not in(select id from reports) ';
        --
        commit;
        --
        to_root();
        --
        exception
            when others then
                rollback;
                save_error();
    end;
    --
    to_root();
    --
    trace('%s: finished', p);
    --
  end fill_reports;

procedure add_grant
    is
BEGIN
   FOR k IN (SELECT object_name, object_type
               FROM all_objects
              WHERE     owner = 'BARS'
                    AND object_type IN ('VIEW','TABLE')
                    AND object_name NOT IN (SELECT table_name
                                              FROM all_tab_privs
                                             WHERE table_schema = 'BARS'))
   LOOP
      IF k.object_type = 'TABLE'
      THEN
       begin
         EXECUTE IMMEDIATE
               'grant select, insert, update, delete on '
            || k.object_name
            || ' to START1';

         EXECUTE IMMEDIATE
               'grant select, insert, update, delete on '
            || k.object_name
            || ' to bars_access_defrole';
       exception when others then null;
      end;
      END IF;

      IF k.object_type = 'VIEW'
      THEN
       begin
         EXECUTE IMMEDIATE 'grant select on ' || k.object_name || ' to START1';

         EXECUTE IMMEDIATE
            'grant select on ' || k.object_name || ' to bars_access_defrole';
       exception when others then null;
       end;
      END IF;
   END LOOP;
END add_grant;

end mgr_commerc2;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mgr_commerc2.sql =========*** End **
 PROMPT ===================================================================================== 
 