PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ead_integration.sql =========*** Run
PROMPT ===================================================================================== 

CREATE OR REPLACE PACKAGE BARS.EAD_INTEGRATION IS
   g_header_version   CONSTANT VARCHAR2 (64) := 'version  Rel-43 3.1 04.06.2018 MMFO';
   g_type_id  object_type.id%type;
   g_state_id number;

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;
   /*ТОЛЬКО ДЛЯ МЕТОДА SetDocumentData (функция get_Doc_Instance) в связи с внедрением ДКБО и печатных документов к нему, требуется определять тип сделки и тип счета по ead_docs*/
   function get_agr_type(p_agr_id in EAD_DOCS.AGR_ID%type) return varchar2;
   function get_acc_type(p_agr_id in EAD_DOCS.AGR_ID%type, p_acc in EAD_DOCS.acc%type) return varchar2;
   procedure get_dkbo_settings(l_type_id out object_type.id%type,  l_state_id out number);
  procedure get_dkbo(p_acc         in accounts.acc%type,
                     p_id          out deal.id%type,
                     p_deal_number out deal.deal_number%type,
                     p_start_date  out deal.start_date%type,
                     p_state_id    out deal.state_id%type);
 
function ead_nbs_check_param  (p_nbs  varchar2, -- можно передавать как nbs так и nls
                               p_tip  varchar2,
                               p_ob22 varchar2 ) return number;                     
   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Dict.GetData
   -----------------------------------------------------------------------
   TYPE Data_Branch_Rec IS RECORD
   (
      Code         branch.branch%TYPE,
      Name         branch.name%TYPE,
      Close_Date   DATE
   );

   TYPE Data_Branch_Set IS TABLE OF Data_Branch_Rec;

   FUNCTION get_Data_Branch
      RETURN Data_Branch_Set
      PIPELINED;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Doc.GetInstance
   -----------------------------------------------------------------------
   TYPE Doc_Instance_Rec IS RECORD
   (
      rnk                   customer.rnk%TYPE,
      doc_type              ead_docs.ea_struct_id%TYPE,
      doc_id                ead_docs.id%TYPE,
      doc_pages_count       ead_docs.page_count%TYPE,
      doc_binary_data       ead_docs.scan_data%TYPE,
      doc_request_number    CUST_REQUESTS.REQ_ID%TYPE,
      agr_code              ead_docs.agr_id%TYPE,
      agr_type              ead_nbs.agr_type%type,
      account_type          varchar2(50), -- размерность 50 - от себя
      account_number        accounts.nls%TYPE,
      account_currency      accounts.kv%TYPE,
      created               ead_docs.crt_date%TYPE,
      changed               ead_docs.crt_date%TYPE,
      user_login            staff$base.logname%TYPE,
      user_fio              staff$base.fio%TYPE,
      branch_id             ead_docs.crt_branch%TYPE,
      linkedrnk             NUMBER
   );

   TYPE Doc_Instance_Set IS TABLE OF Doc_Instance_Rec;

  -- Основной метод передачи сканкопий и тикетов для вызова из EADService.cs
  FUNCTION get_Doc_Instance(p_doc_id ead_docs.id%TYPE) RETURN Doc_Instance_Set PIPELINED;
  -- (Доп метод)Сканкопии по депозитам и не только...
  FUNCTION get_DocAll_Instance(p_doc_id ead_docs.id%TYPE) RETURN Doc_Instance_Set PIPELINED;
  -- (Доп метод)Сканкопии по зарплатным проектам
  FUNCTION get_DocSalary_Instance(p_doc_id ead_docs.id%TYPE) RETURN Doc_Instance_Set PIPELINED;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Client.GetInstance
   -----------------------------------------------------------------------
   TYPE Client_Instance_Rec IS RECORD
   (
      rnk               customer.rnk%TYPE,
      changed           DATE,
      created           DATE,
      branch_id         customer.branch%TYPE,
      user_login        staff$base.logname%TYPE,
      user_fio          staff$base.fio%TYPE,
      client_type       custtype.custtype%TYPE,
      fio               customer.nmk%TYPE,
      inn               customer.okpo%TYPE,
      birth_date        person.bday%TYPE,
      document_type     person.passp%TYPE,
      document_series   person.ser%TYPE,
      document_number   person.numdoc%TYPE
   );

   TYPE Client_Instance_Set IS TABLE OF Client_Instance_Rec;

   FUNCTION get_Client_Instance (p_rnk customer.rnk%TYPE)
      RETURN Client_Instance_Set
      PIPELINED;

   TYPE MergedRNK_Rec IS RECORD (mrg_rnk rnk2nls.rnkfrom%TYPE);

   TYPE MergedRNK_Set IS TABLE OF MergedRNK_Rec;

   FUNCTION get_MergedRNK (p_rnk customer.rnk%TYPE)
      RETURN MergedRNK_Set
      PIPELINED;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.UClient.GetInstance
   -----------------------------------------------------------------------

   TYPE UClient_Instance_Rec IS RECORD
   (
     branch_id                branch.branch%TYPE,
     rnk                      customer.rnk%TYPE,
     changed                  DATE,
     created                  DATE,
     client_type              custtype.custtype%TYPE,
     client_name              customer.nmk%TYPE,
     inn_edrpou               customer.okpo%TYPE,
     user_login               staff$base.logname%TYPE,
     user_fio                 staff$base.fio%TYPE,
     actualized_by_user_fio   staff$base.fio%TYPE,
     actualized_by_user_login staff$base.logname%TYPE,
     actualized_by_branch_id  staff$base.branch%TYPE,
     actualized_date          customer_update.chgdate%TYPE
   );

   TYPE UClient_Instance_Set IS TABLE OF UClient_Instance_Rec;

   FUNCTION get_UClient_Instance (p_rnk customer.rnk%TYPE)
      RETURN UClient_Instance_Set
      PIPELINED;

   TYPE Third_Person_Client_Rec IS RECORD
   (
      rnk                 customer_rel.rel_rnk%TYPE,
      personstateid       customer_rel.rel_id%TYPE,
      date_begin_powers   customer_rel.bdate%TYPE,
      date_end_powers     customer_rel.edate%TYPE
   );

   TYPE Third_Person_Client_Set IS TABLE OF Third_Person_Client_Rec;

   FUNCTION get_Third_Person_Client_Set (p_rnk customer.rnk%TYPE)
      RETURN Third_Person_Client_Set
      PIPELINED;

   TYPE Third_Person_NonClient_Rec IS RECORD
   (
      id                  customer_rel.rnk%TYPE,
      personstateid       customer_rel.rel_id%TYPE,
      name                customer_extern.name%TYPE,
      client_type         custtype.custtype%TYPE,
      inn_edrpou          customer.okpo%TYPE,
      date_begin_powers   customer_rel.bdate%TYPE,
      date_end_powers     customer_rel.edate%TYPE
   );

   TYPE Third_Person_NonClient_Set IS TABLE OF Third_Person_NonClient_Rec;

   FUNCTION get_Third_Person_NonClient_Set (p_rnk customer.rnk%TYPE)
      RETURN Third_Person_NonClient_Set
      PIPELINED;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Agr.GetInstance
   -----------------------------------------------------------------------
   TYPE AgrDPT_Instance_Rec IS RECORD
   (  rnk              customer.rnk%TYPE,
      parent_agr_type  varchar2(50),           -- это поле заполняется типом dkbo_fo только для депозитов онлайн
      parent_agr_code  deal.deal_number%type, -- это поле заполняется номером ДКБО только для депозитов онлайн
      agr_type         ead_nbs.agr_type%type,
      agr_code         dpt_deposit_clos.deposit_id%TYPE,
      agr_number       dpt_deposit_clos.nd%TYPE,
      agr_status       SMALLINT,
      agr_date_open    dpt_deposit_clos.dat_begin%TYPE,
      agr_date_close   dpt_deposit_clos.bdate%TYPE,
      created          DATE,
      changed          DATE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      branch_id        branch.branch%TYPE
   );

   TYPE AgrDPT_Instance_Set IS TABLE OF AgrDPT_Instance_Rec;

   FUNCTION get_AgrDPT_Instance_Set (p_agr_id dpt_deposit.deposit_id%TYPE)
      RETURN AgrDPT_Instance_Set
      PIPELINED;

   TYPE AgrDPT_LinkedRnk_Rec IS RECORD
   (
      rnk                 customer.rnk%TYPE,
      linkpersonstateid   SMALLINT
   );

   TYPE AgrDPT_LinkedRnk_Set IS TABLE OF AgrDPT_LinkedRnk_Rec;

   FUNCTION get_AgrDPT_LinkedRnk_Set (p_agr_id dpt_deposit.deposit_id%TYPE)
      RETURN AgrDPT_LinkedRnk_Set
      PIPELINED;

   TYPE AgrBPK_Instance_Rec IS RECORD
   (
      rnk              customer.rnk%TYPE,
      parent_agr_type  varchar2(50),           -- это поле заполняется типом dkbo_fo только для депозитов онлайн
      parent_agr_code  deal.DEAL_NUMBER%type, -- это поле заполняется номером ДКБО только для депозитов онлайн
      agr_type         ead_nbs.agr_type%type,
      agr_code         dpt_deposit_clos.deposit_id%TYPE,
      agr_number       dpt_deposit_clos.nd%TYPE,
      agr_status       SMALLINT,
      agr_date_open    dpt_deposit_clos.dat_begin%TYPE,
      agr_date_close   dpt_deposit_clos.bdate%TYPE,
      created          DATE,
      changed          DATE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      branch_id        branch.branch%TYPE
   );

   TYPE AgrBPK_Instance_Set IS TABLE OF AgrBPK_Instance_Rec;

   FUNCTION get_AgrBPK_Instance_Set (p_agr_id w4_acc_update.nd%TYPE)
      RETURN AgrBPK_Instance_Set
      PIPELINED;
  ---- DKBO 22/05/2017
   TYPE AgrDKBO_Instance_Rec IS RECORD
   (  rnk              customer.rnk%TYPE,
      parent_agr_type  varchar(50),           -- это поле заполняется типом dkbo_fo только для депозитов онлайн
      parent_agr_code  deal.DEAL_NUMBER%type, -- это поле заполняется номером ДКБО только для депозитов онлайн
      agr_type         ead_nbs.agr_type%type,
      agr_code         deal.id%TYPE,
      agr_number       deal.deal_number%TYPE,
      agr_status       SMALLINT,
      agr_date_open    deal.START_DATE%TYPE,
      agr_date_close   deal.CLOSE_DATE%TYPE,
      created          DATE,
      changed          DATE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      branch_id        branch.branch%TYPE
   );

   TYPE AgrDKBO_Instance_Set IS TABLE OF AgrDKBO_Instance_Rec;

   FUNCTION get_AgrDKBO_Instance_Set (p_agr_id deal.id%TYPE)
      RETURN AgrDKBO_Instance_Set
      PIPELINED;


   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.UAgr.GetInstance
   -----------------------------------------------------------------------
   TYPE UAgrDPU_Instance_Rec IS RECORD
   (

      rnk              customer.rnk%TYPE,
      agr_type         ead_nbs.agr_type%type,
      agr_code         varchar2(50),
      agr_number       dpu_deal.nd%TYPE,
      agr_status       SMALLINT,
      agr_date_open    dpu_deal.datz%TYPE,
      agr_date_close   DATE,
      created          DATE,
      changed          DATE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      branch_id        branch.branch%TYPE
   );

   TYPE UAgrDPU_Instance_Set IS TABLE OF UAgrDPU_Instance_Rec;

   FUNCTION get_UAgrDPU_Instance_Set (p_dpu_id dpu_deal.dpu_id%TYPE)
      RETURN UAgrDPU_Instance_Set
      PIPELINED;

   TYPE UAgrACC_Instance_Rec IS RECORD
   (

      rnk              customer.rnk%TYPE,
      agr_type         ead_nbs.agr_type%type,
      agr_code         specparam.nkd%TYPE,
      agr_number       specparam.nkd%TYPE,
      agr_status       SMALLINT,
      agr_date_open    accounts.daos%TYPE,
      agr_date_close   accounts.dazs%TYPE,
      created          DATE,
      changed          DATE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      branch_id        branch.branch%TYPE
   );

   TYPE UAgrACC_Instance_Set IS TABLE OF UAgrACC_Instance_Rec;

   FUNCTION get_UAgrACC_Instance_Set (p_acc accounts.acc%TYPE)
      RETURN UAgrACC_Instance_Set
      PIPELINED;
   FUNCTION get_UAgrACCRsrv_Instance_Set(p_rsrv_id accounts_rsrv.rsrv_id%type) return UAgrACC_Instance_Set pipelined;


   TYPE UAgrDPTOLD_Instance_Rec IS RECORD
   (
      agr_code         specparam.nkd%TYPE,
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         ead_nbs.agr_type%type,
      agr_status       SMALLINT,
      agr_number       specparam.nkd%TYPE,
      agr_date_open    accounts.daos%TYPE,
      agr_date_close   accounts.dazs%TYPE
   );

   TYPE UAgrDPTOLD_Instance_Set IS TABLE OF UAgrDPTOLD_Instance_Rec;

   FUNCTION get_UAgrDPTOLD_Instance_Set (p_nls     accounts.nls%TYPE,
                                         p_daos    accounts.daos%TYPE,
                                         p_acc     accounts.acc%TYPE)
      RETURN UAgrDPTOLD_Instance_Set
      PIPELINED;
   TYPE UAgrDBO_Instance_Rec IS RECORD
   (
      agr_code         varchar2(100),
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         ead_nbs.agr_type%type,
      agr_status       int,
      agr_number       varchar2(100),
      agr_date_open    accounts.daos%TYPE,
      agr_date_close   accounts.dazs%TYPE
   );

   TYPE UAgrDBO_Instance_Set IS TABLE OF UAgrDBO_Instance_Rec;

   FUNCTION get_UAgrDBO_Instance_Set (p_rnk customer.rnk%TYPE)
      RETURN UAgrDBO_Instance_Set
      PIPELINED;

   TYPE UAgrSalary_Instance_Rec IS RECORD
   (
      rnk              customer.rnk%TYPE,
      agr_type         ead_nbs.agr_type%type,
      agr_code         zp_deals.id%type,
      agr_number       zp_deals.deal_id%type,
      agr_status       number,
      agr_date_open    date,
      agr_date_close   date,
      created          date,
      changed          date,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      branch_id        branch.branch%TYPE
   );

   TYPE UAgrSalary_Instance_Set IS TABLE OF UAgrSalary_Instance_Rec;

   FUNCTION get_UAgrSalary_Instance_Set (p_id zp_deals.id%TYPE,p_status varchar2)
      RETURN UAgrSalary_Instance_Set
      PIPELINED;

    function get_AgrBPKcodes_Set(p_agr_id deal.id%type, p_acc_list string) return number_list pipelined;
   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Acc.GetInstance
   -----------------------------------------------------------------------
   TYPE UACC_Instance_Rec IS RECORD
   (
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      account_number   accounts.nls%TYPE,
      currency_code    accounts.kv%TYPE,
      mfo              banks.mfo%TYPE,
      branch_id        accounts.branch%TYPE,
      open_date        accounts.daos%TYPE,
      close_date       accounts.dazs%TYPE,
      account_status   SMALLINT,
      agr_number       specparam.nkd%TYPE,
      agr_code         VARCHAR2 (500),
      account_type     VARCHAR2 (500),
      agr_type         ead_nbs.agr_type%type,
      remote_controled number(1)
   );

   TYPE UACC_Instance_Set IS TABLE OF UACC_Instance_Rec;
   function get_UACC_Instance_Set (p_agr_type string, p_acc accounts.acc%type) return UACC_Instance_Set pipelined;
   function get_UACCRsrv_Instance_Set (p_agr_type string, p_rsrv_id accounts_rsrv.rsrv_id%type) return UACC_Instance_Set pipelined;

  TYPE ACC_Instance_Rec IS RECORD(
    rnk                       customer.rnk%TYPE,
    agr_type                  ead_nbs.agr_type%type,
    agr_code                  VARCHAR2(500),
    agr_number                specparam.nkd%TYPE,
    account_type              VARCHAR2(500),
    account_number            accounts.nls%TYPE,
    account_currency          accounts.kv%TYPE,
    account_mfo               banks.mfo%TYPE,
    account_open_date         accounts.daos%TYPE,
    account_close_date        accounts.dazs%TYPE,
    account_status            SMALLINT,
    account_is_remote_control number(1),
    created                   DATE,
    changed                   DATE,
    user_login                staff$base.logname%TYPE,
    user_fio                  staff$base.fio%TYPE,
    branch_id                 accounts.branch%TYPE);

   TYPE ACC_Instance_Set IS TABLE OF ACC_Instance_Rec;
   FUNCTION get_ACC_Instance_Set (p_agr_type varchar2,
                                  p_acc     accounts.acc%TYPE)
      RETURN ACC_Instance_Set
      PIPELINED;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Act.GetInstance
   -----------------------------------------------------------------------
