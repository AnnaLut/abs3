
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpt_adm.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DPT_ADM 
is
   g_header_version   constant varchar2 (64) := 'version 1.16 08.12.2016';
   title              constant varchar2 (8) := 'dpt_adm:';
   function header_version return varchar2;
   function body_version return varchar2;

   -- ТИПЫ депозитов
   type r_dpt_type_rec is record
   (
      type_id     dpt_types.type_id%type,
      type_name   dpt_types.type_name%type,
      type_code   dpt_types.type_code%type,
      fl_active   varchar2 (50),
      fl_demand   varchar2 (50),
	  fl_webbanking   varchar2 (50),
      sort_ord    int,
      fl_act      dpt_types.fl_active%type,
      fl_dem      dpt_types.fl_demand%type,
	  fl_wb       dpt_types.fl_webbanking%type,
      count_active int
   );

   type t_dpt_type_set is table of r_dpt_type_rec;

   function get_dpt_type_sets return t_dpt_type_set pipelined;
  procedure savetype(
      p_type_id      in dpt_types.type_id%type,
      p_type_name    in dpt_types.type_name%type,
      p_type_code    in dpt_types.type_code%type,
      p_fl_act       in dpt_types.fl_active%type,
      p_fl_dem       in dpt_types.fl_demand%type,
	  p_fl_wb        in dpt_types.fl_webbanking%type,
      p_sort_ord     in int default 0,
      p_resultcode    out decimal,
      p_resulmessage  out varchar2
   );

   -- виды депозитов
   -- сокращенная форма для экрана
   type r_dpt_vidd_rec is record
   (
      flag            varchar2 (50),
      flagid          int,
      vidd            dpt_vidd.vidd%type,
      type_cod        dpt_vidd.type_cod%type,
      kv              dpt_vidd.kv%type,
      type_name       dpt_vidd.type_name%type,
      countactive     number (38),
      duration        varchar2 (15),
      duration_days   varchar2 (15),
      min_summ        varchar2 (15),
      limit           varchar2 (15),
      freq_k          varchar2 (100),
      fl_dubl         dpt_vidd.fl_dubl%type,
      type_id         dpt_vidd.type_id%type
   );

   type t_dpt_vidd_set is table of r_dpt_vidd_rec;
   function get_dpt_vidd_sets (p_type_id in number) return t_dpt_vidd_set pipelined;

   -- полная информация о видe

   type r_dpt_vidd_inforec is record
   (
      vidd                varchar2(40),
      deposit_cod         varchar2(40),
      type_name           varchar2(140),
      basey               varchar2(4),
      basem               varchar2(4),
      br_id               varchar2(40),
      freq_n              varchar2(40),
      freq_k              varchar2(40),
      bsd                 varchar2(40),
      bsn                 varchar2(40),
      metr                varchar2(40),
      amr_metr            varchar2(40),
      duration            varchar2(40),
      term_type           varchar2(40),
      min_summ            varchar2(40),
      comments            varchar2(400),
      flag                varchar2(40),
      type_cod            varchar2(40),
      kv                  varchar2(40),
      tt                  varchar2(40),
      shablon             varchar2(40),
      idg                 varchar2(40),
      ids                 varchar2(40),
      nls_k               varchar2(40),
      datn                varchar2(40),
      datk                varchar2(40),
      br_id_l             varchar2(40),
      fl_dubl             varchar2(40),
      acc7                varchar2(40),
      id_stop             varchar2(40),
      kodz                varchar2(40),
      fmt                 varchar2(40),
      fl_2620             varchar2(40),
      comproc             varchar2(40),
      limit               varchar2(40),
      term_add            varchar2(40),
      term_dubl           varchar2(40),
      duration_days       varchar2(40),
      extension_id        varchar2(40),
      tip_ost             varchar2(40),
      br_wd               varchar2(40),
      nlsn_k              varchar2(40),
      bsa                 varchar2(40),
      max_limit           varchar2(40),
      br_bonus            varchar2(40),
      br_op               varchar2(40),
      auto_add            varchar2(40),
      type_id             varchar2(40),
      disable_add         varchar2(40),
      code_tariff         varchar2(40),
      duration_max        varchar2(40),
      duration_days_max   varchar2(40),
      irrevocable         varchar2(40)
   );

   type t_dpt_vidd_info is table of r_dpt_vidd_inforec;
   function get_dpt_vidd_info (p_vidd in number) return t_dpt_vidd_info pipelined;
   -----------------------------------------------------------
   -- автооперации
   -----------------------------------------------------------
   type r_dpt_job is record
   (
      JOB_ID     dpt_jobs_list.JOB_ID%type,
      job_code   dpt_jobs_list.job_code%type,
      job_name   dpt_jobs_list.job_name%type,
      job_proc   dpt_jobs_list.job_proc%type,
      ord        dpt_jobs_list.ord%type
   );

   type t_dpt_job_set is table of r_dpt_job;
   function get_dpt_jobs return t_dpt_job_set pipelined;
   ----------------------------------------------------------
   -- справочники любые
   -----------------------------------------------------------
   type r_kv_rec is record(
      kv     tabval$global.kv%type,
      lcv    tabval$global.lcv%type,
      name   tabval$global.name%type);

   type t_kv_set is table of r_kv_rec;
   function get_kv return t_kv_set pipelined;
------------------------------------------------------
   type r_bsd_rec is record(bsd ps.nbs%type, name ps.name%type);
   type t_bsd_set is table of r_bsd_rec;
   function get_bsd return t_bsd_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_bsn_rec is record(bsn ps.nbs%type, name ps.name%type);
   type t_bsn_set is table of r_bsn_rec;
   function get_bsn(p_bsd in varchar2) return t_bsn_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_bsa_rec is record(bsa ps.nbs%type, name ps.name%type);
   type t_bsa_set is table of r_bsa_rec;
   function get_bsa(p_bsd in varchar2, p_flag in varchar2) return t_bsa_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_basey_rec is record(basey int, name varchar2(500));
   type t_basey_set is table of r_basey_rec;
   function get_basey return t_basey_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_freq_rec is record(freq int, name varchar2(50));
   type t_freq_set is table of r_freq_rec;
   function get_freq return t_freq_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_metr_rec is record(metr int, name varchar2(50));
   type t_metr_set is table of r_metr_rec;
   function get_metr return t_metr_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_ion_rec is record (io int, name varchar2(50));
   type t_ion_set is table of r_ion_rec;
   function get_ion return t_ion_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_brates_rec is record (
    br_id       brates.br_id%type,
    br_type     brates.br_type%type,
    comm        brates.comm%type,
    formula     brates.formula%type,
    inuse       brates.inuse%type,
    name        brates.name%type
   );
   type t_brates_set is table of r_brates_rec;
   function get_brates return t_brates_set pipelined;
------------------------------------------------------------------------------------------------------------
   type r_stop_rec is record (
    id          dpt_stop.id%type,
    name        dpt_stop.name%type,
    fl          dpt_stop.fl%type,
    sh_proc     dpt_stop.sh_proc%type,
    sh_ost      dpt_stop.sh_ost%type,
    mod_code    dpt_stop.mod_code%type
   );
   type t_stop_set is table of r_stop_rec;
   function get_dpt_stop return t_stop_set pipelined;
------------------------------------------------------------------------------------------------------------
  type r_dpt_vidd_extypes_rec is record (
    id              dpt_vidd_extypes.id%type,
    name            dpt_vidd_extypes.name%type,
    bonus_proc      dpt_vidd_extypes.bonus_proc%type,
    bonus_rate      dpt_vidd_extypes.bonus_rate%type,
    ext_condition   dpt_vidd_extypes.ext_condition%type
   );
   type t_dpt_vidd_extypes_set is table of r_dpt_vidd_extypes_rec;
   function get_dpt_vidd_extypes return t_dpt_vidd_extypes_set pipelined;
------------------------------------------------------------------------------------------------------------
  type r_tarif_rec is record (
    kod             tarif.kod%type,
    name            tarif.name%type
   );
   type t_tarif_set is table of r_tarif_rec;
   function get_tarif return t_tarif_set pipelined;
----------------------------------------------------------------------------------------------------

  procedure savevidd (  p_vidd varchar2,
                        p_type_cod    varchar2,
                        p_type_name    varchar2,
                        p_basey    varchar2,
                        p_basem    varchar2,
                        p_br_id    varchar2,
                        p_freq_n    varchar2,
                        p_freq_k    varchar2,
                        p_bsd    varchar2,
                        p_bsn    varchar2,
                        p_metr    varchar2,
                        p_amr_metr    varchar2,
                        p_duration    varchar2,
                        p_term_type    varchar2,
                        p_min_summ    varchar2,
                        p_comments    varchar2,
                        p_deposit_cod    varchar2,
                        p_kv    varchar2,
                        p_tt    varchar2,
                        p_shablon    varchar2,
                        p_idg    varchar2,
                        p_ids    varchar2,
                        p_nls_k    varchar2,
                        p_datn    varchar2,
                        p_datk    varchar2,
                        p_br_id_l    varchar2,
                        p_fl_dubl    varchar2,
                        p_acc7    varchar2,
                        p_id_stop    varchar2,
                        p_kodz    varchar2,
                        p_fmt    varchar2,
                        p_fl_2620    varchar2,
                        p_comproc    varchar2,
                        p_limit    varchar2,
                        p_term_add    varchar2,
                        p_term_dubl    varchar2,
                        p_duration_days    varchar2,
                        p_extension_id    varchar2,
                        p_tip_ost    varchar2,
                        p_br_wd    varchar2,
                        p_nlsn_k    varchar2,
                        p_bsa    varchar2,
                        p_max_limit    varchar2,
                        p_br_bonus    varchar2,
                        p_br_op    varchar2,
                        p_auto_add    varchar2,
                        p_type_id    varchar2,
                        p_disable_add    varchar2,
                        p_code_tariff    varchar2,
                        p_duration_max    varchar2,
                        p_duration_days_max    varchar2,
                        p_irrevocable    varchar2,
                        p_resultcode       out decimal,
                        p_resultmessage    out varchar2);

