
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/xrm_integration_oe.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.XRM_INTEGRATION_OE 
IS
   title              CONSTANT VARCHAR2 (19) := 'xrm_integration_oe:';

   TYPE t_cursor IS REF CURSOR;

   g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.57 22.05.2017';

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;

   PROCEDURE open_card (p_transactionid  IN     NUMBER,
                        p_kf             IN     VARCHAR2,       -- код филиала
                        p_rnk            IN     NUMBER,
                        p_nls            IN OUT VARCHAR2,
                        p_cardcode       IN     VARCHAR2,
                        p_branch         IN     VARCHAR2,
                        p_embfirstname   IN     VARCHAR2,
                        p_emblastname    IN     VARCHAR2,
                        p_secname        IN     VARCHAR2,
                        p_work           IN     VARCHAR2,
                        p_office         IN     VARCHAR2,
                        p_wdate          IN     DATE,
                        p_salaryproect   IN     NUMBER,
                        p_term           IN     NUMBER,
                        p_branchissue    IN     VARCHAR2,
                        p_barcode        IN     VARCHAR2 DEFAULT NULL,
                        p_cobrandid      IN     VARCHAR2 DEFAULT NULL,
                        p_nd                OUT NUMBER,
                        p_daos              OUT VARCHAR2,
                        p_date_begin        OUT VARCHAR2,
                        p_status            OUT INT,
                        p_blkd              OUT INT,
                        p_blkk              OUT INT,
                        p_dkbo_num          OUT VARCHAR2,
                        p_dkbo_in           OUT VARCHAR2,
                        p_dkbo_out          OUT VARCHAR2,
                        p_acc               OUT NUMBER);

   --
   -- Создание депозитного договора
   --
   PROCEDURE open_deposit (p_transactionid  IN     NUMBER,
      p_kf              IN     VARCHAR2,                        -- код филиала
      p_branch          IN     branch.branch%TYPE,               -- відділення
      p_vidd            IN     dpt_deposit.vidd%TYPE,       -- код вида вклада
      p_rnk             IN     dpt_deposit.rnk%TYPE,        -- рег.№ вкладчика
      p_nd              IN     dpt_deposit.nd%TYPE, -- номер договора (произвольный)
      p_sum             IN     dpt_deposit.LIMIT%TYPE, -- сумма вклада пол договору
      p_nocash          IN     NUMBER,       -- БЕЗНАЛ взнос (0-НАЛ,1- БЕЗНАЛ)
      p_datz            IN     dpt_deposit.datz%TYPE, -- дата заключения договора
      p_namep           IN     dpt_deposit.name_p%TYPE,       -- получатель %%
      p_okpop           IN     dpt_deposit.okpo_p%TYPE, -- идентиф.код получателя %%
      p_nlsp            IN     dpt_deposit.nls_p%TYPE,  -- счет для выплаты %%
      p_mfop            IN     dpt_deposit.mfo_p%TYPE,   -- МФО для выплаты %%
      p_fl_perekr       IN     dpt_vidd.fl_2620%TYPE, -- флаг открытия техн.счета
      p_name_perekr     IN     dpt_deposit.nms_d%TYPE,  -- получатель депозита
      p_okpo_perekr     IN     dpt_deposit.okpo_p%TYPE, -- идентиф.код получателя депозита
      p_nls_perekr      IN     dpt_deposit.nls_d%TYPE, -- счет для возврата депозита
      p_mfo_perekr      IN     dpt_deposit.mfo_d%TYPE, -- МФО для возврата депозита
      p_comment         IN     dpt_deposit.comments%TYPE,       -- комментарий
      p_dpt_id             OUT dpt_deposit.deposit_id%TYPE, -- идентификатор договора
      p_datbegin        IN     dpt_deposit.dat_begin%TYPE DEFAULT NULL, -- дата открытия договора
      p_duration        IN     dpt_vidd.duration%TYPE DEFAULT NULL, -- длительность (мес.)
      p_duration_days   IN     dpt_vidd.duration_days%TYPE DEFAULT NULL, -- длительность (дней)
      p_rate               OUT NUMBER,
      p_nls                OUT accounts.nls%TYPE,
      p_nlsint             OUT accounts.nls%TYPE,
      p_daos               OUT VARCHAR2,
      p_dat_begin          OUT VARCHAR2,
      p_dat_end            OUT VARCHAR2,
      p_blkd               OUT accounts.blkd%TYPE,
      p_blkk               OUT accounts.blkk%TYPE,
      p_dkbo_num           OUT VARCHAR2,
      p_dkbo_in            OUT VARCHAR2,
      p_dkbo_out           OUT VARCHAR2,
	  ResultCode		   OUT INT,
      ResultMessage 	   OUT VARCHAR2);


   PROCEDURE open_customer (
      p_TransactionId    IN     NUMBER,
      p_UserLogin        IN     staff.logname%TYPE,
      p_OperationType    IN     INT, -- 1 открытие/обновление данных клиента, 0 - поиск клиента
      p_ClientType       IN     custtype.custtype%TYPE,
      p_FormType         IN     INT, -- 1,2,3 упрощенная форма, 0 полная форма
      p_kf               IN     VARCHAR2,
      p_client_name      IN     VARCHAR2,
      p_client_surname   IN     VARCHAR2,
      p_client_patr      IN     VARCHAR2,
      -------------------------------------kl.setCustomerAttr
      Custtype_          IN OUT customer.custtype%TYPE, -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
      Nd_                IN OUT customer.nd%TYPE,                -- № договора
      Nmk_               IN OUT VARCHAR2,              -- Наименование клиента
      Nmkv_              IN OUT customer.nmkv%TYPE, -- Наименование клиента международное
      Nmkk_              IN OUT customer.nmkk%TYPE, -- Наименование клиента краткое
      Adr_               IN OUT customer.adr%TYPE,            -- Адрес клиента
      Codcagent_         IN OUT customer.codcagent%TYPE,     -- Характеристика
      Country_           IN OUT customer.country%TYPE,               -- Страна
      Prinsider_         IN OUT customer.prinsider%TYPE,  -- Признак инсайдера
      Tgr_               IN OUT customer.tgr%TYPE,          -- Тип гос.реестра
      Okpo_              IN OUT customer.okpo%TYPE,                    -- ОКПО
      Stmt_              IN OUT customer.stmt%TYPE,          -- Формат выписки
      Sab_               IN OUT customer.sab%TYPE,                   -- Эл.код
      DateOn_            IN OUT customer.date_on%TYPE,     -- Дата регистрации
      Taxf_              IN OUT customer.taxf%TYPE,           -- Налоговый код
      CReg_              IN OUT customer.c_reg%TYPE,             -- Код обл.НИ
      CDst_              IN OUT customer.c_dst%TYPE,           -- Код район.НИ
      Adm_               IN OUT customer.adm%TYPE,              -- Админ.орган
      RgTax_             IN OUT customer.rgtax%TYPE,         -- Рег номер в НИ
      RgAdm_             IN OUT customer.rgadm%TYPE,       -- Рег номер в Адм.
      DateT_             IN OUT customer.datet%TYPE,          -- Дата рег в НИ
      DateA_             IN OUT customer.datea%TYPE, -- Дата рег. в администрации
      Ise_               IN OUT customer.ise%TYPE,     -- Инст. сек. экономики
      Fs_                IN OUT customer.fs%TYPE,       -- Форма собственности
      Oe_                IN OUT customer.oe%TYPE,         -- Отрасль экономики
      Ved_               IN OUT customer.ved%TYPE,     -- Вид эк. деятельности
      Sed_               IN OUT customer.sed%TYPE,     -- Форма хозяйствования
      K050_              IN OUT customer.k050%TYPE,
      Notes_             IN OUT customer.notes%TYPE,             -- Примечание
      Notesec_           IN OUT customer.notesec%TYPE, -- Примечание для службы безопасности
      CRisk_             IN OUT customer.crisk%TYPE,        -- Категория риска
      Pincode_           IN OUT customer.pincode%TYPE,                      --
      RnkP_              IN OUT customer.rnkp%TYPE,     -- Рег. номер холдинга
      Lim_               IN OUT customer.lim%TYPE,              -- Лимит кассы
      NomPDV_            IN OUT customer.nompdv%TYPE, -- № в реестре плат. ПДВ
      MB_                IN OUT customer.mb%TYPE,   -- Принадл. малому бизнесу
      BC_                IN OUT customer.bc%TYPE,   -- Признак НЕклиента банка
      Tobo_              IN OUT customer.tobo%TYPE, -- Код безбалансового отделения
      Isp_               IN OUT customer.isp%TYPE, -- Менеджер клиента (ответ. исполнитель)
      p_nrezid_code      IN OUT customer.nrezid_code%TYPE,
      p_flag_visa        IN OUT NUMBER,
      -------------------------------------kl.setPersonAttr
      Sex_               IN OUT person.sex%TYPE,
      Passp_             IN OUT person.passp%TYPE,
      Ser_               IN OUT person.ser%TYPE,
      Numdoc_            IN OUT person.numdoc%TYPE,
      Pdate_             IN OUT person.pdate%TYPE,
      Organ_             IN OUT person.organ%TYPE,
      Fdate_             IN OUT person.date_photo%TYPE,
      Bday_              IN OUT person.bday%TYPE,
      Bplace_            IN OUT person.bplace%TYPE,
      Teld_              IN OUT person.teld%TYPE,
      Telw_              IN OUT person.telw%TYPE,
      Telm_              IN OUT person.cellphone%TYPE,
      actual_date_       IN OUT person.actual_date%TYPE,
      eddr_id_           IN OUT person.eddr_id%TYPE,
      -------------------------------------kl.setCustomerRekv

      LimKass_           IN OUT rnk_rekv.lim_kass%TYPE,
      AdrAlt_            IN OUT rnk_rekv.adr_alt%TYPE,
      NomDog_            IN OUT rnk_rekv.nom_dog%TYPE,
      -------------------------------------kl.setCustomerElement
      /*Tag_   IN OUT customerw.tag%type                             ,
      Val_   IN OUT customerw.value%type                           ,
      Otd_   IN OUT customerw.isp%type                             ,
      -------------------------------------kl.setCustomerRel
        p_relid            IN OUT customer_rel.rel_id%type         ,
        p_relrnk           IN OUT customer_rel.rel_rnk%type        ,
        p_relintext        IN OUT customer_rel.rel_intext%type     ,
        p_vaga1            IN OUT customer_rel.vaga1%type          ,
        p_vaga2            IN OUT customer_rel.vaga2%type          ,
        p_typeid           IN OUT customer_rel.type_id%type        ,
        p_position         IN OUT customer_rel.position%type       ,
        p_position_r       IN OUT customer_rel.position_r%type     ,
        p_firstname        IN OUT customer_rel.first_name%type     ,
        p_middlename       IN OUT customer_rel.middle_name%type    ,
        p_lastname         IN OUT customer_rel.last_name%type      ,
        p_documenttypeid   IN OUT customer_rel.document_type_id%type ,
        p_document         IN OUT customer_rel.document%type       ,
        p_trustregnum      IN OUT customer_rel.trust_regnum%type   ,
        p_trustregdat      IN OUT customer_rel.trust_regdat%type   ,
        p_bdate            IN OUT customer_rel.bdate%type          ,
        p_edate            IN OUT customer_rel.edate%type          ,
        p_notaryname       IN OUT customer_rel.notary_name%type    ,
        p_notaryregion     IN OUT customer_rel.notary_region%type  ,
        p_signprivs        IN OUT customer_rel.sign_privs%type     ,
        p_signid           IN OUT customer_rel.sign_id%type        ,
        p_namer            IN OUT customer_rel.name_r%type         ,*/
      -------------------------------------kl.setCustomerRel
      -------------------------------------kl.setFullCustomerAddress
      p_1country         IN OUT customer_address.country%TYPE,
      p_1zip             IN OUT customer_address.zip%TYPE,
      p_1domain          IN OUT customer_address.domain%TYPE,
      p_1region          IN OUT customer_address.region%TYPE,
      p_1locality        IN OUT customer_address.locality%TYPE,
      p_1address         IN OUT customer_address.address%TYPE,
      p_1territoryId     IN OUT customer_address.territory_id%TYPE,
      p_1locality_type   IN OUT customer_address.locality_type%TYPE,
      p_1street_type     IN OUT customer_address.street_type%TYPE,
      p_1street          IN OUT customer_address.street%TYPE,
      p_1home_type       IN OUT customer_address.home_type%TYPE,
      p_1home            IN OUT customer_address.home%TYPE,
      p_1homepart_type   IN OUT customer_address.homepart_type%TYPE,
      p_1homepart        IN OUT customer_address.homepart%TYPE,
      p_1room_type       IN OUT customer_address.room_type%TYPE,
      p_1room            IN OUT customer_address.room%TYPE,
      p_1comment         IN OUT customer_address.comm%TYPE,
      --p_1region_id       IN OUT customer_address.region_id%type,
      --p_1area_id         IN OUT customer_address.area_id%type,
      --p_1settlement_id   IN OUT customer_address.settlement_id%type,
      --p_1street_id       IN OUT customer_address.street_id%type,
      -------------------------------------kl.setFullCustomerAddress
      p_2country         IN OUT customer_address.country%TYPE,
      p_2zip             IN OUT customer_address.zip%TYPE,
      p_2domain          IN OUT customer_address.domain%TYPE,
      p_2region          IN OUT customer_address.region%TYPE,
      p_2locality        IN OUT customer_address.locality%TYPE,
      p_2address         IN OUT customer_address.address%TYPE,
      p_2territoryId     IN OUT customer_address.territory_id%TYPE,
      p_2locality_type   IN OUT customer_address.locality_type%TYPE,
      p_2street_type     IN OUT customer_address.street_type%TYPE,
      p_2street          IN OUT customer_address.street%TYPE,
      p_2home_type       IN OUT customer_address.home_type%TYPE,
      p_2home            IN OUT customer_address.home%TYPE,
      p_2homepart_type   IN OUT customer_address.homepart_type%TYPE,
      p_2homepart        IN OUT customer_address.homepart%TYPE,
      p_2room_type       IN OUT customer_address.room_type%TYPE,
      p_2room            IN OUT customer_address.room%TYPE,
      p_2comment         IN OUT customer_address.comm%TYPE,
      --                            p_2region_id       IN OUT customer_address.region_id%type,
      --                            p_2area_id         IN OUT customer_address.area_id%type,
      --                            p_2settlement_id   IN OUT customer_address.settlement_id%type,
      --                            p_2street_id       IN OUT customer_address.street_id%type,
      -------------------------------------kl.setFullCustomerAddress
      p_3country         IN OUT customer_address.country%TYPE,
      p_3zip             IN OUT customer_address.zip%TYPE,
      p_3domain          IN OUT customer_address.domain%TYPE,
      p_3region          IN OUT customer_address.region%TYPE,
      p_3locality        IN OUT customer_address.locality%TYPE,
      p_3address         IN OUT customer_address.address%TYPE,
      p_3territoryId     IN OUT customer_address.territory_id%TYPE,
      p_3locality_type   IN OUT customer_address.locality_type%TYPE,
      p_3street_type     IN OUT customer_address.street_type%TYPE,
      p_3street          IN OUT customer_address.street%TYPE,
      p_3home_type       IN OUT customer_address.home_type%TYPE,
      p_3home            IN OUT customer_address.home%TYPE,
      p_3homepart_type   IN OUT customer_address.homepart_type%TYPE,
      p_3homepart        IN OUT customer_address.homepart%TYPE,
      p_3room_type       IN OUT customer_address.room_type%TYPE,
      p_3room            IN OUT customer_address.room%TYPE,
      p_3comment         IN OUT customer_address.comm%TYPE,
      --                            p_3region_id       IN OUT customer_address.region_id%type,
      --                            p_3area_id         IN OUT customer_address.area_id%type,
      --                            p_3settlement_id   IN OUT customer_address.settlement_id%type,
      --                            p_3street_id       IN OUT customer_address.street_id%type,
      p_clientname_gc    IN OUT VARCHAR2,
      p_clientid         IN OUT NUMBER,
      p_DateOff          IN OUT VARCHAR2,
      p_status              OUT INT,
      p_status_code         OUT VARCHAR2,
      p_error_code          OUT VARCHAR2);

   PROCEDURE SearchClient (p_in_RNK            IN     NUMBER DEFAULT NULL,
                           p_in_OKPO           IN     VARCHAR2 DEFAULT NULL,
                           p_in_NMK            IN     VARCHAR2 DEFAULT NULL,
                           p_in_CUSTTYPE       IN     NUMBER DEFAULT NULL,
                           p_in_passtype       IN     NUMBER DEFAULT NULL,
                           p_in_SER            IN     VARCHAR2 DEFAULT NULL,
                           p_in_NUMDOC         IN     VARCHAR2 DEFAULT NULL,
                           p_RNK                  OUT NUMBER,
                           p_OKPO                 OUT VARCHAR2,
                           p_NMK                  OUT VARCHAR2,
                           p_PCUSTTYPE            OUT NUMBER,
                           p_COUNTRY              OUT NUMBER,
                           p_NMKV                 OUT VARCHAR2,
                           p_NMKK                 OUT VARCHAR2,
                           p_CODCAGENT            OUT NUMBER,
                           p_PRINSIDER            OUT NUMBER,
                           p_ADR                  OUT VARCHAR2,
                           p_C_REG                OUT NUMBER,
                           p_C_DST                OUT NUMBER,
                           p_ADM                  OUT VARCHAR2,
                           p_DATE_ON              OUT VARCHAR2,
                           p_DATE_OFF             OUT VARCHAR2,
                           p_CRISK                OUT NUMBER,
                           p_ND                   OUT VARCHAR2,
                           p_ISE                  OUT VARCHAR2,
                           p_FS                   OUT VARCHAR2,
                           p_OE                   OUT VARCHAR2,
                           p_VED                  OUT VARCHAR2,
                           p_SED                  OUT VARCHAR2,
                           p_MB                   OUT VARCHAR2,
                           p_RGADM                OUT VARCHAR2,
                           p_BC                   OUT NUMBER,
                           p_BRANCH               OUT VARCHAR2,
                           p_TOBO                 OUT VARCHAR2,
                           p_K050                 OUT VARCHAR2,
                           p_NREZID_CODE          OUT VARCHAR2,
                           p_SER                  OUT VARCHAR2,
                           p_NUMDOC               OUT VARCHAR2,
                           p_OperationResult      OUT INTEGER,
                           p_ErrorMessage         OUT VARCHAR2);

   PROCEDURE AttrCustomer (Rnk_   IN     customerw.rnk%TYPE,
                           Tag_   IN     customerw.tag%TYPE,
                           Val_   IN OUT customerw.VALUE%TYPE,
                           Otd_   IN     customerw.isp%TYPE);

   function GetDictKeyColumn (tabname user_tab_cols.table_name%type) return varchar2;
   function GetDictNameColumn (tabname user_tab_cols.table_name%type) return varchar2;

   procedure sign_doc (p_transactionid  IN      NUMBER,
                       p_archdoc_id     IN  OUT NUMBER,
                       p_errormessage       OUT VARCHAR2);

   procedure request(   p_transactionid  IN      NUMBER,
                        p_type         in   cust_requests.req_type%type,
                        p_trustee      in   cust_requests.trustee_type%type,
                        p_rnk          in   cust_requests.trustee_rnk%type,
                        p_cert_num     in   cust_requests.certif_num%type,
                        p_cert_date    in   cust_requests.certif_date%type,
                        p_date_start   in   cust_requests.date_start%type,
                        p_date_finish  in   cust_requests.date_finish%type,
                        p_access_info  in   XMLType,
                        p_reqid        out  cust_requests.req_id%type,
                        p_errormessage out varchar2);