-----------------------------------------------------------------------
   TYPE Act_Instance_Rec IS RECORD
   (
      rnk              customer.rnk%TYPE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      actual_date      date
   );

   TYPE Act_Instance_Set IS TABLE OF Act_Instance_Rec;
   FUNCTION get_Act_Instance_Rec (p_rnk customer.rnk%TYPE)
      RETURN Act_Instance_Set
      PIPELINED;
   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.GercClient.GetInstance!!!
   -----------------------------------------------------------------------

END ead_integration;
/
show errors



CREATE OR REPLACE PACKAGE BODY BARS.EAD_INTEGRATION IS
   g_body_version constant varchar2(64) := 'version 3.0 01.02.2018 MMFO';

   type TAccAgrParam is record
   (
     agr_code  specparam.nkd%type,
     agr_number  string(50),
     acc_type  string(50),
     agr_type  ead_nbs.agr_type%type,
     agr_date  string(50),
     agr_status  number,
--     p_parent_agr_code out varchar2,
     parent_agr_type string(50)
   );
   rAccAgrParam TAccAgrParam;

   procedure "~*~*~*~ Auxiliarius ~*~*~*~" is begin null; end;

   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body ead_integration ' || g_body_version;
   END body_version;


   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body ead_integration ' || g_body_version;
   END header_version;

  FUNCTION SPLIT_KEY(p_key in string, p_kf in string default null) return string is
    l_ru char(2);
  begin
    select nvl2(p_kf, max(kf_ru.ru), substr(p_key, -2, 2)) into l_ru from kf_ru where kf = p_kf;
    return regexp_replace(p_key, l_ru || '\Z');
  end SPLIT_KEY;

   function get_agr_type(p_agr_id in EAD_DOCS.AGR_ID%type) return varchar2 is
     l_res varchar2(50) := null;
   begin
     -- 1 ищем в депозитах
     begin
       select decode(wb, 'Y', 'dep_online_fo', 'deposit') into l_res from dpt_deposit_clos
        where action_id = 0 and deposit_id = p_agr_id;
/* при закрытии/расторжении запись удаляецо из dpt_deposit
       select decode(wb, 'N', 'deposit', 'Y', 'dep_online_fo') into l_res
         from dpt_deposit
        where deposit_id = p_agr_id;
*/
     exception
       when no_data_found then
         -- 2 ищем в ДКБО
         begin
           select 'dkbo_fo' into l_res from deal d
            where D.DEAL_TYPE_ID = g_type_id
              and D.STATE_ID = g_state_id
              and d.id = p_agr_id;
         exception
           when no_data_found then
             l_res := null;
         end;
     end;
     return l_res;
   end get_agr_type;

   /*ТОЛЬКО ДЛЯ МЕТОДА SetDocumentData (функция get_Doc_Instance) в связи с внедрением ДКБО и печатных документов к нему, требуется определять тип сделки и тип счета по ead_docs*/
   function get_acc_type(p_agr_id in EAD_DOCS.AGR_ID%type, p_acc in EAD_DOCS.acc%type) return varchar2
   is
   l_res varchar2(50) := null;
   l_agr_type ead_nbs.agr_type%type;
   begin
    l_agr_type := get_agr_type(p_agr_id);

     if (l_agr_type is null or l_agr_type in ('dkbo_fo'))
     then
      begin
       select case when nbs = '2625' then 'bpk_fo' end
         into l_res
         from accounts
        where acc= p_acc;
      exception when no_data_found then l_res := null;
      end;
     elsif (l_agr_type in ('deposit', 'dep_online_fo'))
     then
      l_res := l_agr_type;
     end if;

    return l_res;
   end get_acc_type;

   procedure get_dkbo_settings(l_type_id out object_type.id%type,  l_state_id out number) is
      invalid_identifier_state_id exception;
      pragma exception_init(invalid_identifier_state_id, -904);
      
      
      l_sql_template    varchar2(500) := 
                        q'#
                     FROM object_type ot,  object_state os
                    WHERE ot.type_code = 'DKBO'
                      and OT.ID = OS.OBJECT_TYPE_ID
                      and OS.STATE_CODE = 'CONNECTED'#';
  
   begin

     /* -- старый код + нижний exception
      SELECT ot.id, os.state_id
       into l_type_id, l_state_id
       FROM object_type ot,  object_state os
      WHERE ot.type_code = 'DKBO'
        and OT.ID = OS.OBJECT_TYPE_ID
        and OS.STATE_CODE = 'CONNECTED';
        */
   
      -- зависимости между разработками
      -- сделали рефакторинг OBJECT_STATE, но не понятно когда релиз
       
      -- оставляем для dependency (запрос пустышка) 
      SELECT max(null)
        into l_type_id      
        FROM object_type ot,  object_state os
       WHERE ot.type_code = 'DKBO'
         and OT.ID = OS.OBJECT_TYPE_ID
         and OS.STATE_CODE = 'CONNECTED'
         and 1 = 0; -- 
       
        begin
            -- попытка выполнить запрос с возвращением поля STATE_ID из OBJECT_STATE
            execute immediate 'SELECT ot.id, os.state_id '||
                              l_sql_template  
              into l_type_id, l_state_id;
            -- выполнилось без ошибки выходим   
            return;  
        exception
           when invalid_identifier_state_id then
              null;
           when others then
              raise;  
        end;
        begin
            -- попытка выполнить запрос с возвращением поля ID из OBJECT_STATE
            execute immediate 'SELECT ot.id, os.id state_id '||
                              l_sql_template
              into l_type_id, l_state_id;
            return;  
        exception
           when invalid_identifier_state_id then
              null;
           when others then
              raise;  
        end;
   exception when no_data_found then
      bars_audit.error('EBP.GET_ARCHIVE_DKBO_DOCID : Не описаний тип/статуси угоди ДКБО');
      when too_many_rows then
      bars_audit.error('EBP.GET_ARCHIVE_DKBO_DOCID : Не коректно описаний тип/статуси угоди ДКБО (дублювання налаштувань)');
   end get_dkbo_settings;

  procedure get_dkbo(p_acc         in accounts.acc%type,
                     p_id          out deal.id%type,
                     p_deal_number out deal.deal_number%type,
                     p_start_date  out deal.start_date%type,
                     p_state_id    out deal.state_id%type) is
   begin
        begin
      /*SELECT d.id, d.deal_number, d.start_date, d.state_id
        into p_id, p_deal_number, p_start_date, p_state_id
        FROM attribute_values avs
         JOIN
         (  SELECT MAX (t.nested_table_id)
                      KEEP (DENSE_RANK LAST ORDER BY t.value_date)
                      nested_table_id,
                   t.object_id,
                   t.attribute_id
              FROM ATTRIBUTE_VALUE_BY_DATE t
          GROUP BY t.object_id, t.attribute_id) av
            ON     av.nested_table_id = avs.nested_table_id
               AND av.attribute_id IN (SELECT id FROM attribute_kind WHERE attribute_code = 'DKBO_ACC_LIST')
         JOIN deal d ON d.id = av.object_id AND d.deal_type_id IN (select id from object_type where type_code = 'DKBO')
      where avs.number_values = p_acc;*/
        SELECT    MAX (d.id) KEEP (DENSE_RANK LAST ORDER BY av.value_date)  into p_id
              FROM attribute_values avs
                   JOIN
                   (  SELECT t.nested_table_id ,
                             t.object_id,
                             t.attribute_id,
                             t.value_date
                        FROM ATTRIBUTE_VALUE_BY_DATE t
                       WHERE t.attribute_id =
                                (SELECT ak.id
                                   FROM attribute_kind ak
                                  WHERE ak.attribute_code = 'DKBO_ACC_LIST')) av
                      ON     av.nested_table_id = avs.nested_table_id
                   JOIN deal d    ON     d.id = av.object_id AND d.deal_type_id IN (SELECT tt.id
                                                  FROM object_type tt
                                                 WHERE tt.type_code = 'DKBO')
                where avs.number_values =  p_acc;
        exception
            when no_data_found then
                null;
        end;
        
        begin
            SELECT  D.DEAL_NUMBER,
                    D.START_DATE ,
                    D.STATE_ID
            into    p_deal_number, p_start_date, p_state_id        
            from   deal d
            where d.ID = p_id;
        exception
            when no_data_found then
                null;
        end;
   end get_dkbo;
 
 function ead_nbs_check_param  (p_nbs  varchar2, -- можно передавать как nbs так и nls
                                p_tip  varchar2,
                                p_ob22 varchar2 ) return number is 
 l_nbs varchar2(14);  
 l_id  number(10);   
                      
