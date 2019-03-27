 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cig_mgr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CIG_MGR is

  --
  -- �����  : OLEG
  -- ������ : 04.02.2011
  --
  -- ������ : CIG
  -- Purpose : �������������� � ����� (��������� ����)
  --

  -- Public constant declarations
  g_header_version  constant varchar2(64) := 'version 1.9 27/02/2018';
  g_awk_header_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------
  -- get_currbranch - ���������� g_currbranch
  --
  function get_currbranch return varchar2;

  --------------------------------------------------------------------------------
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  -- prc_dog_data - ��������� ��� ����� ���. ���������� �� ��������� ���������
  --
  -- @p_date - ����, �� ������� ���������� ������
  --
  procedure prc_dog_data(p_date in date, p_kf varchar2);

      -- ��������� ��� ����� ���. ���������� �� ���������( ������������ ��� ��������)
      procedure prc_dog_general(p_dtype in number, p_date date);
  --------------------------------------------------------------------------------
  -- prc_dog_data - ��������� ��� ����� ���� ����������� ���������� (������� - ��������)
  --
  -- @p_date - ����, �� ������� ���������� ������
  --
  procedure collect_data(p_date in date, p_kf varchar2);

  --------------------------------------------------------------------------------
  -- job_run - ��������� ������� ����� ������
  --
  -- @p_job_id - ��� �������
  --
  procedure job_run(p_job_id in varchar2);

  --------------------------------------------------------------------------------
  -- job_interval - �������� �������� ���������� �������
  --
  -- @p_job_id - ��� �������
  -- @p_interval - ��������
  --
  procedure job_interval(p_job_id in varchar2, p_interval in varchar2);

  procedure create_job_cig_mmfo;