PROCEDURE CreateDepositAgreement (
   P_TRANSACTIONID    IN     NUMBER,
   P_DPTID            IN     dpt_deposit.deposit_id%TYPE,
   P_AGRMNTTYPE       IN     dpt_agreements.AGRMNT_TYPE%TYPE,
   P_INITCUSTID       IN     dpt_agreements.CUST_ID%TYPE,
   P_TRUSTCUSTID      IN     dpt_agreements.TRUSTEE_ID%TYPE,
   P_TRUSTID          IN     dpt_trustee.id%type,
   P_DENOMCOUNT       IN     dpt_agreements.DENOM_COUNT%TYPE,
   P_TRANSFERDPT      IN     CLOB,              -- параметры возврата депозита
   P_TRANSFERINT      IN     CLOB,              -- параметры выплаты процентов
   P_AMOUNTCASH       IN     dpt_agreements.amount_cash%TYPE, -- сума готівкою (ДУ про зміну суми договору)
   P_AMOUNTCASHLESS   IN     dpt_agreements.amount_cashless%TYPE, -- сума безготівкою (ДУ про зміну суми договору)
   P_DATBEGIN         IN     dpt_agreements.date_begin%TYPE,
   P_DATEND           IN     dpt_agreements.date_end%TYPE,
   P_RATEREQID        IN     dpt_agreements.rate_reqid%TYPE,
   P_RATEVALUE        IN     dpt_agreements.rate_value%TYPE,
   P_RATEDATE         IN     dpt_agreements.rate_date%TYPE,
   P_DENOMAMOUNT      IN     dpt_agreements.denom_amount%TYPE,
   P_DENOMREF         IN     dpt_agreements.denom_ref%TYPE,
   P_COMISSREF        IN     dpt_agreements.comiss_ref%TYPE,
   P_DOCREF           IN     dpt_agreements.doc_ref%TYPE, -- реф. документу поповнення / частк.зняття (ДУ про зміну суми договору)
   P_COMISSREQID      IN     dpt_agreements.comiss_reqid%TYPE, -- идентификатор запроса на отмену комисии
   p_FREQ			  IN     freq.freq%type,
   P_AGRMNTID            OUT dpt_agreements.agrmnt_id%TYPE, -- идентификатор ДУ
   P_ERRORMESSAGE        OUT VARCHAR2);

function getClientBuffer (p_client_name      IN     VARCHAR2,
                           p_client_surname   IN     VARCHAR2,
                           p_client_patr      IN     VARCHAR2,
                           bday_              IN     person.bday%TYPE,
                           Okpo_              IN     customer.okpo%TYPE, -- ОКПО
                           Country_           IN     customer.country%TYPE, -- Страна
                           Codcagent_         IN     customer.codcagent%TYPE, -- Характеристика
                           Sex_               IN     person.sex%TYPE,
                           Prinsider_         IN     customer.prinsider%TYPE, -- Признак инсайдера
                           Telm_              IN     person.cellphone%TYPE,
                           Passp_             IN     person.passp%TYPE,
                           Ser_               IN     person.ser%TYPE,
                           Numdoc_            IN     person.numdoc%TYPE,
                           eddr_id_           IN     person.eddr_id%TYPE,
                           actual_date_       IN     person.actual_date%TYPE,
                           Pdate_             IN     person.pdate%TYPE,
                           Organ_             IN     person.organ%TYPE) return VARCHAR2;

procedure SET_VERIFIED_STATE(p_rnk in customer.rnk%type, p_code out number, p_errmsg out varchar2);
function GET_VERIFIED_STATE(p_rnk in customer.rnk%type) return number;
PROCEDURE set_risk (p_rnk IN NUMBER, p_riskid IN NUMBER, p_riskvalue IN NUMBER, p_errormessage OUT varchar2);
 type r_risks is record(riskid number, dat_begin date, dat_end date);
 type t_risks is table of r_risks;
function get_risklist (p_rnk IN NUMBER) return t_risks pipelined;

 type r_instant is record ( productCode w4_product.code%type,
							productName w4_product.name%type,
                            CardCode	v_w4_card.code%type,
                            CardName	v_w4_card.sub_name%type,
                            KV 			tabval.lcv%type);
 type t_instant is table of r_instant;
 function getInstantDict return t_instant pipelined;
 type r_instantrow is record ( 	NLS accounts.nls%type,
                            	KV 	tabval.lcv%type,
                                Branch	accounts.branch%type);
 type t_instantlist is table of r_instantrow;
 FUNCTION OrderInstant (p_transactionid   IN     NUMBER,
                        p_cardcode        IN     v_w4_card.code%TYPE,
                        p_Branch          IN     accounts.branch%TYPE,
                        p_cardcount       IN     NUMBER)
   RETURN t_instantlist
   PIPELINED;
  type r_cardParam is record ( TAG accountsw.tag%type, VAL accountsw.VALUE%type, ERR varchar2(500));
  type t_cardParams is table of r_cardParam;

    FUNCTION SetGetCardParam (p_TransactionId   IN NUMBER,
                              p_nd              IN w4_acc.nd%TYPE,
                              p_xmltags         IN CLOB) return t_cardParams pipelined;

    procedure CardBulkInsert(p_unit_type_code in    varchar2,
                             p_ext_id         in    varchar2,
                             p_receiver_url   in    varchar2,
                             p_request_data   in    clob,
                             p_hash           in    varchar2,
                             p_state            out number,
                             p_msg              out varchar2,
                             p_bulkid           out number);
                                                   
    procedure CardBulkTicket(p_bulkid         in    number,
                             p_bulkstatus       out varchar2,
                             p_ticket           out clob);   
                              
    PROCEDURE CreateRegular (p_TransactionId   IN NUMBER,
                             IDS                 sto_det.ids%TYPE DEFAULT NULL,
                             ord                 sto_det.ord%TYPE,
                             tt                  sto_det.tt%TYPE,
                             vob                 sto_det.vob%TYPE,
                             dk                  sto_det.dk%TYPE,
                             nlsa                sto_det.nlsa%TYPE,
                             kva                 sto_det.kva%TYPE,
                             nlsb                sto_det.nlsb%TYPE,
                             kvb                 sto_det.kvb%TYPE,
                             mfob                sto_det.mfob%TYPE,
                             polu                sto_det.polu%TYPE,
                             nazn                sto_det.nazn%TYPE,
                             fsum                sto_det.fsum%TYPE,
                             okpo                sto_det.okpo%TYPE,
                             DAT1                sto_det.dat1%TYPE,
                             DAT2                sto_det.dat2%TYPE,
                             FREQ                sto_det.freq%TYPE,
                             DAT0                sto_det.dat0%TYPE,
                             WEND                sto_det.wend%TYPE,
                             DR                  sto_det.dr%TYPE,
                             branch              sto_det.branch%TYPE,
                             p_nd                cc_deal.nd%TYPE,
                             p_sdate             cc_deal.sdate%TYPE,
                             p_idd           OUT sto_det.idd%TYPE,
                             p_status        OUT NUMBER,
                             p_status_text   OUT VARCHAR2);
                            
    PROCEDURE CreateSbonContr (p_TransactionId       IN     NUMBER,
                               p_payer_account_id    IN     INTEGER,
                               p_start_date          IN     DATE,
                               p_stop_date           IN     DATE,
                               p_payment_frequency   IN     INTEGER,
                               p_holiday_shift       IN     INTEGER,
                               p_provider_id         IN     INTEGER,
                               p_personal_account    IN     VARCHAR2,
                               p_regular_amount      IN     NUMBER,
                               p_ceiling_amount      IN     NUMBER,
                               p_extra_attributes    IN     CLOB,
                               p_sendsms             IN     VARCHAR2,
                               p_order_id               OUT NUMBER,
                               p_result_code            OUT NUMBER,
                               p_result_message         OUT VARCHAR2);

    PROCEDURE CreateSbonNoContr (p_TransactionId       IN     NUMBER,
                                 p_payer_account_id    IN     INTEGER,
                                 p_start_date          IN     DATE,
                                 p_stop_date           IN     DATE,
                                 p_payment_frequency   IN     INTEGER,
                                 p_holiday_shift       IN     INTEGER,
                                 p_provider_id         IN     INTEGER,
                                 p_personal_account    IN     VARCHAR2,
                                 p_regular_amount      IN     NUMBER,                                 
                                 p_extra_attributes    IN     CLOB,
                                 p_sendsms             IN     VARCHAR2,
                                 p_order_id               OUT NUMBER,
                                 p_result_code            OUT NUMBER,
                                 p_result_message         OUT VARCHAR2);

    PROCEDURE CreateFreeSbonRegular (p_TransactionId       IN     NUMBER,
                                     p_payer_account_id    IN     INTEGER,
                                     p_start_date          IN     DATE,
                                     p_stop_date           IN     DATE,
                                     p_payment_frequency   IN     INTEGER,
                                     p_holiday_shift       IN     INTEGER,
                                     p_provider_id         IN     INTEGER,
                                     p_regular_amount      IN     NUMBER,
                                     p_receiver_mfo        IN     VARCHAR2,
                                     p_receiver_account    IN     VARCHAR2,
                                     p_receiver_name       IN     VARCHAR2,
                                     p_receiver_edrpou     IN     VARCHAR2,
                                     p_purpose             IN     VARCHAR2,
                                     p_extra_attributes    IN     CLOB,
                                     p_sendsms             IN     VARCHAR2,
                                     p_order_id               OUT NUMBER,
                                     p_result_code            OUT NUMBER,
                                     p_result_message         OUT VARCHAR2);  

    PROCEDURE MapDKBO (p_TransactionId    IN     NUMBER,
                       p_customer_id      IN     customer.rnk%TYPE,
                       p_deal_number      IN     deal.deal_number%TYPE DEFAULT NULL,
                       p_acc_list         IN     varchar2,
                       p_dkbo_date_from   IN     DATE DEFAULT bankdate,
                       p_dkbo_date_to     IN     DATE DEFAULT trunc(add_months(bankdate, 12)),
                       p_dkbo_state       IN     VARCHAR2 DEFAULT 'CONNECTED',
                       p_deal_id            OUT INTEGER,
                       p_start_date         OUT DATE
                       );   
  function getversion return varchar2;
                                                                      
                                                           