begin
 l_nbs := substr(p_nbs,1,4); 
     begin 
   
 for rec in (select e.id,
                e.nbs,
                e.tip,
                e.ob22,
                case when e.tip is null and e.ob22 is null then e.id end clear , 
                count(e.nbs) over(partition by e.nbs ) coun
           from ead_nbs e
          where e.nbs = l_nbs
               
           )
 loop

     dbms_output.put_line(' 1 ->'||rec.id ); 
    if     nvl(rec.tip,'0')  = p_tip and nvl(rec.ob22,'0')  = p_ob22  then l_id:= rec.id ; 
    elsif nvl(rec.tip,'0')  = p_tip  and nvl(rec.ob22,'0') <> p_ob22 then l_id:= rec.id ; 
    elsif nvl(rec.tip,'0')  <> p_tip  and    nvl(rec.ob22,'0') = p_ob22 then l_id:= rec.id ;
    end if;      

 end loop;
 
  if l_id is null  then 
      select e.id
           into l_id  
           from ead_nbs e
          where e.nbs = l_nbs 
           and e.tip is null
           and e.ob22 is null;         
  end if; 
 
    return l_id;
       end;
end  ead_nbs_check_param;
 

    procedure get_accagr_param(p_acc in accounts.acc%type) is
        l_agr_type ead_nbs.agr_type%type;
        l_acc_type ead_nbs.acc_type%type;
        l_agr_status deal.state_id%type;
        l_NDBO varchar2(40);
        l_DDBO varchar2(50);
        l_SDBO varchar2(50);
        l_daos date;
        l_custtype customer.custtype%type;
        l_rnk      customer.rnk%type;
        l_nbs      accounts.nbs%type;
        l_acc_2625 accounts.acc%type;
   begin
     rAccAgrParam := null;
      begin
            SELECT daos, rnk,
                   e.acc_type,
                   e.agr_type,
                   10, -- всегда в статусе проект
                   e.custtype,
                   nvl(a.nbs,substr(nls,1,4))
              into l_daos, l_rnk,
                   l_acc_type,
                   l_agr_type,
                   l_agr_status,
                   l_custtype,
                   l_nbs
              FROM accounts a, ead_nbs e
             WHERE a.acc  = p_acc
               and e.id   = ead_integration.ead_nbs_check_param(a.nls,substr(a.tip,1,2),a.ob22);
        end;

        -- Визначаємо статус угоди. По звичайним рахункам угода зберігається в SpecParam.
        -- Якщо існує хоча б один відкритий рахунок серед решти за номером угоди рахунку p_acc, тоді і статус угоди -1- відкрито,
        -- інакше залишаємо null для визначення по статусу рахунку p_acc у методі, котрий викликав цей

        select sign(max(a_rest.acc)) into l_agr_status
          from accounts a
          join specparam sp on a.acc = sp.acc
          join accounts a_rest on a.rnk = a_rest.rnk and a.acc != a_rest.acc  -- інші рахунки за клієнтом окрім p_acc
          join specparam sp_rest on a_rest.acc = sp_rest.acc and sp.nkd = sp_rest.nkd -- за однаковим номером угоди
         where a.acc = p_acc
           and lnnvl(a_rest.dazs < sysdate); -- тільки відкриті

      if (l_custtype = 2) -- для ДБО
      then
        l_NDBO := kl.get_customerw (l_rnk, 'NDBO');
        l_DDBO := kl.get_customerw (l_rnk, 'DDBO');
        l_SDBO := kl.get_customerw (l_rnk, 'SDBO');

        if (l_acc_type in ('pr_uo', 'kpk_uo') and l_SDBO is not null and l_NDBO is not null and l_daos >= to_date(replace(l_DDBO,'.','/'),'dd/mm/yyyy'))
        then
         rAccAgrParam.agr_date     := l_DDBO;
         rAccAgrParam.agr_code     := l_NDBO;
         l_agr_type     := 'dbo_uo';
         rAccAgrParam.agr_status   := l_agr_status;
        end if;
        rAccAgrParam.acc_type := l_acc_type;
        rAccAgrParam.agr_type := nvl(l_agr_type,l_acc_type);

      elsif (l_custtype = 3) then -- для ДКБО
       rAccAgrParam.acc_type := l_acc_type;
       rAccAgrParam.agr_type := l_agr_type;

       -- Если приезжает счет онлайн-депозита - определяем 2625 счет включенный в ДКБО
       select max(deposit_id) keep(dense_rank last order by idupd),
              max(acc_d) keep(dense_rank last order by idupd)
         into rAccAgrParam.agr_code, l_acc_2625
         from dpt_deposit_clos
        where acc = p_acc and wb = 'Y';

       get_dkbo(p_acc => nvl(l_acc_2625, p_acc), p_id => rAccAgrParam.agr_code, p_deal_number => rAccAgrParam.agr_number, p_start_date  => rAccAgrParam.agr_date, p_state_id  => rAccAgrParam.agr_status);
       --l_id - если счет не принадлежит ДКБО, то l_id будет пуст. Это признак наличия ДКБО
       if (rAccAgrParam.agr_code is not null and l_acc_type is not null) then
        rAccAgrParam.agr_type := 'dkbo_fo';
--        p_agr_code := l_id;
       elsif (rAccAgrParam.agr_code is not null and l_acc_type is null and l_nbs in ('2630','2635')) then
--         p_parent_agr_code := l_id;
        rAccAgrParam.parent_agr_type := 'dkbo_fo';
        rAccAgrParam.agr_type := 'dep_online_fo';
        rAccAgrParam.acc_type := 'dep_online_fo';
        -- Для счетов 2630, 2635 указываем код ИХ угоды, а не ДКБО
        select max(deposit_id) keep(dense_rank last order by idupd),
               max(nd) keep(dense_rank last order by idupd),
               max(kf) keep(dense_rank last order by idupd)
               into rAccAgrParam.agr_code, rAccAgrParam.agr_number, l_NDBO  -- dummy
               from dpt_deposit_clos where acc = p_acc;
        rAccAgrParam.agr_number := ead_integration.split_key(rAccAgrParam.agr_number, l_NDBO);
       elsif (rAccAgrParam.agr_code is null and l_acc_type is null and l_nbs in ('2630','2635')) then
        rAccAgrParam.agr_type := 'deposit';
        rAccAgrParam.acc_type := 'deposit';
        select max(deposit_id) keep(dense_rank last order by idupd),
               max(nd) keep(dense_rank last order by idupd),
               max(kf) keep(dense_rank last order by idupd)
               into rAccAgrParam.agr_code, rAccAgrParam.agr_number, l_NDBO  -- dummy
               from dpt_deposit_clos where acc = p_acc;
        rAccAgrParam.agr_number := ead_integration.split_key(rAccAgrParam.agr_number, l_NDBO);
       elsif (rAccAgrParam.agr_code is null and l_acc_type is not null) then
        rAccAgrParam.agr_type := 'bpk_fo';
        rAccAgrParam.acc_type := 'bpk_fo';
        select max(nd), max(kf) into rAccAgrParam.agr_code, l_NDBO  -- dummy
        from bars.w4_acc where acc_pk = p_acc;  -- max() as Workaround for no_data_found
        rAccAgrParam.agr_number := ead_integration.split_key(rAccAgrParam.agr_code, l_NDBO);
       end if;

      end if;
   end get_accagr_param;

    procedure get_accagr_param_reserve(p_rsrv_id accounts_rsrv.rsrv_id%type) is
        l_agr_type ead_nbs.agr_type%type;
        l_acc_type ead_nbs.acc_type%type;
        l_agr_status deal.state_id%type;
        l_NDBO varchar2(40);
        l_DDBO varchar2(50);
        l_SDBO varchar2(50);
        l_daos date;
        l_custtype customer.custtype%type;
        l_rnk      customer.rnk%type;
        l_nbs      accounts.nbs%type;
        l_acc_2625 accounts.acc%type;
   begin
     rAccAgrParam := null;
            select trunc(a.crt_dt),
                   trunc(a.crt_dt),
                   a.agrm_num,
                   rnk,
                   e.acc_type,
                   e.agr_type,
                   10,
                   e.custtype,
                   substr(nls,1,4)
              into l_daos,
                   rAccAgrParam.agr_date,
                   rAccAgrParam.agr_code,
                   l_rnk,
                   l_acc_type,
                   l_agr_type,
                   rAccAgrParam.agr_status,
                   l_custtype,
                   l_nbs
              from accounts_rsrv a, ead_nbs e
             where a.rsrv_id = p_rsrv_id
               and e.id      = ead_integration.ead_nbs_check_param(a.nls,null,a.ob22);

      if (l_custtype = 2) -- для ДБО
      then
        l_NDBO := kl.get_customerw (l_rnk, 'NDBO');
        l_DDBO := kl.get_customerw (l_rnk, 'DDBO');
        l_SDBO := kl.get_customerw (l_rnk, 'SDBO');

        if (l_acc_type in ('pr_uo', 'kpk_uo') and l_SDBO is not null and l_NDBO is not null and l_daos >= to_date(replace(l_DDBO,'.','/'),'dd/mm/yyyy')) then
         rAccAgrParam.agr_date     := l_DDBO;
         rAccAgrParam.agr_code     := l_NDBO;
         l_agr_type     := 'dbo_uo';
        end if;
        rAccAgrParam.acc_type := l_acc_type;
        rAccAgrParam.agr_type := nvl(l_agr_type,l_acc_type);
      end if;

   end get_accagr_param_reserve;

    procedure get_rnkagr_param(p_rnk        in customer.rnk%type,
                               p_agr_code   out specparam.nkd%type,
                               p_agr_type   out varchar2,
                               p_agr_date   out varchar2,
                               p_agr_status out number) is
    begin
      p_agr_code := kl.get_customerw(p_rnk, 'NDBO');
      p_agr_date := kl.get_customerw(p_rnk, 'DDBO');
      p_agr_type := 'dbo_uo';

      select count(acc) into p_agr_status
        from accounts
       where rnk = p_rnk
         and ead_pack.get_acc_info(acc) = 1
         and nbs is not null;

      p_agr_status := tools.iif(p_agr_status = 0 or kl.get_customerw(p_rnk, 'SDBO') is null, 10 /*проект*/, 1 /*открытый*/);

    end get_rnkagr_param;


   procedure "~*~*~*~*~ Mainframe ~*~*~*~*~" is begin null; end;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Dict.GetData
   -----------------------------------------------------------------------
   FUNCTION get_Data_Branch
      RETURN Data_Branch_Set
      PIPELINED
   IS
      l_Data_branch_rec   Data_Branch_Rec;
   BEGIN
      FOR i IN (  SELECT b.branch AS code, b.name, b.date_closed AS close_date
                    FROM branch b
                ORDER BY b.branch)
      LOOP
         l_Data_branch_rec.code := i.code;
         l_Data_branch_rec.name := i.name;
         l_Data_branch_rec.Close_Date := i.Close_date;
         PIPE ROW (l_Data_branch_rec);
      END LOOP;
   END;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Doc.GetInstance
   -----------------------------------------------------------------------

  -- Основной метод передачи сканкопий и тикетов для вызова из EADService.cs
  function get_Doc_Instance(p_doc_id ead_docs.id%type) return Doc_Instance_Set pipelined is
    l_Doc_Instance_Rec Doc_Instance_Rec;
    l_ea_struct_id ead_docs.ea_struct_id%type;
  begin
    select ea_struct_id into l_ea_struct_id from ead_docs where id = p_doc_id;

    if l_ea_struct_id like ('001%') then
      -- Зарплата (ЮрЛица, первые сканы...)
      select * into l_Doc_Instance_Rec from table(get_DocSalary_Instance(p_doc_id));
    else
      select * into l_Doc_Instance_Rec from table(get_DocAll_Instance(p_doc_id));
    end if;

    pipe row(l_Doc_Instance_Rec);
  end get_Doc_Instance;

  -- Сканкопии по депозитам и не только...
  FUNCTION get_DocAll_Instance(p_doc_id ead_docs.id%TYPE) RETURN Doc_Instance_Set PIPELINED IS
    l_Doc_Instance_Rec Doc_Instance_Rec;
  BEGIN
    bc.go('/');

    FOR i IN (SELECT kf,
                     NVL(rnk, linkedrnk) as rnk,
                     ea_struct_id as doc_type,
                     id as doc_id,
                     NVL(page_count, 1) as doc_pages_count,
                     scan_data as doc_binary_data,
                     (CASE
                       WHEN ea_struct_id = '146' THEN
                        (SELECT max(T1.REQ_ID) FROM CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL(rnk, linkedrnk) AND T1.REQ_STATE = 0 and T1.REQ_TYPE = 0)
                       WHEN ea_struct_id in ('221', '222') and scan_data is not null THEN
                        (SELECT max(T1.REQ_ID) FROM bars.CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL(linkedrnk, rnk) and T1.REQ_TYPE in (1, 2))
--                       WHEN ea_struct_id in ('223', '224') THEN
                       WHEN ea_struct_id = '223' AND scan_data is not null or ea_struct_id = '224' THEN
                        (SELECT max(T1.REQ_ID) FROM bars.CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL(linkedrnk, rnk) and T1.REQ_TYPE in (1, 2))
                       WHEN ea_struct_id = '213' then
                        (SELECT max(T1.REQ_ID) FROM CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL(rnk, linkedrnk) AND T1.REQ_STATE = 0 and trunc(T1.REQ_BDATE) = gl.bd)
                       ELSE
                        null
                     END) as doc_request_number,
                     agr_id as agr_code,
                     get_agr_type(agr_id) as agr_type,
                     get_acc_type(agr_id, acc) as account_type,
                     nls as account_number,
                     kv as account_currency,
                     crt_date as created,
                     crt_date as changed,
                     logname as user_login,
                     fio as user_fio,
                     crt_branch as branch_id,
--                     CASE WHEN rnk <> linkedrnk THEN linkedrnk ELSE NULL END AS linkedrnk
                     nullif(linkedrnk, rnk) as linkedrnk
                FROM (SELECT d.kf,
                             d.id,
                             (select min(rnk) keep(dense_rank last order by idupd) from bars.dpt_deposit_clos dds where dds.deposit_id = d.agr_id) as rnk,
                             d.rnk AS linkedrnk,
                             d.agr_id,
                             sb.logname,
                             sb.fio,
                             d.crt_branch,
                             d.ea_struct_id,
                             d.crt_date,
                             d.page_count,
                             d.scan_data,
                             a.nls,
                             a.kv,
                             a.acc
                        FROM ead_docs d
                        left outer join accounts a on d.acc = a.acc
                        left outer join staff$base sb on d.crt_staff_id = sb.id
                       WHERE d.id = p_doc_id
--                         AND (not exists (select 1 from dpt_deposit_clos where deposit_id = d.agr_id and wb='Y')
--                          or (d.ea_struct_id in  (541,542,543) and d.scan_data is not null))
                      ))
    loop
      l_Doc_Instance_Rec.rnk                := ead_integration.split_key(i.rnk, i.kf);
      l_Doc_Instance_Rec.doc_type           := i.doc_type;
      l_Doc_Instance_Rec.doc_id             := i.doc_id;
      l_Doc_Instance_Rec.doc_pages_count    := i.doc_pages_count;
      l_Doc_Instance_Rec.doc_binary_data    := i.doc_binary_data;
      l_Doc_Instance_Rec.doc_request_number := i.doc_request_number;
      l_Doc_Instance_Rec.agr_code           := ead_integration.split_key(i.agr_code, i.kf);
      l_Doc_Instance_Rec.agr_type           := i.agr_type;
      l_Doc_Instance_Rec.account_type       := i.account_type;
      l_Doc_Instance_Rec.account_number     := i.account_number;
      l_Doc_Instance_Rec.account_currency   := i.account_currency;
      l_Doc_Instance_Rec.created            := i.created;
      l_Doc_Instance_Rec.changed            := i.changed;
      l_Doc_Instance_Rec.user_login         := i.user_login;
      l_Doc_Instance_Rec.user_fio           := i.user_fio;
      l_Doc_Instance_Rec.branch_id          := i.branch_id;
