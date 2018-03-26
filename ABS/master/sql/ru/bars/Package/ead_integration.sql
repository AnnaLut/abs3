 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ead_integration.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.EAD_INTEGRATION 
IS
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 2.2   01.10.2017';
   
   
    type TAccAgrParam is record

   (
     agr_code  specparam.nkd%type,
     agr_number  string(50),
     acc_type  string(50),
     agr_type  string(50),
     agr_date  string(50),
     agr_status  number,
--     p_parent_agr_code out varchar2,
     parent_agr_type string(50)
   );
   rAccAgrParam TAccAgrParam;
   

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;
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
      id             dpt_deposit.deposit_id%TYPE,
      agreement_id   ead_docs.agr_id%TYPE,
      doc_type       ead_docs.type_id%TYPE,
      user_login     staff$base.logname%TYPE,
      user_fio       staff$base.fio%TYPE,
      branch_id      ead_docs.crt_branch%TYPE,
      struct_code    ead_docs.ea_struct_id%TYPE,
      changed        ead_docs.crt_date%TYPE,
      created        ead_docs.crt_date%TYPE,
      pages_count    ead_docs.page_count%TYPE,
      binary_data    ead_docs.scan_data%TYPE,
      rnk            customer.rnk%TYPE,
      linkedrnk      NUMBER,
      doc_request_number    CUST_REQUESTS.REQ_ID%type
   );

   TYPE Doc_Instance_Set IS TABLE OF Doc_Instance_Rec;

   FUNCTION get_Doc_Instance (p_doc_id ead_docs.id%TYPE)
      RETURN Doc_Instance_Set
      PIPELINED;

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
      document_number   person.numdoc%TYPE,
      client_data       VARCHAR2 (500)
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
      branch_id         branch.branch%TYPE,
      rnk               customer.rnk%TYPE,
      changed           DATE,
      created           DATE,
      client_type       custtype.custtype%TYPE,
      client_name       customer.nmk%TYPE,
      inn_edrpou        customer.okpo%TYPE,
      user_login        staff$base.logname%TYPE,
      user_fio          staff$base.fio%TYPE,
      actualized_date   customer_update.chgdate%TYPE,
      actualized_by     customer_update.doneby%TYPE
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
   (
      agr_code         dpt_deposit_clos.deposit_id%TYPE,
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         VARCHAR2 (50),
      agr_status       SMALLINT,
      agr_number       dpt_deposit_clos.nd%TYPE,
      agr_date_open    dpt_deposit_clos.dat_begin%TYPE,
      agr_date_close   dpt_deposit_clos.bdate%TYPE,
      account_number   accounts.nls%TYPE
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
      agr_code         dpt_deposit_clos.deposit_id%TYPE,
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         VARCHAR2 (10),
      agr_status       SMALLINT,
      agr_number       dpt_deposit_clos.nd%TYPE,
      agr_date_open    dpt_deposit_clos.dat_begin%TYPE,
      agr_date_close   dpt_deposit_clos.bdate%TYPE,
      account_number   accounts.nls%TYPE
   );

   TYPE AgrBPK_Instance_Set IS TABLE OF AgrBPK_Instance_Rec;

   FUNCTION get_AgrBPK_Instance_Set (p_agr_id w4_acc_update.nd%TYPE)
      RETURN AgrBPK_Instance_Set
      PIPELINED;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.UAgr.GetInstance
   -----------------------------------------------------------------------
   TYPE UAgrDPU_Instance_Rec IS RECORD
   (
      agr_code         dpu_deal.dpu_id%TYPE,
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      client_type      custtype.custtype%TYPE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         VARCHAR2 (10),
      agr_status       SMALLINT,
      agr_number       dpu_deal.nd%TYPE,
      agr_date_open    dpu_deal.datz%TYPE,
      agr_date_close   DATE
   );

   TYPE UAgrDPU_Instance_Set IS TABLE OF UAgrDPU_Instance_Rec;

   FUNCTION get_UAgrDPU_Instance_Set (p_dpu_id dpu_deal.dpu_id%TYPE)
      RETURN UAgrDPU_Instance_Set
      PIPELINED;

   TYPE UAgrACC_Instance_Rec IS RECORD
   (
      agr_code         specparam.nkd%TYPE,
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      client_type      custtype.custtype%TYPE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         VARCHAR2 (10),
      agr_status       SMALLINT,
      agr_number       specparam.nkd%TYPE,
      agr_date_open    accounts.daos%TYPE,
      agr_date_close   accounts.dazs%TYPE
   );

   TYPE UAgrACC_Instance_Set IS TABLE OF UAgrACC_Instance_Rec;

   FUNCTION get_UAgrACC_Instance_Set (p_acc accounts.acc%TYPE)
      RETURN UAgrACC_Instance_Set
      PIPELINED;


   TYPE UAgrDPTOLD_Instance_Rec IS RECORD
   (
      agr_code         specparam.nkd%TYPE,
      rnk              customer.rnk%TYPE,
      changed          DATE,
      created          DATE,
      client_type      custtype.custtype%TYPE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         VARCHAR2 (10),
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
      client_type      custtype.custtype%TYPE,
      branch_id        branch.branch%TYPE,
      user_login       staff$base.logname%TYPE,
      user_fio         staff$base.fio%TYPE,
      agr_type         VARCHAR2 (10),
      agr_status       int,
      agr_number       varchar2(100),
      agr_date_open    accounts.daos%TYPE,
      agr_date_close   accounts.dazs%TYPE
   );

   TYPE UAgrDBO_Instance_Set IS TABLE OF UAgrDBO_Instance_Rec;

   FUNCTION get_UAgrDBO_Instance_Set (p_rnk customer.rnk%TYPE)
      RETURN UAgrDBO_Instance_Set
      PIPELINED;
   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Acc.GetInstance
   -----------------------------------------------------------------------
   TYPE ACC_Instance_Rec IS RECORD
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
      agr_type         VARCHAR2 (10),
      remote_controled number(1)
   );

   TYPE ACC_Instance_Set IS TABLE OF ACC_Instance_Rec;
   function get_ACC_Instance_Set (p_agr_type string, p_acc accounts.acc%type) return ACC_Instance_Set pipelined;
   
  --UACC_ RESERV 26.03.2018
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
      agr_type         VARCHAR2 (10),
      remote_controled number(1)
   );

   TYPE UACC_Instance_Set IS TABLE OF UACC_Instance_Rec;
 --  function get_UACC_Instance_Set (p_agr_type string, p_acc accounts.acc%type) return UACC_Instance_Set pipelined;
   function get_UACCRsrv_Instance_Set (p_agr_type string, p_rsrv_id accounts_rsrv.rsrv_id%type) return UACC_Instance_Set pipelined;
 
  

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