------------------------------------------
 type r_newtype is record ( type_id     dpt_types.type_id%type,     --Числ.код типа договора
                            type_name   dpt_types.type_name%type,   --Наименование типа договора
                            type_code   dpt_types.type_code%type,   --Симв.код типа договора
                            sort_ord    dpt_types.sort_ord%type,    --Порядок сортировки
                            fl_active   dpt_types.fl_active%type,   --Ознака активності продукту
                            fl_demand   dpt_types.fl_demand%type    --Ознака депозитного продукту "До запитання"
                            );

 procedure shift(p_type_id in dpt_types.type_id%type, p_direction in int);
 procedure activatetype(p_type_id in dpt_types.type_id%type);
 procedure setWBType(p_type_id in dpt_types.type_id%type);
 procedure activatevidd(p_vidd in dpt_vidd.vidd%type);

 --tts
    type r_tts_rec is record
   (    vidd            dpt_vidd.vidd%type,
        added           char(1),
        op_type         char (3 byte),
        op_name         varchar2 (70 byte),
        tt_id           number (38),
        tt_name         varchar2 (40 byte),
        tt_cash         number
   );
   type t_dpt_tts_set is table of r_tts_rec;
   function get_viddtts(p_vidd in number) return t_dpt_tts_set pipelined;

   --vidd_scheme
    type r_doc_rec is record
   (    active  int,
        vidd    dpt_vidd.vidd%type,
        flg     number,
        name    varchar2(500),
        doc     varchar2(500),
        doc_fr  varchar2(500)
   );

   type t_dpt_doc_set is table of r_doc_rec;
   function get_vidddoc(p_vidd in number) return t_dpt_doc_set pipelined;
   procedure addtts(p_vidd in dpt_types.type_id%type, p_tts in char);
   procedure AddDOC2Vidd(p_vidd in dpt_vidd.vidd%type, p_flg in int, p_doc in varchar2, p_doc_fr in varchar2);
   procedure AddDOC2Type(p_type IN dpt_vidd.type_id%type, p_FLG in int, p_DOC in varchar2, p_DOC_FR in varchar2);
   type r_docshceme_rec is record
   (    id      doc_scheme.id%type
   );

   type t_dpt_docshceme_set is table of r_docshceme_rec;
   function get_vidddocscheme(p_fr in int) return t_dpt_docshceme_set pipelined;

   type r_dptarc_rec is record
   (    deposit_id  dpt_deposit_clos.deposit_id%type,
        nd          dpt_deposit_clos.nd%type,
        kv          dpt_deposit_clos.kv%type,
        branch      dpt_deposit_clos.branch%type,
        acc         dpt_deposit_clos.acc%type,
        nls         accounts.nls%type,
        rnk         dpt_deposit_clos.rnk%type,
        nmk         customer.nmk%type,
        ostd        number,
        ostdq       number,
        ostp        number,
        ostpq       number,
        vidd        dpt_deposit_clos.vidd%type,
        vidd_name   dpt_vidd.type_name%type,
        ir          number,
        dat_begin   dpt_deposit_clos.dat_begin%type,
        dat_end     dpt_deposit_clos.dat_end%type,
        cnt_dubl    dpt_deposit_clos.cnt_dubl%type,
        userid      dpt_deposit_clos.userid%type,
        dazs        accounts.dazs%type,
        dos         number,
        kos         number,
        cdat        date,
        idupd       dpt_deposit_clos.idupd%type,
        docreq      varchar2(100),
        pdate       person.pdate%type,
        porgan      person.organ%type,
        passpname   passp.name%type
   );

   type t_dptarc_set is table of r_dptarc_rec;
   function get_dptarc(p_date date, p_vidd dpt_vidd.vidd%type, p_branch branch.branch%type) return t_dptarc_set pipelined;

   type r_vidd_rec is record
   (    vidd        dpt_vidd.vidd%type,
        type_name   varchar2(500)
   );

   type t_vidd_set is table of r_vidd_rec;
   function get_viddlist return t_vidd_set pipelined;

   type r_branch_rec is record
   (    branch_      branch.branch%type,
        name         branch.name%type
   );

   type t_branch_set is table of r_branch_rec;
   function get_branchlist return t_branch_set pipelined;

   procedure deletetype(p_type_id number,
                        p_resultcode       out decimal,
                        p_resultmessage    out varchar2);
   procedure deletevidd(p_vidd number,
                        p_resultcode       out decimal,
                        p_resultmessage    out varchar2);


   type r_viddparam_rec is record (vidd  dpt_vidd.vidd%type,
                                   tag   dpt_vidd_tags.tag%type,
                                   name  dpt_vidd_tags.name%type,
                                   editable dpt_vidd_tags.editable%type,
                                   val   dpt_vidd_params.val%type);
   type t_viddparam_set is table of r_viddparam_rec;
   function get_viddparam(p_vidd in dpt_vidd.vidd%type) return t_viddparam_set pipelined;
   procedure setParam(p_vidd in dpt_vidd.vidd%type,p_tag dpt_vidd_tags.tag%type, p_val dpt_vidd_params.val%type);

   type r_dictlist is record (tabid number, tabname varchar2(500), semantic varchar2(500));
   type t_dicttlist_set is table of r_dictlist;
   function getDicts return t_dicttlist_set pipelined;

   function get_DOCSCHEME(p_type int) return t_DPT_DOC_SET pipelined;
   procedure ClearDOC2Vidd(p_vidd dpt_vidd.vidd%type, p_flg dpt_vidd_scheme.flags%type);
   procedure ClearDOC2Type(p_type dpt_vidd.type_id%type, p_flg dpt_vidd_scheme.flags%type);


  type r_jobjrnl_rec is record
   (   run_id       dpt_jobs_jrnl.run_id%type,
       job_id       dpt_jobs_jrnl.job_id%type,
       start_date   dpt_jobs_jrnl.start_date%type,
       finish_date  dpt_jobs_jrnl.finish_date%type,
       bank_date    dpt_jobs_jrnl.bank_date%type,
       user_id      dpt_jobs_jrnl.user_id%type,
       status       dpt_jobs_jrnl.status%type,
       errmsg       dpt_jobs_jrnl.errmsg%type,
       branch       dpt_jobs_jrnl.branch%type,
       deleted      dpt_jobs_jrnl.deleted%type,
       kf           dpt_jobs_jrnl.kf%type
   );
   type t_jobjrnl_rec_set is table of r_jobjrnl_rec;
   function get_dptjobjrnl(p_job_id in number) return t_jobjrnl_rec_set pipelined;

    type r_joblog_rec is record
   (
   rec_id       dpt_jobs_log.rec_id%type,
   run_id       dpt_jobs_log.run_id%type,
   job_id       dpt_jobs_log.job_id%type,
   dpt_id       dpt_jobs_log.dpt_id%type,
   branch       dpt_jobs_log.branch%type,
   ref          dpt_jobs_log.ref%type,
   rnk          dpt_jobs_log.rnk%type,
   kv           dpt_jobs_log.kv%type,
   dpt_sum      dpt_jobs_log.dpt_sum%type,
   int_sum      dpt_jobs_log.int_sum%type,
   status       dpt_jobs_log.status%type,
   errmsg       dpt_jobs_log.errmsg%type,
   nls          dpt_jobs_log.nls%type,
   contract_id  dpt_jobs_log.contract_id%type,
   deal_num     dpt_jobs_log.deal_num%type,
   rate_val     dpt_jobs_log.rate_val%type,
   rate_dat     dpt_jobs_log.rate_dat%type,
   kf           dpt_jobs_log.kf%type);
   type t_joblog_rec_set is table of r_joblog_rec;
   function get_dptjoblog(p_run_id in number) return t_joblog_rec_set  pipelined;

   type r_dptstop is record (ID dpt_stop.id%type, NAME dpt_stop.NAME%type, FL dpt_stop.FL%type, SH_PROC dpt_stop.SH_PROC%type, SH_OST dpt_stop.SH_OST%type, MOD_CODE dpt_stop.MOD_CODE%type);
   procedure DelPenalty(p_ID in dpt_stop.id%type, p_message out varchar2);
   procedure InsPenalty(p_NAME dpt_stop.NAME%type, p_FL dpt_stop.FL%type, p_SH_PROC dpt_stop.SH_PROC%type, p_SH_OST dpt_stop.SH_OST%type, p_MOD_CODE dpt_stop.MOD_CODE%type, p_message out varchar2);
   procedure UpdPenalty(p_ID dpt_stop.id%type, p_NAME dpt_stop.NAME%type, p_FL dpt_stop.FL%type, p_SH_PROC dpt_stop.SH_PROC%type, p_SH_OST dpt_stop.SH_OST%type, p_MOD_CODE dpt_stop.MOD_CODE%type, p_message out varchar2);
   procedure FillPenalty(p_ID dpt_stop_a.id%type,
                         p_K_SROK dpt_stop_a.K_SROK%type,
                         p_K_PROC dpt_stop_a.K_PROC%type,
                         p_SH_PROC dpt_stop_a.SH_PROC%type,
                         p_K_TERM dpt_stop_a.K_TERM%type,
                         p_SH_TERM dpt_stop_a.SH_TERM%type);
   procedure DelFillPenalty(p_ID in dpt_stop_a.id%type, p_K_SROK dpt_stop_a.K_SROK%type, p_message OUT varchar2);