--      l_Doc_Instance_Rec.linkedrnk          := ead_integration.split_key(i.linkedrnk, i.kf);

      PIPE ROW(l_Doc_Instance_Rec);
    end loop;
  END get_DocAll_Instance;

  -- Сканкопии по зарплатным проектам
  FUNCTION get_DocSalary_Instance(p_doc_id ead_docs.id%TYPE) RETURN Doc_Instance_Set PIPELINED IS
    l_Doc_Instance_Rec Doc_Instance_Rec;
  BEGIN
    bc.go('/');

    FOR i IN (select kf,
                     d.rnk,
                     d.ea_struct_id as doc_type,
                     d.id as doc_id,
                     NVL(d.page_count, 1) as doc_pages_count,
                     d.scan_data as doc_binary_data,
                     null as doc_request_number,
                     d.agr_id as agr_code,
                     'salary_uo' as agr_type,
                     null as account_type,
                     null as account_number,
                     null as account_currency,
                     d.crt_date as created,
                     d.crt_date as changed,
                     sb.logname as user_login,
                     sb.fio as user_fio,
                     d.crt_branch as branch_id,
                     d.rnk as linkedrnk
                from ead_docs d left outer join staff$base sb on d.crt_staff_id = sb.id
               where d.id = p_doc_id) loop

      l_Doc_Instance_Rec.rnk                := ead_integration.split_key(i.rnk, i.kf);
      l_Doc_Instance_Rec.doc_type           := i.doc_type;
      l_Doc_Instance_Rec.doc_id             := i.doc_id;
      l_Doc_Instance_Rec.doc_pages_count    := i.doc_pages_count;
      l_Doc_Instance_Rec.doc_binary_data    := i.doc_binary_data;
      l_Doc_Instance_Rec.doc_request_number := i.doc_request_number;
      l_Doc_Instance_Rec.agr_code           := ead_integration.split_key(i.agr_code, i.kf);
      l_Doc_Instance_Rec.agr_type           := i.agr_type;
      l_Doc_Instance_Rec.account_type       := i.account_type;
      l_Doc_Instance_Rec.account_number     := i.account_number;
      l_Doc_Instance_Rec.account_currency   := i.account_currency;
      l_Doc_Instance_Rec.created            := i.created;
      l_Doc_Instance_Rec.changed            := i.changed;
      l_Doc_Instance_Rec.user_login         := i.user_login;
      l_Doc_Instance_Rec.user_fio           := i.user_fio;
      l_Doc_Instance_Rec.branch_id          := i.branch_id;
      l_Doc_Instance_Rec.linkedrnk          := ead_integration.split_key(i.linkedrnk, i.kf);

      PIPE ROW(l_Doc_Instance_Rec);
    end loop;
  END get_DocSalary_Instance;

 -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Client.GetInstance      BMS.Method = SetClientData
   -----------------------------------------------------------------------

   FUNCTION get_Client_Instance (p_rnk customer.rnk%TYPE)
      RETURN Client_Instance_Set
      PIPELINED
   is
    l_Client_Instance_Rec Client_Instance_Rec;
   begin
    bc.go('/');
    for i in (  SELECT c.kf, c.rnk,
               (SELECT NVL (MAX (chgdate), C.DATE_ON)
                  FROM customer_update
                 WHERE rnk = c.rnk)
                  AS changed,
               c.date_on AS created,
               c.branch AS branch_id,
               NVL ( (SELECT sb.logname
                        FROM staff$base sb, customer_update cu
                       WHERE     cu.doneby = sb.logname(+)
                             AND cu.idupd = (SELECT MAX (cu.idupd)
                                               FROM customer_update cu
                                              WHERE cu.rnk = c.rnk)),
                    'BARS')
                  AS user_login,
               NVL ( (SELECT sb.fio
                        FROM staff$base sb, customer_update cu
                       WHERE     cu.doneby = sb.logname(+)
                             AND cu.idupd = (SELECT MAX (cu.idupd)
                                               FROM customer_update cu
                                              WHERE cu.rnk = c.rnk)),
                    'Користувач BARS')
                  AS user_fio,
--             DECODE (c.custtype,  1, 2,  2, 2,  3, 3) AS  client_type,
               1 as client_type,  -- Значення довідника ЕА «Тип клієнта» - Фізична особа
               c.nmk AS fio,
               c.okpo AS inn,
               p.bday AS birth_date,
               p.passp AS document_type,
               p.ser AS document_series,
               p.numdoc AS document_number
          FROM customer c, person p
         WHERE c.rnk = p_rnk
           AND c.rnk = p.rnk
           AND ead_pack.get_custtype(c.rnk) = 3)
    loop

        l_Client_Instance_Rec.rnk               := ead_integration.split_key(i.rnk, i.kf);
        l_Client_Instance_Rec.changed           := i.changed;
        l_Client_Instance_Rec.created           := i.created;
        l_Client_Instance_Rec.branch_id         := i.branch_id;
        l_Client_Instance_Rec.user_login        := i.user_login;
        l_Client_Instance_Rec.user_fio          := i.user_fio;
        l_Client_Instance_Rec.client_type       := i.client_type;
        l_Client_Instance_Rec.fio               := i.fio;
        l_Client_Instance_Rec.inn               := i.inn;
        l_Client_Instance_Rec.birth_date        := i.birth_date;
        l_Client_Instance_Rec.document_type     := i.document_type;
        l_Client_Instance_Rec.document_series   := i.document_series;
        l_Client_Instance_Rec.document_number   := i.document_number;

        if l_Client_Instance_Rec.birth_date is null then
          raise_application_error(-20002, 'Дата народження клієнта не заповнена [birth_date]');
        end if;

        PIPE ROW (l_Client_Instance_Rec);
    end loop;
   end;

   FUNCTION get_MergedRNK (p_rnk customer.rnk%TYPE)
      RETURN MergedRNK_Set
      PIPELINED
   is
    l_MergedRNK_Rec MergedRNK_Rec;
   begin
    bc.go('/');
    bars_audit.debug('get_MergedRNK startes p_rnk = ' || p_rnk);