CREATE OR REPLACE PACKAGE BODY BARS.EAD_INTEGRATION
IS
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 2.4   16.01.2018';

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
   FUNCTION get_Doc_Instance(p_doc_id ead_docs.id%Type)
      RETURN Doc_Instance_Set
      PIPELINED
   IS
    l_Doc_Instance_Rec  Doc_Instance_Rec;
   BEGIN
    FOR i IN ( SELECT id,
               agreement_id,
               doc_type,
               user_login,
               user_fio,
               branch_id,
               struct_code,
               changed,
               created,
               NVL (pages_count, 1) AS pages_count,
               binary_data,
               NVL (rnk, linkedrnk) AS rnk,
--               CASE WHEN rnk <> linkedrnk THEN linkedrnk ELSE NULL END AS linkedrnk,
               nullif(linkedrnk, rnk) as linkedrnk,
               (CASE
                   WHEN STRUCT_CODE = 146 THEN
                   (SELECT max(T1.REQ_ID) FROM CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL(rnk, linkedrnk) AND T1.REQ_STATE=0 and T1.REQ_TYPE =0 )
                   WHEN (STRUCT_CODE BETWEEN 221 AND 222) and (binary_data is not null)
                   THEN (SELECT max(T1.REQ_ID) FROM bars.CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL(linkedrnk, rnk) and T1.REQ_TYPE in (1,2) )
                   WHEN STRUCT_CODE BETWEEN 223 AND 224 THEN
                   (SELECT max(T1.REQ_ID) FROM bars.CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL(linkedrnk, rnk) and T1.REQ_TYPE in (1,2) )
                   WHEN STRUCT_CODE = 213 then
                   (SELECT max(T1.REQ_ID) FROM CUST_REQUESTS T1 WHERE T1.TRUSTEE_RNK = NVL (rnk, linkedrnk) AND T1.REQ_STATE=0 and trunc(T1.REQ_BDATE) = gl.bd )
               ELSE null END) AS doc_request_number
          FROM (SELECT d.id,
                       d.rnk AS linkedrnk,
                       d.agr_id AS agreement_id,
                       LOWER (type_id) AS doc_type,
                       sb.logname AS user_login,
                       sb.fio AS user_fio,
                       d.crt_branch AS branch_id,
                       d.ea_struct_id AS struct_code,
                       d.crt_date AS changed,
                       d.crt_date AS created,
                       d.page_count AS pages_count,
                       d.scan_data AS binary_data,
--                       (SELECT DISTINCT FIRST_VALUE (dds.rnk) OVER (ORDER BY idupd DESC) FROM dpt_deposit_clos dds WHERE dds.deposit_id = d.agr_id) AS rnk
                       (select min(rnk) keep(dense_rank last order by idupd) from bars.dpt_deposit_clos dds where dds.deposit_id = d.agr_id) as rnk
                  FROM ead_docs d, staff$base sb
                 WHERE d.id = p_doc_id AND d.crt_staff_id = sb.id
--                   AND (not exists (select 1 from dpt_deposit_clos where deposit_id = d.agr_id and wb='Y')
--                      or (d.ea_struct_id in (541,542,543) and d.scan_data is not null))
           ))
    loop
        l_Doc_Instance_Rec.id            :=  i.id;
        l_Doc_Instance_Rec.agreement_id  :=  i.agreement_id;
        l_Doc_Instance_Rec.doc_type      :=  i.doc_type;
        l_Doc_Instance_Rec.user_login    :=  i.user_login;
        l_Doc_Instance_Rec.user_fio      :=  i.user_fio;
        l_Doc_Instance_Rec.branch_id     :=  i.branch_id;
        l_Doc_Instance_Rec.struct_code   :=  i.struct_code;
        l_Doc_Instance_Rec.changed       :=  i.changed;
        l_Doc_Instance_Rec.created       :=  i.created;
        l_Doc_Instance_Rec.pages_count   :=  i.pages_count;
        l_Doc_Instance_Rec.binary_data   :=  i.binary_data;
        l_Doc_Instance_Rec.rnk           :=  i.rnk;
        l_Doc_Instance_Rec.linkedrnk     :=  i.linkedrnk;
        l_Doc_Instance_Rec.doc_request_number     :=  i.doc_request_number;

        PIPE ROW (l_Doc_Instance_Rec);
    end loop;
   END;

 -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Client.GetInstance      BMS.Method = SetClientData
   -----------------------------------------------------------------------

   FUNCTION get_Client_Instance (p_rnk customer.rnk%TYPE)
      RETURN Client_Instance_Set
      PIPELINED
   is
    l_Client_Instance_Rec Client_Instance_Rec;
   begin

    for i in (  SELECT c.rnk,
               (SELECT NVL (MAX (chgdate), C.DATE_ON)
                  FROM customer_update
                 WHERE rnk = c.rnk)
                  AS changed,
               c.date_on AS created,
               c.branch AS branch_id,
               NVL ( (SELECT sb.logname
                        FROM staff$base sb, customer_update cu
                       WHERE     cu.doneby = sb.logname
                             AND cu.idupd = (SELECT MAX (cu.idupd)
                                               FROM customer_update cu
                                              WHERE cu.rnk = c.rnk)),
                    'BARS')
                  AS user_login,
               NVL ( (SELECT sb.fio
                        FROM staff$base sb, customer_update cu
                       WHERE     cu.doneby = sb.logname
                             AND cu.idupd = (SELECT MAX (cu.idupd)
                                               FROM customer_update cu
                                              WHERE cu.rnk = c.rnk)),
                    'Користувач BARS')
                  AS user_fio,
               DECODE (c.custtype,  1, 3,  2, 2,  3, 1) AS client_type,
               c.nmk AS fio,
               c.okpo AS inn,
               p.bday AS birth_date,
               p.passp AS document_type,
               p.ser AS document_series,
               p.numdoc AS document_number,
               NULL AS client_data
          FROM customer c, person p
         WHERE c.rnk = p_rnk
           AND c.rnk = p.rnk
           AND c.custtype = 3
           AND c.SED <> 91)
    loop

        l_Client_Instance_Rec.rnk               := i.rnk;
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
        l_Client_Instance_Rec.client_data       := i.client_data;

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
/*
    for i in (  SELECT DISTINCT rnkfrom AS mrg_rnk
                  FROM (SELECT rn.rnkfrom, rn.rnkto
                          FROM rnk2nls rn
                        UNION ALL
                        SELECT rt.rnkfrom, rt.rnkto
                          FROM rnk2tbl rt)
                 WHERE rnkfrom != p_rnk and rnkto = p_rnk order by rnkfrom desc)
*/
    for i in (select rnk as mrg_rnk from customer
               where rnk in (select rnkfrom from rnk2nls where rnkfrom != p_rnk and rnkto = p_rnk)
                 and rnk in (select rnkfrom from rnk2tbl where rnkfrom != p_rnk and rnkto = p_rnk)
                 and date_off is not null)
    loop
        l_MergedRNK_Rec.mrg_rnk := i.mrg_rnk;
        PIPE ROW (l_MergedRNK_Rec);
    end loop;
   end;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.UClient.GetInstance        BMS.Method = SetClientDataU
   -----------------------------------------------------------------------
   FUNCTION get_UClient_Instance (p_rnk customer.rnk%TYPE)
      RETURN UClient_Instance_Set
      PIPELINED
   is
    l_UClient_Instance_Rec UClient_Instance_Rec;
   begin
    for i in(SELECT c.branch AS                                  branch_id,
                    c.rnk AS                                     rnk,
                    cu.chgdate AS                                changed,
                    c.date_on AS                                 created,
                    DECODE (c.custtype,  1, 2,  2, 2,  3, 3) AS  client_type,
                    c.nmk AS                                     client_name,
                    c.okpo AS                                    inn_edrpou,
                    sb.logname AS                                user_login,
                    sb.fio AS                                    user_fio,
                    cu.chgdate AS                                actualized_date,
                    cu.doneby AS                                 actualized_by
               FROM customer c, customer_update cu, staff$base sb
              WHERE     c.rnk = p_rnk
                    AND c.rnk = cu.rnk
                    AND (c.custtype <> 3 OR (c.custtype = 3 AND c.SED = 91))
                    AND cu.idupd = (SELECT MAX (cu.idupd)
                                      FROM customer_update cu
                                     WHERE cu.rnk = c.rnk)
                    AND cu.doneby = sb.logname)

    loop
        l_UClient_Instance_Rec.branch_id       := i.branch_id;
        l_UClient_Instance_Rec.rnk             := i.rnk;
        l_UClient_Instance_Rec.changed         := i.changed;
        l_UClient_Instance_Rec.created         := i.created;
        l_UClient_Instance_Rec.client_type     := i.client_type;
        l_UClient_Instance_Rec.client_name     := i.client_name;
        l_UClient_Instance_Rec.inn_edrpou      := i.inn_edrpou;
        l_UClient_Instance_Rec.user_login      := i.user_login;
        l_UClient_Instance_Rec.user_fio        := i.user_fio;
        l_UClient_Instance_Rec.actualized_date := i.actualized_date;
        l_UClient_Instance_Rec.actualized_by   := i.actualized_by;

        PIPE ROW (l_UClient_Instance_Rec);
    end loop;

   end;

    FUNCTION get_Third_Person_Client_Set (p_rnk customer.rnk%TYPE)
      RETURN Third_Person_Client_Set
      PIPELINED
    is
        l_Third_Person_Client_Rec   Third_Person_Client_Rec;
    begin

        for i in (  SELECT t1.rel_rnk AS rnk,
                           t1.rel_id AS  personstateid,
                           T1.BDATE AS   date_begin_powers,
                           T1.EDATE AS   date_end_powers
                      FROM customer_rel t1
                     WHERE t1.rnk = p_rnk
                       AND t1.rel_id > 0
                       AND t1.REL_INTEXT = 1)
        loop
            l_Third_Person_Client_Rec.rnk               := i.rnk;
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
            l_Third_Person_NonClient_Rec.id                := i.id;
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
    begin

        for i in (SELECT ddc.deposit_id AS                                                         agr_code,
                         ddc.rnk                                                                     rnk,
                         ddc.when AS                                                                 changed,
                         ddc.datz AS                                                                 created,
                         ddc.branch AS                                                               branch_id,
                         sb.logname AS                                                              user_login,
                         sb.fio AS                                                                  user_fio,
/*                       case when d.wb = 'N' then 'deposit'
                              when d.wb = 'Y' then 'dep_online_fo'
                         end       AS                                                               agr_type,
*/                       'deposit' AS                                                               agr_type,
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
                   join dpt_deposit d on ddc.deposit_id = d.deposit_id
                   left outer join staff$base sb on ddc.actiion_author = sb.id
                  WHERE ddc.deposit_id = p_agr_id
--                    and d.wb = 'N'
                  ORDER BY ddc.idupd DESC)
        loop
            l_AgrDPT_Instance_Rec.agr_code        := i.agr_code;
            l_AgrDPT_Instance_Rec.rnk             := i.rnk;
            l_AgrDPT_Instance_Rec.changed         := i.changed;
            l_AgrDPT_Instance_Rec.created         := i.created;
            l_AgrDPT_Instance_Rec.branch_id       := i.branch_id;
            l_AgrDPT_Instance_Rec.user_login      := i.user_login;
            l_AgrDPT_Instance_Rec.user_fio        := i.user_fio;
            l_AgrDPT_Instance_Rec.agr_type        := i.agr_type;
            l_AgrDPT_Instance_Rec.agr_status      := i.agr_status;
            l_AgrDPT_Instance_Rec.agr_number      := i.agr_number;
            l_AgrDPT_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_AgrDPT_Instance_Rec.agr_date_close  := i.agr_date_close;
            l_AgrDPT_Instance_Rec.account_number  := i.account_number;

            PIPE ROW (l_AgrDPT_Instance_Rec);
        end loop;

    end;

    FUNCTION get_AgrDPT_LinkedRnk_Set (p_agr_id dpt_deposit.deposit_id%TYPE)
    RETURN AgrDPT_LinkedRnk_Set
    PIPELINED
    is
        l_AgrDPT_LinkedRnk_Rec  AgrDPT_LinkedRnk_Rec;
    begin
     for i in ( SELECT DISTINCT
                       t.rnk_tr AS              rnk,
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
                SELECT t1.rnk AS rnk, 3 AS linkpersonstateid
                  FROM (SELECT *
                          FROM dpt_deposit_clos
                         WHERE deposit_id = p_agr_id AND ACTION_ID = 0 AND ROWNUM = 1 and wb='N') t1,
                       (SELECT *
                          FROM (  SELECT *
                                    FROM dpt_deposit_clos
                                   WHERE deposit_id = p_agr_id and wb='N'
                                ORDER BY idupd DESC)
                         WHERE ROWNUM = 1) t2
                 WHERE t1.rnk <> t2.rnk)
         loop
            l_AgrDPT_LinkedRnk_Rec.rnk  :=  i.rnk;
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

        for i in ( SELECT agr_code,
                         rnk,
                         (case when daos between trunc(chgdate) and bankdate() then daos else chgdate end) AS changed,
                         DAOS AS created,
                         branch AS branch_id,
                         user_login,
                         user_fio,
                         'bpk_fo' AS agr_type,
                         CASE
                            WHEN DAZS IS NULL THEN 1
                            WHEN DAZS < SYSDATE THEN 0
                            ELSE 1
                         END
                            AS agr_status,
                         agr_code AS agr_number,
                         NVL (dat_begin, daos) AS agr_date_open,
                         DAZS AS agr_date_close,
                         nls AS account_number
                from (  
                SELECT w4.idupd, w4.nd as agr_code, w4.dat_begin, w4.chgdate,
                       MAX (w4.idupd) OVER (ORDER BY w4.acc_pk, w4.chgdate DESC) max_idupd,
                       a.branch, a.rnk, a.nls,
                       TRUNC (a.daos) daos, a.dazs,
                       sb.logname AS user_login, sb.fio AS user_fio
                  FROM w4_acc_update w4, staff$base sb, accounts a
                 WHERE w4.nd = p_agr_id AND w4.DONEBY = sb.id AND a.acc = w4.acc_pk) 
                 where idupd = max_idupd)
        loop
            l_AgrBPK_Instance_Rec.agr_code        := i.agr_code;
            l_AgrBPK_Instance_Rec.rnk             := i.rnk;
            l_AgrBPK_Instance_Rec.changed         := i.changed;
            l_AgrBPK_Instance_Rec.created         := i.created;
            l_AgrBPK_Instance_Rec.branch_id       := i.branch_id;
            l_AgrBPK_Instance_Rec.user_login      := i.user_login;
            l_AgrBPK_Instance_Rec.user_fio        := i.user_fio;
            l_AgrBPK_Instance_Rec.agr_type        := i.agr_type;
            l_AgrBPK_Instance_Rec.agr_status      := i.agr_status;
            l_AgrBPK_Instance_Rec.agr_number      := i.agr_number;
            l_AgrBPK_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_AgrBPK_Instance_Rec.agr_date_close  := i.agr_date_close;
            l_AgrBPK_Instance_Rec.account_number  := i.account_number;

            PIPE ROW (l_AgrBPK_Instance_Rec);
        end loop;

    end;

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.UAgr.GetInstance      BMS.Method = SetAgreementDataU
   -----------------------------------------------------------------------
   FUNCTION get_UAgrDPU_Instance_Set (p_dpu_id dpu_deal.dpu_id%TYPE)
      RETURN UAgrDPU_Instance_Set
      PIPELINED
     is
        l_UAgrDPU_Instance_Rec   UAgrDPU_Instance_Rec;
    begin

        for i in (  SELECT dd.dpu_id AS agr_code,
                           dd.rnk AS rnk,
                           ddu.dateu AS changed,
                           dd.dat_begin AS created,
                           (SELECT DECODE (c.custtype,  1, 2,  2, 2,  3, 3)
                              FROM customer c
                             WHERE c.rnk = dd.rnk)
                              AS client_type,
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
                           AND ddu.useru = sb.id
                           AND ddu.idu = (SELECT MAX (ddu0.idu)
                                            FROM dpu_deal_update ddu0
                                           WHERE ddu0.dpu_id = dd.dpu_id))
        loop
            l_UAgrDPU_Instance_Rec.agr_code        := i.agr_code;
            l_UAgrDPU_Instance_Rec.rnk             := i.rnk;
            l_UAgrDPU_Instance_Rec.changed         := i.changed;
            l_UAgrDPU_Instance_Rec.created         := i.created;
            l_UAgrDPU_Instance_Rec.client_type     := i.client_type;
            l_UAgrDPU_Instance_Rec.branch_id       := i.branch_id;
            l_UAgrDPU_Instance_Rec.user_login      := i.user_login;
            l_UAgrDPU_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrDPU_Instance_Rec.agr_type        := i.agr_type;
            l_UAgrDPU_Instance_Rec.agr_status      := i.agr_status;
            l_UAgrDPU_Instance_Rec.agr_number      := i.agr_number;
            l_UAgrDPU_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_UAgrDPU_Instance_Rec.agr_date_close  := i.agr_date_close;

            PIPE ROW (l_UAgrDPU_Instance_Rec);
        end loop;

    end;

    procedure get_accagr_param(p_acc in accounts.acc%type,
                               p_agr_code out specparam.nkd%type,
                               p_acc_type out varchar2,
                               p_agr_type out varchar2,
                               p_agr_date out varchar2,
                               p_agr_status out number)
   is
        l_agr_code specparam.nkd%type;
        l_agr_type varchar2(10);
        l_acc_type varchar2(10);
        l_agr_status number(2);
        l_NDBO varchar2(40);
        l_NKD  varchar2(40);
        l_DDBO varchar2(50);
        l_SDBO varchar2(50);
        l_daos date;
        l_dazs date;
        l_nbs accounts.nbs%type;
   begin

      begin
            SELECT kl.get_customerw (rnk, 'NDBO'),
                   kl.get_customerw (rnk, 'DDBO'),
                   kl.get_customerw (rnk, 'SDBO'),
                   daos,
                   dazs,
                   nvl(nbs,substr(nls,1,4)),
                   (SELECT nkd
                      FROM specparam
                     WHERE acc = p_acc)
              INTO l_NDBO,
                   l_DDBO,
                   l_SDBO,
                   l_daos,
                   l_dazs,
                   l_nbs,
                   l_NKD
              FROM accounts
             WHERE acc = p_acc;
        end;
        if (l_NDBO is not null and l_daos >= to_date(replace(l_DDBO,'.','/'),'dd/mm/yyyy'))
        then
        l_agr_code     := l_NDBO;
        l_agr_status   := 10;--case when l_dazs is null then 10 else 0 end;
        l_agr_type     := tools.iif(l_SDBO is not null, 'dbo_uo');
         p_agr_code:= l_agr_code;
         p_agr_status := l_agr_status;
         p_agr_date := l_DDBO;
        end if;

          if l_nbs in ('2655', '2605') then
            l_acc_type := 'kpk_uo';
          elsif l_nbs in ('2525', '2546', '2610', '2615', '2651', '2652') then
            l_acc_type := 'dep_uo';
          else
            l_acc_type:= 'pr_uo';
          end if;
         p_acc_type := l_acc_type;