end dpt_adm;
/
CREATE OR REPLACE PACKAGE BODY BARS.DPT_ADM 
IS
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 1.23 06.03.2017';

   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body DPT_ADM ' || g_body_version;
   END body_version;


   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body DPT_ADM ' || g_body_version;
   END header_version;


   FUNCTION get_DPT_TYPE_SETS
      RETURN t_DPT_TYPE_SET
      PIPELINED
   IS
      l_DPT_TYPE_REC   r_DPT_TYPE_REC;
   BEGIN
      FOR i
         IN (  SELECT type_id,
                      type_name,
                      type_code,
                      CASE fl_active
                         WHEN 1 THEN 'Активний'
                         WHEN 0 THEN 'Не використовується'
                         ELSE 'Без ознаки'
                      END
                         fl_active,
                      CASE fl_demand
                         WHEN 1 THEN 'До запитання'
                         ELSE 'Строковий'
                      END
                         fl_demand,
					 CASE fl_webbanking
                         WHEN 1 THEN 'Використовується'
                         ELSE 'Не використовується'
                      END
                         fl_webbanking,
                      sort_ord,
                      NVL (fl_active, -1) fl_act,
                      fl_demand as fl_dem,
					  NVL (fl_webbanking, 0) fl_wb,
                      (select count(deposit_id) from dpt_deposit where vidd in (select vidd from dpt_vidd v where t.type_id = v.type_id)) as count_active
                 FROM dpt_types t
             ORDER BY sort_ord, NVL (fl_active, -1) )
      LOOP
         l_DPT_TYPE_REC.type_id := i.type_id;
         l_DPT_TYPE_REC.type_name := i.type_name;
         l_DPT_TYPE_REC.type_code := i.type_code;
         l_DPT_TYPE_REC.fl_active := i.fl_active;
         l_DPT_TYPE_REC.fl_demand := i.fl_demand;
		 l_DPT_TYPE_REC.fl_webbanking := i.fl_webbanking;
         l_DPT_TYPE_REC.sort_ord := i.sort_ord;
         l_DPT_TYPE_REC.fl_act := i.fl_act;
         l_DPT_TYPE_REC.fl_dem := i.fl_dem;
		 l_DPT_TYPE_REC.fl_wb := i.fl_wb;
         l_DPT_TYPE_REC.count_active := i.count_active;
         PIPE ROW (l_DPT_TYPE_REC);
      END LOOP;
   END;

   procedure saveType(
      p_type_id      IN dpt_types.type_id%TYPE,
      p_type_name    IN dpt_types.type_name%TYPE,
      p_type_code    IN dpt_types.type_code%TYPE,
      p_fl_act       IN dpt_types.fl_active%TYPE,
      p_fl_dem       IN dpt_types.fl_demand%TYPE,
	  p_fl_wb        in dpt_types.fl_webbanking%type,
      p_sort_ord     IN INT default 0,
      p_resultcode      OUT decimal,
      p_resulmessage    OUT varchar2)
   is
     l_context varchar2(30) := sys_context('bars_context','user_branch');
     l_type_id dpt_types.type_id%TYPE;
     l_type_code dpt_types.type_code%TYPE;
     l_unique int := 0;
   begin
    p_resultcode:=0;
    l_type_id := p_type_id;
    bars_audit.info('dpt_adm.saveType started with p_type_id = '||to_char(p_type_id)
    ||',p_type_name='||p_type_name||',p_type_code = '||p_type_code||', p_fl_act='||to_char(p_fl_act)||',p_fl_dem='||to_char(p_fl_dem)||',p_fl_wb='||to_char(p_fl_wb)||',p_sort_ord='|| to_char(p_sort_ord));
    bc.go('/');

    if (p_type_id is null)
    then
        p_resultcode := -1;
        p_resulmessage := 'Не введено номера типу вкладу!';
        bc.go(l_context);
        return;
    end if;

    if (p_type_code is null)
    then
        p_resultcode := -1;
        p_resulmessage := 'Не введено код типу вкладу!';
        bc.go(l_context);
        return;
    end if;

    if (p_type_name is null)
    then
        p_resultcode := -1;
        p_resulmessage := 'Не введена назва типу вкладу!';
        bc.go(l_context);
        return;
    end if;

    if (p_fl_act is null)
    then
        p_resultcode := -1;
        p_resulmessage := 'Не введена активність типу вкладу!';
        bc.go(l_context);
        return;
    end if;
    if (p_fl_dem is null)
    then
        p_resultcode := -1;
        p_resulmessage := 'Не введена строковість типу вкладу!';
        bc.go(l_context);
        return;
    end if;

    -- проверка на уникальность
    begin
     select 1
       into l_unique
       from dpt_types
      where type_id = p_type_id
        and type_code = p_type_code;
    exception when no_data_found then l_unique:= null;
    end;

    if l_unique is null
            then
             begin
             select type_code
               into l_type_code
               from dpt_types
          where type_id = p_type_id
            and type_code != p_type_code;
         p_resultcode := -1;
         p_resulmessage := 'Тип вкладу з номером '|| to_char(l_type_id) ||' вже існує з кодом '||l_type_code||'!';
         bars_audit.info(l_type_code);
         bc.go(l_context);
         return;
      exception when no_data_found
      then
           begin
             select type_id
               into l_type_id
               from dpt_types
              where type_name = p_type_code
                and type_id != l_type_id;
             p_resultcode := -1;
             p_resulmessage := 'Тип вкладу з кодом '|| p_type_code ||' вже існує з номером '||to_char(l_type_id)||'!';
           exception when no_data_found then l_unique := 0; -- точно новый
           end;
      end;
    end if;

    if (l_unique = 1 ) -- уже существует - номер и код совпадают, обновляем другие реквизиты
    then
        begin
        update dpt_types
           set type_name  = p_type_name,
               fl_active  = p_fl_act,
               fl_demand  = p_fl_dem,
			   fl_webbanking = p_fl_wb,
               sort_ord   = p_sort_ord
         where type_id = p_type_id
           and type_code  = p_type_code;
          p_resulmessage := 'Оновлено тип з кодом '|| p_type_code ||' під номером '||to_char(l_type_id);
        exception when others
         then   p_resultcode := -1;
                p_resulmessage := sqlerrm;
                bc.go(l_context);
                return;
        end;
    elsif (l_unique = 0) -- не существует и не нарушает уникальность - добавляем
     then
         begin
             select max(type_id)+1
               into l_type_id
               from dpt_types;
             begin
                 insert into dpt_types (type_id, type_name, type_code, fl_active, fl_demand, fl_webbanking, sort_ord)
             values (p_type_id,
                         p_type_name,
                         p_type_code,
                         p_fl_act,
                         p_fl_dem,
						 p_fl_wb,
                         p_sort_ord);
               p_resulmessage := 'Збережено тип з кодом '|| p_type_code ||' під номером '||to_char(l_type_id);
               p_resultcode := 0;
             exception
             when others then
               p_resultcode := -1;
               p_resulmessage := sqlerrm;
               bc.go(l_context);
               return;
             end;
         end;
    end if;
    bc.go(l_context);
    bars_audit.info(to_char(p_resultcode)||', mess='|| p_resulmessage);
   end;

   -- узкий список депозитных видов для экрана

   FUNCTION get_DPT_VIDD_SETS(p_TYPE_ID IN number)
      RETURN t_DPT_VIDD_SET
      PIPELINED
   IS
      l_DPT_VIDD_REC   r_DPT_VIDD_REC;
   BEGIN
      bars_audit.trace ('get_DPT_VIDD_SETS start with p_TYPE_ID = '||to_char(p_TYPE_ID));

      FOR i
         IN (  SELECT CASE NVL (dv.flag, 0)
                         WHEN 1 THEN 'Активний'
                         WHEN 0 THEN 'Не активний'
                         ELSE 'Без ознаки'
                      END
                         flag,
                      NVL (dv.flag, 0) flagid,
                      vidd,
                      TYPE_COD,
                      KV,
                      TYPE_NAME,
                      (SELECT COUNT (*)
                         FROM dpt_deposit
                        WHERE vidd = dv.VIDD)
                         AS CountActive,
                      NVL (TO_CHAR (DURATION), '-') DURATION,
                      NVL (TO_CHAR (DURATION_DAYS), '-') DURATION_DAYS,
                      NVL (TO_CHAR (MIN_SUMM), '-') MIN_SUMM,
                      NVL (TO_CHAR (LIMIT), '-') LIMIT,
                      (SELECT name
                         FROM freq
                        WHERE freq = dv.FREQ_K)
                         FREQ_K,
                      FL_DUBL,
                      TYPE_ID
                 FROM dpt_vidd dv
                 where type_id = p_TYPE_ID
             ORDER BY dv.vidd, NVL (dv.flag, -1))
      LOOP
         l_DPT_VIDD_REC.flag := i.flag;
         l_DPT_VIDD_REC.flagid := i.flagid;
         l_DPT_VIDD_REC.vidd := i.vidd;
         l_DPT_VIDD_REC.TYPE_COD := i.TYPE_COD;
         l_DPT_VIDD_REC.KV := i.KV;
         l_DPT_VIDD_REC.TYPE_NAME := i.TYPE_NAME;
         l_DPT_VIDD_REC.CountActive := i.CountActive;
         l_DPT_VIDD_REC.DURATION := i.DURATION;
         l_DPT_VIDD_REC.DURATION_DAYS := i.DURATION_DAYS;
         l_DPT_VIDD_REC.MIN_SUMM := i.MIN_SUMM;
         l_DPT_VIDD_REC.LIMIT := i.LIMIT;
         l_DPT_VIDD_REC.FREQ_K := i.FREQ_K;
         l_DPT_VIDD_REC.FL_DUBL := i.FL_DUBL;
         l_DPT_VIDD_REC.TYPE_ID := i.TYPE_ID;

         PIPE ROW (l_DPT_VIDD_REC);
      END LOOP;
   END;


   FUNCTION get_DPT_VIDD_INFO (p_vidd IN NUMBER)
      RETURN t_DPT_VIDD_INFO
      PIPELINED
   IS
      l_DPT_VIDD_INFOREC   r_DPT_VIDD_INFOREC;-- dpt_vidd%rowtype;
   BEGIN
      bars_audit.trace ('get_DPT_VIDD_SETS start');

      FOR i IN (SELECT distinct *
                  FROM dpt_vidd
                 WHERE vidd = p_vidd)
      LOOP
        l_DPT_VIDD_INFOREC.VIDD             := to_char(i.VIDD);
        l_DPT_VIDD_INFOREC.DEPOSIT_COD      := nvl(to_char(i.DEPOSIT_COD),' ');
        l_DPT_VIDD_INFOREC.TYPE_NAME        := to_char(i.TYPE_NAME);
        l_DPT_VIDD_INFOREC.BASEY            := to_char(i.BASEY);
        l_DPT_VIDD_INFOREC.BASEM            := to_char(i.BASEM);
        l_DPT_VIDD_INFOREC.BR_ID            := to_char(i.BR_ID);
        l_DPT_VIDD_INFOREC.FREQ_N           := to_char(i.FREQ_N);
        l_DPT_VIDD_INFOREC.FREQ_K           := to_char(i.FREQ_K);
        l_DPT_VIDD_INFOREC.BSD              := to_char(i.BSD);
        l_DPT_VIDD_INFOREC.BSN              := to_char(i.BSN);
        l_DPT_VIDD_INFOREC.METR             := to_char(i.METR);
        l_DPT_VIDD_INFOREC.AMR_METR         := to_char(i.AMR_METR);
        l_DPT_VIDD_INFOREC.DURATION         := to_char(i.DURATION);
        l_DPT_VIDD_INFOREC.TERM_TYPE        := to_char(i.TERM_TYPE);
        l_DPT_VIDD_INFOREC.MIN_SUMM         := to_char(i.MIN_SUMM);
        l_DPT_VIDD_INFOREC.COMMENTS         := to_char(i.COMMENTS);
        l_DPT_VIDD_INFOREC.FLAG             := to_char(i.FLAG);
        l_DPT_VIDD_INFOREC.TYPE_COD         := to_char(i.TYPE_COD);
        l_DPT_VIDD_INFOREC.KV               := to_char(i.KV);
        l_DPT_VIDD_INFOREC.TT               := to_char(i.TT);
        l_DPT_VIDD_INFOREC.SHABLON          := to_char(i.SHABLON);
        l_DPT_VIDD_INFOREC.IDG              := to_char(i.IDG);
        l_DPT_VIDD_INFOREC.IDS              := to_char(i.IDS);
        l_DPT_VIDD_INFOREC.NLS_K            := to_char(i.NLS_K);
        l_DPT_VIDD_INFOREC.DATN             := to_char(i.DATN,'dd.mm.yyyy');
        l_DPT_VIDD_INFOREC.DATK             := to_char(i.DATK,'dd.mm.yyyy');
        l_DPT_VIDD_INFOREC.BR_ID_L          := to_char(i.BR_ID_L);
        l_DPT_VIDD_INFOREC.FL_DUBL          := to_char(i.FL_DUBL);
        l_DPT_VIDD_INFOREC.ACC7             := to_char(i.ACC7);
        l_DPT_VIDD_INFOREC.ID_STOP          := to_char(i.ID_STOP);
        l_DPT_VIDD_INFOREC.KODZ             := to_char(i.KODZ);
        l_DPT_VIDD_INFOREC.FMT              := to_char(i.FMT);
        l_DPT_VIDD_INFOREC.FL_2620          := to_char(i.FL_2620);
        l_DPT_VIDD_INFOREC.COMPROC          := to_char(i.COMPROC);
        l_DPT_VIDD_INFOREC.LIMIT            := to_char(i.LIMIT);
        l_DPT_VIDD_INFOREC.TERM_ADD         := to_char(i.TERM_ADD);
        l_DPT_VIDD_INFOREC.TERM_DUBL        := to_char(i.TERM_DUBL);
        l_DPT_VIDD_INFOREC.DURATION_DAYS    := to_char(i.DURATION_DAYS);
        l_DPT_VIDD_INFOREC.EXTENSION_ID     := to_char(i.EXTENSION_ID);
        l_DPT_VIDD_INFOREC.TIP_OST          := to_char(i.TIP_OST);
        l_DPT_VIDD_INFOREC.BR_WD            := to_char(i.BR_WD);
        l_DPT_VIDD_INFOREC.NLSN_K           := to_char(i.NLSN_K);
        l_DPT_VIDD_INFOREC.BSA              := to_char(i.BSA);
        l_DPT_VIDD_INFOREC.MAX_LIMIT        := to_char(i.MAX_LIMIT);
        l_DPT_VIDD_INFOREC.BR_BONUS         := to_char(i.BR_BONUS);
        l_DPT_VIDD_INFOREC.BR_OP            := to_char(i.BR_OP);
        l_DPT_VIDD_INFOREC.AUTO_ADD         := to_char(i.AUTO_ADD);
        l_DPT_VIDD_INFOREC.TYPE_ID          := to_char(i.TYPE_ID);
        l_DPT_VIDD_INFOREC.DISABLE_ADD      := to_char(i.DISABLE_ADD);
        l_DPT_VIDD_INFOREC.CODE_TARIFF      := to_char(i.CODE_TARIFF);
        l_DPT_VIDD_INFOREC.DURATION_MAX     := to_char(i.DURATION_MAX);
        l_DPT_VIDD_INFOREC.DURATION_DAYS_MAX:= to_char(i.DURATION_DAYS_MAX);
        l_DPT_VIDD_INFOREC.IRREVOCABLE      := to_char(i.IRREVOCABLE);

         PIPE ROW (l_DPT_VIDD_INFOREC);
      END LOOP;
   END;