/*
    for i in (  SELECT DISTINCT rnkfrom AS mrg_rnk
                  FROM (SELECT rn.rnkfrom, rn.rnkto
                          FROM rnk2nls rn
                        UNION ALL
                        SELECT rt.rnkfrom, rt.rnkto
                          FROM rnk2tbl rt)
                 WHERE rnkfrom != p_rnk and rnkto = p_rnk order by rnkfrom desc)
*/
    for i in (select rnk as mrg_rnk, kf from customer
               where rnk in (select rnkfrom from rnk2nls where rnkfrom != p_rnk and rnkto = p_rnk)
                 and rnk in (select rnkfrom from rnk2tbl where rnkfrom != p_rnk and rnkto = p_rnk)
                 and date_off is not null)
    loop
        l_MergedRNK_Rec.mrg_rnk := ead_integration.split_key(i.mrg_rnk, i.kf);
        PIPE ROW (l_MergedRNK_Rec);
    end loop;
   end get_MergedRNK;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.UClient.GetInstance        BMS.Method = SetClientDataU
   -----------------------------------------------------------------------
   FUNCTION get_UClient_Instance (p_rnk customer.rnk%TYPE)
      RETURN UClient_Instance_Set
      PIPELINED
   is
    l_UClient_Instance_Rec UClient_Instance_Rec;
   begin
    bc.go('/');
    for i in(SELECT c.kf, c.branch AS                            branch_id,
                    c.rnk ,
                    cu.chgdate AS                                changed,
                    c.date_on AS                                 created,
--                  DECODE (c.custtype,  1, 2,  2, 2,  3, 3) AS  client_type,
                    case
                      when c.custtype in (1, 2) then 2
                      when c.custtype = 3 and rtrim(c.sed) = '91' /*and ise in ('14100', '14101', '14200', '14201')*/ then 3
                    end as client_type,
                    c.nmk AS                                     client_name,
                    c.okpo AS                                    inn_edrpou,
                    nvl(sb.logname,'BARS')                       user_login,
                    nvl(sb.fio,'BARS')                           user_fio,
                    sb.fio as                                    actualized_by_user_fio,
                    sb.logname as                                actualized_by_user_login,
                    sb.branch as                                 actualized_by_branch_id,
                    cu.chgdate AS                                actualized_date
               FROM customer c, customer_update cu, staff$base sb
              WHERE     c.rnk = p_rnk
                    AND c.rnk = cu.rnk
                    AND ead_pack.get_custtype(c.rnk) = 2
                    AND cu.idupd = (SELECT MAX (cu.idupd)
                                      FROM customer_update cu
                                     WHERE cu.rnk = c.rnk)
                    AND cu.doneby = sb.logname(+))

    loop
        l_UClient_Instance_Rec.branch_id                := i.branch_id;
        l_UClient_Instance_Rec.rnk                      := ead_integration.split_key(i.rnk, i.kf);
        l_UClient_Instance_Rec.changed                  := i.changed;
        l_UClient_Instance_Rec.created                  := i.created;
        l_UClient_Instance_Rec.client_type              := i.client_type;
        l_UClient_Instance_Rec.client_name              := i.client_name;
        l_UClient_Instance_Rec.inn_edrpou               := i.inn_edrpou;
        l_UClient_Instance_Rec.user_login               := i.user_login;
        l_UClient_Instance_Rec.user_fio                 := i.user_fio;
        l_UClient_Instance_Rec.actualized_by_user_fio   := i.actualized_by_user_fio;
        l_UClient_Instance_Rec.actualized_by_user_login := i.actualized_by_user_login;
        l_UClient_Instance_Rec.actualized_by_branch_id  := i.actualized_by_branch_id;
        l_UClient_Instance_Rec.actualized_date          := i.actualized_date;

        PIPE ROW (l_UClient_Instance_Rec);
    end loop;

   end get_UClient_Instance;

    FUNCTION get_Third_Person_Client_Set (p_rnk customer.rnk%TYPE)
      RETURN Third_Person_Client_Set
      PIPELINED
    is
        l_Third_Person_Client_Rec   Third_Person_Client_Rec;
    begin
    bc.go('/');
        for i in (  SELECT t1.rel_rnk AS rnk,
                           t1.rel_id AS  personstateid,
                           T1.BDATE AS   date_begin_powers,
                           T1.EDATE AS   date_end_powers
                      FROM customer_rel t1
                     WHERE t1.rnk = p_rnk
                       AND t1.rel_id > 0
                       AND t1.REL_INTEXT = 1)
        loop
            l_Third_Person_Client_Rec.rnk               := ead_integration.split_key(i.rnk);
            l_Third_Person_Client_Rec.personstateid     := i.personstateid;
            l_Third_Person_Client_Rec.date_begin_powers := i.date_begin_powers;
            l_Third_Person_Client_Rec.date_end_powers   := i.date_end_powers;

            PIPE ROW (l_Third_Person_Client_Rec);
        end loop;

    end;

    FUNCTION get_Third_Person_NonClient_Set (p_rnk customer.rnk%TYPE)
      RETURN Third_Person_NonClient_Set
      PIPELINED
    is
        l_Third_Person_NonClient_Rec   Third_Person_NonClient_Rec;
    begin
     bc.go('/');
        for i in (  SELECT t1.rel_rnk AS id,
                           rel_id AS personstateid,
                           t2.name,
                           DECODE (T2.CUSTTYPE,  1, 2,  2, 1,  3, 3) AS client_type,
                           T2.OKPO AS inn_edrpou,
                           t1.bdate AS date_begin_powers,
                           t1.edate AS date_end_powers
                      FROM customer_rel t1, customer_extern t2
                     WHERE t1.rnk = p_rnk
                       AND T1.REL_RNK = T2.ID
                       and T2.OKPO is not null
                       AND t1.rel_id > 0
                       AND t1.REL_INTEXT = 0)
        loop
            l_Third_Person_NonClient_Rec.id                := ead_integration.split_key(i.id);
            l_Third_Person_NonClient_Rec.personstateid     := i.personstateid;
            l_Third_Person_NonClient_Rec.name              := i.name;
            l_Third_Person_NonClient_Rec.client_type       := i.client_type;
            l_Third_Person_NonClient_Rec.inn_edrpou        := i.inn_edrpou;
            l_Third_Person_NonClient_Rec.date_begin_powers := i.date_begin_powers;
            l_Third_Person_NonClient_Rec.date_end_powers   := i.date_end_powers;

            PIPE ROW (l_Third_Person_NonClient_Rec);
        end loop;

    end;
   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Agr.GetInstance       BMS.Method = SetAgreementData
   -----------------------------------------------------------------------
   FUNCTION get_AgrDPT_Instance_Set (p_agr_id dpt_deposit.deposit_id%TYPE)
      RETURN AgrDPT_Instance_Set
      PIPELINED
    is
        l_AgrDPT_Instance_Rec   AgrDPT_Instance_Rec;
        l_acc accounts.acc%type;
        parent_agr_code  deal.id%type;
        parent_agr_number deal.deal_number%type;
        l_agr_date deal.start_date%type;
        l_agr_status deal.state_id%type;
        l_deposit_wb dpt_deposit_clos.wb%type;
    begin
      bc.go('/');

      select max(acc_d) keep(dense_rank last order by idupd),
             max(wb) keep(dense_rank first order by idupd)
        into l_acc, l_deposit_wb
        from dpt_deposit_clos
       where deposit_id = p_agr_id;
       if l_deposit_wb = 'Y' then
         get_dkbo(p_acc => l_acc, p_id => parent_agr_code, p_deal_number => parent_agr_number, p_start_date => l_agr_date, p_state_id => l_agr_status);
       end if;

        for i in (SELECT ddc.kf, ddc.deposit_id AS                                                    agr_code,
                         ddc.rnk                                                                     rnk,
                         ddc.when AS                                                                 changed,
                         ddc.datz AS                                                                 created,
                         ddc.branch AS                                                               branch_id,
                         sb.logname AS                                                              user_login,
                         sb.fio AS                                                                  user_fio,
                         get_agr_type(p_agr_id) AS                                                  agr_type,
                         (SELECT DECODE (COUNT (1), 0, 1, 0)
                            FROM dpt_deposit_clos dc0
                           WHERE dc0.deposit_id = ddc.deposit_id AND dc0.action_id IN (1, 2))
                            AS                                                                      agr_status,
                         ddc.nd AS                                                                   agr_number,
                         ddc.dat_begin AS                                                            agr_date_open,
                         CASE
                            WHEN ddc.ACTION_ID IN (1, 2) THEN ddc.BDATE
                            WHEN ddc.ACTION_ID NOT IN (1, 2) THEN NULL
                            ELSE NULL
                         END
                            AS                                                                      agr_date_close,
                         (SELECT a.nls
                            FROM accounts a
                           WHERE a.acc = ddc.acc)
                            AS                                                                      account_number
                   FROM dpt_deposit_clos ddc
--                   join dpt_deposit d on ddc.deposit_id = d.deposit_id and ddc.kf = d.kf
                   left outer join staff$base sb on ddc.actiion_author = sb.id
                  WHERE ddc.deposit_id = p_agr_id
                  ORDER BY ddc.idupd DESC)
        loop
            l_AgrDPT_Instance_Rec.rnk             := ead_integration.split_key(i.rnk);
            l_AgrDPT_Instance_Rec.parent_agr_type := bars.tools.iif(parent_agr_code is not null, 'dkbo_fo', null);
            l_AgrDPT_Instance_Rec.parent_agr_code := ead_integration.split_key(parent_agr_code);
--            l_AgrDPT_Instance_Rec.parent_agr_code := parent_agr_number;
            l_AgrDPT_Instance_Rec.agr_type        := i.agr_type;
            l_AgrDPT_Instance_Rec.agr_code        := ead_integration.split_key(i.agr_code, i.kf);