--         p_agr_type := nvl(l_agr_type,l_acc_type);
         p_agr_type := case when l_acc_type ='dep_uo' then 'dep_uo' else nvl(l_agr_type,l_acc_type) end;   --- temporary until dkbo
   end get_accagr_param;

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

    FUNCTION get_UAgrDBO_Instance_Set (p_rnk customer.rnk%TYPE)
      RETURN UAgrDBO_Instance_Set
      PIPELINED
    is
       l_UAgrDBO_Instance_Rec   UAgrDBO_Instance_Rec;
        l_agr_code specparam.nkd%type;
        l_agr_type varchar2(10);
        l_agr_date varchar2(10);
        l_agr_status number(2);
     begin
      get_rnkagr_param(p_rnk => p_rnk,
                       p_agr_code => l_agr_code,
                       p_agr_type => l_agr_type,
                       p_agr_date => l_agr_date,
                       p_agr_status => l_agr_status);
        bars_audit.info('get_UAgrDBO_Instance_Set.get_rnkagr_param: l_agr_code='|| l_agr_code ||', l_agr_type='||l_agr_type||',l_agr_date = '||l_agr_date||',l_agr_status='||l_agr_status );
        for i in (  with custupd as (select doneby, chgdate, s.logname, s.fio from customerw_update cu, staff$base s where cu.rnk = p_rnk and cu.tag = 'NDBO' and s.LOGNAME = cu.doneby)
                    select  l_agr_code as agr_code,
                            rnk as rnk,
                            custupd.chgdate as changed,
                            TO_DATE(l_agr_date,'DD.MM.YYYY') as created,
                            DECODE (custtype,  1, 2,  2, 2,  3, 3) as client_type,
                            branch as branch_id,
                            custupd.logname as user_login,
                            custupd.fio as user_fio,
                            l_agr_type as agr_type,
                            l_agr_status as agr_status,
                            l_agr_code as agr_number,
                            TO_DATE(l_agr_date,'DD.MM.YYYY') as agr_date_open,
                            null  as  agr_date_close
                            from customer c, custupd
                            where c.rnk = p_rnk
                 )
        loop
            l_UAgrDBO_Instance_Rec.agr_code        := i.agr_code;
            l_UAgrDBO_Instance_Rec.rnk             := i.rnk;
            l_UAgrDBO_Instance_Rec.changed         := i.changed;
            l_UAgrDBO_Instance_Rec.created         := i.created;
            l_UAgrDBO_Instance_Rec.client_type     := i.client_type;
            l_UAgrDBO_Instance_Rec.branch_id       := i.branch_id;
            l_UAgrDBO_Instance_Rec.user_login      := i.user_login;
            l_UAgrDBO_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrDBO_Instance_Rec.agr_type        := i.agr_type;
            l_UAgrDBO_Instance_Rec.agr_status      := i.agr_status;
            l_UAgrDBO_Instance_Rec.agr_number      := i.agr_number;
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
        l_agr_code specparam.nkd%type;
        l_agr_type varchar2(10);
        l_acc_type varchar2(10);
        l_agr_date varchar2(10);
        l_agr_status number(2);
    begin
      get_accagr_param(p_acc => p_acc,
                       p_agr_code => l_agr_code,
                       p_acc_type => l_acc_type,
                       p_agr_type => l_agr_type,
                       p_agr_date => l_agr_date,
                       p_agr_status => l_agr_status);