---------------------------------------------------------
   -- autooperations

   FUNCTION get_DPT_JOBS
      RETURN t_DPT_JOB_SET
      PIPELINED
   IS
      l_DPT_JOB   r_DPT_JOB;
   BEGIN
      bars_audit.trace ('get_DPT_JOBS start');

      FOR i IN (  SELECT job_id,
                         job_code,
                         job_name,
                         job_proc,
                         ord
                    FROM dpt_jobs_list
                   WHERE UPPER (job_proc) LIKE UPPER ('%dpt%')
                ORDER BY ord)
      LOOP
         l_DPT_JOB.job_id   := i.job_id;
         l_DPT_JOB.job_code := i.job_code;
         l_DPT_JOB.job_name := i.job_name;
         l_DPT_JOB.job_proc := i.job_proc;
         l_DPT_JOB.ord := i.ord;
         PIPE ROW (l_DPT_JOB);
      END LOOP;
   END;
   --------------------------------------
      FUNCTION get_KV
      RETURN t_KV_SET
      PIPELINED
      is
      l_KV_REC r_KV_REC;
      begin
      bars_audit.trace ('get_KV start');

      FOR i IN (  SELECT kv, lcv, name from tabval$global t where kv in (980,978,840,643))
      LOOP
         l_KV_REC.kv := i.kv;
         l_KV_REC.lcv := i.lcv;
         l_KV_REC.name := i.name;

         PIPE ROW (l_KV_REC);
      END LOOP;
      end;


   FUNCTION get_BSD
      RETURN t_BSD_SET
      PIPELINED
      is
      l_BSD_REC r_BSD_REC;
      begin
      bars_audit.trace ('get_BSD start');
      FOR i IN ( select nbs, name from ps where ((nbs in ('2620','2630') and newnbs.get_state = 1) or (newnbs.get_state = 0 and nbs in ('2620', '2630', '2635')))
       and d_close is null and length(trunc(nbs))=4)
      LOOP
         l_BSD_REC.bsd := i.NBS  ;
         l_BSD_REC.name := i.NBS|| ' - ' ||i.name;

         PIPE ROW (l_BSD_REC);
      END LOOP;
      end;

      FUNCTION get_BSN(p_bsd in varchar2)
      RETURN t_BSN_SET
      PIPELINED
      is
      l_BSN_REC r_BSN_REC;
      begin
      bars_audit.trace ('get_BSN start');
      FOR i IN ( select nbs, name from ps where nbs in ('2628','2638') and d_close is null and length(trunc(nbs))=4 and substr(p_bsd,1,3) = substr(nbs,1,3))
      LOOP
         l_BSN_REC.bsn := i.NBS  ;
         l_BSN_REC.name := i.NBS|| ' - ' ||i.name;

         PIPE ROW (l_BSN_REC);
      END LOOP;
      end;
      FUNCTION get_BSA(p_BSD in varchar2, p_flag in varchar2)
      RETURN t_BSA_SET
      PIPELINED
      is
      l_BSA_REC r_BSA_REC;
      begin
      bars_audit.trace ('get_BSA start');
      if trunc(p_flag) = '1'
      then
          FOR i IN ( select nbs, name from ps where d_close is null and length(trunc(nbs))=4 and substr(p_bsd,1,3) = substr(nbs,1,3))
          LOOP
             l_BSA_REC.bsa := i.NBS;
             l_BSA_REC.name := i.NBS|| ' - ' ||i.name;

             PIPE ROW (l_BSA_REC);
          END LOOP;
      else
            l_BSA_REC.bsa := ' ';
            l_BSA_REC.name := ' ';
            PIPE ROW (l_BSA_REC);
      end if;
      end;
     FUNCTION get_BASEY
      RETURN t_BASEY_SET PIPELINED
       is
      l_BASEY_REC r_BASEY_REC;
      begin
      bars_audit.trace ('get_BASEY start');

          FOR i IN ( select basey, name from basey)
          LOOP
             l_BASEY_REC.basey := i.basey;
             l_BASEY_REC.name := i.name;

             PIPE ROW (l_BASEY_REC);
          END LOOP;

      end;
     FUNCTION get_FREQ
      RETURN t_FREQ_SET PIPELINED
       is
      l_freq_REC r_freq_REC;
      begin
      bars_audit.trace ('get_FREQ start');

          FOR i IN ( select freq, name from freq)
          LOOP
             l_freq_REC.freq := i.freq;
             l_freq_REC.name := i.name;

             PIPE ROW (l_freq_REC);
          END LOOP;
      end;
    FUNCTION get_METR
    RETURN t_METR_SET PIPELINED
    is
    l_METR_REC r_METR_REC;
    begin
    bars_audit.trace ('get_METR start');

      FOR i IN ( select metr, name from INT_METR)
      LOOP
         l_METR_REC.metr := i.metr;
         l_METR_REC.name := i.name;

         PIPE ROW (l_METR_REC);
      END LOOP;
    end;

    FUNCTION get_ION

    RETURN t_ION_SET PIPELINED
    is
    l_ION_REC r_ION_REC;
    begin
    bars_audit.trace ('get_ION start');

      FOR i IN ( select io, name from INT_ION)
      LOOP
         l_ION_REC.io := i.io;
         l_ION_REC.name := i.name;

         PIPE ROW (l_ION_REC);
      END LOOP;
    end;
    FUNCTION get_BRATES RETURN t_BRATES_SET
    PIPELINED
    is
    l_BRATES_REC r_BRATES_REC;
    begin
    bars_audit.trace ('get_BRATES start');

      FOR i IN ( select * from BRATES)
      LOOP
         l_BRATES_REC.BR_ID     := i.BR_ID;
         l_BRATES_REC.BR_TYPE   := i.BR_TYPE;
         l_BRATES_REC.COMM      := i.COMM;
         l_BRATES_REC.FORMULA   := i.FORMULA;
         l_BRATES_REC.INUSE     := i.INUSE;
         l_BRATES_REC.NAME      := i.NAME;

         PIPE ROW (l_BRATES_REC);
      END LOOP;
    end;

    FUNCTION get_DPT_STOP RETURN t_STOP_SET PIPELINED
    is
    l_STOP_REC r_STOP_REC;
    begin
    bars_audit.trace ('get_STOP start');

      FOR i IN ( select * from DPT_STOP where nvl(mod_code,'DPT') = 'DPT')
      LOOP
         l_STOP_REC.id          := i.id;
         l_STOP_REC.name        := i.name;
         l_STOP_REC.ID          := i.ID;
         l_STOP_REC.NAME        := i.NAME;
         l_STOP_REC.FL          := nvl(i.FL,0);
         l_STOP_REC.SH_PROC     := i.SH_PROC;
         l_STOP_REC.SH_OST      := i.SH_OST;
         l_STOP_REC.MOD_CODE    := i.MOD_CODE;
         PIPE ROW (l_STOP_REC);
      END LOOP;
    end;

    FUNCTION get_DPT_VIDD_EXTYPES RETURN t_DPT_VIDD_EXTYPES_SET PIPELINED
    is
    l_DPT_VIDD_EXTYPES_REC r_DPT_VIDD_EXTYPES_REC;
    begin
    bars_audit.trace ('get_DPT_VIDD_EXTYPES start');

      FOR i IN ( select * from DPT_VIDD_EXTYPES)
      LOOP
         l_DPT_VIDD_EXTYPES_REC.ID          := i.ID;
         l_DPT_VIDD_EXTYPES_REC.NAME        := i.NAME;
         l_DPT_VIDD_EXTYPES_REC.BONUS_PROC  := i.BONUS_PROC;
         l_DPT_VIDD_EXTYPES_REC.BONUS_RATE  := i.BONUS_RATE;
         l_DPT_VIDD_EXTYPES_REC.EXT_CONDITION   := i.EXT_CONDITION;

         PIPE ROW (l_DPT_VIDD_EXTYPES_REC);
      END LOOP;
    end;
    FUNCTION get_TARIF RETURN t_TARIF_SET PIPELINED
    is
    l_TARIF_REC r_TARIF_REC;
    begin
    bars_audit.trace ('get_TARIF start');

      FOR i IN ( select kod, name from TARIF)
      LOOP
         l_TARIF_REC.KOD         := i.KOD;
         l_TARIF_REC.NAME        := i.NAME;

         PIPE ROW (l_TARIF_REC);
      END LOOP;
    end;