--            l_AgrDPT_Instance_Rec.agr_code        := i.idupd;  -- dummy tests
            l_AgrDPT_Instance_Rec.agr_number      := ead_integration.split_key(i.agr_number, i.kf);
            l_AgrDPT_Instance_Rec.agr_status      := i.agr_status;
            l_AgrDPT_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_AgrDPT_Instance_Rec.agr_date_close  := i.agr_date_close;
            l_AgrDPT_Instance_Rec.created         := i.created;
            l_AgrDPT_Instance_Rec.changed         := i.changed;
            l_AgrDPT_Instance_Rec.user_login      := i.user_login;
            l_AgrDPT_Instance_Rec.user_fio        := i.user_fio;
            l_AgrDPT_Instance_Rec.branch_id       := i.branch_id;

            PIPE ROW (l_AgrDPT_Instance_Rec);
        end loop;

    end get_AgrDPT_Instance_Set;

    FUNCTION get_AgrDPT_LinkedRnk_Set (p_agr_id dpt_deposit.deposit_id%TYPE)
    RETURN AgrDPT_LinkedRnk_Set
    PIPELINED
    is
        l_AgrDPT_LinkedRnk_Rec  AgrDPT_LinkedRnk_Rec;
    begin
     bc.go('/');
     for i in ( SELECT DISTINCT
                       t.rnk_tr AS rnk, kf,
                       DECODE (t.typ_tr,
                               'T', 1,
                               'H', 2,
                               'V', 5,
                               'B', 4,
                               'C', 6,
                               'M', 7,
                               0)
                          AS linkpersonstateid
                  FROM dpt_trustee t
                 WHERE t.dpt_id = p_agr_id AND t.fl_act > 0
                UNION
                SELECT t1.rnk AS rnk, t1.kf, 3 AS linkpersonstateid
                  FROM (SELECT *
                          FROM dpt_deposit_clos
                         WHERE deposit_id = p_agr_id AND ACTION_ID = 0 AND ROWNUM = 1) t1,
                       (SELECT *
                          FROM (  SELECT *
                                    FROM dpt_deposit_clos
                                   WHERE deposit_id = p_agr_id
                                ORDER BY idupd DESC)
                         WHERE ROWNUM = 1) t2
                 WHERE t1.rnk <> t2.rnk)
         loop
            l_AgrDPT_LinkedRnk_Rec.rnk  :=  ead_integration.split_key(i.rnk, i.kf);
            l_AgrDPT_LinkedRnk_Rec.linkpersonstateid := i.linkpersonstateid;
            PIPE ROW (l_AgrDPT_LinkedRnk_Rec);
         end loop;
    end;

    FUNCTION get_AgrBPK_Instance_Set (p_agr_id w4_acc_update.nd%TYPE)
      RETURN AgrBPK_Instance_Set
      PIPELINED
    is
        l_AgrBPK_Instance_Rec   AgrBPK_Instance_Rec;
    begin
     bc.go('/');
        for i in (SELECT t3.kf, t1.nd AS agr_code,
                         t3.rnk,
                         (case when t3.daos between trunc(t1.CHGDATE) and bankdate() then t3.daos else t1.CHGDATE end) AS changed,
                         T3.DAOS AS created,
                         t3.branch AS branch_id,
                         nvl(t2.logname,'BARS') AS user_login,
                         nvl(t2.fio,'BARS') AS user_fio,
                         'bpk_fo' AS agr_type,
                         CASE
                            WHEN T3.DAZS IS NULL THEN 1
                            WHEN t3.DAZS < SYSDATE THEN 0
                            ELSE 1
                         END
                            AS agr_status,
                         t1.nd AS agr_number,
                         NVL (t1.dat_begin, t3.daos) AS agr_date_open,
                         t3.DAZS AS agr_date_close,
                         t3.nls AS account_number
                    FROM w4_acc_update t1, staff$base t2, accounts t3
                   WHERE t1.nd = p_agr_id
                     AND T1.DONEBY = t2.id(+)
                     AND t3.acc = t1.acc_pk
                ORDER BY t1.idupd DESC)
        loop
            l_AgrBPK_Instance_Rec.rnk             := ead_integration.split_key(i.rnk, i.kf);
            l_AgrBPK_Instance_Rec.parent_agr_type := null;
            l_AgrBPK_Instance_Rec.parent_agr_code := null;
            l_AgrBPK_Instance_Rec.agr_type        := i.agr_type;
            l_AgrBPK_Instance_Rec.agr_code        := ead_integration.split_key(i.agr_code, i.kf);
            l_AgrBPK_Instance_Rec.agr_number      := ead_integration.split_key(i.agr_number, i.kf);
            l_AgrBPK_Instance_Rec.agr_status      := i.agr_status;
            l_AgrBPK_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_AgrBPK_Instance_Rec.agr_date_close  := i.agr_date_close;
            l_AgrBPK_Instance_Rec.created         := i.created;
            l_AgrBPK_Instance_Rec.changed         := i.changed;
            l_AgrBPK_Instance_Rec.user_login      := i.user_login;
            l_AgrBPK_Instance_Rec.user_fio        := i.user_fio;
            l_AgrBPK_Instance_Rec.branch_id       := i.branch_id;

            PIPE ROW (l_AgrBPK_Instance_Rec);
        end loop;

    end;
    FUNCTION get_AgrDKBO_Instance_Set (p_agr_id deal.id%TYPE)
      RETURN AgrDKBO_Instance_Set
      PIPELINED
    is l_AgrDKBO_Instance_Rec AgrDKBO_Instance_Rec;
    begin
      bc.go('/');
      for i in (select d.customer_id    as rnk,
                       c.kf,
                       'dkbo_fo'        as agr_type,
                       d.id             as agr_code,
                       d.deal_number    as agr_number,
                       decode(D.STATE_ID, g_state_id, 1, 0) as agr_status,  -- статусы в ЕА надо смотреть по цикл жижни угоды
                       d.START_DATE     as agr_date_open,
                       D.CLOSE_DATE     as agr_date_close,
                       d.START_DATE     as created,
                       D.START_DATE     as changed,
                       S.LOGNAME        as user_login,
                       S.FIO            as user_fio,
                       D.BRANCH_ID      as branch_id
                  from bars.deal d
                    join bars.customer c on d.customer_id = c.rnk and d.id = p_agr_id
                    left outer join bars.staff$base s on d.CURATOR_ID = s.id
      )
      loop
        l_AgrDKBO_Instance_Rec.rnk             := ead_integration.split_key(i.rnk, i.kf);
        l_AgrDKBO_Instance_Rec.parent_agr_type := null;
        l_AgrDKBO_Instance_Rec.parent_agr_code := null;
        l_AgrDKBO_Instance_Rec.agr_type        := i.agr_type;
        l_AgrDKBO_Instance_Rec.agr_code        := ead_integration.split_key(i.agr_code, i.kf);
        l_AgrDKBO_Instance_Rec.agr_number      := i.agr_number;
        l_AgrDKBO_Instance_Rec.agr_status      := i.agr_status;
        l_AgrDKBO_Instance_Rec.agr_date_open   := i.agr_date_open;
        l_AgrDKBO_Instance_Rec.agr_date_close  := i.agr_date_close;
        l_AgrDKBO_Instance_Rec.changed         := i.changed;
        l_AgrDKBO_Instance_Rec.created         := i.created;
        l_AgrDKBO_Instance_Rec.user_login      := i.user_login;
        l_AgrDKBO_Instance_Rec.user_fio        := i.user_fio;
        l_AgrDKBO_Instance_Rec.branch_id       := i.branch_id;

       PIPE ROW (l_AgrDKBO_Instance_Rec);
      end loop;
    end;

    function get_AgrBPKcodes_Set(p_agr_id deal.id%type, p_acc_list string) return number_list pipelined is
      l_acc_list number_list;
    begin
      if p_acc_list = 'ALL' then -- вытаскиваем все присоединенные к ДКБО счета
        l_acc_list := pkg_dkbo_utl.f_get_all_cust_acc(p_customer_id => deal_utl.get_deal_customer_id(p_agr_id), p_deal_id => p_agr_id);
      else  -- или работаем только с теми что приехали в процедуру
        l_acc_list := tools.string_to_number_list(p_string => p_acc_list, p_splitting_symbol => ',');
      end if;

      for i in (select w4.nd, w4.kf
                  from deal dkbo
                  join accounts a on dkbo.customer_id = a.rnk
                  join w4_acc w4  on a.acc = w4.acc_pk
                 where 1 = 1
                   and dkbo.id = p_agr_id
                   and w4.acc_pk member of l_acc_list                  
                   and (dkbo.start_date > w4.dat_begin 
                   or   dkbo.start_date <= greatest(to_date('10/02/2018','dd/mm/yyyy'), ( select max(trunc(MIGRATION_START_TIME) )from migration_log where TABLE_NAME ='DEAL' and MIGRATION_ID= a.kf ))
                       ) 
                 order by w4.nd) loop