--     bars_audit.info('get_UAgrACC_Instance_Set.get_accagr_param: l_agr_code='|| l_agr_code  ||', l_acc_type='||l_acc_type||', l_agr_type='||l_agr_type||',l_agr_date = '||l_agr_date||',l_agr_status='||l_agr_status );
        for i in (  SELECT agr_code, rnk, changed, daos AS created,
                           EAD_PACK.GET_CUSTTYPE (rnk) AS client_type,
                           branch AS branch_id, user_login, user_fio,
                           NVL ( l_agr_type, 'pr_uo') AS agr_type,
                           NVL ( l_agr_status, CASE WHEN dazs IS NULL OR dazs > SYSDATE THEN 1 ELSE 0 END) AS agr_status,
                           agr_code as  agr_number,
                           NVL (TO_DATE ( l_agr_date, 'dd.mm.yyyy'), daos) AS agr_date_open,
                           CASE WHEN dazs IS NULL OR dazs > SYSDATE THEN TO_DATE (NULL) ELSE dazs END AS agr_date_close
                      FROM (SELECT au.idupd,
                                   MAX (au.idupd) OVER (ORDER BY au.acc, au.chgdate DESC) max_idupd,               
                                   a.branch, a.rnk, TRUNC(a.daos) daos, a.dazs,
                                   coalesce (l_agr_code, (SELECT nkd FROM specparam sp WHERE a.acc = sp.acc)) agr_code,
                                   au.chgdate changed,
                                   sb.logname AS user_login,
                                   sb.fio AS user_fio
                              FROM accounts a, 
                                   accounts_update au, 
                                   staff$base sb
                             WHERE a.acc = p_acc 
                               AND a.acc = au.acc 
                               AND au.doneby = sb.logname)
                     WHERE max_idupd = idupd)
        loop
            l_UAgrACC_Instance_Rec.agr_code        := i.agr_code;
            l_UAgrACC_Instance_Rec.rnk             := i.rnk;
            l_UAgrACC_Instance_Rec.changed         := i.changed;
            l_UAgrACC_Instance_Rec.created         := i.created;
            l_UAgrACC_Instance_Rec.client_type     := i.client_type;
            l_UAgrACC_Instance_Rec.branch_id       := i.branch_id;
            l_UAgrACC_Instance_Rec.user_login      := i.user_login;
            l_UAgrACC_Instance_Rec.user_fio        := i.user_fio;
            l_UAgrACC_Instance_Rec.agr_type        := i.agr_type;
            l_UAgrACC_Instance_Rec.agr_status      := i.agr_status;
            l_UAgrACC_Instance_Rec.agr_number      := i.agr_number;
            l_UAgrACC_Instance_Rec.agr_date_open   := i.agr_date_open;
            l_UAgrACC_Instance_Rec.agr_date_close  := i.agr_date_close;

            PIPE ROW (l_UAgrACC_Instance_Rec);
        end loop;

    end;

    FUNCTION get_UAgrDPTOLD_Instance_Set (p_nls accounts.nls%TYPE, p_daos accounts.daos%type, p_acc accounts.acc%type)
      RETURN UAgrDPTOLD_Instance_Set
      PIPELINED
     is
        l_UAgrDPTOLD_Instance_Rec  UAgrDPTOLD_Instance_Rec;
    begin

        for i in (  SELECT t.agr_code,
                           t.rnk,
                           au.chgdate AS changed,
                           t.created,
                           EAD_PACK.GET_CUSTTYPE (t.rnk) AS client_type,                              
                           t.branch_id,
                           sb.logname AS user_login,
                           sb.fio AS user_fio,
                           t.agr_type,
                           t.agr_status,
                           t.agr_number,
                           t.agr_date_open,
                           t.agr_date_close
                      FROM (  SELECT    TO_CHAR (TRUNC (a.daos), 'yyyymmdd') || '|' || a.nls || '|' || TO_CHAR (a.kv) AS agr_code,
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
                                     A.RNK,
                                     A.NLS,
                                     A.KV) t,
                           accounts_update au,
                           staff$base sb
                     WHERE t.max_idupd = au.idupd AND au.doneby = sb.logname)
        loop
            l_UAgrDPTOLD_Instance_Rec.agr_code        := i.agr_code;
            l_UAgrDPTOLD_Instance_Rec.rnk             := i.rnk;
            l_UAgrDPTOLD_Instance_Rec.changed         := i.changed;
            l_UAgrDPTOLD_Instance_Rec.created         := i.created;
            l_UAgrDPTOLD_Instance_Rec.client_type     := i.client_type;
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

   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Acc.GetInstance       BMS.Method = SetAccountDataU
   -----------------------------------------------------------------------

    function get_ACC_Instance_Set (p_agr_type string, p_acc accounts.acc%type) return ACC_Instance_Set pipelined is
     l_ACC_Instance_Rec ACC_Instance_Rec;
     l_agr_code specparam.nkd%type;
     l_acc_type varchar2(10);
     l_agr_type varchar2(10);
     l_agr_date varchar2(10);
     l_agr_status number(2);
    BEGIN

    get_accagr_param(p_acc => p_acc,
                     p_agr_code => l_agr_code,
                     p_acc_type => l_acc_type,
                     p_agr_type => l_agr_type,
                     p_agr_date => l_agr_date,
                     p_agr_status => l_agr_status);

     for i in ( SELECT a.rnk AS rnk,
                       au.chgdate AS changed,
                       nvl(TO_DATE(l_agr_date,'DD.MM.YYYY'), a.daos) AS created,
                       sb.logname AS user_login,
                       sb.fio AS user_fio,
                       a.nls AS account_number,
                       a.kv AS currency_code,
                       f_ourmfo_g () AS mfo,
                       a.branch AS branch_id,
                       a.daos AS open_date,
                       a.dazs AS close_date,
                       CASE
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
                          THEN nvl(l_agr_code, (SELECT TO_CHAR (MAX (sp.nkd))
                                FROM specparam sp
                               WHERE sp.acc = a.acc))
                          WHEN ( p_agr_type = 'DPT_OLD')
                          THEN
                             (SELECT TO_CHAR (MAX (sp.nkd))
                                FROM specparam sp
                               WHERE sp.acc = a.acc)
                       END
                          AS agr_number,
                       CASE
                          WHEN ( p_agr_type = 'DPT')
                          THEN
                             (SELECT TO_CHAR (MAX (da.dpuid))
                                FROM dpu_accounts da
                               WHERE da.accid = a.acc)
                          WHEN ( p_agr_type = 'ACC')
                           THEN nvl(l_agr_code, (SELECT TO_CHAR (MAX (sp.nkd))
                                FROM specparam sp
                               WHERE sp.acc = a.acc))
                          WHEN ( p_agr_type = 'DPT_OLD')
                          THEN
                                TO_CHAR (a.daos, 'yyyymmdd') || '|'|| a.nls || '|' || TO_CHAR (a.kv)
                       END
                          AS agr_code,
                    /*Поточні рахунки:
                    2512, 2513, 2520, 2523, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2560, 2561, 2562, 2565, 2570, 2571,2572, 2600, 2601, 2602, 2603, 2604, 2640, 2641, 2642, 2643, 2644, 2650.
                    Депозитніе:
                    2610, 2615, 2651 ,2652, 2600 з типом DEP та ОБ22=03, 2650 з типом DEP та ОБ22=03*/
                         case WHEN
                         (a.nbs ='2650' and a.tip = 'DEP' and a.ob22 = '03' )
                         or (a.nbs ='2600' and a.tip = 'DEP' and a.ob22 in ('03','04','05','06','07','08','09','11'))
                         or (a.nbs in ('2610', '2615', '2651' ,'2652', '2525'))
                         THEN 'dep_uo'
                            ELSE nvl(l_acc_type,'pr_uo') END
                          AS account_type
                  FROM accounts a, accounts_update au, staff$base sb
                 WHERE     a.acc = p_acc
                       AND au.idupd = (SELECT MAX (au0.idupd)
                                         FROM accounts_update au0
                                        WHERE au0.acc = a.acc)
                       AND au.doneby = sb.logname)
     loop
        l_ACC_Instance_Rec.rnk              := i.rnk;
        l_ACC_Instance_Rec.changed          := i.changed;