PROCEDURE saveVidd (p_vidd                    VARCHAR2,
                    p_TYPE_COD                VARCHAR2,
                    p_TYPE_NAME               VARCHAR2,
                    p_BASEY                   VARCHAR2,
                    p_BASEM                   VARCHAR2,
                    p_BR_ID                   VARCHAR2,
                    p_FREQ_N                  VARCHAR2,
                    p_FREQ_K                  VARCHAR2,
                    p_BSD                     VARCHAR2,
                    p_BSN                     VARCHAR2,
                    p_METR                    VARCHAR2,
                    p_AMR_METR                VARCHAR2,
                    p_DURATION                VARCHAR2,
                    p_TERM_TYPE               VARCHAR2,
                    p_MIN_SUMM                VARCHAR2,
                    p_COMMENTS                VARCHAR2,
                    p_DEPOSIT_COD             VARCHAR2,
                    p_KV                      VARCHAR2,
                    p_TT                      VARCHAR2,
                    p_SHABLON                 VARCHAR2,
                    p_IDG                     VARCHAR2,
                    p_IDS                     VARCHAR2,
                    p_NLS_K                   VARCHAR2,
                    p_DATN                    VARCHAR2,
                    p_DATK                    VARCHAR2,
                    p_BR_ID_L                 VARCHAR2,
                    p_FL_DUBL                 VARCHAR2,
                    p_ACC7                    VARCHAR2,
                    p_ID_STOP                 VARCHAR2,
                    p_KODZ                    VARCHAR2,
                    p_FMT                     VARCHAR2,
                    p_FL_2620                 VARCHAR2,
                    p_COMPROC                 VARCHAR2,
                    p_LIMIT                   VARCHAR2,
                    p_TERM_ADD                VARCHAR2,
                    p_TERM_DUBL               VARCHAR2,
                    p_DURATION_DAYS           VARCHAR2,
                    p_EXTENSION_ID            VARCHAR2,
                    p_TIP_OST                 VARCHAR2,
                    p_BR_WD                   VARCHAR2,
                    p_NLSN_K                  VARCHAR2,
                    p_BSA                     VARCHAR2,
                    p_MAX_LIMIT               VARCHAR2,
                    p_BR_BONUS                VARCHAR2,
                    p_BR_OP                   VARCHAR2,
                    p_AUTO_ADD                VARCHAR2,
                    p_TYPE_ID                 VARCHAR2,
                    p_DISABLE_ADD             VARCHAR2,
                    p_CODE_TARIFF             VARCHAR2,
                    p_DURATION_MAX            VARCHAR2,
                    p_DURATION_DAYS_MAX       VARCHAR2,
                    p_IRREVOCABLE             VARCHAR2,
                    p_resultcode       out decimal,
                    p_resultmessage    out varchar2)
    is
    l_vidd varchar2(50);
    l_TYPE_ID number;
	l_context varchar2(30) := sys_context('bars_context','user_branch');
    begin
     begin
     p_resultcode := 0;
     bc.go('/');
     l_vidd := p_vidd;

         begin
         select TYPE_ID
           into l_TYPE_ID
           from dpt_types
          where type_code = p_TYPE_COD;
         exception when no_data_found then  p_resultcode := -1; p_resultmessage := 'Не обрано тип вкладу';
                   bc.go(l_context);
                   return;
                   when too_many_rows then  p_resultcode := -1; p_resultmessage := 'З кодом вкладу '|| p_TYPE_COD || ' вже існує більш ніж 1 тип - треба змінити налаштування типу';
                   bc.go(l_context);
                   return;
         end;
         begin
          PUL.PUT ('DPT_TYPE_ACTIVE','1');
         exception when others then bars_audit.error(sqlerrm);
         end;
         bars_audit.info ('saveVidd start l_TYPE_ID='||l_TYPE_ID||',l_vidd='||l_vidd);
         bars_audit.info('dpt_adm.savevidd: checks started');
         if (p_TYPE_NAME is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено найменування виду вкладу'; bc.go(l_context); return; end if;
         if (p_KV is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Валюта вида вклада"'; bc.go(l_context); return; end if;
         if (p_TERM_TYPE is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Тип срока: 1-фикс, 0-плав, 2-диапазон"'; bc.go(l_context); return; end if;
         if (p_DURATION is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Срок вида вклада в месяцах"'; bc.go(l_context);return; end if;
         if (p_DURATION_DAYS is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Срок вида вклада в днях"';bc.go(l_context); return; end if;
         if (p_BSD is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Балансовый счет депозита"';bc.go(l_context); return; end if;
         if (p_BSN is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Балансовый счет начисленных процентов"';bc.go(l_context); return; end if;
         if (p_BASEY is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено код бази нарахування';bc.go(l_context); return; end if;
         if (p_BASEM is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Признак фиксир.%-ной ставки"';bc.go(l_context); return; end if;
         if (p_BR_ID is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Базова ставка"';bc.go(l_context); return; end if;
         if (p_FREQ_N is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Периодичность начисления %%"'; bc.go(l_context);return; end if;
         if (p_FREQ_K is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Периодичность выплаты %%"';bc.go(l_context); return; end if;
         if (p_TIP_OST is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Тип вычисления остатка"';bc.go(l_context); return; end if;
         if (p_METR is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Код метода начисления процентов"';bc.go(l_context); return; end if;
         if (p_AMR_METR is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Метод амортизации процентов"';bc.go(l_context); return; end if;
         if (p_FL_DUBL is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Флаг автопереоформления"';bc.go(l_context); return; end if;
         if (p_ID_STOP is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Код штрафа"'; bc.go(l_context);return; end if;
         if (p_FL_2620 is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Перенос на вклад "До востребования""';bc.go(l_context);return; end if;
         if (p_COMPROC is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Признак капитализации"';bc.go(l_context); return; end if;
         if (p_TERM_DUBL is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Макс.кол-во автопереоформлений вклада"';bc.go(l_context); return; end if;
         if (p_BR_BONUS is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Код базовой бонусной ставки"';bc.go(l_context); return; end if;
         if (p_BR_OP is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено " Код арифм.операции между базовой и бонусной ставками"'; bc.go(l_context);return; end if;
         if (p_AUTO_ADD is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Флаг автопополнения вклада"'; bc.go(l_context);return; end if;
         --if (p_TYPE_ID is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Числ.код типа договора"'; return; end if;
         if (p_IRREVOCABLE is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Безвідкличний депозитний договір (заборонено дострокове вилучення)"'; bc.go(l_context);return; end if;
         if (p_EXTENSION_ID is null) then  p_resultcode := -1; p_resultmessage := 'Не заповнено "Код методу переоформлення"';bc.go(l_context); return; end if;
        bars_audit.info('dpt_adm.savevidd: checks ok');
        bars_audit.info('dpt_adm.savevidd: l_vidd = ' || to_char(l_vidd)|| ',p_BR_WD='||to_char(p_BR_WD));
        if l_vidd is not null
        then
             begin
              update dpt_vidd
                 set
                    TYPE_COD    = p_TYPE_COD,
                    TYPE_NAME   = p_TYPE_NAME,
                    BASEY =       p_BASEY,
                    BASEM =       nvl(p_BASEM,0),
                    BR_ID =       p_BR_ID,
                    FREQ_N =      p_FREQ_N,
                    FREQ_K =      p_FREQ_K,
                    BSD =         p_BSD,
                    BSN =         p_BSN,
                    METR =        p_METR,
                    AMR_METR =    p_AMR_METR,
                    DURATION =    p_DURATION,
                    TERM_TYPE =   p_TERM_TYPE,
                    MIN_SUMM =    p_MIN_SUMM,
                    COMMENTS =    p_COMMENTS,
                    DEPOSIT_COD = p_TYPE_COD,
                    KV =          p_KV,
                    TT =          p_TT,
                    SHABLON =     p_SHABLON,
                    IDG =         null,
                    IDS =         null,
                    NLS_K =       p_NLS_K,
                    DATN =        to_date(p_DATN,'dd.mm.yyyy'),
                    DATK =        to_date(p_DATK,'dd.mm.yyyy'),
                    BR_ID_L=      p_BR_ID_L,
                    FL_DUBL =     p_FL_DUBL,
                    ACC7 =        p_ACC7,
                    ID_STOP =     p_ID_STOP,
                    KODZ =        null,
                    FMT =         null,
                    FL_2620 =     p_FL_2620,
                    COMPROC =     p_COMPROC,
                    LIMIT =       p_LIMIT,
                    TERM_ADD =    p_TERM_ADD,
                    TERM_DUBL =   nvl(p_TERM_DUBL,0),
                    DURATION_DAYS=nvl(p_DURATION_DAYS,0),
                    EXTENSION_ID= p_EXTENSION_ID,
                    TIP_OST =     p_TIP_OST,
                    BR_WD =       p_BR_WD,
                    NLSN_K =      p_NLSN_K,
                    BSA =         p_BSA,
                    MAX_LIMIT =   p_MAX_LIMIT,
                    BR_BONUS =    p_BR_BONUS,
                    BR_OP =       p_BR_OP,
                    AUTO_ADD =    p_AUTO_ADD,
                    TYPE_ID =     l_TYPE_ID,
                    DISABLE_ADD = p_DISABLE_ADD,
                    CODE_TARIFF = p_CODE_TARIFF,
                    DURATION_MAX =p_DURATION_MAX,
                    DURATION_DAYS_MAX = p_DURATION_DAYS_MAX
                  where vidd = l_vidd;
               exception when others then
                if (sqlerrm like '%BASEY%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Базові параметри';
                elsif (sqlerrm like '%FREQ_N%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Періодичність нарахування %%';
                elsif (sqlerrm like '%FREQ_K%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Періодичність виплати %%';
                elsif (sqlerrm like '%FK_DPTVIDD_BRATES2%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Ставка після закінчення строку ' || p_BR_ID_L;
                elsif (sqlerrm like '%FK_DPTVIDD_BRATES3%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Ставка часткового зняття ' || p_BR_WD;
                elsif (sqlerrm like '%FK_DPTVIDD_TTS%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Операція для нарахування з кодом'||p_TT ||'не існує';
                else  p_resultcode := -1; p_resultmessage := 'UPDATE Не коректний параметр'||sqlerrm;
                end if;
             end;

             if sql%rowcount = 0
             then
                if (l_vidd is null) then
                l_vidd := s_dpt_vidd.NEXTVAL;
                end if;
                bars_audit.info('new vidd='||l_vidd);
                begin
                 PUL.PUT ('DPT_TYPE_ACTIVE','1');
                exception when others then bars_audit.error(sqlerrm);
                end;

                  begin
                    insert into dpt_vidd (vidd, DEPOSIT_COD,TYPE_NAME,BASEY,BASEM
                                          ,BR_ID,FREQ_N,FREQ_K,BSD,BSN,METR,AMR_METR
                                          ,DURATION,TERM_TYPE,MIN_SUMM,COMMENTS,FLAG
                                          ,TYPE_COD,KV,TT,SHABLON,IDG,IDS,NLS_K,DATN
                                          ,DATK,BR_ID_L,FL_DUBL,ACC7,ID_STOP,KODZ,FMT
                                          ,FL_2620,COMPROC,LIMIT,TERM_ADD,TERM_DUBL
                                          ,DURATION_DAYS,EXTENSION_ID,TIP_OST,BR_WD
                                          ,NLSN_K,BSA,MAX_LIMIT,BR_BONUS,BR_OP,AUTO_ADD
                                          ,TYPE_ID,DISABLE_ADD,CODE_TARIFF,DURATION_MAX
                                          ,DURATION_DAYS_MAX,IRREVOCABLE)
                     values (l_vidd,p_DEPOSIT_COD,p_TYPE_NAME,p_BASEY,p_BASEM,p_BR_ID
                            ,p_FREQ_N,p_FREQ_K,p_BSD,p_BSN,p_METR,p_AMR_METR,p_DURATION
                            ,p_TERM_TYPE,p_MIN_SUMM,p_COMMENTS,0,p_TYPE_COD,p_KV,p_TT
                            ,p_SHABLON,p_IDG,p_IDS,p_NLS_K,to_date(p_DATN,'dd.mm.yyyy'),to_date(p_DATK,'dd.mm.yyyy'),p_BR_ID_L,p_FL_DUBL
                            ,p_ACC7,nvl(p_ID_STOP,0),p_KODZ,p_FMT,p_FL_2620,p_COMPROC,p_LIMIT,nvl(p_TERM_ADD,0)
                            ,nvl(p_TERM_DUBL,0),nvl(p_DURATION_DAYS,0),nvl(p_EXTENSION_ID,0),p_TIP_OST,p_BR_WD
                            ,p_NLSN_K,p_BSA,p_MAX_LIMIT,p_BR_BONUS,p_BR_OP,p_AUTO_ADD,l_TYPE_ID
                            ,p_DISABLE_ADD,p_CODE_TARIFF,p_DURATION_MAX,p_DURATION_DAYS_MAX,p_IRREVOCABLE);
                  exception when others then
                    if (sqlerrm like '%BASEY%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Базові параметри ' || p_BASEY;
                        elsif (sqlerrm like '%FREQ_N%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Періодичність нарахування %%';
                        elsif (sqlerrm like '%FREQ_K%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Періодичність виплати %%';
                        elsif (sqlerrm like '%KV%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Валюта вкладу';
                        elsif (sqlerrm like '%METR%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Код методу нарахування %%';
                        elsif (sqlerrm like '%DURAT%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Строк вкладу %%';
                        elsif (sqlerrm like '%FK_DPTVIDD_BRATES2%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Ставка після закінчення строку';
                        elsif (sqlerrm like '%FK_DPTVIDD_TTS%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Операція для нарахування з кодом'||p_TT ||'не існує';
                        else  p_resultcode := -1; p_resultmessage := 'Не коректний параметр' ||sqlerrm;
                    end if;
                  end;
             end if;
        else
           bars_audit.info('dpt_adm.savevidd: l_vidd (null) = ' || to_char(l_vidd));
           l_vidd := s_dpt_vidd.NEXTVAL;
           bars_audit.info('new vidd='||l_vidd||',p_DEPOSIT_COD='||p_DEPOSIT_COD);
		  /* begin
           PUL.PUT ('DPT_TYPE_ACTIVE','1');
		   exception when others then bars_audit.error(sqlerrm);
		   end;*/
          insert into dpt_vidd (vidd, DEPOSIT_COD,TYPE_NAME,BASEY,BASEM
                                      ,BR_ID,FREQ_N,FREQ_K,BSD,BSN,METR,AMR_METR
                                      ,DURATION,TERM_TYPE,MIN_SUMM,COMMENTS,FLAG
                                      ,TYPE_COD,KV,TT,SHABLON,IDG,IDS,NLS_K,DATN
                                      ,DATK,BR_ID_L,FL_DUBL,ACC7,ID_STOP,KODZ,FMT
                                      ,FL_2620,COMPROC,LIMIT,TERM_ADD,TERM_DUBL
                                      ,DURATION_DAYS,EXTENSION_ID,TIP_OST,BR_WD
                                      ,NLSN_K,BSA,MAX_LIMIT,BR_BONUS,BR_OP,AUTO_ADD
                                      ,TYPE_ID,DISABLE_ADD,CODE_TARIFF,DURATION_MAX
                                      ,DURATION_DAYS_MAX,IRREVOCABLE)
                 values (l_vidd,p_DEPOSIT_COD,p_TYPE_NAME,p_BASEY,p_BASEM,p_BR_ID
                        ,p_FREQ_N,p_FREQ_K,p_BSD,p_BSN,p_METR,p_AMR_METR,p_DURATION
                        ,p_TERM_TYPE,p_MIN_SUMM,p_COMMENTS,0,p_TYPE_COD,p_KV,p_TT
                        ,p_SHABLON,p_IDG,p_IDS,p_NLS_K,to_date(p_DATN,'dd.mm.yyyy'),to_date(p_DATK,'dd.mm.yyyy'),p_BR_ID_L,p_FL_DUBL
                        ,p_ACC7,nvl(p_ID_STOP,0),p_KODZ,p_FMT,p_FL_2620,p_COMPROC,p_LIMIT,nvl(p_TERM_ADD,0)
                        ,nvl(p_TERM_DUBL,0),nvl(p_DURATION_DAYS,0),p_EXTENSION_ID,p_TIP_OST,p_BR_WD
                        ,p_NLSN_K,p_BSA,p_MAX_LIMIT,p_BR_BONUS,p_BR_OP,p_AUTO_ADD,l_TYPE_ID
                        ,p_DISABLE_ADD,p_CODE_TARIFF,p_DURATION_MAX,p_DURATION_DAYS_MAX,p_IRREVOCABLE);
        end if;

     exception when others then p_resultcode := -1; bars_audit.info('saveVidd'|| sqlerrm);
        if		  (sqlerrm like '%TYPE_NAME%') then p_resultcode := -1; p_resultmessage := 'Не коректна назва виду';
            elsif (sqlerrm like '%BS%') then p_resultcode := -1; p_resultmessage := 'Не коректні балансові рахунки вкладу';
            elsif (sqlerrm like '%BASEY%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Параметри нарахування %%';
            elsif (sqlerrm like '%FREQ_N%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Періодичність нарахування %%';
            elsif (sqlerrm like '%FREQ_K%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Періодичність виплати %%';
            elsif (sqlerrm like '%KV%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Валюта вкладу';
            elsif (sqlerrm like '%METR%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Код методу нарахування %%';
            elsif (sqlerrm like '%DURAT%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Строк вкладу %%';
            elsif (sqlerrm like '%TIP_OST%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр :Тип обчислення залишку %%';
            elsif (sqlerrm like '%FK_DPTVIDD_BRATES2%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Ставка після закінчення строку';
            elsif (sqlerrm like '%DEXTYPES%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Параметри повернення депозиту - Код методу переоформлення вкладу ';
            elsif (sqlerrm like '%FK_DPTVIDD_TTS%') then p_resultcode := -1; p_resultmessage := 'Не коректний параметр : Операція для нарахування з кодом '||p_TT ||' не існує';
        else p_resultcode := -1; p_resultmessage := 'Не коректні налаштування:' || sqlerrm;
        end if;
     end;
     if (p_resultcode = 0) then bars_audit.info(p_resultmessage); p_resultmessage := 'Вид вкладу '||p_TYPE_NAME ||' збережено з номером '|| to_char(l_vidd); end if;
     bars_audit.info('p_resultcode= ' ||p_resultcode);bars_audit.info(p_resultmessage);
	 bc.go(l_context);
    end;

 procedure shift(p_TYPE_ID IN dpt_types.type_id%type, p_direction IN int)
 is
 l_context varchar2(30) := sys_context('bars_context','user_branch');
 begin
  bars_audit.info('dpt_adm.shift(p_TYPE_ID = '||to_char(p_TYPE_ID)|| ',p_direction='||to_char(p_direction)||' ) starts');
  bc.go('/');
  begin
  update dpt_types
      set sort_ord = sort_ord+p_direction
  where TYPE_ID = p_TYPE_ID;
  exception when others then bars_audit.info(sqlerrm);
  end;
   bc.go(l_context);
 end;
 procedure ActivateType(p_TYPE_ID IN dpt_types.type_id%type)
 is
 l_context varchar2(30) := sys_context('bars_context','user_branch');
 begin
  bars_audit.info('dpt_adm.ActivateType(p_TYPE_ID = '||to_char(p_TYPE_ID)||') starts');
  bc.go('/');
  begin
   update dpt_types
      set FL_ACTIVE = case when FL_ACTIVE = 0 then 1 else 0 end
    where type_id = p_type_id;
  exception when others then bars_audit.info(sqlerrm);
  end;
   bc.go(l_context);
 end;
 procedure setWBType(p_TYPE_ID IN dpt_types.type_id%type)
 is
 l_context varchar2(30) := sys_context('bars_context','user_branch');
 begin
  bars_audit.info('dpt_adm.setWBType(p_TYPE_ID = '||to_char(p_TYPE_ID)||') starts');
  bc.go('/');
  begin
   update dpt_types
      set FL_WEBBANKING = case when FL_WEBBANKING = 0 then 1 else 0 end
    where type_id = p_type_id;
  exception when others then bars_audit.info(sqlerrm);
  end;
   bc.go(l_context);
 end;

 procedure ActivateVidd(p_VIDD IN dpt_vidd.vidd%type)
 is
 l_context varchar2(30) := sys_context('bars_context','user_branch');
 begin
  bars_audit.info('dpt_adm.ActivateVidd(p_VIDD = '||to_char(p_VIDD)||') starts');
  bc.go('/');
  begin
   update dpt_vidd dv
      set dv.flag = case when dv.flag = 0 then 1 else 0 end
    where dv.vidd = p_VIDD
	  and exists (select 1  from dpt_types where fl_active = 1 and dv.type_id = type_id);
  exception when others then bars_audit.info(sqlerrm);
  end;
   bc.go(l_context);
 end;
 FUNCTION get_ViddTTS(p_vidd in number) RETURN t_DPT_TTS_SET PIPELINED
 is
 l_TTS_REC r_TTS_REC;
 begin
  FOR i
     IN (SELECT DISTINCT p_vidd vidd, (select case when count(*)>0 then '+' else '-' end from dpt_tts_vidd dv where dv.tt = r.tt and dv.vidd=p_vidd) as added,
                 t.tt OP_TYPE,
       t.name OP_NAME,
       dpt_op.id TT_ID,
       dpt_op.name TT_NAME,
       GREATEST (DECODE (t.sk, NULL, 0, 1),
                 (SELECT COUNT (*)
                    FROM op_rules
                             WHERE tt = t.tt AND tag = 'D#73 '))
                    TT_CASH
  FROM dpt_vidd v,
       tts t,
       op_rules r,
       dpt_op
  WHERE     t.tt = r.tt
       AND r.tag = 'DPTOP'
       AND t.tt NOT LIKE 'DU%'
       AND SubStr(t.flags,1,1) = decode(t.TT, 'PKR', '1' , '0')
       AND TRIM (r.val) = TO_CHAR (dpt_op.id)
       AND t.tt NOT IN (SELECT tt
                          FROM op_rules
                          WHERE tag = 'DPTOF' AND val = '1')
      order by t.tt                    )
      LOOP
         l_TTS_REC.vidd          := i.vidd;
         l_TTS_REC.added         := i.added;
         l_TTS_REC.OP_TYPE       := i.OP_TYPE;
         l_TTS_REC.OP_NAME       := i.OP_NAME;
         l_TTS_REC.TT_ID         := i.TT_ID;
         l_TTS_REC.TT_NAME       := i.TT_NAME;
         l_TTS_REC.TT_CASH       := i.TT_CASH;

         PIPE ROW (l_TTS_REC);
      END LOOP;
 end;

 FUNCTION get_ViddDOC(p_vidd in number) RETURN t_DPT_DOC_SET PIPELINED
 is
 l_DOC_REC r_DOC_REC;
 begin
  FOR i
     IN ( SELECT p_vidd vidd,
                CASE
                    WHEN (SELECT COUNT (1)
                              FROM dpt_vidd_scheme dv
                             WHERE     (dv.flags = df.id OR dv.flags = df.id)
                                   AND dv.vidd = p_vidd) > 0
                    THEN 1 ELSE 0
                 END as active,
                 df.id flg,
                 df.name,
                 (SELECT nvl(id,'')
                    FROM dpt_vidd_scheme dv
                   WHERE dv.flags = df.id AND dv.vidd = p_vidd and (type_id is null or type_id = (select type_id from dpt_vidd where vidd = p_vidd)))
                    doc,
                 (SELECT nvl(id_fr,'')
                    FROM dpt_vidd_scheme dv
                   WHERE dv.flags = df.id AND dv.vidd = p_vidd and (type_id is null or type_id = (select type_id from dpt_vidd where vidd = p_vidd)))
                    doc_fr
            FROM dpt_vidd_flags df
        ORDER BY df.id)
      LOOP
         l_DOC_REC.vidd     := i.vidd;
         l_DOC_REC.active   := i.active;
         l_DOC_REC.flg      := i.flg;
         l_DOC_REC.name     := i.name;
         l_DOC_REC.doc      := nvl(i.doc,' ');
         l_DOC_REC.doc_fr   := nvl(i.doc_fr,' ');

         PIPE ROW (l_DOC_REC);
      END LOOP;
 end;

  procedure AddTTS(p_VIDD IN dpt_types.type_id%type, p_tts IN char)
  is
  l_already_in int := 0;
  l_context varchar2(30) := sys_context('bars_context','user_branch');
  begin
   bc.go('/');
   begin
    select 1
      into l_already_in
     from dpt_tts_vidd
     where vidd = p_vidd and tt = p_tts;
   exception when no_data_found then l_already_in :=0;
   end;
   if l_already_in = 0
   then
       begin
        insert into dpt_tts_vidd (vidd, tt) values (p_vidd, p_tts);
       exception when others then  bars_audit.info('dpt_adm.addTTS: error' || sqlerrm);
       end;
   else
    delete dpt_tts_vidd where vidd = p_vidd and tt = p_tts;
   end if;
    bc.go(l_context);
  end;

  procedure AddDOC2Vidd(p_Vidd IN dpt_vidd.vidd%type, p_FLG in int, p_DOC in varchar2, p_DOC_FR in varchar2)
   is
   l_type_id int;
   l_already_in int := 0;
   l_context varchar2(30) := sys_context('bars_context','user_branch');
  begin
   bars_audit.info('p_VIDD='||p_VIDD||',p_flg='||to_char(p_flg)||',p_doc='||p_doc||',p_doc_fr='||p_doc_fr);

    begin
        select 1
          into l_already_in
         from dpt_vidd_scheme
         where vidd = p_vidd
           and flags = p_flg;
    exception when no_data_found then l_already_in :=0;
    end;
   bars_audit.info('l_already_in = '||to_char(l_already_in));
   bc.go('/');
   if l_already_in = 1
   then
    if p_doc is not null then
    update dpt_vidd_scheme
       set id =  p_doc
     where vidd = p_vidd
       and flags = p_flg;
	   bars_audit.info('p_doc update '||to_char(p_doc));
    end if;
    if p_doc_fr is not null then
    update dpt_vidd_scheme
       set id_fr = p_doc_fr
     where vidd = p_vidd
       and flags = p_flg;
	   bars_audit.info('p_doc_fr update '||to_char(p_doc_fr));
    end if;
   else
    begin
	bars_audit.info('insert into dpt_vidd_scheme '||to_char(p_doc_fr));
    insert into dpt_vidd_scheme ( vidd, type_id, id_fr, id, flags) values ( p_vidd, null, p_doc_fr, p_doc, p_flg);
    exception when others then raise_application_error ( -20001, 'Халепа спіткала...'|| sqlerrm, false);
	bars_audit.info('insert into dpt_vidd_scheme '||sqlerrm);
    end;
   end if;
  exception when others then raise_application_error ( -20001, 'Халепа спіткала...'|| sqlerrm, false);
  bars_audit.info('insert into dpt_vidd_scheme '||sqlerrm);
   bc.go(l_context);
  end;

  FUNCTION get_ViddDOCSCHEME(p_fr in int) RETURN t_DPT_DOCSHCEME_SET PIPELINED
  is
  l_DOCSHCEME_REC r_DOCSHCEME_REC;
  begin
  FOR i
     in ( select ds.id from doc_scheme ds, doc_root dr
           where ds.fr = p_fr
             and ds.id = dr.id
             and dr.vidd = 101)
      LOOP
         l_DOCSHCEME_REC.id     := i.id;

         PIPE ROW (l_DOCSHCEME_REC);
      END LOOP;

  end;

  FUNCTION get_DPTARC(p_date date, p_vidd dpt_vidd.vidd%type, p_branch branch.branch%type) RETURN t_DPTARC_SET PIPELINED
  is
  l_DPTARC_REC r_DPTARC_REC;
  begin
  FOR i
     IN ( SELECT dc.deposit_id,
                 dc.nd,
                 dc.kv,
                 b.branch,
                 dc.acc,
                 (SELECT nls
                    FROM accounts
                   WHERE acc = dc.acc)
                    AS nls,
                 dc.rnk,
                 (SELECT nmk
                    FROM customer
                   WHERE rnk = dc.rnk)
                    AS nmk,
                 fost (dc.acc, p_date) ostd,
                 fostq (dc.acc, p_date) ostdQ,
                 DECODE (dc.acc,
                         (SELECT acra
                            FROM int_accn
                           WHERE acc = dc.acc AND id = 1), 0,
                         fost ( (SELECT acra
                                   FROM int_accn
                                  WHERE acc = dc.acc AND id = 1),
                               p_date))
                    ostp,
                 DECODE (dc.acc,
                         (SELECT acra
                            FROM int_accn
                           WHERE acc = dc.acc AND id = 1), 0,
                         fostq ( (SELECT acra
                                    FROM int_accn
                                   WHERE acc = dc.acc AND id = 1),
                                p_date))
                    ostpQ,
                 dc.vidd,
                 (SELECT type_name
                    FROM dpt_vidd
                   WHERE vidd = dc.vidd)
                    AS vidd_name,
                 acrn.fproc (dc.acc, p_date) AS ir,
                 dc.dat_begin,
                 dc.dat_end,
                 dc.CNT_DUBL,
                 dc.userid,
                 (SELECT dazs
                    FROM accounts
                   WHERE acc = dc.acc)
                    AS DAZS,
                 fdos (acc, DAT_BEGIN, p_date) dos,
                 GREATEST (fkos (dc.acc, DAT_BEGIN, p_date) - dc.LIMIT, 0) kos,
                 p_date AS cdat,
                 dc.IDUPD,
                 ser || ' ' || numdoc as docreq,
                 pdate,
                 organ,
                 (SELECT name
                    FROM passp
                   WHERE passp = p.passp) as passpname
            FROM dpt_deposit_clos dc, dpt_deposit_all b, person p
           WHERE     (dc.idupd, dc.deposit_ID) IN (  SELECT MAX (idupd) idupd, deposit_ID
                                                       FROM dpt_deposit_clos
                                                      WHERE bdate <= p_date
                                                   GROUP BY deposit_ID)
                 AND dc.action_id NOT IN (1, 2)
                 AND dc.deposit_id = b.deposit_id
                 AND b.branch LIKE
                           DECODE ( p_branch,
                                   '-', '/' || f_ourmfo_g || '/',
                                   p_branch)
                        || '%'
                 AND dc.rnk = p.rnk
                 AND (dc.vidd = p_vidd OR p_vidd IS NULL)
        ORDER BY deposit_id
     )
      LOOP
        l_DPTARC_REC.deposit_id    := i.deposit_id;
        l_DPTARC_REC.nd            := i.nd;
        l_DPTARC_REC.kv            := i.kv;
        l_DPTARC_REC.branch        := i.branch;
        l_DPTARC_REC.acc           := i.acc;
        l_DPTARC_REC.nls           := i.nls;
        l_DPTARC_REC.rnk           := i.rnk;
        l_DPTARC_REC.nmk           := i.nmk;
        l_DPTARC_REC.ostd          := i.ostd;
        l_DPTARC_REC.ostdq         := i.ostdq;
        l_DPTARC_REC.ostp          := i.ostp;
        l_DPTARC_REC.ostpq         := i.ostpq;
        l_DPTARC_REC.vidd          := i.vidd;
        l_DPTARC_REC.vidd_name     := i.vidd_name;
        l_DPTARC_REC.ir            := i.ir;
        l_DPTARC_REC.dat_begin     := i.dat_begin;
        l_DPTARC_REC.dat_end       := i.dat_end;
        l_DPTARC_REC.cnt_dubl      := i.cnt_dubl;
        l_DPTARC_REC.userid        := i.userid;
        l_DPTARC_REC.dazs          := i.dazs;
        l_DPTARC_REC.dos           := i.dos;
        l_DPTARC_REC.kos           := i.kos;
        l_DPTARC_REC.cdat          := i.cdat;
        l_DPTARC_REC.idupd         := i.idupd;
        l_DPTARC_REC.docreq        := i.docreq;
        l_DPTARC_REC.pdate         := i.pdate;
        l_DPTARC_REC.porgan        := i.organ;
        l_DPTARC_REC.passpname     := i.passpname;

         PIPE ROW (l_DPTARC_REC);
      END LOOP;

  end;

  FUNCTION get_ViddList RETURN t_VIDD_SET PIPELINED
  is
    l_VIDD_REC r_VIDD_REC;
  begin
  FOR i
     IN (select null as vidd, 'Усі' as type_name from dual union all
         select vidd, type_name from dpt_vidd
          where vidd is not null
          order by vidd)
      LOOP
         l_VIDD_REC.vidd          := i.vidd;
         l_VIDD_REC.type_name     := i.type_name;
         PIPE ROW (l_VIDD_REC);
      END LOOP;
  end;

  FUNCTION get_BranchList RETURN t_BRANCH_SET PIPELINED
  is
    l_BRANCH_REC r_BRANCH_REC;
  begin
  FOR i
     IN (select branch as branch_, name from branch order by 1)
      LOOP
         l_BRANCH_REC.branch_  := i.branch_;
         l_BRANCH_REC.name     := i.name;
         PIPE ROW (l_BRANCH_REC);
      END LOOP;
  end;
  procedure deleteType (p_type_id number,
                        p_resultcode       out decimal,
                        p_resultmessage    out varchar2)
  is
  l_context varchar2(30) := sys_context('bars_context','user_branch');
  begin
   p_resultcode := 0;
   p_resultmessage := 'Тип '|| p_type_id ||' видалено!';
   bars_audit.info('Видалення типу '|| to_char(p_type_id));
   bc.go('/');
   begin

    INSERT INTO dpt_vidd_arc (  vidd, deposit_cod, type_name, basey, basem, br_id, freq_n, freq_k, bsd, bsn, metr, amr_metr, duration, term_type,
                                min_summ, comments, flag, type_cod, kv, tt, shablon, idg, ids, nls_k, datn, datk, br_id_l, fl_dubl, acc7, id_stop,
                                kodz, fmt, fl_2620, comproc, limit, term_add, term_dubl, duration_days, extension_id, tip_ost, br_wd, nlsn_k, bsa,
                                max_limit, br_bonus, br_op, auto_add, type_id, disable_add, code_tariff, duration_max, duration_days_max, irrevocable, user_off)
       SELECT vidd, deposit_cod, type_name, basey, basem, br_id, freq_n, freq_k, bsd, bsn, metr, amr_metr, duration, term_type,
                                min_summ, comments, flag, type_cod, kv, tt, shablon, idg, ids, nls_k, datn, datk, br_id_l, fl_dubl, acc7, id_stop,
                                kodz, fmt, fl_2620, comproc, limit, term_add, term_dubl, duration_days, extension_id, tip_ost, br_wd, nlsn_k, bsa,
                                max_limit, br_bonus, br_op, auto_add, type_id, disable_add, code_tariff, duration_max, duration_days_max, irrevocable, user_id
         FROM dpt_vidd
        WHERE type_id = p_type_id;

    insert into DPT_VIDD_SCHEME_ARC
    select * from DPT_VIDD_SCHEME
    where vidd in (select vidd FROM dpt_vidd WHERE type_id = p_type_id);

    insert into DPT_TTS_VIDD_ARC
    select * from  DPT_TTS_VIDD
    where vidd in (select vidd FROM dpt_vidd WHERE type_id = p_type_id);

    insert into DPT_VIDD_PARAMS_ARC
    select * from DPT_VIDD_PARAMS
    where vidd in (select vidd FROM dpt_vidd WHERE type_id = p_type_id);

    INSERT INTO dpt_types_arc(type_id, type_name, type_code, sort_ord, fl_active, fl_demand, user_off)
       SELECT type_id, type_name, type_code, sort_ord, fl_active, fl_demand, user_id
         FROM dpt_types
        WHERE type_id = p_type_id;
   commit;
   exception when others then p_resultcode := -1;
                              p_resultmessage := 'Помилка видалення типу:'|| p_type_id || sqlerrm;
   end;
   begin
     delete DPT_TTS_VIDD where vidd in (select vidd FROM dpt_vidd WHERE type_id = p_type_id);
     delete DPT_VIDD_SCHEME where type_id = p_type_id;
     delete DPT_VIDD_PARAMS where vidd in (select vidd FROM dpt_vidd WHERE type_id = p_type_id);
     delete dpt_vidd where type_id = p_type_id;
     delete dpt_types where type_id = p_type_id;
   exception when others then p_resultcode := -1;
                              p_resultmessage := 'Помилка видалення типу:'|| p_type_id || sqlerrm;
   end;
   p_resultmessage := substr(p_resultmessage,1,4000);
    bc.go(l_context);
  end;

  procedure deleteVidd (p_vidd  number,
                        p_resultcode       out decimal,
                        p_resultmessage    out varchar2)
  is
  l_context varchar2(30) := sys_context('bars_context','user_branch');
  l_closed int := 0;
  begin
   p_resultcode := 0;
   p_resultmessage := 'Вид '|| p_vidd ||' видалено!';
   bars_audit.info('Видалення виду '|| to_char(p_vidd));
   bc.go('/');
   begin
    select count(*)
      into l_closed
      from dpt_deposit_clos
     where action_id = 0
       and vidd = p_vidd;
   exception when no_data_found then l_closed := 0;
   end;
   if l_closed >0
   then
    p_resultcode := -1;
    p_resultmessage := 'Вид '|| p_vidd || ' не можна видалити, за ним в архіві '||to_char(l_closed)||'депозитних вкладів';
    return;
    --raise_application_error ( -20001, 'Видалити вид '|| to_char(p_vidd) || ' неможна видалити, за ним в архіві '||to_char(l_closed)||'депозитних вкладів', false);
   else
    execute immediate 'alter table dpt_deposit_clos DISABLE CONSTRAINT FK_DPTDEPOSITCLOS_DPTVIDD';

       begin

        INSERT INTO dpt_vidd_arc (  vidd, deposit_cod, type_name, basey, basem, br_id, freq_n, freq_k, bsd, bsn, metr, amr_metr, duration, term_type,
                                    min_summ, comments, flag, type_cod, kv, tt, shablon, idg, ids, nls_k, datn, datk, br_id_l, fl_dubl, acc7, id_stop,
                                    kodz, fmt, fl_2620, comproc, limit, term_add, term_dubl, duration_days, extension_id, tip_ost, br_wd, nlsn_k, bsa,
                                    max_limit, br_bonus, br_op, auto_add, type_id, disable_add, code_tariff, duration_max, duration_days_max, irrevocable, user_off)
           SELECT vidd, deposit_cod, type_name, basey, basem, br_id, freq_n, freq_k, bsd, bsn, metr, amr_metr, duration, term_type,
                                    min_summ, comments, flag, type_cod, kv, tt, shablon, idg, ids, nls_k, datn, datk, br_id_l, fl_dubl, acc7, id_stop,
                                    kodz, fmt, fl_2620, comproc, limit, term_add, term_dubl, duration_days, extension_id, tip_ost, br_wd, nlsn_k, bsa,
                                    max_limit, br_bonus, br_op, auto_add, type_id, disable_add, code_tariff, duration_max, duration_days_max, irrevocable, user_id
             FROM dpt_vidd
            WHERE vidd = p_vidd;

        insert into DPT_VIDD_SCHEME_ARC
        select * from DPT_VIDD_SCHEME
        where vidd = p_vidd;

        insert into DPT_TTS_VIDD_ARC
        select * from  DPT_TTS_VIDD
        where vidd = p_vidd;

        insert into DPT_VIDD_PARAMS_ARC
        select * from DPT_VIDD_PARAMS
        where vidd = p_vidd;

       exception when others then p_resultcode := -1;
                                  p_resultmessage := 'Помилка видалення виду:'|| p_vidd || sqlerrm;
        return;
       end;
       begin
         delete DPT_TTS_VIDD where vidd =p_vidd;
         delete DPT_VIDD_SCHEME where vidd = p_vidd;
         delete DPT_VIDD_PARAMS where vidd =p_vidd;
		 delete DPT_VIDD_BONUSES where vidd =p_vidd;
         delete DPT_VIDD where vidd = p_vidd;
       exception when others then p_resultcode := -1;
                                  p_resultmessage := 'Помилка видалення виду:'|| p_vidd || sqlerrm;
       end;
       execute immediate 'alter table dpt_deposit_clos ENABLE NOVALIDATE CONSTRAINT FK_DPTDEPOSITCLOS_DPTVIDD';
   end if;
    p_resultmessage := substr(p_resultmessage,1,4000);
    bc.go(l_context);
  end;

  function get_viddparam(p_vidd in dpt_vidd.vidd%type) return t_viddparam_set pipelined
  is
   l_viddparam_rec r_viddparam_rec;
  begin
   FOR i
    IN (SELECT p_vidd vidd,
               dt.tag,
               dt.name,
               dt.editable,
               dvp.val
          FROM dpt_vidd_tags dt
          left join dpt_vidd_params dvp on dvp.tag= dt.tag and dvp.vidd = p_vidd
          WHERE status = 'Y' and editable = 'Y' )
      LOOP
         l_viddparam_rec.vidd  := i.vidd;
         l_viddparam_rec.tag  := i.tag;
         l_viddparam_rec.name  := i.name;
         l_viddparam_rec.editable  := i.editable;
         l_viddparam_rec.val  := i.val;
         PIPE ROW (l_viddparam_rec);
      END LOOP;
  end;

  procedure setParam(p_vidd in dpt_vidd.vidd%type,p_tag dpt_vidd_tags.tag%type, p_val dpt_vidd_params.val%type)
  is
  l_context varchar2(30) := sys_context('bars_context','user_branch');
  begin
  bc.go('/');
   if (p_val is not null) then
   update dpt_vidd_params
      set val = p_val
    where vidd = p_vidd
      and tag = p_tag;
   else
    delete dpt_vidd_params where vidd = p_vidd and tag = p_tag;
   end if;
   if sql%rowcount = 0
   then
   begin
    insert into dpt_vidd_params (vidd, tag, val) values (p_vidd, p_tag, p_val);
   exception when dup_val_on_index then null;
   end;
   end if;
    bc.go(l_context);
  end;

  function getDicts return t_dicttlist_set pipelined
  is
  l_dictlist r_dictlist;
  begin
   for i in (SELECT m.tabid, tabname, semantic
               FROM meta_tables m, references r
              WHERE r.role2edit = 'DPT_ADMIN' AND m.tabid = r.tabid)
   loop
     l_dictlist.tabid       := i.tabid;
     l_dictlist.tabname     := i.tabname;
     l_dictlist.semantic    := i.semantic;
     PIPE ROW (l_dictlist);
   end loop;
  end;
  function get_DOCSCHEME(p_type int) return t_DPT_DOC_SET pipelined
  is
     l_DOC_REC r_DOC_REC;
     begin
      FOR i
         IN ( SELECT null vidd,
                    CASE
                        WHEN (SELECT COUNT (1)
                                  FROM dpt_vidd_scheme dv
                                 WHERE     (dv.flags = df.id OR dv.flags = df.id)
                                       AND dv.vidd is null and dv.type_id = p_type) > 0
                        THEN 1 ELSE 0
                     END as active,
                     df.id flg,
                     df.name,
                     (SELECT nvl(id,'')
                        FROM dpt_vidd_scheme dv
                       WHERE dv.flags = df.id AND dv.vidd is null and dv.type_id = p_type)
                        doc,
                     (SELECT nvl(id_fr,'')
                        FROM dpt_vidd_scheme dv
                       WHERE dv.flags = df.id AND dv.vidd is null and dv.type_id = p_type)
                        doc_fr
                FROM dpt_vidd_flags df
            ORDER BY df.id)
       LOOP
             l_DOC_REC.vidd     := i.vidd;
             l_DOC_REC.active   := i.active;
             l_DOC_REC.flg      := i.flg;
             l_DOC_REC.name     := i.name;
             l_DOC_REC.doc      := nvl(i.doc,' ');
             l_DOC_REC.doc_fr   := nvl(i.doc_fr,' ');

             PIPE ROW (l_DOC_REC);
       END LOOP;
      end;

  procedure AddDOC2Type(p_type IN dpt_vidd.type_id%type, p_FLG in int, p_DOC in varchar2, p_DOC_FR in varchar2)
   is
   l_type_id int;
   l_already_in int := 0;
   l_context varchar2(30) := sys_context('bars_context','user_branch');
  begin
   bars_audit.info('p_type='||p_type||',p_flg='||to_char(p_flg)||',p_doc='||p_doc||',p_doc_fr='||p_doc_fr);

    begin
        select 1
          into l_already_in
         from dpt_vidd_scheme
         where type_id = p_type
           and flags = p_flg and vidd is null;
    exception when no_data_found then l_already_in :=0;
    end;

   bc.go('/');
   if l_already_in = 1
   then
    if p_doc is not null
    then
        update dpt_vidd_scheme
           set id =  p_doc
         where type_id = p_type
           and flags = p_flg and id is null and vidd is null;
    end if;
    if p_doc_fr is not null
    then
        update dpt_vidd_scheme
           set id_fr = p_doc_fr
         where type_id = p_type
           and flags = p_flg and id_fr is null and vidd is null;
    end if;
   else
    begin
     insert into dpt_vidd_scheme ( vidd, type_id, id_fr, id, flags)
           values ( null, p_type, p_doc_fr, p_doc, p_flg);
     for k in (select vidd from dpt_vidd where type_id = p_type)
     loop
      begin
        insert into dpt_vidd_scheme ( vidd, type_id, id_fr, id, flags)
          values ( k.vidd, p_type, p_doc_fr, p_doc, p_flg);
        exception when others then null;
        end;
     end loop;
    exception when others then raise_application_error ( -20001, 'Халепа спіткала...'|| sqlerrm, false);
    end;
   end if;
    bc.go(l_context);
  end;

   procedure ClearDOC2Vidd(p_vidd dpt_vidd.vidd%type, p_flg dpt_vidd_scheme.flags%type)
   is
   begin
    bars_audit.info('p_vidd='||p_vidd||',p_flg='||to_char(p_flg));
    delete from dpt_vidd_scheme where vidd = p_vidd and flags = p_flg;
   end;

   procedure ClearDOC2Type(p_type dpt_vidd.type_id%type, p_flg dpt_vidd_scheme.flags%type)
   is
   begin
    bars_audit.info('p_type='||p_type||',p_flg='||to_char(p_flg));
    delete from dpt_vidd_scheme where type_id = p_type and flags = p_flg and vidd is null;
   end;

   function get_dptjobjrnl(p_job_id in number) return t_jobjrnl_rec_set pipelined
   is
   l_jobjrnl_rec r_jobjrnl_rec;
     begin
--      bars_audit.info('get_dptjobjrnl:' ||to_char(p_job_id));
      FOR i
         IN (select * from dpt_jobs_jrnl where job_id = p_job_id and bank_date >= sysdate - 60 order by run_id desc)
       LOOP
 --      bars_audit.info('get_dptjobjrnl:run_id' ||to_char(l_jobjrnl_rec.run_id));
             l_jobjrnl_rec.run_id       := i.run_id;
             l_jobjrnl_rec.job_id       := i.job_id;
             l_jobjrnl_rec.start_date   := i.start_date;
             l_jobjrnl_rec.finish_date  := i.finish_date;
             l_jobjrnl_rec.bank_date    := i.bank_date;
             l_jobjrnl_rec.user_id      := i.user_id;
             l_jobjrnl_rec.status       := i.status;
             l_jobjrnl_rec.errmsg       := i.errmsg;
             l_jobjrnl_rec.branch       := i.branch;
             l_jobjrnl_rec.deleted      := i.deleted;
             l_jobjrnl_rec.kf           := i.kf;

         --   bars_audit.info('get_dptjobjrnl: pipe start_date' ||to_char(l_jobjrnl_rec.start_date,'dd/mm/yyyy'));
             PIPE ROW (l_jobjrnl_rec);
       END LOOP;
      end;


   function get_dptjoblog(p_run_id in number) return t_joblog_rec_set pipelined
   is
   l_joblog_rec r_joblog_rec;
     begin
      FOR i
         IN (select * from dpt_jobs_log where run_id = p_run_id)
       LOOP
             l_joblog_rec.rec_id        := i.rec_id;
             l_joblog_rec.run_id        := i.run_id;
             l_joblog_rec.job_id        := i.job_id;
             l_joblog_rec.dpt_id        := i.dpt_id;
             l_joblog_rec.branch        := i.branch;
             l_joblog_rec.ref           := i.ref;
             l_joblog_rec.rnk           := i.rnk;
             l_joblog_rec.kv            := i.kv;
             l_joblog_rec.dpt_sum       := i.dpt_sum;
             l_joblog_rec.int_sum       := i.int_sum;
             l_joblog_rec.status        := i.status;
             l_joblog_rec.errmsg        := i.errmsg;
             l_joblog_rec.nls           := i.nls;
             l_joblog_rec.contract_id   := i.contract_id;
             l_joblog_rec.deal_num      := i.deal_num;
             l_joblog_rec.rate_val      := i.rate_val;
             l_joblog_rec.rate_dat      := i.rate_dat;
             l_joblog_rec.kf            := i.kf;

             PIPE ROW (l_joblog_rec);
       END LOOP;
     end;
   procedure DelPenalty(p_ID dpt_stop.id%type, p_message OUT varchar2)
   is
   l_resulmessage varchar2(500);
   begin
    bars_audit.info('dpt_adm.DelPenalty:'||p_ID);
     begin
     select 'Не можна видаляти системний штраф, не підвязаний до модуля!'
       into l_resulmessage
       from dpt_stop
      where nvl(MOD_CODE,'') = '' and id = p_ID;
      return;
    exception when no_data_found then
       begin
       delete dpt_stop where id = p_ID;
    exception when others then
        l_resulmessage := 'Неможливо видалити штраф! Знайдені налаштування штрафу, потрібно спочатку видалити налаштування.';
        p_message := l_resulmessage;
        bars_audit.error(l_resulmessage);
   end;
    end;
    if nvl(p_message,'') = '' then p_message := 'Виконано!'; end if;
   end;
   procedure InsPenalty(p_NAME dpt_stop.NAME%type, p_FL dpt_stop.FL%type, p_SH_PROC dpt_stop.SH_PROC%type, p_SH_OST dpt_stop.SH_OST%type, p_MOD_CODE dpt_stop.MOD_CODE%type, p_message OUT varchar2)
   is
    l_resulmessage varchar2(500);
   begin
   bars_audit.info('dpt_adm.InsPenalty:'||p_NAME||','||p_FL||','||p_SH_PROC||','||p_SH_OST||','||p_MOD_CODE);
    begin
        insert into dpt_stop (ID, NAME, FL, SH_PROC, SH_OST, MOD_CODE)
        values (s_dpt_stop_id.nextval, p_NAME,nvl(p_FL,1),p_SH_PROC,p_SH_OST,p_MOD_CODE);
    exception when dup_val_on_index then
        p_message := 'Штраф з номером вже існує!';
    end;
    if nvl(p_message,'') = '' then p_message := 'Виконано!'; end if;
   end;
   procedure UpdPenalty(p_ID dpt_stop.id%type, p_NAME dpt_stop.NAME%type, p_FL dpt_stop.FL%type, p_SH_PROC dpt_stop.SH_PROC%type, p_SH_OST dpt_stop.SH_OST%type, p_MOD_CODE dpt_stop.MOD_CODE%type, p_message OUT varchar2)
   is
    l_resulmessage varchar2(500);
   begin
   bars_audit.info('dpt_adm.UpdPenalty:'||p_ID ||','||p_NAME||','||p_FL||','||p_SH_PROC||','||p_SH_OST||','||p_MOD_CODE);

       if p_NAME is not null
       then
           begin
            update dpt_stop
               set name = p_NAME
             where ID = p_ID;
           exception when others then
                l_resulmessage := 'Неможливо зберегти штраф!' ||substr(sqlerrm,1,420);
                p_message := l_resulmessage;
                bars_audit.error(l_resulmessage);
           end;
       end if;

       if p_FL is not null
       then
           begin
            update dpt_stop
               set FL = p_FL
             where ID = p_ID;
           exception when others then
                l_resulmessage := 'Неможливо зберегти штраф!' ||substr(sqlerrm,1,420);
                p_message := l_resulmessage;
                bars_audit.error(l_resulmessage);
           end;
       end if;

       if p_SH_PROC is not null
       then
           begin
            update dpt_stop
               set SH_PROC = p_SH_PROC
             where ID = p_ID;
           exception when others then
                l_resulmessage := 'Неможливо зберегти штраф!' ||substr(sqlerrm,1,420);
                p_message := l_resulmessage;
                bars_audit.error(l_resulmessage);
           end;
       end if;

       if p_SH_OST is not null
       then
           begin
            update dpt_stop
               set SH_OST = p_SH_OST
             where ID = p_ID;
           exception when others then
                l_resulmessage := 'Неможливо зберегти штраф!' ||substr(sqlerrm,1,420);
                p_message := l_resulmessage;
                bars_audit.error(l_resulmessage);
           end;
       end if;
       if p_MOD_CODE is not null
       then
           begin
            update dpt_stop
               set MOD_CODE = p_MOD_CODE
             where ID = p_ID;
           exception when others then
                l_resulmessage := 'Неможливо зберегти штраф!' ||substr(sqlerrm,1,420);
                p_message := l_resulmessage;
                bars_audit.error(l_resulmessage);
           end;
       end if;
    if nvl(p_message,'') = '' then p_message := 'Виконано!'; end if;
   end;

    procedure FillPenalty(p_ID dpt_stop_a.id%type,
                         p_K_SROK dpt_stop_a.K_SROK%type,
                         p_K_PROC dpt_stop_a.K_PROC%type,
                         p_SH_PROC dpt_stop_a.SH_PROC%type,
                         p_K_TERM dpt_stop_a.K_TERM%type,
                         p_SH_TERM dpt_stop_a.SH_TERM%type)
   is
    l_minsrok             dpt_stop_a.k_srok%type;
    l_maxsrok             dpt_stop_a.k_srok%type;
    p_err_msg             varchar2(500);
   begin
    bars_audit.info(title   || 'FillPenalty starts with params: '
                            || '  p_ID = ' || to_char(p_ID)
                            || ', p_K_SROK = ' || to_char(p_K_SROK)
                            || ', p_K_PROC = ' || to_char(p_K_PROC)
                            || ', p_SH_PROC = ' || to_char(p_SH_PROC)
                            || ', p_K_TERM = ' || to_char(p_K_TERM)
                            || ', p_SH_TERM = ' || to_char(p_SH_TERM));

      begin
          p_err_msg := null;

          select max( case when (K_SROK < p_K_SROK) then K_SROK else null end ), min( case when (K_SROK >= p_K_SROK) then K_SROK else null end )
            into l_minsrok, l_maxsrok
            from BARS.DPT_STOP_A
           where ID = p_ID;

          if ( l_minsrok Is Null )
          then -- нижня межа

            insert
              into BARS.DPT_STOP_A
              ( ID, K_SROK, K_PROC, SH_PROC, K_TERM, SH_TERM )
            values
              ( p_ID, 0, p_K_PROC, p_SH_PROC, p_K_TERM, p_SH_TERM );

            bars_audit.trace( '%s: inserted lower limit value for penalty #%s.', title, to_char(p_ID) );

          else

            if ( l_maxsrok > p_K_SROK )
            then
              -- duplicate row
              insert
                into BARS.DPT_STOP_A
                   ( ID, K_SROK, K_PROC, SH_PROC, K_TERM, SH_TERM )
              select ID, p_K_SROK, K_PROC, SH_PROC, K_TERM, SH_TERM
                from BARS.DPT_STOP_A
               where ID = p_ID
                 and K_SROK = l_minsrok;

              -- update row
              update BARS.DPT_STOP_A
                 set K_PROC  = p_K_PROC, SH_PROC = p_SH_PROC, K_TERM  = p_K_TERM, SH_TERM = p_SH_TERM
               where ID = p_ID
                 and K_SROK = l_minsrok;

            else -- ( l_maxsrok = p_K_SROK ) or ( l_maxsrok < p_K_SROK )

              update BARS.DPT_STOP_A
                 set K_PROC  = p_K_PROC, SH_PROC = p_SH_PROC, K_TERM  = p_K_TERM, SH_TERM = p_SH_TERM
               where ID = p_ID
                 and K_SROK = l_minsrok;

            end if;

          end if;

          if ( l_maxsrok Is Null )
          then -- нова верхня межа

            insert
              into BARS.DPT_STOP_A
              ( ID, K_SROK, K_PROC, SH_PROC, K_TERM, SH_TERM )
            values
              ( p_ID, p_K_SROK, 100, 0, NULL, 0 );

            bars_audit.trace( '%s: inserted upper limit value for penalty #%s.', title, to_char(p_ID) );

          end if;
      exception
          when OTHERS then
            p_err_msg := sqlerrm;
            bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
      end;
   end;

  procedure DelFillPenalty(p_ID in dpt_stop_a.id%type, p_K_SROK dpt_stop_a.K_SROK%type, p_message OUT varchar2)is
  begin
    bars_audit.trace( '%s: Entry with ( p_id=%s ).', title, to_char(p_id) );
    begin
      delete DPT_STOP_A
       where ID = p_id
         and k_Srok = p_K_SROK;
      bars_audit.trace( '%s: deleted deposit penalty #%s.', title, to_char(p_id) );
    exception
      when OTHERS then
        p_message := 'Неможливо видалити налаштування штрафу!';
    end;
    if nvl(p_message,'') = '' then p_message := 'Виконано!'; end if;
  end;

END DPT_ADM;
/
 show err;
 
PROMPT *** Create  grants  DPT_ADM ***
grant EXECUTE                                                                on DPT_ADM         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpt_adm.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 