--        exit;
        pipe row(ead_integration.split_key(i.nd, i.kf));
      end loop;
    end get_AgrBPKcodes_Set;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.UAgr.GetInstance      BMS.Method = SetAgreementDataU
   -----------------------------------------------------------------------
   FUNCTION get_UAgrDPU_Instance_Set (p_dpu_id dpu_deal.dpu_id%TYPE)
      RETURN UAgrDPU_Instance_Set
      PIPELINED
     is
        l_UAgrDPU_Instance_Rec   UAgrDPU_Instance_Rec;
    begin
     bc.go('/');
        for i in (  SELECT dd.kf, dd.dpu_id AS agr_code,
                           dd.rnk AS rnk,
                           ddu.dateu AS changed,
                           dd.dat_begin AS created,
                           dd.branch AS branch_id,
                           sb.logname AS user_login,
                           sb.fio AS user_fio,
                           'dep_uo' AS agr_type,
                           DECODE (dd.closed,  0, 1,  1, 0) AS agr_status,
                           dd.nd AS agr_number,
                           dd.datz AS agr_date_open,
                           DECODE (dd.closed,  0, TO_DATE (NULL),  1, gl.bd) AS agr_date_close
                      FROM dpu_deal dd, dpu_deal_update ddu, staff$base sb
                     WHERE     dd.dpu_id = p_dpu_id
                           AND dd.dpu_id = ddu.dpu_id
                           AND ddu.useru = sb.id(+)
                           AND ddu.idu = (SELECT MAX (ddu0.idu)
                                            FROM dpu_deal_update ddu0
                                           WHERE ddu0.dpu_id = dd.dpu_id))
        loop
            l_UAgrDPU_Instance_Rec.rnk             := ead_integration.split_key (i.rnk, i.kf);
            l_UAgrDPU_Instance_Rec.agr_type        := i.agr_type;
            l_UAgrDPU_Instance_Rec.agr_code        := ead_integration.split_key (i.agr_code, i.kf);
            l_UAgrDPU_Instance_Rec.agr_number      := i.agr_number;
            l_UAgrDPU_Instance_Rec.agr_status      := i.agr_status;
            l_UAgrDPU_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_UAgrDPU_Instance_Rec.agr_date_close  := i.agr_date_close;
            l_UAgrDPU_Instance_Rec.created         := i.created;
            l_UAgrDPU_Instance_Rec.changed         := i.changed;
            l_UAgrDPU_Instance_Rec.user_login      := i.user_login;
            l_UAgrDPU_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrDPU_Instance_Rec.branch_id       := i.branch_id;

            PIPE ROW (l_UAgrDPU_Instance_Rec);
        end loop;

    end;

    FUNCTION get_UAgrDBO_Instance_Set (p_rnk customer.rnk%TYPE)
      RETURN UAgrDBO_Instance_Set
      PIPELINED
    is
       l_UAgrDBO_Instance_Rec   UAgrDBO_Instance_Rec;
        l_agr_code specparam.nkd%type;
        l_agr_type ead_nbs.agr_type%type;
        l_agr_date varchar2(10);
        l_agr_status number(2);
     begin
      bc.go('/');
      get_rnkagr_param(p_rnk => p_rnk,
                       p_agr_code => l_agr_code,
                       p_agr_type => l_agr_type,
                       p_agr_date => l_agr_date,
                       p_agr_status => l_agr_status);
        bars_audit.info('get_UAgrDBO_Instance_Set.get_rnkagr_param: l_agr_code='|| l_agr_code ||', l_agr_type='||l_agr_type||',l_agr_date = '||l_agr_date||',l_agr_status='||l_agr_status );
        for i in (  with custupd as (select doneby, chgdate,nvl(s.logname,'BARS') AS logname, nvl(s.fio,'BARS') AS fio from customerw_update cu, staff$base s where cu.rnk = p_rnk and cu.tag = 'NDBO' and s.LOGNAME(+) = cu.doneby)
                    select  rnk, kf,
                            custupd.chgdate as changed,
                            TO_DATE(l_agr_date,'DD.MM.YYYY') as created,
                            branch as branch_id,
                            custupd.logname as user_login,
                            custupd.fio as user_fio,
                            TO_DATE(l_agr_date,'DD.MM.YYYY') as agr_date_open,
                            null  as  agr_date_close
                            from customer c, custupd
                            where c.rnk = p_rnk
                 )
        loop
            l_UAgrDBO_Instance_Rec.agr_code        := l_agr_code;
            l_UAgrDBO_Instance_Rec.rnk             := ead_integration.split_key(i.rnk, i.kf);
            l_UAgrDBO_Instance_Rec.changed         := i.changed;
            l_UAgrDBO_Instance_Rec.created         := i.created;
            l_UAgrDBO_Instance_Rec.branch_id       := i.branch_id;
            l_UAgrDBO_Instance_Rec.user_login      := i.user_login;
            l_UAgrDBO_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrDBO_Instance_Rec.agr_type        := l_agr_type;
            l_UAgrDBO_Instance_Rec.agr_status      := l_agr_status;
            l_UAgrDBO_Instance_Rec.agr_number      := l_agr_code;
            l_UAgrDBO_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_UAgrDBO_Instance_Rec.agr_date_close  := i.agr_date_close;

            PIPE ROW (l_UAgrDBO_Instance_Rec);
        end loop;

     end;


    FUNCTION get_UAgrACC_Instance_Set (p_acc accounts.acc%type)
      RETURN UAgrACC_Instance_Set
      PIPELINED
     is
        l_UAgrACC_Instance_Rec   UAgrACC_Instance_Rec;
    begin
      bc.go('/');
      get_accagr_param(p_acc);

        for i in (  SELECT kf, agr_code, rnk, changed, daos AS created,
                           branch AS branch_id, user_login, user_fio,
                           NVL ( rAccAgrParam.agr_type, 'pr_uo') AS agr_type,
                           NVL ( rAccAgrParam.agr_status, CASE WHEN dazs IS NULL OR dazs > SYSDATE THEN 1
                                                               when dazs = DAOS then 10
                                                               ELSE 0 END) AS agr_status,
--                           agr_code as  agr_number,
                           NVL (TO_DATE ( rAccAgrParam.agr_date, 'dd.mm.yyyy'), daos) AS agr_date_open,
                           CASE WHEN dazs IS NULL OR dazs > SYSDATE THEN TO_DATE (NULL) ELSE dazs END AS agr_date_close
                      FROM (SELECT au.idupd, a.kf,
                                   MAX (au.idupd) OVER (ORDER BY au.acc, au.chgdate DESC) max_idupd,
                                   a.branch, a.rnk, TRUNC(a.daos) daos, a.dazs,
                                   coalesce (rAccAgrParam.agr_code, (SELECT nkd FROM specparam sp WHERE a.acc = sp.acc)) agr_code,
                                   au.chgdate changed,
                                   sb.logname AS user_login,
                                   sb.fio AS user_fio
                              FROM accounts a,
                                   accounts_update au,
                                   staff$base sb
                             WHERE a.acc = p_acc
                               AND a.acc = au.acc
                               AND au.doneby = sb.logname(+))
                     WHERE max_idupd = idupd)

        loop
            l_UAgrACC_Instance_Rec.agr_code        := i.agr_code;
            l_UAgrACC_Instance_Rec.rnk             := ead_integration.split_key (i.rnk, i.kf);
            l_UAgrACC_Instance_Rec.changed         := i.changed;
            l_UAgrACC_Instance_Rec.created         := i.created;
            l_UAgrACC_Instance_Rec.branch_id       := i.branch_id;
            l_UAgrACC_Instance_Rec.user_login      := i.user_login;
            l_UAgrACC_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrACC_Instance_Rec.agr_type        := i.agr_type;
            l_UAgrACC_Instance_Rec.agr_status      := i.agr_status;
            l_UAgrACC_Instance_Rec.agr_number      := i.agr_code;
            l_UAgrACC_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_UAgrACC_Instance_Rec.agr_date_close  := case when i.agr_status = 10 then null else i.agr_date_close end;

            PIPE ROW (l_UAgrACC_Instance_Rec);
        end loop;

    end;

    FUNCTION get_UAgrACCRsrv_Instance_Set(p_rsrv_id accounts_rsrv.rsrv_id%type) return UAgrACC_Instance_Set pipelined is
      l_UAgrACC_Instance_Rec UAgrACC_Instance_Rec;
    begin
      bc.go('/');
      get_accagr_param_reserve(p_rsrv_id);

      for i in (SELECT a.kf,
                       a.branch as branch_id,
                       a.rnk,
                       trunc(a.crt_dt) as created,
                       trunc(a.crt_dt) as changed,
                       rAccAgrParam.agr_code as agr_code,
                       NVL(rAccAgrParam.agr_type, 'pr_uo') AS agr_type,
                       to_date(replace(rAccAgrParam.agr_date, '.', '/'), 'dd/mm/yyyy') AS agr_date_open,
                       rAccAgrParam.agr_status AS agr_status,
                       sb.logname AS user_login,
                       sb.fio AS user_fio
                  FROM accounts_rsrv a join staff$base sb on a.usr_id = sb.id
                 WHERE a.rsrv_id = p_rsrv_id)
      loop
        l_UAgrACC_Instance_Rec.agr_code       := i.agr_code;
        l_UAgrACC_Instance_Rec.rnk            := ead_integration.split_key(i.rnk, i.kf);
        l_UAgrACC_Instance_Rec.changed        := i.changed;
        l_UAgrACC_Instance_Rec.created        := i.created;
        l_UAgrACC_Instance_Rec.branch_id      := i.branch_id;
        l_UAgrACC_Instance_Rec.user_login     := i.user_login;
        l_UAgrACC_Instance_Rec.user_fio       := i.user_fio;
        l_UAgrACC_Instance_Rec.agr_type       := i.agr_type;
        l_UAgrACC_Instance_Rec.agr_status     := i.agr_status;
        l_UAgrACC_Instance_Rec.agr_number     := i.agr_code;
        l_UAgrACC_Instance_Rec.agr_date_open  := i.agr_date_open;
        l_UAgrACC_Instance_Rec.agr_date_close := null;

        PIPE ROW(l_UAgrACC_Instance_Rec);
      end loop;

    end get_UAgrACCRsrv_Instance_Set;

    FUNCTION get_UAgrDPTOLD_Instance_Set (p_nls accounts.nls%TYPE, p_daos accounts.daos%type, p_acc accounts.acc%type)
      RETURN UAgrDPTOLD_Instance_Set
      PIPELINED
     is
        l_UAgrDPTOLD_Instance_Rec  UAgrDPTOLD_Instance_Rec;
    begin
    bc.go('/');
        for i in (  SELECT t.kf, t.agr_code,
                           t.rnk,
                           au.chgdate AS changed,
                           t.created,
                           t.branch_id,
                           nvl(sb.logname,'BARS') AS user_login,
                           nvl(sb.fio,'BARS') AS user_fio,
                           t.agr_type,
                           t.agr_status,
                           t.agr_number,
                           t.agr_date_open,
                           t.agr_date_close
                      FROM (  SELECT    a.kf, TO_CHAR (TRUNC (a.daos), 'yyyymmdd') || '|' || a.nls || '|' || TO_CHAR (a.kv) AS agr_code,
                                     a.rnk AS rnk,
                                     TRUNC (a.daos) AS created,
                                     a.branch AS branch_id,
                                     'dep_uo' AS agr_type,
                                     CASE
                                        WHEN MAX (a.dazs) IS NULL OR MAX (a.dazs) > SYSDATE THEN 1
                                        ELSE 0
                                     END
                                        AS agr_status,
                                     MAX (sp.nkd) AS agr_number,
                                     TRUNC (a.daos) AS agr_date_open,
                                     CASE
                                        WHEN MAX (a.dazs) IS NULL OR MAX (a.dazs) > SYSDATE
                                        THEN
                                           TO_DATE (NULL)
                                        ELSE
                                           MAX (a.dazs)
                                     END
                                        AS agr_date_close,
                                     MAX (au.idupd) AS max_idupd
                                FROM accounts a, specparam sp, accounts_update au
                               WHERE     a.nls = p_nls
                                     AND TRUNC (a.daos) = p_daos
                                     AND a.acc = p_acc
                                     AND a.acc = au.acc
                                     AND a.acc = sp.acc(+)
                            GROUP BY A.BRANCH,
                                     TRUNC (a.daos),
                                     A.RNK, a.kf,
                                     A.NLS,
                                     A.KV) t,
                           accounts_update au,
                           staff$base sb
                     WHERE t.max_idupd = au.idupd AND au.doneby = sb.logname(+))
        loop
            l_UAgrDPTOLD_Instance_Rec.agr_code        := i.agr_code;
            l_UAgrDPTOLD_Instance_Rec.rnk             := ead_integration.split_key (i.rnk, i.kf);
            l_UAgrDPTOLD_Instance_Rec.changed         := i.changed;
            l_UAgrDPTOLD_Instance_Rec.created         := i.created;
            l_UAgrDPTOLD_Instance_Rec.branch_id       := i.branch_id;
            l_UAgrDPTOLD_Instance_Rec.user_login      := i.user_login;
            l_UAgrDPTOLD_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrDPTOLD_Instance_Rec.agr_type        := i.agr_type;
            l_UAgrDPTOLD_Instance_Rec.agr_status      := i.agr_status;
            l_UAgrDPTOLD_Instance_Rec.agr_number      := i.agr_number;
            l_UAgrDPTOLD_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_UAgrDPTOLD_Instance_Rec.agr_date_close  := i.agr_date_close;

            PIPE ROW (l_UAgrDPTOLD_Instance_Rec);
        end loop;

    end;

    FUNCTION get_UAgrSalary_Instance_Set (p_id zp_deals.id%TYPE,p_status varchar2)
      RETURN UAgrSalary_Instance_Set
      PIPELINED
     is
        l_UAgrSalary_Instance_Rec   UAgrSalary_Instance_Rec;
    begin
     bc.go('/');
        for i in (

                select d.rnk,
                       d.kf,
                       'salary_uo'                              agr_type,
                       d.id                                     agr_code,
                       d.deal_id                                agr_number,
                       p_status                                 agr_status,
                       d.start_date                             agr_date_open,
                       d.close_date                             agr_date_close,
                       trunc (d.crt_date)                       created,
                       trunc (d.upd_date)                       changed,
                       sb.logname                               user_login,
                       sb.fio                                   user_fio,
                       d.branch                                 branch_id
                  from zp_deals d, customer c, staff$base sb
                 where d.rnk = c.rnk and d.user_id = sb.id(+) and d.id = p_id
                                     )
        loop
            l_UAgrSalary_Instance_Rec.rnk             := ead_integration.split_key (i.rnk, i.kf);
            l_UAgrSalary_Instance_Rec.agr_type        := i.agr_type;
            l_UAgrSalary_Instance_Rec.agr_code        := ead_integration.split_key (i.agr_code, i.kf);
            l_UAgrSalary_Instance_Rec.agr_number      := i.agr_number;
            l_UAgrSalary_Instance_Rec.agr_status      := i.agr_status;
            l_UAgrSalary_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_UAgrSalary_Instance_Rec.agr_date_close  := i.agr_date_close;
            l_UAgrSalary_Instance_Rec.created         := i.created;
            l_UAgrSalary_Instance_Rec.changed         := i.changed;
            l_UAgrSalary_Instance_Rec.user_login      := i.user_login;
            l_UAgrSalary_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrSalary_Instance_Rec.branch_id       := i.branch_id;

            pipe ROW (l_UAgrSalary_Instance_Rec);
        end loop;

    end;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Acc.GetInstance       BMS.Method = SetAccountDataU
   -----------------------------------------------------------------------

    function get_UACC_Instance_Set (p_agr_type string, p_acc accounts.acc%type) return UACC_Instance_Set pipelined is
     l_UACC_Instance_Rec UACC_Instance_Rec;
     l_sal_type varchar2(256);
     l_zp_id    number;
    begin
     bc.go('/');
     l_sal_type:=substr(p_agr_type,1,instr(p_agr_type,'/')-1);
     if substr(p_agr_type,1,6)='SALARY' then
     l_zp_id:=to_number(substr(p_agr_type,instr(p_agr_type,'/')+1,length(p_agr_type)));
     end if;

     get_accagr_param(p_acc);
     for i in ( SELECT a.kf, a.rnk,
                       au.chgdate AS changed,
--                       nvl(TO_DATE(l_agr_date,'DD.MM.YYYY'), a.daos) AS created,
                       nvl(sb.logname,'BARS') AS user_login,
                       nvl(sb.fio,'BARS') AS user_fio,
                       a.nls AS account_number,
                       a.kv AS currency_code,
--                       f_ourmfo_g () AS mfo,
                       a.kf AS mfo,
                       a.branch AS branch_id,
                       a.daos AS open_date,
                       a.dazs AS close_date,
                       CASE
                          WHEN L_SAL_TYPE='SALARY_OPEN' THEN 1
                          WHEN L_SAL_TYPE='SALARY_CLOSE' THEN 2
                          WHEN L_SAL_TYPE='SALARY_RESERVED' THEN 6
                          WHEN (a.dazs IS NULL AND a.blkd = 0 AND a.blkk = 0) THEN 1
                          WHEN a.dazs = a.daos and a.nbs is null THEN 6
                          WHEN a.dazs != a.daos and a.nbs is not null THEN 2
                          WHEN (a.blkd <> 0 AND a.blkk = 0) THEN 3
                          WHEN (a.blkk <> 0 AND a.blkd = 0) THEN 4
                          WHEN (a.blkd <> 0 AND a.blkd <> 0) THEN 5
                       END
                          AS account_status,
                       CASE
                          WHEN ( p_agr_type = 'DPT')
                          THEN
                             (SELECT TO_CHAR (MAX (dd.nd))
                                FROM dpu_accounts da, dpu_deal dd
                               WHERE da.accid = a.acc AND da.dpuid = dd.dpu_id)
                          WHEN ( p_agr_type = 'ACC')
                          THEN nvl(rAccAgrParam.agr_code, (SELECT TO_CHAR (MAX (sp.nkd))
                                FROM specparam sp
                               WHERE sp.acc = a.acc))
                          WHEN ( p_agr_type = 'DPT_OLD')
                          THEN
                             (SELECT TO_CHAR (MAX (sp.nkd))
                                FROM specparam sp
                               WHERE sp.acc = a.acc)
                          when  substr(p_agr_type,1,6)='SALARY'
                          then
                             (select deal_id from zp_deals where id=l_zp_id)

                       END
                          AS agr_number,
                       CASE
                          WHEN ( p_agr_type = 'DPT')
                          THEN
                             (SELECT TO_CHAR (MAX (da.dpuid))
                                FROM dpu_accounts da
                               WHERE da.accid = a.acc)
                          WHEN ( p_agr_type = 'ACC')
                           THEN nvl(rAccAgrParam.agr_code, (SELECT TO_CHAR (MAX (sp.nkd))
                                FROM specparam sp
                               WHERE sp.acc = a.acc))
                          WHEN ( p_agr_type = 'DPT_OLD')
                          THEN
                                TO_CHAR (a.daos, 'yyyymmdd') || '|'|| a.nls || '|' || TO_CHAR (a.kv)
                          when  substr(p_agr_type,1,6)='SALARY'
                           then
                                to_char(l_zp_id)

                       END
                          AS agr_code,
                    /*Поточні рахунки:
                    2512, 2513, 2520, 2523, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2560, 2561, 2562, 2565, 2570, 2571,2572, 2600, 2601, 2602, 2603, 2604, 2640, 2641, 2642, 2643, 2644, 2650.
                    Депозитніе:
                    2610, 2615, 2651 ,2652, 2600 з типом DEP та ОБ22=03, 2650 з типом DEP та ОБ22=03*/
                         case
                         when substr(p_agr_type,1,6)='SALARY' then 'transit_uo'
                         WHEN
                         (a.nbs ='2650' and a.tip = 'DEP' and a.ob22 = '03' )
                         or (a.nbs ='2600' and a.tip = 'DEP' and a.ob22 in ('03','04','05','06','07','08','09','11'))
                         or (a.nbs in ('2610', '2615', '2651' ,'2652', '2525'))
                         THEN 'dep_uo'
                            ELSE nvl(rAccAgrParam.acc_type,'pr_uo') END AS account_type,
                         aw.value as reserved_account
                     FROM accounts a
                     join (select max(acc) keep(dense_rank last order by idupd) as acc,
                                  max(chgdate) keep(dense_rank last order by idupd) as chgdate,
                                  max(doneby) keep(dense_rank last order by idupd) as doneby
                             from accounts_update where acc = p_acc) au
                       on a.acc = au.acc and a.acc = p_acc
                     left outer join staff$base sb
                       on au.doneby = sb.logname
                     left outer join accountsw aw
                       on a.acc = aw.acc and aw.tag = 'RESERVED' and aw.value = '1')
     loop
        l_UACC_Instance_Rec.rnk              := ead_integration.split_key (i.rnk, i.kf);
        l_UACC_Instance_Rec.changed          := i.changed;