--        l_ACC_Instance_Rec.created          := i.created;
        l_ACC_Instance_Rec.user_login       := i.user_login;
        l_ACC_Instance_Rec.user_fio         := i.user_fio;
        l_ACC_Instance_Rec.account_number   := i.account_number;
        l_ACC_Instance_Rec.currency_code    := i.currency_code;
        l_ACC_Instance_Rec.mfo              := i.mfo;
        l_ACC_Instance_Rec.branch_id        := i.branch_id;
        l_ACC_Instance_Rec.open_date        := i.open_date;
        l_ACC_Instance_Rec.close_date       := i.close_date;
        l_ACC_Instance_Rec.account_status   := i.account_status;
        l_ACC_Instance_Rec.agr_number       := i.agr_number;
        l_ACC_Instance_Rec.agr_code         := i.agr_code;
        l_ACC_Instance_Rec.account_type     := i.account_type;
        l_ACC_Instance_Rec.agr_type         := l_agr_type;
        l_ACC_Instance_Rec.remote_controled := barsAQ.Ibank_Accounts.is_subscribed(p_acc);

        if l_ACC_Instance_Rec.agr_code is null then
          raise_application_error(-20001, 'Код угоди не заповнений [agr_code]'); 
        end if;

        PIPE ROW (l_ACC_Instance_Rec);
     end loop;

    END;


   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.Act.GetInstance
   -----------------------------------------------------------------------
   FUNCTION get_Act_Instance_Rec (p_rnk customer.rnk%TYPE)
      RETURN Act_Instance_Set
      PIPELINED
   is
    l_Act_Instance_Rec Act_Instance_Rec;
   begin
    for i in (SELECT vd.rnk, sb.branch AS branch_id, sb.logname AS user_login, sb.fio AS user_fio, vd.chgdate AS actual_date
                FROM (SELECT p_rnk as rnk, max(chgdate) as chgdate, max(userid) keep(dense_rank first order by chgdate desc nulls last) as userid
                         FROM bars.PERSON_VALID_DOCUMENT_UPDATE WHERE rnk = p_rnk AND doc_state = 1) vd
                inner join bars.STAFF$BASE sb on vd.userid = sb.id)
    loop
        l_Act_Instance_Rec.rnk          := i.rnk;
        l_Act_Instance_Rec.branch_id    := i.branch_id;
        l_Act_Instance_Rec.user_login   := i.user_login;
        l_Act_Instance_Rec.user_fio     := i.user_fio;
        l_Act_Instance_Rec.actual_date  := i.actual_date;

        PIPE ROW (l_Act_Instance_Rec);
    end loop;

   end;

 
  ----------------!!!!!  26.03.2018
 function get_UACCRsrv_Instance_Set (p_agr_type string, p_rsrv_id accounts_rsrv.rsrv_id%type) return UACC_Instance_Set pipelined is
     l_UACC_Instance_Rec UACC_Instance_Rec;
     l_agr_type varchar2(10);
     l_acc_type varchar2(10);
    begin
  --    bc.go('/');
  --    get_accagr_param_reserve(p_rsrv_id);

     for i in ( SELECT a.rnk,
                       a.kf,
                       kl.get_customerw (a.rnk, 'NDBO') NDBO,
                       kl.get_customerw (a.rnk, 'DDBO') DDBO,
                       kl.get_customerw (a.rnk, 'SDBO') SDBO,
                       trunc(a.crt_dt) as changed,
                       sb.logname AS user_login,
                       sb.fio AS user_fio,
                       a.nls AS account_number,
                       a.kv AS currency_code,
                       a.kf AS mfo,
                       a.branch AS branch_id,
                       trunc(a.crt_dt) as open_date,
                    --   rAccAgrParam.agr_code as agr_code,
                       kl.get_customerw (a.rnk, 'NDBO') as agr_code,
                       kl.get_customerw (a.rnk, 'NDBO') as agr_number,
                       nvl(rAccAgrParam.acc_type,'pr_uo') AS account_type
                     FROM accounts_rsrv a join staff$base sb on a.usr_id = sb.id
                   WHERE a.rsrv_id = p_rsrv_id)
     loop
    
  if (i.ndbo is not null and i.open_date >= to_date(replace(i.DDBO,'.','/'),'dd/mm/yyyy'))
        then
        l_agr_type     := tools.iif(i.SDBO is not null, 'dbo_uo');
        end if;

          if substr(i.account_number,1,4) in ('2655', '2605') then
            l_acc_type := 'kpk_uo';
          elsif substr(i.account_number,1,4) in ('2525', '2546', '2610', '2615', '2651', '2652') then
            l_acc_type := 'dep_uo';
          else
            l_acc_type := 'pr_uo';
          end if;