END;
/
CREATE OR REPLACE PACKAGE BODY BARS.XRM_INTEGRATION_OE 
IS
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 1.90 22.05.2017';
   g_null_date      CONSTANT DATE := null;

   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body xrm_integration_oe ' || g_body_version;
   END body_version;


   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body xrm_integration_oe ' || g_body_version;
   END header_version;

   PROCEDURE open_card (p_transactionid  in     number,
                        p_kf             IN     VARCHAR2,       -- код филиала
                        p_rnk            IN     NUMBER,
                        p_nls            IN OUT VARCHAR2,
                        p_cardcode       IN     VARCHAR2,
                        p_branch         IN     VARCHAR2,
                        p_embfirstname   IN     VARCHAR2,
                        p_emblastname    IN     VARCHAR2,
                        p_secname        IN     VARCHAR2,
                        p_work           IN     VARCHAR2,
                        p_office         IN     VARCHAR2,
                        p_wdate          IN     DATE,
                        p_salaryproect   IN     NUMBER,
                        p_term           IN     NUMBER,
                        p_branchissue    IN     VARCHAR2,
                        p_barcode        IN     VARCHAR2,
                        p_cobrandid      IN     VARCHAR2,
                        p_nd                OUT NUMBER,
                        p_daos              OUT VARCHAR2,
                        p_date_begin        OUT VARCHAR2,
                        p_status            OUT INT,
                        p_blkd              OUT INT,
                        p_blkk              OUT INT,
                        p_dkbo_num          OUT VARCHAR2,
                        p_dkbo_in           OUT VARCHAR2,
                        p_dkbo_out          OUT VARCHAR2,
                        p_acc               OUT NUMBER)
   IS
      l_nls   accounts.nls%TYPE;
      l_kv    INT;
      l_reqid number;
   BEGIN
      bc.go (p_branch);
      l_nls := p_nls;
      dbms_session.set_context('clientcontext','iscrm','1');
      bars_ow.open_card (p_rnk          => p_rnk,
                         p_nls          => l_nls,
                         p_cardcode     => p_cardcode,
                         p_branch       => p_branch,
                         p_embfirstname => p_embfirstname,
                         p_emblastname  => p_emblastname,
                         p_secname      => p_secname,
                         p_work         => p_work,
                         p_office       => p_office,
                         p_wdate        => p_wdate,
                         p_salaryproect => p_salaryproect,
                         p_term         => p_term,
                         p_branchissue  => p_branchissue,
                         p_barcode      => p_barcode,
                         p_cobrandid    => p_cobrandid,
                         p_sendsms      => null,
                         p_nd           => p_nd,
			 p_reqid        => l_reqid
                         );
      bars_audit.trace (
         title || 'bars_ow.open_card- ok;nd=' || TO_CHAR (p_nd));

      BEGIN
         SELECT nls,
                1,
                blkd,
                blkk,
                d.deal_number,
                TO_CHAR (d.start_date, 'dd/mm/yyyy'),
                TO_CHAR (d.close_date, 'dd/mm/yyyy'),
                a.kv,
                TO_CHAR (a.daos, 'dd/mm/yyyy'),
                TO_CHAR (a.daos, 'dd/mm/yyyy'),
                a.acc
           INTO p_nls,
                p_status,
                p_blkd,
                p_blkk,
                p_dkbo_num,
                p_dkbo_in,
                p_dkbo_out,
                l_kv,
                p_daos,
                p_date_begin,
                p_acc
           FROM accounts a, w4_acc wa, deal d
          WHERE     a.acc = wa.acc_pk
                AND wa.nd = p_nd
                AND d.customer_id(+) = a.rnk
                AND d.deal_type_id IN (SELECT tt.id
                                         FROM object_type tt
                                        WHERE tt.type_code = 'DKBO');
      EXCEPTION
         WHEN OTHERS
         THEN
            bars_audit.error (
                  title
               || 'open_card: '
               || SQLERRM
               || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      END;

      begin
        xrm_ui_oe.xrm_card_trans(p_TransactionId  => p_transactionid,
                                 p_ND             => p_nd,
                                 p_ACC            => p_ACC,
                                 p_NLS            => p_NLS,
                                 p_DAOS           => to_date(p_DAOS,'dd/mm/yyyy'),
                                 p_DATE_BEGIN     => to_date(p_DATE_BEGIN,'dd/mm/yyyy'),
                                 p_STATUS         => p_STATUS,
                                 p_BLKD           => p_BLKD,
                                 p_BLKK           => p_BLKK,
                                 p_DKBO_NUM       => p_DKBO_NUM,
                                 p_DKBO_IN        => to_date(p_DKBO_IN,'dd/mm/yyyy'),
                                 p_DKBO_OUT       => to_date(p_DKBO_OUT,'dd/mm/yyyy'),
                                 p_STATUSCODE     => nvl(SQLCODE, 0),
                                 p_ERRORMESSAGE   => nvl(SQLERRM,'Ok'));
      exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_card_trans failed with mess:' || sqlerrm);
      end;
   END;

   PROCEDURE SearchClient (p_in_RNK            IN     NUMBER DEFAULT NULL,
                           p_in_OKPO           IN     VARCHAR2 DEFAULT NULL,
                           p_in_NMK            IN     VARCHAR2 DEFAULT NULL,
                           p_in_CUSTTYPE       IN     NUMBER DEFAULT NULL,
                           p_in_passtype       IN     NUMBER DEFAULT NULL,
                           p_in_SER            IN     VARCHAR2 DEFAULT NULL,
                           p_in_NUMDOC         IN     VARCHAR2 DEFAULT NULL,
                           p_RNK                  OUT NUMBER,
                           p_OKPO                 OUT VARCHAR2,
                           p_NMK                  OUT VARCHAR2,
                           p_PCUSTTYPE            OUT NUMBER,
                           p_COUNTRY              OUT NUMBER,
                           p_NMKV                 OUT VARCHAR2,
                           p_NMKK                 OUT VARCHAR2,
                           p_CODCAGENT            OUT NUMBER,
                           p_PRINSIDER            OUT NUMBER,
                           p_ADR                  OUT VARCHAR2,
                           p_C_REG                OUT NUMBER,
                           p_C_DST                OUT NUMBER,
                           p_ADM                  OUT VARCHAR2,
                           p_DATE_ON              OUT VARCHAR2,
                           p_DATE_OFF             OUT VARCHAR2,
                           p_CRISK                OUT NUMBER,
                           p_ND                   OUT VARCHAR2,
                           p_ISE                  OUT VARCHAR2,
                           p_FS                   OUT VARCHAR2,
                           p_OE                   OUT VARCHAR2,
                           p_VED                  OUT VARCHAR2,
                           p_SED                  OUT VARCHAR2,
                           p_MB                   OUT VARCHAR2,
                           p_RGADM                OUT VARCHAR2,
                           p_BC                   OUT NUMBER,
                           p_BRANCH               OUT VARCHAR2,
                           p_TOBO                 OUT VARCHAR2,
                           p_K050                 OUT VARCHAR2,
                           p_NREZID_CODE          OUT VARCHAR2,
                           p_SER                  OUT VARCHAR2,
                           p_NUMDOC               OUT VARCHAR2,
                           p_OperationResult      OUT INTEGER,
                           p_ErrorMessage         OUT VARCHAR2)
   IS
      title   CONSTANT VARCHAR2 (27) := 'xrm_integration_oe.SearchClient:';
      nlchr   CONSTANT CHAR (2) := CHR (13) || CHR (10);
      l_stmt_kl        VARCHAR2 (4000) := '';
      l_stmt_nkl       VARCHAR2 (4000) := '';
      l_clause_kl      VARCHAR2 (4000) := '';
      l_clause_nkl     VARCHAR2 (4000) := '';
      t_cust           t_cursor;
   BEGIN
      bars_audit.trace (title || ' started.');
      bars_audit.trace (
            'xrm_integration_oe.SearchClient('
         || ' p_in_RNK      => '
         || p_in_RNK
         || ',p_in_okpo     => '
         || p_in_OKPO
         || ',p_in_NMK      => '
         || p_in_NMK
         || ',p_in_CUSTTYPE => '
         || p_in_CUSTTYPE
         || ',p_in_passtype => '
         || p_in_passtype
         || ',p_in_SER      => '
         || p_in_SER
         || ',p_in_NUMDOC   => '
         || p_in_NUMDOC
         || ')');

      IF p_in_RNK IS NOT NULL
      THEN
         l_clause_kl := nlchr || ' AND c.rnk = :p_in_RNK ' || nlchr;
      ELSE
         l_clause_kl := nlchr || ' AND (:p_in_RNK is null or 1=1)' || nlchr;
      END IF;

      l_clause_kl := l_clause_kl || ' AND CUSTTYPE = :p_in_CUSTTYPE' || nlchr;

      IF p_in_okpo IS NOT NULL
      THEN
         l_clause_kl :=
               l_clause_kl
            || ' AND NVL(c.okpo, ''0000000000'') = :p_in_okpo '
            || nlchr;
      ELSE
         l_clause_kl :=
            l_clause_kl || ' AND (:p_in_okpo is null or 1=1)' || nlchr;
      END IF;

      ------------------------------
      IF p_in_RNK IS NOT NULL
      THEN
         l_clause_nkl := nlchr || ' AND c.rnk = :p_in_RNK ' || nlchr;
      ELSE
         l_clause_nkl := nlchr || ' AND (:p_in_RNK is null or 1=1)' || nlchr;
      END IF;

      l_clause_nkl :=
         l_clause_nkl || ' AND CUSTTYPE = :p_in_CUSTTYPE' || nlchr;

      IF p_in_okpo IS NOT NULL
      THEN
         l_clause_nkl :=
               l_clause_nkl
            || ' AND NVL(okpo, ''0000000000'') = :p_in_okpo '
            || nlchr;
      ELSE
         l_clause_nkl := l_clause_nkl || ' AND :p_in_okpo is null' || nlchr;
      END IF;

      CASE
         WHEN p_in_CUSTTYPE = 2
         THEN
            BEGIN
               l_clause_kl :=
                  l_clause_kl || ' AND :p_in_passtype is null ' || nlchr;
               l_clause_kl := l_clause_kl || ' AND :p_in_ser is null' || nlchr;
               l_clause_kl :=
                  l_clause_kl || ' AND :p_in_numdoc is null' || nlchr;

               l_clause_nkl :=
                  l_clause_nkl || ' AND :p_in_passtype is null ' || nlchr;
               l_clause_nkl :=
                  l_clause_nkl || ' AND :p_in_ser is null' || nlchr;
               l_clause_nkl :=
                  l_clause_nkl || ' AND :p_in_numdoc is null' || nlchr;
               l_stmt_kl :=
                  'SELECT /*+ FIRST_ROWS(10) */
                   c.RNK,c.OKPO,c.NMK,c.CUSTTYPE,c.COUNTRY,c.NMKV,c.NMKK,c.CODCAGENT,c.PRINSIDER,c.ADR,c.C_REG,c.C_DST,c.ADM,
                   c.DATE_ON,c.DATE_OFF,c.CRISK,c.ND,c.ISE,c.FS,c.OE,c.VED,c.SED,c.MB,c.RGADM,c.BC,c.BRANCH,c.TOBO,c.K050,c.NREZID_CODE, NULL, NULL
              FROM customer c
             WHERE c.date_off IS NULL ';

               l_stmt_nkl := ' SELECT /*+FIRST_ROWS(10) */
                    ID RNK,
                    OKPO,
                    name NMK,
                    CUSTTYPE,
                    COUNTRY,
                    null NMKV,
                    null NMKK,
                    null CODCAGENT,
                    null PRINSIDER,
                    ADR,
                    null C_REG,
                    null C_DST,
                    null ADM,
                    null DATE_ON,
                    null DATE_OFF,
                    null CRISK,
                    null ND,
                    ISE,
                    FS,
                    null OE,
                    VED,
                    SED,
                    null MB,
                    null RGADM,
                    null BC,
                    null BRANCH,
                    null TOBO,
                    null K050,
                    null NREZID_CODE,
                    DOC_SERIAL,DOC_NUMBER
               FROM CUSTOMER_EXTERN
              WHERE 1=1 ';
               p_OperationResult := 20;
            END;
         WHEN p_in_CUSTTYPE = 3
         THEN
            BEGIN
               IF p_in_passtype IS NOT NULL
               THEN
                  l_clause_kl :=
                     l_clause_kl || ' AND s.passp = :p_in_passtype ' || nlchr;
               ELSE
                  l_clause_kl :=
                     l_clause_kl || ' AND :p_in_passtype is null' || nlchr;
               END IF;

               IF p_in_ser IS NOT NULL
               THEN
                  l_clause_kl :=
                     l_clause_kl || ' AND p.ser= :p_in_ser ' || nlchr;
               ELSE
                  l_clause_kl :=
                     l_clause_kl || ' AND :p_in_ser is null' || nlchr;
               END IF;

               IF p_in_numdoc IS NOT NULL
               THEN
                  l_clause_kl :=
                     l_clause_kl || ' AND p.numdoc = :p_in_numdoc ' || nlchr;
               ELSE
                  l_clause_kl :=
                     l_clause_kl || ' AND :p_in_numdoc is null' || nlchr;
               END IF;

               IF p_in_passtype IS NOT NULL
               THEN
                  l_clause_nkl :=
                        l_clause_nkl
                     || ' AND DOC_TYPE = :p_in_passtype '
                     || nlchr;
               ELSE
                  l_clause_nkl :=
                     l_clause_nkl || ' AND :p_in_passtype is null ' || nlchr;
               END IF;

               IF p_in_ser IS NOT NULL
               THEN
                  l_clause_nkl :=
                     l_clause_nkl || ' AND DOC_SERIAL = :p_in_ser ' || nlchr;
               ELSE
                  l_clause_nkl :=
                     l_clause_nkl || ' AND :p_in_ser is null' || nlchr;
               END IF;

               IF p_in_numdoc IS NOT NULL
               THEN
                  l_clause_nkl :=
                        l_clause_nkl
                     || ' AND DOC_NUMBER= :p_in_numdoc '
                     || nlchr;
               ELSE
                  l_clause_nkl :=
                     l_clause_nkl || ' AND :p_in_numdoc is null  ' || nlchr;
               END IF;

               l_stmt_kl :=
                  'SELECT /*+ FIRST_ROWS(10) */
                   c.RNK,c.OKPO,c.NMK,c.CUSTTYPE,c.COUNTRY,c.NMKV,c.NMKK,c.CODCAGENT,c.PRINSIDER,c.ADR,c.C_REG,c.C_DST,c.ADM,
                   c.DATE_ON,c.DATE_OFF,c.CRISK,c.ND,c.ISE,c.FS,c.OE,c.VED,c.SED,c.MB,c.RGADM,c.BC,c.BRANCH,c.TOBO,c.K050,c.NREZID_CODE, P.SER, P.NUMDOC
              FROM customer c, person p, passp s
             WHERE c.rnk   = p.rnk
               AND p.passp = s.passp
               AND c.date_off IS NULL ';

               l_stmt_nkl := 'SELECT /*+FIRST_ROWS(10) */
                    ID RNK,
                    OKPO,
                    name NMK,
                    CUSTTYPE,
                    COUNTRY,
                    null NMKV,
                    null NMKK,
                    null CODCAGENT,
                    null PRINSIDER,
                    ADR,
                    null C_REG,
                    null C_DST,
                    null ADM,
                    null DATE_ON,
                    null DATE_OFF,
                    null CRISK,
                    null ND,
                    ISE,
                    FS,
                    null OE,
                    VED,
                    SED,
                    null MB,
                    null RGADM,
                    null BC,
                    null BRANCH,
                    null TOBO,
                    null K050,
                    null NREZID_CODE,
                    DOC_SERIAL,DOC_NUMBER
               FROM CUSTOMER_EXTERN
              WHERE 1=1 ';
               p_OperationResult := 30;
            END;
         ELSE
            p_OperationResult := -1;
            p_ErrorMessage :=
                  'Тип клієнта '
               || TO_CHAR (p_in_CUSTTYPE)
               || ' не відповідає переліку для пошуку (2 ЮО, 3 ФО)';
            bars_audit.error (title || p_ErrorMessage);
            RETURN;
      END CASE;

      --bars_audit.info(p_in_NMK||','|| p_in_CUSTTYPE||','|| p_in_passtype||','|| p_in_okpo||','|| p_in_ser||','||p_in_numdoc);
      l_stmt_kl := l_stmt_kl || l_clause_kl;
      l_stmt_nkl := l_stmt_nkl || l_clause_nkl;
      bars_audit.trace (l_stmt_kl);
      bars_audit.trace (l_stmt_nkl);

      OPEN t_cust FOR l_stmt_kl
         USING p_in_rnk,
               p_in_CUSTTYPE,
               p_in_okpo,
               p_in_passtype,
               p_in_ser,
               p_in_numdoc;

      BEGIN
         FETCH t_cust
            INTO p_rnk,
                 p_okpo,
                 p_nmk,
                 p_PCUSTTYPE,
                 p_COUNTRY,
                 p_NMKV,
                 p_NMKK,
                 p_CODCAGENT,
                 p_PRINSIDER,
                 p_ADR,
                 p_C_REG,
                 p_C_DST,
                 p_ADM,
                 p_DATE_ON,
                 p_DATE_OFF,
                 p_CRISK,
                 p_ND,
                 p_ISE,
                 p_FS,
                 p_OE,
                 p_VED,
                 p_SED,
                 p_MB,
                 p_RGADM,
                 p_BC,
                 p_BRANCH,
                 p_TOBO,
                 p_K050,
                 p_NREZID_CODE,
                 p_SER,
                 p_NUMDOC;

         IF p_rnk IS NULL
         THEN
            bars_audit.info (title || ' не найден среди клиентов банка');

            CLOSE t_cust;

            OPEN t_cust FOR l_stmt_nkl
               USING p_in_rnk,
                     p_in_CUSTTYPE,
                     p_in_okpo,
                     p_in_passtype,
                     p_in_ser,
                     p_in_numdoc;

            FETCH t_cust
               INTO p_rnk,
                    p_okpo,
                    p_nmk,
                    p_PCUSTTYPE,
                    p_COUNTRY,
                    p_NMKV,
                    p_NMKK,
                    p_CODCAGENT,
                    p_PRINSIDER,
                    p_ADR,
                    p_C_REG,
                    p_C_DST,
                    p_ADM,
                    p_DATE_ON,
                    p_DATE_OFF,
                    p_CRISK,
                    p_ND,
                    p_ISE,
                    p_FS,
                    p_OE,
                    p_VED,
                    p_SED,
                    p_MB,
                    p_RGADM,
                    p_BC,
                    p_BRANCH,
                    p_TOBO,
                    p_K050,
                    p_NREZID_CODE,
                    p_SER,
                    p_NUMDOC;

            IF p_rnk IS NULL                     -- не найден среди неклиентов
            THEN
               bars_audit.trace (
                     title
                  || ' не найден среди неклиентов банка');
               p_OperationResult := -1;
               p_ErrorMessage :=
                  'Клієнта з вказаними реквізитами не знайдено';
            ELSE                                    -- найден среди неклиентов
               bars_audit.trace (
                  title || ' найден среди неклиентов');
            END IF;
         ELSE
            p_OperationResult := p_OperationResult + 1;
         END IF;
      END;

      IF p_rnk IS NULL
      THEN
         p_OperationResult := -1;
         p_ErrorMessage :=
            'Клієнта з вказаними реквізитами не знайдено';
      END IF;

      CLOSE t_cust;

      bars_audit.info (
            'xrm_integration_oe.SearchClient('
         || ' p_RNK =>'
         || p_rnk
         || ',p_OKPO => '
         || p_OKPO
         || ',p_NMK => '
         || p_NMK
         || ',p_PCUSTTYPE => '
         || p_PCUSTTYPE
         || ',p_COUNTRY => '
         || p_COUNTRY
         || ',p_NMKV => '
         || p_NMKV
         || ',p_NMKK => '
         || p_NMKK
         || ',p_CODCAGENT => '
         || p_CODCAGENT
         || ',p_PRINSIDER => '
         || p_PRINSIDER
         || ',p_ADDR => '
         || p_ADR
         || ',p_C_REG => '
         || p_C_REG
         || ',p_C_DST => '
         || p_C_DST
         || ',p_ADM => '
         || p_ADM
         || ',p_DATE_ON => '
         || p_DATE_ON
         || ',p_DATE_OFF => '
         || p_DATE_OFF
         || ',p_CRISK => '
         || p_CRISK
         || ',p_ND => '
         || p_ND
         || ',p_ISE => '
         || p_ISE
         || ',p_FS => '
         || p_FS
         || ',p_OE => '
         || p_OE
         || ',p_VED => '
         || p_VED
         || ',p_SED => '
         || p_SED
         || ',p_MB => '
         || p_MB
         || ',p_RGADM => '
         || p_RGADM
         || ',p_BC => '
         || p_BC
         || ',p_BRANCH => '
         || p_BRANCH
         || ',p_TOBO => '
         || p_TOBO
         || ',p_K050 => '
         || p_K050
         || ',p_NREZID_CODE => '
         || p_NREZID_CODE
         || ',p_SER => '
         || p_SER
         || ',p_NUMDOC => '
         || p_NUMDOC
         || ',p_OperationResult=>'
         || p_OperationResult
         || ',p_ErrorMessage => '
         || p_ErrorMessage);
      bars_audit.trace (title || ' finished');
   END;

   PROCEDURE open_deposit (p_transactionid  in     number,
      p_kf              IN     VARCHAR2,                        -- код филиала
      p_branch          IN     branch.branch%TYPE,               -- відділення
      p_vidd            IN     dpt_deposit.vidd%TYPE,       -- код вида вклада
      p_rnk             IN     dpt_deposit.rnk%TYPE,        -- рег.№ вкладчика
      p_nd              IN     dpt_deposit.nd%TYPE, -- номер договора (произвольный)
      p_sum             IN     dpt_deposit.LIMIT%TYPE, -- сумма вклада пол договору
      p_nocash          IN     NUMBER,       -- БЕЗНАЛ взнос (0-НАЛ,1- БЕЗНАЛ)
      p_datz            IN     dpt_deposit.datz%TYPE, -- дата заключения договора
      p_namep           IN     dpt_deposit.name_p%TYPE,       -- получатель %%
      p_okpop           IN     dpt_deposit.okpo_p%TYPE, -- идентиф.код получателя %%
      p_nlsp            IN     dpt_deposit.nls_p%TYPE,  -- счет для выплаты %%
      p_mfop            IN     dpt_deposit.mfo_p%TYPE,   -- МФО для выплаты %%
      p_fl_perekr       IN     dpt_vidd.fl_2620%TYPE, -- флаг открытия техн.счета
      p_name_perekr     IN     dpt_deposit.nms_d%TYPE,  -- получатель депозита
      p_okpo_perekr     IN     dpt_deposit.okpo_p%TYPE, -- идентиф.код получателя депозита
      p_nls_perekr      IN     dpt_deposit.nls_d%TYPE, -- счет для возврата депозита
      p_mfo_perekr      IN     dpt_deposit.mfo_d%TYPE, -- МФО для возврата депозита
      p_comment         IN     dpt_deposit.comments%TYPE,       -- комментарий
      p_dpt_id             OUT dpt_deposit.deposit_id%TYPE, -- идентификатор договора
      p_datbegin        IN     dpt_deposit.dat_begin%TYPE DEFAULT NULL, -- дата открытия договора
      p_duration        IN     dpt_vidd.duration%TYPE DEFAULT NULL, -- длительность (мес.)
      p_duration_days   IN     dpt_vidd.duration_days%TYPE DEFAULT NULL, -- длительность (дней)
      p_rate               OUT NUMBER,
      p_nls                OUT accounts.nls%TYPE,
      p_nlsint             OUT accounts.nls%TYPE,
      p_daos               OUT VARCHAR2,
      p_dat_begin          OUT VARCHAR2,
      p_dat_end            OUT VARCHAR2,
      p_blkd               OUT accounts.blkd%TYPE,
      p_blkk               OUT accounts.blkk%TYPE,
      p_dkbo_num           OUT VARCHAR2,
      p_dkbo_in            OUT VARCHAR2,
      p_dkbo_out           OUT VARCHAR2,
	  ResultCode		   OUT INT,
      ResultMessage 	   OUT VARCHAR2)
   IS
   l_verified_docs number := 0;
   l_errmsg varchar2(500) := '';
   l_errcode number := 0;
   BEGIN
      ResultCode := 0;
      ResultMessage := 'Ok';
      bc.go (p_branch);
      l_verified_docs := GET_VERIFIED_STATE(p_rnk);
	  bars_audit.trace (title || 'dpt_web.l_verified_docs =' || to_char(l_verified_docs));
      if l_verified_docs = 1
      then
		  dpt_web.create_deposit (p_vidd          => p_vidd,
								  p_rnk           => p_rnk,
								  p_nd            => p_nd,
								  p_sum           => p_sum,
								  p_nocash        => p_nocash,
								  p_datz          => p_datz,
								  p_namep         => p_namep,
								  p_okpop         => p_okpop,
								  p_nlsp          => p_nlsp,
								  p_mfop          => p_mfop,
								  p_fl_perekr     => p_fl_perekr,
								  p_name_perekr   => p_name_perekr,
								  p_okpo_perekr   => p_okpo_perekr,
								  p_nls_perekr    => p_nls_perekr,
								  p_mfo_perekr    => p_mfo_perekr,
								  p_comment       => p_comment,
								  p_dpt_id        => p_dpt_id,
								  p_datbegin      => p_datbegin,
								  p_duration      => p_duration,
								  p_duration_days => p_duration_days);
     	  bars_audit.trace (title || 'dpt_web.create_deposit - ok;');

		  BEGIN
			 SELECT a.nls,
					TO_CHAR (a.daos, 'dd/mm/yyyy'),
					TO_CHAR (d.dat_begin, 'dd/mm/yyyy'),
					TO_CHAR (d.dat_end, 'dd/mm/yyyy'),
					a.blkd,
					a.blkk,
					deal.deal_number,
					TO_CHAR (deal.start_date, 'dd/mm/yyyy'),
					TO_CHAR (deal.close_date, 'dd/mm/yyyy'),
					aint.nls,
					dpt.fproc (d.acc, SYSDATE)
			   INTO p_nls,
					p_daos,
					p_dat_begin,
					p_dat_end,
					p_blkd,
					p_blkk,
					p_dkbo_num,
					p_dkbo_in,
					p_dkbo_out,
					p_nlsint,
					p_rate
			   FROM accounts a,
					dpt_deposit d,
					dpt_accounts da,
					accounts aint,
					deal
			  WHERE     a.acc = d.acc
					AND da.dptid = d.deposit_id
					AND da.accid != d.acc
					AND aint.acc = da.accid
					AND d.deposit_id = p_dpt_id
					AND deal.customer_id = d.rnk
					AND deal.deal_type_id IN (SELECT tt.id
												FROM object_type tt
											   WHERE tt.type_code = 'DKBO');
		  EXCEPTION
             WHEN NO_DATA_FOUND
             THEN
             BEGIN
             SELECT a.nls,
                    TO_CHAR (a.daos, 'dd/mm/yyyy'),
                    TO_CHAR (d.dat_begin, 'dd/mm/yyyy'),
                    TO_CHAR (d.dat_end, 'dd/mm/yyyy'),
                    a.blkd,
                    a.blkk,
                    null,
                    null,
                    null,
                    aint.nls,
                    dpt.fproc (d.acc, SYSDATE)
               INTO p_nls,
                    p_daos,
                    p_dat_begin,
                    p_dat_end,
                    p_blkd,
                    p_blkk,
                    p_dkbo_num,
                    p_dkbo_in,
                    p_dkbo_out,
                    p_nlsint,
                    p_rate
               FROM accounts a,
                    dpt_deposit d,
                    dpt_accounts da,
                    accounts aint
              WHERE     a.acc = d.acc
                    AND da.dptid = d.deposit_id
                    AND da.accid != d.acc
                    AND aint.acc = da.accid
                    AND d.deposit_id = p_dpt_id;
			 EXCEPTION WHEN OTHERS
			 THEN ResultCode := -1;
				  ResultMessage := SQLERRM;
             END;
				bars_audit.error (title || 'open_deposit' || SQLERRM);
		  END;
	    l_errmsg := NVL(SQLERRM,'Ok');
        l_errcode := 0;
	  else
	    l_errmsg := 'Без відмітки "Документи перевірено" створення депозиту неможливе';
        l_errcode := -1;
      end if;

	  ResultCode := l_errcode;
      ResultMessage := l_errmsg;

	  begin
        xrm_ui_oe.xrm_deposit_trans(p_TransactionId => p_TransactionId,
                                    p_DPTID         => p_dpt_id,
                                    p_NLS           => p_NLS,
                                    p_RATE          => p_RATE,
                                    p_NLSINT        => p_NLSINT,
                                    p_DAOS          => to_date(p_DAOS,'dd/mm/yyyy'),
                                    p_DAT_BEGIN     => to_date(p_DAT_BEGIN,'dd/mm/yyyy'),
                                    p_DAT_END       => to_date(p_DAT_END,'dd/mm/yyyy'),
                                    p_BLKD          => p_BLKD,
                                    p_BLKK          => p_BLKK,
                                    p_DKBO_NUM      => p_DKBO_NUM,
                                    p_DKBO_IN       => to_date(p_DKBO_IN,'dd/mm/yyyy'),
                                    p_DKBO_OUT      => null,
                                    p_STATUSCODE    => l_errcode,
                                    p_ERRORMESSAGE  => l_errmsg);
      exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_deposit_trans failed with mess:' || sqlerrm);
      end;

	  bars_audit.info (title || 'ResultMessage =' || to_char(ResultMessage));
   END;

   PROCEDURE open_customer (
      p_TransactionId    IN     NUMBER,
      p_UserLogin        IN     staff.logname%TYPE,
      p_OperationType    IN     INT, -- 1 открытие/ 2 обновление данных клиента, 0 - поиск клиента, 3 установка даты закрытия
      p_ClientType       IN     custtype.custtype%TYPE,
      p_FormType         IN     INT, -- 1,2,3 упрощенная форма, 0 полная форма
      p_kf               IN     VARCHAR2,
      p_client_name      IN     VARCHAR2,
      p_client_surname   IN     VARCHAR2,
      p_client_patr      IN     VARCHAR2,
      -------------------------------------kl.setCustomerAttr
      Custtype_          IN OUT customer.custtype%TYPE, -- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
      Nd_                IN OUT customer.nd%TYPE,                -- № договора
      Nmk_               IN OUT VARCHAR2,              -- Наименование клиента
      Nmkv_              IN OUT customer.nmkv%TYPE, -- Наименование клиента международное
      Nmkk_              IN OUT customer.nmkk%TYPE, -- Наименование клиента краткое
      Adr_               IN OUT customer.adr%TYPE,            -- Адрес клиента
      Codcagent_         IN OUT customer.codcagent%TYPE,     -- Характеристика
      Country_           IN OUT customer.country%TYPE,               -- Страна
      Prinsider_         IN OUT customer.prinsider%TYPE,  -- Признак инсайдера
      Tgr_               IN OUT customer.tgr%TYPE,          -- Тип гос.реестра
      Okpo_              IN OUT customer.okpo%TYPE,                    -- ОКПО
      Stmt_              IN OUT customer.stmt%TYPE,          -- Формат выписки
      Sab_               IN OUT customer.sab%TYPE,                   -- Эл.код
      DateOn_            IN OUT customer.date_on%TYPE,     -- Дата регистрации
      Taxf_              IN OUT customer.taxf%TYPE,           -- Налоговый код
      CReg_              IN OUT customer.c_reg%TYPE,             -- Код обл.НИ
      CDst_              IN OUT customer.c_dst%TYPE,           -- Код район.НИ
      Adm_               IN OUT customer.adm%TYPE,              -- Админ.орган
      RgTax_             IN OUT customer.rgtax%TYPE,         -- Рег номер в НИ
      RgAdm_             IN OUT customer.rgadm%TYPE,       -- Рег номер в Адм.
      DateT_             IN OUT customer.datet%TYPE,          -- Дата рег в НИ
      DateA_             IN OUT customer.datea%TYPE, -- Дата рег. в администрации
      Ise_               IN OUT customer.ise%TYPE,     -- Инст. сек. экономики
      Fs_                IN OUT customer.fs%TYPE,       -- Форма собственности
      Oe_                IN OUT customer.oe%TYPE,         -- Отрасль экономики
      Ved_               IN OUT customer.ved%TYPE,     -- Вид эк. деятельности
      Sed_               IN OUT customer.sed%TYPE,     -- Форма хозяйствования
      K050_              IN OUT customer.k050%TYPE,
      Notes_             IN OUT customer.notes%TYPE,             -- Примечание
      Notesec_           IN OUT customer.notesec%TYPE, -- Примечание для службы безопасности
      CRisk_             IN OUT customer.crisk%TYPE,        -- Категория риска
      Pincode_           IN OUT customer.pincode%TYPE,                      --
      RnkP_              IN OUT customer.rnkp%TYPE,     -- Рег. номер холдинга
      Lim_               IN OUT customer.lim%TYPE,              -- Лимит кассы
      NomPDV_            IN OUT customer.nompdv%TYPE, -- № в реестре плат. ПДВ
      MB_                IN OUT customer.mb%TYPE,   -- Принадл. малому бизнесу
      BC_                IN OUT customer.bc%TYPE,   -- Признак НЕклиента банка
      Tobo_              IN OUT customer.tobo%TYPE, -- Код безбалансового отделения
      Isp_               IN OUT customer.isp%TYPE, -- Менеджер клиента (ответ. исполнитель)
      p_nrezid_code      IN OUT customer.nrezid_code%TYPE,
      p_flag_visa        IN OUT NUMBER,
      -------------------------------------kl.setPersonAttr
      Sex_               IN OUT person.sex%TYPE,
      Passp_             IN OUT person.passp%TYPE,
      Ser_               IN OUT person.ser%TYPE,
      Numdoc_            IN OUT person.numdoc%TYPE,
      Pdate_             IN OUT person.pdate%TYPE,
      Organ_             IN OUT person.organ%TYPE,
      Fdate_             IN OUT person.date_photo%TYPE,
      Bday_              IN OUT person.bday%TYPE,
      Bplace_            IN OUT person.bplace%TYPE,
      Teld_              IN OUT person.teld%TYPE,
      Telw_              IN OUT person.telw%TYPE,
      Telm_              IN OUT person.cellphone%TYPE,
      actual_date_       IN OUT person.actual_date%TYPE,
      eddr_id_           IN OUT person.eddr_id%TYPE,
      -------------------------------------kl.setCustomerRekv

      LimKass_           IN OUT rnk_rekv.lim_kass%TYPE,
      AdrAlt_            IN OUT rnk_rekv.adr_alt%TYPE,
      NomDog_            IN OUT rnk_rekv.nom_dog%TYPE,
      -------------------------------------kl.setCustomerElement
      /*Tag_   IN OUT customerw.tag%type                             ,
      Val_   IN OUT customerw.value%type                           ,
      Otd_   IN OUT customerw.isp%type                             ,
      -------------------------------------kl.setCustomerRel
        p_relid            IN OUT customer_rel.rel_id%type         ,
        p_relrnk           IN OUT customer_rel.rel_rnk%type        ,
        p_relintext        IN OUT customer_rel.rel_intext%type     ,
        p_vaga1            IN OUT customer_rel.vaga1%type          ,
        p_vaga2            IN OUT customer_rel.vaga2%type          ,
        p_typeid           IN OUT customer_rel.type_id%type        ,
        p_position         IN OUT customer_rel.position%type       ,
        p_position_r       IN OUT customer_rel.position_r%type     ,
        p_firstname        IN OUT customer_rel.first_name%type     ,
        p_middlename       IN OUT customer_rel.middle_name%type    ,
        p_lastname         IN OUT customer_rel.last_name%type      ,
        p_documenttypeid   IN OUT customer_rel.document_type_id%type ,
        p_document         IN OUT customer_rel.document%type       ,
        p_trustregnum      IN OUT customer_rel.trust_regnum%type   ,
        p_trustregdat      IN OUT customer_rel.trust_regdat%type   ,
        p_bdate            IN OUT customer_rel.bdate%type          ,
        p_edate            IN OUT customer_rel.edate%type          ,
        p_notaryname       IN OUT customer_rel.notary_name%type    ,
        p_notaryregion     IN OUT customer_rel.notary_region%type  ,
        p_signprivs        IN OUT customer_rel.sign_privs%type     ,
        p_signid           IN OUT customer_rel.sign_id%type        ,
        p_namer            IN OUT customer_rel.name_r%type         ,*/
      -------------------------------------kl.setFullCustomerAddress
      p_1country         IN OUT customer_address.country%TYPE,
      p_1zip             IN OUT customer_address.zip%TYPE,
      p_1domain          IN OUT customer_address.domain%TYPE,
      p_1region          IN OUT customer_address.region%TYPE,
      p_1locality        IN OUT customer_address.locality%TYPE,
      p_1address         IN OUT customer_address.address%TYPE,
      p_1territoryId     IN OUT customer_address.territory_id%TYPE,
      p_1locality_type   IN OUT customer_address.locality_type%TYPE,
      p_1street_type     IN OUT customer_address.street_type%TYPE,
      p_1street          IN OUT customer_address.street%TYPE,
      p_1home_type       IN OUT customer_address.home_type%TYPE,
      p_1home            IN OUT customer_address.home%TYPE,
      p_1homepart_type   IN OUT customer_address.homepart_type%TYPE,
      p_1homepart        IN OUT customer_address.homepart%TYPE,
      p_1room_type       IN OUT customer_address.room_type%TYPE,
      p_1room            IN OUT customer_address.room%TYPE,
      p_1comment         IN OUT customer_address.comm%TYPE,
      --                            p_1region_id       IN OUT customer_address.region_id%type,
      --                            p_1area_id         IN OUT customer_address.area_id%type,
      --                            p_1settlement_id   IN OUT customer_address.settlement_id%type,
      --                            p_1street_id       IN OUT customer_address.street_id%type,
      -------------------------------------kl.setFullCustomerAddress
      p_2country         IN OUT customer_address.country%TYPE,
      p_2zip             IN OUT customer_address.zip%TYPE,
      p_2domain          IN OUT customer_address.domain%TYPE,
      p_2region          IN OUT customer_address.region%TYPE,
      p_2locality        IN OUT customer_address.locality%TYPE,
      p_2address         IN OUT customer_address.address%TYPE,
      p_2territoryId     IN OUT customer_address.territory_id%TYPE,
      p_2locality_type   IN OUT customer_address.locality_type%TYPE,
      p_2street_type     IN OUT customer_address.street_type%TYPE,
      p_2street          IN OUT customer_address.street%TYPE,
      p_2home_type       IN OUT customer_address.home_type%TYPE,
      p_2home            IN OUT customer_address.home%TYPE,
      p_2homepart_type   IN OUT customer_address.homepart_type%TYPE,
      p_2homepart        IN OUT customer_address.homepart%TYPE,
      p_2room_type       IN OUT customer_address.room_type%TYPE,
      p_2room            IN OUT customer_address.room%TYPE,
      p_2comment         IN OUT customer_address.comm%TYPE,
      --                            p_2region_id       IN OUT customer_address.region_id%type,
      --                            p_2area_id         IN OUT customer_address.area_id%type,
      --                            p_2settlement_id   IN OUT customer_address.settlement_id%type,
      --                            p_2street_id       IN OUT customer_address.street_id%type,
      -------------------------------------kl.setFullCustomerAddress
      p_3country         IN OUT customer_address.country%TYPE,
      p_3zip             IN OUT customer_address.zip%TYPE,
      p_3domain          IN OUT customer_address.domain%TYPE,
      p_3region          IN OUT customer_address.region%TYPE,
      p_3locality        IN OUT customer_address.locality%TYPE,
      p_3address         IN OUT customer_address.address%TYPE,
      p_3territoryId     IN OUT customer_address.territory_id%TYPE,
      p_3locality_type   IN OUT customer_address.locality_type%TYPE,
      p_3street_type     IN OUT customer_address.street_type%TYPE,
      p_3street          IN OUT customer_address.street%TYPE,
      p_3home_type       IN OUT customer_address.home_type%TYPE,
      p_3home            IN OUT customer_address.home%TYPE,
      p_3homepart_type   IN OUT customer_address.homepart_type%TYPE,
      p_3homepart        IN OUT customer_address.homepart%TYPE,
      p_3room_type       IN OUT customer_address.room_type%TYPE,
      p_3room            IN OUT customer_address.room%TYPE,
      p_3comment         IN OUT customer_address.comm%TYPE,
      --                            p_3region_id       IN OUT customer_address.region_id%type,
      --                            p_3area_id         IN OUT customer_address.area_id%type,
      --                            p_3settlement_id   IN OUT customer_address.settlement_id%type,
      --                            p_3street_id       IN OUT customer_address.street_id%type,
      -------------------------------------
      p_clientname_gc    IN OUT VARCHAR2,
      p_clientid         IN OUT NUMBER,
      p_DateOff          IN OUT VARCHAR2,
      p_status              OUT INT,
      p_status_code         OUT VARCHAR2,
      p_error_code          OUT VARCHAR2)
   IS
      l_clientname   VARCHAR2 (500);
      l_can_close    int := 0; -- Признак, что клиента закрыть можно (нет открытых счетов)
   BEGIN

      bars_audit.info (
            title
         || 'open_customer  p_OperationType (0 перегляд, 1 створення, 2 оновлення, 3 закриття ) = '
         || TO_CHAR (p_OperationType)
         || 'p_clientname='
         || l_clientname
         || ',sex='
         || TO_CHAR (Sex_));
      p_status := 0;
      p_status_code := 'Ok';
      p_error_code := '';

      IF (    p_client_name IS NOT NULL
          AND p_client_surname IS NOT NULL
          AND p_client_patr IS NOT NULL)
      THEN
         l_clientname := UPPER ( p_client_name || ' ' || p_client_surname || ' ' || p_client_patr);
      END IF;

      SELECT    f_getNameInGenitiveCase (p_client_name,1,Sex_,'U')|| ' '
             || f_getNameInGenitiveCase (p_client_surname,2,Sex_,'U')|| ' '
             || f_getNameInGenitiveCase (p_client_patr,3,Sex_,'U')
        INTO p_clientname_gc
        FROM DUAL;

      BEGIN
         SELECT rnk
           INTO p_clientid
           FROM customer
          WHERE     (rnk = p_clientid OR p_clientid IS NULL)
                AND (nmk = l_clientname OR l_clientname IS NULL)
                AND (OKPO = Okpo_ OR Okpo_ IS NULL)
                AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            IF (p_OperationType IN (0, 3))
            THEN
               p_status := -1;
               p_status_code := 'Не знайдено';
               p_error_code :=
                     'Не знайдено клієнта з РНК = '
                  || TO_CHAR (p_clientid);

               IF (p_OperationType = 1)
               THEN
                  DateOn_ := SYSDATE;
               END IF;
            END IF;
      END;

      if ((p_OperationType = 1 and p_clientid is null) or (p_OperationType = 2))
      THEN
         BEGIN
            bars_audit.info (
               title || 'start kl.setCustomerAttr' || ', RnkP_ = ' || RnkP_);

            IF RnkP_ = 0
            THEN
               RnkP_ := NULL;
            END IF;

            IF Isp_ = 0
            THEN
               Isp_ := NULL;
            END IF;

            kl.setCustomerAttr (Rnk_           => p_clientid,
                                Custtype_      => Custtype_,
                                Nd_            => Nd_,
                                Nmk_           => l_clientname,
                                Nmkv_          => Nmkv_,
                                Nmkk_          => Nmkk_,
                                Adr_           => Adr_,
                                Codcagent_     => NVL (Codcagent_, 5),
                                Country_       => NVL (Country_, 804),
                                Prinsider_     => NVL (Prinsider_, 99),
                                Tgr_           => NVL (Tgr_, 2),
                                Okpo_          => Okpo_,
                                Stmt_          => Stmt_,
                                Sab_           => Sab_,
                                DateOn_        => NVL (DateOn_, SYSDATE),
                                Taxf_          => Taxf_,
                                CReg_          => NVL (CReg_, -1),
                                CDst_          => NVL (CDst_, -1),
                                Adm_           => NVL (Adm_, -1),
                                RgTax_         => RgTax_,
                                RgAdm_         => RgAdm_,
                                DateT_         => DateT_,
                                DateA_         => DateA_,
                                Ise_           => SUBSTR (Ise_, 1, 5),
                                Fs_            => SUBSTR (Fs_, 1, 2),
                                Oe_            => SUBSTR (Oe_, 1, 5),
                                Ved_           => SUBSTR (Ved_, 1, 5),
                                Sed_           => SUBSTR (Sed_, 1, 4),
                                Notes_         => Notes_,
                                Notesec_       => Notesec_,
                                CRisk_         => CRisk_,
                                Pincode_       => Pincode_,
                                RnkP_          => RnkP_,
                                Lim_           => Lim_,
                                NomPDV_        => NomPDV_,
                                MB_            => SUBSTR (MB_, 1, 1),
                                BC_            => SUBSTR (BC_, 1, 1),
                                Tobo_          => Tobo_,
                                Isp_           => Isp_,
                                p_nrezid_code  => p_nrezid_code,
                                p_flag_visa    => p_flag_visa);
            bars_audit.info (title || 'end kl.setCustomerAttr');
         EXCEPTION
            WHEN OTHERS
            THEN
               p_status := -1;
               p_error_code := title ||
			   	case
					when SQLERRM like '%FK_CUSTOMER_ISE%' then 'Некоректне значення коду "Інституційний сектор економіки" (' || Ise_ ||')'
					when SQLERRM like '%UK_CUSTOMER_SAB%' then 'Неунікальний еклектроний код клієнта (' || Sab_ ||')'
					when SQLERRM like '%FK_CUSTOMER_VED%' then 'Некоректне значення коду "Вид економічної діяльності" (' || Ved_ ||')'
					when SQLERRM like '%FK_CUSTOMER_TOBO%' then 'Неіснуюче відділення клієнта (' || Tobo_ ||')'
					when SQLERRM like '%FK_CUSTOMER_TGR%' then 'Некоректне значення парамтра "Тип госреєстру" (1:Реєстр ЄДРПОУ,2:Реєстр ДРФО (фiз.осiб),3:Реєстр ТРДПА (тимчасовий)) (' || Tgr_ ||')'
					when SQLERRM like '%FK_CUSTOMER_STMT%' then 'Некоректне значення параметра "Тип виписки" (0:Не використовується,5:Клієнт-Банк) (' || Stmt_ ||')'
					when SQLERRM like '%FK_CUSTOMER_STAFF%' then 'Неіснуючий код відповідального виконавця клієнта (' || Isp_ ||')'
					when SQLERRM like '%FK_CUSTOMER_SPRREG%' then 'Некоректні/невідповідні значення пари параметрів "ДПА (Код обл, Код району)" (' ||CReg_||','||CDst_||')'
					when SQLERRM like '%FK_CUSTOMER_SPK050%' then 'Некоректне значення параметра "K050 (КЛАССИФИКАЦИЯ ОРГАНИЗАЦИОННО-ПРАВОВЫХ ФОРМ ХОЗЯЙСТВОВАНИЯ)"'
					when SQLERRM like '%FK_CUSTOMER_SED%' then 'Некоректне значення параметра "Сектор економічної діяльності" (' || Sed_ ||')'
					when SQLERRM like '%FK_CUSTOMER_PRINSIDER%' then 'Некоректне значення параметра "Ознака інсайдера" (' || Prinsider_ ||')'
					when SQLERRM like '%FK_CUSTOMER_OE%' then 'Некоректне значення параметра "Форма господарювання" (' || Oe_ ||')'
					when SQLERRM like '%FK_CUSTOMER_FS%' then 'Некоректне значення параметра "Форма власності" (' || Fs_  ||')'
					when SQLERRM like '%FK_CUSTOMER_CUSTTYPE%' then 'Некоректне значення параметра "Тип клієнта" (' || Custtype_ ||')'
					when SQLERRM like '%FK_CUSTOMER_CUSTOMER%' then 'Неіснуюче РНК холдинга (' || RnkP_ ||')'
					when SQLERRM like '%FK_CUSTOMER_COUNTRY%' then 'Неіснуючий код країни клієнта (' || Country_ ||')'
					when SQLERRM like '%FK_CUSTOMER_CODCAGENT%' then 'Неіснуючий код характеристики контрагента (' || Codcagent_ ||')'
					when SQLERRM like '%FK_CUSTOMER_BRANCH%' then 'Неіснуюче відділення клієнта  (' || Tobo_ ||')'
					when SQLERRM like '%CC_CUSTOMER_TOBO_NN%' then 'Пусте значення відділення'
					when SQLERRM like '%CC_CUSTOMER_BC%' then 'Некоректне значення параметра "Ознака не-клієнта Банку" (' || BC_ ||')'
					else SQLERRM
				end;
               p_status_code := '';
               bars_audit.info (p_error_code);
         END;

         IF p_clientid IS NOT NULL
         THEN
            bars_audit.info (
                  --804,02160,1,1,Kiev,ftrt,38210,,,str,1,18,1,1,1,112,
                  p_clientid
               || ':'
               || p_1country
               || ','
               || p_1zip
               || ','
               || p_1domain
               || ','
               || p_1region
               || ','
               || p_1locality
               || ','
               || p_1address
               || ','
               || p_1territoryId
               || ','
               || p_1locality_type
               || ','
               || p_1street_type
               || ','
               || p_1street
               || ','
               || p_1home_type
               || ','
               || p_1home
               || ','
               || p_1homepart_type
               || ','
               || p_1homepart
               || ','
               || p_1room_type
               || ','
               || p_1room
               || ','
               || p_1comment);

            kl.setFullCustomerAddress (p_rnk            => p_clientid,
                                       p_typeId         => 1,
                                       p_country        => p_1country,
                                       p_zip            => p_1zip,
                                       p_domain         => p_1domain,
                                       p_region         => p_1region,
                                       p_locality       => p_1locality,
                                       p_address        => p_1address,
                                       p_territoryId    => p_1territoryId,
                                       p_locality_type  => p_1locality_type,
                                       p_street_type    => p_1street_type,
                                       p_street         => p_1street,
                                       p_home_type      => p_1home_type,
                                       p_home           => p_1home,
                                       p_homepart_type  => p_1homepart_type,
                                       p_homepart       => p_1homepart,
                                       p_room_type      => p_1room_type,
                                       p_room           => p_1room,
                                       p_comment        => p_1comment);
            kl.setFullCustomerAddress (p_rnk            => p_clientid,
                                       p_typeId         => 2,
                                       p_country        => p_2country,
                                       p_zip            => p_2zip,
                                       p_domain         => p_2domain,
                                       p_region         => p_2region,
                                       p_locality       => p_2locality,
                                       p_address        => p_2address,
                                       p_territoryId    => p_2territoryId,
                                       p_locality_type  => p_2locality_type,
                                       p_street_type    => p_2street_type,
                                       p_street         => p_2street,
                                       p_home_type      => p_2home_type,
                                       p_home           => p_2home,
                                       p_homepart_type  => p_2homepart_type,
                                       p_homepart       => p_2homepart,
                                       p_room_type      => p_2room_type,
                                       p_room           => p_2room,
                                       p_comment        => p_2comment);
            kl.setFullCustomerAddress (p_rnk            => p_clientid,
                                       p_typeId         => 3,
                                       p_country        => p_3country,
                                       p_zip            => p_3zip,
                                       p_domain         => p_3domain,
                                       p_region         => p_3region,
                                       p_locality       => p_3locality,
                                       p_address        => p_3address,
                                       p_territoryId    => p_3territoryId,
                                       p_locality_type  => p_3locality_type,
                                       p_street_type    => p_3street_type,
                                       p_street         => p_3street,
                                       p_home_type      => p_3home_type,
                                       p_home           => p_3home,
                                       p_homepart_type  => p_3homepart_type,
                                       p_homepart       => p_3homepart,
                                       p_room_type      => p_3room_type,
                                       p_room           => p_3room,
                                       p_comment        => p_3comment);

            kl.setPersonAttrEx (Rnk_           => p_clientid,
                                Sex_           => TRUNC (Sex_),
                                Passp_         => Passp_,
                                Ser_           => Ser_,
                                Numdoc_        => Numdoc_,
                                Pdate_         => Pdate_,
                                Organ_         => Organ_,
                                Fdate_         => Fdate_,
                                Bday_          => Bday_,
                                Bplace_        => Bplace_,
                                Teld_          => Teld_,
                                Telw_          => Telw_,
                                Telm_          => Telm_,
                                actual_date_   => actual_date_,
                                eddr_id_       => eddr_id_);

            kl.setCustomerRekv (Rnk_       => p_clientid,
                                LimKass_   => LimKass_,
                                AdrAlt_    => AdrAlt_,
                                NomDog_    => NomDog_);

            kl.setCustomerEN (p_rnk    => p_clientid,
                              p_k070   => SUBSTR (Ise_, 1, 5),
                              p_k080   => SUBSTR (fs_, 1, 2),
                              p_k110   => SUBSTR (ved_, 1, 5),
                              p_k090   => SUBSTR (oe_, 1, 5),
                              p_k050   => SUBSTR (k050_, 1, 3),
                              p_k051   => SUBSTR (sed_, 1, 4));
         END IF;
      ELSIF (p_OperationType = 3)
      THEN
       begin
         select count(acc)
           into l_can_close
           from accounts
          where rnk = p_clientid
            and (dazs is null or dazs > sysdate);
       exception when no_data_found then l_can_close := 0;
       end;

       if (l_can_close = 0)
       then
           UPDATE customer
                SET date_off = TRUNC (SYSDATE)
              WHERE rnk = p_clientid;
       else
            p_status_code := 'Неможливо закрити';
               p_error_code :='У клієнта з РНК '|| TO_CHAR (p_clientid)|| ' є ' || to_char(l_can_close) || ' відкритих рахунків.';
       end if;


      ELSIF (p_OperationType = 1  and p_clientid is not null)
      THEN
             p_status := -1;
             p_status_code := 'Не знайдено';
             p_error_code := 'Клієнта з РНК = ' || TO_CHAR (p_clientid) || ' вже існує';
      END IF;

      IF p_clientid IS NOT NULL
      THEN
         BEGIN
            SELECT country,
                   zip,
                   domain,
                   region,
                   locality,
                   address,
                   territory_id,
                   locality_type,
                   street_type,
                   street,
                   home_type,
                   home,
                   homepart_type,
                   homepart,
                   room_type,
                   room,
                   comm        --, region_id, area_id, settlement_id,street_id
              INTO p_1country,
                   p_1zip,
                   p_1domain,
                   p_1region,
                   p_1locality,
                   p_1address,
                   p_1territoryId,
                   p_1locality_type,
                   p_1street_type,
                   p_1street,
                   p_1home_type,
                   p_1home,
                   p_1homepart_type,
                   p_1homepart,
                   p_1room_type,
                   p_1room,
                   p_1comment --, p_1region_id, p_1area_id, p_1settlement_id, p_1street_id
              FROM customer_address
             WHERE type_id = 1 AND rnk = p_clientid;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               bars_audit.info (
                     title
                  || 'Для p_clientname= '
                  || l_clientname
                  || ' не знайдено адреси 1');
         END;

         BEGIN
            SELECT country,
                   zip,
                   domain,
                   region,
                   locality,
                   address,
                   territory_id,
                   locality_type,
                   street_type,
                   street,
                   home_type,
                   home,
                   homepart_type,
                   homepart,
                   room_type,
                   room,
                   comm        --, region_id, area_id, settlement_id,street_id
              INTO p_2country,
                   p_2zip,
                   p_2domain,
                   p_2region,
                   p_2locality,
                   p_2address,
                   p_2territoryId,
                   p_2locality_type,
                   p_2street_type,
                   p_2street,
                   p_2home_type,
                   p_2home,
                   p_2homepart_type,
                   p_2homepart,
                   p_2room_type,
                   p_2room,
                   p_2comment --, p_2region_id, p_2area_id, p_2settlement_id, p_2street_id
              FROM customer_address
             WHERE type_id = 2 AND rnk = p_clientid;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               bars_audit.info (
                     title
                  || 'Для p_clientname= '
                  || l_clientname
                  || ' не знайдено адреси 2');
         END;

         BEGIN
            SELECT country,
                   zip,
                   domain,
                   region,
                   locality,
                   address,
                   territory_id,
                   locality_type,
                   street_type,
                   street,
                   home_type,
                   home,
                   homepart_type,
                   homepart,
                   room_type,
                   room,
                   comm        --, region_id, area_id, settlement_id,street_id
              INTO p_3country,
                   p_3zip,
                   p_3domain,
                   p_3region,
                   p_3locality,
                   p_3address,
                   p_3territoryId,
                   p_3locality_type,
                   p_3street_type,
                   p_3street,
                   p_3home_type,
                   p_3home,
                   p_3homepart_type,
                   p_3homepart,
                   p_3room_type,
                   p_3room,
                   p_3comment --, p_3region_id, p_3area_id, p_3settlement_id, p_3street_id
              FROM customer_address
             WHERE type_id = 3 AND rnk = p_clientid;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               bars_audit.info (
                     title
                  || 'Для p_clientname= '
                  || l_clientname
                  || ' не знайдено адреси 3');
         END;

         BEGIN
            SELECT Sex,
                   Passp,
                   Ser,
                   Numdoc,
                   Pdate,
                   Organ,
                   date_photo,
                   Bday,
                   Bplace,
                   Teld,
                   Telw,
                   CellPhone,
                   actual_date,
                   eddr_id
              INTO Sex_,
                   Passp_,
                   Ser_,
                   Numdoc_,
                   Pdate_,
                   Organ_,
                   Fdate_,
                   Bday_,
                   Bplace_,
                   Teld_,
                   Telw_,
                   Telm_,
                   actual_date_,
                   eddr_id_
              FROM person
             WHERE rnk = p_clientid AND ROWNUM = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               bars_audit.info (
                     title
                  || 'Для p_clientname= '
                  || l_clientname
                  || ' не знайдено персональних даних');
         END;

         bars_audit.info (
               title
            || 'p_clientname= '
            || l_clientname
            || ' Nd_='
            || TO_CHAR (Nd_)
            || ', rnk ='
            || TO_CHAR (p_clientid));
      END IF;


      bars_audit.info (
            'Пошук з параметрами: p_clientid='
         || TO_CHAR (p_clientid)
         || ', l_clientname ='
         || l_clientname
         || ', Okpo_='
         || Okpo_);

      BEGIN
         SELECT rnk,
                custtype,
                nd,
                nmk,
                nmkv,
                nmkk,
                adr,
                NVL (codcagent, 5),
                NVL (country, 804),
                NVL (prinsider, 99),
                NVL (tgr, 2),
                Okpo,
                Stmt,
                Sab,
                Date_On,
                Date_off,
                Taxf,
                C_Reg,
                c_dst,
                Adm,
                RgTax,
                RgAdm,
                DateT,
                DateA,
                Ise,
                Fs,
                Oe,
                Ved,
                Sed,
                Notes,
                Notesec,
                CRisk,
                Pincode,
                NVL (RnkP, 0),
                NVL (Lim, 0),
                NomPDV,
                MB,
                BC,
                Tobo,
                Isp,
                p_nrezid_code
           INTO p_clientid,
                Custtype_,
                Nd_,
                l_clientname,
                Nmkv_,
                Nmkk_,
                Adr_,
                Codcagent_,
                Country_,
                Prinsider_,
                Tgr_,
                Okpo_,
                Stmt_,
                Sab_,
                DateOn_,
                p_DateOff,
                Taxf_,
                CReg_,
                CDst_,
                Adm_,
                RgTax_,
                RgAdm_,
                DateT_,
                DateA_,
                Ise_,
                Fs_,
                Oe_,
                Ved_,
                Sed_,
                Notes_,
                Notesec_,
                CRisk_,
                Pincode_,
                RnkP_,
                Lim_,
                NomPDV_,
                MB_,
                BC_,
                Tobo_,
                Isp_,
                p_nrezid_code
           FROM customer
          WHERE     (rnk = p_clientid OR p_clientid IS NULL)
                AND (nmk = UPPER (l_clientname) OR l_clientname IS NULL)
                AND (Okpo_ IS NULL OR OKPO = Okpo_)
                AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            IF (p_OperationType IN (0, 3))
            THEN
               p_status := -1;
               p_status_code := 'Не знайдено';
               p_error_code :=
                     'Не знайдено клієнта з РНК = '
                  || TO_CHAR (p_clientid);

               IF (p_OperationType = 1)
               THEN
                  DateOn_ := SYSDATE;
               END IF;
            END IF;
      END;

      IF p_1country IS NULL
      THEN
         p_1country := 0;
      END IF;

      IF p_1locality_type IS NULL
      THEN
         p_1locality_type := 0;
      END IF;

      IF p_1street_type IS NULL
      THEN
         p_1street_type := 0;
      END IF;

      IF p_1territoryId IS NULL
      THEN
         p_1territoryId := 0;
      END IF;

      IF p_1home_type IS NULL
      THEN
         p_1home_type := 0;
      END IF;

      IF p_1homepart_type IS NULL
      THEN
         p_1homepart_type := 0;
      END IF;

      IF p_1room_type IS NULL
      THEN
         p_1room_type := 0;
      END IF;

      IF p_2country IS NULL
      THEN
         p_2country := 0;
      END IF;

      IF p_2locality_type IS NULL
      THEN
         p_2locality_type := 0;
      END IF;

      IF p_2street_type IS NULL
      THEN
         p_2street_type := 0;
      END IF;

      IF p_2territoryId IS NULL
      THEN
         p_2territoryId := 0;
      END IF;

      IF p_2home_type IS NULL
      THEN
         p_2home_type := 0;
      END IF;

      IF p_2homepart_type IS NULL
      THEN
         p_2homepart_type := 0;
      END IF;

      IF p_2room_type IS NULL
      THEN
         p_2room_type := 0;
      END IF;

      IF p_3country IS NULL
      THEN
         p_3country := 0;
      END IF;

      IF p_3locality_type IS NULL
      THEN
         p_3locality_type := 0;
      END IF;

      IF p_3street_type IS NULL
      THEN
         p_3street_type := 0;
      END IF;

      IF p_3territoryId IS NULL
      THEN
         p_3territoryId := 0;
      END IF;

      IF p_3home_type IS NULL
      THEN
         p_3home_type := 0;
      END IF;

      IF p_3homepart_type IS NULL
      THEN
         p_3homepart_type := 0;
      END IF;

      IF p_3room_type IS NULL
      THEN
         p_3room_type := 0;
      END IF;

      IF Sex_ IS NULL
      THEN
         Sex_ := 0;
      END IF;

      IF Rnkp_ IS NULL
      THEN
         Rnkp_ := 0;
      END IF;

      IF Lim_ IS NULL
      THEN
         Lim_ := 0;
      END IF;

      IF ISP_ IS NULL
      THEN
         ISP_ := 0;
      END IF;

      IF p_clientid IS NULL
      THEN
         p_clientid := 0;
      END IF;

      IF Passp_ IS NULL
      THEN
         Passp_ := 0;
      END IF;

      IF fdate_ IS NULL
      THEN
         fdate_ := g_null_date;
      END IF;

      IF actual_date_ IS NULL
      THEN
         actual_date_ := g_null_date;
      END IF;

      IF p_DateOff IS NULL
      THEN
         p_DateOff := g_null_date;
      END IF;

      IF DateOn_ IS NULL
      THEN
         DateOn_ := TRUNC (SYSDATE);
      END IF;

      IF Pdate_ IS NULL
      THEN
         Pdate_ := g_null_date;
      END IF;

      IF DateT_ IS NULL
      THEN
         DateT_ := g_null_date;
      END IF;

      IF DateA_ IS NULL
      THEN
         DateA_ := g_null_date;
      END IF;

      IF Bday_ IS NULL
      THEN
         Bday_ := g_null_date;
      END IF;

      IF actual_date_ IS NULL
      THEN
         actual_date_ := g_null_date;
      END IF;

      IF Tgr_ IS NULL
      THEN
         Tgr_ := 0;
      END IF;

      begin
        xrm_ui_oe.xrm_customer_trans(p_TransactionId =>   p_TransactionId,
                                     p_rnk           =>   p_clientid,
                                     p_STATUSCODE    =>   p_status,
                                     p_ERRORMESSAGE  =>   p_error_code);
      exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_customer_trans failed with mess:' || sqlerrm);
      end;

   END;

   PROCEDURE AttrCustomer (Rnk_   IN     customerw.rnk%TYPE,
                           Tag_   IN     customerw.tag%TYPE,
                           Val_   IN OUT customerw.VALUE%TYPE,
                           Otd_   IN     customerw.isp%TYPE)
   IS
   l_sql varchar2 (500);
   l_val customerw.value%type;
   l_sqlid varchar2 (500);
   BEGIN
      bars_audit.info ('exec xrm_integration_oe.AttrCustomer(' || TO_CHAR (Rnk_)|| ',' || Tag_ || ',' || Val_ || ',' || Otd_ || ')');
     --проверим, является ли Tag_ реквизитом из справочника

      IF val_ IS NOT NULL
      THEN
          begin
            SELECT    'select '
                   || cf.tabcolumn_check
                   || ' from '
                   || cf.tabname
                   || ' where '
                   || xrm_integration_oe.GetDictKeyColumn (cf.tabname)
                   || '= '''|| to_char(Val_) ||''''
              INTO l_sql
              FROM customer_field cf
             WHERE cf.tag = Tag_
               AND cf.tabname is not null;
          exception when others then null;
          end;

          if (l_sql is not null)
          then
           begin
            execute immediate l_sql into l_val;
           exception when others then bars_audit.error('xrm_integration_oe.AttrCustomer: не вдалося визначити параметр в довіднику з помилкою: '||sqlerrm);
           end;
          end if;

         Val_ := coalesce(l_val, Val_);
         kl.setCustomerElement (Rnk_   => Rnk_,
                                Tag_   => Tag_,
                                Val_   => Val_,
                                Otd_   => Otd_);
      END IF;

      begin
        SELECT    'select '
               || cf.tabcolumn_check
               || ' from '
               || cf.tabname
               || ' where '
               || xrm_integration_oe.GetDictKeyColumn (cf.tabname)
               || '= '''|| to_char(Tag) ||''''
          INTO l_sql
          FROM customer_field cf
         WHERE cf.tag = Tag_
           AND cf.tabname is not null;
      exception when others then null;
      end;

      if (l_sql is not null)
      then
       begin
        execute immediate l_sql into l_val;
       exception when others then bars_audit.error('xrm_integration_oe.AttrCustomer: не вдалося визначити параметр в довіднику з помилкою: '||sqlerrm);
       end;
      end if;
      -- найти текстовое значение параметра
      BEGIN
         SELECT VALUE
           INTO l_val
           FROM customerw
          WHERE rnk = Rnk_ AND tag = tag_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN l_val := '';
      END;
      -- попытаться найти в связанном с полем справочнике идентификатор записи
      begin
        SELECT    'select '
               || xrm_integration_oe.GetDictKeyColumn (cf.tabname)
               || ' from '
               || cf.tabname
               || ' where '
               || xrm_integration_oe.GetDictNameColumn (cf.tabname)
               || '= '''|| to_char(l_val) ||''''
          INTO l_sqlid
          FROM customer_field cf
         WHERE cf.tag = tag_
           AND cf.tabname is not null;
      exception when others then null;
      end;

      if (l_sqlid is not null)
      then
       begin
        execute immediate l_sqlid into l_val;
       exception when others then null;
       end;
     end if;
     if tag_ = 'IDDPR' then l_val := replace(l_val,'/','-'); end if;
     Val_ := l_val;
   END;

    PROCEDURE set_risk (p_rnk IN NUMBER, p_riskid IN NUMBER, p_riskvalue IN NUMBER, p_errormessage OUT varchar2)
    IS
    BEGIN
	 begin
       kl.set_customer_risk (p_rnk         => p_rnk,
                             p_riskid      => p_riskid,
                             p_riskvalue   => p_riskvalue);
     exception when others then p_errormessage :=  replace(sqlerrm,'ORA-20097: CAC-00056','Попередження! ');
     end;
    END;

   function GetDictKeyColumn (tabname user_tab_cols.table_name%type) return varchar2
   is
    l_column user_tab_cols.column_name%type;
   begin
    begin
        SELECT column_name
          INTO l_column
          FROM user_tab_cols
         WHERE table_name = upper(tabname)
           AND column_name = 'ID';
    exception when no_data_found then
        SELECT column_name
          INTO l_column
          FROM user_tab_cols
         WHERE table_name = upper(tabname)
           AND column_id = 1;
    end;
    return l_column;
   end;

   function GetDictNameColumn (tabname user_tab_cols.table_name%type) return varchar2
   is
    l_column user_tab_cols.column_name%type;
   begin
    begin
        SELECT column_name
          INTO l_column
          FROM user_tab_cols
         WHERE table_name = upper(tabname)
           AND column_name = 'NAME';
    exception when no_data_found then
     begin
        SELECT column_name
          INTO l_column
          FROM user_tab_cols
         WHERE table_name = upper(tabname)
           AND column_name = 'TXT';
     exception when no_data_found then
      SELECT column_name
          INTO l_column
          FROM user_tab_cols
         WHERE table_name = upper(tabname)
           AND column_id = 2;
     end;
    end;
    return l_column;
   end;

   procedure sign_doc (p_transactionid  IN      NUMBER,
                       p_archdoc_id     IN  OUT NUMBER,
                       p_errormessage       OUT VARCHAR2)
   is
   l_archdoc_id number;
   begin
    bars_audit.info ('exec xrm_integration_oe.sign_doc with params p_transactionid='|| to_char(p_transactionid) || ', p_archdoc_id=' || to_char(p_archdoc_id));
    p_errormessage := 'Ok';
    begin
     select max(id)
       into l_archdoc_id
       from ead_docs
      where agr_id = p_archdoc_id;
    exception when no_data_found then p_errormessage := 'Депозитного договору за номером ' || p_archdoc_id || ' не знайдено!'; Return;
    end;

    begin
    update dpt_deposit
       set archdoc_id = l_archdoc_id
     where deposit_id = p_archdoc_id;
    exception when others then p_errormessage := 'Для депозитного договору за номером ' || p_archdoc_id || ' не жодного розрукованого договору!'; Return;
    end;

    begin
     ead_pack.doc_sign(l_archdoc_id);
    exception when others then p_errormessage := 'Не виконано підпис документу:' || sqlerrm;
    end;

    begin
        xrm_ui_oe.xrm_docsign_trans(p_TransactionId =>   p_TransactionId,
                                    p_archdoc_id    =>   l_archdoc_id,
                                    p_ERRORMESSAGE  =>   p_errormessage);
    exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_docsign_trans failed with mess:' || sqlerrm);
    end;

    p_archdoc_id := l_archdoc_id;
    bars_audit.info ('exec xrm_integration_oe.sign_doc finished with p_archdoc_id=' || to_char(p_archdoc_id));
   end;


   procedure request(   p_transactionid  IN      NUMBER,
                        p_type         in   cust_requests.req_type%type,
                        p_trustee      in   cust_requests.trustee_type%type,
                        p_rnk          in   cust_requests.trustee_rnk%type,
                        p_cert_num     in   cust_requests.certif_num%type,
                        p_cert_date    in   cust_requests.certif_date%type,
                        p_date_start   in   cust_requests.date_start%type,
                        p_date_finish  in   cust_requests.date_finish%type,
                        p_access_info  in   XMLType,
                        p_reqid        out  cust_requests.req_id%type,
                        p_errormessage out varchar2)
   is
   begin
   begin
    ebp.CREATE_ACCESS_REQUEST
      ( p_type         =>  p_type,
        p_trustee      =>  p_trustee,
        p_rnk          =>  p_rnk,
        p_cert_num     =>  p_cert_num,
        p_cert_date    =>  p_cert_date,
        p_date_start   =>  p_date_start,
        p_date_finish  =>  p_date_finish,
        p_access_info  =>  p_access_info,
        p_reqid        =>  p_reqid);
   exception when others
             then bars_audit.error(title||'request failed with mess:' || sqlerrm);
                  p_errormessage := sqlerrm;
   end;
   end;

/*сформировать буфер из данных клиента и сохранить*/
/*
1    Прізвище
2    Ім’я
3    По-батькові
4    Дата народження
5    Реєстраційний номер облікової карти платника податків
6    Громадянство
7    Резидент / не резидент
8    Стать
9    Ознака інсайдера
10    Мобільний телефон
11    Вид документу
12    Номер паспорта-ID-картки
13    Унікальний номер запису в ЄДДР
14    Дійсний до
15    Дата видачі
16    Орган, що видав
17    Серія документу
18    Номер документу
19    Ким виданий
20    Дата видачі документа
*/

function getClientBuffer ( p_client_name      IN     VARCHAR2,
                           p_client_surname   IN     VARCHAR2,
                           p_client_patr      IN     VARCHAR2,
                           bday_              IN     person.bday%TYPE,
                           Okpo_              IN     customer.okpo%TYPE, -- ОКПО
                           Country_           IN     customer.country%TYPE, -- Страна
                           Codcagent_         IN     customer.codcagent%TYPE, -- Характеристика
                           Sex_               IN     person.sex%TYPE,
                           Prinsider_         IN     customer.prinsider%TYPE, -- Признак инсайдера
                           Telm_              IN     person.cellphone%TYPE,
                           Passp_             IN     person.passp%TYPE,
                           Ser_               IN     person.ser%TYPE,
                           Numdoc_            IN     person.numdoc%TYPE,
                           eddr_id_           IN     person.eddr_id%TYPE,
                           actual_date_       IN     person.actual_date%TYPE,
                           Pdate_             IN     person.pdate%TYPE,
                           Organ_             IN     person.organ%TYPE) return varchar2
IS
 l_buffer varchar2(400);
BEGIN
   l_buffer :=
            NVL (RPAD (to_char(p_client_name), 50), RPAD (' ', 10))             --1    Прізвище (50 символів, пробілами з правого боку)
            || NVL (RPAD (to_char(p_client_surname), 50), RPAD (' ', 10))       --2    Ім’я (50 символів, пробілами з правого боку)
            || NVL (RPAD (to_char(p_client_patr), 50), RPAD (' ', 10))          --3    По-батькові (50 символів, пробілами з правого боку)
            || NVL (TO_CHAR (bday_, 'DD-MM-YYYY'), RPAD (' ', 6))               --4    Дата народження (10 символів в форматі DD-MM-YYYY)
            || NVL (LPAD (TO_CHAR (Okpo_), 10), ' ')                            --5    Реєстраційний номер облікової карти платника податків (10 символів, пробілами з лівого боку)
            || NVL (TO_CHAR (Country_), RPAD (' ', 3))                          --6    Громадянство (3 символи, пробілами з правого боку)
            || NVL (TO_CHAR (Codcagent_), RPAD (' ', 1))                        --7    Резидент / не резидент (1 символ, пробілами з правого боку)
            || NVL (TO_CHAR (Sex_), RPAD (' ', 1))                              --8    Стать (1 символ, пробілами з правого боку)
            || NVL (TO_CHAR (Prinsider_), RPAD (' ', 2))                        --9    Ознака інсайдера (2 символи, пробілами з правого боку)
            || NVL (TO_CHAR (Telm_), RPAD (' ', 14))                            --10    Мобільний телефон (14 символів, пробілами з правого боку)
            || NVL (TO_CHAR (Passp_), RPAD (' ', 2))                            --11    Вид документу (2 символи, пробілами з правого боку)
            || NVL (TO_CHAR (Ser_), RPAD (' ', 10))                             --12    Серія документу (10 символів, пробілами з правого боку)
            || NVL (TO_CHAR (Numdoc_), RPAD (' ', 20))                          --13    Номер паспорта АБО Номер паспорта-ID-картки (20 символів, пробілами з правого боку)
            || NVL (TO_CHAR (eddr_id_), RPAD (' ', 20))                         --14    Унікальний номер запису в ЄДДР (20 символів, пробілами з правого боку)
            || NVL (TO_CHAR (actual_date_, 'DD-MM-YYYY'), RPAD (' ', 10))       --15    Дійсний до (10 символів в форматі DD-MM-YYYY)
            || NVL (TO_CHAR (Pdate_, 'DD-MM-YYYY'), RPAD (' ', 10))             --16    Дата видачі документа (10 символів в форматі YYMMDD)
            || NVL (TO_CHAR (Organ_), RPAD (' ', 70))                           --17    Орган, що видав (70 символів, пробілами з правого боку)
            ;
 bars_audit.info(l_buffer);
 return l_buffer;
END;

procedure SET_VERIFIED_STATE(p_rnk in customer.rnk%type, p_code out number, p_errmsg out varchar2)
is
begin
 p_errmsg := '';
  EBP.SET_VERIFIED_STATE
  ( p_rnk    => p_rnk,
    p_state  => 1);
   p_code := 0;
exception when others then p_code := -1; p_errmsg := sqlerrm;
 bars_audit.info ('XRM_INTEGRATION_OE:SET_VERIFIED_STATE' || p_errmsg);
end;

function GET_VERIFIED_STATE(p_rnk in customer.rnk%type) return number
is
l_result number := 0;
begin
 begin
	 l_result := EBP.GET_VERIFIED_STATE(p_rnk => p_rnk);
 exception when others then l_result := -1;
  bars_audit.info ('XRM_INTEGRATION_OE:GET_VERIFIED_STATE' || sqlerrm);
 end;
 return l_result;
end;

PROCEDURE CreateDepositAgreement (
   P_TRANSACTIONID    IN     NUMBER,
   P_DPTID            IN     dpt_deposit.deposit_id%TYPE,
   P_AGRMNTTYPE       IN     dpt_agreements.AGRMNT_TYPE%TYPE,
   P_INITCUSTID       IN     dpt_agreements.CUST_ID%TYPE,
   P_TRUSTCUSTID      IN     dpt_agreements.TRUSTEE_ID%TYPE,
   P_TRUSTID          IN     dpt_trustee.id%type,
   P_DENOMCOUNT       IN     dpt_agreements.DENOM_COUNT%TYPE,
   P_TRANSFERDPT      IN     CLOB,              					-- параметры возврата депозита
   P_TRANSFERINT      IN     CLOB,              					-- параметры выплаты процентов
   P_AMOUNTCASH       IN     dpt_agreements.amount_cash%TYPE, 		-- сума готівкою (ДУ про зміну суми договору)
   P_AMOUNTCASHLESS   IN     dpt_agreements.amount_cashless%TYPE, 	-- сума безготівкою (ДУ про зміну суми договору)
   P_DATBEGIN         IN     dpt_agreements.date_begin%TYPE,
   P_DATEND           IN     dpt_agreements.date_end%TYPE,
   P_RATEREQID        IN     dpt_agreements.rate_reqid%TYPE,
   P_RATEVALUE        IN     dpt_agreements.rate_value%TYPE,
   P_RATEDATE         IN     dpt_agreements.rate_date%TYPE,
   P_DENOMAMOUNT      IN     dpt_agreements.denom_amount%TYPE,
   P_DENOMREF         IN     dpt_agreements.denom_ref%TYPE,
   P_COMISSREF        IN     dpt_agreements.comiss_ref%TYPE,
   P_DOCREF           IN     dpt_agreements.doc_ref%TYPE, 		-- реф. документу поповнення / частк.зняття (ДУ про зміну суми договору)
   P_COMISSREQID      IN     dpt_agreements.comiss_reqid%TYPE, 	-- идентификатор запроса на отмену комисии
   p_FREQ			  IN     freq.freq%type,
   P_AGRMNTID            OUT dpt_agreements.agrmnt_id%TYPE, 	-- идентификатор ДУ
   P_ERRORMESSAGE        OUT VARCHAR2)
 is
  l_deposit dpt_deposit%rowtype;
  l_vidd_flags dpt_vidd_scheme%rowtype;
  l_vidd dpt_vidd%rowtype;
  l_do	int := 1;
  l_trustid dpt_trustee.id%type;
 begin

  bars_audit.info(P_TRANSFERDPT);
  bars_audit.info(P_TRANSFERINT);
  if (p_trustid is not null)
  then
   begin
       select trustee_id
         into l_trustid
         from dpt_agreements
        where agrmnt_Id = p_trustid and dpt_id = P_DPTID;
   exception when no_data_found then l_trustid := null;
   end;
  end if;
  p_ERRORMESSAGE := 'Ok';
  /*проверить что депозит существует и он у клиента из запроса*/
  begin
   select *
     into l_deposit
     from dpt_deposit
    where deposit_id = p_dptid
      and rnk = p_initcustid;
  exception when no_data_found then p_ERRORMESSAGE:= 'Депозит ' || p_dptid || ' не знайдено для клієнта з РНК =' ||p_initcustid;
  	l_do := 0;
  end;
  /*проверить доступность заказываемой ДУ*/
  if (l_do = 1)
  then
      begin
       select *
         into l_vidd_flags
         from dpt_vidd_scheme
        where vidd = l_deposit.vidd
          and flags = P_AGRMNTTYPE;
      exception when no_data_found then p_ERRORMESSAGE:= 'Вид ' || l_deposit.vidd || ' не підтримує ДУ №' ||P_AGRMNTTYPE;
        l_do := 0;
      end;

       begin
       select *
         into l_vidd
         from dpt_vidd
        where vidd = l_deposit.vidd;
      exception when no_data_found then p_ERRORMESSAGE:= 'Вид ' || l_deposit.vidd || ' не налаштовано';
        l_do := 0;
      end;

      if (l_do = 1)
      then
        begin
          if (P_AGRMNTTYPE = 11)
          then
              if (P_TRANSFERDPT = '' and P_TRANSFERINT = '')
              then p_ERRORMESSAGE := 'Не вказано рахунки виплати депозиту';
                   bars_audit.info('Не вказано рахунки виплати депозиту');
              elsif (nvl(P_TRANSFERDPT,'')!='' and nvl(P_TRANSFERINT,'')='')
              then p_ERRORMESSAGE := 'Виконано зміну рахунку виплати вкладу.';
              elsif (nvl(P_TRANSFERDPT,'')!='' and nvl(P_TRANSFERINT,'')!='' and l_vidd.comproc = 1)
              then p_ERRORMESSAGE := 'Вклад '||P_DPTID||' передбачає капіталізацію. Рахунок виплати відсотків змінювати не можна.';
              end if;
          end if;
                DPT_WEB.CREATE_AGREEMENT (P_DPTID            => P_DPTID,
                                          P_AGRMNTTYPE       => P_AGRMNTTYPE,
                                          P_INITCUSTID       => P_INITCUSTID,
                                          P_TRUSTCUSTID      => P_TRUSTCUSTID,
                                          P_TRUSTID          => l_trustid,
                                          P_TRANSFERDPT      => P_TRANSFERDPT,
                                          P_TRANSFERINT      => P_TRANSFERINT,
                                          P_AMOUNTCASH       => P_AMOUNTCASH,
                                          P_AMOUNTCASHLESS   => P_AMOUNTCASHLESS,
                                          P_DATBEGIN         => P_DATBEGIN,
                                          P_DATEND           => P_DATEND,
                                          P_RATEREQID        => P_RATEREQID,
                                          P_RATEVALUE        => P_RATEVALUE,
                                          P_RATEDATE         => P_RATEDATE,
                                          P_DENOMAMOUNT      => P_DENOMAMOUNT,
                                          P_DENOMCOUNT       => P_DENOMCOUNT,
                                          P_DENOMREF         => P_DENOMREF,
                                          P_COMISSREF        => 1,
                                          P_DOCREF           => P_DOCREF,
                                          P_COMISSREQID      => P_COMISSREQID,
                                          P_AGRMNTID         => P_AGRMNTID,
                                          P_TEMPLATEID       => NULL,
                                          P_FREQ             => p_FREQ,
                                          P_ACCESS_OTHERS    => NULL);
        exception when others then if (sqlerrm like '%unique constraint%')
         then p_ERRORMESSAGE := 'Помилка при запису даних про 3-тю особу: Для депозитного договору №'||P_DPTID|| ' довірена особа з РНК №' ||P_TRUSTCUSTID||' вже зареєстрована.';
         else p_ERRORMESSAGE := sqlerrm;
         end if;
         bars_audit.error(title||'xrm_depositagreemnt_trans failed with mess:' || sqlerrm);
        end;
      end if;
  end if;
  begin
        xrm_ui_oe.xrm_depositagreemnt_trans(p_TransactionId  => p_transactionid,
                                 P_DPTID        => P_DPTID,
                                 P_AGRMNTTYPE   => P_AGRMNTTYPE,
                                 P_INITCUSTID   => P_INITCUSTID,
                                 P_TRUSTCUSTID  => P_TRUSTCUSTID,
                                 P_DENOMCOUNT   => P_DENOMCOUNT,
                                 P_AGRMNTID     => P_AGRMNTID,
                                 p_STATUSCODE     => nvl(SQLCODE, 0),
                                 p_ERRORMESSAGE   => nvl(p_ERRORMESSAGE,'Ok'));
  exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_depositagreemnt_trans failed with mess:' || sqlerrm);
  end;

 end;

 function get_risklist (p_rnk IN NUMBER) return t_risks pipelined
 is
 l_risks r_risks;
 begin
  for k in (select * from customer_risk where rnk = p_rnk)
  loop
   l_risks.riskid := k.risk_id;
   l_risks.dat_begin := k.dat_begin;
   l_risks.dat_end := k.dat_end;
   pipe row(l_risks);
  end loop;
 end;

 function getInstantDict return t_instant pipelined
 is
 l_instant r_instant;
 begin
  for k in (select wp.code productCode, wp.name productName, vc.code CardCode, vc.sub_name CardName, t.lcv KV
              from w4_product wp, v_w4_card vc, tabval t
             where grp_code = 'INSTANT' and nvl(date_close, gl.bd + 1) > gl.bd
               and vc.product_code = wp.code
               and wp.kv = t.kv
             order by wp.code)
  loop
   l_instant.productCode := k.productCode;
   l_instant.productName := k.productName;
   l_instant.CardCode := k.CardCode;
   l_instant.CardName := k.CardName;
   l_instant.KV := k.KV;

   pipe row(l_instant);
  end loop;

 end;

 FUNCTION OrderInstant (p_transactionid   IN     NUMBER,
                        p_cardcode        IN     v_w4_card.code%TYPE,
                        p_Branch          IN     accounts.branch%TYPE,
                        p_cardcount       IN     NUMBER)
  RETURN t_instantlist
  PIPELINED
  is
  pragma autonomous_transaction;
  l_instantrow r_instantrow;
  l_statuscode int;
  l_ERRORMESSAGE varchar2(4000);
  begin
    bc.go (p_branch);
    BEGIN
       bars_ow.create_instant_cards (p_cardcode   => p_cardcode,
                                     p_branch     => p_branch,
                                     p_cardnum    => p_cardcount);
    exception when others then l_ERRORMESSAGE := 'xrm_InstantcardOrder_trans:' || sqlerrm;
    END;

    bars_audit.trace(
     'xrm_ui_oe.xrm_InstantcardOrder_trans(p_TransactionId   => '||to_char(p_transactionid)||',
	                                      P_CARDCODE     	=> '||P_CARDCODE||',
                                          P_BRANCH     		=> '||P_BRANCH||',
                                          P_CARDCOUNT    	=> '||to_char(P_CARDCOUNT)||',
                                          p_STATUSCODE     	=> '||NVL(SQLCODE, 0)||',
                                          p_ERRORMESSAGE   	=> '||NVL(l_ERRORMESSAGE,'Ok')||');');
    begin
     xrm_ui_oe.xrm_InstantcardOrder_trans(p_TransactionId   => p_transactionid,
	                                      P_CARDCODE     	=> P_CARDCODE,
                                          P_BRANCH     		=> P_BRANCH,
                                          P_CARDCOUNT    	=> P_CARDCOUNT,
                                          p_STATUSCODE     	=> NVL(SQLCODE, 0),
                                          p_ERRORMESSAGE   	=> NVL(l_ERRORMESSAGE,'Ok'));
    exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_InstantcardOrder_trans failed with mess:' || sqlerrm);
    end;
    commit;
    for k in (
    SELECT a.acc,
          a.nls,
          (select lcv from tabval$global where kv = a.kv) KV,
          a.tip,
          a.daos,
          w.card_code,
          c.sub_code,
          a.branch
     FROM w4_acc_instant w, accounts a, w4_card c
    WHERE w.acc = a.acc
      --AND a.tip = 'W4I'
      AND w.card_code = c.code
      AND a.branch = p_branch
      and w.card_code = p_cardcode
      and a.isp = ( SELECT user_id
                      FROM staff_ad_user
                     WHERE upper(active_directory_name) = (SELECT upper(user_login)
                                                             FROM xrmsw_audit
                                                            WHERE transactionid = p_transactionid))
      and a.daos = gl.bd
      and rownum <= P_CARDCOUNT
      order by a.acc desc)
   loop
    l_instantrow.NLS := k.NLS;
    l_instantrow.Branch := k.Branch;
    l_instantrow.KV := k.KV;
    pipe row (l_instantrow);
   end loop;
  end;

  FUNCTION SetGetCardParam (p_TransactionId   IN NUMBER,
                            p_nd              IN w4_acc.nd%TYPE,
                            p_xmltags         IN CLOB) return t_cardParams pipelined
  is
  pragma autonomous_transaction;
  l_cardParam 		r_cardParam;
  l_ERRORMESSAGE 	varchar2(4000) := null;
  l_dataxml      	XMLTYPE;
  l_counttags 		number(38);
  p_acc				accounts.acc%type;
  FUNCTION get_data_from_xml
     (p_dataxml xmltype, p_param varchar2)
  RETURN varchar2
  IS
    l_str   varchar2(254);
    l_value varchar2(254);
  BEGIN

    l_str :=  '/params/'||p_param||'/text()';

    IF (p_dataxml.extract(l_str) IS NOT NULL) THEN
      l_value := p_dataxml.extract(l_str).getStringVal();
    ELSE
      l_value := NULL;
    END IF;

    RETURN l_value;

  END get_data_from_xml;

  begin
    bc.go('/'||f_ourmfo||'/');
	bars_audit.info( 'p_nd = ' || p_nd || ',p_xmltags= ' ||p_xmltags);
    l_dataxml :=   XMLTYPE.createXML(p_xmltags);
   select to_number(xmlquery('count($doc/params/descendant::*)' passing l_dataxml as "doc" returning content))/2
     into l_counttags
     from dual;

   begin
    select acc_pk
      into p_acc
      from w4_acc
     where nd = p_nd;
   exception when no_data_found then null;
   end;

   if (p_acc is not null)
   then
    for i in 1 .. l_counttags
    loop
     l_cardParam.TAG := get_data_from_xml(l_dataxml, 'TAG['||to_char(i)||']');
     l_cardParam.VAL := get_data_from_xml(l_dataxml, 'VAL['||to_char(i)||']');
     --bars_audit.info('xrm_integration_oe.SetGetCardParam: l_cardParam.TAG='|| l_cardParam.TAG || ', l_cardParam.VAL='|| l_cardParam.VAL);
	 begin
      accreg.setAccountwParam(p_acc, l_cardParam.TAG, l_cardParam.VAL);
	 exception when others then l_ERRORMESSAGE := ' Параметра з тегом ' || l_cardParam.TAG || ' не існує! Неможливо встановити.';
	 end;
     commit;
	 bars_audit.info('l_ERRORMESSAGE = '|| l_ERRORMESSAGE);
    end loop;
    --l_cardParam := null;

    for k in (select tag, value val, 'Ok' err from accountsw where acc = p_acc
			   union all
			   select l_cardParam.TAG, l_cardParam.VAL, l_ERRORMESSAGE from dual where l_ERRORMESSAGE is not null
			   )
    loop
     l_cardParam.TAG := k.tag;
     l_cardParam.val := k.val;
	 l_cardParam.ERR := k.err;
     pipe row (l_cardParam);
    end loop;
   end if;

   begin
     xrm_ui_oe.xrm_SetGetCardParams_trans(p_TransactionId   => p_transactionid,
	                                      P_ND		     	=> P_ND,
                                          P_XMLTAGS    		=> P_XMLTAGS,
                                          p_STATUSCODE     	=> NVL(SQLCODE, 0),
                                          p_ERRORMESSAGE   	=> NVL(l_ERRORMESSAGE,'Ok'));
   exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_SetGetCardParams_trans failed with mess:' || sqlerrm);
   end;
  end;

  PROCEDURE CreateRegular   (p_TransactionId  IN NUMBER,
                             IDS                 sto_det.ids%TYPE DEFAULT NULL,
                             ord                 sto_det.ord%TYPE,
                             tt                  sto_det.tt%TYPE,
                             vob                 sto_det.vob%TYPE,
                             dk                  sto_det.dk%TYPE,
                             nlsa                sto_det.nlsa%TYPE,
                             kva                 sto_det.kva%TYPE,
                             nlsb                sto_det.nlsb%TYPE,
                             kvb                 sto_det.kvb%TYPE,
                             mfob                sto_det.mfob%TYPE,
                             polu                sto_det.polu%TYPE,
                             nazn                sto_det.nazn%TYPE,
                             fsum                sto_det.fsum%TYPE,
                             okpo                sto_det.okpo%TYPE,
                             DAT1                sto_det.dat1%TYPE,
                             DAT2                sto_det.dat2%TYPE,
                             FREQ                sto_det.freq%TYPE,
                             DAT0                sto_det.dat0%TYPE,
                             WEND                sto_det.wend%TYPE,
                             DR                  sto_det.dr%TYPE,
                             branch              sto_det.branch%TYPE,
                             p_nd                cc_deal.nd%TYPE,
                             p_sdate             cc_deal.sdate%TYPE,
                             p_idd           OUT sto_det.idd%TYPE,
                             p_status        OUT NUMBER,
                             p_status_text   OUT VARCHAR2)
 is
 l_rnk customer.rnk%type;
 l_tmp varchar2(50);
 l_ord int := nvl(ord,1);
 l_ids number := IDS;
 begin
  begin
      select rnk
        into l_rnk
        from accounts
        where nls = nlsa
          and kv = kva;
  exception when no_data_found then p_status := -1; p_status_text := 'Рахунку '|| nlsa || ' не знайдено в валюті/'|| to_char(kva);     return;
  end;
  l_tmp := freq;
  begin
   select to_char(freq)
     into l_tmp
     from freq
    where freq = l_tmp;
  exception when no_data_found then p_status := -1; p_status_text := 'Не існує періодичність з кодом '|| to_char(freq);   return;
  end;

   select max(ord)+1
     into l_ord
     from sto_det 
    where ids = l_ids;    
  
  begin
      STO_ALL.Add_RegularTreaty (IDS         => IDS,
                                 ord         => l_ord,        
                                 tt          => tt,
                                 vob         => vob,
                                 dk          => dk,
                                 nlsa        => nlsa,
                                 kva         => kva,
                                 nlsb        => nlsb,
                                 kvb         => kvb,
                                 mfob        => mfob,
                                 polu        => polu,
                                 nazn        => nazn,
                                 fsum        => fsum,
                                 okpo        => okpo,
                                 DAT1        => DAT1,
                                 DAT2        => DAT2,
                                 FREQ        => FREQ,
                                 DAT0        => DAT0,
                                 WEND        => WEND,
                                 DR          => DR,
                                 branch      => branch,
                                 p_nd        => p_nd,
                                 p_sdate     => p_sdate,
                                 p_idd       => p_idd,
                                 p_status    => p_status,
                                 p_status_text => p_status_text);
   exception when others then p_status_text := p_status_text || sqlerrm;
   end;
   begin
     xrm_ui_oe.xrm_regular_trans(p_TransactionId   => p_transactionid,
                                 Rnk        => l_rnk,
                                 StartDate  => DAT1,
                                 FinishDate => DAT2,
                                 Frequency  => FREQ,
                                 KV         => KVA,
                                 NLSA       => nlsa,
                                 OKPOB      => okpo,
                                 NAMEB      => polu,
                                 MFOB       => mfob,
                                 NLSB       => NLSB,
                                 Holyday    => WEND,
                                 fSum       => fsum,
                                 Purpose    => nazn,
                                 DPT_ID     => null,
                                 AGR_ID     => null,
                                 StatusCode => NVL(SQLCODE, 0),
                                 ErrorMessage => NVL(sqlerrm,'Ok'));
   exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_SetGetCardParams_trans failed with mess:' || sqlerrm);
   end;
 end;
 procedure CardBulkInsert(p_unit_type_code in    varchar2,
                          p_ext_id         in    varchar2,
                          p_receiver_url   in    varchar2,
                          p_request_data   in    clob,
                          p_hash           in    varchar2,
                          p_state            out number,
                          p_msg              out varchar2,
                          p_bulkid           out number)
 is
 l_res number;
 begin
    begin
    l_res := barstrans.transport_utl.create_transport_unit(
     p_unit_type_code   => p_unit_type_code,
     p_ext_id           => p_ext_id,
     p_receiver_url     => p_receiver_url,
     p_request_data     => p_request_data,
     p_hash             => p_hash,
     p_state            => p_state,
     p_msg              => p_msg);
    end;
  p_bulkid := l_res;
 end;

  procedure CardBulkTicket(p_bulkid         in    number,
                           p_bulkstatus       out varchar2,
                           p_ticket           out clob)
  is
  begin
   p_bulkstatus := barstrans.transport_utl.get_unit_state(p_bulkid);
   if p_bulkstatus = barstrans.transport_utl.trans_state_done
   then
    p_ticket :=  barstrans.transport_utl.get_unit_respinbase64(p_bulkid);
    p_bulkstatus := 'Файл оброблено. Квитанція у вкладенні.';
   else p_bulkstatus := 'Файл в обробці.';
   end if;
  end;

    PROCEDURE CreateSbonContr (p_TransactionId       IN     NUMBER,
                               p_payer_account_id    IN     INTEGER,
                               p_start_date          IN     DATE,
                               p_stop_date           IN     DATE,
                               p_payment_frequency   IN     INTEGER,
                               p_holiday_shift       IN     INTEGER,
                               p_provider_id         IN     INTEGER,
                               p_personal_account    IN     VARCHAR2,
                               p_regular_amount      IN     NUMBER,
                               p_ceiling_amount      IN     NUMBER,
                               p_extra_attributes    IN     CLOB,
                               p_sendsms             IN     VARCHAR2,
                               p_order_id               OUT NUMBER,
                               p_result_code            OUT NUMBER,
                               p_result_message         OUT VARCHAR2)
    is
    begin
         STO_UI.NEW_SBON_ORDER_WITH_CONTR_EXT(
                p_payer_account_id     => p_payer_account_id,
                p_start_date           => p_start_date,
                p_stop_date            => p_stop_date,
                p_payment_frequency    => p_payment_frequency,
                p_holiday_shift        => p_holiday_shift,
                p_provider_id          => p_provider_id,
                p_personal_account     => p_personal_account,
                p_regular_amount       => p_regular_amount,
                p_ceiling_amount       => p_ceiling_amount,
                p_extra_attributes     => p_extra_attributes,
                p_sendsms              => p_sendsms,
                p_order_id             => p_order_id,
                p_result_code          => p_result_code,
                p_result_message       => p_result_message);
    
         begin
         xrm_ui_oe.xrm_Sbon_trans (
                   p_TransactionId     => p_TransactionId,
                   SBONTYPE            => 'Contr', -- Contr, NoContr
                   payer_account_id    => p_payer_account_id,
                   start_date          => p_start_date,
                   stop_date           => p_stop_date,
                   payment_frequency   => p_payment_frequency,
                   holiday_shift       => p_holiday_shift,
                   provider_id         => p_provider_id,
                   personal_account    => p_personal_account,
                   regular_amount      => p_regular_amount,
                   ceiling_amount      => p_ceiling_amount,
                   extra_attributes    => p_extra_attributes,
                   sendsms             => p_sendsms,
                   orderid             => p_order_id,
                   StatusCode          => p_result_code,
                   ErrorMessage        => p_result_message);
          exception when others then bars_audit.error(title||'xrm_ui_oe.CreateFreeSbonRegular failed with mess:' || sqlerrm);  
          end; 
    end;

    PROCEDURE CreateSbonNoContr (p_TransactionId       IN     NUMBER,
                                 p_payer_account_id    IN     INTEGER,
                                 p_start_date          IN     DATE,
                                 p_stop_date           IN     DATE,
                                 p_payment_frequency   IN     INTEGER,
                                 p_holiday_shift       IN     INTEGER,
                                 p_provider_id         IN     INTEGER,
                                 p_personal_account    IN     VARCHAR2,
                                 p_regular_amount      IN     NUMBER,                                 
                                 p_extra_attributes    IN     CLOB,
                                 p_sendsms             IN     VARCHAR2,
                                 p_order_id               OUT NUMBER,
                                 p_result_code            OUT NUMBER,
                                 p_result_message         OUT VARCHAR2)
    is
    begin
         STO_UI.NEW_SBON_ORDER_WITH_NO_CONTR_E(
                p_payer_account_id          =>p_payer_account_id,
                p_start_date                => p_start_date,
                p_stop_date                 => p_stop_date,
                p_payment_frequency         => p_payment_frequency,
                p_holiday_shift             => p_holiday_shift,
                p_provider_id               => p_provider_id,
                p_personal_account          => p_personal_account,
                p_regular_amount            => p_regular_amount,                
                p_extra_attributes          => p_extra_attributes,
                p_sendsms                   => p_sendsms,
                p_order_id                  => p_order_id,
                p_result_code               => p_result_code,
                p_result_message            => p_result_message);
        begin
         xrm_ui_oe.xrm_Sbon_trans (
                   p_TransactionId     => p_TransactionId,
                   SBONTYPE            => 'NoContr', -- Contr, NoContr
                   payer_account_id    => p_payer_account_id,
                   start_date          => p_start_date,
                   stop_date           => p_stop_date,
                   payment_frequency   => p_payment_frequency,
                   holiday_shift       => p_holiday_shift,
                   provider_id         => p_provider_id,
                   personal_account    => p_personal_account,
                   regular_amount      => p_regular_amount,
                   ceiling_amount      => 0,
                   extra_attributes    => p_extra_attributes,
                   sendsms             => p_sendsms,
                   orderid             => p_order_id,
                   StatusCode          => p_result_code,
                   ErrorMessage        => p_result_message);                   
        exception when others then bars_audit.error(title||'xrm_ui_oe.CreateFreeSbonRegular failed with mess:' || sqlerrm);  
        end; 
    end;                                 

    PROCEDURE CreateFreeSbonRegular (p_TransactionId       IN     NUMBER,
                                     p_payer_account_id    IN     INTEGER,
                                     p_start_date          IN     DATE,
                                     p_stop_date           IN     DATE,
                                     p_payment_frequency   IN     INTEGER,
                                     p_holiday_shift       IN     INTEGER,
                                     p_provider_id         IN     INTEGER,
                                     p_regular_amount      IN     NUMBER,
                                     p_receiver_mfo        IN     VARCHAR2,
                                     p_receiver_account    IN     VARCHAR2,
                                     p_receiver_name       IN     VARCHAR2,
                                     p_receiver_edrpou     IN     VARCHAR2,
                                     p_purpose             IN     VARCHAR2,
                                     p_extra_attributes    IN     CLOB,
                                     p_sendsms             IN     VARCHAR2,
                                     p_order_id               OUT NUMBER,
                                     p_result_code            OUT NUMBER,
                                     p_result_message         OUT VARCHAR2)
    is
    begin
        sto_ui.new_free_sbon_order_ext(
                p_payer_account_id      =>p_payer_account_id,
                p_start_date            =>p_start_date,
                p_stop_date             =>p_stop_date,
                p_payment_frequency     =>p_payment_frequency,
                p_holiday_shift         =>p_holiday_shift,
                p_provider_id           =>p_provider_id,
                p_regular_amount        =>p_regular_amount,
                p_receiver_mfo          =>p_receiver_mfo,
                p_receiver_account      =>p_receiver_account,
                p_receiver_name         =>p_receiver_name,
                p_receiver_edrpou       =>p_receiver_edrpou,
                p_purpose               =>p_purpose,
                p_extra_attributes      =>p_extra_attributes,
                p_sendsms               =>p_sendsms,
                p_order_id              =>p_order_id,
                p_result_code           =>p_result_code,
                p_result_message        =>p_result_message);
    
       begin   
         xrm_ui_oe.xrm_freesbon_trans(p_TransactionId   => p_transactionid,
                                      payer_account_id  => p_payer_account_id,
                                      start_date        => p_start_date,
                                      stop_date         => p_stop_date,
                                      payment_frequency => p_payment_frequency,
                                      holiday_shift     => p_holiday_shift,
                                      provider_id       => p_provider_id,
                                      regular_amount    => p_regular_amount,
                                      receiver_mfo      => p_receiver_mfo,
                                      receiver_account  => p_receiver_account,
                                      receiver_name     => p_receiver_name,
                                      receiver_edrpou   => p_receiver_edrpou,
                                      purpose           => p_purpose,
                                      extra_attributes  => p_extra_attributes,
                                      sendsms           => p_sendsms,
                                      orderid           => p_order_id,
                                      StatusCode => NVL(p_result_code, SQLCODE),
                                      ErrorMessage => NVL(p_result_message, sqlerrm));   
       exception when others then bars_audit.error(title||'xrm_ui_oe.CreateFreeSbonRegular failed with mess:' || sqlerrm);  
       end;    
    end;                                        
 
    PROCEDURE MapDKBO (p_TransactionId    IN     NUMBER,
                       p_customer_id      IN     customer.rnk%TYPE,
                       p_deal_number      IN     deal.deal_number%TYPE DEFAULT NULL,
                       p_acc_list         IN     varchar2,
                       p_dkbo_date_from   IN     DATE DEFAULT bankdate,
                       p_dkbo_date_to     IN     DATE DEFAULT trunc(add_months(bankdate, 12)),
                       p_dkbo_state       IN     VARCHAR2 DEFAULT 'CONNECTED',
                       p_deal_id            OUT INTEGER,
                       p_start_date         OUT DATE)
     is
     p_result_code number := 0;
     p_result_message varchar2(4000);
     l_acclist varchar2(4000);
     acc_list number_list;
    begin
    bars_audit.info('xrm_integration_oe:MapDKBO: acc_list = ' ||p_acc_list ||', p_customer_id =' || to_char(p_customer_id));
     acc_list := tools.string_to_number_list(p_acc_list,',');
     begin
         pkg_dkbo_utl.p_acc_map_to_dkbo(
            in_customer_id  => p_customer_id,
            in_acc_list     => acc_list,
            out_deal_id     => p_deal_id);
         
        select d.start_date
          into p_start_date 
          from deal d 
         where d.id = p_deal_id;
     exception when others then p_result_code := -1;  p_result_message := dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace();   
     end;
     
      begin   
         xrm_ui_oe.xrm_dkbo_trans ( TransactionId    => p_TransactionId,
                                    Rnk              => nvl(p_customer_id,-1),
                                    DealNumber       => p_deal_number,
                                    acc_list         => p_acc_list,
                                    dkbo_date_from   => p_dkbo_date_from,
                                    dkbo_date_to     => p_dkbo_date_to,
                                    dkbo_date_state  => nvl(p_dkbo_state,-1),
                                    deal_id          => nvl(p_deal_id,-1),
                                    start_date       => p_start_date,
                                    StatusCode       => NVL(p_result_code, SQLCODE),
                                    ErrorMessage     => NVL(p_result_message, sqlerrm));   
       exception when others then bars_audit.error(title||'xrm_ui_oe.xrm_dkbo_trans failed with mess:' || dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());  
       end;   
    
    end;
    
    function getversion return varchar2
    is
    l_version varchar2(1000);
    begin
        begin
        SELECT ver || ' installed ' || TO_CHAR (max_inst_date, 'dd.mm.yyyy HH:MI:SS')
          INTO l_version
          FROM (SELECT 'vers.id ='
                       || version_id || ' (' || TO_CHAR (version_date, 'dd.mm.yyyy')|| ')'              
                          AS ver,
                       install_date,
                       MAX (install_date) OVER (ORDER BY install_date DESC)
                          AS max_inst_date
                  FROM XRMSW_VERSION t)
         WHERE install_date = max_inst_date;
        exception when no_data_found then l_version := 'unknown';
        end;
      return l_version;
    end;                                                                            
END;
/
 show err;
 
PROMPT *** Create  grants  XRM_INTEGRATION_OE ***
grant DEBUG,EXECUTE                                                          on XRM_INTEGRATION_OE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/xrm_integration_oe.sql =========*** 
 PROMPT ===================================================================================== 
 