--        l_UACC_Instance_Rec.created          := i.created;
        l_UACC_Instance_Rec.user_login       := i.user_login;
        l_UACC_Instance_Rec.user_fio         := i.user_fio;
        l_UACC_Instance_Rec.account_number   := i.account_number;
        l_UACC_Instance_Rec.currency_code    := i.currency_code;
        l_UACC_Instance_Rec.mfo              := i.mfo;
        l_UACC_Instance_Rec.branch_id        := i.branch_id;
        l_UACC_Instance_Rec.open_date        := i.open_date;
        l_UACC_Instance_Rec.close_date       := tools.iif(i.reserved_account is not null or i.account_status = 6, null, i.close_date);
        l_UACC_Instance_Rec.account_status   := i.account_status;
        l_UACC_Instance_Rec.agr_number       := i.agr_number;
        l_UACC_Instance_Rec.agr_code         := case when p_agr_type='DPT' or substr(p_agr_type,1,6)='SALARY' then ead_integration.split_key(i.agr_code, i.kf) else i.agr_code end;
        l_UACC_Instance_Rec.account_type     := i.account_type;
        l_UACC_Instance_Rec.agr_type         := case when  substr(p_agr_type,1,6)='SALARY' then 'salary_uo' else rAccAgrParam.agr_type end;
        l_UACC_Instance_Rec.remote_controled := barsAQ.Ibank_Accounts.is_subscribed(p_acc);

        if l_UACC_Instance_Rec.agr_code is null then
          raise_application_error(-20001, 'Код угоди не заповнений [agr_code]');
        end if;

        PIPE ROW (l_UACC_Instance_Rec);
     end loop;

    END;

    function get_UACCRsrv_Instance_Set (p_agr_type string, p_rsrv_id accounts_rsrv.rsrv_id%type) return UACC_Instance_Set pipelined is
     l_UACC_Instance_Rec UACC_Instance_Rec;
    begin
      bc.go('/');
      get_accagr_param_reserve(p_rsrv_id);

     for i in ( SELECT a.rnk, a.kf,
                       trunc(a.crt_dt) as changed,
                       sb.logname AS user_login,
                       sb.fio AS user_fio,
                       a.nls AS account_number,
                       a.kv AS currency_code,
                       a.kf AS mfo,
                       a.branch AS branch_id,
                       trunc(a.crt_dt) as open_date,
                       rAccAgrParam.agr_code as agr_code,
                       nvl(rAccAgrParam.acc_type,'pr_uo') AS account_type
                     FROM accounts_rsrv a join staff$base sb on a.usr_id = sb.id
                   WHERE a.rsrv_id = p_rsrv_id)
     loop
        l_UACC_Instance_Rec.rnk              := ead_integration.split_key (i.rnk, i.kf);
        l_UACC_Instance_Rec.changed          := i.changed;
--        l_UACC_Instance_Rec.created          := i.created;
        l_UACC_Instance_Rec.user_login       := i.user_login;
        l_UACC_Instance_Rec.user_fio         := i.user_fio;
        l_UACC_Instance_Rec.account_number   := i.account_number;
        l_UACC_Instance_Rec.currency_code    := i.currency_code;
        l_UACC_Instance_Rec.mfo              := i.mfo;
        l_UACC_Instance_Rec.branch_id        := i.branch_id;
        l_UACC_Instance_Rec.open_date        := i.open_date;
        l_UACC_Instance_Rec.close_date       := null;
        l_UACC_Instance_Rec.account_status   := 6;
--        l_UACC_Instance_Rec.agr_number       := i.agr_number;
        l_UACC_Instance_Rec.agr_code         := i.agr_code;
        l_UACC_Instance_Rec.account_type     := i.account_type;
        l_UACC_Instance_Rec.agr_type         := rAccAgrParam.agr_type;
        l_UACC_Instance_Rec.remote_controled := 0;

        if l_UACC_Instance_Rec.agr_code is null then
          raise_application_error(-20001, 'Код угоди не заповнений [agr_code]');
        end if;

        PIPE ROW (l_UACC_Instance_Rec);
     end loop;

    END get_UACCRsrv_Instance_Set;

    function get_ACC_Instance_Set(p_agr_type VARCHAR2, p_acc accounts.acc%TYPE)
       RETURN ACC_Instance_Set
       PIPELINED
    IS
     l_ACC_Instance_Rec ACC_Instance_Rec;
    begin
     bc.go('/');
      get_accagr_param(p_acc);
     for i in (
                SELECT a.kf, a.rnk AS rnk,
                       au.chgdate AS changed,
                       nvl(TO_DATE(rAccAgrParam.agr_date,'DD.MM.YYYY'), a.daos) AS created,
                       sb.logname AS user_login,
                       sb.fio AS user_fio,
                       a.nls AS account_number,
                       a.kv AS account_currency,
--                       f_ourmfo_g () AS account_mfo,
                       a.kf AS account_mfo,
                       a.branch AS branch_id,
                       a.daos AS account_open_date,
                       a.dazs AS account_close_date,
                       /*
                       Код    Стан рахунку    Примітка
                        1    Відкритий
                        2    Закритий
                        3    Заблокований за дебетом
                        4    Заблокований за кредитом
                        5    Заблоковано за дебетом та за кредитом
                        6    Зарезервований    Використовується лише для синхронизації рахунків угод ДБО та КПК. Для рахунків в межах угод поточного рахунка та рахунків в межах депозитних угод не застосовується.
                       */
                       CASE
                          WHEN (a.dazs IS NULL AND a.blkd = 0 AND a.blkk = 0) THEN 1                -- открыт
                          WHEN a.dazs IS NOT NULL and a.dazs != a.daos and a.nbs is not null THEN 2 -- закрыт
                          WHEN a.dazs IS NOT NULL THEN 6
                          WHEN (a.blkd <> 0 AND a.blkk = 0) THEN 3
                          WHEN (a.blkk <> 0 AND a.blkd = 0) THEN 4
                          WHEN (a.blkd <> 0 AND a.blkd <> 0) THEN 5
                          WHEN a.dazs IS NOT NULL and a.dazs = a.daos and a.nbs is null THEN 6 -- зарезервирован
                       END AS account_status
      FROM accounts a, accounts_update au, staff$base sb
                 WHERE     a.acc = p_acc
                       AND a.nbs in (select nbs from ead_nbs where custtype = 3)
                       AND au.idupd = (SELECT MAX (au0.idupd)
                                         FROM accounts_update au0
                                        WHERE au0.acc = a.acc)
      and a.nbs = case when a.nbs = '2620' and substr(a.tip,1,2) <> 'W4' then null else a.nbs end                                              
                       AND au.doneby = sb.logname(+))
        loop
          l_ACC_Instance_Rec.rnk                       := ead_integration.split_key(i.rnk, i.kf);
          l_ACC_Instance_Rec.agr_type                  := rAccAgrParam.agr_type;
          l_ACC_Instance_Rec.agr_code                  := ead_integration.split_key(rAccAgrParam.agr_code, i.kf);
          l_ACC_Instance_Rec.agr_number                := rAccAgrParam.agr_number;
          l_ACC_Instance_Rec.account_type              := rAccAgrParam.acc_type;
          l_ACC_Instance_Rec.account_number            := i.account_number;
          l_ACC_Instance_Rec.account_currency          := i.account_currency;
          l_ACC_Instance_Rec.account_mfo               := i.account_mfo;
          l_ACC_Instance_Rec.account_open_date         := i.account_open_date;
          l_ACC_Instance_Rec.account_close_date        := i.account_close_date;
          l_ACC_Instance_Rec.account_status            := i.account_status;
--          l_ACC_Instance_Rec.account_is_remote_control := i.account_is_remote_control;
          l_ACC_Instance_Rec.created                   := i.created;
          l_ACC_Instance_Rec.changed                   := i.changed;
          l_ACC_Instance_Rec.user_login                := i.user_login;
          l_ACC_Instance_Rec.user_fio                  := i.user_fio;
          l_ACC_Instance_Rec.branch_id                 := i.branch_id;

          if l_ACC_Instance_Rec.agr_code is null then
            raise_application_error(-20001, 'Код угоди не заповнений [agr_code]');
          end if;

          pipe row(l_ACC_Instance_Rec);
        end loop;
      end;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Act.GetInstance
   -----------------------------------------------------------------------
   FUNCTION get_Act_Instance_Rec (p_rnk customer.rnk%TYPE)
      RETURN Act_Instance_Set
      PIPELINED
   is
    l_Act_Instance_Rec Act_Instance_Rec;
   begin
    bc.go('/');
    for i in (SELECT vd.rnk, sb.branch AS branch_id, sb.logname AS user_login, sb.fio AS user_fio, vd.chgdate AS actual_date
                FROM (SELECT p_rnk as rnk, max(chgdate) as chgdate, max(userid) keep(dense_rank first order by chgdate desc nulls last) as userid
                         FROM bars.PERSON_VALID_DOCUMENT_UPDATE WHERE rnk = p_rnk AND doc_state = 1) vd
                left outer join bars.STAFF$BASE sb on vd.userid = sb.id(+))
    loop
        l_Act_Instance_Rec.rnk          := ead_integration.split_key (i.rnk);
        l_Act_Instance_Rec.branch_id    := i.branch_id;
        l_Act_Instance_Rec.user_login   := i.user_login;
        l_Act_Instance_Rec.user_fio     := i.user_fio;
        l_Act_Instance_Rec.actual_date  := i.actual_date;

        PIPE ROW (l_Act_Instance_Rec);
    end loop;

   end;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.GercClient.GetInstance!!!
   -----------------------------------------------------------------------

begin
   get_dkbo_settings(g_type_id, g_state_id);
END ead_integration;
/
show errors



prompt ***  grants on ead_integration ***
grant execute on bars.ead_integration to bars_access_defrole;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ead_integration.sql =========*** End
 PROMPT ===================================================================================== 
 