--         p_agr_type := nvl(l_agr_type,l_acc_type);
         l_agr_type := case when l_acc_type ='dep_uo' then 'dep_uo' else nvl(l_agr_type,l_acc_type) end;   --- temporary until dkbo
     
     
     
     
     
        l_UACC_Instance_Rec.rnk              := i.rnk; --ead_integration.split_key (i.rnk, i.kf);
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
        l_UACC_Instance_Rec.agr_number       := i.agr_number;
        l_UACC_Instance_Rec.agr_code         := i.agr_code;
        l_UACC_Instance_Rec.account_type     := l_acc_type; --i.account_type;
        l_UACC_Instance_Rec.agr_type         := l_agr_type; -- rAccAgrParam.agr_type;
        l_UACC_Instance_Rec.remote_controled := 0;

        if l_UACC_Instance_Rec.agr_code is null then
          raise_application_error(-20001, 'Код угоди не заповнений [agr_code]');
        end if;

        PIPE ROW (l_UACC_Instance_Rec);
     end loop;

    END get_UACCRsrv_Instance_Set;



   -----------------------------------------------------------------------
   -- EADService.cs         Structs.Params.GercClient.GetInstance!!!
   -----------------------------------------------------------------------

END ead_integration;
/
show errors



PROMPT *** Create  grants  EAD_INTEGRATION ***
grant EXECUTE on BARS.EAD_INTEGRATION to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ead_integration.sql =========*** End
 PROMPT ===================================================================================== 
 