end cig_mgr;
/
CREATE OR REPLACE PACKAGE BODY BARS.CIG_MGR is

   --
   -- �����  : OLEG
   -- ������ : 04.02.2011
   --
   -- ������ : CIG
   -- Purpose : �������������� � ����� (��������� ����)
   --

   -- Private constant declarations
   g_body_version constant varchar2(64) := 'version 2.7 15/05/2018';

   g_awk_body_defs constant varchar2(512) := '' || '��� �������� ����� ' || chr(13) || chr(10);

   g_dbgcode     constant varchar2(12) := 'cig_mgr.';
   g_module_name constant varchar2(3) := 'CIG';

   -- ���� �������
   G_ERROR_CUSTATTRS constant number := 3;
   G_ERROR_DOGATTRS  constant number := 4;
   G_WITHOUT_ERRORS  constant number := 1;
   G_SYSERROR        constant number := 2;

   -- ���� ���������
   G_CONTRACT_INSTALMENT constant number := 1;
   G_CONTRACT_CREDIT     constant number := 2;
   G_CONTRACT_BPK        constant number := 3;
   G_CONTRACT_OVR        constant number := 4;
   G_CONTRACT_GRNT       constant number := 5;
   G_CONTRACT_MBK_NI     constant number := 6;
   G_CONTRACT_MBK_CR     constant number := 7;

   -- ���� ��������
   G_CUST_INDIVIDUAL constant number := 3;
   G_CUST_COMPANY    constant number := 2;

   -- ���� ������
   G_CUSTDATA        constant number := 1;
   G_DOGDATA         constant number := 2;
   G_DOG_INSTDATA    constant number := 3;
   G_DOG_CREDITDATA  constant number := 4;
   G_DOG_NONINSTDATA constant number := 5;

   g_currbranch varchar2(30) := null;
 --  g_newnbs          number := newnbs.get_state;  -- ������� �������� �� ����� ���� ������. (1-�������, 0-���)

   TYPE dog_general_rec_type IS RECORD(
     nd                cc_deal.nd%TYPE,
     rnk               accounts.rnk%TYPE,
     start_date        DATE,
     end_date          DATE,
     bdate             DATE,
     dazs              DATE,
     currency          tabval$global.lcv%TYPE,
     currency_id       accounts.kv%TYPE,
     cig_13            mos_operw.value%TYPE,
     cig_14            mos_operw.value%TYPE,
     cig_15            mos_operw.value%TYPE,
     cig_16            mos_operw.value%TYPE,
     cig_17            mos_operw.value%TYPE,
     cig_18            mos_operw.value%TYPE,
     cig_19            mos_operw.value%TYPE,
     cig_20            mos_operw.value%TYPE,
     custtype          customer.custtype%TYPE,
     contract_type     NUMBER,
     branch            customer.branch%TYPE,
     limit_sum         cig_dog_credit.limit_sum%TYPE,
     credit_usage      cig_dog_credit.credit_usage%TYPE,
     res_sum           cig_dog_credit.res_sum%TYPE,
     overdue_sum       cig_dog_credit.overdue_sum%TYPE,
     accountingDate    DATE,
     fact_terr_id      customer_address.territory_id%type,
     fact_addr         VARCHAR2(250),
     fact_zip          customer_address.zip%type,
     reg_terr_id       customer_address.territory_id%type,
     reg_addr          VARCHAR2(250),
     reg_zip           customer_address.zip%type,
     role_id           NUMBER,
     firstname         VARCHAR2(70),
     surname           VARCHAR2(70),
     fathers_name      VARCHAR2(70),
     gender            NUMBER,
     classification    NUMBER,
     birth_surname     cig_cust_individual.birth_surname%type,
     date_birth        person.bday%type,
     place_birth       person.bplace%type,
     residency         NUMBER,
     citizenship       kl_k040.a2%type,
     neg_status        cig_cust_individual.neg_status%type,
     education         cig_cust_individual.education%type,
     marital_status    cig_cust_individual.marital_status%type,
     position          customerw.value%type,
     okpo              customer.okpo%type,
     cust_key          VARCHAR2(148),
     ser               person.ser%type,
     numdoc            person.numdoc%type,
     passp_iss_date    person.pdate%type,
     passp_exp_date    date,
     passp_organ       person.organ%type,
     phone_office      person.telw%type,
     phone_mobile      person.teld%type,
     phone_fax         person.teld%type,
     email             cig_cust_individual.email%type,
     website           cig_cust_individual.website%type,
     status_id         number,
     lang_name         varchar2(10),
     name              customer.nmk%type,
     lang_abbreviation varchar2(10),
     abbreviation      customer.nmkk%type,
     ownership         number,
     registr_date      date,
     economic_activity v_cig_cust_company.economic_activity%type,
     emplote_count     NUMBER,
     cust_code         customer.okpo%type,
     reg_num           v_cig_cust_company.reg_num%type,
     tel_fax           corps.tel_fax%type,
     e_mail            corps.e_mail%type,
     a8_acc            accounts.acc%type,
     a8_kv             accounts.kv%type,
     branch_dog        customer.branch%type);


 type stg_general_rec_type 
    is record(
     nd                number,
     rnk               number,
     start_date        DATE,
     end_date          DATE,
     bdate             DATE,
     dazs              DATE,
     currency          varchar2(4000),
     currency_id       number,
     cig_13            varchar2(4000),
     cig_14            varchar2(4000),
     cig_15            varchar2(4000),
     cig_16            varchar2(4000),
     cig_17            varchar2(4000),
     cig_18            varchar2(4000),
     cig_19            varchar2(4000),
     cig_20            varchar2(4000),
     custtype          number,
     contract_type     number,
     branch            varchar2(4000),
     limit_sum         number,
     credit_usage      number,
     res_sum           number,
     overdue_sum       number,
     accountingDate    DATE,
     fact_terr_id      number,
     fact_addr         varchar2(4000),
     fact_zip          varchar2(4000),
     reg_terr_id       number,
     reg_addr          varchar2(4000),
     reg_zip           varchar2(4000),
     role_id           number,
     firstname         varchar2(4000),
     surname           varchar2(4000),
     fathers_name      varchar2(4000),
     gender            number,
     classification    number,
     birth_surname     varchar2(4000),
     date_birth        date,
     place_birth       varchar2(4000),
     residency         number,
     citizenship       varchar2(4000),
     neg_status        number,
     education         number,
     marital_status    number,
     position          varchar2(4000),
     okpo              varchar2(4000),
     cust_key          varchar2(4000),
     ser               varchar2(4000),
     numdoc            varchar2(4000),
     passp_iss_date    date,
     passp_exp_date    date,
     passp_organ       varchar2(4000),
     phone_office      varchar2(4000),
     phone_mobile      varchar2(4000),
     phone_fax         varchar2(4000),
     email             varchar2(4000),
     website           varchar2(4000),
     status_id         number,
     lang_name         varchar2(4000),
     name              varchar2(4000),
     lang_abbreviation varchar2(4000),
     abbreviation      varchar2(4000),
     ownership         number,
     registr_date      date,
     economic_activity number,
     emplote_count     number,
     cust_code         varchar2(4000),
     reg_num           varchar2(4000),
     tel_fax           varchar2(4000),
     e_mail            varchar2(4000),
     a8_acc            number,
     a8_kv             number,
     branch_dog        varchar2(4000)
  );



   --------------------------------------------------------------------------------
    -- header_version - ���������� ������ ��������� ������
   --
   function header_version return varchar2 is
   begin
     return 'Package header cig_mgr ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_header_defs;
   end header_version;

   --------------------------------------------------------------------------------
   -- body_version - ���������� ������ ���� ������
   --
   function body_version return varchar2 is
   begin
     return 'Package body cig_mgr ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_awk_body_defs;
   end body_version;

   --------------------------------------------------------------------------------
   -- add_event - ��������� ������ � ������ �������
   --
   -- p_errtype - ��� ������
   -- p_errormsg - ����� ������
   --
   procedure add_event(p_errtype  in number,
                       p_errormsg V_CIG_EVENTS_INS.evt_message%type,
                       p_oraerrm  V_CIG_EVENTS_INS.evt_oraerr%type,
                       p_nd       in cc_deal.nd%type := null,
                       p_rnk      in customer.rnk%type := null,
                       p_custtype in number default null,
                       p_dtype    in number default null) is
     l_th constant varchar2(100) := g_dbgcode || 'add_event';
   begin
     bars_audit.trace('%s: entry point', l_th);

     -- ������ � ������
     insert into V_CIG_EVENTS_INS c
       (evt_id,
        evt_date,
        evt_uname,
        evt_state_id,
        evt_message,
        evt_oraerr,
        evt_nd,
        evt_rnk,
        evt_custtype,
        evt_dtype)
     values
       (s_cig_events.nextval,
        sysdate,
        user_id,
        p_errtype,
        substr(p_errormsg, 1, 4000),
        substr(p_oraerrm, 1, 4000),
        p_nd,
        p_rnk,
        p_custtype,
        p_dtype);

     bars_audit.trace('%s: done', l_th);
   end add_event;


   -- ��������� ������ � ������ �������  ���������� ���������� 
   procedure add_error
   (
    p_errtype  in number,
    p_errormsg V_CIG_EVENTS_INS.evt_message%type,
    p_oraerrm  V_CIG_EVENTS_INS.evt_oraerr%type,
    p_nd       in cc_deal.nd%type := null,
    p_rnk      in customer.rnk%type := null,
    p_custtype in number default null,
    p_dtype    in number default null
   )
   as
    pragma autonomous_transaction;
   begin
     add_event(p_errtype, p_errormsg, p_oraerrm, p_nd, p_rnk, p_custtype, p_dtype);
     commit;    
   end add_error;
   
   --------------------------------------------------------------------------------
   -- date_val - ��������� �������� ���� >= 01.01.1900
   --
   -- @p_field - ����������� ����
   -- @p_errname - ��� ������ ��� BARS_ERROR
   -- @p_rnk - ��� �������
   -- @p_nd - ��� ���������� ��������
   --
   function date_val(p_field    in date,
                     p_errname  in varchar2,
                     p_rnk      in customer.rnk%type := null,
                     p_nd       in cc_deal.nd%type := null,
                     p_custtype in number default null,
                     p_dtype    in number default null) return boolean is
     l_errtype number;
   begin
     if ((p_field < to_date('01.01.1900', 'dd.mm.yyyy')) or
        (p_field > to_date('01.01.2098', 'dd.mm.yyyy'))) then
       if (p_rnk is not null) then
         l_errtype := G_ERROR_CUSTATTRS;
       else
         l_errtype := G_ERROR_DOGATTRS;
       end if;
       add_event(l_errtype,
                 bars_error.get_nerror_text(g_module_name, p_errname),
                 null,
                 p_nd,
                 p_rnk,
                 p_custtype,
                 p_dtype);
       return false;
     end if;
     return true;
   end;

   --------------------------------------------------------------------------------
   -- check_nn - ��������� �������� �� not null
   --
   -- @p_field - ����������� ����
   -- @p_errname - ��� ������ ��� BARS_ERROR
   -- @p_rnk - ��� �������
   -- @p_nd - ��� ���������� ��������
   --
   function check_nn(p_field    in varchar2,
                     p_errname  in varchar2,
                     p_rnk      in customer.rnk%type := null,
                     p_nd       in cc_deal.nd%type := null,
                     p_custtype in number default null,
                     p_dtype    in number default null) return boolean is
     l_errtype number;
   begin
     if (trim(p_field) is null) then
       if (p_rnk is not null) then
         l_errtype := G_ERROR_CUSTATTRS;
       else
         l_errtype := G_ERROR_DOGATTRS;
       end if;
       add_event(l_errtype,
                 bars_error.get_nerror_text(g_module_name, p_errname),
                 null,
                 p_nd,
                 p_rnk,
                 p_custtype,
                 p_dtype);
       return false;
     end if;
     return true;
   end;

   function check_nn_fact_adr(p_field_ter in varchar2,
                              p_field_str in varchar2,
                              p_rnk       in customer.rnk%type := null,
                              p_nd        in cc_deal.nd%type := null,
                              p_custtype  in number default null,
                              p_dtype     in number default null)
     return boolean is
     l_errtype number;
   begin
     if (p_rnk is not null) then
       l_errtype := G_ERROR_CUSTATTRS;
     else
       l_errtype := G_ERROR_DOGATTRS;
     end if;
     if ((trim(p_field_ter) is null) and (trim(p_field_str) is not null)) then
       add_event(l_errtype,
                 bars_error.get_nerror_text(g_module_name,
                                            'CIG_FACT_TER_N_STR_NN'),
                 null,
                 p_nd,
                 p_rnk,
                 p_custtype,
                 p_dtype);
       return false;
     elsif ((trim(p_field_ter) is not null) and (trim(p_field_str) is null)) then
       add_event(l_errtype,
                 bars_error.get_nerror_text(g_module_name,
                                            'CIG_FACT_TER_NN_STR_N'),
                 null,
                 p_nd,
                 p_rnk,
                 p_custtype,
                 p_dtype);
       return false;
     else
       return true;
     end if;
   end;

   function check_post_index(P_REG_POST_INDEX  in varchar2,
                             P_FACT_POST_INDEX in varchar2,
                             p_rnk             in customer.rnk%type := null,
                             p_nd              in cc_deal.nd%type := null,
                             p_custtype        in number default null,
                             p_dtype           in number default null)
     return boolean is
     l_errtype number;
   begin
     if (p_rnk is not null) then
       l_errtype := G_ERROR_CUSTATTRS;
     else
       l_errtype := G_ERROR_DOGATTRS;
     end if;
     if ((length(P_REG_POST_INDEX) > 5) or
        (trim(translate(P_REG_POST_INDEX, '0123456789', ' ')) is not null)) then
       add_event(l_errtype,
                 bars_error.get_nerror_text(g_module_name,
                                            'CIG_REG_POST_INDEX_VAL'),
                 null,
                 p_nd,
                 p_rnk,
                 p_custtype,
                 p_dtype);
       return false;
     elsif ((length(P_FACT_POST_INDEX) > 5) or
           (trim(translate(P_FACT_POST_INDEX, '0123456789', ' ')) is not null)) then
       add_event(l_errtype,
                 bars_error.get_nerror_text(g_module_name,
                                            'CIG_FACT_POST_INDEX_VAL'),
                 null,
                 p_nd,
                 p_rnk,
                 p_custtype,
                 p_dtype);
       return false;
     end if;
     return true;
   end;
   --------------------------------------------------------------------------------
   -- check_ind_row - ��������� ���������� ������������
   --                 ����� ��� ������
   --
   -- @p_row - ����������� ������
   --
   function check_ind_row(p_row   in dog_general_rec_type,
                          p_dtype in number default null) return boolean is
     l_res    boolean := true;
     l_gender varchar2(2) := null;
   begin
     if not check_nn(p_row.role_id,
                     'CIG_ROLEID_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.firstname,
                     'CIG_FIRST_NAME_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.surname,
                     'CIG_SURNAME_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.classification,
                     'CIG_CLASSIFICATION_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.date_birth,
                     'CIG_DATEBIRTH_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.residency,
                     'CIG_RESIDENCY_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.citizenship,
                     'CIG_CITIZENSHIP_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.position,
                     'CIG_POSITION_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.okpo,
                     'CIG_CUST_CODE_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.cust_key,
                     'CIG_CUST_KEY_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.ser,
                     'CIG_PASSP_SER_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.numdoc,
                     'CIG_PASSP_NUM_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.passp_iss_date,
                     'CIG_PASSP_ISS_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.passp_organ,
                     'CIG_PASSP_ORGAN_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.reg_terr_id,
                     'CIG_REG_TERRIT_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.reg_addr,
                     'CIG_REG_STREET_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if (p_dtype <> 3) then
       if not check_nn_fact_adr(p_row.fact_terr_id,
                                p_row.fact_addr,
                                p_row.rnk,
                                p_row.nd,
                                3,
                                p_dtype) and l_res then
         l_res := false;
       end if;
     end if;
     if p_row.gender != 0 then
       l_gender := p_row.gender;
     end if;
     if not check_nn(l_gender,
                     'CIG_GENDER_NULL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     --���� ����������
     if not date_val(p_row.date_birth,
                     'CIG_BDATE_VAL',
                     p_row.rnk,
                     p_row.nd,
                     3,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_post_index(p_row.reg_zip,
                             p_row.fact_zip,
                             p_row.rnk,
                             p_row.nd,
                             3,
                             p_dtype) and l_res then
       l_res := false;
     end if;
     --������������� ��������
     /*
     if
     add_event(
         l_errtype,
         bars_error.get_nerror_text(g_module_name, p_errname),
         null, p_nd, p_rnk);
     */
     return l_res;
   end;

   --------------------------------------------------------------------------------
   -- check_comp_row - ��������� ���������� ������������
   --                  ����� ��� �����
   --
   -- @p_row - ����������� ������
   --
   function check_comp_row(p_row   in dog_general_rec_type,
                           p_dtype in number default null) return boolean is
     l_res boolean := true;
   begin
     if not check_nn(p_row.role_id,
                     'CIG_ROLEID_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.status_id,
                     'CIG_STATUSID_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.lang_name,
                     'CIG_LANGNAME_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.name,
                     'CIG_NAME_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.lang_abbreviation,
                     'CIG_LANGABBREV_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.abbreviation,
                     'CIG_ABBREV_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.ownership,
                     'CIG_OWNERSHIP_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.registr_date,
                     'CIG_REGISTRDATE_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.reg_terr_id,
                     'CIG_REG_TERRIT_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.reg_addr,
                     'CIG_REG_STREET_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.fact_terr_id,
                     'CIG_FACT_TERRIT_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.fact_addr,
                     'CIG_FACT_STREET_NULL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     if not check_post_index(p_row.reg_zip,
                             p_row.fact_zip,
                             p_row.rnk,
                             p_row.nd,
                             2,
                             p_dtype) and l_res then
       l_res := false;
     end if;
     --���� ��������  ���������
     if not date_val(p_row.registr_date,
                     'CIG_REGDT_VAL',
                     p_row.rnk,
                     p_row.nd,
                     2,
                     p_dtype) and l_res then
       l_res := false;
     end if;
     return l_res;
   end;

   --------------------------------------------------------------------------------
   -- check_dog_row - ��������� ���������� ������������
   --                  ����� ��� ����� ���������� ��
   --                  ��������� ���������
   --
   -- @p_row - ����������� ������
   --
   function check_dog_row(p_row in dog_general_rec_type) return boolean is
     l_res boolean := true;
   begin
     if not check_nn(p_row.cig_18,
                     'CIGDOG_PAYPERIODID_NULL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.cig_15,
                     'CIGDOG_PHASEID_NULL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.start_date,
                     'CIGDOG_SDATE_NULL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.bdate,
                     'CIGDOG_BDATE_NULL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.currency_id,
                     'CIGDOG_CURRENCY_NULL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     if not check_nn(p_row.end_date,
                     'CIGDOG_ENDDATE_NULL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     --���� ��������� ��������
     if not date_val(p_row.start_date,
                     'CIG_STARTDT_VAL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     --���� ������� 䳿 ��������
     if not date_val(p_row.bdate,
                     'CIG_BDT_VAL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     --��������� ���� ��������� ��������
     if not date_val(p_row.end_date,
                     'CIG_ENDDT_VAL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     --�������� ��������� 䳿 ��������
     if not date_val(p_row.dazs,
                     'CIG_DAZS_VAL',
                     p_row.rnk,
                     p_row.nd,
                     p_row.custtype,
                     p_row.contract_type) and l_res then
       l_res := false;
     end if;
     return l_res;
   end;

   --------------------------------------------------------------------------------
   -- get_error - ���������� ������ � �������� ����
   --
   -- @p_errcode - ��� ORA ������
   -- @p_sqlerrm - ����� ORA ������
   --
   function get_error(p_errcode in number, p_sqlerrm in varchar2)
     return varchar2 is
     l_errcode err_codes.err_name%type;
     l_res     varchar2(4000);
     l_th constant varchar2(100) := g_dbgcode || 'get_error';
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: p_errcode=>%s, p_sqlerrm=>%s',
                      l_th,
                      to_char(p_errcode),
                      sqlerrm);
     case

       when (p_errcode = -01400 and
            instr(p_sqlerrm, '"V_CIG_DOG_GENERAL"."CUST_ID"') > 0) then
         l_errcode := 'CIG_CUST_NOTFOUND';

       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_CIGD01') > 0) then
         l_errcode := 'PARENT_KEY_NOT_CLASSIF';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_CIGD02') > 0) then
         l_errcode := 'PARENT_KEY_NOT_ROLEID';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_CIGD03') > 0) then
         l_errcode := 'PARENT_KEY_NOT_RESIDENCY';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_KLK040') > 0) then
         l_errcode := 'PARENT_KEY_NOT_CITIZENSHIP';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_CIGD05') > 0) then
         l_errcode := 'PARENT_KEY_NOT_NEG_STATUS';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_CIGD07') > 0) then
         l_errcode := 'PARENT_KEY_NOT_EDUCATION';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_CIGD08') > 0) then
         l_errcode := 'PARENT_KEY_NOT_MARITAL';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_CIGD09') > 0) then
         l_errcode := 'PARENT_KEY_NOT_POSITION';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_FACRTERRIT') > 0) then
         l_errcode := 'PARENT_KEY_NOT_FACT_TERRIT';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTCOMP_CIGD02') > 0) then
         l_errcode := 'PARENT_KEY_NOT_ROLEID';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTCOMP_CIGD10') > 0) then
         l_errcode := 'PARENT_KEY_NOT_OWNER';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTCOMP_CIGD11') > 0) then
         l_errcode := 'PARENT_KEY_NOT_ECONACTIV';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTCOMP_CIGD12') > 0) then
         l_errcode := 'PARENT_KEY_NOT_STATUSID';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTCOMP_CIGD22') > 0) then
         l_errcode := 'PARENT_KEY_NOT_EMPCOUNT';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTCOMP_TERRIT') > 0) then
         l_errcode := 'PARENT_KEY_NOT_FACT_TERRIT';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTCUST_TERRIT') > 0) then
         l_errcode := 'PARENT_KEY_NOT_REG_TERRIT';
       when (p_errcode = -02291 and
            instr(p_sqlerrm, 'FK_CIGCUSTIND_D06') > 0) then
         l_errcode := 'PARENT_KEY_NOT_GENDER';
       when (p_errcode = -1 and instr(p_sqlerrm, 'PK_CIGCUSTINDIVIDUAL') > 0) then
         l_errcode := 'PK_DUPL_RNK';
       when (p_errcode = -1 and instr(p_sqlerrm, 'PK_CIGCUSTCOMPANY') > 0) then
         l_errcode := 'PK_DUPL_RNK';
       else
         l_errcode := 'ERR_NOT_DEFINED';
     end case;

     l_res := bars_error.get_nerror_text(g_module_name, l_errcode);
     bars_audit.trace('%s: done, return value=%s', l_th, l_res);
     return l_res;
   end;

   --------------------------------------------------------------------------------
   -- upd_syncdata - ����� ���� �����
   --
   -- @data_id in number, data_type in cig_sync_types.type_id%type
   --
   procedure upd_syncdata(p_data_id   in number,
                          p_branch    in branch.branch%type,
                          p_data_type in cig_sync_types.type_id%type) is
     l_th constant varchar2(100) := g_dbgcode || 'upd_syncdata';
     l_sync_row V_CIG_SYNC_DATA%rowtype;
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: data_id=%s, data_type=%s',
                      l_th,
                      to_char(p_data_id),
                      to_char(p_data_type));

     begin

       select *
         into l_sync_row
         from V_CIG_SYNC_DATA
        where data_id = p_data_id
          and data_type = p_data_type
          and branch = p_branch;

     exception
       when no_data_found then
       begin
         insert into V_CIG_SYNC_DATA
           (data_id, data_type, branch)
         values
           (p_data_id, p_data_type, p_branch);
       EXCEPTION WHEN OTHERS  THEN
          bars_audit.info ('cig_mgr.upd_syncdata 1 insert: '||p_data_id||' p_branch: '||p_branch||' : '|| sqlerrm);
       end;
     end;

  begin
     if p_data_type = G_CUSTDATA then
       update V_CIG_CUSTOMERS c
          set c.upd_date = sysdate
        where c.cust_id = p_data_id
          and c.branch = p_branch;        
     elsif p_data_type = G_DOGDATA then
       update V_CIG_DOG_GENERAL g
       set g.upd_date = sysdate 
       where g.id = p_data_id
         and g.branch = p_branch;
     elsif p_data_type = G_DOG_INSTDATA then
       update v_cig_dog_instalment
          set update_date = sysdate
        where id = p_data_id;
     elsif p_data_type = G_DOG_CREDITDATA then
       update V_CIG_DOG_CREDIT set update_date = sysdate where id = p_data_id;
     end if;

    EXCEPTION WHEN OTHERS  THEN
          bars_audit.info ('cig_mgr.upd_syncdata 2 : '||p_data_id||' p_branch: '||p_branch||' : '|| sqlerrm);
     end;

     bars_audit.trace('%s: done', l_th);
   end upd_syncdata;

   --------------------------------------------------------------------------------
   -- upd_syncdata - ����� ���� �����
   --
   -- @data_id in number, data_type in cig_sync_types.type_id%type
   --
   procedure upd_syncdata_branch(p_data_id    in number,
                                 p_branch     in branch.branch%type,
                                 p_data_type  in cig_sync_types.type_id%type,
                                 p_branch_old in branch.branch%type) is
     l_th constant varchar2(100) := g_dbgcode || 'upd_syncdata_brnch';
     l_cnt      number;
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: data_id=%s, data_type=%s',
                      l_th,
                      to_char(p_data_id),
                      to_char(p_data_type));
     if (p_branch <> p_branch_old) then

       select count(*)
         into l_cnt
         from V_CIG_SYNC_DATA csd
        where csd.data_id = p_data_id
          and csd.branch = p_branch
          and csd.data_type = p_data_type;

       if (l_cnt = 0) then
         update V_CIG_SYNC_DATA csd
            set csd.branch = p_branch
          where csd.data_id = p_data_id
            and csd.branch = p_branch_old
            and csd.data_type = p_data_type;

         if p_data_type = G_CUSTDATA then
           update V_CIG_CUSTOMERS c
              set c.upd_date = sysdate
            where c.cust_id = p_data_id
              and c.branch  = p_branch;
         elsif p_data_type = G_DOGDATA then
           update V_CIG_DOG_GENERAL g
              set g.upd_date = sysdate
            where g.id = p_data_id
              and g.branch = p_branch;
         elsif p_data_type = G_DOG_INSTDATA then
           update v_cig_dog_instalment
              set update_date = sysdate
            where id = p_data_id;
         elsif p_data_type = G_DOG_CREDITDATA then
           update V_CIG_DOG_CREDIT
              set update_date = sysdate
            where id = p_data_id;
         end if;
       end if;
     end if;
     bars_audit.trace('%s: done', l_th);
   end upd_syncdata_branch; 
   
   procedure upd_dog_general_branch
   (
    ip_custid      in number,
    ip_old_branch  in varchar2,
    ip_row         in dog_general_rec_type
   )
   as
    l_dog_id cig_dog_general.id%type;
   begin
         upd_syncdata_branch(ip_custid, ip_row.branch, G_CUSTDATA, ip_old_branch);

         for cur in 
             (
              select g.id     as old_dog_id, 
                     g.branch as old_branch
              from V_CIG_DOG_GENERAL g
              where g.cust_id = ip_custid
                and g.branch = ip_old_branch
             )
        loop
           
         begin
           update V_CIG_DOG_GENERAL g
              set g.branch = ip_row.branch,
                  g.id     = s_cig_dog_general.nextval
            where g.branch = cur.old_branch
              and g.id     = cur.old_dog_id
           returning id into l_dog_id;
         exception
            when DUP_VAL_ON_INDEX then 
             l_dog_id := null;
             add_error(
                       G_SYSERROR,
                       '������ ��������� ������ '||ip_old_branch||' �� '||ip_row.branch,
                       sqlerrm,
                       ip_row.nd,
                       ip_row.rnk,
                       ip_row.custtype,
                       null
                      );
           raise;

         end;

         update v_cig_dog_stop st
            set st.branch = ip_row.branch,
                st.dog_id = l_dog_id
          where st.dog_id = cur.old_dog_id
            and st.branch = cur.old_branch;

         upd_syncdata_branch(l_dog_id, ip_row.branch, G_DOGDATA, cur.old_branch);

         for crs_i in 
            (
             select i.id, i.branch, i.rowid as ri
             from V_CIG_DOG_INSTALMENT i
             where i.branch = cur.old_branch
               and i.dog_id = cur.old_dog_id
             ) 
         loop
           update V_CIG_DOG_INSTALMENT i
              set i.branch = ip_row.branch,
                  i.dog_id = l_dog_id
            where i.rowid = crs_i.ri;

           upd_syncdata_branch(crs_i.id,
                               ip_row.branch,
                               G_DOG_INSTDATA,
                               crs_i.branch);
         end loop;

         for crs_c in 
           (
            select i.id, i.branch, i.rowid as ri
            from V_CIG_DOG_CREDIT i
            where i.branch = cur.old_branch
              and i.dog_id = cur.old_dog_id
            )
         loop
           update V_CIG_DOG_CREDIT i
              set i.branch = ip_row.branch,
                  i.dog_id = l_dog_id                
            where i.rowid = crs_c.ri;
            
           upd_syncdata_branch(crs_c.id,
                               ip_row.branch,
                               G_DOG_CREDITDATA,
                               crs_c.branch);
         end loop;
         
         
         for crs_n in 
            (
             select i.id, i.branch, i.rowid as ri
             from V_CIG_DOG_NONINSTALMENT i
             where i.branch = cur.old_branch
               and i.dog_id = cur.old_dog_id
             ) 
         loop
           update V_CIG_DOG_NONINSTALMENT i
              set i.branch = ip_row.branch,
                  i.dog_id = l_dog_id
            where i.rowid = crs_n.ri;

           upd_syncdata_branch(crs_n.id,
                               ip_row.branch,
                               G_DOG_NONINSTDATA,
                               crs_n.branch);
         end loop;

      end loop;

   end;
 
    --------------------------------------------------------------------------------
    -- ������� ������ � �������
    --
    --
    procedure p_customer_by_rnk
    (
     ip_rnk     in number,
     op_custid  out number,
     op_branch  out varchar2
    )
    as
    begin
     select v.cust_id, v.branch
       into op_custid, op_branch
     from V_CIG_CUSTOMERS v
     where v.rnk = ip_rnk;
    exception
      when NO_DATA_FOUND then 
        op_custid := null;
        op_branch := null;
    end p_customer_by_rnk;

   --------------------------------------------------------------------------------
   -- prc_individuals - �������� ������ � �������� - ��������
   --
   --
   procedure prc_individuals(l_row    in dog_general_rec_type,
                             p_result out boolean,
                             p_dtype  in number default null) is
     l_errm    varchar2(256);
     l_sqlerrm varchar2(4000);
     l_th constant varchar2(100) := g_dbgcode || 'prc_individuals';
     l_custid number;
     l_old_branch varchar2(200);
     l_upd    boolean;
     l_okpo   varchar2(10);
   begin
     savepoint ins_start;
     p_result := false;
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: cur_individuals record fetched, rnk=%s',
                      l_th,
                      to_char(l_row.rnk));

      -- ������� ������ � �������
      p_customer_by_rnk(l_row.rnk, l_custid, l_old_branch);

     -- ����������
     if (l_custid is not null) then
         l_upd := false;

       -- ��������� ��������� ����
       select cust_code into l_okpo
       from V_CIG_CUSTOMERS
       where cust_id = l_custid
         and branch = l_old_branch;
         -- ��� ��������� ���� � 00000000 �� ������ ���������� � ����� ���� ��� ��������� 2� ����� ������������� type=3 � type=4
       if (nvl(l_okpo,'0000000000') = '0000000000' and nvl(l_okpo,'0000000000') != l_row.okpo) then
          insert into v_cig_cust_change_code values
           (l_row.cust_key, f_ourmfo, 1);
       end if;
     
        begin
           update V_CIG_CUSTOMERS
              set cust_name = trim(l_row.surname) || ' ' || trim(l_row.firstname) || ' ' ||
                              trim(l_row.fathers_name),
                  cust_code = l_row.okpo,
                  branch    = l_row.branch
            where cust_id = l_custid
              and branch = l_old_branch;
       exception
        when DUP_VAL_ON_INDEX then 
            add_error(
               G_SYSERROR,
               '������ ����������� cig_mgr.prc_individuals CIG_CUSTOMERS '||l_old_branch||' �� '||l_row.branch,
               sqlerrm,
               l_row.nd,
               l_row.rnk,
               l_row.custtype,
               p_dtype
              );
           raise;   
         when others then 
             add_error(G_SYSERROR,
               '������ ����������� cig_mgr.prc_individuals CIG_CUSTOMERS',
               sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
              );                 
       end;

       begin
           update V_CIG_CUST_INDIVIDUAL
              set role_id        = l_row.role_id,
                  first_name     = l_row.firstname,
                  surname        = l_row.surname,
                  fathers_name   = l_row.fathers_name,
                  gender         = l_row.gender,
                  classification = l_row.classification,
                  birth_surname  = l_row.birth_surname,
                  date_birth     = l_row.date_birth,
                  place_birth    = l_row.place_birth,
                  residency      = l_row.residency,
                  citizenship    = l_row.citizenship,
                  neg_status     = l_row.neg_status,
                  education      = l_row.education,
                  marital_status = l_row.marital_status,
                  position       = l_row.position,
                  --cust_code = l_row.okpo,
                  --cust_key             = l_row.cust_key, -- �������� ������ COBUSUPABS-3290 ������ ���� �� ������ ����������
                  passp_ser            = l_row.ser,
                  passp_num            = l_row.numdoc,
                  passp_iss_date       = l_row.passp_iss_date,
                  passp_exp_date       = l_row.passp_exp_date,
                  passp_organ          = l_row.passp_organ,
                  phone_office         = l_row.phone_office,
                  phone_mobile         = l_row.phone_mobile,
                  phone_fax            = l_row.phone_fax,
                  email                = substr(trim(l_row.email), 1, 38),
                  website              = l_row.website,
                  fact_territory_id    = l_row.fact_terr_id,
                  fact_street_buildnum = l_row.fact_addr,
                  fact_post_index      = l_row.fact_zip,
                  reg_territory_id     = l_row.reg_terr_id,
                  reg_street_buildnum  = l_row.reg_addr,
                  reg_post_index       = l_row.reg_zip,
                  branch               = l_row.branch
            where cust_id = l_custid
              and branch = l_old_branch;
       exception
         when others then 
             add_error(G_SYSERROR,
               '������ ����������� CIG_CUST_INDIVIDUAL',
               sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
              );                 
       end;

       if sql%rowcount > 0 then
         l_upd := true;
       end if;

       if (l_old_branch != l_row.branch) then
           -- update branch for all entities
           upd_dog_general_branch(l_custid, l_old_branch, l_row);
       end if;

       if l_upd then

         upd_syncdata(l_custid, l_row.branch, G_CUSTDATA);

         add_event(G_WITHOUT_ERRORS,
                   bars_msg.get_msg(g_module_name,
                                    'CLI_UPDATED',
                                    to_char(l_row.rnk)),
                   null,
                   null,
                   l_row.rnk,
                   3,
                   p_dtype);
         bars_audit.trace('%s: record updated, rnk=%s',
                          l_th,
                          to_char(l_row.rnk));

       end if;

       -- �������
     else

       -- ������� � ������� �������
       select s_cig_customers.nextval into l_custid from dual;
  begin
       insert into V_CIG_CUSTOMERS
         (cust_id, cust_type, rnk, upd_date, cust_name, cust_code, branch)
       values
         (l_custid,
          G_CUST_INDIVIDUAL,
          l_row.rnk,
          sysdate,
          trim(l_row.surname) || ' ' || trim(l_row.firstname) || ' ' ||
          trim(l_row.fathers_name),
          l_row.okpo,
          l_row.branch);
   exception
     when others then 
         add_error(G_SYSERROR,
           '������ ������� cig_mgr.prc_individuals CIG_CUSTOMERS',
           sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
          );                 
         raise;
   end;

       -- ������� � ������� ������
  begin
       insert 
       into V_CIG_CUST_INDIVIDUAL
         (cust_id,
          role_id,
          first_name,
          surname,
          fathers_name,
          gender,
          classification,
          birth_surname,
          date_birth,
          place_birth,
          residency,
          citizenship,
          neg_status,
          education,
          marital_status,
          position, /*cust_code,*/
          cust_key,
          passp_ser,
          passp_num,
          passp_iss_date,
          passp_exp_date,
          passp_organ,
          phone_office,
          phone_mobile,
          phone_fax,
          email,
          website,
          fact_territory_id,
          fact_street_buildnum,
          fact_post_index,
          reg_territory_id,
          reg_street_buildnum,
          reg_post_index,
          branch)
       values
         (l_custid,
          l_row.role_id,
          l_row.firstname,
          l_row.surname,
          l_row.fathers_name,
          l_row.gender,
          l_row.classification,
          l_row.birth_surname,
          l_row.date_birth,
          l_row.place_birth,
          l_row.residency,
          l_row.citizenship,
          l_row.neg_status,
          l_row.education,
          l_row.marital_status,
          l_row.position,
          /*l_row.okpo,*/
          l_row.cust_key,
          l_row.ser,
          l_row.numdoc,
          l_row.passp_iss_date,
          l_row.passp_exp_date,
          l_row.passp_organ,
          l_row.phone_office,
          l_row.phone_mobile,
          l_row.phone_fax,
          substr(trim(l_row.email), 1, 38),
          l_row.website,
          l_row.fact_terr_id,
          l_row.fact_addr,
          l_row.fact_zip,
          l_row.reg_terr_id,
          l_row.reg_addr,
          l_row.reg_zip,
          l_row.branch);
   exception
     when others then 
         add_error(G_SYSERROR,
           '������ ������� CIG_CUST_INDIVIDUAL',
           sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
          );                 
       raise;   
   end;

       upd_syncdata(l_custid, l_row.branch, G_CUSTDATA);

       add_event(G_WITHOUT_ERRORS,
                 bars_msg.get_msg(g_module_name,
                                  'CLI_INSERTED',
                                  to_char(l_row.rnk)),
                 null,
                 null,
                 l_row.rnk,
                 3,
                 p_dtype);
       bars_audit.trace('%s: record inserted, rnk=%s',
                        l_th,
                        to_char(l_row.rnk));

     end if;
     p_result := true;
     bars_audit.trace('%s: done', l_th);

   exception
     when others then
       rollback to ins_start;
       p_result := false;
       bars_audit.trace('%s: exception block entry point, rnk=%s',
                        l_th,
                        to_char(l_row.rnk));

       -- ����� ORA ������
       l_sqlerrm := substr(sqlerrm, 1, 4000);
       bars_audit.trace('%s: l_sqlerrm=%s', l_th, l_sqlerrm);

       -- ����� BARS ������
       l_errm := get_error(sqlcode, sqlerrm);
       bars_audit.trace('%s: l_errm=%s', l_th, l_errm);

       -- ������ � ������
       add_error(G_SYSERROR, l_errm, l_sqlerrm, null, l_row.rnk, 3, p_dtype);
       bars_audit.trace('%s: error text saved, rnk=%s',
                        l_th,
                        to_char(l_row.rnk));

   end;

   --------------------------------------------------------------------------------
   -- prc_company - �������� ������ � �������� - �������
   --
   --
   procedure prc_company(l_row    in dog_general_rec_type,
                         p_result out boolean,
                         p_dtype  in number default null) is
     l_errm    varchar2(256);
     l_sqlerrm varchar2(4000);
     l_th constant varchar2(100) := g_dbgcode || 'prc_company';
     l_custid number;
     l_old_branch varchar2(200);
     l_upd        boolean;
   begin
     savepoint ins_start;
     p_result := false;
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: cur_company record fetched, rnk=%s',
                      l_th,
                      to_char(l_row.rnk));

      -- ������� ������ � �������
      p_customer_by_rnk(l_row.rnk, l_custid, l_old_branch);

     -- ����������
     if (l_custid is not null) then
       l_upd := false;
  begin
       update V_CIG_CUSTOMERS
          set cust_name = l_row.name,
              cust_code = l_row.cust_code,
              branch    = l_row.branch
        where cust_id = l_custid
          and branch = l_old_branch;
   EXCEPTION 
     when DUP_VAL_ON_INDEX then 
          add_error(
             G_SYSERROR,
             '������ ����������� cig_mgr.prc_company CIG_CUSTOMERS '||l_old_branch||' �� '||l_row.branch,
             sqlerrm,
             l_row.nd,
             l_row.rnk,
             l_row.custtype,
             p_dtype
            );
           raise;   
      when others then 
           add_error(G_SYSERROR,
             '������ ����������� cig_mgr.prc_company CIG_CUSTOMERS '||l_old_branch||' �� '||l_row.branch,
             sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
            );    
   end;

 begin
       update v_cig_cust_company
          set role_id           = l_row.role_id,
              status_id         = l_row.status_id,
              lang_name         = l_row.lang_name,
              name              = l_row.name,
              lang_abbreviation = l_row.lang_abbreviation,
              abbreviation      = l_row.abbreviation,
              ownership         = l_row.ownership,
              registr_date      = l_row.registr_date,
              economic_activity = l_row.economic_activity,
              employe_count     = l_row.emplote_count,
              /*cust_code = l_row.cust_code,*/
              reg_num              = l_row.reg_num,
              phone_office         = l_row.phone_office,
              phone_mobile         = l_row.phone_mobile,
              phone_fax            = l_row.tel_fax,
              email                = substr(trim(l_row.e_mail), 1, 38),
              website              = l_row.website,
              fact_territory_id    = l_row.fact_terr_id,
              fact_street_buildnum = l_row.fact_addr,
              fact_post_index      = l_row.fact_zip,
              reg_territory_id     = l_row.reg_terr_id,
              reg_street_buildnum  = l_row.reg_addr,
              reg_post_index       = l_row.reg_zip,
              branch               = l_row.branch
        where cust_id = l_custid
          and branch = l_old_branch;
   exception
         when others then 
           add_error(G_SYSERROR,
             '������ ����������� CIG_CUST_COMPANY',
             sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
            );  
   end;

       if sql%rowcount > 0 then
         l_upd := true;
       end if;

       if (l_old_branch != l_row.branch) then
           -- update branch for all entities
           upd_dog_general_branch(l_custid, l_old_branch, l_row);
           
       end if;

       if l_upd then

         upd_syncdata(l_custid, l_row.branch, G_CUSTDATA);

         -- ������ � ������
         add_event(G_WITHOUT_ERRORS,
                   bars_msg.get_msg(g_module_name,
                                    'CLI_UPDATED',
                                    to_char(l_row.rnk)),
                   null,
                   null,
                   l_row.rnk,
                   2,
                   p_dtype);
         bars_audit.trace('%s: record updated, rnk=%s',
                          l_th,
                          to_char(l_row.rnk));

       end if;

       -- �������
     else

       -- ������� � ������� �������
       select s_cig_customers.nextval into l_custid from dual;

  begin
     insert into V_CIG_CUSTOMERS
       (cust_id, cust_type, rnk, upd_date, cust_name, cust_code, branch)
     values
       (l_custid,
        G_CUST_COMPANY,
        l_row.rnk,
        sysdate,
        l_row.name,
        l_row.cust_code,
        l_row.branch);
   exception
     when others then 
         add_error(G_SYSERROR,
           '������ ������� cig_mgr.prc_company CIG_CUSTOMERS',
           sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
          );
         raise;       
   end;

       -- ��������� ������ � �������
  begin
       insert into v_cig_cust_company
         (cust_id,
          role_id,
          status_id,
          lang_name,
          name,
          lang_abbreviation,
          abbreviation,
          ownership,
          registr_date,
          economic_activity,
          employe_count, /*cust_code,*/
          reg_num,
          phone_office,
          phone_mobile,
          phone_fax,
          email,
          website,
          fact_territory_id,
          fact_street_buildnum,
          fact_post_index,
          reg_territory_id,
          reg_street_buildnum,
          reg_post_index,
          branch)
       values
         (l_custid,
          l_row.role_id,
          l_row.status_id,
          l_row.lang_name,
          l_row.name,
          l_row.lang_abbreviation,
          l_row.abbreviation,
          l_row.ownership,
          l_row.registr_date,
          l_row.economic_activity,
          l_row.emplote_count,
          /*l_row.cust_code,*/
          l_row.reg_num,
          l_row.phone_office,
          l_row.phone_mobile,
          l_row.tel_fax,
          substr(trim(l_row.e_mail), 1, 38),
          l_row.website,
          l_row.fact_terr_id,
          l_row.fact_addr,
          l_row.fact_zip,
          l_row.reg_terr_id,
          l_row.reg_addr,
          l_row.reg_zip,
          l_row.branch);

   exception
     when others then 
         add_error(G_SYSERROR,
           '������ ������� CIG_CUST_COMPANY',
           sqlerrm, l_row.nd, l_row.rnk,  l_row.custtype, p_dtype
          );
         raise;                 
   end;

       upd_syncdata(l_custid, l_row.branch, G_CUSTDATA);

       -- ������ � ������
       add_event(G_WITHOUT_ERRORS,
                 bars_msg.get_msg(g_module_name,
                                  'CLI_INSERTED',
                                  to_char(l_row.rnk)),
                 null,
                 null,
                 l_row.rnk,
                 2,
                 p_dtype);

       bars_audit.trace('%s: record inserted, rnk=%s',
                        l_th,
                        to_char(l_row.rnk));

     end if;
     p_result := true;
     bars_audit.trace('%s: done', l_th);
   exception
     when others then
       rollback to ins_start;

       p_result := false;
       bars_audit.trace('%s: exception block entry point, rnk=%s',
                        l_th,
                        to_char(l_row.rnk));

       -- ����� ORA ������
       l_sqlerrm := substr(sqlerrm, 1, 4000);
       bars_audit.trace('%s: l_sqlerrm=%s', l_th, l_sqlerrm);

       -- ����� BARS ������
       l_errm := get_error(sqlcode, sqlerrm);
       bars_audit.trace('%s: l_errm=%s', l_th, l_errm);

       -- ������ � ������
       add_error(G_SYSERROR, l_errm, l_sqlerrm, null, l_row.rnk, 2, p_dtype);
       bars_audit.trace('%s: error text saved, rnk=%s',
                        l_th,
                        to_char(l_row.rnk));

   end;

   --------------------------------------------------------------------------------
   --get_dg_rc - ������������� ������ ��� ������ ���������� �� ��������� ���������
   --
   --------p_deptno =
  procedure get_dg_rs(p_dtype     IN NUMBER,
                       p_date      in DATE,
                       p_recordset OUT SYS_REFCURSOR) is
     l_pdatef date;
     l_pdate  date;
     l_pdatel date;
   begin
     l_pdatef := trunc(p_date, 'mm');
     l_pdate  := trunc(p_date);
     l_pdatel := trunc(p_date, 'mm') - 1;
     dbms_application_info.set_action('Query...');
     if (p_dtype = 1) then
       OPEN p_recordset FOR
          select q.nd,
                q.rnk,
                q.start_date,
                q.end_date,
                q.bdate,
                q.dazs,
                q.currency,
                q.currency_id,
                q.cig_13,
                null as cig_14,
                case
                  when ((q.dazs is not null) and
                       (trunc(q.end_date) > trunc(q.dazs))) then
                   6
                  when ((q.dazs is not null) and
                       (trunc(q.end_date) <= trunc(q.dazs))) then
                   5
                  else
                   4
                end as cig_15,
                q.cig_16,
                q.cig_17,
                decode(q.custtype,
                       3,
                       2,
                       2,
                       decode(nvl(q.credit_period, 0), 5, 2, 10)) cig_18,
                q.cig_19,
                q.cig_20,
                q.custtype,
                q.contract_type,
                q.branch,
                null as limit_sum,
                null as credit_usage,
                null as res_sum,
                null as overdue_sum,
                null as accountingDate,
                c2.fact_terr_id,
                c2.fact_addr,
                c2.fact_zip,
                c2.reg_terr_id,
                c2.reg_addr,
                c2.reg_zip,
                q.role_id,
                q.firstname,
                q.surname,
                q.fathers_name,
                q.gender,
                q.classification,
                q.birth_surname,
                q.date_birth,
                q.place_birth,
                q.residency,
                q.citizenship,
                q.neg_status,
                q.education,
                q.marital_status,
                decode(q.position,
                       '0',
                       '0',
                       '1',
                       '1',
                       '2',
                       '2',
                       '3',
                       '3',
                       '4',
                       '4',
                       '5',
                       '5',
                       '6',
                       '6',
                       '7',
                       '7',
                       '8',
                       '8',
                       '9',
                       '9',
                       null) as position,
                q.okpo,
                q.cust_key,
                q.ser,
                q.numdoc,
                q.passp_iss_date,
                q.passp_exp_date,
                q.passp_organ,
                q.phone_office,
                q.phone_mobile,
                q.phone_fax,
                q.email,
                q.website,
                q.status_id,
                q.lang_name,
                q.name,
                q.lang_abbreviation,
                q.abbreviation,
                q.ownership,
                q.registr_date,
                q.economic_activity,
                q.emplote_count,
                q.cust_code,
                q.reg_num,
                q.tel_fax,
                q.e_mail,
                q.a8_acc,
                q.a8_kv,
                q.branch_dog
           from (select cd.nd,
                        cd.sdate as start_date,
                        cd.wdate as end_date,
                        val.kv as currency_id,
                        val.lcv as currency,
                        cd.rnk,
                        cda.bdate as bdate,
                        ow.cig_13,
                        null as cig_16,
                        null as cig_17,
                        cda.freq as credit_period,
                        1 as cig_19,
                        ow.cig_20,
                        a8.dazs as dazs,
                        c.custtype,
                        case
                          when cd.vidd in (1, 11) then
                           1
                          when cd.vidd in (2, 3, 12, 13) then
                           2
                        end as contract_type,
                        1 as role_id,
                        null as firstname,
                        null as surname,
                        null as fathers_name,
                        null as gender,
                        null as classification,
                        null as birth_surname,
                        null as date_birth,
                        null as place_birth,
                        null as residency,
                        null as citizenship,
                        null as neg_status,
                        null as education,
                        null as marital_status,
                        null as position,
                        null as okpo,
                        null as cust_key,
                        null as ser,
                        null as numdoc,
                        null as passp_iss_date,
                        null as passp_exp_date,
                        null as passp_organ,
                        c1.telr as phone_office,
                        null as phone_mobile,
                        null as phone_fax,
                        null as email,
                        null as website,
                        1 status_id,
                        'uk-UA' lang_name,
                        c.nmk name,
                        'uk-UA' lang_abbreviation,
                        c.nmkk abbreviation,
                        case
                          when c.sed in ('00', '91', '34') then
                           0
                          when c.sed in ('08',
                                         '09',
                                         '10',
                                         '11',
                                         '12',
                                         '13',
                                         '14',
                                         '15',
                                         '16',
                                         '17',
                                         '19',
                                         '33',
                                         '20') then
                           1
                          when c.sed in ('23', '24', '25', '26', '27') then
                           2
                          when c.sed in
                               ('61', '62', '63', '64', '65', '66', '18') then
                           3
                          when c.sed in ('40', '41', '42', '43', '44') then
                           4
                          when c.sed in ('70', '28', '29', '30', '31', '32') then
                           5
                          when c.sed in ('80', '50', '51', '52') then
                           6
                          when c.sed in ('45',
                                         '46',
                                         '47',
                                         '48',
                                         '49',
                                         '53',
                                         '54',
                                         '55',
                                         '56',
                                         '57') then
                           8
                          else
                           9
                        --when c.sed in ('92','93','94','95','96','97','21','22') then 9
                        end as ownership,
                        c.datea registr_date,
                        null economic_activity,
                        DECODE(DECODE(TRANSLATE(TRANSLATE(trim(f_get_custw_h(c.rnk,
                                                                             'FSKPR',
                                                                             trunc(sysdate))),
                                                          '_',
                                                          '-'),
                                                '0123456789',
                                                '__________'),
                                      '_',
                                      1,
                                      '__',
                                      1,
                                      '___',
                                      1,
                                      '____',
                                      1,
                                      '_____',
                                      1,
                                      '______',
                                      1,
                                      '_______',
                                      1,
                                      '________',
                                      1,
                                      '_________',
                                      1,
                                      0),
                               1,
                               case
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 1 and 5 then
                                  1
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 6 and 30 then
                                  2
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 31 and 100 then
                                  3
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 101 and 500 then
                                  4
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) > 500 then
                                  5
                               end,
                               NULL) emplote_count,
                        c.okpo cust_code,
                        null reg_num,
                        c1.tel_fax,
                        c1.e_mail,
                        a8.acc as a8_acc,
                        a8.kv as a8_kv,
                        c.branch,
                        cd.branch as branch_dog
                   from cc_deal cd,
                        cc_add cda,
                        customer c,
                        (select nd,
                                max(cig_13) as cig_13,
                                max(cig_20) as cig_20
                           from (select nd,
                                        decode(tag, 'CIG_D13', value) as cig_13,
                                        decode(tag, 'CIG_D20', value) as cig_20
                                   from mos_operw
                                  where tag in ('CIG_D13', 'CIG_D20'))
                          group by nd) ow,
                        tabval val,
                        corps c1,
                        nd_acc n,
                        accounts a8
                  where cd.nd = cda.nd
                    and cd.rnk = c.rnk
                    and cd.nd = ow.nd
                    and ow.cig_13 > 0
                    and cda.kv = val.kv
                    and c.custtype = 2
                    and cd.rnk = c1.rnk(+)
                    and cd.nd = n.nd
                    and n.acc = a8.acc
                    and a8.tip = 'LIM'
                    --and to_number(substr(cd.prod, 1, 1)) < 9 #COBUSUPABS-4018
                    and substr(cd.prod, 1, 1) ='2'
                 --and not exists (select nd from cig_dog_general where nd = cd.nd)
             ---------

             union all -- ���.��� contract_type = 3

             SELECT cd.nd,
                    cd.sdate AS start_date,
                    cd.wdate AS end_date,
                    val.kv   AS currency_id,
                    val.lcv  AS currency,
                    cd.rnk,

                    cd.sdate  AS bdate,
                    ow.cig_13,
                    NULL      AS cig_16,
                    NULL      AS cig_17,
                    5         AS credit_period,
                    1         AS cig_19,
                    ow.cig_20,

                    a.dazs     AS dazs,
                    c.custtype,
      case when cd.vidd in (1, 11)        then 1
           when cd.vidd in (2, 3, 12, 13) then 2 end as contract_type,
                    1          AS role_id,

 ----------------http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-4056 --COBUMMFO-5168
  fio(trim(REGEXP_REPLACE (c.nmk,'^���')), 2) firstname,     --  NULL AS firstname,
  fio(trim(REGEXP_REPLACE (c.nmk,'^���')), 1) surname, --  NULL AS surname,
                    NULL AS fathers_name,
  decode(to_number(p.sex),1,1,2,2,null) gender, --  NULL AS gender,
  case when to_number(nvl(c.sed, 0)) = 91 then  2 else 1 end  classification,    --  NULL AS classification,
                    NULL AS birth_surname,
  p.bday  date_birth,    -- NULL AS date_birth,
                    NULL AS place_birth,
  case when c.codcagent = 5 then 1 else 2 end   residency,     -- NULL AS residency,
  case when cty.k040 = '011' then 'UA' else cty.a2 end citizenship,    -- NULL AS citizenship,
                    NULL AS neg_status,
                    NULL AS education,
                    NULL AS marital_status,
  decode(w.value,'0','0','1','1','2','2','3','3',
                                               '4','4','5','5','6','6','7','7','8','8','9') position,   --  NULL AS position,
  c.okpo ,     --  NULL AS okpo,
  fio(c.nmk, 2) || fio(c.nmk, 1) || to_char(p.bday, 'ddmmyyyy') cust_key,   --  NULL AS cust_key,
  case when  p.passp = 7 then nvl(p.ser,0) else p.ser end ser,    --  NULL AS ser,
  p.numdoc numdoc,    --  NULL AS numdoc,
  p.pdate passp_iss_date,      --   NULL AS passp_iss_date,
                    NULL AS passp_exp_date,
  p.organ  passp_organ, -- NULL AS passp_organ,

                    c1.telr AS phone_office,
                    NULL    AS phone_mobile,
                    NULL    AS phone_fax,
                    NULL    AS email,
                    NULL    AS website,
                    1       status_id,

                    'uk-UA' lang_name,
                    c.nmk name,
                    'uk-UA' lang_abbreviation,
                    c.nmkk abbreviation,

                    CASE
                      WHEN c.sed IN ('00', '91', '34') THEN
                       0

                      WHEN c.sed IN ('08',
                                     '09',
                                     '10',
                                     '11',
                                     '12',
                                     '13',
                                     '14',
                                     '15',
                                     '16',
                                     '17',
                                     '19',
                                     '33',
                                     '20') THEN
                       1

                      WHEN c.sed IN ('23', '24', '25', '26', '27') THEN
                       2

                      WHEN c.sed IN ('61', '62', '63', '64', '65', '66', '18') THEN
                       3

                      WHEN c.sed IN ('40', '41', '42', '43', '44') THEN
                       4

                      WHEN c.sed IN ('70', '28', '29', '30', '31', '32') THEN
                       5

                      WHEN c.sed IN ('80', '50', '51', '52') THEN
                       6

                      WHEN c.sed IN
                           ('45', '46', '47', '48', '49', '53', '54', '55', '56', '57') THEN
                       8

                      ELSE
                       9

                    END AS ownership,

                    c.datea registr_date,
                    NULL    economic_activity,

                    DECODE(DECODE(TRANSLATE(TRANSLATE(TRIM(f_get_custw_h(c.rnk,
                                                                         'FSKPR',
                                                                         TRUNC(SYSDATE))),
                                                      '_',
                                                      '-'),
                                            '0123456789',
                                            '__________'),

                                  '_',
                                  1,
                                  '__',
                                  1,
                                  '___',
                                  1,
                                  '____',
                                  1,
                                  '_____',
                                  1,
                                  '______',
                                  1,
                                  '_______',
                                  1,
                                  '________',
                                  1,
                                  '_________',
                                  1,
                                  0),
                           1,

                           CASE
                             WHEN TO_NUMBER(TRIM(f_get_custw_h(c.rnk, 'FSKPR', TRUNC(SYSDATE)))) BETWEEN 1 AND 5 THEN
                              1

                             WHEN TO_NUMBER(TRIM(f_get_custw_h(c.rnk, 'FSKPR', TRUNC(SYSDATE)))) BETWEEN 6 AND 30 THEN
                              2

                             WHEN TO_NUMBER(TRIM(f_get_custw_h(c.rnk, 'FSKPR', TRUNC(SYSDATE)))) BETWEEN 31 AND 100 THEN
                              3

                             WHEN TO_NUMBER(TRIM(f_get_custw_h(c.rnk, 'FSKPR', TRUNC(SYSDATE)))) BETWEEN 101 AND 500 THEN
                              4

                             WHEN TO_NUMBER(TRIM(f_get_custw_h(c.rnk, 'FSKPR', TRUNC(SYSDATE)))) > 500 THEN
                              5

                           END,

                           NULL) emplote_count,

                    c.okpo     cust_code,
                    NULL       reg_num,
                    c1.tel_fax,
                    c1.e_mail,
                    a.acc      AS a8_acc,
                    a.kv       AS a8_kv,
                    c.branch,
                    cd.branch  AS branch_dog

               FROM cc_deal  cd,
                    customer c,
                    customerw w,
                    person   p,
                    kl_k040 cty,
                    tabval   val,
                    corps    c1,
                    nd_acc   n,
                    accounts a,

                    (SELECT nd, MAX(cig_13) cig_13, MAX(cig_20) cig_20
                       FROM (SELECT nd,
                                    DECODE(tag, 'CIG_D13', VALUE) cig_13,
                                    DECODE(tag, 'CIG_D20', VALUE) cig_20
                               FROM mos_operw
                              WHERE tag IN ('CIG_D13', 'CIG_D20'))
                      GROUP BY nd) ow

              WHERE cd.rnk = c.rnk
                and p.rnk  = c.rnk
                and c.country = cty.k040(+)
                and a.rnk = w.rnk(+)
                and w.tag(+) = 'CIGPO'
                AND cd.nd = ow.nd
                and ow.cig_13 > 0
                AND a.kv = val.kv
                AND c.custtype in (2,3)
                AND cd.rnk = c1.rnk(+)
                AND cd.nd = n.nd
                AND n.acc = a.acc
                and a.tip = 'LIM'
                and substr(cd.prod, 1, 1) ='2'

                /*AND a.nbs in ('2600', '2650')
                AND cd.vidd in (10, 110)*/
                ) q,
               (SELECT rnk as rnk, --
        nvl(fact_terr_id, reg_terr_id) as fact_terr_id, --
        NVL(CASE WHEN fact_type_id = 2 AND fact_terr_id = -1 THEN
                      DECODE(domain2,   NULL, '', trim(domain2) || ', ') ||
                      DECODE(region2,   NULL, '', trim(region2) || ', ') ||
                      DECODE(locality2, NULL, '', trim(locality2) || ', ') || trim(address2)
                 WHEN fact_type_id = 2 AND fact_terr_id > 0  THEN
                      address2
                 ELSE NULL   END, --NVL-- ���� ��� ���.���. ������� ����.���.
                      DECODE(domain1,   NULL, '', trim(domain1) || ', ') ||
                      DECODE(region1,   NULL, '', trim(region1) || ', ') ||
                      DECODE(locality1, NULL, '', trim(locality1) || ', ') || trim(address1)) as fact_addr, --
        NVL(fact_zip, reg_zip) as fact_zip, --
        reg_terr_id            as reg_terr_id,--
        NVL(CASE WHEN reg_type_id = 1 AND NVL(reg_terr_id, -1) = -1 THEN
                      DECODE(domain1,   NULL, '', trim(domain1) || ', ') ||
                      DECODE(region1,   NULL, '', trim(region1) || ', ') ||
                      DECODE(locality1, NULL, '', trim(locality1) || ', ') || trim(address1)
                 WHEN reg_type_id = 1 AND reg_terr_id > 0           THEN
                      address1
                 ELSE NULL END,  --NVL-- ���� ��� ����.���. ������� ���.���.
                      DECODE(domain2,   NULL, '', trim(domain2) || ', ') ||
                      DECODE(region2,   NULL, '', trim(region2) || ', ') ||
                      DECODE(locality2, NULL, '', trim(locality2) || ', ') || trim(address2)) as reg_addr, --
        NVL(reg_zip, fact_zip) as reg_zip --
   FROM (SELECT rnk,
                min(DECODE(territory_id, null, -1, territory_id)) as territory_id,
                MAX(DECODE(type_id, 1,   type_id,  NULL)) AS reg_type_id,
                MAX(DECODE(type_id, 2,   type_id,  NULL)) AS fact_type_id,
                MAX(DECODE(type_id, 2,   nvl(territory_id, -1), -1)) AS fact_terr_id,
                MAX(DECODE(type_id, 2,   zip,      NULL)) AS fact_zip,
                MAX(DECODE(type_id, 2,   domain,   NULL)) AS domain2,
                MAX(DECODE(type_id, 2,   region,   NULL)) AS region2,
                MAX(DECODE(type_id, 2,   locality, NULL)) AS locality2,
                MAX(DECODE(type_id, 2,   address,  NULL)) AS address2,
                MAX(DECODE(type_id, 1,   zip,      NULL)) AS reg_zip,
                MAX(DECODE(type_id, 1,   domain,   NULL)) AS domain1,
                MAX(DECODE(type_id, 1,   region,   NULL)) AS region1,
                MAX(DECODE(type_id, 1,   locality, NULL)) AS locality1,
                MAX(DECODE(type_id, 1,   address,  NULL)) AS address1,
                MAX(DECODE(type_id, 1,   nvl(territory_id, -1), -1)) AS reg_terr_id
           FROM bars.customer_address
          WHERE 1=1 /*rnk IN (16784021, 37853721, 95127921, 95497721, 151213521, 277793721)*/
            AND type_id < 3
          GROUP BY rnk) ) c2
          where q.rnk = c2.rnk(+);
     elsif (p_dtype = G_CONTRACT_BPK) then
       OPEN p_recordset FOR 'select tab.nd,
                tab.rnk,
                tab.daos as start_date,
                tab.dat_z as end_date,
                tab.daos as bdate,
                tab.dazs,
                t.lcv as currency,
                tab.kv as currency_id,
                tab.cig_13,
                null as cig_14,
                case
                  when ((tab.dazs is not null)
                         and (trunc(tab.dat_z) > trunc(tab.dazs)))
                  then ''6''
                  when ((tab.dazs is not null)
                         and (trunc(tab.dat_z) <= trunc(tab.dazs)))
                  then ''5''
                  else ''4''
                end as cig_15,
                tab.cig_16,
                tab.cig_17,
                ''2'' as cig_18,
                tab.cig_19,
                tab.cig_20,
                tab.custtype,
                tab.contract_type,' || 'tab.branch,' || 'tab.limit_sum,
                tab.credit_usage,
                tab.res_sum,
                tab.overdue_sum,
                tab.accountingDate,
                c2.fact_terr_id,
                c2.fact_addr,
                c2.fact_zip,
                c2.reg_terr_id,
                c2.reg_addr,
                c2.reg_zip,
                tab.role_id,
                tab.firstname,
                tab.surname,
                tab.fathers_name,
                tab.gender,
                tab.classification,
                tab.birth_surname,
                tab.date_birth,
                tab.place_birth,
                tab.residency,
                tab.citizenship,
                tab.neg_status,
                tab.education,
                tab.marital_status,
                decode(tab.position,''0'',''0'',''1'',''1'',''2'',''2'',''3'',''3'',''4'',''4'',''5'',''5'',''6'',''6'',''7'',''7'',''8'',''8'',''9'') as position,
                tab.okpo,
                tab.cust_key,
                tab.ser,
                tab.numdoc,
                tab.passp_iss_date,
                tab.passp_exp_date,
                tab.passp_organ,
                tab.phone_office,
                tab.phone_mobile,
                tab.phone_fax,
                tab.email,
                tab.website,
                tab.status_id,
                tab.lang_name,
                tab.name,
                tab.lang_abbreviation,
                tab.abbreviation,
                tab.ownership,
                tab.registr_date,
                tab.economic_activity,
                tab.emplote_count,
                tab.cust_code,
                tab.reg_num,
                tab.tel_fax,
                tab.e_mail,
                null as a8_acc,
                null as a8_kv,' || 'tab.branch as branch_dog' || ' from (select aa.nd,
                aa.daos,
                aa.dat_z,
                aa.kv,
                aa.rnk,
                null as bdate,
                null as cig_13,
                null as cig_16,
                null as cig_17,
                null as credit_period,
                ''1'' as cig_19,
                null as cig_20,
                aa.dazs,
                c.custtype,
                3 as contract_type,
                1 as role_id,
                null as firstname,
                null as surname,
                null as fathers_name,
                null as gender,
                null as classification,
                null as birth_surname,
                null as date_birth,
                null as place_birth,
                null as residency,
                null as citizenship,
                null as neg_status,
                null as education,
                null as marital_status,
                null as position,
                null as okpo,
                null as cust_key,
                null as ser,
                null as numdoc,
                null as passp_iss_date,
                null as passp_exp_date,
                null as passp_organ,
                c1.telr as phone_office,
                null as phone_mobile,
                null as phone_fax,
                null as email,
                null as website,
                1 status_id,
                ''uk-UA'' lang_name,
                c.nmk name,
                ''uk-UA'' lang_abbreviation,
                c.nmkk abbreviation,
                case
                  when c.sed in (''00'', ''91'', ''34'')
                  then 0
                  when c.sed in (''08'',
                                 ''09'',
                                 ''10'',
                                 ''11'',
                                 ''12'',
                                 ''13'',
                                 ''14'',
                                 ''15'',
                                 ''16'',
                                 ''17'',
                                 ''19'',
                                 ''33'',
                                 ''20'')
                  then 1
                  when c.sed in (''23'', ''24'', ''25'', ''26'', ''27'')
                  then 2
                  when c.sed in (''61'', ''62'', ''63'', ''64'', ''65'', ''66'', ''18'')
                  then 3
                  when c.sed in (''40'', ''41'', ''42'', ''43'', ''44'')
                  then 4
                  when c.sed in (''70'', ''28'', ''29'', ''30'', ''31'', ''32'')
                  then 5
                  when c.sed in (''80'', ''50'', ''51'', ''52'')
                  then 6
                  when c.sed in (''45'',
                                 ''46'',
                                 ''47'',
                                 ''48'',
                                 ''49'',
                                 ''53'',
                                 ''54'',
                                 ''55'',
                                 ''56'',
                                 ''57'')
                  then 8
                  else 9
            --when c.sed in (''92'',''93'',''94'',''95'',''96'',''97'',''21'',''22'') then 9
                end as ownership,
                c.datea registr_date,
                null economic_activity,
                DECODE(DECODE(TRANSLATE(TRANSLATE(trim(f_get_custw_h(c.rnk,
                                                                 ''FSKPR'',
                                                           trunc(sysdate))),
                          ''_'',
                          ''-''),
                          ''0123456789'',
                          ''__________''),
                          ''_'',
                          1,
                          ''__'',
                          1,
                          ''___'',
                          1,
                          ''____'',
                          1,
                          ''_____'',
                          1,
                          ''______'',
                          1,
                          ''_______'',
                          1,
                          ''________'',
                          1,
                          ''_________'',
                          1,
                          0),
                           1,
                   case
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 1 and 5 then
                      1
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 6 and 30 then
                      2
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 31 and 100 then
                      3
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 101 and 500 then
                      4
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) > 500 then
                      5
                   end,
                   NULL) emplote_count,
            c.okpo cust_code,
            null reg_num,
            c1.tel_fax,
            c1.e_mail,
                    aa.branch,
                  aa.ost_9129 + aa.ost_ovr limit_sum,
                  aa.sysdt accountingDate,
                  (select nvl(max(decode(d.dk, 1, 1, 2)), 3)
                     from opldok d
                    where d.acc = aa.acc_ovr
                      and d.fdat =
                          (select max(fdat)
                             from opldok
                            where acc = d.acc
                          and fdat between :p_date_f and aa.sysdt)) credit_usage,
                  aa.ost_ovr + aa.ost_2207 + aa.ost_2208 + aa.ost_2209 + decode(sign(aa.ost_pk), -1, aa.ost_pk, 0) + aa.ost_3570 + aa.ost_3579 res_sum,
                  aa.ost_2207 + aa.ost_2209 + aa.ost_3579 overdue_sum
                   from (select o.nd,
                                o.acc_pk,
                                a.kv,
                                b.daos,
                                a.branch,
                                add_months(a.daos,
                                           nvl(to_number(w.value),
                                               nvl(p.mm_max, 0))) dat_z,
                                nvl(o.acc_ovr, o.acc_2203) acc_ovr,
                                nvl(sum(decode(ostatki.acc, o.acc_pk, ostatki.ost)), 0) ost_pk,
                                nvl(sum(decode(ostatki.acc, nvl(o.acc_ovr, o.acc_2203), ostatki.ost)), 0) ost_ovr,
                                nvl(sum(decode(ostatki.acc, o.acc_2207, ostatki.ost)), 0) ost_2207,
                                nvl(sum(decode(ostatki.acc, o.acc_2208, ostatki.ost)), 0) ost_2208,
                                nvl(sum(decode(ostatki.acc, o.acc_2209, ostatki.ost)), 0) ost_2209,
                                nvl(sum(decode(ostatki.acc, o.acc_3570, ostatki.ost)), 0) ost_3570,
                                nvl(sum(decode(ostatki.acc, o.acc_3579, ostatki.ost)), 0) ost_3579,
                                nvl(sum(decode(ostatki.acc, o.acc_9129, ostatki.ost)), 0) ost_9129,
 /*
                                fost(o.acc_pk, sd.sysdt) ost_pk,
                                nvl2(nvl(o.acc_ovr, o.acc_2203),fost(nvl(o.acc_ovr, o.acc_2203), sd.sysdt),0) ost_ovr,
                                nvl2(o.acc_2207, fost(o.acc_2207, sd.sysdt), 0) ost_2207,
                                nvl2(o.acc_2208, fost(o.acc_2208, sd.sysdt), 0) ost_2208,
                                nvl2(o.acc_2209, fost(o.acc_2209, sd.sysdt), 0) ost_2209,
                                nvl2(o.acc_3570, fost(o.acc_3570, sd.sysdt), 0) ost_3570,
                                nvl2(o.acc_3579, fost(o.acc_3579, sd.sysdt), 0) ost_3579,
                                nvl2(o.acc_9129,fost(o.acc_9129, sd.sysdt),0) ost_9129,
 */
                                a.rnk,
                                a.dazs,
                                sd.sysdt
                           from w4_acc o join accounts a on o.acc_pk = a.acc
                           join accounts b on o.acc_9129 = b.acc
                           left outer join accountsw w on a.acc = w.acc and w.tag = ''PK_TERM''
                           join w4_card d on o.card_code = d.code
                           join CM_PRODUCT p on d.product_code = p.product_code
                           join (select :p_date as sysdt from dual) sd on 1 = 1
                           left outer join
                            (select a_ost.acc, a_ost.ostc - nvl(sum(s_ost.kos - s_ost.dos), 0) as ost
                               from accounts a_ost left outer join saldoa s_ost on a_ost.acc = s_ost.acc and s_ost.fdat > :p_date
                             group by a_ost.acc, a_ost.ostc) ostatki
                               on ostatki.acc = any(o.acc_pk, o.acc_ovr, o.acc_2203, o.acc_2207, o.acc_2208, o.acc_2209, o.acc_3570, o.acc_3579, o.acc_9129)

                            group by  o.nd, o.acc_pk, a.kv, b.daos, a.branch, a.rnk, a.dazs, sd.sysdt,
                                add_months(a.daos, nvl(to_number(w.value), nvl(p.mm_max, 0))), nvl(o.acc_ovr, o.acc_2203)
                            ) aa,
                        customer c,
                        corps c1
                  where aa.rnk = c.rnk
                    and c.custtype = 2
                    and aa.rnk = c1.rnk(+)

 union all
 select
                  aa.nd,
                  aa.daos,
                  aa.dat_z,
                  aa.kv,
                  aa.rnk,
                  null as bdate,
                  null as cig_13,
                  null as cig_16,
                  null as cig_17,
                  null as credit_period,
                  ''1'' as cig_19,
                  null as cig_20,
                  aa.dazs,
                  c.custtype,
                  3 as contract_type,
            1 as role_id,
            fio(trim(REGEXP_REPLACE (c.nmk,''^��� '')), 2) as firstname,
            fio(trim(REGEXP_REPLACE (c.nmk,''^��� '')), 1) as surname,
            fio(trim(REGEXP_REPLACE (c.nmk,''^��� '')), 3) as fathers_name,
            decode(to_number(p.sex),1,1,2,2,null) as gender,
            case
              when to_number(nvl(c.sed, 0)) = 91 then
               2
              else
               1
            end as classification,
            to_char(null) birth_surname,
            p.bday as date_birth,
            p.bplace place_birth,
            case
              when c.codcagent = 5 then
               1
              else
               2
            end as residency,
            case when cty.k040 = ''011'' then ''UA'' else cty.a2 end as citizenship,
            null as neg_status,
            null as education,
            null as marital_status,
            decode(w.value,''0'',''0'',''1'',''1'',''2'',''2'',''3'',''3'',''4'',''4'',''5'',''5'',''6'',''6'',''7'',''7'',''8'',''8'',''9'') as position,
            c.okpo,
            fio(c.nmk, 2) || fio(c.nmk, 1) || to_char(p.bday, ''ddmmyyyy'') as cust_key,
     case when  p.passp = 7 then nvl(p.ser,0) else p.ser end ser,
            p.numdoc,
            p.pdate as passp_iss_date,
            null as passp_exp_date,
            p.organ passp_organ,
            p.telw as phone_office,
            p.teld as phone_mobile,
            p.teld as phone_fax,
            null as email,
            null as website,
            null as status_id,
            null as lang_name,
            null as name,
            null as lang_abbreviation,
            null as abbreviation,
            null as ownership,
            null as registr_date,
            null as economic_activity,
            null as emplote_count,
            null as cust_code,
            null as reg_num,
            null as tel_fax,
            null as e_mail,
                    aa.branch,
                  aa.ost_9129 + aa.ost_ovr limit_sum,
                  aa.sysdt accountingDate,
                  (select nvl(max(decode(d.dk, 1, 1, 2)), 3)
                     from opldok d
                    where d.acc = aa.acc_ovr
                      and d.fdat =
                          (select max(fdat)
                             from opldok
                            where acc = d.acc
                          and fdat between :p_date_f and aa.sysdt)) credit_usage,
                  aa.ost_ovr + aa.ost_2207 + aa.ost_2208 + aa.ost_2209 + decode(sign(aa.ost_pk), -1, aa.ost_pk, 0) + aa.ost_3570 + aa.ost_3579 res_sum,
                  aa.ost_2207 + aa.ost_2209 + aa.ost_3579 overdue_sum
                   from (select o.nd,
                                o.acc_pk,
                                a.kv,
                                b.daos,
                                a.branch,
                                add_months(a.daos,
                                           nvl(to_number(w.value),
                                               nvl(p.mm_max, 0))) dat_z,
                                nvl(o.acc_ovr, o.acc_2203) acc_ovr,
                                nvl(sum(decode(ostatki.acc, o.acc_pk, ostatki.ost)), 0) ost_pk,
                                nvl(sum(decode(ostatki.acc, nvl(o.acc_ovr, o.acc_2203), ostatki.ost)), 0) ost_ovr,
                                nvl(sum(decode(ostatki.acc, o.acc_2207, ostatki.ost)), 0) ost_2207,
                                nvl(sum(decode(ostatki.acc, o.acc_2208, ostatki.ost)), 0) ost_2208,
                                nvl(sum(decode(ostatki.acc, o.acc_2209, ostatki.ost)), 0) ost_2209,
                                nvl(sum(decode(ostatki.acc, o.acc_3570, ostatki.ost)), 0) ost_3570,
                                nvl(sum(decode(ostatki.acc, o.acc_3579, ostatki.ost)), 0) ost_3579,
                                nvl(sum(decode(ostatki.acc, o.acc_9129, ostatki.ost)), 0) ost_9129,
 /*
                                fost(o.acc_pk, sd.sysdt) ost_pk,
                                nvl2(nvl(o.acc_ovr, o.acc_2203),fost(nvl(o.acc_ovr, o.acc_2203), sd.sysdt),0) ost_ovr,
                                nvl2(o.acc_2207, fost(o.acc_2207, sd.sysdt), 0) ost_2207,
                                nvl2(o.acc_2208, fost(o.acc_2208, sd.sysdt), 0) ost_2208,
                                nvl2(o.acc_2209, fost(o.acc_2209, sd.sysdt), 0) ost_2209,
                                nvl2(o.acc_3570, fost(o.acc_3570, sd.sysdt), 0) ost_3570,
                                nvl2(o.acc_3579, fost(o.acc_3579, sd.sysdt), 0) ost_3579,
                                nvl2(o.acc_9129,fost(o.acc_9129, sd.sysdt),0) ost_9129,
 */
                                a.rnk,
                                a.dazs,
                                sd.sysdt
                           from w4_acc o join accounts a on o.acc_pk = a.acc
                           join accounts b on o.acc_9129 = b.acc
                           left outer join accountsw w on a.acc = w.acc and w.tag = ''PK_TERM''
                           join w4_card d on o.card_code = d.code
                           join CM_PRODUCT p on d.product_code = p.product_code
                           join (select :p_date as sysdt from dual) sd on 1 = 1
                           left outer join
                            (select a_ost.acc, a_ost.ostc - nvl(sum(s_ost.kos - s_ost.dos), 0) as ost
                               from accounts a_ost left outer join saldoa s_ost on a_ost.acc = s_ost.acc and s_ost.fdat > :p_date
                             group by a_ost.acc, a_ost.ostc) ostatki
                               on ostatki.acc = any(o.acc_pk, o.acc_ovr, o.acc_2203, o.acc_2207, o.acc_2208, o.acc_2209, o.acc_3570, o.acc_3579, o.acc_9129)
   group by  o.nd, o.acc_pk, a.kv, b.daos, a.branch, a.rnk, a.dazs, sd.sysdt,
                                add_months(a.daos, nvl(to_number(w.value), nvl(p.mm_max, 0))), nvl(o.acc_ovr, o.acc_2203)
                            ) aa,
                        customer c,
                        customerw w,
                        person p,
                        kl_k040 cty
                  where aa.rnk = c.rnk
                    and c.custtype = 3
                    and aa.rnk = w.rnk(+)
                    and w.tag(+) = ''CIGPO''
                    and aa.rnk = p.rnk(+)
                    and c.country = cty.k040(+)
                     ) tab,
                        tabval$global t,
     (SELECT rnk as rnk, --
        nvl(fact_terr_id, reg_terr_id) as fact_terr_id, --
        NVL(CASE WHEN fact_type_id = 2 AND fact_terr_id = -1 THEN
                      DECODE(domain2,   NULL, '''', trim(domain2)   || '''', '''') ||
                      DECODE(region2,   NULL, '''', trim(region2)   || '''', '''') ||
                      DECODE(locality2, NULL, '''', trim(locality2) || '''', '''') || trim(address2)
                 WHEN fact_type_id = 2 AND fact_terr_id > 0  THEN
                      address2
                 ELSE NULL   END, --NVL-- ���� ��� ���.���. ������� ����.���.
                      DECODE(domain1,   NULL, '''', trim(domain1)   || '''', '''') ||
                      DECODE(region1,   NULL, '''', trim(region1)   || '''', '''') ||
                      DECODE(locality1, NULL, '''', trim(locality1) || '''', '''') || trim(address1)) as fact_addr, --
        NVL(fact_zip, reg_zip) as fact_zip, --
        reg_terr_id            as reg_terr_id,--
        NVL(CASE WHEN reg_type_id = 1 AND NVL(reg_terr_id, -1) = -1 THEN
                      DECODE(domain1,   NULL, '''', trim(domain1)   || '''', '''') ||
                      DECODE(region1,   NULL, '''', trim(region1)   || '''', '''') ||
                      DECODE(locality1, NULL, '''', trim(locality1) || '''', '''') || trim(address1)
                 WHEN reg_type_id = 1 AND reg_terr_id > 0           THEN
                      address1
                 ELSE NULL END,  --NVL-- ���� ��� ����.���. ������� ���.���.
                      DECODE(domain2,   NULL, '''', trim(domain2)   || '''', '''') ||
                      DECODE(region2,   NULL, '''', trim(region2)   || '''', '''') ||
                      DECODE(locality2, NULL, '''', trim(locality2) || '''', '''') || trim(address2)) as reg_addr, --
        NVL(reg_zip, fact_zip) as reg_zip --
   FROM (SELECT rnk,
                min(DECODE(territory_id, null, -1, territory_id)) as territory_id,
                MAX(DECODE(type_id, 1,   type_id,  NULL)) AS reg_type_id,
                MAX(DECODE(type_id, 2,   type_id,  NULL)) AS fact_type_id,
                MAX(DECODE(type_id, 2,   nvl(territory_id, -1), -1)) AS fact_terr_id,
                MAX(DECODE(type_id, 2,   zip,      NULL)) AS fact_zip,
                MAX(DECODE(type_id, 2,   domain,   NULL)) AS domain2,
                MAX(DECODE(type_id, 2,   region,   NULL)) AS region2,
                MAX(DECODE(type_id, 2,   locality, NULL)) AS locality2,
                MAX(DECODE(type_id, 2,   address,  NULL)) AS address2,
                MAX(DECODE(type_id, 1,   zip,      NULL)) AS reg_zip,
                MAX(DECODE(type_id, 1,   domain,   NULL)) AS domain1,
                MAX(DECODE(type_id, 1,   region,   NULL)) AS region1,
                MAX(DECODE(type_id, 1,   locality, NULL)) AS locality1,
                MAX(DECODE(type_id, 1,   address,  NULL)) AS address1,
                MAX(DECODE(type_id, 1,   nvl(territory_id, -1), -1)) AS reg_terr_id
           FROM bars.customer_address
          WHERE 1=1 -- rnk IN (16784021, 37853721, 95127921, 95497721, 151213521, 277793721)
            AND type_id < 3
          GROUP BY rnk)) c2
                        where tab.kv = t.kv and tab.rnk = c2.rnk(+)' -- and 1 = nvl((select cds.is_sync from cig_dog_sync_params cds where cds.nd = tab.nd and cds.data_type = 3),1)
         using l_pdatef, l_pdate, l_pdate, l_pdatef, l_pdate, l_pdate;
     elsif (p_dtype = G_CONTRACT_OVR) then
       OPEN p_recordset FOR 'select    tab.nd,
                tab.rnk,
                tab.datd as start_date,
                tab.datd2 as end_date,
                tab.datd as bdate,
                tab.dazs,
                t.lcv as currency,
                tab.kv as currency_id,
                tab.cig_13,
                null as cig_14,
                4 as cig_15,
                tab.cig_16,
                tab.cig_17,
                tab.period as cig_18,
                tab.cig_19,
                tab.cig_20,
                tab.custtype,
                tab.contract_type,' || 'tab.branch,' || 'tab.limit_sum,
                tab.credit_usage,
                tab.res_sum,
                tab.overdue_sum,
                tab.accountingDate,
                c2.fact_terr_id,
                c2.fact_addr,
                c2.fact_zip,
                c2.reg_terr_id,
                c2.reg_addr,
                c2.reg_zip,
                tab.role_id,
                tab.firstname,
                tab.surname,
                tab.fathers_name,
                tab.gender,
                tab.classification,
                tab.birth_surname,
                tab.date_birth,
                tab.place_birth,
                tab.residency,
                tab.citizenship,
                tab.neg_status,
                tab.education,
                tab.marital_status,
                decode(tab.position,''0'',''0'',''1'',''1'',''2'',''2'',''3'',''3'',''4'',''4'',''5'',''5'',''6'',''6'',''7'',''7'',''8'',''8'',''9'',''9'',null) as position,
                tab.okpo,
                tab.cust_key,
                tab.ser,
                tab.numdoc,
                tab.passp_iss_date,
                tab.passp_exp_date,
                tab.passp_organ,
                tab.phone_office,
                tab.phone_mobile,
                tab.phone_fax,
                tab.email,
                tab.website,
                tab.status_id,
                tab.lang_name,
                tab.name,
                tab.lang_abbreviation,
                tab.abbreviation,
                tab.ownership,
                tab.registr_date,
                tab.economic_activity,
                tab.emplote_count,
                tab.cust_code,
                tab.reg_num,
                tab.tel_fax,
                tab.e_mail,
                null as a8_acc,
                null as a8_kv,' || 'tab.branch as branch_dog' || ' from (select           aa.nd,
                  aa.datd,
                  aa.datd2,
                  aa.kv,
                  aa.rnk,
                  null as bdate,
                  null as cig_13,
                  null as cig_16,
                  null as cig_17,
                  null as credit_period,
                  aa.method as cig_19,
                  null as cig_20,
                  aa.dazs,
                  c.custtype,
                  4 as contract_type,
            1 as role_id,
            null as firstname,
            null as surname,
            null as fathers_name,
            null as gender,
            null as classification,
            null as birth_surname,
            null as date_birth,
            null as place_birth,
            null as residency,
            null as citizenship,
            null as neg_status,
            null as education,
            null as marital_status,
            null as position,
            null as okpo,
            null as cust_key,
            null as ser,
            null as numdoc,
            null as passp_iss_date,
            null as passp_exp_date,
            null as passp_organ,
            c1.telr as phone_office,
            null as phone_mobile,
            null as phone_fax,
            null as email,
            null as website,
            1 status_id,
            ''uk-UA'' lang_name,
            c.nmk name,
            ''uk-UA'' lang_abbreviation,
            c.nmkk abbreviation,
            case
              when c.sed in (''00'', ''91'', ''34'') then
               0
              when c.sed in (''08'',
                             ''09'',
                             ''10'',
                             ''11'',
                             ''12'',
                             ''13'',
                             ''14'',
                             ''15'',
                             ''16'',
                             ''17'',
                             ''19'',
                             ''33'',
                             ''20'') then
               1
              when c.sed in (''23'', ''24'', ''25'', ''26'', ''27'') then
               2
              when c.sed in (''61'', ''62'', ''63'', ''64'', ''65'', ''66'', ''18'') then
               3
              when c.sed in (''40'', ''41'', ''42'', ''43'', ''44'') then
               4
              when c.sed in (''70'', ''28'', ''29'', ''30'', ''31'', ''32'') then
               5
              when c.sed in (''80'', ''50'', ''51'', ''52'') then
               6
              when c.sed in (''45'',
                             ''46'',
                             ''47'',
                             ''48'',
                             ''49'',
                             ''53'',
                             ''54'',
                             ''55'',
                             ''56'',
                             ''57'') then
               8
              else
               9
            --when c.sed in (''92'',''93'',''94'',''95'',''96'',''97'',''21'',''22'') then 9
            end as ownership,
            c.datea registr_date,
            null economic_activity,
            DECODE(DECODE(TRANSLATE(TRANSLATE(trim(f_get_custw_h(c.rnk,
                                                                 ''FSKPR'',
                                                                 trunc(sysdate))),
                                              ''_'',
                                              ''-''),
                                    ''0123456789'',
                                    ''__________''),
                          ''_'',
                          1,
                          ''__'',
                          1,
                          ''___'',
                          1,
                          ''____'',
                          1,
                          ''_____'',
                          1,
                          ''______'',
                          1,
                          ''_______'',
                          1,
                          ''________'',
                          1,
                          ''_________'',
                          1,
                          0),
                   1,
                   case
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 1 and 5 then
                      1
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 6 and 30 then
                      2
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 31 and 100 then
                      3
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) between 101 and 500 then
                      4
                     when to_number(trim(f_get_custw_h(c.rnk,
                                                       ''FSKPR'',
                                                       trunc(sysdate)))) > 500 then
                      5
                   end,
                   NULL) emplote_count,
            c.okpo cust_code,
            null reg_num,
            c1.tel_fax,
            c1.e_mail,
                  aa.branch,
                  aa.limit_sum,
                  aa.sdt as accountingDate,
                  aa.credit_usage,
                  aa.res_sum,
                  aa.overdue_sum,
                  aa.period
   from (select 1 as method,
                10 as period,
                case
                  when a.ost_2067 != 0 then
                   a.sd
                  else
                   a.lim
                end as limit_sum,
                sdt,
                (select nvl(max(decode(d.dk, 1, 1, 2)), 3)
                   from opldok d
                  where d.acc = a.acc
                    and d.fdat =
                        (select max(fdat)
                           from opldok
                          where acc = d.acc
                            and fdat between :p_date_f and sdt)) credit_usage,
                decode(sign(a.ost_2067),-1, a.ost_2067, 0) + a.ost_2607 + a.ost_2069 +
                +decode(sign(a.ost_acc), -1, a.ost_acc, 0) + a.ost_3578 +
                a.ost_3579 as res_sum,
                decode(sign(a.ost_2067),-1, a.ost_2067, 0) + a.ost_2069 + a.ost_3579 as overdue_sum,
                a.nd,
                a.datd,
                a.datd2,
                a.branch,
                a.rnk,
                a.kv,
                a.dazs
           from (select nvl2(aa.acc2, fost(aa.acc2, sdt), 0) as ost_3579,
                        nvl2(aa.acra3, fost(aa.acra3, sdt), 0) ost_3578,
                        nvl2(aa.acra1, fost(aa.acra1, sdt), 0) ost_2607,
                        nvl2(aa.acra2, fost(aa.acra2, sdt), 0) ost_2069,
                        aa.acc2 as acc2,
                        aa.*
                   from (select a.rnk,
                                a.lim,
                                o.deldate as dazs,
                                a.kv,
                                t.sdt,
                                a.branch,
                                o.nd,
                                o.datd,
                                o.datd2,
                                o.acc,
                                o.sd,
                                n3.acra acra3,
                                n.acra acra1,
                                n2.acra acra2,
                                nvl2(o.acc_9129, fost(o.acc_9129, t.sdt), 0) ost_9129,
                                nvl2(o.acc_2067, fost(o.acc_2067, t.sdt), 0) ost_2067,
                                nvl2(o.acc, fost(o.acc, t.sdt), 0) ost_acc,
                          (select a2.acc
                          from nd_acc na, accounts a2
                           where na.nd = o.nd
                                 and na.acc = a2.acc
                                 and a2.NBS = ''3579''
                                 and a2.dazs is null) as acc2
   from (
 select     d.nd,
        max(d.sos),
        max(d.sdate) as datd,
        max(d.wdate) as datd2,
        max(case when a.nbs = ''2600'' then a.acc else null end) as acc, --   acc_2600,
        max(d.limit) as sd,
        max(case when a.nbs = ''9129'' then a.acc else null end) as acc_9129,
        max(case when a.nbs = ''2607'' then a.acc else null end) as acc_2067,
        max(case when a.nbs = ''8000'' then a.acc else null end) as acc_8000,
        max(null) as deldate
   from bars.cc_deal  d,
        bars.nd_acc   n,
        bars.accounts a
    where d.nd = n.nd
      and a.acc = n.acc
      AND d.vidd in (10)
    group by d.nd       ) o,--end_acc_over
 (SELECT     nd,
         MAX(cig_13) cig_13,
         MAX(cig_20) cig_20
      FROM (SELECT nd,
                   DECODE(tag, ''CIG_D13'', VALUE) cig_13,
                   DECODE(tag, ''CIG_D20'', VALUE) cig_20
             FROM mos_operw
                  WHERE tag IN (''CIG_D13'', ''CIG_D20''))
                      GROUP BY nd) ow,  ------------------
        accounts a,
        int_accn n,
        int_accn n2,
        int_accn n3,
        (select :p_date as sdt from dual) t
   where a.acc = o.acc
    and n.id(+) = 0
    and n2.id(+) = 0
    and n3.id(+) = 0
    and n2.acc(+) = o.acc_2067
    and n.acc(+) = o.acc
    and n3.acc(+) = o.acc_8000
    --
     AND o.nd = ow.nd
     and ow.cig_13 > 0) aa
    ) a
          ) aa,
        customer c,
        corps c1
  where aa.rnk = c.rnk
    and c.custtype = 2
    and aa.rnk = c1.rnk(+)
 union all
 select           aa.nd,
                  aa.datd,
                  aa.datd2,
                  aa.kv,
                  aa.rnk,
                  null as bdate,
                  null as cig_13,
                  null as cig_16,
                  null as cig_17,
                  null as credit_period,
                  aa.method as cig_19,
                  null as cig_20,
                  aa.dazs,
                  c.custtype,
                  4 as contract_type,
            1 as role_id,
            fio(c.nmk, 2) as firstname,
            fio(c.nmk, 1) as surname,
            fio(c.nmk, 3) as fathers_name,
            decode(to_number(p.sex),1,1,2,2,null) as gender,
            case
              when to_number(nvl(c.sed, 0)) = 91 then
               2
              else
               1
            end as classification,
            to_char(null) birth_surname,
            p.bday as date_birth,
            p.bplace place_birth,
            case
              when c.codcagent = 5 then
               1
              else
               2
            end as residency,
            case when cty.k040 = ''011'' then ''UA'' else cty.a2 end as citizenship,
            null as neg_status,
            null as education,
            null as marital_status,
            decode(w.value,''0'',''0'',''1'',''1'',''2'',''2'',''3'',''3'',''4'',''4'',''5'',''5'',''6'',''6'',''7'',''7'',''8'',''8'',''9'') as position,
            c.okpo,
            fio(c.nmk, 2) || fio(c.nmk, 1) || to_char(p.bday, ''ddmmyyyy'') as cust_key,
  case when  p.passp = 7 then nvl(p.ser,0) else p.ser end ser,
            p.numdoc,
            p.pdate as passp_iss_date,
            null as passp_exp_date,
            p.organ passp_organ,
            p.telw as phone_office,
            p.teld as phone_mobile,
            p.teld as phone_fax,
            null as email,
            null as website,
            null as status_id,
            null as lang_name,
            null as name,
            null as lang_abbreviation,
            null as abbreviation,
            null as ownership,
            null as registr_date,
            null as economic_activity,
            null as emplote_count,
            null as cust_code,
            null as reg_num,
            null as tel_fax,
            null as e_mail,
                    aa.branch,
                  aa.limit_sum,
                  aa.sdt as accountingDate,
                  aa.credit_usage,
                  aa.res_sum,
                  aa.overdue_sum,
                  aa.period
   from (select 1 as method,
                10 as period,
                case
                  when a.ost_2067 != 0 then
                   a.sd
                  else
                   a.lim
                end as limit_sum,
                sdt,
                (select nvl(max(decode(d.dk, 1, 1, 2)), 3)
                   from opldok d
                  where d.acc = a.acc
                    and d.fdat =
                        (select max(fdat)
                           from opldok
                          where acc = d.acc
                            and fdat between :p_date_f and sdt)) credit_usage,
                decode(sign(a.ost_2067),-1, a.ost_2067, 0) + a.ost_2607 + a.ost_2069 +
                + decode(sign(a.ost_acc), -1, a.ost_acc, 0) + a.ost_3578 +
                a.ost_3579 as res_sum,
                decode(sign(a.ost_2067),-1, a.ost_2067, 0) + a.ost_2069 + a.ost_3579 as overdue_sum,
                a.nd,
                a.datd,
                a.datd2,
                a.branch,
                a.rnk,
                a.kv,
                a.dazs
           from (select nvl2(aa.acc2, fost(aa.acc2, sdt), 0) as ost_3579,
                        nvl2(aa.acra3, fost(aa.acra3, sdt), 0) ost_3578,
                        nvl2(aa.acra1, fost(aa.acra1, sdt), 0) ost_2607,
                        nvl2(aa.acra2, fost(aa.acra2, sdt), 0) ost_2069,
                        aa.acc2 as acc2,
                        aa.*
                   from (select a.rnk,
                                a.lim,
                                o.deldate as dazs,
                                a.kv,
                                t.sdt,
                                a.branch,
                                o.nd,
                                o.datd,
                                o.datd2,
                                o.acc,
                                o.sd,
                                n3.acra acra3,
                                n.acra acra1,
                                n2.acra acra2,
                                nvl2(o.acc_9129, fost(o.acc_9129, t.sdt), 0) ost_9129,
                                nvl2(o.acc_2067, fost(o.acc_2067, t.sdt), 0) ost_2067,
                                nvl2(o.acc, fost(o.acc, t.sdt), 0) ost_acc,
                          (select a2.acc
                          from nd_acc na, accounts a2
                           where na.nd = o.nd
                                 and na.acc = a2.acc
                                 and a2.NBS = ''3579''
                                 and a2.dazs is null) as acc2
 from (
 select     d.nd,
        max(d.sos),
        max(d.sdate) as datd,
        max(d.wdate) as datd2,
        max(case when a.nbs = ''2600'' then a.acc else null end) as acc, --   acc_2600,
        max(d.limit) as sd,
        max(case when a.nbs = ''9129'' then a.acc else null end) as acc_9129,
        max(case when a.nbs = ''2607'' then a.acc else null end) as acc_2067,
        max(case when a.nbs = ''8000'' then a.acc else null end) as acc_8000,
        max(null) as deldate
   from bars.cc_deal  d,
        bars.nd_acc   n,
        bars.accounts a
    where d.nd = n.nd
      and a.acc = n.acc
      AND d.vidd in (10)
    group by d.nd
  ) o, --end_acc_over
 (SELECT     nd,
         MAX(cig_13) cig_13,
         MAX(cig_20) cig_20
      FROM (SELECT nd,
                   DECODE(tag, ''CIG_D13'', VALUE) cig_13,
                   DECODE(tag, ''CIG_D20'', VALUE) cig_20
             FROM mos_operw
                  WHERE tag IN (''CIG_D13'', ''CIG_D20''))
                      GROUP BY nd) ow,  ------------------
        accounts a,
        int_accn n,
        int_accn n2,
        int_accn n3,
        (select :p_date as sdt from dual) t
   where a.acc = o.acc
    and n.id(+) = 0
    and n2.id(+) = 0
    and n3.id(+) = 0
    and n2.acc(+) = o.acc_2067
    and n.acc(+) = o.acc
    and n3.acc(+) = o.acc_8000
     --cig
     AND o.nd = ow.nd
     and ow.cig_13 > 0
    ) aa ) a
          ) aa,
        customer c,
        customerw w,
        person p,
        kl_k040 cty
  where aa.rnk = c.rnk
    and c.custtype = 3
    and aa.rnk = w.rnk(+)
    and w.tag(+) = ''CIGPO''
    and aa.rnk = p.rnk(+)
    and c.country = cty.k040(+)
    and to_number(nvl(c.sed, 0)) = 91
 ) tab,
                    tabval$global t,
 (SELECT rnk as rnk, --
        nvl(fact_terr_id, reg_terr_id) as fact_terr_id, --
        NVL(CASE WHEN fact_type_id = 2 AND fact_terr_id = -1 THEN
                      DECODE(domain2,   NULL, '''', trim(domain2)   || '''', '''') ||
                      DECODE(region2,   NULL, '''', trim(region2)   || '''', '''') ||
                      DECODE(locality2, NULL, '''', trim(locality2) || '''', '''') || trim(address2)
                 WHEN fact_type_id = 2 AND fact_terr_id > 0  THEN
                      address2
                 ELSE NULL   END, --NVL-- ���� ��� ���.���. ������� ����.���.
                      DECODE(domain1,   NULL, '''', trim(domain1)   || '''', '''') ||
                      DECODE(region1,   NULL, '''', trim(region1)   || '''', '''') ||
                      DECODE(locality1, NULL, '''', trim(locality1) || '''', '''') || trim(address1)) as fact_addr, --
        NVL(fact_zip, reg_zip) as fact_zip, --
        reg_terr_id            as reg_terr_id,--
        NVL(CASE WHEN reg_type_id = 1 AND NVL(reg_terr_id, -1) = -1 THEN
                      DECODE(domain1,   NULL, '''', trim(domain1)   || '''', '''') ||
                      DECODE(region1,   NULL, '''', trim(region1)   || '''', '''') ||
                      DECODE(locality1, NULL, '''', trim(locality1) || '''', '''') || trim(address1)
                 WHEN reg_type_id = 1 AND reg_terr_id > 0           THEN
                      address1
                 ELSE NULL END,  --NVL-- ���� ��� ����.���. ������� ���.���.
                      DECODE(domain2,   NULL, '''', trim(domain2)   || '''', '''') ||
                      DECODE(region2,   NULL, '''', trim(region2)   || '''', '''') ||
                      DECODE(locality2, NULL, '''', trim(locality2) || '''', '''') || trim(address2)) as reg_addr, --
        NVL(reg_zip, fact_zip) as reg_zip --
   FROM (SELECT rnk,
                min(DECODE(territory_id, null, -1, territory_id)) as territory_id,
                MAX(DECODE(type_id, 1,   type_id,  NULL)) AS reg_type_id,
                MAX(DECODE(type_id, 2,   type_id,  NULL)) AS fact_type_id,
                MAX(DECODE(type_id, 2,   nvl(territory_id, -1), -1)) AS fact_terr_id,
                MAX(DECODE(type_id, 2,   zip,      NULL)) AS fact_zip,
                MAX(DECODE(type_id, 2,   domain,   NULL)) AS domain2,
                MAX(DECODE(type_id, 2,   region,   NULL)) AS region2,
                MAX(DECODE(type_id, 2,   locality, NULL)) AS locality2,
                MAX(DECODE(type_id, 2,   address,  NULL)) AS address2,
                MAX(DECODE(type_id, 1,   zip,      NULL)) AS reg_zip,
                MAX(DECODE(type_id, 1,   domain,   NULL)) AS domain1,
                MAX(DECODE(type_id, 1,   region,   NULL)) AS region1,
                MAX(DECODE(type_id, 1,   locality, NULL)) AS locality1,
                MAX(DECODE(type_id, 1,   address,  NULL)) AS address1,
                MAX(DECODE(type_id, 1,   nvl(territory_id, -1), -1)) AS reg_terr_id
           FROM bars.customer_address
          WHERE 1=1 -- rnk IN (16784021, 37853721, 95127921, 95497721, 151213521, 277793721)
            AND type_id < 3
          GROUP BY rnk) ) c2
                        where tab.kv = t.kv and tab.rnk = c2.rnk(+)'--    and 1 = nvl((select cds.is_sync from cig_dog_sync_params cds where cds.nd = tab.nd and cds.data_type = 4),1)
         using l_pdatef, l_pdate, l_pdatef, l_pdate;
     elsif (p_dtype = G_CONTRACT_GRNT) then
       OPEN p_recordset FOR
         select q.nd,
                q.rnk,
                q.start_date,
                q.end_date,
                q.bdate,
                q.dazs,
                q.currency,
                q.currency_id,
                q.cig_13,
                case
                  when substr(q.prod, 1, 4) = '9122' then
                   13
                  else
                   11
                end as cig_14,
                case
                  when ((q.dazs is not null) and
                       (trunc(q.end_date) > trunc(q.dazs))) then
                   6
                  when ((q.dazs is not null) and
                       (trunc(q.end_date) <= trunc(q.dazs))) then
                   5
                  else
                   4
                end as cig_15,
                q.cig_16,
                q.cig_17,
                9 as cig_18,
                q.cig_19,
                q.cig_20,
                q.custtype,
                q.contract_type,
                q.branch,
                abs(nvl(q.ostc, 0)) as limit_sum,
                null as credit_usage,
                0 as res_sum,
                null as overdue_sum,
                null as accountingDate,
                c2.fact_terr_id,
                c2.fact_addr,
                c2.fact_zip,
                c2.reg_terr_id,
                c2.reg_addr,
                c2.reg_zip,
                q.role_id,
                q.firstname,
                q.surname,
                q.fathers_name,
                q.gender,
                q.classification,
                q.birth_surname,
                q.date_birth,
                q.place_birth,
                q.residency,
                q.citizenship,
                q.neg_status,
                q.education,
                q.marital_status,
                decode(q.position,
                       '0',
                       '0',
                       '1',
                       '1',
                       '2',
                       '2',
                       '3',
                       '3',
                       '4',
                       '4',
                       '5',
                       '5',
                       '6',
                       '6',
                       '7',
                       '7',
                       '8',
                       '8',
                       '9',
                       '9',
                       null) as position,
                q.okpo,
                q.cust_key,
                q.ser,
                q.numdoc,
                q.passp_iss_date,
                q.passp_exp_date,
                q.passp_organ,
                q.phone_office,
                q.phone_mobile,
                q.phone_fax,
                q.email,
                q.website,
                q.status_id,
                q.lang_name,
                q.name,
                q.lang_abbreviation,
                q.abbreviation,
                q.ownership,
                q.registr_date,
                q.economic_activity,
                q.emplote_count,
                q.cust_code,
                q.reg_num,
                q.tel_fax,
                q.e_mail,
                q.a8_acc,
                q.a8_kv,
                q.branch_dog
           from (select cd.nd,
                        cd.sdate as start_date,
                        cd.wdate as end_date,
                        val.kv as currency_id,
                        val.lcv as currency,
                        cd.rnk,
                        cda.bdate as bdate,
                        ow.cig_13,
                        null as cig_16,
                        null as cig_17,
                        cda.freq as credit_period,
                        1 as cig_19,
                        ow.cig_20,
                        a8.dazs as dazs,
                        c.custtype,
                        5 as contract_type,
                        1 as role_id,
                        null as firstname,
                        null as surname,
                        null as fathers_name,
                        null as gender,
                        null as classification,
                        null as birth_surname,
                        null as date_birth,
                        null as place_birth,
                        null as residency,
                        null as citizenship,
                        null as neg_status,
                        null as education,
                        null as marital_status,
                        null as position,
                        null as okpo,
                        null as cust_key,
                        null as ser,
                        null as numdoc,
                        null as passp_iss_date,
                        null as passp_exp_date,
                        null as passp_organ,
                        c1.telr as phone_office,
                        null as phone_mobile,
                        null as phone_fax,
                        null as email,
                        null as website,
                        1 status_id,
                        'uk-UA' lang_name,
                        c.nmk name,
                        'uk-UA' lang_abbreviation,
                        c.nmkk abbreviation,
                        case
                          when c.sed in ('00', '91', '34') then
                           0
                          when c.sed in ('08',
                                         '09',
                                         '10',
                                         '11',
                                         '12',
                                         '13',
                                         '14',
                                         '15',
                                         '16',
                                         '17',
                                         '19',
                                         '33',
                                         '20') then
                           1
                          when c.sed in ('23', '24', '25', '26', '27') then
                           2
                          when c.sed in
                               ('61', '62', '63', '64', '65', '66', '18') then
                           3
                          when c.sed in ('40', '41', '42', '43', '44') then
                           4
                          when c.sed in ('70', '28', '29', '30', '31', '32') then
                           5
                          when c.sed in ('80', '50', '51', '52') then
                           6
                          when c.sed in ('45',
                                         '46',
                                         '47',
                                         '48',
                                         '49',
                                         '53',
                                         '54',
                                         '55',
                                         '56',
                                         '57') then
                           8
                          else
                           9
                        --when c.sed in ('92','93','94','95','96','97','21','22') then 9
                        end as ownership,
                        c.datea registr_date,
                        null economic_activity,
                        DECODE(DECODE(TRANSLATE(TRANSLATE(trim(f_get_custw_h(c.rnk,
                                                                             'FSKPR',
                                                                             trunc(sysdate))),
                                                          '_',
                                                          '-'),
                                                '0123456789',
                                                '__________'),
                                      '_',
                                      1,
                                      '__',
                                      1,
                                      '___',
                                      1,
                                      '____',
                                      1,
                                      '_____',
                                      1,
                                      '______',
                                      1,
                                      '_______',
                                      1,
                                      '________',
                                      1,
                                      '_________',
                                      1,
                                      0),
                               1,
                               case
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 1 and 5 then
                                  1
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 6 and 30 then
                                  2
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 31 and 100 then
                                  3
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) between 101 and 500 then
                                  4
                                 when to_number(trim(f_get_custw_h(c.rnk,
                                                                   'FSKPR',
                                                                   trunc(sysdate)))) > 500 then
                                  5
                               end,
                               NULL) emplote_count,
                        c.okpo cust_code,
                        null reg_num,
                        c1.tel_fax,
                        c1.e_mail,
                        a8.acc as a8_acc,
                        a8.kv as a8_kv,
                        c.branch,
                        cd.branch as branch_dog,
                        a8.ostc,
                        cd.prod
                   from cc_deal cd,
                        cc_add cda,
                        customer c,
                        (select nd,
                                max(cig_13) as cig_13,
                                max(cig_20) as cig_20
                           from (select nd,
                                        decode(tag, 'CIG_D13', value) as cig_13,
                                        decode(tag, 'CIG_D20', value) as cig_20
                                   from mos_operw
                                  where tag in ('CIG_D13', 'CIG_D20'))
                          group by nd) ow,
                        tabval val,
                        corps c1,
                        nd_acc n,
                        accounts a8
                  where cd.nd = cda.nd
                    and cd.rnk = c.rnk
                    and cd.nd = ow.nd
                    and cda.kv = val.kv
                    and c.custtype in (1, 2)
                    and ow.cig_13 > 0
                    and cd.rnk = c1.rnk(+)
                    and cd.vidd in (1, 2, 3)
                    and substr(cd.prod, 1, 1) = '9'
                    and cd.sos >= 10
                    and cd.nd = n.nd
                    and n.acc = a8.acc
                    and a8.tip = 'LIM'
                 /*and a8.dazs is null
                 and a8.ostc<0*/
                 --and not exists (select nd from cig_dog_general where nd = cd.nd)
                 UNION ALL
                 select cd.nd,
                        cd.sdate as start_date,
                        cd.wdate as end_date,
                        val.kv as currency_id,
                        val.lcv as currency,
                        cd.rnk,
                        cda.bdate as bdate,
                        ow.cig_13,
                        null as cig_16,
                        null as cig_17,
                        cda.freq as credit_period,
                        1 as cig_19,
                        ow.cig_20,
                        a8.dazs as dazs,
                        c.custtype,
                        5 as contract_type,
                        1 as role_id,
                        fio(c.nmk, 2) as firstname,
                        fio(c.nmk, 1) as surname,
                        fio(c.nmk, 3) as fathers_name,
                        decode(to_number(p.sex), 1, 1, 2, 2, null) as gender,
                        case
                          when to_number(nvl(c.sed, 0)) = 91 then
                           2
                          else
                           1
                        end as classification,
                        to_char(null) birth_surname,
                        p.bday as date_birth,
                        p.bplace place_birth,
                        case
                          when c.codcagent = 5 then
                           1
                          else
                           2
                        end as residency,
                        case
                          when cty.k040 = '011' then
                           'UA'
                          else
                           cty.a2
                        end as citizenship,
                        null as neg_status,
                        null as education,
                        null as marital_status,
                        decode(w.value,
                               '0',
                               '0',
                               '1',
                               '1',
                               '2',
                               '2',
                               '3',
                               '3',
                               '4',
                               '4',
                               '5',
                               '5',
                               '6',
                               '6',
                               '7',
                               '7',
                               '8',
                               '8',
                               '9',
                               '9',
                               null) as position,
                        c.okpo,
                        fio(c.nmk, 2) || fio(c.nmk, 1) ||
                        to_char(p.bday, 'ddmmyyyy') as cust_key,
    case when  p.passp = 7 then nvl(p.ser,0) else p.ser end ser,
                        p.numdoc,
                        p.pdate as passp_iss_date,
                        null as passp_exp_date,
                        p.organ passp_organ,
                        p.telw as phone_office,
                        p.teld as phone_mobile,
                        p.teld as phone_fax,
                        null as email,
                        null as website,
                        null as status_id,
                        null as lang_name,
                        null as name,
                        null as lang_abbreviation,
                        null as abbreviation,
                        null as ownership,
                        null as registr_date,
                        null as economic_activity,
                        null as emplote_count,
                        null as cust_code,
                        null as reg_num,
                        null as tel_fax,
                        null as e_mail,
                        a8.acc as a8_acc,
                        a8.kv as a8_kv,
                        c.branch,
                        cd.branch as branch_dog,
                        a8.ostc,
                        cd.prod
                   from cc_deal cd,
                        cc_add cda,
                        customer c,
                        (select nd,
                                max(cig_13) as cig_13,
                                max(cig_20) as cig_20
                           from (select nd,
                                        decode(tag, 'CIG_D13', value) as cig_13,
                                        decode(tag, 'CIG_D20', value) as cig_20
                                   from mos_operw
                                  where tag in ('CIG_D13', 'CIG_D20'))
                          group by nd) ow,
                        tabval val,
                        customerw w,
                        person p,
                        kl_k040 cty,
                        nd_acc n,
                        accounts a8
                  where cd.nd = cda.nd
                    and cd.rnk = c.rnk
                    and cd.nd = ow.nd
                    and cda.kv = val.kv
                    and c.custtype = 3
                    and ow.cig_13 > 0
                    and cd.rnk = w.rnk(+)
                    and cd.vidd in (1, 2, 3)
                    and substr(cd.prod, 1, 1) = '9'
                    and cd.sos >= 10
                    and w.tag(+) = 'CIGPO'
                    and cd.rnk = p.rnk(+)
                    and c.country = cty.k040(+)
                    and cd.nd = n.nd
                    and n.acc = a8.acc
                    and a8.tip = 'LIM'
                 /*and a8.dazs is null
                 and a8.ostc<0*/
                 --and not exists (select nd from cig_dog_general where nd = cd.nd)
                 ) q,
 (SELECT rnk as rnk, --
        nvl(fact_terr_id, reg_terr_id) as fact_terr_id, --
        NVL(CASE WHEN fact_type_id = 2 AND fact_terr_id = -1 THEN
                      DECODE(domain2,   NULL, '', trim(domain2)   || '', '') ||
                      DECODE(region2,   NULL, '', trim(region2)   || '', '') ||
                      DECODE(locality2, NULL, '', trim(locality2) || '', '') || trim(address2)
                 WHEN fact_type_id = 2 AND fact_terr_id > 0  THEN
                      address2
                 ELSE NULL   END, --NVL-- ���� ��� ���.���. ������� ����.���.
                      DECODE(domain1,   NULL, '', trim(domain1)   || '', '') ||
                      DECODE(region1,   NULL, '', trim(region1)   || '', '') ||
                      DECODE(locality1, NULL, '', trim(locality1) || '', '') || trim(address1)) as fact_addr, --
        NVL(fact_zip, reg_zip) as fact_zip, --
        reg_terr_id            as reg_terr_id,--
        NVL(CASE WHEN reg_type_id = 1 AND NVL(reg_terr_id, -1) = -1 THEN
                      DECODE(domain1,   NULL, '', trim(domain1)   || '', '') ||
                      DECODE(region1,   NULL, '', trim(region1)   || '', '') ||
                      DECODE(locality1, NULL, '', trim(locality1) || '', '') || trim(address1)
                 WHEN reg_type_id = 1 AND reg_terr_id > 0           THEN
                      address1
                 ELSE NULL END,  --NVL-- ���� ��� ����.���. ������� ���.���.
                      DECODE(domain2,   NULL, '', trim(domain2)   || '', '') ||
                      DECODE(region2,   NULL, '', trim(region2)   || '', '') ||
                      DECODE(locality2, NULL, '', trim(locality2) || '', '') || trim(address2)) as reg_addr, --
        NVL(reg_zip, fact_zip) as reg_zip --
   FROM (SELECT rnk,
                min(DECODE(territory_id, null, -1, territory_id)) as territory_id,
                MAX(DECODE(type_id, 1,   type_id,  NULL)) AS reg_type_id,
                MAX(DECODE(type_id, 2,   type_id,  NULL)) AS fact_type_id,
                MAX(DECODE(type_id, 2,   nvl(territory_id, -1), -1)) AS fact_terr_id,
                MAX(DECODE(type_id, 2,   zip,      NULL)) AS fact_zip,
                MAX(DECODE(type_id, 2,   domain,   NULL)) AS domain2,
                MAX(DECODE(type_id, 2,   region,   NULL)) AS region2,
                MAX(DECODE(type_id, 2,   locality, NULL)) AS locality2,
                MAX(DECODE(type_id, 2,   address,  NULL)) AS address2,
                MAX(DECODE(type_id, 1,   zip,      NULL)) AS reg_zip,
                MAX(DECODE(type_id, 1,   domain,   NULL)) AS domain1,
                MAX(DECODE(type_id, 1,   region,   NULL)) AS region1,
                MAX(DECODE(type_id, 1,   locality, NULL)) AS locality1,
                MAX(DECODE(type_id, 1,   address,  NULL)) AS address1,
                MAX(DECODE(type_id, 1,   nvl(territory_id, -1), -1)) AS reg_terr_id
           FROM bars.customer_address
          WHERE 1=1 -- rnk IN (16784021, 37853721, 95127921, 95497721, 151213521, 277793721)
            AND type_id < 3
          GROUP BY rnk) ) c2
          where q.rnk = c2.rnk(+);
     elsif (p_dtype = 6) then
       OPEN p_recordset FOR 'select q.nd,
        q.rnk,
        q.start_date,
        q.end_date,
        q.bdate,
        q.dazs,
        q.currency,
        q.currency_id,
        q.cig_13,
        null as cig_14,
        case
          when ((q.dazs is not null) and (trunc(q.end_date) > trunc(q.dazs))) then
           6
          when ((q.dazs is not null) and (trunc(q.end_date) <= trunc(q.dazs))) then
           5
          else
           4
        end as cig_15,
        q.cig_16,
        q.cig_17,
        9 as cig_18,
        q.cig_19,
        q.cig_20,
        q.custtype,
        q.contract_type,
        q.branch,
        nvl(q.limit*100,0) as limit_sum,
        null as credit_usage,
        q.res_sum as res_sum,
        null as overdue_sum,
        null as accountingDate,
        nvl(c2.fact_terr_id,-1) as fact_terr_id,
        nvl(c2.fact_addr,q.adr) as fact_addr,
        c2.fact_zip,
        nvl(c2.reg_terr_id,-1) as reg_terr_id,
        nvl(c2.reg_addr,q.adr) as reg_addr,
        c2.reg_zip,
        q.role_id,
        q.firstname,
        q.surname,
        q.fathers_name,
        q.gender,
        q.classification,
        q.birth_surname,
        q.date_birth,
        q.place_birth,
        q.residency,
        q.citizenship,
        q.neg_status,
        q.education,
        q.marital_status,
        decode(q.position,
               ''0'',
               ''0'',
               ''1'',
               ''1'',
               ''2'',
               ''2'',
               ''3'',
               ''3'',
               ''4'',
               ''4'',
               ''5'',
               ''5'',
               ''6'',
               ''6'',
               ''7'',
               ''7'',
               ''8'',
               ''8'',
               ''9'',
               ''9'',
               null) as position,
        q.okpo,
        q.cust_key,
        q.ser,
        q.numdoc,
        q.passp_iss_date,
        q.passp_exp_date,
        q.passp_organ,
        q.phone_office,
        q.phone_mobile,
        q.phone_fax,
        q.email,
        q.website,
        q.status_id,
        q.lang_name,
        q.name,
        q.lang_abbreviation,
        q.abbreviation,
        q.ownership,
        q.registr_date,
        q.economic_activity,
        q.emplote_count,
        q.cust_code,
        q.reg_num,
        q.tel_fax,
        q.e_mail,
        q.a8_acc,
        q.a8_kv,
        q.branch_dog
   from (select cd.nd,
                cd.sdate as start_date,
                cd.wdate as end_date,
                val.kv as currency_id,
                val.lcv as currency,
                cd.rnk,
                cda.bdate as bdate,
                null as cig_13,
                null as cig_16,
                null as cig_17,
                cda.freq as credit_period,
                1 as cig_19,
                ow.cig_20,
                decode (cd.sos, 15, cd.wdate, null) as dazs,
                c.custtype,
                coalesce((case
                           when a1.nbs in (''1523'', ''1524'', ''1527'') then
                            null
                           else
                            6
                         end),
                         (select decode(count(*), 0, 6, 7)
                            from nd_acc n1, accounts a2
                           where cd.nd = n1.nd
                             and n1.acc = a2.acc
                             and a2.nbs = ''9100''
                             and a1.dazs is null)) as contract_type,
                1 as role_id,
                null as firstname,
                null as surname,
                null as fathers_name,
                null as gender,
                null as classification,
                null as birth_surname,
                null as date_birth,
                null as place_birth,
                null as residency,
                null as citizenship,
                null as neg_status,
                null as education,
                null as marital_status,
                null as position,
                null as okpo,
                null as cust_key,
                null as ser,
                null as numdoc,
                null as passp_iss_date,
                null as passp_exp_date,
                null as passp_organ,
                c1.telr as phone_office,
                null as phone_mobile,
                null as phone_fax,
                null as email,
                null as website,
                1 status_id,
                ''uk-UA'' lang_name,
                c.nmk name,
                ''uk-UA'' lang_abbreviation,
                c.nmkk abbreviation,
                case
                  when c.sed in (''00'', ''91'', ''34'') then
                   0
                  when c.sed in (''08'',
                                 ''09'',
                                 ''10'',
                                 ''11'',
                                 ''12'',
                                 ''13'',
                                 ''14'',
                                 ''15'',
                                 ''16'',
                                 ''17'',
                                 ''19'',
                                 ''33'',
                                 ''20'') then
                   1
                  when c.sed in (''23'', ''24'', ''25'', ''26'', ''27'') then
                   2
                  when c.sed in (''61'', ''62'', ''63'', ''64'', ''65'', ''66'', ''18'') then
                   3
                  when c.sed in (''40'', ''41'', ''42'', ''43'', ''44'') then
                   4
                  when c.sed in (''70'', ''28'', ''29'', ''30'', ''31'', ''32'') then
                   5
                  when c.sed in (''80'', ''50'', ''51'', ''52'') then
                   6
                  when c.sed in (''45'',
                                 ''46'',
                                 ''47'',
                                 ''48'',
                                 ''49'',
                                 ''53'',
                                 ''54'',
                                 ''55'',
                                 ''56'',
                                 ''57'') then
                   8
                  else
                   9
                --when c.sed in (''92'',''93'',''94'',''95'',''96'',''97'',''21'',''22'') then 9
                end as ownership,
                c.datea registr_date,
                null economic_activity,
                DECODE(DECODE(TRANSLATE(TRANSLATE(trim(f_get_custw_h(c.rnk,
                                                                     ''FSKPR'',
                                                                     trunc(sysdate))),
                                                  ''_'',
                                                  ''-''),
                                        ''0123456789'',
                                        ''__________''),
                              ''_'',
                              1,
                              ''__'',
                              1,
                              ''___'',
                              1,
                              ''____'',
                              1,
                              ''_____'',
                              1,
                              ''______'',
                              1,
                              ''_______'',
                              1,
                              ''________'',
                              1,
                              ''_________'',
                              1,
                              0),
                       1,
                       case
                         when to_number(trim(f_get_custw_h(c.rnk,
                                                           ''FSKPR'',
                                                           trunc(sysdate)))) between 1 and 5 then
                          1
                         when to_number(trim(f_get_custw_h(c.rnk,
                                                           ''FSKPR'',
                                                           trunc(sysdate)))) between 6 and 30 then
                          2
                         when to_number(trim(f_get_custw_h(c.rnk,
                                                           ''FSKPR'',
                                                           trunc(sysdate)))) between 31 and 100 then
                          3
                         when to_number(trim(f_get_custw_h(c.rnk,
                                                           ''FSKPR'',
                                                           trunc(sysdate)))) between 101 and 500 then
                          4
                         when to_number(trim(f_get_custw_h(c.rnk,
                                                           ''FSKPR'',
                                                           trunc(sysdate)))) > 500 then
                          5
                       end,
                       NULL) emplote_count,
                c.okpo cust_code,
                null reg_num,
                c1.tel_fax,
                c1.e_mail,
                a8.acc as a8_acc,
                a8.kv as a8_kv,
                c.branch,
                cd.branch as branch_dog,
                cd.limit,
                nvl(bars.rez1.ostc96(a1.acc,:p_date_l),0) res_sum,
                c.adr,
                cd.prod
           from cc_deal cd,
                cc_add cda,
                customer c,
                (select nd, max(cig_20) as cig_20
                   from (select nd, decode(tag, ''CIG_D20'', value) as cig_20
                           from mos_operw
                          where tag in (''CIG_D20''))
                  group by nd) ow,
                tabval val,
                corps c1,
                nd_acc n,
                accounts a8,
                accounts a1
          where cd.nd = cda.nd
            and cd.rnk = c.rnk
            and cd.nd = ow.nd(+)
            and cda.kv = val.kv
            and c.custtype = 1
            and (cd.vidd > 1500 and cd.vidd < 1600)
            and cd.sdate < :p_date_f
            and (cd.sos > 9 and (cd.sos < 15 or cd.wdate >= :p_date_f))
            and cd.rnk = c1.rnk(+)
            and cd.nd = n.nd
            and n.acc = a8.acc
            and a8.tip = ''SS''
            and a1.acc = cda.accs
            and cda.adds = 0
            and a1.nbs in (''1510'',
                           ''1512'',
                           ''1513'',
                           ''1514'',
                           ''1517'',
                           ''1521'',
                           ''1522'',
                           ''1523'',
                           ''1524'',
                           ''1527'')
         --and not exists (select nd from V_CIG_DOG_GENERAL where nd = cd.nd)
         ) q,
 (SELECT rnk as rnk, --
        nvl(fact_terr_id, reg_terr_id) as fact_terr_id, --
        NVL(CASE WHEN fact_type_id = 2 AND fact_terr_id = -1 THEN
                      DECODE(domain2,   NULL, '''', trim(domain2)   || '''', '''') ||
                      DECODE(region2,   NULL, '''', trim(region2)   || '''', '''') ||
                      DECODE(locality2, NULL, '''', trim(locality2) || '''', '''') || trim(address2)
                 WHEN fact_type_id = 2 AND fact_terr_id > 0  THEN
                      address2
                 ELSE NULL   END, --NVL-- ���� ��� ���.���. ������� ����.���.
                      DECODE(domain1,   NULL, '''', trim(domain1)   || '''', '''') ||
                      DECODE(region1,   NULL, '''', trim(region1)   || '''', '''') ||
                      DECODE(locality1, NULL, '''', trim(locality1) || '''', '''') || trim(address1)) as fact_addr, --
        NVL(fact_zip, reg_zip) as fact_zip, --
        reg_terr_id            as reg_terr_id,--
        NVL(CASE WHEN reg_type_id = 1 AND NVL(reg_terr_id, -1) = -1 THEN
                      DECODE(domain1,   NULL, '''', trim(domain1)   || '''', '''') ||
                      DECODE(region1,   NULL, '''', trim(region1)   || '''', '''') ||
                      DECODE(locality1, NULL, '''', trim(locality1) || '''', '''') || trim(address1)
                 WHEN reg_type_id = 1 AND reg_terr_id > 0           THEN
                      address1
                 ELSE NULL END,  --NVL-- ���� ��� ����.���. ������� ���.���.
                      DECODE(domain2,   NULL, '''', trim(domain2)   || '''', '''') ||
                      DECODE(region2,   NULL, '''', trim(region2)   || '''', '''') ||
                      DECODE(locality2, NULL, '''', trim(locality2) || '''', '''') || trim(address2)) as reg_addr, --
        NVL(reg_zip, fact_zip) as reg_zip --
   FROM (SELECT rnk,
                min(DECODE(territory_id, null, -1, territory_id)) as territory_id,
                MAX(DECODE(type_id, 1,   type_id,  NULL)) AS reg_type_id,
                MAX(DECODE(type_id, 2,   type_id,  NULL)) AS fact_type_id,
                MAX(DECODE(type_id, 2,   nvl(territory_id, -1), -1)) AS fact_terr_id,
                MAX(DECODE(type_id, 2,   zip,      NULL)) AS fact_zip,
                MAX(DECODE(type_id, 2,   domain,   NULL)) AS domain2,
                MAX(DECODE(type_id, 2,   region,   NULL)) AS region2,
                MAX(DECODE(type_id, 2,   locality, NULL)) AS locality2,
                MAX(DECODE(type_id, 2,   address,  NULL)) AS address2,
                MAX(DECODE(type_id, 1,   zip,      NULL)) AS reg_zip,
                MAX(DECODE(type_id, 1,   domain,   NULL)) AS domain1,
                MAX(DECODE(type_id, 1,   region,   NULL)) AS region1,
                MAX(DECODE(type_id, 1,   locality, NULL)) AS locality1,
                MAX(DECODE(type_id, 1,   address,  NULL)) AS address1,
                MAX(DECODE(type_id, 1,   nvl(territory_id, -1), -1)) AS reg_terr_id
           FROM bars.customer_address
          WHERE 1=1 -- rnk IN (16784021, 37853721, 95127921, 95497721, 151213521, 277793721)
            AND type_id < 3
          GROUP BY rnk) ) c2
  where q.rnk = c2.rnk(+) and q.res_sum != 0'
         using l_pdatel, l_pdatef, l_pdatef;
     end if;
   end get_dg_rs;

   --------------------------------------------------------------------------------
   -- prc_dog_bpk - ��������� ��������� ���
   --
   procedure prc_dog_bpk(p_dog_id    in number,
                         p_rec       in dog_general_rec_type,
                         p_date      in date,
                         p_oldbranch in branch.branch%type) is
     l_th constant varchar2(100) := g_dbgcode || 'prc_dog_bpk';
     l_id      number;
   begin
     bars_audit.trace('%s: entry point', l_th);

     -- ������� ��� ���������� ������ �� ����� ��������
     if p_oldbranch is not null then
       for cr in (select cdc.*
                    from V_CIG_DOG_CREDIT cdc, V_CIG_DOG_GENERAL dg
                   where dg.nd = p_rec.nd
                     and cdc.dog_id = dg.id
                     and cdc.branch = p_oldbranch
                     and dg.contract_type = p_rec.contract_type) loop
         delete from V_CIG_DOG_CREDIT cdc
          where cdc.id = cr.id
            and cr.branch = cdc.branch;
         delete from V_CIG_SYNC_DATA csd
          where csd.branch = cr.branch
            and csd.data_id = cr.id
            and csd.data_type = 4;
       end loop;
     end if;

 begin
     select s_cig_dog_credit.nextval into l_id from dual;

     insert into V_CIG_DOG_CREDIT
       (id,
        dog_id,
        limit_curr_id,
        limit_sum,
        update_date,
        credit_usage,
        res_curr_id,
        res_sum,
        overdue_curr_id,
        overdue_sum,
        branch)
     values
       (l_id,
        p_dog_id,
        p_rec.currency_id,
        abs(nvl(p_rec.limit_sum, 0) / 100),
        p_rec.accountingDate,
        p_rec.credit_usage,
        p_rec.currency_id,
        abs(nvl(p_rec.res_sum, 0) / 100),
        p_rec.currency_id,
        abs(nvl(p_rec.overdue_sum, 0) / 100),
        p_rec.branch);

    EXCEPTION WHEN OTHERS  THEN
          bars_audit.info ('cig_mgr.prc_dog_bpk insrert \p_dog_id: '||p_dog_id||' p_oldbranch: '||p_oldbranch||'\p_rec.nd:'||p_rec.nd||' : '|| sqlerrm);
       end;

     upd_syncdata(l_id, p_rec.branch, G_DOG_CREDITDATA);

     bars_audit.trace('%s: done', l_th);
   end prc_dog_bpk;

   --------------------------------------------------------------------------------
   -- prc_dog_inst - ����� ���� �����
   --
   -- p_dog_id - �������������� �������� (cig_dog_general)
   -- p_nd - �������� ���������� ������� (cc_deal)
   -- p_last_date - ���� ���������� ���������� �� ��������
   -- p_date - ����, �� ������� ����� �������� ����������
   --
   procedure prc_dog_inst(p_dog_id    in V_CIG_DOG_GENERAL.id%type,
                          p_branch    in V_CIG_DOG_GENERAL.branch%type,
                          p_nd        in cc_deal.nd%type,
                          p_last_date in date,
                          p_date      in date,
                          p_a8_acc    in accounts.acc%type,
                          p_a8_kv     in accounts.kv%type,
                          p_oldbranch in branch.branch%type) is
     l_th constant varchar2(100) := g_dbgcode || 'prc_dog_inst';
     l_rec            v_cig_dog_instalment%rowtype;
     l_cnt_all        number;
     l_sum_all        number;
     l_outst_sum      number;
     l_overdue_sum    number;
     l_instalment_sum number;
     l_outst_now      number;
     l_id             number;
   begin
     bars_audit.trace('%s: entry point', l_th);
     l_rec.dog_id := p_dog_id;
     l_rec.branch := p_branch;

     select count(*), -- ���. ���.��������
            nvl(sum(sumg), 0) -- ���. ��� % ����-����� ��������
       into l_cnt_all, l_sum_all
       from cc_pog
      where nd = p_nd
        and (sumg > 0 or sumo > 0);

     if (l_cnt_all = 0) then
       bars_audit.trace('%s: dog nd=%s does not have records in cc_pog',
                        l_th,
                        to_char(p_nd));
     else
       bars_audit.trace('%s: l_cnt_all=%s, l_sum_all=%s',
                        l_th,
                        to_char(l_cnt_all),
                        to_char(l_sum_all));
     end if;

     -- ����� ������� ������������� �� ���� ������� ������������ �������������
     select
     -- ����� ����
      sum(gl.p_ncurval(p_a8_kv,
                       gl.p_icurval(a.kv, fost(a.acc, p_date), p_date),
                       p_date)),
      -- ����� ����������
      sum(gl.p_ncurval(p_a8_kv,
                       case
                         when a.tip in ('SP ', 'SL ', 'SPN', 'SK9', 'SN8', 'SLN') then
                          gl.p_icurval(a.kv, fost(a.acc, p_date), p_date)
                         else
                          0
                       end,
                       p_date)),
      -- ����� ���� ��� ���� �������
      sum(gl.p_ncurval(p_a8_kv,
                       case
                         when a.tip in
                              ('SN ', 'SP ', 'SL ', 'SPN', 'SK9', 'SN8', 'SLN', 'SK0', 'SNO') then
                          gl.p_icurval(a.kv, fost(a.acc, p_date), p_date)
                         else
                          0
                       end,
                       p_date))
       into l_outst_sum, l_overdue_sum, l_outst_now
       from accounts a, nd_acc n
      where n.nd = p_nd
        and n.acc = a.acc
        and a.tip in ('SS ', -- SS  �������� ����
                      'SN ', -- SN  ���������� ����
                      'SP ', -- SP  ����������� ���.����
                      'SPN', -- SPN ����������� ����.����
                      'SL ', -- SL  ��������� ���.����
                      'SLN', -- SLN ������������ ���������� ����
                      'SK0', -- SK0 �����. ����� �� ������
                      'SK9', -- SK9 �������. ����� �� ������
                      'SN8', -- SN8 �����.����
                      'SNO' -- SNO ���. % ������ 30 ����
                      );

     l_outst_sum   := abs(nvl(l_outst_sum, 0));
     l_overdue_sum := abs(nvl(l_overdue_sum, 0));
     l_outst_now   := abs(nvl(l_outst_now, 0));

     -- ����� ���������� �������� �������
     begin
       select sumg
         into l_instalment_sum
         from cc_pog g
        where nd = p_nd
          and (g.nd, g.fdat) = (select nd, min(fdat)
                                  from cc_pog
                                 where nd = g.nd
                                   and fdat >= p_date
                                   and sumg > 0
                                 group by nd);
     exception
       when no_data_found then
         l_instalment_sum := 0;
     end;

     l_instalment_sum := l_instalment_sum + l_outst_now;

     /*��� ������ �������� ���������� ��� ������ - ���� ������� �� ������.
     ���� � ����� 䳿  ����� ���� ��������� (���������,
     �� ������� ��������� ���������� ����) - ���� ���� ����������
     � ��������� �����������. */
     l_rec.body_sum     := l_sum_all / 100;
     l_rec.body_curr_id := p_a8_kv;

     /*��� ������ �������� ���������� ��� ������ - ������� �������
     ����� ������� �������. ���� � ����� 䳿  ����� ������� �������
     ��������� (���������, �� ������� ��������� ���������� ����) - ����
     ������� ���������� � ��������� �����������.*/
     l_rec.body_total_cnt := l_cnt_all;

     /*��� ������ �������� ���������� ��� ������ - ���� ����� ��������� ��������
     ������� (��������� ������� �� ��� ������� �� ��������)
     ����� ������� �������.
     ��� �������� ��������� ��������� - ���� ������ ����� ������� �� ���������� �����.*/
     l_rec.instalment_sum     := l_instalment_sum / 100;
     l_rec.instalment_curr_id := p_a8_kv;

     /*����, �� ��� ���������� ���������� � ���� (YYYY-MM-DD)*/
     l_rec.update_date := sysdate;

     /*��� ������ �������� ���������� ��� ������ - ������� ���������
     ��� ��������. ��� �������� ��������� ��������� - �������
     ���������� ���� � ����������� ��� �������, �����������
     �������, �������, �����.*/
     l_rec.outstand_sum := l_outst_sum / 100;
     -- TODO: ���������� ���-��
     if nvl(l_outst_sum, 0) > 0 then
       l_rec.outstand_cnt := 1;
     else
       l_rec.outstand_cnt := 0;
     end if;
     l_rec.outstand_curr_id := p_a8_kv;

     /*��� ������ �������� ���������� ��� ������ - ������� 0.
     ��� �������� ��������� ��������� - ���� ���������� ����������
     ������������� � ����������� ��� �������, ����������� �������,
     �������, ����� �� ���� ����������.*/
     l_rec.overdue_sum := l_overdue_sum / 100;
     -- TODO: ���������� ���-��
     if nvl(l_overdue_sum, 0) > 0 then
       l_rec.overdue_cnt := 1;
     else
       l_rec.overdue_cnt := 0;
     end if;

     l_rec.overdue_curr_id := p_a8_kv;

     /*begin

       select id
         into l_id
         from cig_dog_instalment
        where
          dog_id = l_rec.dog_id and
          trunc(update_date) = trunc(p_date);

       -- ���������� ������������ ������ �� ��������� ����
       update cig_dog_instalment set
         body_sum = l_rec.body_sum,
         body_curr_id = l_rec.body_curr_id,
         body_total_cnt = l_rec.body_total_cnt,
         instalment_curr_id = l_rec.instalment_curr_id,
         instalment_sum = l_rec.instalment_sum,
         update_date = l_rec.update_date,
         outstand_cnt = l_rec.outstand_cnt,
         outstand_curr_id = l_rec.outstand_curr_id,
         outstand_sum = l_rec.outstand_sum,
         overdue_cnt = l_rec.overdue_cnt,
         overdue_curr_id = l_rec.overdue_curr_id,
         overdue_sum = l_rec.overdue_sum
       where id = l_id;

     exception when no_data_found then*/

     if p_oldbranch is not null then
       -- ������� ��� ���������� ������ �� ����� ��������
       for cr in (select cdi.*
                    from v_cig_dog_instalment cdi, V_CIG_DOG_GENERAL dg
                   where dg.nd = p_nd
                     and cdi.dog_id = dg.id
                     and cdi.branch = p_oldbranch
                     and dg.contract_type = 1) loop
         delete from v_cig_dog_instalment cdi
          where cdi.id = cr.id
            and cr.branch = cdi.branch;
         delete from V_CIG_SYNC_DATA csd
          where csd.branch = cr.branch
            and csd.data_id = cr.id
            and csd.data_type = 3;
       end loop;
       for cr_ in (select cdc.*
                     from V_CIG_DOG_CREDIT cdc, V_CIG_DOG_GENERAL dg
                    where dg.nd = p_nd
                      and cdc.dog_id = dg.id
                      and cdc.branch = p_oldbranch
                      and dg.contract_type = 2) loop
         delete from V_CIG_DOG_CREDIT cdc
          where cdc.id = cr_.id
            and cr_.branch = cdc.branch;
         delete from V_CIG_SYNC_DATA csd
          where csd.branch = cr_.branch
            and csd.data_id = cr_.id
            and csd.data_type = 4;
       end loop;
     end if;

 begin
     select s_cig_dog_instalment.nextval into l_id from dual;

     insert into v_cig_dog_instalment
       (id,
        dog_id,
        body_sum,
        body_curr_id,
        body_total_cnt,
        instalment_curr_id,
        instalment_sum,
        update_date,
        outstand_cnt,
        outstand_curr_id,
        outstand_sum,
        overdue_cnt,
        overdue_curr_id,
        overdue_sum,
        branch)
     values
       (l_id,
        l_rec.dog_id,
        l_rec.body_sum,
        l_rec.body_curr_id,
        l_rec.body_total_cnt,
        l_rec.instalment_curr_id,
        l_rec.instalment_sum,
        l_rec.update_date,
        l_rec.outstand_cnt,
        l_rec.outstand_curr_id,
        l_rec.outstand_sum,
        l_rec.overdue_cnt,
        l_rec.overdue_curr_id,
        l_rec.overdue_sum,
        l_rec.branch);

    EXCEPTION WHEN OTHERS  THEN
          bars_audit.info ('cig_mgr.prc_dog_inst insrert \p_dog_id: '||p_dog_id||' p_oldbranch: '||p_oldbranch||'\p_nd:'||p_nd||' : '|| sqlerrm);
       end;

     upd_syncdata(l_id, l_rec.branch, G_DOG_INSTDATA);

     bars_audit.trace('%s: done', l_th);
   end prc_dog_inst;

   --------------------------------------------------------------------------------
   -- prc_dog_credit - ����� ���� �����
   -- p_dog_id - �������������� �������� (V_CIG_DOG_GENERAL)
   -- p_nd - �������� ���������� ������� (cc_deal)
   -- p_last_date - ���� ���������� ���������� �� ��������
   -- p_date - ����, �� ������� ����� �������� ����������
   --
   procedure prc_dog_credit(p_dog_id        in V_CIG_DOG_GENERAL.id%type,
                            p_branch        in V_CIG_DOG_GENERAL.branch%type,
                            p_nd            in cc_deal.nd%type,
                            p_last_date     in date,
                            p_date          in date,
                            p_a8_acc        in accounts.acc%type,
                            p_a8_kv         in accounts.kv%type,
                            p_oldbranch     in branch.branch%type,
                            p_contract_type in NUMBER default null) is
     l_th constant varchar2(100) := g_dbgcode || 'prc_dog_credit';
     l_rec         V_CIG_DOG_CREDIT%rowtype;
     l_cl_usage    number;
     l_lim_total   number;
     l_res_sum     number;
     l_overdue_sum number;
     l_id          number;
   begin
     bars_audit.trace('%s: entry point', l_th);
     l_rec.dog_id := p_dog_id;
     l_rec.branch := p_branch;

     -- ������� �����
     begin
       select lim2
         into l_lim_total
         from cc_lim
        where fdat = (select max(fdat)
                        from cc_lim
                       where acc = p_a8_acc
                         and fdat <= p_date)
          and acc = p_a8_acc;
     exception
       when no_data_found then
         -- ��� �������� %s �� ������ ���� � ����� LIM'
         add_event(G_SYSERROR,
                   bars_error.get_nerror_text(g_module_name,
                                              'CIG_ACCLIM_NOTFOUND',
                                              to_char(p_a8_acc)),
                   sqlerrm,
                   p_nd);
         bars_audit.trace('%s: error detected: LIM acc not found, acc=%s',
                          l_th,
                          to_char(p_a8_acc));
         return;
     end;
     bars_audit.trace('%s: LIM acc found, acc=%s', l_th, to_char(p_a8_acc));

     -- ���� ������������� ������
     -- 1-������ ������, 2-��������� , 3 - ������ ��������
     select nvl(decode(sign(sum(dos - kos)), 0, 3, 1, 1, -1, 2, 3), 3)
       into l_cl_usage
       from saldoa
      where acc = p_a8_acc
        and fdat > p_last_date
        and fdat <= p_date;

     if l_cl_usage is null then
       bars_audit.trace('%s: error detected: no informaton about acc in saldoa, acc=%s',
                        l_th,
                        to_char(p_a8_acc));
       l_cl_usage := 3;
     end if;

     bars_audit.trace('%s: error detected: LIM acc not found, acc=%s',
                      l_th,
                      to_char(p_a8_acc));

     -- ����� ������� ������������� �� ���� ������� ������������ �������������
     select
     -- ����� ������� (� ������ ���� � ���. ���� + ���� + ��������� + ��������)
      sum(gl.p_ncurval(p_a8_kv,
                       gl.p_icurval(a.kv, fost(a.acc, p_date), p_date),
                       p_date)),
      sum(gl.p_ncurval(p_a8_kv,
                       -- ���� + ��������� + ��������)
                       case
                         when a.tip in ('SP ', 'SL ', 'SPN', 'SK9', 'SN8', 'SLN') then
                          gl.p_icurval(a.kv, fost(a.acc, p_date), p_date)
                         else
                          0
                       end,
                       p_date))
       into l_res_sum, l_overdue_sum
       from accounts a, nd_acc n
      where n.nd = p_nd
        and n.acc = a.acc
        and a.tip in ('SS ',
                      'SP ',
                      'SL ',
                      'SN ',
                      'SPN',
                      'SLN',
                      'SK0',
                      'SK9',
                      'SN8',
                      'SNO');

     l_rec.limit_curr_id := p_a8_kv; -- ������ ������
     l_rec.limit_sum     := l_lim_total / 100; -- ������� ����� ������
     l_rec.update_date   := sysdate; -- ���� ���������
     l_rec.credit_usage  := l_cl_usage; -- ���� ������������� ������

     l_rec.res_curr_id     := p_a8_kv; -- ������ �������
     l_rec.res_sum         := abs(l_res_sum) / 100; -- ���� �������
     l_rec.overdue_curr_id := p_a8_kv; -- ������ ���������. ������������
     l_rec.overdue_sum     := abs(l_overdue_sum) / 100; -- ����� �������. ������������

     /*begin

       select id
         into l_id
         from cig_dog_credit
        where
          dog_id = l_rec.dog_id and
          trunc(update_date) = trunc(p_date);

       update cig_dog_credit set
         limit_curr_id = l_rec.limit_curr_id,
         limit_sum = l_rec.limit_sum,
         update_date = l_rec.update_date,
         credit_usage = l_rec.credit_usage,
         res_curr_id = l_rec.res_curr_id,
         res_sum = l_rec.res_sum,
         overdue_curr_id = l_rec.overdue_curr_id,
         overdue_sum = l_rec.overdue_sum,
         sync_date = null
       where id = l_id;

     exception when no_data_found then*/

     -- ������� ��� ���������� ������ �� ����� ��������
     if p_oldbranch is not null then
       if (p_contract_type is null) then
         for cr in (select cdi.*
                      from v_cig_dog_instalment cdi, V_CIG_DOG_GENERAL dg
                     where dg.nd = p_nd
                       and cdi.dog_id = dg.id
                       and cdi.branch = p_oldbranch
                       and dg.contract_type = 1) loop
           delete from v_cig_dog_instalment cdi
            where cdi.id = cr.id
              and cr.branch = cdi.branch;
           delete from V_CIG_SYNC_DATA csd
            where csd.branch = cr.branch
              and csd.data_id = cr.id
              and csd.data_type = 3;
         end loop;
         for cr_ in (select cdc.*
                       from V_CIG_DOG_CREDIT cdc, V_CIG_DOG_GENERAL dg
                      where dg.nd = p_nd
                        and cdc.dog_id = dg.id
                        and cdc.branch = p_oldbranch
                        and dg.contract_type = 2) loop
           delete from V_CIG_DOG_CREDIT cdc
            where cdc.id = cr_.id
              and cr_.branch = cdc.branch;
           delete from V_CIG_SYNC_DATA csd
            where csd.branch = cr_.branch
              and csd.data_id = cr_.id
              and csd.data_type = 4;
         end loop;
       elsif (p_contract_type = 7) then
         for cr_ in (select cdc.*
                       from V_CIG_DOG_CREDIT cdc, V_CIG_DOG_GENERAL dg
                      where dg.nd = p_nd
                        and cdc.dog_id = dg.id
                        and cdc.branch = p_oldbranch
                        and dg.contract_type = p_contract_type) loop
           delete from V_CIG_DOG_CREDIT cdc
            where cdc.id = cr_.id
              and cr_.branch = cdc.branch;
           delete from V_CIG_SYNC_DATA csd
            where csd.branch = cr_.branch
              and csd.data_id = cr_.id
              and csd.data_type = 4;
         end loop;
       end if;
     end if;

 begin
     select s_cig_dog_credit.nextval into l_id from dual;

     insert into V_CIG_DOG_CREDIT
       (id,
        dog_id,
        limit_curr_id,
        limit_sum,
        update_date,
        credit_usage,
        res_curr_id,
        res_sum,
        overdue_curr_id,
        overdue_sum,
        branch)
     values
       (l_id,
        l_rec.dog_id,
        l_rec.limit_curr_id,
        nvl(l_rec.limit_sum,0),
        l_rec.update_date,
        l_rec.credit_usage,
        l_rec.res_curr_id,
        nvl(l_rec.res_sum,0),
        l_rec.overdue_curr_id,
        nvl(l_rec.overdue_sum,0),
        l_rec.branch);

   EXCEPTION WHEN OTHERS  THEN
          bars_audit.info ('cig_mgr.prc_dog_credit insert: '||p_dog_id||' p_branch: '||p_branch||'\p_nd:'||p_nd||' : '|| sqlerrm);
       end;

     upd_syncdata(l_id, l_rec.branch, G_DOG_CREDITDATA);

     bars_audit.trace('%s: done', l_th);
   end prc_dog_credit;

   --------------------------------------------------------------------------------
   -- prc_dog_noninst - ����� ���� �����
   -- p_dog_id - �������������� �������� (V_CIG_DOG_GENERAL)
   -- p_nd - �������� ���������� ������� (cc_deal)
   -- p_last_date - ���� ���������� ���������� �� ��������
   -- p_date - ����, �� ������� ����� �������� ����������
   --
   procedure prc_dog_noninst(p_dog_id        in V_CIG_DOG_GENERAL.id%type,
                             p_branch        in V_CIG_DOG_GENERAL.branch%type,
                             p_nd            in cc_deal.nd%type,
                             p_limit         in cc_deal.limit%type,
                             p_res_sum       in number,
                             p_last_date     in date,
                             p_date          in date,
                             p_a8_acc        in accounts.acc%type,
                             p_a8_kv         in accounts.kv%type,
                             p_oldbranch     in branch.branch%type,
                             p_contract_type in NUMBER default null) is
     l_th constant varchar2(200) := g_dbgcode || 'prc_dog_noninst';
     l_rec      v_cig_dog_noninstalment%rowtype;
     l_cl_usage number;
     l_res_sum  number;
     l_id       number;
   begin
     bars_audit.trace('%s: entry point', l_th);
     l_rec.dog_id := p_dog_id;
     l_rec.branch := p_branch;

     -- ���� ������������� ������
     -- 1-������ ������, 2-��������� , 3 - ������ ��������
     select nvl(decode(sign(sum(dos - kos)), 0, 3, 1, 1, -1, 2, 3), 3)
       into l_cl_usage
       from saldoa
      where acc = p_a8_acc
        and fdat > p_last_date
        and fdat <= p_date;

     if l_cl_usage is null then
       bars_audit.trace('%s: error detected: no informaton about acc in saldoa, acc=%s',
                        l_th,
                        to_char(p_a8_acc));
       l_cl_usage := 3;
     end if;

     --���� �������������, ��� ������� �� ���� ����
     if p_res_sum is null then
       select sum(gl.p_ncurval(p_a8_kv,
                               gl.p_icurval(a.kv, fost(a.acc, p_date), p_date),
                               p_date))
         into l_res_sum
         from accounts a, nd_acc n
        where n.nd = p_nd
          and n.acc = a.acc
          and a.tip in ('SS ',
                        'SP ',
                        'SL ',
                        'SN ',
                        'SPN',
                        'SLN',
                        'SK0',
                        'SK9',
                        'SN8',
                        'SNO');
     else
       l_res_sum := p_res_sum;
     end if;

     l_rec.limit_curr_id := p_a8_kv; -- ������ ������
     l_rec.limit_sum     := p_limit / 100; -- ������� ����� ������
     l_rec.update_date   := sysdate; -- ���� ���������
     l_rec.credit_usage  := l_cl_usage; -- ���� ������������� ������

     l_rec.used_curr_id := p_a8_kv;
     l_rec.used_sum     := abs(l_res_sum) / 100;

     if (p_oldbranch is not null) then
       -- ������� ��� ���������� ������ �� ����� ��������
       for cr_ in (select cdc.*
                     from v_cig_dog_noninstalment cdc, V_CIG_DOG_GENERAL dg
                    where dg.nd = p_nd
                      and cdc.dog_id = dg.id
                      and cdc.branch = p_oldbranch
                      and dg.contract_type = p_contract_type) loop
         delete from v_cig_dog_noninstalment cdc
          where cdc.id = cr_.id
            and cr_.branch = cdc.branch;
         delete from V_CIG_SYNC_DATA csd
          where csd.branch = cr_.branch
            and csd.data_id = cr_.id
            and csd.data_type = 5;
       end loop;
     end if;

 begin
     select s_cig_dog_noninstalment.nextval into l_id from dual;

     insert into v_cig_dog_noninstalment
       (id,
        dog_id,
        limit_curr_id,
        limit_sum,
        update_date,
        credit_usage,
        used_curr_id,
        used_sum,
        branch)
     values
       (l_id,
        l_rec.dog_id,
        l_rec.limit_curr_id,
        l_rec.limit_sum,
        l_rec.update_date,
        l_rec.credit_usage,
        l_rec.used_curr_id,
        l_rec.used_sum,
        l_rec.branch);

     EXCEPTION WHEN OTHERS  THEN
          bars_audit.info ('cig_mgr.prc_dog_noninst insert: '||p_dog_id||' p_branch: '||p_branch||'\p_nd:'||p_nd||' : '|| sqlerrm);
       end;

     upd_syncdata(l_id, l_rec.branch, G_DOG_NONINSTDATA);

     bars_audit.trace('%s: done', l_th);
   end prc_dog_noninst;
   
   
   -- �������� �������� �� �����������
   procedure p_stg2row
   (
    ip_dtype in         number,
    ip_stg   in         stg_general_rec_type,
    ip_row   out nocopy dog_general_rec_type
   )
   as
    idx       pls_integer := 0;
    l_field   varchar2(30);
    l_value   varchar2(4000);
    l_errm    varchar2(32000);
    l_sqlerrm varchar2(32000);
    
   begin      
    idx:= idx + 1; ip_row.nd                 := ip_stg.nd               ;
    idx:= idx + 1; ip_row.rnk                := ip_stg.rnk              ;
    idx:= idx + 1; ip_row.start_date         := ip_stg.start_date       ;
    idx:= idx + 1; ip_row.end_date           := ip_stg.end_date         ;
    idx:= idx + 1; ip_row.bdate              := ip_stg.bdate            ;
    idx:= idx + 1; ip_row.dazs               := ip_stg.dazs             ;
    idx:= idx + 1; ip_row.currency           := ip_stg.currency         ;
    idx:= idx + 1; ip_row.currency_id        := ip_stg.currency_id      ;
    idx:= idx + 1; ip_row.cig_13             := ip_stg.cig_13           ;
    idx:= idx + 1; ip_row.cig_14             := ip_stg.cig_14           ;
    idx:= idx + 1; ip_row.cig_15             := ip_stg.cig_15           ;
    idx:= idx + 1; ip_row.cig_16             := ip_stg.cig_16           ;
    idx:= idx + 1; ip_row.cig_17             := ip_stg.cig_17           ;
    idx:= idx + 1; ip_row.cig_18             := ip_stg.cig_18           ;
    idx:= idx + 1; ip_row.cig_19             := ip_stg.cig_19           ;
    idx:= idx + 1; ip_row.cig_20             := ip_stg.cig_20           ;
    idx:= idx + 1; ip_row.custtype           := ip_stg.custtype         ;
    idx:= idx + 1; ip_row.contract_type      := ip_stg.contract_type    ;
    idx:= idx + 1; ip_row.branch             := ip_stg.branch           ;
    idx:= idx + 1; ip_row.limit_sum          := ip_stg.limit_sum        ;
    idx:= idx + 1; ip_row.credit_usage       := ip_stg.credit_usage     ;
    idx:= idx + 1; ip_row.res_sum            := ip_stg.res_sum          ;
    idx:= idx + 1; ip_row.overdue_sum        := ip_stg.overdue_sum      ;
    idx:= idx + 1; ip_row.accountingDate     := ip_stg.accountingDate   ;
    idx:= idx + 1; ip_row.fact_terr_id       := ip_stg.fact_terr_id     ;
    idx:= idx + 1; ip_row.fact_addr          := ip_stg.fact_addr        ;
    idx:= idx + 1; ip_row.fact_zip           := ip_stg.fact_zip         ;
    idx:= idx + 1; ip_row.reg_terr_id        := ip_stg.reg_terr_id      ;
    idx:= idx + 1; ip_row.reg_addr           := ip_stg.reg_addr         ;
    idx:= idx + 1; ip_row.reg_zip            := ip_stg.reg_zip          ;
    idx:= idx + 1; ip_row.role_id            := ip_stg.role_id          ;
    idx:= idx + 1; ip_row.firstname          := ip_stg.firstname        ;
    idx:= idx + 1; ip_row.surname            := ip_stg.surname          ;
    idx:= idx + 1; ip_row.fathers_name       := ip_stg.fathers_name     ;
    idx:= idx + 1; ip_row.gender             := ip_stg.gender           ;
    idx:= idx + 1; ip_row.classification     := ip_stg.classification   ;
    idx:= idx + 1; ip_row.birth_surname      := ip_stg.birth_surname    ;
    idx:= idx + 1; ip_row.date_birth         := ip_stg.date_birth       ;
    idx:= idx + 1; ip_row.place_birth        := ip_stg.place_birth      ;
    idx:= idx + 1; ip_row.residency          := ip_stg.residency        ;
    idx:= idx + 1; ip_row.citizenship        := ip_stg.citizenship      ;
    idx:= idx + 1; ip_row.neg_status         := ip_stg.neg_status       ;
    idx:= idx + 1; ip_row.education          := ip_stg.education        ;
    idx:= idx + 1; ip_row.marital_status     := ip_stg.marital_status   ;
    idx:= idx + 1; ip_row.position           := ip_stg.position         ;
    idx:= idx + 1; ip_row.okpo               := ip_stg.okpo             ;
    idx:= idx + 1; ip_row.cust_key           := ip_stg.cust_key         ;
    idx:= idx + 1; ip_row.ser                := ip_stg.ser              ;
    idx:= idx + 1; ip_row.numdoc             := ip_stg.numdoc           ;
    idx:= idx + 1; ip_row.passp_iss_date     := ip_stg.passp_iss_date   ;
    idx:= idx + 1; ip_row.passp_exp_date     := ip_stg.passp_exp_date   ;
    idx:= idx + 1; ip_row.passp_organ        := ip_stg.passp_organ      ;
    idx:= idx + 1; ip_row.phone_office       := ip_stg.phone_office     ;
    idx:= idx + 1; ip_row.phone_mobile       := ip_stg.phone_mobile     ;
    idx:= idx + 1; ip_row.phone_fax          := ip_stg.phone_fax        ;
    idx:= idx + 1; ip_row.email              := ip_stg.email            ;
    idx:= idx + 1; ip_row.website            := ip_stg.website          ;
    idx:= idx + 1; ip_row.status_id          := ip_stg.status_id        ;
    idx:= idx + 1; ip_row.lang_name          := ip_stg.lang_name        ;
    idx:= idx + 1; ip_row.name               := ip_stg.name             ;
    idx:= idx + 1; ip_row.lang_abbreviation  := ip_stg.lang_abbreviation;
    idx:= idx + 1; ip_row.abbreviation       := ip_stg.abbreviation     ;
    idx:= idx + 1; ip_row.ownership          := ip_stg.ownership        ;
    idx:= idx + 1; ip_row.registr_date       := ip_stg.registr_date     ;
    idx:= idx + 1; ip_row.economic_activity  := ip_stg.economic_activity;
    idx:= idx + 1; ip_row.emplote_count      := ip_stg.emplote_count    ;
    idx:= idx + 1; ip_row.cust_code          := ip_stg.cust_code        ;
    idx:= idx + 1; ip_row.reg_num            := ip_stg.reg_num          ;
    idx:= idx + 1; ip_row.tel_fax            := ip_stg.tel_fax          ;
    idx:= idx + 1; ip_row.e_mail             := ip_stg.e_mail           ;
    idx:= idx + 1; ip_row.a8_acc             := ip_stg.a8_acc           ;
    idx:= idx + 1; ip_row.a8_kv              := ip_stg.a8_kv            ;
    idx:= idx + 1; ip_row.branch_dog         := ip_stg.branch_dog       ;     
   exception 
     when others then
     ip_row := null;
     case idx 
          when 1  then l_field := 'nd'                ; l_value := to_char(ip_stg.nd)                ;
          when 2  then l_field := 'rnk'               ; l_value := to_char(ip_stg.rnk)               ;
          when 3  then l_field := 'start_date'        ; l_value := to_char(ip_stg.start_date)        ;
          when 4  then l_field := 'end_date'          ; l_value := to_char(ip_stg.end_date)          ;
          when 5  then l_field := 'bdate'             ; l_value := to_char(ip_stg.bdate)             ;
          when 6  then l_field := 'dazs'              ; l_value := to_char(ip_stg.dazs)              ;
          when 7  then l_field := 'currency'          ; l_value := to_char(ip_stg.currency)          ;
          when 8  then l_field := 'currency_id'       ; l_value := to_char(ip_stg.currency_id)       ;
          when 9  then l_field := 'cig_13'            ; l_value := to_char(ip_stg.cig_13)            ;
          when 10 then l_field := 'cig_14'            ; l_value := to_char(ip_stg.cig_14)            ;
          when 11 then l_field := 'cig_15'            ; l_value := to_char(ip_stg.cig_15)            ;
          when 12 then l_field := 'cig_16'            ; l_value := to_char(ip_stg.cig_16)            ;
          when 13 then l_field := 'cig_17'            ; l_value := to_char(ip_stg.cig_17)            ;
          when 14 then l_field := 'cig_18'            ; l_value := to_char(ip_stg.cig_18)            ;
          when 15 then l_field := 'cig_19'            ; l_value := to_char(ip_stg.cig_19)            ;
          when 16 then l_field := 'cig_20'            ; l_value := to_char(ip_stg.cig_20)            ;
          when 17 then l_field := 'custtype'          ; l_value := to_char(ip_stg.custtype)          ;
          when 18 then l_field := 'contract_type'     ; l_value := to_char(ip_stg.contract_type)     ;
          when 19 then l_field := 'branch'            ; l_value := to_char(ip_stg.branch)            ;
          when 20 then l_field := 'limit_sum'         ; l_value := to_char(ip_stg.limit_sum)         ;
          when 21 then l_field := 'credit_usage'      ; l_value := to_char(ip_stg.credit_usage)      ;
          when 22 then l_field := 'res_sum'           ; l_value := to_char(ip_stg.res_sum)           ;
          when 23 then l_field := 'overdue_sum'       ; l_value := to_char(ip_stg.overdue_sum)       ;
          when 24 then l_field := 'accountingDate'    ; l_value := to_char(ip_stg.accountingDate)    ;
          when 25 then l_field := 'fact_terr_id'      ; l_value := to_char(ip_stg.fact_terr_id)      ;
          when 26 then l_field := 'fact_addr'         ; l_value := to_char(ip_stg.fact_addr)         ;
          when 27 then l_field := 'fact_zip'          ; l_value := to_char(ip_stg.fact_zip)          ;
          when 28 then l_field := 'reg_terr_id'       ; l_value := to_char(ip_stg.reg_terr_id)       ;
          when 29 then l_field := 'reg_addr'          ; l_value := to_char(ip_stg.reg_addr)          ;
          when 30 then l_field := 'reg_zip'           ; l_value := to_char(ip_stg.reg_zip)           ;
          when 31 then l_field := 'role_id'           ; l_value := to_char(ip_stg.role_id)           ;
          when 32 then l_field := 'firstname'         ; l_value := to_char(ip_stg.firstname)         ;
          when 33 then l_field := 'surname'           ; l_value := to_char(ip_stg.surname)           ;
          when 34 then l_field := 'fathers_name'      ; l_value := to_char(ip_stg.fathers_name)      ;
          when 35 then l_field := 'gender'            ; l_value := to_char(ip_stg.gender)            ;
          when 36 then l_field := 'classification'    ; l_value := to_char(ip_stg.classification)    ;
          when 37 then l_field := 'birth_surname'     ; l_value := to_char(ip_stg.birth_surname)     ;
          when 38 then l_field := 'date_birth'        ; l_value := to_char(ip_stg.date_birth)        ;
          when 39 then l_field := 'place_birth'       ; l_value := to_char(ip_stg.place_birth)       ;
          when 40 then l_field := 'residency'         ; l_value := to_char(ip_stg.residency)         ;
          when 41 then l_field := 'citizenship'       ; l_value := to_char(ip_stg.citizenship)       ;
          when 42 then l_field := 'neg_status'        ; l_value := to_char(ip_stg.neg_status)        ;
          when 43 then l_field := 'education'         ; l_value := to_char(ip_stg.education)         ;
          when 44 then l_field := 'marital_status'    ; l_value := to_char(ip_stg.marital_status)    ;
          when 45 then l_field := 'position'          ; l_value := to_char(ip_stg.position)          ;
          when 46 then l_field := 'okpo'              ; l_value := to_char(ip_stg.okpo)              ;
          when 47 then l_field := 'cust_key'          ; l_value := to_char(ip_stg.cust_key)          ;
          when 48 then l_field := 'ser'               ; l_value := to_char(ip_stg.ser)               ;
          when 49 then l_field := 'numdoc'            ; l_value := to_char(ip_stg.numdoc)            ;
          when 50 then l_field := 'passp_iss_date'    ; l_value := to_char(ip_stg.passp_iss_date)    ;
          when 51 then l_field := 'passp_exp_date'    ; l_value := to_char(ip_stg.passp_exp_date)    ;
          when 52 then l_field := 'passp_organ'       ; l_value := to_char(ip_stg.passp_organ)       ;
          when 53 then l_field := 'phone_office'      ; l_value := to_char(ip_stg.phone_office)      ;
          when 54 then l_field := 'phone_mobile'      ; l_value := to_char(ip_stg.phone_mobile)      ;
          when 55 then l_field := 'phone_fax'         ; l_value := to_char(ip_stg.phone_fax)         ;
          when 56 then l_field := 'email'             ; l_value := to_char(ip_stg.email)             ;
          when 57 then l_field := 'website'           ; l_value := to_char(ip_stg.website)           ;
          when 58 then l_field := 'status_id'         ; l_value := to_char(ip_stg.status_id)         ;
          when 59 then l_field := 'lang_name'         ; l_value := to_char(ip_stg.lang_name)         ;
          when 60 then l_field := 'name'              ; l_value := to_char(ip_stg.name)              ;
          when 61 then l_field := 'lang_abbreviation' ; l_value := to_char(ip_stg.lang_abbreviation) ;
          when 62 then l_field := 'abbreviation'      ; l_value := to_char(ip_stg.abbreviation)      ;
          when 63 then l_field := 'ownership'         ; l_value := to_char(ip_stg.ownership)         ;
          when 64 then l_field := 'registr_date'      ; l_value := to_char(ip_stg.registr_date)      ;
          when 65 then l_field := 'economic_activity' ; l_value := to_char(ip_stg.economic_activity) ;
          when 66 then l_field := 'emplote_count'     ; l_value := to_char(ip_stg.emplote_count)     ;
          when 67 then l_field := 'cust_code'         ; l_value := to_char(ip_stg.cust_code)         ;
          when 68 then l_field := 'reg_num'           ; l_value := to_char(ip_stg.reg_num)           ;
          when 69 then l_field := 'tel_fax'           ; l_value := to_char(ip_stg.tel_fax)           ;
          when 70 then l_field := 'e_mail'            ; l_value := to_char(ip_stg.e_mail)            ;
          when 71 then l_field := 'a8_acc'            ; l_value := to_char(ip_stg.a8_acc)            ;
          when 72 then l_field := 'a8_kv'             ; l_value := to_char(ip_stg.a8_kv)             ;
          when 73 then l_field := 'branch_dog'        ; l_value := to_char(ip_stg.branch_dog)        ;
        end case;           

       l_sqlerrm := sqlerrm;
       l_errm    := 'p_stg2row '||l_field ||' = '||l_value;
       
       add_error(
                 G_SYSERROR,
                 l_errm,
                 l_sqlerrm,
                 ip_stg.nd,
                 ip_stg.rnk,
                 null,
                 ip_dtype
                 );                             
      raise;        
   end p_stg2row;
   --------------------------------------------------------------------------------
   -- prc_dog_general - �������� ����� ���������� �� ��������� ���������
   --
   -- p_dtype ��� ����� ���������
   ---G_CONTRACT_INSTALMENT - 1
   ---G_CONTRACT_CREDIT     - 1
   ---G_CONTRACT_BPK        - 3
   --------------------------------------------------------------------------------
   procedure prc_dog_general(p_dtype in number, p_date date) is
     l_th constant varchar2(100) := g_dbgcode || 'prc_dog_general';
     l_custid        number;
     l_id            number;
     l_sqlerrm       varchar2(4000);
     l_errm          varchar2(4000);
     l_cursor        SYS_REFCURSOR;
     l_row           dog_general_rec_type;
     l_stg           stg_general_rec_type;
     l_check_cust    boolean;
     l_not_exception boolean;
     l_step          number;
     old_branch      branch.branch%type;
     l_count         number;
   begin
     l_step := 0;
     bars_audit.trace('%s: entry point', l_th);
     savepoint dg_start;

     --������ �� ����� ���������� � ���������
     get_dg_rs(p_dtype, p_date, l_cursor);
     
     add_event(G_WITHOUT_ERRORS,
               bars_msg.get_msg(g_module_name,
                                'SYN�DOG_STARTED_INNER',
                                (case when p_dtype = 3 then '(���)' when
                                 p_dtype = 4 then '(���������)' else '' end)),
               null,
               null,
               null,
               null,
               p_dtype);


     bars_audit.trace('%s: cur_dog_general is open, p_dtype=%s',
                      l_th,
                      to_char(p_dtype));

     loop

      begin
       savepoint sv_start;
       -- �������� ������ �������
       begin
         fetch l_cursor
          into l_stg;
       exception
         when others then 
           l_stg := null;
           add_error(G_SYSERROR,'Technical error on Fetching',sqlerrm,null,null,null,p_dtype);                     
           raise;
       end;
       
      -- ����� �� ����� ���� ��� ������
       if l_cursor%notfound then
          bars_audit.trace('%s:cur_dog_general%notfound, exit loop', l_th);
          exit;
       end if;
       -- �������� ������ �� �����������       
       p_stg2row(p_dtype, l_stg, l_row);         
         
       bars_audit.trace('%s: cur_dog_general record fetched, nd=%s , p_dtype=%s',
                        l_th,
                        to_char(l_row.nd),
                        to_char(p_dtype));                        
               
         
         execute immediate 'set constraint FK_CIGCUSTCOMP_CIGCUSTOMERS deferred';
         execute immediate 'set constraint FK_CIGCUSTIND_CIGCUSTOMERS deferred';
         execute immediate 'set constraint FK_CIGDOGG_CIGCUSTOMERS deferred';
         execute immediate 'set constraint FK_CIGDOGINST_CIGDOGGENERAL deferred';
         execute immediate 'set constraint FK_CIGDOGCREDIT_CIGDOGGENERAL deferred';
         l_check_cust := false;
         if (l_row.custtype in (1, 2)) then
           if (check_comp_row(l_row, p_dtype)) then
             bars_audit.trace('%s: attrs checked, rnk=%s',
                              l_th,
                              to_char(l_row.rnk));
             l_check_cust := true;
           else
             bars_audit.trace('%s: attrs not valid, rnk=%s',
                              l_th,
                              to_char(l_row.rnk));
           end if;
         elsif (l_row.custtype = 3) then
           if (check_ind_row(l_row, p_dtype)) then
             bars_audit.trace('%s: attrs checked, rnk=%s',
                              l_th,
                              to_char(l_row.rnk));
             l_check_cust := true;
           else
             bars_audit.trace('%s: attrs not valid, rnk=%s',
                              l_th,
                              to_char(l_row.rnk));
           end if;
         end if;
         if (l_check_cust) then
           if check_dog_row(l_row) then
             begin

               if (l_row.custtype in (1, 2)) then
                 prc_company(l_row, l_not_exception, p_dtype);
               elsif (l_row.custtype = 3) then
                 prc_individuals(l_row, l_not_exception, p_dtype);
               else
                 l_not_exception := false;
               end if;

               begin
                 select g.branch
                   into old_branch
                   from V_CIG_DOG_GENERAL g
                  where g.nd = l_row.nd
                    and contract_type = l_row.contract_type;
               exception
                 when no_data_found then
                   old_branch := null;
               end;

               if (l_not_exception) then

                 --begin
                 -- ����� ������� ��� ���������� ��������
                 l_step := 1;
                 select max(cust_id)
                   into l_custid
                   from V_CIG_CUSTOMERS
                  where rnk = l_row.rnk;

                 -- ������� ��������
                 update V_CIG_DOG_GENERAL
                    set phase_id            = l_row.cig_15,
                        operation           = 1,
                        pay_method_id       = l_row.cig_19,
                        pay_period_id       = l_row.cig_18,
                        contract_type       = l_row.contract_type,
                        contract_code       = l_row.nd,
                        contract_date       = l_row.start_date,
                        contract_start_date = l_row.bdate,
                        currency_id         = l_row.currency_id,
                        credit_purpose      = l_row.cig_14,
                        negative_status     = l_row.cig_16,
                        application_date    = l_row.start_date,
                        exp_end_date        = l_row.end_date,
                        fact_end_date       = l_row.dazs,
                        branch              = l_row.branch,
                        cust_id             = l_custid,
                        upd_date            = sysdate,
                        branch_dog          = l_row.branch_dog
                  where nd = l_row.nd
                    and contract_type = l_row.contract_type
                 returning id into l_id;

                 if (sql%rowcount != 0) then
                   upd_syncdata(l_id, l_row.branch, G_DOGDATA);

                   --������ � ������
                   add_event(G_WITHOUT_ERRORS,
                             bars_msg.get_msg(g_module_name,
                                              'DOG_UPDATED',
                                              (case when p_dtype = 3 then
                                               '(���)' when p_dtype = 4 then
                                               '(���������)' else '' end),
                                              to_char(l_row.nd)),
                             null,
                             l_row.nd,
                             l_row.rnk,
                             l_row.custtype,
                             p_dtype);
                   bars_audit.trace('%s: cur_dog_general record updated, nd=%s, p_dtype=%s',
                                    l_th,
                                    to_char(l_row.nd),
                                    to_char(p_dtype));
                   update v_cig_dog_stop st
                      set st.branch = l_row.branch
                    where st.dog_id = l_id;

                 else

                 begin
                   select s_cig_dog_general.nextval into l_id from dual;

                   -- ���� ������ ���������  - ���������
                   insert into V_CIG_DOG_GENERAL
                     (id,
                      nd,
                      cust_id,
                      phase_id,
                      operation,
                      pay_method_id,
                      pay_period_id,
                      contract_type,
                      contract_code,
                      contract_date,
                      contract_start_date,
                      currency_id,
                      credit_purpose,
                      negative_status,
                      application_date,
                      exp_end_date,
                      fact_end_date,
                      upd_date,
                      branch,
                      branch_dog)
                   values
                     (l_id,
                      l_row.nd,
                      l_custid,
                      l_row.cig_15,
                      1,
                      l_row.cig_19,
                      l_row.cig_18,
                      l_row.contract_type,
                      l_row.nd,
                      l_row.start_date,
                      l_row.bdate,
                      l_row.currency_id,
                      l_row.cig_14,
                      l_row.cig_16,
                      l_row.start_date,
                      l_row.end_date,
                      l_row.dazs,
                      sysdate,
                      l_row.branch,
                      l_row.branch_dog);
                  exception 
                    when others  then
                     bars_audit.info ('cig_mgr.prc_dog_general insert: l_custid :'||l_custid||' l_row.branch: '||l_row.branch||'\l_row.nd:'||l_row.nd||' : '|| sqlerrm);
                     
                     
                 end;
                   upd_syncdata(l_id, l_row.branch, G_DOGDATA);
    --������ � ������
                   add_event(G_WITHOUT_ERRORS,
                             bars_msg.get_msg(g_module_name,
                                              'DOG_INSERTED',
                                              (case when p_dtype = 3 then
                                               '(���)' when p_dtype = 4 then
                                               '(���������)' else '' end),
                                              to_char(l_row.nd)),
                             null,
                             l_row.nd,
                             l_row.rnk,
                             l_row.custtype,
                             p_dtype);
                  
                 bars_audit.trace('%s: V_CIG_DOG_GENERAL inserted, nd=%s, p_dtype=%s',
                                    l_th,
                                    to_char(l_row.nd),
                                    to_char(p_dtype));

                 end if;
                 -- ���
                 if ((p_dtype = G_CONTRACT_BPK) or
                    (p_dtype = G_CONTRACT_OVR)) then
                   l_step := 2;
                   if (trunc(l_row.dazs) <= trunc(sysdate)) then
                     -- ��� �������� �������� ��� ���������/��������� ������ � ��������� �� ���������� ���������� �� �������� � ��������� ��� (������ COBUSUPABS-3290)
                     -- l_count = 0 - ������ �������� ��������, 1 - ���������� ��� ������������

                    select count(m.nd)
                       into l_count
                     from v_cig_dog_sync_params m
                     where m.nd = l_row.nd
                       and m.data_type = p_dtype;

                     -- ���� ������ - ���������
                     if (l_count = 0) then
                       insert into v_cig_dog_sync_params values
                         (l_row.nd, f_ourmfo, p_dtype, 1, 1);
                     end if;
                     prc_dog_bpk(l_id, l_row, p_date, old_branch);
                   else
                     prc_dog_bpk(l_id, l_row, p_date, old_branch);
                   end if;
                 else
                   if ((l_row.contract_type = G_CONTRACT_GRNT) or
                      ((p_dtype = 6) and
                      (l_row.contract_type = G_CONTRACT_MBK_NI))) then
                     l_step := 2;
                     prc_dog_noninst(l_id,
                                     l_row.branch,
                                     l_row.nd,
                                     l_row.limit_sum,
                                     l_row.res_sum,
                                     l_row.start_date,
                                     p_date,
                                     l_row.a8_acc,
                                     l_row.a8_kv,
                                     old_branch,
                                     l_row.contract_type);
                   elsif ((p_dtype = 6) and
                         (l_row.contract_type = G_CONTRACT_MBK_CR)) then
                     l_step := 2;
                     prc_dog_credit(l_id,
                                    l_row.branch,
                                    l_row.nd,
                                    l_row.start_date,
                                    p_date,
                                    l_row.a8_acc,
                                    l_row.a8_kv,
                                    old_branch);
                     -- ����������� ������
                   elsif ((l_row.contract_type = G_CONTRACT_INSTALMENT) and
                         (p_dtype = 1)) then
                     l_step := 2;
                     prc_dog_inst(l_id,
                                  l_row.branch,
                                  l_row.nd,
                                  l_row.start_date,
                                  p_date,
                                  l_row.a8_acc,
                                  l_row.a8_kv,
                                  old_branch);
                     -- ��������� �����
                   elsif (((l_row.contract_type = G_CONTRACT_CREDIT) and
                         (p_dtype = 1)) or
                         ((p_dtype = 6) and
                         (l_row.contract_type = G_CONTRACT_MBK_CR))) then
                     l_step := 2;
                     prc_dog_credit(l_id,
                                    l_row.branch,
                                    l_row.nd,
                                    l_row.start_date,
                                    p_date,
                                    l_row.a8_acc,
                                    l_row.a8_kv,
                                    old_branch);
                   end if;
                   --������ � ������
                   add_event(G_WITHOUT_ERRORS,
                             bars_msg.get_msg(g_module_name,
                                              'DOG_FULL_INS',
                                              (case when p_dtype = 3 then
                                               '(���)' when p_dtype = 4 then
                                               '(���������)' else '' end),
                                              to_char(l_row.nd)),
                             null,
                             l_row.nd,
                             l_row.rnk,
                             l_row.custtype,
                             p_dtype);
                   l_step := 3;
                   if (trunc(l_row.dazs) <= trunc(sysdate)) then
                     if (p_dtype = 1) then
                       -- �������� ���-�� ���������� ������ 1 ���
                       update mos_operw o
                          set o.value = '-1'
                        where o.nd = l_row.nd
                          and tag = 'CIG_D13';
                     end if;
                   end if;
                 end if;
                 --exception
                 --end;
               end if;
               --exception
             end;
           end if;
         end if;
         execute immediate 'set constraint FK_CIGCUSTCOMP_CIGCUSTOMERS immediate';
         execute immediate 'set constraint FK_CIGCUSTIND_CIGCUSTOMERS immediate';
         execute immediate 'set constraint FK_CIGDOGG_CIGCUSTOMERS immediate';
         execute immediate 'set constraint FK_CIGDOGINST_CIGDOGGENERAL immediate';
         execute immediate 'set constraint FK_CIGDOGCREDIT_CIGDOGGENERAL immediate';
       exception
         when others then
           rollback to sv_start;
           execute immediate 'set constraint FK_CIGCUSTCOMP_CIGCUSTOMERS immediate';
           execute immediate 'set constraint FK_CIGCUSTIND_CIGCUSTOMERS immediate';
           execute immediate 'set constraint FK_CIGDOGG_CIGCUSTOMERS immediate';
           execute immediate 'set constraint FK_CIGDOGINST_CIGDOGGENERAL immediate';
           execute immediate 'set constraint FK_CIGDOGCREDIT_CIGDOGGENERAL immediate';
           -- ����� ORA ������
           l_sqlerrm := substr(sqlerrm, 1, 4000);
           bars_audit.trace('%s: l_sqlerrm=%s', l_th, l_sqlerrm);

           -- ����� BARS ������
           if abs(sqlcode) > 20000 then
             l_errm := sqlerrm;
           else
             l_errm := get_error(sqlcode, sqlerrm);
           end if;

           bars_audit.trace('%s: l_errm=%s', l_th, l_errm);

           -- ������ � ������
           if (l_step = 1) then
             l_errm := bars_msg.get_msg(g_module_name,
                                        'DOG_INSUPD_ERR',
                                        (case
                                          when p_dtype = 3 then
                                           '(���)'
                                          when p_dtype = 4 then
                                           '(���������)'
                                          else
                                           ''
                                        end),
                                        to_char(l_row.nd));
           elsif (l_step = 2) then
             l_errm := bars_msg.get_msg(g_module_name,
                                        'DOG_FULL_INS_ERR',
                                        (case
                                          when p_dtype = 3 then
                                           '(���)'
                                          when p_dtype = 4 then
                                           '(���������)'
                                          else
                                           ''
                                        end),
                                        to_char(l_row.nd));
           end if;

           add_error(G_SYSERROR,
                     l_errm,
                     l_sqlerrm,
                     l_row.nd,
                     l_row.rnk,
                     l_row.custtype,
                     p_dtype);

           bars_audit.trace('%s: error text saved, rnk=%s',
                            l_th,
                            to_char(l_row.rnk));
       end;

     end loop;

     -- ������� ������
     close l_cursor;
     bars_audit.trace('%s:cur_dog_general closed', l_th);

     add_event(G_WITHOUT_ERRORS,
               bars_msg.get_msg(g_module_name,
                                'SYN�DOG_END_INNER',
                                (case when p_dtype = 3 then '(���)' when
                                 p_dtype = 4 then '(���������)' else '' end)),
               null,
               null,
               null,
               null,
               p_dtype);
     bars_audit.trace('%s: done', l_th);
   exception
     when others then
       bars_audit.trace('%s: error detected, sqlerrm:%s',
                        l_th,
                        substr(sqlerrm, 1, 256));

        bars_audit.info(dbms_utility.format_error_stack() || chr(10) ||dbms_utility.format_error_backtrace());



       if l_cursor%isopen then
         close l_cursor;
         bars_audit.trace('%s:cur_dog_general closed, done', l_th);
       end if;

       rollback to dg_start;

       -- ����� ORA ������
       l_sqlerrm := substr(sqlerrm, 1, 4000);
       bars_audit.trace('%s: l_sqlerrm=%s', l_th, l_sqlerrm);
       -- ����� BARS ������
       l_errm := get_error(sqlcode, sqlerrm);
       bars_audit.trace('%s: l_errm=%s', l_th, l_errm);

       add_error(G_SYSERROR, l_errm, l_sqlerrm, null, null);

   end prc_dog_general;

   --------------------------------------------------------------------------------
   -- prc_dog_data - ��������� ��� ����� ���. ���������� �� ��������� ���������
   --
   -- @p_date - ����, �� ������� ���������� ������
   --
   procedure prc_dog_data(p_date in date, p_kf varchar2) is
     l_th constant varchar2(100) := g_dbgcode || 'prc_dog_data';
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: p_date=%s', l_th, to_char(p_date, 'dd.mm.yyyy'));

     -- ������� ����
     bc.subst_mfo(p_kf);
         
     -- ����� ���� ������
     add_event(G_WITHOUT_ERRORS,
               bars_msg.get_msg(g_module_name, 'SYN�DOG_STARTED'), null);

     -- ������� ����� ���������� �� ���������
     dbms_application_info.set_module('prc_dog_general(1, p_date)', null);
     prc_dog_general(1, p_date);
     dbms_application_info.set_module('prc_dog_general(G_CONTRACT_BPK, p_date)', null);
     prc_dog_general(G_CONTRACT_BPK, p_date);
     dbms_application_info.set_module('prc_dog_general(G_CONTRACT_OVR, p_date)', null);
     prc_dog_general(G_CONTRACT_OVR, p_date);
     dbms_application_info.set_module('prc_dog_general(G_CONTRACT_GRNT, p_date)', null);
     prc_dog_general(G_CONTRACT_GRNT, p_date);
     dbms_application_info.set_module('prc_dog_general(6, p_date)', null);
     prc_dog_general(6, p_date);

     -- ������������ � ����
     bc.set_context;

     -- ���� ������ ��������
     add_event(G_WITHOUT_ERRORS,
               bars_msg.get_msg(g_module_name, 'SYN�DOG_END'),
               null);

     bars_audit.trace('%s: done', l_th);
   exception
     when others then
       -- ������������ � ����
       bc.set_context;
       -- ����������� ����������� ������ ������
       bars_audit.trace(sqlerrm);
       raise_application_error(-20000,
                               dbms_utility.format_error_stack() || chr(10) ||
                               dbms_utility.format_error_backtrace());
   end prc_dog_data;

   --------------------------------------------------------------------------------
   -- get_currbranch - ���������� g_currbranch
   --
   function get_currbranch return varchar2 is
   begin
     return g_currbranch;
   end;

   --------------------------------------------------------------------------------
   -- prc_dog_data - ��������� ��� ����� ���� ����������� ���������� (������� - ��������)
   --
   -- @p_date - ����, �� ������� ���������� ������
   --
   procedure collect_data(p_date in date, p_kf varchar2 ) is
     l_th constant varchar2(100) := g_dbgcode || 'collect_data';
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: p_date=%s', l_th, to_char(p_date, 'dd.mm.yyyy'));
     add_event(G_WITHOUT_ERRORS,
               bars_msg.get_msg(g_module_name, 'SYN�_START', body_version),
               null);
     begin
       update CIG_SHED_JOBS_STATE
         set last_start_date = this_start_date,
             this_start_date = sysdate,
             next_start_Date = ADD_MONTHS(TRUNC(SYSDATE,'MM'),+1),
             total_time = null,
             broken = 'N'
       where branch  = '/'||p_kf||'/';
       commit;

       prc_dog_data(p_date, p_kf);
     exception
       when others then
         add_event(G_SYSERROR,
                   bars_msg.get_msg(g_module_name, 'JOB_RUN_FAILED'),
                   sqlerrm);
          update CIG_SHED_JOBS_STATE
            set this_start_date = null,
                broken = 'Y',
                failures = failures +1
           where branch  = '/'||p_kf||'/';
     end;
     add_event(G_WITHOUT_ERRORS,
               bars_msg.get_msg(g_module_name, 'SYN�_END'),
               null);

     update CIG_SHED_JOBS_STATE
         set last_start_date = this_start_date,
             this_start_date = null,
             next_start_Date = ADD_MONTHS(TRUNC(SYSDATE,'MM'),+1),
             total_time = (sysdate - this_start_date) * 24*60*60,
             broken = 'N',
             failures = 0
       where branch  = '/'||p_kf||'/'
       and broken = 'N';
     bars_audit.trace('%s: done', l_th);
     commit work;
   end collect_data;

   --------------------------------------------------------------------------------
   -- job_run - ��������� ������� ����� ������
   --
   -- @p_job_id - ��� �������
   --
   procedure job_run(p_job_id in varchar2) is
     l_th constant varchar2(100) := g_dbgcode || 'job_run';
     l_is_run number;
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: p_job_id=%s', l_th, to_char(p_job_id));
     --dbms_job.run(job => p_job_id);
     select case when s.STATE = 'RUNING' then 1 else 0 end into l_is_run
     from sys.dba_scheduler_jobs s
     where job_name = (select  'CIG_PVBKI_MMFO_'||kf.kf from MV_KF kf  where kf.kf = f_ourmfo);
     if l_is_run != 1 then
     DBMS_SCHEDULER.run_job(p_job_id, false);
     add_event(G_WITHOUT_ERRORS,
               bars_msg.get_msg(g_module_name, 'JOB_RUN', null),
               null);
     else
       raise_application_error(-20001, '�������� '||p_job_id||' ��� ��������.');
     end if;
     bars_audit.trace('%s: done', l_th);
   end job_run;

   --------------------------------------------------------------------------------
   -- job_interval - �������� �������� ���������� �������
   --
   -- @p_job_id - ��� �������
   -- @p_interval - ��������
   --
   procedure job_interval(p_job_id in varchar2, p_interval in varchar2) is
     l_th constant varchar2(100) := g_dbgcode || 'job_int';
   begin
     bars_audit.trace('%s: entry point', l_th);
     bars_audit.trace('%s: p_job_id=%s, p_interval=%s',
                      l_th,
                      to_char(p_job_id),
                      p_interval);
     /* execute immediate 'select ' || p_interval || ' from dual'
       into l_res;
     dbms_job.interval(p_job_id, p_interval);
     dbms_job.next_date(p_job_id, l_res);*/

     DBMS_SCHEDULER.SET_ATTRIBUTE(name      => p_job_id,
                                  attribute => 'repeat_interval',
                                  value     => p_interval);

     bars_audit.trace('%s: done', l_th);
   end job_interval;

     -- ������� ����� �� ������������ ������ ��� ����� ��� �������� ������� ��� ���������� �� ����.
   -- http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-4381
  procedure create_job_cig_mmfo is

   begin
   null;
    /* for rec in (select m.kf from mv_kf m where not exists ( select j.job_name from DBA_SCHEDULER_JOBS j where j.job_name like 'CIG_PVBKI_MMFO_'||m.kf))

     loop
         begin
           sys.dbms_scheduler.create_job(job_name        => 'BARS.CIG_PVBKI_MMFO_'||rec.kf,
                                         job_type        => 'PLSQL_BLOCK',
                                         job_action      => 'begin bc.go('''||rec.kf||''');  cig_mgr.collect_data(sysdate,'''||rec.kf||'''); end;',
                                         start_date      => to_date(null),
                                         repeat_interval => 'Freq=Monthly;Interval=1;ByMonthDay=01;ByHour=00;ByMinute=01;BySecond=00',
                                         end_date        => to_date(null),
                                         job_class       => 'DEFAULT_JOB_CLASS',
                                         enabled         => TRUE,
                                         auto_drop       => false,
                                         comments        => '��������� ���� ������ ��� �������� � �����/����');
          exception when others then
                   if (sqlcode = -27477) then null;
                   else raise;
                    end if;
     end;
         end loop;*/

  end;

 begin
   -- Initialization
   select '/' || GetGlobalOption('MFO') || '/' into g_currbranch from dual;
 end cig_mgr;
/
 show err;
 
PROMPT *** Create  grants  CIG_MGR ***
grant EXECUTE                                                                on CIG_MGR         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CIG_MGR         to CIG_LOADER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cig_mgr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 