
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kl.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KL 
IS

--***************************************************************************--
-- (C) BARS. Contragents
--***************************************************************************--

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.6 28/09/2018';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''
$if KL_PARAMS.TREASURY $then
  || 'KAZ  - ��� ������������ (��� ����.��������, ������ ��.��� � ��.������)' || chr(10)
$end
$if KL_PARAMS.SIGN $then
  || 'SIGN - � �������� ���������� �������/������' || chr(10)
$end
;

  cus_rec customer%ROWTYPE;       -- Transit record of customer update(TRIG)
  cus_otm SMALLINT;               -- Flag of kind changing for Customer_Update


--****** header_version - ���������� ������ ��������� ������ ****************--
function header_version return varchar2;

--****** body_version - ���������� ������ ���� ������ ***********************--
function body_version return varchar2;



--***************************************************************************--
-- function 	: isCustomerTr
-- description	: ������� �������� ������������ ������� �� �������������� � ������ �����������
--***************************************************************************--
function isCustomerTr (
  pNmk    customer.nmk%type,
  pNmkk   customer.nmkk%type,
  pNmkv   customer.nmkv%type ) return number;

--***************************************************************************--
-- procedure 	: checkFM
-- description	: ��������� �������� ������������ ������� �� �������������� � ������ �����������
--***************************************************************************--
procedure checkFM (
  pNmk   in customer.nmk%type,
  pNmkk  in customer.nmkk%type,
  pNmkv  in customer.nmkv%type,
  pIdTr out number );

--***************************************************************************--
-- procedure 	: open_client
-- description	: ��������� ����������� ������� � ��������� ���
--***************************************************************************--
procedure open_client (
  Rnk_        IN customer.rnk%type,         -- Customer number
  Custtype_      customer.custtype%type,    -- ��� �������: 1-����, 2-��.����, 3-���.����
  Nd_            customer.nd%type,          -- � ��������
  Nmk_           varchar2,                  -- ������������ �������
  Nmkv_          customer.nmkv%type,        -- ������������ ������� �������������
  Nmkk_          customer.nmkk%type,        -- ������������ ������� �������
  Adr_           customer.adr%type,         -- ����� �������
  Codcagent_     customer.codcagent%type,   -- ��������������
  Country_       customer.country%type,     -- ������
  Prinsider_     customer.prinsider%type,   -- ������� ���������
  Tgr_           customer.tgr%type,         -- ��� ���.�������
  Okpo_          customer.okpo%type,        -- ����
  Stmt_          customer.stmt%type,        -- ������ �������
  Sab_           customer.sab%type,         -- ��.���
  DateOn_        customer.date_on%type,     -- ���� �����������
  Taxf_          customer.taxf%type,        -- ��������� ���
  CReg_          customer.c_reg%type,       -- ��� ���.��
  CDst_          customer.c_dst%type,       -- ��� �����.��
  Adm_           customer.adm%type,         -- �����.�����
  RgTax_         customer.rgtax%type,       -- ��� ����� � ��
  RgAdm_         customer.rgadm%type,       -- ��� ����� � ���.
  DateT_         customer.datet%type,       -- ���� ��� � ��
  DateA_         customer.datea%type,       -- ���� ���. � �������������
  Ise_           customer.ise%type,         -- ����. ���. ���������
  Fs_            customer.fs%type,          -- ����� �������������
  Oe_            customer.oe%type,          -- ������� ���������
  Ved_           customer.ved%type,         -- ��� ��. ������������
  Sed_           customer.sed%type,         -- ����� ��������������
  K050_          customer.k050%type,        -- ���������� k050
  Notes_         customer.notes%type,       -- ����������
  Notesec_       customer.notesec%type,     -- ���������� ��� ������ ������������
  CRisk_         customer.crisk%type,       -- ��������� �����
  Pincode_       customer.pincode%type,     --
  RnkP_          customer.rnkp%type,        -- ���. ����� ��������
  Lim_           customer.lim%type,         -- ����� �����
  NomPDV_        customer.nompdv%type,      -- � � ������� ����. ���
  MB_            customer.mb%type,          -- �������. ������ �������
  BC_            customer.bc%type,          -- ������� ��������� �����
  Tobo_          customer.tobo%type,        -- ��� �������������� ���������
  Isp_           customer.isp%type          -- �������� ������� (�����. �����������)
) ;

--***************************************************************************--
-- procedure 	: setCustomerAttr
-- description	: ��������� ����������� �������/���������� ���������� �������
--***************************************************************************--
procedure setCustomerAttr (
  Rnk_    IN OUT customer.rnk%type,         -- Customer number
  Custtype_      customer.custtype%type,    -- ��� �������: 1-����, 2-��.����, 3-���.����
  Nd_            customer.nd%type,          -- � ��������
  Nmk_           varchar2,                  -- ������������ �������
  Nmkv_          customer.nmkv%type,        -- ������������ ������� �������������
  Nmkk_          customer.nmkk%type,        -- ������������ ������� �������
  Adr_           customer.adr%type,         -- ����� �������
  Codcagent_     customer.codcagent%type,   -- ��������������
  Country_       customer.country%type,     -- ������
  Prinsider_     customer.prinsider%type,   -- ������� ���������
  Tgr_           customer.tgr%type,         -- ��� ���.�������
  Okpo_          customer.okpo%type,        -- ����
  Stmt_          customer.stmt%type,        -- ������ �������
  Sab_           customer.sab%type,         -- ��.���
  DateOn_        customer.date_on%type,     -- ���� �����������
  Taxf_          customer.taxf%type,        -- ��������� ���
  CReg_          customer.c_reg%type,        -- ��� ���.��
  CDst_          customer.c_dst%type,        -- ��� �����.��
  Adm_           customer.adm%type,         -- �����.�����
  RgTax_         customer.rgtax%type,       -- ��� ����� � ��
  RgAdm_         customer.rgadm%type,       -- ��� ����� � ���.
  DateT_         customer.datet%type,       -- ���� ��� � ��
  DateA_         customer.datea%type,       -- ���� ���. � �������������
  Ise_           customer.ise%type,         -- ����. ���. ���������
  Fs_            customer.fs%type,          -- ����� �������������
  Oe_            customer.oe%type,          -- ������� ���������
  Ved_           customer.ved%type,         -- ��� ��. ������������
  Sed_           customer.sed%type,         -- ����� ��������������
  Notes_         customer.notes%type,       -- ����������
  Notesec_       customer.notesec%type,     -- ���������� ��� ������ ������������
  CRisk_         customer.crisk%type,       -- ��������� �����
  Pincode_       customer.pincode%type,     --
  RnkP_          customer.rnkp%type,        -- ���. ����� ��������
  Lim_           customer.lim%type,         -- ����� �����
  NomPDV_        customer.nompdv%type,      -- � � ������� ����. ���
  MB_            customer.mb%type,          -- �������. ������ �������
  BC_            customer.bc%type,          -- ������� ��������� �����
  Tobo_          customer.tobo%type,        -- ��� �������������� ���������
  Isp_           customer.isp%type,         -- �������� ������� (�����. �����������)
  p_nrezid_code  customer.nrezid_code%type default null,
  p_flag_visa    number default 0 );

--***************************************************************************--
-- procedure 	: setCustomerEN
-- description	: ��������� ��������� ������������� ����������� �������
--***************************************************************************--
procedure setCustomerEN (
  p_rnk   customer.rnk%type,
  p_k070  customer.ise%type,
  p_k080  customer.fs%type,
  p_k110  customer.ved%type,
  p_k090  customer.oe%type,
  p_k050  customer.k050%type,
  p_k051  customer.sed%type,
  p_flag_visa number default 0 );

--***************************************************************************--
-- procedure 	: setBankAttr
-- description	: ��������� ����������� �������-�����/���������� ����������
--***************************************************************************--
procedure setBankAttr (
  Rnk_      custbank.rnk%type,
  Mfo_      custbank.mfo%type,
  Bic_      custbank.bic%type,
  BicAlt_   custbank.alt_bic%type,
  Rating_   custbank.rating%type,
  Kod_b_    custbank.kod_b%type,
  Ruk_      custbank.ruk%type,
  Telr_     custbank.telr%type,
  Buh_      custbank.buh%type,
  Telb_     custbank.telb%type,
  k190_     custbank.k190%type ) ;

--***************************************************************************--
-- procedure 	: setCorpAttr
-- description	: ��������� ����������� �������-��.����/���������� ����������
--***************************************************************************--
procedure setCorpAttr (
  Rnk_      corps.rnk%type,
  Nmku_     corps.nmku%type,
  Ruk_      corps.ruk%type,
  Telr_     corps.telr%type,
  Buh_      corps.buh%type,
  Telb_     corps.telb%type,
  TelFax_   corps.tel_fax%type,
  EMail_    corps.e_mail%type,
  SealId_   corps.seal_id%type,
  p_flag_visa number default 0 ) ;

--***************************************************************************--
-- procedure 	: setPersonAttr
-- description	: ��������� ����������� �������-���.����/���������� ����������
--***************************************************************************--
procedure setPersonAttr (
  Rnk_          person.rnk%type,
  Sex_          person.sex%type,
  Passp_        person.passp%type,
  Ser_          person.ser%type,
  Numdoc_       person.numdoc%type,
  Pdate_        person.pdate%type,
  Organ_        person.organ%type,
  Bday_         person.bday%type,
  Bplace_       person.bplace%type,
  Teld_         person.teld%type,
  Telw_         person.telw%type,
  Telm_         person.cellphone%type default null,
  actual_date_  person.actual_date%type default null,
  eddr_id_      person.eddr_id%type default null,
  p_flag_visa   number default 0,
  Fdate_        person.date_photo%type default null
);


--***************************************************************************--
-- procedure   : setPersonAttrEx
-- description : ��������� ��������� ���������� ������������ ����� �볺��� ��
--***************************************************************************--
PROCEDURE setPersonAttrEx
( Rnk_      person.rnk%type,
  Sex_      person.sex%type,
  Passp_    person.passp%type,
  Ser_      person.ser%type,
  Numdoc_   person.numdoc%type,
  Pdate_    person.pdate%type,
  Organ_    person.organ%type,
  Fdate_    person.date_photo%type,	-- ���� ���� ���� ������ ������� ���������� � �������
  Bday_     person.bday%type,
  Bplace_   person.bplace%type,
  TelD_     person.teld%type,       -- �������  ������� �볺���
  TelW_     person.telw%type,       -- �������   ������� �볺���
  TelM_     person.cellphone%type default null,  -- �������� ������� �볺���
  actual_date_  person.actual_date%type default null,
  eddr_id_      person.eddr_id%type default null);

--***************************************************************************--
-- procedure 	: setCustomerRekv
-- description	: ��������� ���������� ���������� �������
--***************************************************************************--
procedure setCustomerRekv (
  Rnk_       rnk_rekv.rnk%type,
  LimKass_   rnk_rekv.lim_kass%type,
  AdrAlt_    rnk_rekv.adr_alt%type,
  NomDog_    rnk_rekv.nom_dog%type ) ;

--***************************************************************************--
-- procedure 	: setCustomerElement
-- description	: ��������� ���������� ���������� �������
--***************************************************************************--
procedure setCustomerElement (
  Rnk_   customerw.rnk%type,
  Tag_   customerw.tag%type,
  Val_   customerw.value%type,
  Otd_   customerw.isp%type,
  p_flag_visa number default 0 ) ;

$if KL_PARAMS.TREASURY $then
$else
--***************************************************************************--
-- procedure 	: setCustomerExtern
-- description	: ��������� ���������� ���������� ���������� �����
--***************************************************************************--
procedure setCustomerExtern (
  p_id         in out customer_extern.id%type,
  p_name              customer_extern.name%type,
  p_doctype           customer_extern.doc_type%type,
  p_docserial         customer_extern.doc_serial%type,
  p_docnumber         customer_extern.doc_number%type,
  p_docdate           customer_extern.doc_date%type,
  p_docissuer         customer_extern.doc_issuer%type,
  p_birthday          customer_extern.birthday%type,
  p_birthplace        customer_extern.birthplace%type,
  p_sex               customer_extern.sex%type,
  p_adr               customer_extern.adr%type,
  p_tel               customer_extern.tel%type,
  p_email             customer_extern.email%type,
  p_custtype          customer_extern.custtype%type,
  p_okpo              customer_extern.okpo%type,
  p_country           customer_extern.country%type,
  p_region            customer_extern.region%type,
  p_fs                customer_extern.fs%type,
  p_ved               customer_extern.ved%type,
  p_sed               customer_extern.sed%type,
  p_ise               customer_extern.ise%type,
  p_notes             customer_extern.notes%type,
  p_date_photo        customer_extern.date_photo%type default null,
  p_eddr_id           customer_extern.eddr_id%type default null,
  p_actual_date       customer_extern.actual_date%type default null );

--***************************************************************************--
-- procedure 	: setCustomerRel
-- description	: ��������� ���������� ���������� ������� "��������� ����"
--***************************************************************************--
procedure setCustomerRel (
  p_rnk              customer_rel.rnk%type,
  p_relid            customer_rel.rel_id%type,
  p_relrnk           customer_rel.rel_rnk%type,
  p_relintext        customer_rel.rel_intext%type,
  p_vaga1            customer_rel.vaga1%type,
  p_vaga2            customer_rel.vaga2%type,
  p_typeid           customer_rel.type_id%type,
  p_position         customer_rel.position%type,
  p_position_r       customer_rel.position_r%type,
  p_firstname        customer_rel.first_name%type,
  p_middlename       customer_rel.middle_name%type,
  p_lastname         customer_rel.last_name%type,
  p_documenttypeid   customer_rel.document_type_id%type,
  p_document         customer_rel.document%type,
  p_trustregnum      customer_rel.trust_regnum%type,
  p_trustregdat      customer_rel.trust_regdat%type,
  p_bdate            customer_rel.bdate%type,
  p_edate            customer_rel.edate%type,
  p_notaryname       customer_rel.notary_name%type,
  p_notaryregion     customer_rel.notary_region%type,
  p_signprivs        customer_rel.sign_privs%type,
  p_signid           customer_rel.sign_id%type,
  p_namer            customer_rel.name_r%type,
  p_flag_visa number default 0 ) ;

--***************************************************************************--
-- procedure 	: delCustomerRel
-- description	: ��������� �������� ���������� ������� "��������� ����"
--***************************************************************************--
procedure delCustomerRel (
  p_rnk       customer_rel.rnk%type,
  p_relid     customer_rel.rel_id%type,
  p_relrnk    customer_rel.rel_rnk%type,
  p_relintext customer_rel.rel_intext%type,
  p_flag_visa number default 0 );
$end

--***************************************************************************--
-- procedure 	: setCustomerAddress
-- description	: ��������� ���������� ������� �������
--***************************************************************************--
procedure setCustomerAddress (
  Rnk_         customer_address.rnk%type,
  TypeId_      customer_address.type_id%type,
  Country_     customer_address.country%type,
  Zip_         customer_address.zip%type,
  Domain_      customer_address.domain%type,
  Region_      customer_address.region%type,
  Locality_    customer_address.locality%type,
  Address_     customer_address.address%type );

--***************************************************************************--
-- procedure 	: setCustomerAddressByTerritory
-- description	: ��������� ���������� ������� �������
--***************************************************************************--
procedure setCustomerAddressByTerritory (
  Rnk_         customer_address.rnk%type,
  TypeId_      customer_address.type_id%type,
  Country_     customer_address.country%type,
  Zip_         customer_address.zip%type,
  Domain_      customer_address.domain%type,
  Region_      customer_address.region%type,
  Locality_    customer_address.locality%type,
  Address_     customer_address.address%type,
  TerritoryId_ customer_address.territory_id%type,
  p_flag_visa  number default 0 );

procedure setFullCustomerAddress (
	p_rnk         	customer_address.rnk%type,
	p_typeId    	customer_address.type_id%type,
	p_country    	customer_address.country%type,
	p_zip         	customer_address.zip%type,
	p_domain     	customer_address.domain%type,
	p_region    	customer_address.region%type,
	p_locality   	customer_address.locality%type,
	p_address    	customer_address.address%type,
	p_territoryId 	customer_address.territory_id%type,
	p_locality_type customer_address.locality_type%type,
	p_street_type   customer_address.street_type%type,
	p_street       	customer_address.street%type,
	p_home_type    	customer_address.home_type%type,
	p_home         	customer_address.home%type,
	p_homepart_type	customer_address.homepart_type%type,
	p_homepart     	customer_address.homepart%type,
	p_room_type     customer_address.room_type%type,
	p_room         	customer_address.room%type,
	p_comment		customer_address.comm%type default null,
	p_flag_visa  number default 0 );

--***************************************************************************--
-- PROCEDURE  : setFullCustomerAddress
-- DESCRIPTION  : ????????? ?????????? ??????? ??????? ? ????? ??????????
-- ?????????? ? ?? ? ????????????, ??? ????? ??? ??? ???? ?? ????
--***************************************************************************--
procedure setFullCustomerAddress (
  p_rnk           customer_address.rnk%type,
  p_typeId      customer_address.type_id%type,
  p_country     customer_address.country%type,
  p_zip           customer_address.zip%type,
  p_domain      customer_address.domain%type,
  p_region      customer_address.region%type,
  p_locality    customer_address.locality%type,
  p_address     customer_address.address%type,
  p_territoryId   customer_address.territory_id%type,
  p_locality_type customer_address.locality_type%type,
  p_street_type   customer_address.street_type%type,
  p_street        customer_address.street%type,
  p_home_type     customer_address.home_type%type,
  p_home          customer_address.home%type,
  p_homepart_type customer_address.homepart_type%type,
  p_homepart      customer_address.homepart%type,
  p_room_type     customer_address.room_type%type,
  p_room          customer_address.room%type,
  p_comment       customer_address.comm%type default null,
  p_region_id     customer_address.region_id%type,
  p_area_id       customer_address.area_id%type,
  p_settlement_id customer_address.settlement_id%type,
  p_street_id     customer_address.street_id%type,
  p_house_id      customer_address.house_id%type,
  p_flag_visa     number default 0 );


$if KL_PARAMS.TREASURY $then
$else
--***************************************************************************--
-- procedure 	: setCorpAcc
-- description	: ��������� ���������� ���������� ������ ������� � ��. ������
--***************************************************************************--
procedure setCorpAcc (
  Rnk_    corps_acc.rnk%type,
  Id_     corps_acc.id%type,
  Mfo_    corps_acc.mfo%type,
  Nls_    corps_acc.nls%type,
  Kv_     corps_acc.kv%type,
  Comm_   corps_acc.comments%type );

--***************************************************************************--
-- procedure 	: setCorpAccEx
-- description	: ��������� ���������� ���������� ������ ������� � ��. ������
--***************************************************************************--
procedure setCorpAccEx (
  Rnk_    corps_acc.rnk%type,
  Id_     corps_acc.id%type,
  Mfo_    corps_acc.mfo%type,
  Nls_    corps_acc.nls%type,
  Kv_     corps_acc.kv%type,
  Comm_   corps_acc.comments%type,
  p_sw56_name  corps_acc.sw56_name%type,
  p_sw56_adr   corps_acc.sw56_adr%type,
  p_sw56_code  corps_acc.sw56_code%type,
  p_sw57_name  corps_acc.sw57_name%type,
  p_sw57_adr   corps_acc.sw57_adr%type,
  p_sw57_code  corps_acc.sw57_code%type,
  p_sw57_acc   corps_acc.sw57_acc%type,
  p_sw59_name  corps_acc.sw59_name%type,
  p_sw59_adr   corps_acc.sw59_adr%type,
  p_sw59_acc   corps_acc.sw59_acc%type,
  p_flag_visa  number default 0 );

--***************************************************************************--
-- procedure 	: delCorpAcc
-- description	: ��������� �������� ���������� ������ ������� � ��. ������
--***************************************************************************--
procedure delCorpAcc (
  Id_         corps_acc.id%type,
  p_flag_visa number default 0);
$end

$if KL_PARAMS.SIGN $then
--***************************************************************************--
-- procedure 	: setCustomerSeal
-- description	: ��������� ���������� �������/������
--***************************************************************************--
procedure setCustomerSeal (
  Id_   OUT customer_bin_data.id%type,
  Img_   IN customer_bin_data.bin_data%type );
$end

--***************************************************************************--
-- procedure 	: set_customer_risk
-- description	: ��������� ��������� ������ ��������
--***************************************************************************--
procedure set_customer_risk (
  p_rnk       number,
  p_riskid    number,
  p_riskvalue number,
  p_flag_visa number default 0 );

--***************************************************************************--
-- procedure 	: set_customer_rept
-- description	: ��������� ��������� ��������� �������
--***************************************************************************--
procedure set_customer_rept (
  p_rnk       number,
  p_reptid    number,
  p_reptvalue number );

--***************************************************************************--
-- procedure     : set_customer_category
-- description   : ��������� ��������� ��������� �������
--***************************************************************************--
procedure set_customer_category (
  p_rnk           number,
  p_categoryid    number,
  p_categoryvalue number );

--***************************************************************************--
-- procedure 	: approve_client_request
-- description	: ��������� ����������� ��������� ���������� �������
--***************************************************************************--
procedure approve_client_request (p_rnk number);

--***************************************************************************--
-- function 	: get_customerw
-- description	: ������� ��������� �������� ���.��������� �������
--***************************************************************************--
function get_customerw (
  p_rnk customerw.rnk%type,
  p_tag customerw.tag%type,
  p_isp customerw.isp%type default 0) return customerw.value%type;

--***************************************************************************--
function get_empty_attr_foropenacc (p_rnk number) return varchar2;

--***************************************************************************--
-- procedure 	: check_attr_foropenacc
-- description	: ��������� �������� ���������� ���������� ������ ��� �������� ������ 2 ��.
--***************************************************************************--
procedure check_attr_foropenacc (p_rnk in number, p_msg out varchar2);

  -----------------------------------------------------------
  -- ��������� ������������� ����� �������� � ���������� �������
  -- ����������, �� ����������� ����������
  --     @p_serial - ����� �������� �� ����
  --     @p_result - ����� �������� �� �����
  --     @p_errmsg - ����� ������ ��� ������ (SUCCESS, PASSPORT_SERIAL_NULL, PASSPORT_SERIAL_LENGTH, PASSPORT_SERIAL_ERROR)
  --
  procedure recode_passport_serial_silent
  ( p_serial     in  person.ser%type,
    p_result     out person.ser%type,
    p_errmsg     out varchar2
  );

  -----------------------------------------------------------
  -- ������� ������������� ����� �������� � ���������� �������
  --
  --     @p_serial - ����� ��������
  --
  function recode_passport_serial(p_serial in person.ser%type) return person.ser%type;

  -----------------------------------------------------------
  -- ������� ������������� ������ ��������
  --
  --     @p_number - ����� ��������
  --
  function recode_passport_number(p_number in person.numdoc%type) return person.numdoc%type;

  -----------------------------------------------------------
  -- �-��� ��������� ������ ����
  --
  -- @p_rnk - ��� �������
  --
  function generate_dkbo_number(p_rnk customer.rnk%type) return varchar2;



  -----------------------------------------------------------
  -- ��������� ���������(���������) ���� ������� � ���������� ���������� �� CardMake
  --
  --
  procedure set_cutomer_image(p_rnk number, p_imgage_type  varchar2, p_image blob);

  -----------------------------------------------------------
  -- ��������� ��������������� ��������� �����������
  --
  -- @p_rnk - ��� �������
  --  
  procedure resurrect_customer(p_rnk customer.rnk%type,
                               p_err_msg out varchar2);

END KL;
/
CREATE OR REPLACE PACKAGE BODY BARS.KL 
is

--***************************************************************************--
-- (C) BARS. Contragents
--***************************************************************************--

  G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 2.3  03/10/2018';
  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := ''
$if KL_PARAMS.TREASURY $then
  || 'KAZ   - ��� ������������ (��� ����.��������, ������ ��.��� � ��.������)' || chr(10)
$end
$if KL_PARAMS.NADRA $then
  || 'NADRA - ��� ����� �����' || chr(10)
$end
$if KL_PARAMS.SIGN $then
  || 'SIGN  - � �������� ���������� �������/������' || chr(10)
$end
$if KL_PARAMS.FINMON $then
  || 'FM    - � �������� �������� ������������ ������� �� �������������� � ������ �����������' || chr(10)
$end
$if KL_PARAMS.RI $then
  || 'RI    - � �������� ��������� �������� ������� ���������� (CUSTOMER_RI)' || chr(10)
$end
$if KL_PARAMS.SBER $then
  || 'SBER   - ��� ���������' || chr(10)
$end
$if KL_PARAMS.CLV $then
  || 'CLV   - � ������������ ����������' || chr(10)
$end
;

  -- ����
  type t_let_rec is record (
                          ukr_num  varchar2(2),
                          ukr_let  varchar2(1),
                          rus_let  varchar2(1),
                          eng_let  varchar2(1) );

  type t_let_table is table of t_let_rec index by pls_integer;


  -- ���������� ����������
  g_let_table       t_let_table;   /* ������� ������������ ���� */

  g_modcode constant varchar2(3) := 'CAC';

  --****** header_version - ���������� ������ ��������� ������ ****************--
  function header_version return varchar2
  is
  begin
    return 'Package header KL ' || G_HEADER_VERSION || '.' || chr(10)
        || 'AWK definition: ' || chr(10) || G_AWK_HEADER_DEFS;
  end header_version;

  --****** body_version - ���������� ������ ���� ������ ***********************--
  function body_version return varchar2
  is
  begin
    return 'Package body KL ' || G_BODY_VERSION || '.' || chr(10)
        || 'AWK definition: ' || chr(10) || G_AWK_BODY_DEFS;
  end body_version;

$if KL_PARAMS.SBER $then
  --
  -- GET_EBK_CUST_TP()
  --
  function GET_EBK_CUST_TP
  ( p_custtype      in     customer.custtype%type
  , p_sed           in     customer.sed%type
  ) return varchar2
  deterministic
  is
  begin

    bars_audit.trace( 'kl.get_ebk_cust_tp: custtype=%s, sed=%s.', g_modcode, to_char(p_custtype), p_sed );

    return case
             when ( p_custtype = 2 )
             then 'L'
             when ( p_custtype = 3 and p_sed = '91  ' )
             then 'P'
             when ( p_custtype = 3 and p_sed = '00  ' )
             then 'I'
             else null
           end;

  end GET_EBK_CUST_TP;

  --
  -- GET_CUST_TP()
  --
  function GET_CUST_TP
  ( p_rnk           in     customer.rnk%type
  ) return varchar2
  deterministic
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
    l_custtype             customer.custtype%type;
    l_sed                  customer.sed%type;
  begin

    begin
      select c.CUSTTYPE, c.SED
        into l_custtype, l_sed
        from CUSTOMER c
       where c.RNK = p_rnk
--       and date_off is null
      ;
    exception
      when NO_DATA_FOUND then
        -- ��������� ������ �볺���
        l_custtype := null;
    end;

    bars_audit.trace( 'kl.get_cust_tp: rnk=%s, custtype=%s, sed=%s.', g_modcode, to_char(p_rnk), to_char(l_custtype), l_sed );

    return GET_EBK_CUST_TP( l_custtype, l_sed );

  end GET_CUST_TP;

  --
  -- ADD_EBK_QUEUE()
  --
  procedure ADD_EBK_QUEUE
  ( p_rnk           in     customer.rnk%type
  , p_custw_tag     in     customerw.tag%type default null
  , p_cust_tp       in     varchar2           default null
  ) is
    l_cust_tp              varchar2(1);
  begin

    if ( p_cust_tp IS Null )
    then
      l_cust_tp := GET_CUST_TP( p_rnk );
    else
      l_cust_tp := p_cust_tp;
    end if;

    case
      when ( l_cust_tp = 'I' )
      then -- is_fiz_pers(p_rnk)
        if ( p_custw_tag is Null or
             p_custw_tag in ('SN_LN','SN_FN','SN_MN','SN_GC','K013 ','FGADR','FGDST','FGTWN'
                            ,'MPNO ','SAMZ ','VIP_K','WORK ','PUBLP','CIGPO','FGOBL','EMAIL'
                            ,'PC_Z2','PC_Z1','PC_Z5','PC_Z3','PC_Z4','CHORN','SPMRK','WORKB')
           )
        then
          begin
            execute immediate 'begin BARS.EBK_WFORMS_UTL.ADD_RNK_QUEUE( :p_rnk ); end;' using p_rnk;
          exception
            when OTHERS then
              bars_audit.error('kl.add_ebk_queue: '||sqlerrm);
          end;
        end if;
      when ( l_cust_tp = 'P' )
      then -- is_private_ent(p_rnk)
        if ( p_custw_tag is Null or
             p_custw_tag in ('MS_GR','EMAIL','CIGPO','SAMZ ','K013')
           )
        then
          begin
            execute immediate 'begin BARS.EBKC_WFORMS_UTL.ADD_RNK_QUEUE( :p_rnk ); end;' using p_rnk;
          exception
            when OTHERS then
              bars_audit.error('kl.add_ebk_queue: '||sqlerrm);
          end;
        end if;
      when ( l_cust_tp = 'L' )
      then -- is_legal_pers(p_rnk)
        if ( p_custw_tag is Null or
             p_custw_tag in ('FSKPR','IDPIB','UUDV ','KVPKK','AINAB','FSVED','FIRMA','O_REP'
                            ,'FSRSK','RIZIK','K013 ','MS_GR','VIP_K','NOTAX','N_RPD','CCVED'
                            ,'DATVR','DATZ ','DJER ','SUTD ')
           )
        then
          begin
            execute immediate 'begin BARS.EBKC_WFORMS_UTL.ADD_RNK_QUEUE( :p_rnk ); end;' using p_rnk;
          exception
            when OTHERS then
              bars_audit.error('kl.add_ebk_queue: '||sqlerrm);
          end;
        end if;
      else
        null;
    end case;

  end add_ebk_queue;

$end

--***************************************************************************--
-- PROCEDURE 	: isCustomerTr
-- DESCRIPTION	: ������� �������� ������������ ������� �� �������������� � ������ �����������
--***************************************************************************--
function isCustomerTr (
  pNmk    customer.nmk%type,
  pNmkk   customer.nmkk%type,
  pNmkv   customer.nmkv%type
) return number is
  lRet number := 0;
  l_title varchar2(20) := 'kl.isCustomerTr: ';
begin

$if KL_PARAMS.FINMON $then
  bars_audit.trace('%s params: pNmk=>%s, pNmkk=>%s, pNmkv=>%s',
       l_title, pNmk, pNmkk, pNmkv);

  if pNmk is not null then
     lRet := f_isTr(pNmk);
     bars_audit.trace('%s check Nmk: lRet=%s', l_title, to_char(lRet));
  end if;

  if pNmkk is not null and lRet = 0 then
     lRet := f_isTr(pNmkk);
     bars_audit.trace('%s check Nmkk: lRet=%s', l_title, to_char(lRet));
  end if;

  if pNmkv is not null and lRet = 0 then
     lRet := f_isTr(pNmkv);
     bars_audit.trace('%s check Nmkv: lRet=%s', l_title, to_char(lRet));
  end if;

$end
  return lRet;
end isCustomerTr;

--***************************************************************************--
-- PROCEDURE 	: checkFM
-- DESCRIPTION	: ��������� �������� ������������ ������� �� �������������� � ������ �����������
--***************************************************************************--
procedure checkFM (
  pNmk   in customer.nmk%type,
  pNmkk  in customer.nmkk%type,
  pNmkv  in customer.nmkv%type,
  pIdTr out number )
is
  l_title varchar2(20) := 'kl.checkFM: ';
begin
  pIdTr := 0;
$if KL_PARAMS.FINMON $then
  bars_audit.trace('%s params: pNmk=>%s, pNmkk=>%s, pNmkv=>%s',
       l_title, pNmk, pNmkk, pNmkv);

  if pNmk is not null then
     pIdTr := f_isTr(pNmk);
     bars_audit.trace('%s check Nmk: IdTr=%s', l_title, to_char(pIdTr));
  end if;

  if pNmkk is not null and pIdTr = 0 then
     pIdTr := f_isTr(pNmkk);
     bars_audit.trace('%s check Nmkk: IdTr=%s', l_title, to_char(pIdTr));
  end if;

  if pNmkv is not null and pIdTr = 0 then
     pIdTr := f_isTr(pNmkv);
     bars_audit.trace('%s check Nmkv: IdTr=%s', l_title, to_char(pIdTr));
  end if;

$end
end checkFM;

--***************************************************************************--
function is_customer_visa (p_custtype number, p_sed varchar2) return boolean
is
  l_ret boolean := false;
begin
$if KL_PARAMS.CLV $then
  if p_custtype = 2
  or p_custtype = 3 and nvl(trim(p_sed),'00') = '91' then
     l_ret := true;
  end if;
$end
  return l_ret;
end is_customer_visa;

--***************************************************************************--
function is_customer_visa (p_rnk number) return boolean
is
  l_custtype customer.custtype%type;
  l_sed      customer.sed%type;
begin
$if KL_PARAMS.CLV $then
  begin
     select custtype, sed into l_custtype, l_sed from customer where rnk = p_rnk;
  exception when no_data_found then
     begin
        select custtype, sed into l_custtype, l_sed from clv_customer where rnk = p_rnk;
     exception when no_data_found then
        return false;
     end;
  end;
$end
  return is_customer_visa(l_custtype, l_sed);
end is_customer_visa;

--***************************************************************************--
procedure set_corp_nmk (
  p_rnk corps.rnk%type,
  p_nmk corps.nmk%type )
is
begin
   update corps set nmk = p_nmk where rnk = p_rnk;
   if sql%rowcount = 0 then
      insert into corps (rnk, nmk)
      values (p_rnk, p_nmk);
   end if;
end set_corp_nmk;

--***************************************************************************--
procedure iopen_client (
  p_rnk        in customer.rnk%type,         -- Customer number
  -- �������� ���������
  p_custtype      customer.custtype%type,    -- ��� �������: 1-����, 2-��.����, 3-���.����
  p_nd            customer.nd%type,          -- � ��������
  p_nmk           varchar2,                  -- ������������ �������
  p_nmkv          customer.nmkv%type,        -- ������������ ������� �������������
  p_nmkk          customer.nmkk%type,        -- ������������ ������� �������
  p_adr           customer.adr%type,         -- ����� �������
  p_codcagent     customer.codcagent%type,   -- ��������������
  p_country       customer.country%type,     -- ������
  p_prinsider     customer.prinsider%type,   -- ������� ���������
  p_tgr           customer.tgr%type,         -- ��� ���.�������
  p_okpo          customer.okpo%type,        -- ����
  p_tobo          customer.tobo%type,        -- ��� �������������� ���������
  p_isp           customer.isp%type,         -- �������� ������� (�����. �����������)
  p_dateon        customer.date_on%type,     -- ���� �����������
  -- ��������� ��� ���������
  p_creg          customer.c_reg%type,       -- ��� ���.��
  p_cdst          customer.c_dst%type,       -- ��� �����.��
  p_adm           customer.adm%type,         -- �����.�����
  p_rgadm         customer.rgadm%type,       -- ��� ����� � ���.
  p_datea         customer.datea%type,       -- ���� ���. � �������������
  p_rgtax         customer.rgtax%type,       -- ��� ����� � ��
  p_datet         customer.datet%type,       -- ���� ��� � ��
  p_nompdv        customer.nompdv%type,      -- � ������������� ����������� ��� (9 ����)
  p_taxf          customer.taxf%type,        -- ���. ��������� ����� (12 ����.)
  -- ������������� ���������
  p_ise           customer.ise%type,         -- ����. ���. ���������
  p_fs            customer.fs%type,          -- ����� �������������
  p_oe            customer.oe%type,          -- ������� ���������
  p_ved           customer.ved%type,         -- ��� ��. ������������
  p_sed           customer.sed%type,         -- ����� ��������������
  p_k050          customer.k050%type,        -- ���������� k050
  -- ������
  p_sab           customer.sab%type,         -- ��.���
  p_stmt          customer.stmt%type,        -- ������ �������
  p_crisk         customer.crisk%type,       -- ��������� �����
  p_rnkp          customer.rnkp%type,        -- ���. ����� ��������
  p_notes         customer.notes%type,       -- ����������
  p_notesec       customer.notesec%type,     -- ���������� ��� ������ ������������
  p_lim           customer.lim%type,         -- ����� �����
  p_pincode       customer.pincode%type,     --
  p_mb            customer.mb%type,          -- �������. ������ �������
  p_bc            customer.bc%type,           -- ������� ��������� �����
  p_nrezid_code   customer.nrezid_code%type
) is
begin

  if ( p_custtype < 1 or p_custtype > 3 ) then
     -- �����. ��� �����������
     bars_error.raise_nerror(g_modcode, 'INCORRECT_CUSTTYPE', to_char(p_custtype));
  end if;
  
  --2018.09.25 ��� ���������� ����, ���� ���� ��������� ������� �������� ��� ��� �볺��(���) ������ �� ����������
  if p_custtype = 3 and p_sed = 91 then
    if p_ise not in ('14200', '14100', '14201', '14101') then
      bars_error.raise_nerror(g_modcode, 'INCORRECT_ISE', to_char(p_ise));
    elsif coalesce(p_ved, '00000') = '00000' then
      bars_error.raise_nerror(g_modcode, 'INCORRECT_VED', to_char(p_ved));
    end if;
  end if;
  ----

  begin
    insert
      into customer (rnk, nd, custtype, nmk, nmkv, nmkk,
        country, codcagent, prinsider, okpo, adr, sab, stmt, tgr,
        taxf, c_reg, c_dst, adm, rgtax, rgadm, datet, datea, date_on,
        ise, fs, oe, ved, sed, k050,
        rnkp, notes, notesec, crisk, lim, nompdv, mb, bc, tobo, isp, nrezid_code )
    values (p_rnk, p_nd, p_custtype, substr(p_nmk,1,70), p_nmkv, p_nmkk,
        p_country, p_codcagent, p_prinsider, p_okpo, p_adr, p_sab, p_stmt, p_tgr,
        p_taxf, p_creg, p_cdst, p_adm, p_rgtax, p_rgadm, p_datet, p_datea, p_dateon,
        p_ise, p_fs, p_oe, p_ved, p_sed, p_k050,
        p_rnkp, p_notes, p_notesec, p_crisk, p_lim, p_nompdv, p_mb, p_bc, p_tobo, p_isp, p_nrezid_code );
$if KL_PARAMS.SBER $then
    ADD_EBK_QUEUE( p_rnk, null, GET_EBK_CUST_TP( p_custtype, p_sed ) );
$end
  exception
    when dup_val_on_index then
      -- ������ � ��� p_rnk ��� ����������
      bars_error.raise_nerror(g_modcode, 'RNK_ALREADY_EXISTS', to_char(p_custtype));
  end;

  if p_custtype = 2
  then
    set_corp_nmk(p_rnk, p_nmk);
  end if;

  cust_insider(p_rnk);

end iopen_client;

--***************************************************************************--
-- PROCEDURE 	: open_client
-- DESCRIPTION	: ��������� ����������� ������� � ��������� ���
--***************************************************************************--
PROCEDURE open_client (
  Rnk_        IN customer.rnk%type,         -- Customer number
  Custtype_      customer.custtype%type,    -- ��� �������: 1-����, 2-��.����, 3-���.����
  Nd_            customer.nd%type,          -- � ��������
  Nmk_           varchar2,                  -- ������������ �������
  Nmkv_          customer.nmkv%type,        -- ������������ ������� �������������
  Nmkk_          customer.nmkk%type,        -- ������������ ������� �������
  Adr_           customer.adr%type,         -- ����� �������
  Codcagent_     customer.codcagent%type,   -- ��������������
  Country_       customer.country%type,     -- ������
  Prinsider_     customer.prinsider%type,   -- ������� ���������
  Tgr_           customer.tgr%type,         -- ��� ���.�������
  Okpo_          customer.okpo%type,        -- ����
  Stmt_          customer.stmt%type,        -- ������ �������
  Sab_           customer.sab%type,         -- ��.���
  DateOn_        customer.date_on%type,     -- ���� �����������
  Taxf_          customer.taxf%type,        -- ��������� ���
  CReg_          customer.c_reg%type,       -- ��� ���.��
  CDst_          customer.c_dst%type,       -- ��� �����.��
  Adm_           customer.adm%type,         -- �����.�����
  RgTax_         customer.rgtax%type,       -- ��� ����� � ��
  RgAdm_         customer.rgadm%type,       -- ��� ����� � ���.
  DateT_         customer.datet%type,       -- ���� ��� � ��
  DateA_         customer.datea%type,       -- ���� ���. � �������������
  Ise_           customer.ise%type,         -- ����. ���. ���������
  Fs_            customer.fs%type,          -- ����� �������������
  Oe_            customer.oe%type,          -- ������� ���������
  Ved_           customer.ved%type,         -- ��� ��. ������������
  Sed_           customer.sed%type,         -- ����� ��������������
  K050_          customer.k050%type,        -- ���������� k050
  Notes_         customer.notes%type,       -- ����������
  Notesec_       customer.notesec%type,     -- ���������� ��� ������ ������������
  CRisk_         customer.crisk%type,       -- ��������� �����
  Pincode_       customer.pincode%type,     --
  RnkP_          customer.rnkp%type,        -- ���. ����� ��������
  Lim_           customer.lim%type,         -- ����� �����
  NomPDV_        customer.nompdv%type,      -- � � ������� ����. ���
  MB_            customer.mb%type,          -- �������. ������ �������
  BC_            customer.bc%type,          -- ������� ��������� �����
  Tobo_          customer.tobo%type,        -- ��� �������������� ���������
  Isp_           customer.isp%type          -- �������� ������� (�����. �����������)
) is
begin

  iopen_client (
     p_rnk       => Rnk_,
     -- �������� ���������
     p_custtype  => Custtype_,
     p_nd        => Nd_,
     p_nmk       => Nmk_,
     p_nmkv      => Nmkv_,
     p_nmkk      => Nmkk_,
     p_adr       => Adr_,
     p_codcagent => Codcagent_,
     p_country   => Country_,
     p_prinsider => Prinsider_,
     p_tgr       => Tgr_,
     p_okpo      => Okpo_,
     p_tobo      => Tobo_,
     p_isp       => Isp_,
     p_dateon    => DateOn_,
     -- ��������� ��� ���������
     p_creg      => CReg_,
     p_cdst      => CDst_,
     p_adm       => Adm_,
     p_rgadm     => RgAdm_,
     p_datea     => DateA_,
     p_rgtax     => RgTax_,
     p_datet     => DateT_,
     p_nompdv    => NomPDV_,
     p_taxf      => Taxf_,
     -- ������������� ���������
     p_ise       => Ise_,
     p_fs        => Fs_,
     p_oe        => Oe_,
     p_ved       => Ved_,
     p_sed       => Sed_,
     p_k050      => K050_,
     -- ������
     p_sab       => Sab_,
     p_stmt      => Stmt_,
     p_crisk     => CRisk_,
     p_rnkp      => RnkP_,
     p_notes     => Notes_,
     p_notesec   => Notesec_,
     p_lim       => Lim_,
     p_pincode   => Pincode_,
     p_mb        => MB_,
     p_bc        => BC_,
     p_nrezid_code => null );
end open_client;

--***************************************************************************--
-- PROCEDURE 	: setCustomerAttr
-- DESCRIPTION	: ��������� ����������� �������/���������� ���������� �������
--***************************************************************************--
PROCEDURE setCustomerAttr (
  Rnk_    IN OUT customer.rnk%type,         -- Customer number
  Custtype_      customer.custtype%type,    -- ��� �������: 1-����, 2-��.����, 3-���.����
  Nd_            customer.nd%type,          -- � ��������
  Nmk_           varchar2,                  -- ������������ �������
  Nmkv_          customer.nmkv%type,        -- ������������ ������� �������������
  Nmkk_          customer.nmkk%type,        -- ������������ ������� �������
  Adr_           customer.adr%type,         -- ����� �������
  Codcagent_     customer.codcagent%type,   -- ��������������
  Country_       customer.country%type,     -- ������
  Prinsider_     customer.prinsider%type,   -- ������� ���������
  Tgr_           customer.tgr%type,         -- ��� ���.�������
  Okpo_          customer.okpo%type,        -- ����
  Stmt_          customer.stmt%type,        -- ������ �������
  Sab_           customer.sab%type,         -- ��.���
  DateOn_        customer.date_on%type,     -- ���� �����������
  Taxf_          customer.taxf%type,        -- ��������� ���
  CReg_          customer.c_reg%type,       -- ��� ���.��
  CDst_          customer.c_dst%type,       -- ��� �����.��
  Adm_           customer.adm%type,         -- �����.�����
  RgTax_         customer.rgtax%type,       -- ��� ����� � ��
  RgAdm_         customer.rgadm%type,       -- ��� ����� � ���.
  DateT_         customer.datet%type,       -- ���� ��� � ��
  DateA_         customer.datea%type,       -- ���� ���. � �������������
  Ise_           customer.ise%type,         -- ����. ���. ���������
  Fs_            customer.fs%type,          -- ����� �������������
  Oe_            customer.oe%type,          -- ������� ���������
  Ved_           customer.ved%type,         -- ��� ��. ������������
  Sed_           customer.sed%type,         -- ����� ��������������
  Notes_         customer.notes%type,       -- ����������
  Notesec_       customer.notesec%type,     -- ���������� ��� ������ ������������
  CRisk_         customer.crisk%type,       -- ��������� �����
  Pincode_       customer.pincode%type,     --
  RnkP_          customer.rnkp%type,        -- ���. ����� ��������
  Lim_           customer.lim%type,         -- ����� �����
  NomPDV_        customer.nompdv%type,      -- � � ������� ����. ���
  MB_            customer.mb%type,          -- �������. ������ �������
  BC_            customer.bc%type,          -- ������� ��������� �����
  Tobo_          customer.tobo%type,        -- ��� �������������� ���������
  Isp_           customer.isp%type,         -- �������� ������� (�����. �����������)
  p_nrezid_code  customer.nrezid_code%type default null,
  p_flag_visa    number default 0
) IS
  RnkNew_ NUMBER;
  l_title varchar2(20) := 'kl.setCustomerAttr: ';
$if KL_PARAMS.NADRA $then

  function igetrnk (p_seq number) return number
  is
  begin
     execute immediate 'drop sequence s_customer';
     execute immediate 'create sequence s_customer start with ' || to_char(p_seq);
     return p_seq;
  end;

$end
BEGIN
  --2018.09.25 ��� ���������� ����, ���� ���� ��������� ������� �������� ��� ��� �볺��(���) ������ �� ����������
  if Custtype_ = 3 and Sed_ = 91 then
    if Ise_ not in ('14200', '14100', '14201', '14101') then
      bars_error.raise_nerror(g_modcode, 'INCORRECT_ISE', to_char(Ise_));
    elsif coalesce(Ved_, '00000') = '00000' then
      bars_error.raise_nerror(g_modcode, 'INCORRECT_VED', to_char(Ved_));
    end if;
  end if;
  ----

  bars_audit.trace('%s 1.params:'
       || ' Rnk_=>%s,'
       || ' Custtype_=>%s,'
       || ' Nd_=>%s,'
       || ' Nmk_=>%s,'
       || ' Nmkv_=>%s,'
       || ' Nmkk_=>%s,'
       || ' Adr_=>%s,'
       || ' Codcagent_=>%s',
       l_title, to_char(Rnk_), to_char(Custtype_), Nd_, Nmk_, Nmkv_, Nmkk_, Adr_, to_char(Codcagent_));
  bars_audit.trace('%s 2.params:'
       || ' Country_=>%s,'
       || ' Prinsider_=>%s,'
       || ' Tgr_=>%s,'
       || ' Okpo_=>%s,'
       || ' Stmt_=>%s,'
       || ' Sab_=>%s,'
       || ' DateOn_=>%s,'
       || ' Taxf_=>%s',
       l_title, to_char(Country_), to_char(Prinsider_), to_char(Tgr_),
       Okpo_, to_char(Stmt_), Sab_, to_char(DateOn_,'dd/MM/yyyy'), Taxf_);
  bars_audit.trace('%s 3.params:'
       || ' CReg_=>%s,'
       || ' CDst_=>%s,'
       || ' Adm_=>%s,'
       || ' RgTax_=>%s,'
       || ' RgAdm_=>%s,'
       || ' DateT_=>%s,'
       || ' DateA_=>%s,'
       || ' Ise_=>%s',
       l_title, to_char(CReg_), to_char(CDst_), Adm_, to_char(RgTax_), RgAdm_,
       to_char(DateT_,'dd/MM/yyyy'), to_char(DateA_,'dd/MM/yyyy'), Ise_);
  bars_audit.trace('%s 4.params:'
       || ' Fs_=>%s,'
       || ' Oe_=>%s,'
       || ' Ved_=>%s,'
       || ' Sed_=>%s,'
       || ' Notes_=>%s,'
       || ' Notesec_=>%s,'
       || ' CRisk_=>%s,'
       || ' Pincode_=>%s',
       l_title, Fs_, Oe_, Ved_, Sed_, Notes_, Notesec_, to_char(CRisk_), Pincode_);
  bars_audit.trace('%s 5.params:'
       || ' RnkP_=>%s,'
       || ' Lim_=>%s,'
       || ' NomPDV_=>%s,'
       || ' MB_=>%s,'
       || ' BC_=>%s,'
       || ' Tobo_=>%s,'
       || ' Isp_=>%s',
       l_title, to_char(RnkP_), to_char(Lim_), NomPDV_, MB_, to_char(BC_), Tobo_, to_char(Isp_));

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(Custtype_, Sed_) then

     IF ( Rnk_ IS NOT NULL ) THEN

        bars_audit.trace('%s 6. ���������� ���������� ������� rnk=%s', l_title, Rnk_);

        -- ����������
        UPDATE customer
           SET nd        = Nd_,
               nmk       = substr(Nmk_,1,70),
               nmkv      = Nmkv_,
               nmkk      = Nmkk_,
               adr       = Adr_,
               codcagent = Codcagent_,
               country   = Country_,
               prinsider = Prinsider_,
               tgr       = Tgr_,
               okpo      = Okpo_,
               stmt      = Stmt_,
               sab       = Sab_,
               taxf      = Taxf_,
               c_reg     = CReg_,
               c_dst     = CDst_,
               adm       = Adm_,
               rgtax     = RgTax_,
               rgadm     = RgAdm_,
               datet     = DateT_,
               datea     = DateA_,
               ise       = Ise_,
               fs        = Fs_,
               oe        = Oe_,
               ved       = Ved_,
               sed       = Sed_,
               rnkp      = RnkP_,
               notes     = Notes_,
               notesec   = Notesec_,
               crisk     = CRisk_,
               lim       = Lim_,
               nompdv    = NomPDV_,
               mb        = MB_,
               bc        = BC_,
               tobo      = Tobo_,
               isp       = Isp_,
               nrezid_code = p_nrezid_code
         WHERE rnk = Rnk_;

$if KL_PARAMS.SBER $then
        ADD_EBK_QUEUE( Rnk_ );

$end
        bars_audit.trace('%s 7. ��������� ���������� ���������� ������� rnk=%s', l_title, Rnk_);

     ELSE

        bars_audit.trace('%s 8. ����������� �������', l_title);

        -- �����������
        RnkNew_ := bars_sqnc.get_nextval('s_customer');
        --
$if KL_PARAMS.NADRA $then
        -- ��� ����������� ��������:
        --   3 712 - 100 000
        -- 100 390 - 399 999
        -- 413 508 - 500 000
        -- 500 044 - 799 999
        -- 900 000 - 999 999
        -- ��� �����������:
        -- 800 000 - 899 999
        if    RnkNew_ > 500000 and RnkNew_ < 500044 then
           RnkNew_ := igetrnk(500044);
        elsif RnkNew_ > 399999 and RnkNew_ < 413508 then
           RnkNew_ := igetrnk(413508);
        elsif RnkNew_ > 100000 and RnkNew_ < 100390 then
           RnkNew_ := igetrnk(100390);
        elsif RnkNew_ < 3712 then
           RnkNew_ := igetrnk(3712);
        end if;
$end

        iopen_client (
           p_rnk       => RnkNew_,
           -- �������� ���������
           p_custtype  => Custtype_,
           p_nd        => Nd_,
           p_nmk       => Nmk_,
           p_nmkv      => Nmkv_,
           p_nmkk      => Nmkk_,
           p_adr       => Adr_,
           p_codcagent => Codcagent_,
           p_country   => Country_,
           p_prinsider => Prinsider_,
           p_tgr       => Tgr_,
           p_okpo      => Okpo_,
           p_tobo      => Tobo_,
           p_isp       => Isp_,
           p_dateon    => DateOn_,
           -- ��������� ��� ���������
           p_creg      => CReg_,
           p_cdst      => CDst_,
           p_adm       => Adm_,
           p_rgadm     => RgAdm_,
           p_datea     => DateA_,
           p_rgtax     => RgTax_,
           p_datet     => DateT_,
           p_nompdv    => NomPDV_,
           p_taxf      => Taxf_,
           -- ������������� ���������
           p_ise       => Ise_,
           p_fs        => Fs_,
           p_oe        => Oe_,
           p_ved       => Ved_,
           p_sed       => Sed_,
           p_k050      => null,
           -- ������
           p_sab       => Sab_,
           p_stmt      => Stmt_,
           p_crisk     => CRisk_,
           p_rnkp      => RnkP_,
           p_notes     => Notes_,
           p_notesec   => Notesec_,
           p_lim       => Lim_,
           p_pincode   => Pincode_,
           p_mb        => MB_,
           p_bc        => BC_,
           p_nrezid_code => p_nrezid_code );

        Rnk_ := RnkNew_ ;

     END IF;

$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customer%rowtype;
     begin
        l_clv.date_on   := case when Rnk_ is null then null else DateOn_ end;
        l_clv.custtype  := Custtype_;
        l_clv.codcagent := Codcagent_;
        l_clv.country   := Country_;
        l_clv.tgr       := Tgr_;
        l_clv.nmk       := Nmk_;
        l_clv.nmkv      := Nmkv_;
        l_clv.nmkk      := Nmkk_;
        l_clv.okpo      := Okpo_;
        l_clv.adr       := Adr_;
        l_clv.prinsider := Prinsider_;
        l_clv.sab       := Sab_;
        l_clv.c_reg     := CReg_;
        l_clv.c_dst     := CDst_;
        l_clv.adm       := Adm_;
        l_clv.rgadm     := RgAdm_;
        l_clv.datea     := DateA_;
        l_clv.rgtax     := RgTax_;
        l_clv.datet     := DateT_;
        l_clv.stmt      := Stmt_;
        l_clv.notes     := Notes_;
        l_clv.notesec   := Notesec_;
        l_clv.crisk     := CRisk_;
        l_clv.nd        := Nd_;
        l_clv.rnkp      := RnkP_;
        l_clv.ise       := Ise_;
        l_clv.fs        := Fs_;
        l_clv.oe        := Oe_;
        l_clv.ved       := Ved_;
        l_clv.sed       := Sed_;
        l_clv.k050      := null;
        l_clv.branch    := Tobo_;
        l_clv.isp       := Isp_;
        l_clv.taxf      := Taxf_;
        l_clv.nompdv    := NomPDV_;
        l_clv.nrezid_code := p_nrezid_code;
        -- ��� ������ ������� ����� ����������� ���
        bars_clv.new_request(Rnk_);
        l_clv.rnk       := Rnk_;
        bars_clv.set_req_customer(l_clv);
     end;
$end
  end if;

  bars_audit.trace('%s 9. ��������� ����������� �������, ����� ���=%s', l_title, Rnk_);

END setCustomerAttr;

--***************************************************************************--
-- PROCEDURE 	: setCustomerEN
-- DESCRIPTION	: ��������� ��������� ������������� ����������� �������
--***************************************************************************--
procedure setCustomerEN (
  p_rnk   customer.rnk%type,
  p_k070  customer.ise%type,
  p_k080  customer.fs%type,
  p_k110  customer.ved%type,
  p_k090  customer.oe%type,
  p_k050  customer.k050%type,
  p_k051  customer.sed%type,
  p_flag_visa number default 0 )
is
begin
$if KL_PARAMS.SBER $then
  IF (p_k110 = 'N9420' and p_k050 not in ('830','835','180','440'))
  THEN
    bars_error.raise_nerror(g_modcode, 'K110_N9420_CORRESPONDS_K050');
  end if;
$end
  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(p_rnk) then
     update customer
        set ise  = p_k070,
            fs   = p_k080,
            ved  = p_k110,
            oe   = p_k090,
            k050 = p_k050,
            sed  = p_k051
      where rnk = p_rnk;
$if KL_PARAMS.SBER $then

    ADD_EBK_QUEUE( p_rnk );

$end
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customer%rowtype;
     begin
        l_clv.rnk  := p_rnk;
        l_clv.ise  := p_k070;
        l_clv.fs   := p_k080;
        l_clv.ved  := p_k110;
        l_clv.oe   := p_k090;
        l_clv.k050 := p_k050;
        l_clv.sed  := p_k051;
        bars_clv.set_req_customeren(l_clv);
     end;
$end
  end if;
end setCustomerEN;

--***************************************************************************--
-- PROCEDURE 	: setBankAttr
-- DESCRIPTION	: ��������� ����������� �������-�����/���������� ����������
--***************************************************************************--
PROCEDURE setBankAttr (
  Rnk_      custbank.rnk%type,
  Mfo_      custbank.mfo%type,
  Bic_      custbank.bic%type,
  BicAlt_   custbank.alt_bic%type,
  Rating_   custbank.rating%type,
  Kod_b_    custbank.kod_b%type,
  Ruk_      custbank.ruk%type,
  Telr_     custbank.telr%type,
  Buh_      custbank.buh%type,
  Telb_     custbank.telb%type,
  k190_     custbank.k190%type
) IS
  l_title varchar2(20) := 'kl.setBankAttr: ';
BEGIN
  bars_audit.trace('%s 1.params:'
       || ' Rnk_=>%s,'
       || ' Mfo_=>%s,'
       || ' Bic_=>%s,'
       || ' BicAlt_=>%s,'
       || ' Rating_=>%s,'
       || ' Kod_b_=>%s,'
       || ' Ruk_=>%s,'
       || ' Telr_=>%s',
       l_title, to_char(Rnk_), Mfo_, Bic_, BicAlt_, Rating_, to_char(Kod_b_), Ruk_, Telr_);
  bars_audit.trace('%s 2.params:'
       || ' Buh_=>%s,'
       || ' Telb_=>%s',
       l_title, Buh_, Telb_);

  UPDATE Custbank
     SET mfo     = Mfo_,
         bic     = Bic_,
         alt_bic = BicAlt_,
         rating  = Rating_,
         kod_b   = Kod_b_,
         ruk     = Ruk_,
         telr    = TelR_,
         buh     = Buh_,
         telb    = TelB_,
         k190    = k190_
     WHERE rnk = Rnk_;
  IF SQL%rowcount = 0 THEN
     bars_audit.trace('%s 3. ����������� ���������� ����� ���=%s', l_title, Rnk_);
     INSERT INTO Custbank(rnk, mfo, bic, alt_bic, rating, kod_b, ruk, telr, buh, telb, K190)
     VALUES (Rnk_, Mfo_, Bic_, BicAlt_, Rating_, Kod_b_, Ruk_, TelR_, Buh_, TelB_, k190_ );
     bars_audit.trace('%s 4. ��������� ����������� ���������� ����� ���=%s', l_title, Rnk_);
  ELSE
     bars_audit.trace('%s 5. ��������� ���������� ���������� ����� ���=%s', l_title, Rnk_);
  END IF;

END setBankAttr;

--***************************************************************************--
-- PROCEDURE 	: setCorpAttr
-- DESCRIPTION	: ��������� ����������� �������-��.����/���������� ����������
--***************************************************************************--
PROCEDURE setCorpAttr (
  Rnk_      corps.rnk%type,
  Nmku_     corps.nmku%type,
  Ruk_      corps.ruk%type,
  Telr_     corps.telr%type,
  Buh_      corps.buh%type,
  Telb_     corps.telb%type,
  TelFax_   corps.tel_fax%type,
  EMail_    corps.e_mail%type,
  SealId_   corps.seal_id%type,
  p_flag_visa number default 0 )
IS
  l_title   varchar2(20) := 'kl.setCorpAttr: ';
$if KL_PARAMS.RI $then
  okpo_     customer.okpo%type;
  insfo_    number(1);
  k060_     number;
$end
BEGIN
  bars_audit.trace('%s 1.params:'
       || ' Rnk_=>%s,'
       || ' Nmku_=>%s,'
       || ' Ruk_=>%s,'
       || ' Telr_=>%s,'
       || ' Buh_=>%s,'
       || ' Telb_=>%s,'
       || ' TelFax_=>%s,'
       || ' EMail_=>%s,'
       || ' SealId_=>'|| SealId_,
       l_title, to_char(Rnk_), Nmku_, Ruk_, Telr_, Buh_, Telb_, TelFax_, EMail_);

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(Rnk_) then
     UPDATE Corps
        SET nmku    = Nmku_,
            ruk     = Ruk_,
            telr    = TelR_,
            buh     = Buh_,
            telb    = TelB_,
            tel_fax = TelFax_,
            e_mail  = EMail_,
            seal_id = SealId_
      WHERE rnk = Rnk_;
     IF SQL%rowcount = 0 THEN
        bars_audit.trace('%s 2. ����������� ���������� ��.���� ���=%s', l_title, Rnk_);
        INSERT INTO Corps(rnk, nmku, ruk, telr, buh, telb, tel_fax, e_mail, seal_id)
        VALUES (Rnk_, Nmku_, Ruk_, TelR_, Buh_, TelB_, TelFax_, EMail_, SealId_ );
        bars_audit.trace('%s 3. ��������� ����������� ���������� ��.���� ���=%s', l_title, Rnk_);
     ELSE
        bars_audit.trace('%s 4. ��������� ���������� ���������� ��.���� ���=%s', l_title, Rnk_);
     END IF;
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_corps%rowtype;
     begin
        l_clv.rnk  := Rnk_;
        l_clv.nmku := Nmku_;
        l_clv.ruk  := Ruk_;
        l_clv.telr := Telr_;
        l_clv.buh  := Buh_;
        l_clv.telb := Telb_;
        l_clv.tel_fax := TelFax_;
        l_clv.e_mail  := EMail_;
        l_clv.seal_id := SealId_;
        bars_clv.set_req_customercorp(l_clv);
     end;
$end
  end if;

$if KL_PARAMS.RI $then
  begin
    select okpo
    into   okpo_
    from   customer
    where  rnk=Rnk_;
  exception when no_data_found then
    okpo_ := null;
  end;
  if okpo_ is not null then
    begin
      select insform,
             k060
      into   insfo_,
             k060_
      from   customer_ri
      where  idcode=okpo_ and
             rownum<2;
      setCustomerElement(Rnk_,'INSFO',to_char(insfo_),0);
    exception when no_data_found then
      k060_ := null;
    end;
    if k060_ is not null
    then

      update customer
         set prinsider=k060_
       where rnk = Rnk_;

$if KL_PARAMS.SBER $then
      add_ebk_queue(Rnk_);

$end

    end if;
  end if;
$end

END setCorpAttr;

--***************************************************************************--
-- PROCEDURE 	: setPersonAttr
-- DESCRIPTION	: ��������� ����������� �������-���.����/���������� ����������
--***************************************************************************--
PROCEDURE setPersonAttr
( Rnk_          person.rnk%type,
  Sex_          person.sex%type,
  Passp_        person.passp%type,
  Ser_          person.ser%type,
  Numdoc_       person.numdoc%type,
  Pdate_        person.pdate%type,
  Organ_        person.organ%type,
  Bday_         person.bday%type,
  Bplace_       person.bplace%type,
  Teld_         person.teld%type,
  Telw_         person.telw%type,
  Telm_         person.cellphone%type default null,
  actual_date_  person.actual_date%type default null,
  eddr_id_      person.eddr_id%type default null,
  p_flag_visa   number default 0,
  Fdate_        person.date_photo%type default null
) IS
  l_fdate   date;
BEGIN

  If (Passp_ = 1) 
  Then

    l_fdate := Fdate_;
	
	if ( ( l_fdate is Null ) and (Bday_ is Not Null) And (Pdate_ is Not Null) ) 
    then -- ����� ��� ���� ���� ���������� ���� = ��� ������ ��������
      
	  If (add_months(Bday_,300) < trunc(sysdate))
	  then -- �볺���� ����� 25 ����
        l_fdate := Pdate_;
      
      ElsIf ((add_months(Bday_,540) < trunc(sysdate)) And (Pdate_ > add_months(Bday_,300)))
		then -- �볺���� ����� 45 ���� � ���� ������ ����� �� ���� ���� 25 ����
        l_fdate := Pdate_;
      
      ElsIf (Pdate_ > add_months(Bday_,540)) Then
      -- ���� ������ ����� �� ���� 45 ���� �볺���
        l_fdate := Pdate_;
      
      End if;
      
    End If;

  Else
    l_fdate := null;
  End If;

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(Rnk_) 
  then
     setPersonAttrEx(Rnk_,Sex_,Passp_,Ser_,Numdoc_, Pdate_,Organ_,l_fdate,Bday_,Bplace_,Teld_,Telw_,Telm_,actual_date_,eddr_id_);
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_person%rowtype;
     begin
        l_clv.rnk    := Rnk_;
        l_clv.sex    := Sex_;
        l_clv.passp  := Passp_;
        l_clv.ser    := Ser_;
        l_clv.numdoc := Numdoc_;
        l_clv.pdate  := Pdate_;
        l_clv.organ  := Organ_;
        l_clv.bday   := Bday_;
        l_clv.bplace := Bplace_;
        l_clv.teld   := Teld_;
        l_clv.telw   := Telw_;
		l_clv.cellphone   := Telm_;
        l_clv.actual_date := actual_date_;
        l_clv.eddr_id     := eddr_id_;
        bars_clv.set_req_customerperson(l_clv);
      exception when others then
        bars_audit.error('KL - '||sqlerrm);
    end;
$end
  end if;

END setPersonAttr;

--***************************************************************************--
-- PROCEDURE 	: setPersonAttrEx
-- DESCRIPTION	: ��������� ����������� �������-���.����/���������� ����������
--***************************************************************************--
PROCEDURE setPersonAttrEx
( Rnk_      person.rnk%type,
  Sex_      person.sex%type,
  Passp_    person.passp%type,
  Ser_      person.ser%type,
  Numdoc_   person.numdoc%type,
  Pdate_    person.pdate%type,
  Organ_    person.organ%type,
  Fdate_    person.date_photo%type,	-- ���� ���� ���� ������ ������� ���������� � �������
  Bday_     person.bday%type,
  Bplace_   person.bplace%type,
  TelD_     person.teld%type,       -- �������  ������� �볺���
  TelW_     person.telw%type,       -- �������   ������� �볺���
  TelM_     person.cellphone%type default null,  -- �������� ������� �볺���
  actual_date_  person.actual_date%type default null,
  eddr_id_      person.eddr_id%type default null
) IS
  l_title   varchar2(20) := 'kl.setPersonAttrEx: ';
$if KL_PARAMS.RI $then
  okpo_     customer.okpo%type;
  insfo_    number(1);
  k060_     number;
$end
BEGIN
  if eddr_id_ is not null 
  then
    bars_audit.trace('%s 1.params:'
         || ' Rnk_=>%s,'
         || ' actual_date_=>%s,'
         || ' Passp_=>%s,'
         || ' eddr_id_=>%s,'
         || ' Numdoc_=>%s,'
         || ' Pdate_=>%s,'
         || ' Organ_=>%s,'
         || ' Bday_=>%s',
         l_title, to_char(Rnk_), to_char(actual_date_,'dd/MM/yyyy'),
         to_char(Passp_), eddr_id_, Numdoc_, to_char(Pdate_,'dd/MM/yyyy'),
         Organ_, to_char(Bday_,'dd/MM/yyyy'));
  else
    bars_audit.trace('%s 1.params:'
       || ' Rnk_=>%s,'
       || ' Sex_=>%s,'
       || ' Passp_=>%s,'
       || ' Ser_=>%s,'
       || ' Numdoc_=>%s,'
       || ' Pdate_=>%s,'
       || ' Organ_=>%s,'
       || ' Bday_=>%s',
       l_title, to_char(Rnk_), Sex_, to_char(Passp_), Ser_, Numdoc_,
       to_char(Pdate_,'dd/MM/yyyy'), Organ_, to_char(Bday_,'dd/MM/yyyy'));
  end if;
  
  bars_audit.trace( '%s 2.params: Bplace_=>%s, Teld_=>%s, Telw_=>%s, TelM_=>%s.'
                  , l_title, Bplace_, Teld_, Telw_, TelM_ );

  UPDATE Person
     SET sex         = Sex_   ,
         passp       = Passp_ ,
         telw        = TelW_  ,
         teld        = TelD_  ,
         CellPhone   = case when TelM_ = 'XXXXXXXXXX' then CellPhone else TelM_ end,
         ser         = Ser_   ,
         numdoc      = Numdoc_,
         pdate       = PDate_ ,
         organ       = Organ_ ,
         bday        = BDay_  ,
         bplace      = BPlace_,
         date_photo  = case passp_
                         when 1 then nvl(fdate_,date_photo)
                         else Fdate_
                       end,
         actual_date = actual_date_,
         eddr_id     = eddr_id_
   WHERE rnk = rnk_;

  IF SQL%rowcount = 0 
  THEN
    bars_audit.trace('%s 3. ����������� ���������� ���.���� ���=%s', l_title, Rnk_);
    INSERT INTO Person (rnk, sex, passp, ser, numdoc, pdate, organ, bday, bplace, telD, telW, CellPhone, date_photo, actual_date, eddr_id)
    VALUES (Rnk_, Sex_, Passp_, Ser_, Numdoc_, PDate_, Organ_, BDay_, BPlace_, TelD_, TelW_, TelM_, Fdate_, actual_date_, eddr_id_);
    bars_audit.trace('%s 4. ��������� ����������� ���������� ���.���� ���=%s', l_title, Rnk_);
  ELSE
    bars_audit.trace('%s 5. ��������� ���������� ���������� ���.���� ���=%s', l_title, Rnk_);
  END IF;

$if KL_PARAMS.SBER $then
  ADD_EBK_QUEUE(rnk_);

$end
  -- ���.���.
  If ( TelM_ = 'XXXXXXXXXX' )
  Then
    null;
  Else
    setCustomerElement(Rnk_, 'MPNO', TelM_, 0);
  End If;

$if KL_PARAMS.RI $then
  begin
    select okpo
    into   okpo_
    from   customer
    where  rnk=Rnk_;
  exception when no_data_found then
    okpo_ := null;
  end;
  if okpo_ is not null then
    if okpo_ in ('0000000000','000000000') then
      begin
        select insform,
               k060
        into   insfo_,
               k060_
        from   customer_ri
        where  idcode in ('0000000000','000000000') and
--             paspsn=Ser_||Numdoc_                 and
               doct=Passp_                          and
               docs=Ser_                            and
               docn=Numdoc_                         and
               rownum<2;
        setCustomerElement(Rnk_,'INSFO',to_char(insfo_),0);
      exception when no_data_found then
        k060_ := null;
      end;
    else
      if Passp_ is not null and Ser_ is not null and Numdoc_ is not null then
        begin
          select insform,
                 k060
          into   insfo_,
                 k060_
          from   customer_ri
          where  idcode=okpo_ and
                 doct=Passp_  and
                 docs=Ser_    and
                 docn=Numdoc_ and
                 rownum<2;
          setCustomerElement(Rnk_,'INSFO',to_char(insfo_),0);
        exception when no_data_found then
          k060_ := null;
        end;
      else
        begin
          select insform,
                 k060
          into   insfo_,
                 k060_
          from   customer_ri
          where  idcode=okpo_ and
                 rownum<2;
          setCustomerElement(Rnk_,'INSFO',to_char(insfo_),0);
        exception when no_data_found then
          k060_ := null;
        end;
      end if;
    end if;

    if k060_ is not null
    then
      update customer
         set prinsider=k060_
       where rnk=Rnk_;
$if KL_PARAMS.SBER $then
      ADD_EBK_QUEUE(Rnk_);
$end
    end if;

  end if;
$end

END setPersonAttrEx;

--***************************************************************************--
-- PROCEDURE 	: setCustomerRekv
-- DESCRIPTION	: ��������� ���������� ���������� �������
--***************************************************************************--
PROCEDURE setCustomerRekv (
  Rnk_       rnk_rekv.rnk%type,
  LimKass_   rnk_rekv.lim_kass%type,
  AdrAlt_    rnk_rekv.adr_alt%type,
  NomDog_    rnk_rekv.nom_dog%type
) IS
  l_title varchar2(20) := 'kl.setCustomerRekv: ';
BEGIN
  bars_audit.trace('%s 1.params:'
       || ' Rnk_=>%s,'
       || ' LimKass_=>%s,'
       || ' AdrAlt_=>%s,'
       || ' NomDog_=>%s',
       l_title, to_char(Rnk_), to_char(LimKass_), AdrAlt_, NomDog_);

  IF LimKass_ is null AND AdrAlt_ is null AND NomDog_ is null THEN
     bars_audit.trace('%s 2. �������� ���������� ������� ���=%s', l_title, Rnk_);
     DELETE FROM rnk_rekv WHERE rnk=Rnk_;
     bars_audit.trace('%s 3. ��������� �������� ���������� ������� ���=%s', l_title, Rnk_);
  ELSE
     UPDATE rnk_rekv
        SET lim_kass = LimKass_,
            adr_alt  = AdrAlt_,
            nom_dog  = NomDog_
      WHERE rnk = Rnk_;
     IF sql%rowcount = 0 THEN
        bars_audit.trace('%s 4. ����������� ���������� ������� ���=%s', l_title, Rnk_);
        INSERT INTO rnk_rekv(rnk, lim_kass, adr_alt, nom_dog)
        VALUES (Rnk_, LimKass_, AdrAlt_, NomDog_);
        bars_audit.trace('%s 5. ��������� ����������� ���������� ������� ���=%s', l_title, Rnk_);
     ELSE
        bars_audit.trace('%s 6. ��������� ���������� ���������� ������� ���=%s', l_title, Rnk_);
     END If;
  END IF;

END setCustomerRekv;

--***************************************************************************--
-- PROCEDURE 	: setCustomerElement
-- DESCRIPTION	: ��������� ���������� ���������� �������
--***************************************************************************--
PROCEDURE setCustomerElement(
  Rnk_        customerw.rnk%type,
  Tag_        customerw.tag%type,
  Val_        customerw.value%type,
  Otd_        customerw.isp%type,
  p_flag_visa number default 0 )
IS
  l_title     varchar2(30) := 'kl.setCustomerElement: ';
  l_isp       customerw.isp%type;
BEGIN

  bars_audit.trace( '%s 1.params: Rnk_=>%s, Tag_=>%s, Val_=>%s, Otd_=>%s'
                  , l_title, to_char(Rnk_), Tag_, Val_, to_char(Otd_) );

$if KL_PARAMS.SBER $then
  l_isp := 0;
$else
  l_isp := nvl(Otd_,0);
$end

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(Rnk_)
  then
     if ( Val_ is null )
     then
        bars_audit.trace('%s 2. �������� ���.��������� %s ������� ���=%s', l_title, Tag_, to_char(Rnk_));
        delete CUSTOMERW
         where RNK = Rnk_
           and TAG = Tag_
$if KL_PARAMS.SBER $then
$else
           and ISP = l_isp
$end
        ;
        bars_audit.trace('%s 3. ��������� �������� ���.��������� %s ������� ���=%s', l_title, Tag_, to_char(Rnk_));
     else
        update CUSTOMERW
           set VALUE = trim(Val_)
         where RNK = Rnk_
           and TAG = Tag_
$if KL_PARAMS.SBER $then
$else
           and ISP = l_isp
$end
        ;
        if ( sql%rowcount = 0 )
        then
          bars_audit.trace('%s 4. ����������� ���.��������� %s ������� ���=%s', l_title, Tag_, to_char(Rnk_));
          insert into CUSTOMERW ( RNK, TAG, VALUE, ISP )
          values ( Rnk_, Tag_, trim(Val_), l_isp );
          bars_audit.trace('%s 5. ��������� ����������� ���.��������� %s ������� ���=%s', l_title, Tag_, to_char(Rnk_));
        else
          bars_audit.trace('%s 6. ��������� ���������� ���.��������� %s ������� ���=%s', l_title, Tag_, to_char(Rnk_));
        end if;

$if KL_PARAMS.SBER $then
        ADD_EBK_QUEUE(Rnk_, trim(Tag_));

$end
     END IF;
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customerw%rowtype;
     begin
        l_clv.rnk   := Rnk_;
        l_clv.tag   := trim(Tag_);
        l_clv.value := trim(Val_);
        bars_clv.set_req_customerw(l_clv);
     end;
$end
  end if;

END setCustomerElement;

$if KL_PARAMS.TREASURY $then
$else
--***************************************************************************--
-- PROCEDURE 	: setCustomerExtern
-- DESCRIPTION	: ��������� ���������� ���������� ���������� �����
--***************************************************************************--
procedure setCustomerExtern (
  p_id         in out customer_extern.id%type,
  p_name              customer_extern.name%type,
  p_doctype           customer_extern.doc_type%type,
  p_docserial         customer_extern.doc_serial%type,
  p_docnumber         customer_extern.doc_number%type,
  p_docdate           customer_extern.doc_date%type,
  p_docissuer         customer_extern.doc_issuer%type,
  p_birthday          customer_extern.birthday%type,
  p_birthplace        customer_extern.birthplace%type,
  p_sex               customer_extern.sex%type,
  p_adr               customer_extern.adr%type,
  p_tel               customer_extern.tel%type,
  p_email             customer_extern.email%type,
  p_custtype          customer_extern.custtype%type,
  p_okpo              customer_extern.okpo%type,
  p_country           customer_extern.country%type,
  p_region            customer_extern.region%type,
  p_fs                customer_extern.fs%type,
  p_ved               customer_extern.ved%type,
  p_sed               customer_extern.sed%type,
  p_ise               customer_extern.ise%type,
  p_notes             customer_extern.notes%type,
  p_date_photo        customer_extern.date_photo%type default null,
  p_eddr_id           customer_extern.eddr_id%type default null,
  p_actual_date       customer_extern.actual_date%type default null)
is
  l_title varchar2(30) := 'kl.setCustomerExtern: ';
  l_id    number;
begin
  bars_audit.trace('%s 1.params:'
       || ' p_id=>%s,'
       || ' p_name=>%s,'
       || ' p_doctype=>%s,'
       || ' p_docserial=>%s,'
       || ' p_docnumber=>%s,'
       || ' p_docdate=>%s,'
       || ' p_docissuer=>'||p_docissuer,
       l_title, to_char(p_id), p_name,
       to_char(p_doctype), p_docserial, p_docnumber, to_char(p_docdate,'dd/MM/yyyy'));
  bars_audit.trace('%s 2.params:'
       || ' p_birthday=>%s,'
       || ' p_birthplace=>%s,'
       || ' p_sex=>%s,'
       || ' p_adr=>%s,'
       || ' p_tel=>%s,'
       || ' p_email=>%s,'
       || ' p_custtype=>%s,'
       || ' p_okpo=>%s',
       l_title, to_char(p_birthday,'dd/MM/yyyy'), p_birthplace, p_sex, p_adr, p_tel,
       p_email, to_char(p_custtype), p_okpo);
  bars_audit.trace('%s 3.params:'
       || ' p_country=>%s,'
       || ' p_region=>%s,'
       || ' p_fs=>%s,'
       || ' p_ved=>%s,'
       || ' p_sed=>%s,'
       || ' p_ise=>%s',
       l_title, to_char(p_country), p_region, p_fs, p_ved, p_sed, p_ise);

  bars_audit.trace('%s 4.params:'
       || ' p_date_photo=>%s,'
       || ' p_eddr_id=>%s,'
       || ' p_actual_date=>%s',
       l_title, to_char(p_date_photo,'dd/MM/yyyy'), p_eddr_id, to_char(p_actual_date,'dd/MM/yyyy'));

  if p_id is not null then
     bars_audit.trace('%s 4. ���������� ���������� ���������� ���� id=%s', l_title, to_char(p_id));
     update customer_extern
        set name = p_name,
            doc_type    = p_doctype,
            doc_serial  = p_docserial,
            doc_number  = p_docnumber,
            doc_date    = p_docdate,
            doc_issuer  = p_docissuer,
            birthday    = p_birthday,
            birthplace  = p_birthplace,
            sex         = p_sex,
            adr         = p_adr,
            tel         = p_tel,
            email       = p_email,
            custtype    = p_custtype,
            okpo        = p_okpo,
            country     = p_country,
            region      = p_region,
            fs          = p_fs,
            ved         = p_ved,
            sed         = p_sed,
            ise         = p_ise,
            notes       = p_notes,
            date_photo  = p_date_photo,
            EDDR_ID     = p_eddr_id,
            actual_date = p_actual_date
      where id = p_id;
     bars_audit.trace('%s 5. ��������� ���������� ���������� ���������� ���� id=%s', l_title, to_char(p_id));
  else
     bars_audit.trace('%s 6. ����������� ���������� ����', l_title);
     l_id := bars_sqnc.get_nextval('s_customer');
     insert into customer_extern ( id, name,
        doc_type, doc_serial, doc_number, doc_date, doc_issuer,
        birthday, birthplace, sex, adr, tel, email,
        custtype, okpo, country, region, fs, ved, sed, ise, notes,date_photo,eddr_id,actual_date )
     values ( l_id, p_name,
        p_doctype, p_docserial, p_docnumber, p_docdate, p_docissuer,
        p_birthday, p_birthplace, p_sex, p_adr, p_tel, p_email,
        p_custtype, p_okpo, p_country, p_region, p_fs, p_ved, p_sed, p_ise, p_notes,p_date_photo,p_eddr_id,p_actual_date ) ;
     p_id := l_id;
     bars_audit.trace('%s 7. ��������� ����������� ���������� ����, id=%s', l_title, to_char(p_id));
  end if;
end setCustomerExtern;

--***************************************************************************--
-- PROCEDURE 	: setCustomerRel
-- DESCRIPTION	: ��������� ���������� ���������� ������� "��������� ����"
--***************************************************************************--
PROCEDURE setCustomerRel (
  p_rnk              customer_rel.rnk%type,
  p_relid            customer_rel.rel_id%type,
  p_relrnk           customer_rel.rel_rnk%type,
  p_relintext        customer_rel.rel_intext%type,
  p_vaga1            customer_rel.vaga1%type,
  p_vaga2            customer_rel.vaga2%type,
  p_typeid           customer_rel.type_id%type,
  p_position         customer_rel.position%type,
  p_position_r       customer_rel.position_r%type,
  p_firstname        customer_rel.first_name%type,
  p_middlename       customer_rel.middle_name%type,
  p_lastname         customer_rel.last_name%type,
  p_documenttypeid   customer_rel.document_type_id%type,
  p_document         customer_rel.document%type,
  p_trustregnum      customer_rel.trust_regnum%type,
  p_trustregdat      customer_rel.trust_regdat%type,
  p_bdate            customer_rel.bdate%type,
  p_edate            customer_rel.edate%type,
  p_notaryname       customer_rel.notary_name%type,
  p_notaryregion     customer_rel.notary_region%type,
  p_signprivs        customer_rel.sign_privs%type,
  p_signid           customer_rel.sign_id%type,
  p_namer            customer_rel.name_r%type,
  p_flag_visa number default 0 )
is
begin
  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(p_rnk) then
     update customer_rel
        set vaga1            = p_vaga1,
            vaga2            = p_vaga2,
            type_id          = p_typeid,
            position         = p_position,
            position_r       = p_position_r,
            first_name       = p_firstname,
            middle_name      = p_middlename,
            last_name        = p_lastname,
            document_type_id = p_documenttypeid,
            document         = p_document,
            trust_regnum     = p_trustregnum,
            trust_regdat     = p_trustregdat,
            bdate            = p_bdate,
            edate            = p_edate,
            notary_name      = p_notaryname,
            notary_region    = p_notaryregion,
            sign_privs       = p_signprivs,
            sign_id          = p_signid,
            name_r           = p_namer
      where rnk        = p_rnk
        and rel_id     = p_relid
        and rel_rnk    = p_relrnk
        and rel_intext = p_relintext;
     if sql%rowcount = 0 then
        insert into customer_rel ( rnk, rel_id, rel_rnk, rel_intext, vaga1, vaga2,
           type_id, position, position_r, first_name, middle_name, last_name,
           document_type_id, document,
           trust_regnum, trust_regdat, bdate, edate, notary_name, notary_region,
           sign_privs, sign_id, name_r )
        values ( p_rnk, p_relid, p_relrnk, p_relintext, p_vaga1, p_vaga2,
           p_typeid, p_position, p_position_r, p_firstname, p_middlename, p_lastname,
           p_documenttypeid, p_document,
           p_trustregnum, p_trustregdat, p_bdate, p_edate,
           p_notaryname, p_notaryregion, p_signprivs, p_signid, p_namer );
     end if;
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customer_rel%rowtype;
     begin
        l_clv.rnk     := p_rnk;
        l_clv.rel_id  := p_relid;
        l_clv.rel_rnk := p_relrnk;
        l_clv.rel_intext := p_relintext;
        l_clv.vaga1 := p_vaga1;
        l_clv.vaga2 := p_vaga2;
        l_clv.type_id  := p_typeid;
        l_clv.position := p_position;
        l_clv.position_r := p_position_r;
        l_clv.first_name  := p_firstname;
        l_clv.middle_name := p_middlename;
        l_clv.last_name   := p_lastname;
        l_clv.document_type_id := p_documenttypeid;
        l_clv.document := p_document;
        l_clv.trust_regnum := p_trustregnum;
        l_clv.trust_regdat := p_trustregdat;
        l_clv.bdate := p_bdate;
        l_clv.edate := p_edate;
        l_clv.notary_name   := p_notaryname;
        l_clv.notary_region := p_notaryregion;
        l_clv.sign_privs := p_signprivs;
        l_clv.sign_id := p_signid;
        l_clv.name_r := p_namer;
        bars_clv.set_req_customerrel(l_clv);
     end;
$end
  end if;

end setCustomerRel;

--***************************************************************************--
-- PROCEDURE 	: delCustomerRel
-- DESCRIPTION	: ��������� �������� ���������� ������� "��������� ����"
--***************************************************************************--
PROCEDURE delCustomerRel (
  p_rnk       customer_rel.rnk%type,
  p_relid     customer_rel.rel_id%type,
  p_relrnk    customer_rel.rel_rnk%type,
  p_relintext customer_rel.rel_intext%type,
  p_flag_visa number default 0 )
is
  l_title varchar2(30) := 'kl.delCustomerRel: ';
begin

  bars_audit.trace('%s 1.params:'
       || ' p_rnk=>%s,'
       || ' p_relid=>%s,'
       || ' p_relrnk=>%s',
       l_title, to_char(p_rnk), to_char(p_relid), to_char(p_relrnk));

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(p_rnk) then
     delete from customer_rel
      where rnk        = p_rnk
        and rel_id     = p_relid
        and rel_rnk    = p_relrnk
        and rel_intext = p_relintext;
     bars_audit.trace('%s 2. �������� ���������� ����: rnk=%s, relid=%s, relrnk=%s',
          l_title, to_char(p_rnk), to_char(p_relid), to_char(p_relrnk));
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customer_rel%rowtype;
     begin
        l_clv.rnk     := p_rnk;
        l_clv.rel_id  := p_relid;
        l_clv.rel_rnk := p_relrnk;
        -- rel_intext = null - ������� �������� �����
        l_clv.rel_intext := null;
        bars_clv.set_req_customerrel(l_clv);
     end;
$end
  end if;

end delCustomerRel;
$end

--***************************************************************************--
-- PROCEDURE 	: setCustomerAddress
-- DESCRIPTION	: ��������� ���������� ������� �������
--***************************************************************************--
PROCEDURE setCustomerAddress (
  Rnk_         customer_address.rnk%type,
  TypeId_      customer_address.type_id%type,
  Country_     customer_address.country%type,
  Zip_         customer_address.zip%type,
  Domain_      customer_address.domain%type,
  Region_      customer_address.region%type,
  Locality_    customer_address.locality%type,
  Address_     customer_address.address%type )
is
begin
  setCustomerAddressByTerritory(Rnk_, TypeId_, Country_, Zip_,
     Domain_, Region_, Locality_, Address_, null);
end setCustomerAddress;

--***************************************************************************--
-- PROCEDURE 	: setCustomerAddressByTerritory
-- DESCRIPTION	: ��������� ���������� ������� �������
--***************************************************************************--
PROCEDURE setCustomerAddressByTerritory (
  Rnk_         customer_address.rnk%type,
  TypeId_      customer_address.type_id%type,
  Country_     customer_address.country%type,
  Zip_         customer_address.zip%type,
  Domain_      customer_address.domain%type,
  Region_      customer_address.region%type,
  Locality_    customer_address.locality%type,
  Address_     customer_address.address%type,
  TerritoryId_ customer_address.territory_id%type,
  p_flag_visa  number default 0 )
is
begin
  setFullCustomerAddress(Rnk_, TypeId_, Country_, Zip_,
     Domain_, Region_, Locality_, Address_, TerritoryId_,
     null, null, null, null, null, null, null, null, null, null, p_flag_visa);
end setCustomerAddressByTerritory;

--***************************************************************************--
-- PROCEDURE 	: setFullCustomerAddress
-- DESCRIPTION	: ��������� ���������� ������� �������
--***************************************************************************--
procedure setFullCustomerAddress (
	p_rnk         	customer_address.rnk%type,
	p_typeId    	customer_address.type_id%type,
	p_country    	customer_address.country%type,
	p_zip         	customer_address.zip%type,
	p_domain     	customer_address.domain%type,
	p_region    	customer_address.region%type,
	p_locality   	customer_address.locality%type,
	p_address    	customer_address.address%type,
	p_territoryId 	customer_address.territory_id%type,
	p_locality_type customer_address.locality_type%type,
	p_street_type   customer_address.street_type%type,
	p_street       	customer_address.street%type,
	p_home_type    	customer_address.home_type%type,
	p_home         	customer_address.home%type,
	p_homepart_type	customer_address.homepart_type%type,
	p_homepart     	customer_address.homepart%type,
	p_room_type     customer_address.room_type%type,
	p_room         	customer_address.room%type,
	p_comment       customer_address.comm%type default null,
	p_flag_visa     number default 0 )
IS
  NewId_ number;
  l_title varchar2(40) := 'kl.setFullCustomerAddress: ';
BEGIN
  bars_audit.trace('%s 1.params:'
       || ' p_Rnk=>%s,'
       || ' p_TypeId=>%s,'
       || ' p_Country=>%s,'
       || ' p_Zip=>%s,'
       || ' p_Domain=>%s,'
       || ' p_Region=>%s,'
       || ' p_Locality=>%s,'
       || ' p_Address=>%s,'
       || ' p_TerritoryId=>' || to_char(p_TerritoryId),
       l_title, to_char(p_Rnk), to_char(p_TypeId), to_char(p_Country),
       p_Zip, p_Domain, p_Region, p_Locality, p_Address);

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(p_Rnk) then
     -- ��������
     if     p_Country     is null
        and p_Zip         is null
        and p_Domain      is null
        and p_Region      is null
        and p_Locality    is null
        and p_Address     is null
        and p_TerritoryId is null
     then
        bars_audit.trace('%s 2. �������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
        delete from customer_address where rnk=p_Rnk and type_id=p_TypeId;
        bars_audit.trace('%s 3. ��������� �������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
     else
        -- ����������
		-- ��� �������� � ������ �����
		if (p_locality_type is null
		    and p_street_type is null
		    and p_street is null
		    and p_home_type is null
		    and p_home is null
		    and p_homepart_type is null
		    and p_homepart is null
		    and p_room_type is null
		    and p_room is null
			and p_comment is null ) then

				update customer_address
				set country       = p_Country,
					zip     	     = p_Zip,
					domain  	     = p_Domain,
					region        = p_Region,
					locality      = p_Locality,
					address       = p_Address,
					territory_id  = p_TerritoryId
				where rnk = p_Rnk and type_id = p_TypeId;

		else

			update customer_address
				set country       = p_Country,
					zip     	     = p_Zip,
					domain  	     = p_Domain,
					region        = p_Region,
					locality      = p_Locality,
					address       = p_Address,
					territory_id  = p_TerritoryId,
					locality_type = p_locality_type,
					street_type   = p_street_type,
					street        = p_street,
					home_type     = p_home_type,
					home          = p_home,
					homepart_type = p_homepart_type,
					homepart      = p_homepart,
					room_type     = p_room_type,
					room          = p_room,
					comm          = p_comment
				where rnk = p_Rnk and type_id = p_TypeId;

		end if;

        if sql%rowcount = 0 then
           bars_audit.trace('%s 4. ����������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
           -- ����������
           insert into customer_address (rnk, type_id, country, zip, domain, region, locality, address, territory_id,
              locality_type, street_type, street, home_type, home, homepart_type, homepart, room_type, room, comm)
           values ( p_Rnk, p_TypeId, p_Country, p_Zip, p_Domain, p_Region, p_Locality, p_Address, p_TerritoryId,
              p_locality_type, p_street_type, p_street, p_home_type, p_home, p_homepart_type, p_homepart,
              p_room_type, p_room, p_comment);
           bars_audit.trace('%s 5. ��������� ����������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
        else
           bars_audit.trace('%s 6. ��������� ���������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
        end if;

$if KL_PARAMS.SBER $then
        ADD_EBK_QUEUE(p_rnk);

$end
     end if;
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customer_address%rowtype;
     begin
        l_clv.rnk      	    := p_Rnk;
        l_clv.type_id  	    := p_TypeId;
        l_clv.country  	    := p_Country;
        l_clv.zip      	    := p_Zip;
        l_clv.domain   	    := p_Domain;
        l_clv.region   	    := p_Region;
        l_clv.locality 	    := p_Locality;
        l_clv.address  	    := p_Address;
        l_clv.territory_id  := p_TerritoryId;
        l_clv.locality_type := p_locality_type;
        l_clv.street_type   := p_street_type;
        l_clv.street        := p_street;
        l_clv.home_type     := p_home_type;
        l_clv.home          := p_home;
        l_clv.homepart_type := p_homepart_type;
        l_clv.homepart      := p_homepart;
        l_clv.room_type     := p_room_type;
        l_clv.room          := p_room;
        l_clv.comm          := p_comment;
        bars_clv.set_req_customeraddress(l_clv);
     end;
$end
  end if;

END;

--***************************************************************************--
-- PROCEDURE  : setFullCustomerAddress
-- DESCRIPTION  : ��������� ���������� ������� ������� � ����� ����������
-- ���������� � �� � ������������, ��� ����� ��� ��� ���� �� ����
--***************************************************************************--
procedure setFullCustomerAddress (
  p_rnk           customer_address.rnk%type,
  p_typeId      customer_address.type_id%type,
  p_country     customer_address.country%type,
  p_zip           customer_address.zip%type,
  p_domain      customer_address.domain%type,
  p_region      customer_address.region%type,
  p_locality    customer_address.locality%type,
  p_address     customer_address.address%type,
  p_territoryId   customer_address.territory_id%type,
  p_locality_type customer_address.locality_type%type,
  p_street_type   customer_address.street_type%type,
  p_street        customer_address.street%type,
  p_home_type     customer_address.home_type%type,
  p_home          customer_address.home%type,
  p_homepart_type customer_address.homepart_type%type,
  p_homepart      customer_address.homepart%type,
  p_room_type     customer_address.room_type%type,
  p_room          customer_address.room%type,
  p_comment       customer_address.comm%type default null,
  p_region_id     customer_address.region_id%type,
  p_area_id       customer_address.area_id%type,
  p_settlement_id customer_address.settlement_id%type,
  p_street_id     customer_address.street_id%type,
  p_house_id      customer_address.house_id%type,
  p_flag_visa     number default 0 )
IS
  NewId_ number;
  l_title varchar2(40) := 'kl.setFullCustomerAddress: ';
BEGIN
  bars_audit.trace('%s 1.params:'
       || ' p_Rnk=>%s,'
       || ' p_TypeId=>%s,'
       || ' p_Country=>%s,'
       || ' p_Zip=>%s,'
       || ' p_Domain=>%s,'
       || ' p_Region=>%s,'
       || ' p_Locality=>%s,'
       || ' p_Address=>%s,'
       || ' p_TerritoryId=>' || to_char(p_TerritoryId),
       l_title, to_char(p_Rnk), to_char(p_TypeId), to_char(p_Country),
       p_Zip, p_Domain, p_Region, p_Locality, p_Address);

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(p_Rnk) then
     -- ��������
     if     p_Country     is null
        and p_Zip         is null
        and p_Domain      is null
        and p_Region      is null
        and p_Locality    is null
        and p_Address     is null
        and p_TerritoryId is null
     then
        bars_audit.trace('%s 2. �������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
        delete from customer_address where rnk=p_Rnk and type_id=p_TypeId;
        bars_audit.trace('%s 3. ��������� �������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
     else
        -- ����������
        -- ��� �������� � ������ �����
        if (p_locality_type is null
            and p_street_type is null
            and p_street is null
            and p_home_type is null
            and p_home is null
            and p_homepart_type is null
            and p_homepart is null
            and p_room_type is null
            and p_room is null
          and p_comment is null ) then

            update customer_address
            set country       = p_Country,
              zip            = p_Zip,
              domain         = p_Domain,
              region        = p_Region,
              locality      = p_Locality,
              address       = p_Address,
              territory_id  = p_TerritoryId
            where rnk = p_Rnk and type_id = p_TypeId;

        else
          update customer_address
            set country       = p_Country,
              zip            = p_Zip,
              domain         = p_Domain,
              region        = p_Region,
              locality      = p_Locality,
              address       = p_Address,
              territory_id  = p_TerritoryId,
              --locality_type = p_locality_type,
              --street_type   = p_street_type,
              street        = p_street,
              home_type     = p_home_type,
              home          = p_home,
              homepart_type = p_homepart_type,
              homepart      = p_homepart,
              room_type     = p_room_type,
              room          = p_room,
              comm          = p_comment,
              region_id     = p_region_id,
              area_id       = p_area_id,
              settlement_id = p_settlement_id,
              street_id     = p_street_id,
              house_id      = p_house_id,
              locality_type_n = p_locality_type,
              street_type_n   = p_street_type
            where rnk = p_Rnk and type_id = p_TypeId;

        end if;

        if sql%rowcount = 0 then
           bars_audit.trace('%s 4. ����������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
           -- ����������
           insert into customer_address (rnk, type_id, country, zip, domain, region, locality, address, territory_id,
              locality_type, street_type, street, home_type, home, homepart_type, homepart, room_type, room, comm,
              region_id, area_id, settlement_id, street_id, house_id, locality_type_n, street_type_n  )
           values ( p_Rnk, p_TypeId, p_Country, p_Zip, p_Domain, p_Region, p_Locality, p_Address, p_TerritoryId,
              /*p_locality_type*/null, /*p_street_type*/null, p_street, p_home_type, p_home, p_homepart_type, p_homepart,p_room_type, p_room, p_comment,
              p_region_id, p_area_id, p_settlement_id, p_street_id,p_house_id, p_locality_type, p_street_type);
           bars_audit.trace('%s 5. ��������� ����������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
        else
           bars_audit.trace('%s 6. ��������� ���������� ������ �� ������ ������� %s (���=%s)', l_title, to_char(p_Rnk), to_char(p_TypeId));
        end if;

$if KL_PARAMS.SBER $then
        ADD_EBK_QUEUE(p_rnk);

$end
     end if;
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customer_address%rowtype;
     begin
        l_clv.rnk           := p_Rnk;
        l_clv.type_id       := p_TypeId;
        l_clv.country       := p_Country;
        l_clv.zip           := p_Zip;
        l_clv.domain        := p_Domain;
        l_clv.region        := p_Region;
        l_clv.locality      := p_Locality;
        l_clv.address       := p_Address;
        l_clv.territory_id  := p_TerritoryId;
        l_clv.locality_type := p_locality_type;
        l_clv.street_type   := p_street_type;
        l_clv.street        := p_street;
        l_clv.home_type     := p_home_type;
        l_clv.home          := p_home;
        l_clv.homepart_type := p_homepart_type;
        l_clv.homepart      := p_homepart;
        l_clv.room_type     := p_room_type;
        l_clv.room          := p_room;
        l_clv.comm          := p_comment;
        bars_clv.set_req_customeraddress(l_clv);
     end;
$end
  end if;

END;

$if KL_PARAMS.TREASURY $then
$else
--***************************************************************************--
-- PROCEDURE 	: setCorpAcc
-- DESCRIPTION	: ��������� ���������� ���������� ������ ������� � ��. ������
--***************************************************************************--
PROCEDURE setCorpAcc (
  Rnk_    corps_acc.rnk%type,
  Id_     corps_acc.id%type,
  Mfo_    corps_acc.mfo%type,
  Nls_    corps_acc.nls%type,
  Kv_     corps_acc.kv%type,
  Comm_   corps_acc.comments%type
) IS
  NewId_ number;
  l_title varchar2(30) := 'kl.setCorpAcc: ';
BEGIN
  bars_audit.trace('%s 1.params:'
       || ' Rnk_=>%s,'
       || ' Id_=>%s,'
       || ' Mfo_=>%s,'
       || ' Nls_=>%s,'
       || ' Kv_=>%s,'
       || ' Comm_=>%s',
       l_title, to_char(Rnk_), to_char(Id_), Mfo_, Nls_, to_char(Kv_), Comm_);

  setCorpAccEx(Rnk_ , Id_, Mfo_, Nls_, Kv_, Comm_,
     null, null, null, null, null, null, null, null, null, null);

END setCorpAcc;

--***************************************************************************--
-- PROCEDURE 	: setCorpAccEx
-- DESCRIPTION	: ��������� ���������� ���������� ������ ������� � ��. ������
--***************************************************************************--
PROCEDURE setCorpAccEx (
  Rnk_    corps_acc.rnk%type,
  Id_     corps_acc.id%type,
  Mfo_    corps_acc.mfo%type,
  Nls_    corps_acc.nls%type,
  Kv_     corps_acc.kv%type,
  Comm_   corps_acc.comments%type,
  p_sw56_name  corps_acc.sw56_name%type,
  p_sw56_adr   corps_acc.sw56_adr%type,
  p_sw56_code  corps_acc.sw56_code%type,
  p_sw57_name  corps_acc.sw57_name%type,
  p_sw57_adr   corps_acc.sw57_adr%type,
  p_sw57_code  corps_acc.sw57_code%type,
  p_sw57_acc   corps_acc.sw57_acc%type,
  p_sw59_name  corps_acc.sw59_name%type,
  p_sw59_adr   corps_acc.sw59_adr%type,
  p_sw59_acc   corps_acc.sw59_acc%type,
  p_flag_visa  number default 0 )
is
  l_id  number;
  l_flag_visa number;
begin
     l_flag_visa := GetGlobalOption('CUST_CLV');
  if l_flag_visa = 0
  or l_flag_visa = 1 and not is_customer_visa(Rnk_) then
     l_id := case when Id_ is null then s_corps_acc.nextval else Id_ end;
     begin
        -- ����������
        insert into corps_acc(id, rnk, mfo, nls, kv, comments,
           sw56_name, sw56_adr, sw56_code,
           sw57_name, sw57_adr, sw57_code, sw57_acc,
           sw59_name, sw59_adr, sw59_acc)
        values (l_id, Rnk_, Mfo_, Nls_, Kv_, Comm_,
           p_sw56_name, p_sw56_adr, p_sw56_code,
           p_sw57_name, p_sw57_adr, p_sw57_code, p_sw57_acc,
           p_sw59_name, p_sw59_adr, p_sw59_acc);
     exception when dup_val_on_index then
        -- ����������
        update corps_acc
           set mfo = Mfo_,
               nls = Nls_,
               kv  = Kv_,
               comments = Comm_,
               sw56_name = p_sw56_name,
               sw56_adr  = p_sw56_adr,
               sw56_code = p_sw56_code,
               sw57_name = p_sw57_name,
               sw57_adr  = p_sw57_adr,
               sw57_code = p_sw57_code,
               sw57_acc  = p_sw57_acc,
               sw59_name = p_sw59_name,
               sw59_adr  = p_sw59_adr,
               sw59_acc  = p_sw59_acc
         where id = l_id;
     end;
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_corps_acc%rowtype;
     begin
        l_clv.rnk := Rnk_;
        l_clv.id  := Id_;
        l_clv.mfo := Mfo_;
        l_clv.nls := Nls_;
        l_clv.kv  := Kv_;
        l_clv.comments := Comm_;
        bars_clv.set_req_customercorpacc(l_clv);
     end;
$end
  end if;

end setCorpAccEx;

--***************************************************************************--
-- PROCEDURE 	: delCorpAcc
-- DESCRIPTION	: ��������� �������� ���������� ������ ������� � ��. ������
--***************************************************************************--
PROCEDURE delCorpAcc (
  Id_         corps_acc.id%type,
  p_flag_visa number default 0 )
IS
  l_rnk number;
BEGIN
  if p_flag_visa = 0 then
     delete from corps_acc where id=Id_;
$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_corps_acc%rowtype;
     begin
        l_clv.rnk := null;
        l_clv.id  := Id_;
        bars_clv.set_req_customercorpacc(l_clv);
     end;
$end
  end if;
END delCorpAcc;
$end

$if KL_PARAMS.SIGN $then
--***************************************************************************--
-- PROCEDURE 	: setCustomerSeal
-- DESCRIPTION	: ��������� ���������� �������/������
--***************************************************************************--
procedure setCustomerSeal (
  Id_   OUT customer_bin_data.id%type,
  Img_   IN customer_bin_data.bin_data%type
) is
begin

  if id_ is null then

     select s_customer_bin_data.nextval into id_ from dual ;

     insert into customer_bin_data(id, bin_data)
     values (id_, img_);

  else

     update customer_bin_data
        set bin_data = img_
      where id = id_;

  end if;

end setCustomerSeal;
$end

--***************************************************************************--
-- procedure 	: set_customer_risk
-- description	: ��������� ��������� ������ ��������
--***************************************************************************--
procedure set_customer_risk (
  p_rnk       number,
  p_riskid    number,
  p_riskvalue number,
  p_flag_visa number default 0 )
is
  i     number;
  ipep  number;
  l_dat date := trunc(sysdate);
  l_publ     varchar2(3);
  l_pep      varchar2(15);
  l_pep_valid  number(1);
begin

  if p_flag_visa = 0
  or p_flag_visa = 1 and not is_customer_visa(p_rnk) then
     -- ���������� ���� �� ������� ����?
     execute immediate '
     select count(*)
       from customer_risk
      where rnk = :p_rnk
        and risk_id = :p_riskid
        and dat_begin = :l_dat' into i using p_rnk, p_riskid, l_dat;

     -- ���� �� ����������
     if i = 0 then

        -- ��������� ��������� �� ����� ����� ���������
        execute immediate '
        update customer_risk
           set dat_end = :l_dat
         where rnk = :p_rnk
           and risk_id = :p_riskid
           and dat_end is null' using l_dat, p_rnk, p_riskid;

        -- ������������� ����
        if p_riskvalue = 1 then
           execute immediate '
           insert into customer_risk (rnk, risk_id, dat_begin, user_id)
           values (:p_rnk, :p_riskid, :l_dat, user_id)' using p_rnk, p_riskid, l_dat;
        end if;

     -- ���� ����������
     else

        if p_riskvalue = 0 then

           execute immediate '
           delete from customer_risk
            where rnk = :p_rnk
              and risk_id = :p_riskid
              and dat_begin = :l_dat' using p_rnk, p_riskid, l_dat;

        end if;

     end if;

$if KL_PARAMS.CLV $then
  else
     declare
        l_clv clv_customer_risk%rowtype;
        l_rnk number;
     begin
        l_rnk := p_rnk;
        l_clv.rnk     := l_rnk;
        l_clv.risk_id := p_riskid;
        if p_riskvalue = 0 then
           l_clv.user_id := null;
        else
           l_clv.user_id := user_id;
        end if;
        bars_clv.set_req_customerrisk(l_clv);
     end;
  end if;
$end
  execute immediate '
     select count(*)
       from customer_risk
      where rnk = :p_rnk
        and risk_id in  (2, 3, 62, 63, 64, 65)
        and dat_begin = :l_dat'
  into ipep using p_rnk, l_dat;

  if ( ipep > 0 )
  then

    setCustomerElement( Rnk_ => p_rnk
                      , Tag_ => 'PUBLP'
                      , Val_ => '���'
                      , Otd_ => 0
                      );
    /* pavlenko 04/04/2016 COBUSUPABS-4365
    4) � ������ �볺��� (������� ����.��������/Գ�.���.�)
    ������ ������� ������ ��ϻ, �� ������ �������� ��� ������䳻, ����, �ͳ�, ������ ���������,
    ��� ����� ���������� ��������:
    ���� �������� �������� ���������� �� �������� ����� ������� ����,
    �� �������� ������ �������� �� �������� �������� ��� ������䳻, ����, �ͳ�,
    ������ � ������� �� ������������ (������ ���������).
    */
    begin
      select upper(trim(value))
        into l_pep
        from CUSTOMERW
       where rnk = p_rnk
         and tag = 'PEP';
     bars_audit.info( 'kl.set_customer_risk: pep='||l_pep );
    exception
      when NO_DATA_FOUND
      then bars_error.raise_nerror('CAC', 'ERR_EMPTY_PEP');
    end;

    begin
      execute immediate 'select 1 from FM_PEP where upper(name) = :l_pep'
      into l_pep_valid using l_pep;
      bars_audit.info( 'kl.set_customer_risk: pep='||l_pep_valid );
    exception
      when NO_DATA_FOUND
      then bars_error.raise_nerror('CAC', 'ERR_EMPTY_PEP');
    end;

  else

    setCustomerElement( Rnk_ => p_rnk
                      , Tag_ => 'PUBLP'
                      , Val_ => 'ͳ'
                      , Otd_ => 0
                      );

    setCustomerElement( Rnk_ => p_rnk
                      , Tag_ => 'PEP'
                      , Val_ => null
                      , Otd_ => 0
                      );

  end if;

end set_customer_risk;

--***************************************************************************--
-- procedure 	: set_customer_rept
-- description	: ��������� ��������� ��������� �������
--***************************************************************************--
procedure set_customer_rept (
  p_rnk       number,
  p_reptid    number,
  p_reptvalue number )
is
  i     number;
  l_dat date := trunc(sysdate);
begin

  -- ����������� ��������� �� ������� ����?
  execute immediate '
  select count(*)
    from customer_rept
   where rnk = :p_rnk
     and rept_id = :p_reptid
     and dat_begin = :l_dat' into i using p_rnk, p_reptid, l_dat;

  -- ��������� �� �����������
  if i = 0 then

     -- ��������� ��������� �� ���� ��������� ���������
     execute immediate '
     update customer_rept
        set dat_end = :l_dat
      where rnk = :p_rnk
        and rept_id = :p_reptid
        and dat_end is null' using l_dat, p_rnk, p_reptid;

     -- ������������� ���������
     if p_reptvalue = 1 then
        execute immediate '
        insert into customer_rept (rnk, rept_id, dat_begin, user_id)
        values (:p_rnk, :p_reptid, :l_dat, user_id)' using p_rnk, p_reptid, l_dat;
     end if;

  -- ��������� �����������
  else

     if p_reptvalue = 0 then

        execute immediate '
        delete from customer_rept
         where rnk = :p_rnk
           and rept_id = :p_reptid
           and dat_begin = :l_dat' using p_rnk, p_reptid, l_dat;

     end if;

  end if;

end set_customer_rept;

--***************************************************************************--
-- procedure     : set_customer_category
-- description   : ��������� ��������� ��������� �������
--***************************************************************************--
procedure set_customer_category (
  p_rnk           number,
  p_categoryid    number,
  p_categoryvalue number )
is
  i     number;
  l_dat date := trunc(sysdate);
begin

  -- ����������� ��������� �� ������� ����?
  execute immediate '
  select count(*)
    from customer_category
   where rnk = :p_rnk
     and category_id = :p_categoryid
     and dat_begin = :l_dat' into i using p_rnk, p_categoryid, l_dat;

  -- ��������� �� �����������
  if i = 0 then

     -- ��������� ��������� �� ���� ��������� ���������
     execute immediate '
     update customer_category
        set dat_end = :l_dat
      where rnk = :p_rnk
        and category_id = :p_categoryid
        and dat_end is null' using l_dat, p_rnk, p_categoryid;

     -- ������������� ���������
     if p_categoryvalue = 1 then
        execute immediate '
        insert into customer_category (rnk, category_id, dat_begin, user_id)
        values (:p_rnk, :p_categoryid, :l_dat, user_id)' using p_rnk, p_categoryid, l_dat;
     end if;

  -- ��������� �����������
  else

     if p_categoryvalue = 0 then

        execute immediate '
        delete from customer_category
         where rnk = :p_rnk
           and category_id = :p_categoryid
           and dat_begin = :l_dat' using p_rnk, p_categoryid, l_dat;

     end if;

  end if;

end set_customer_category;

--***************************************************************************--
-- procedure 	: approve_client_request
-- description	: ��������� ����������� ��������� ���������� �������
--***************************************************************************--
procedure approve_client_request (p_rnk number)
is
$if KL_PARAMS.CLV $then
  l_request  clv_request%rowtype;
  l_customer clv_customer%rowtype;
$end
begin
$if KL_PARAMS.CLV $then
  if bars_clv.found_request(p_rnk, l_request) = true
  then

    begin
       select * into l_customer from clv_customer where rnk = p_rnk;
    exception when no_data_found then
       raise_application_error(-20000, '����� �� �볺��� ��� ' || p_rnk || ' �� ��������');
    end;

    -- customer
    if l_request.req_type = 0
    then
        iopen_client (
           p_rnk         => l_customer.rnk,         -- Customer number
           -- �������� ���������
           p_custtype    => l_customer.custtype,    -- ��� �������: 1-����, 2-��.����, 3-���.����
           p_nd          => l_customer.nd,          -- � ��������
           p_nmk         => l_customer.nmk,         -- ������������ �������
           p_nmkv        => l_customer.nmkv,        -- ������������ ������� �������������
           p_nmkk        => l_customer.nmkk,        -- ������������ ������� �������
           p_adr         => l_customer.adr,         -- ����� �������
           p_codcagent   => l_customer.codcagent,   -- ��������������
           p_country     => l_customer.country,     -- ������
           p_prinsider   => l_customer.prinsider,   -- ������� ���������
           p_tgr         => l_customer.tgr,         -- ��� ���.�������
           p_okpo        => l_customer.okpo,        -- ����
           p_tobo        => l_customer.branch,      -- ��� �������������� ���������
           p_isp         => l_customer.isp,         -- �������� ������� (�����. �����������)
           p_dateon      => bankdate,               -- ���� �����������
           -- ��������� ��� ���������
           p_creg        => l_customer.c_reg,       -- ��� ���.��
           p_cdst        => l_customer.c_dst,       -- ��� �����.��
           p_adm         => l_customer.adm,         -- �����.�����
           p_rgadm       => l_customer.rgadm,       -- ��� ����� � ���.
           p_datea       => l_customer.datea,       -- ���� ���. � �������������
           p_rgtax       => l_customer.rgtax,       -- ��� ����� � ��
           p_datet       => l_customer.datet,       -- ���� ��� � ��
           p_nompdv      => l_customer.nompdv,      -- � ������������� ����������� ��� (9 ����)
           p_taxf        => l_customer.taxf,        -- ���. ��������� ����� (12 ����.)
           -- ������������� ���������
           p_ise         => l_customer.ise,         -- ����. ���. ���������
           p_fs          => l_customer.fs,          -- ����� �������������
           p_oe          => l_customer.oe,          -- ������� ���������
           p_ved         => l_customer.ved,         -- ��� ��. ������������
           p_sed         => l_customer.sed,         -- ����� ��������������
           p_k050        => l_customer.k050,        -- ���������� k050
           -- ������
           p_sab         => l_customer.sab,         -- ��.���
           p_stmt        => l_customer.stmt,        -- ������ �������
           p_crisk       => l_customer.crisk,       -- ��������� �����
           p_rnkp        => l_customer.rnkp,        -- ���. ����� ��������
           p_notes       => l_customer.notes,       -- ����������
           p_notesec     => l_customer.notesec,     -- ���������� ��� ������ ������������
           p_lim         => null,                   -- ����� �����
           p_pincode     => null,                   --
           p_mb          => null,                   -- �������. ������ �������
           p_bc          => 0,                      -- ������� ��������� �����
           p_nrezid_code => l_customer.nrezid_code );
     elsif l_request.req_type = 1 then
        setCustomerAttr (
           Rnk_          => l_customer.rnk,         -- Customer number
           Custtype_     => l_customer.custtype,    -- ��� �������: 1-����, 2-��.����, 3-���.����
           Nd_           => l_customer.nd,          -- � ��������
           Nmk_          => l_customer.nmk,         -- ������������ �������
           Nmkv_         => l_customer.nmkv,        -- ������������ ������� �������������
           Nmkk_         => l_customer.nmkk,        -- ������������ ������� �������
           Adr_          => l_customer.adr,         -- ����� �������
           Codcagent_    => l_customer.codcagent,   -- ��������������
           Country_      => l_customer.country,     -- ������
           Prinsider_    => l_customer.prinsider,   -- ������� ���������
           Tgr_          => l_customer.tgr,         -- ��� ���.�������
           Okpo_         => l_customer.okpo,        -- ����
           Stmt_         => l_customer.stmt,        -- ������ �������
           Sab_          => l_customer.sab,         -- ��.���
           DateOn_       => null,                   -- ���� �����������
           Taxf_         => l_customer.taxf,        -- ��������� ���
           CReg_         => l_customer.c_reg,       -- ��� ���.��
           CDst_         => l_customer.c_dst,       -- ��� �����.��
           Adm_          => l_customer.adm,         -- �����.�����
           RgTax_        => l_customer.rgtax,       -- ��� ����� � ��
           RgAdm_        => l_customer.rgadm,       -- ��� ����� � ���.
           DateT_        => l_customer.datet,       -- ���� ��� � ��
           DateA_        => l_customer.datea,       -- ���� ���. � �������������
           Ise_          => l_customer.ise,         -- ����. ���. ���������
           Fs_           => l_customer.fs,          -- ����� �������������
           Oe_           => l_customer.oe,          -- ������� ���������
           Ved_          => l_customer.ved,         -- ��� ��. ������������
           Sed_          => l_customer.sed,         -- ����� ��������������
           Notes_        => l_customer.notes,       -- ����������
           Notesec_      => l_customer.notesec,     -- ���������� ��� ������ ������������
           CRisk_        => l_customer.crisk,       -- ��������� �����
           Pincode_      => null,                   --
           RnkP_         => l_customer.rnkp,        -- ���. ����� ��������
           Lim_          => null,                   -- ����� �����
           NomPDV_       => l_customer.nompdv,      -- � � ������� ����. ���
           MB_           => null,                   -- �������. ������ �������
           BC_           => 0,                      -- ������� ��������� �����
           Tobo_         => l_customer.branch,      -- ��� �������������� ���������
           Isp_          => l_customer.isp,         -- �������� ������� (�����. �����������)
           p_nrezid_code => l_customer.nrezid_code,
           p_flag_visa   => 0 );

     end if;

     -- customer_address
     delete from customer_address c
      where rnk = p_rnk
        and not exists ( select 1 from clv_customer_address where rnk = c.rnk and type_id = c.type_id );
     for c in ( select * from clv_customer_address where rnk = p_rnk )
     loop
        setFullCustomerAddress (
           p_rnk           => c.rnk,
           p_typeId        => c.type_id,
           p_country       => c.country,
           p_zip           => c.zip,
           p_domain        => c.domain,
           p_region        => c.region,
           p_locality      => c.locality,
           p_address       => c.address,
           p_territoryId   => c.territory_id,
           p_locality_type => c.locality_type,
           p_street_type   => c.street_type,
           p_street        => c.street,
           p_home_type     => c.home_type,
           p_home          => c.home,
           p_homepart_type => c.homepart_type,
           p_homepart      => c.homepart,
           p_room_type     => c.room_type,
           p_room          => c.room,
           p_comment       => c.comm);
     end loop;

     -- customerw
     delete from customerw c
      where rnk = p_rnk
        and not exists ( select 1 from clv_customerw where rnk = c.rnk and tag = c.tag );
     for c in ( select * from clv_customerw where rnk = p_rnk )
     loop
        setCustomerElement(
           Rnk_ => c.rnk,
           Tag_ => c.tag,
           Val_ => c.value,
           Otd_ => 0 );
     end loop;

     -- customer_rel
     delete from customer_rel c
      where rnk = p_rnk
        and not exists ( select 1 from clv_customer_rel where rnk = c.rnk and rel_id = c.rel_id and rel_rnk = c.rel_rnk );
     for c in ( select * from clv_customer_rel where rnk = p_rnk )
     loop
        setCustomerRel (
           p_rnk            => c.rnk,
           p_relid          => c.rel_id,
           p_relrnk         => c.rel_rnk,
           p_relintext      => c.rel_intext,
           p_vaga1          => c.vaga1,
           p_vaga2          => c.vaga2,
           p_typeid         => c.type_id,
           p_position       => c.position,
           p_position_r     => c.position_r,
           p_firstname      => c.first_name,
           p_middlename     => c.middle_name,
           p_lastname       => c.last_name,
           p_documenttypeid => c.document_type_id,
           p_document       => c.document,
           p_trustregnum    => c.trust_regnum,
           p_trustregdat    => c.trust_regdat,
           p_bdate          => c.bdate,
           p_edate          => c.edate,
           p_notaryname     => c.notary_name,
           p_notaryregion   => c.notary_region,
           p_signprivs      => c.sign_privs,
           p_signid         => c.sign_id,
           p_namer          => c.name_r );
     end loop;

     -- corps
     for c in ( select * from clv_corps where rnk = p_rnk )
     loop
        setCorpAttr (
           Rnk_    => c.rnk,
           Nmku_   => c.nmku,
           Ruk_    => c.ruk,
           Telr_   => c.telr,
           Buh_    => c.buh,
           Telb_   => c.telb,
           TelFax_ => c.tel_fax,
           EMail_  => c.e_mail,
           SealId_ => c.seal_id );
     end loop;

     -- corps_acc
     delete from corps_acc c
      where rnk = p_rnk
        and not exists ( select 1 from clv_corps_acc where rnk = c.rnk and id = c.id );
     for c in ( select * from clv_corps_acc where rnk = p_rnk )
     loop
        setCorpAccEx (
           Rnk_   => c.rnk,
           Id_    => c.id,
           Mfo_   => c.mfo,
           Nls_   => c.nls,
           Kv_    => c.kv,
           Comm_  => c.comments,
           p_sw56_name => null,
           p_sw56_adr  => null,
           p_sw56_code => null,
           p_sw57_name => null,
           p_sw57_adr  => null,
           p_sw57_code => null,
           p_sw57_acc  => null,
           p_sw59_name => null,
           p_sw59_adr  => null,
           p_sw59_acc  => null );
     end loop;

     -- person
     for c in ( select * from clv_person where rnk = p_rnk )
     loop
        setPersonAttr (
           Rnk_    => c.rnk,
           Sex_    => c.sex,
           Passp_  => c.passp,
           Ser_    => c.ser,
           Numdoc_ => c.numdoc,
           Pdate_  => c.pdate,
           Organ_  => c.organ,
           Bday_   => c.bday,
           Bplace_ => c.bplace,
           Teld_   => c.teld,
           Telw_   => c.telw ,
           Telm_        => c.cellphone,
           actual_date_ => c.actual_date,
           eddr_id_     => c.eddr_id);
     end loop;

     -- customer_risk
     for c in ( select * from customer_risk r where rnk = p_rnk and not exists (select 1 from clv_customer_risk where rnk = r.rnk and risk_id = r.risk_id) )
     loop
        set_customer_risk(c.rnk, c.risk_id, 0);
     end loop;
     for c in ( select * from clv_customer_risk where rnk = p_rnk)
     loop
        set_customer_risk(c.rnk, c.risk_id, 1);
     end loop;

  else
     raise_application_error(-20000, '����� �� �볺��� ��� ' || p_rnk || ' �� ��������');
  end if;
  p_after_edit_client(p_rnk);
$else
  null;
$end
end approve_client_request;

--***************************************************************************--
-- function 	: get_customerw
-- description	: ������� ��������� �������� ���.��������� �������
--***************************************************************************--
function get_customerw (
  p_rnk customerw.rnk%type,
  p_tag customerw.tag%type,
  p_isp customerw.isp%type default 0) return customerw.value%type
is
  l_value customerw.value%type;
begin
  begin
     select value into l_value
       from customerw
      where rnk = p_rnk
        and tag = p_tag
        and isp = p_isp;
  exception when no_data_found then
     l_value := null;
  end;
  return l_value;
end get_customerw;

--***************************************************************************--
function get_empty_attr_foropenacc (p_rnk number) return varchar2
is
  l_msg    varchar2(2000) := null;
  l_cust   customer%rowtype;
  l_person person%rowtype;
  l_adr    customer_address%rowtype;
  procedure add_msg (i_str varchar2)
  is
  begin
     l_msg := case when l_msg is null then i_str
                   else l_msg || chr(10) || i_str
              end;
  end;
  procedure check_attr (i_value varchar2, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
  procedure check_attr (i_value number, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
  procedure check_attr (i_value date, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
begin
  -- �������� �������������� ��� �� � ��-���
  begin
     select c.* into l_cust
       from customer c
      where c.rnk = p_rnk
        and (c.custtype = 2 or c.custtype = 3 and nvl(trim(c.sed),'00') = '91');
     -- ����. �������
     check_attr(l_cust.country, '�����');
     check_attr(l_cust.nmk, '������������ �볺��� (���.)');
     check_attr(l_cust.nmkv, '������������ (���.)');
     check_attr(l_cust.okpo, '���������������� ���');
     check_attr(l_cust.adm, '���. ����� ���������');
     check_attr(l_cust.rgtax, '�����. ����� � ϲ');
     check_attr(l_cust.datet, '���� �����. � ϲ');
     check_attr(l_cust.datea, '���� �����. � ���.');
     -- �����
     begin
        select * into l_adr from customer_address where rnk = p_rnk and type_id = 1;
        check_attr(l_adr.locality, '��������� ����� (��������)');
        check_attr(l_adr.street, '���., �����., �-�. (��������)');
        check_attr(l_adr.home, '� ���., �/� (��������)');
     exception when no_data_found then null;
     end;
     check_attr( get_customerw(p_rnk, 'K013 '), '��� ���� �볺��� (K013)');
     -- ����. ��
     if l_cust.custtype = 3 then
        check_attr(trim(l_cust.ise), '����. ������ �������� (�070)');
        check_attr(trim(l_cust.fs), '����� �������� (�080)');
        check_attr(trim(l_cust.ved), '��� ��. ��������(�110)');
        check_attr(trim(l_cust.k050), '����� �������������� (�050)');
        begin
           select * into l_person from person where rnk = p_rnk;
           check_attr(l_person.passp , '��� ���������');
           -- ��� 7 ID - ������ ����� ������ �������,  ��������� ������ ��� ��������.
            case when l_person.passp = 1 then
                check_attr(l_person.ser, '����');
            else null;
            end case;
           check_attr(l_person.numdoc, '����� ���.');
           check_attr(l_person.organ, '��� �������');
           check_attr(l_person.pdate, '���� �������');
           check_attr(l_person.bday, '���� ����������');
           check_attr(l_person.sex, '�����');
           check_attr(l_person.teld, '���. ���.');
        exception when no_data_found then null;
        end;
        check_attr(get_customerw(p_rnk, 'MPNO '), '���. ���.');
        check_attr(get_customerw(p_rnk, 'GR   '), '������������');
        check_attr(get_customerw(p_rnk, 'DATZ '), '���� ���������� ���������� ������');
        check_attr(get_customerw(p_rnk, 'IDDPR'), '���� ��������� i������i���i�/��������� ����������');
        check_attr(get_customerw(p_rnk, 'ID_YN'), '������������� �볺��� ���������');
        check_attr(get_customerw(p_rnk, 'O_REP'), '������ ��������� �볺���');
        check_attr(get_customerw(p_rnk, 'IDPIB'), 'ϲ� �� ���. ����������, ����������. �� �����-��� � �������� �볺���');
        check_attr(get_customerw(p_rnk, 'DJER '), '�������������� ������ ���������� ����i�');
        check_attr(get_customerw(p_rnk, 'CIGPO') ,'������ ��������� �����');
     -- ��-��������
     elsif mod(l_cust.codcagent, 2) = 1 
 then
        check_attr(l_cust.adm,   '���. ����� ���������');
        check_attr(l_cust.rgtax, '�����. ����� � ϲ');
        check_attr(l_cust.datet, '���� �����. � ϲ');
        check_attr(l_cust.datea, '���� �����. � ���.');
        check_attr(trim(l_cust.ise), '����. ������ �������� (�070)');
        check_attr(trim(l_cust.fs), '����� �������� (�080)');
        check_attr(trim(l_cust.ved), '��� ��. ��������(�110)');
        check_attr(trim(l_cust.k050), '����� �������������� (�050)');
      --check_attr(get_customerw(p_rnk, 'UUCG '), '����� ������� ������ �� ����������� ��, �� ���������');
        check_attr(get_customerw(p_rnk, 'UUDV '), '������ �������� ��������');
     end if;
  exception when no_data_found then null;
  end;
  return l_msg;
end get_empty_attr_foropenacc;

--***************************************************************************--
-- procedure 	: check_attr_foropenacc
-- description	: ��������� �������� ���������� ���������� ������ ��� �������� ������ 2 ��.
--***************************************************************************--
procedure check_attr_foropenacc (p_rnk in number, p_msg out varchar2)
is
begin
  p_msg := null;
$if KL_PARAMS.SBER $then
  p_msg := get_empty_attr_foropenacc(p_rnk);
  if p_msg is not null
  then
    p_msg := substr('��� �������� ������� � ������ �볺��� ��������� ��������� ����:' || chr(10) || p_msg, 1, 2000);
  end if;
$end
end check_attr_foropenacc;

    -----------------------------------------------------------
    -- ��������� ������������� ������� ������������ ����
    -- � �� �������
    --
    procedure fill_let_table
    is
    p     constant varchar2(100) := 'kl.fill_let_table';
    l     t_let_rec;
    begin
        bars_audit.trace('%s: entry point', p);

		l.ukr_num := '01'; l.ukr_let := chr(192);  l.eng_let := chr(65); g_let_table(0) := l;
		l.ukr_num := '02'; l.ukr_let := chr(193);  l.eng_let := '';  	 g_let_table(1) := l;
		l.ukr_num := '03'; l.ukr_let := chr(194);  l.eng_let := chr(66); g_let_table(39) := l;
		l.ukr_num := '03'; l.ukr_let := chr(194);  l.eng_let := chr(86); g_let_table(2) := l;
		l.ukr_num := '03'; l.ukr_let := chr(194);  l.eng_let := chr(87); g_let_table(3) := l;
		l.ukr_num := '04'; l.ukr_let := chr(195);  l.eng_let := chr(71); g_let_table(4) := l;
		l.ukr_num := '05'; l.ukr_let := chr(165);  l.eng_let := '';  	 g_let_table(5) := l;
		l.ukr_num := '06'; l.ukr_let := chr(196);  l.eng_let := chr(68); g_let_table(6) := l;
		l.ukr_num := '07'; l.ukr_let := chr(197);  l.eng_let := chr(69); g_let_table(7) := l;
		l.ukr_num := '08'; l.ukr_let := chr(170);  l.eng_let := '';  	 g_let_table(8) := l;
		l.ukr_num := '09'; l.ukr_let := chr(198);  l.eng_let := chr(74); g_let_table(9) := l;
		l.ukr_num := '10'; l.ukr_let := chr(199);  l.eng_let := chr(90); g_let_table(10) := l;
		l.ukr_num := '11'; l.ukr_let := chr(200);  l.eng_let := '';  	 g_let_table(11) := l;
		l.ukr_num := '12'; l.ukr_let := chr(178);  l.eng_let := chr(73); g_let_table(12) := l;
		l.ukr_num := '13'; l.ukr_let := chr(175);  l.eng_let := '';  	 g_let_table(13) := l;
		l.ukr_num := '14'; l.ukr_let := chr(201);  l.eng_let := '';  	 g_let_table(14) := l;
		l.ukr_num := '15'; l.ukr_let := chr(202);  l.eng_let := chr(75); g_let_table(15) := l;
		l.ukr_num := '15'; l.ukr_let := chr(202);  l.eng_let := chr(81); g_let_table(16) := l;
		l.ukr_num := '16'; l.ukr_let := chr(203);  l.eng_let := chr(76); g_let_table(17) := l;
		l.ukr_num := '17'; l.ukr_let := chr(204);  l.eng_let := chr(77); g_let_table(18) := l;
		l.ukr_num := '18'; l.ukr_let := chr(205);  l.eng_let := chr(72); g_let_table(19) := l;
		l.ukr_num := '18'; l.ukr_let := chr(205);  l.eng_let := chr(78); g_let_table(20) := l;
		l.ukr_num := '19'; l.ukr_let := chr(206);  l.eng_let := chr(79); g_let_table(21) := l;
		l.ukr_num := '20'; l.ukr_let := chr(207);  l.eng_let := '';  	 g_let_table(22) := l;
		l.ukr_num := '21'; l.ukr_let := chr(208);  l.eng_let := chr(80); g_let_table(23) := l;
		l.ukr_num := '21'; l.ukr_let := chr(208);  l.eng_let := chr(82); g_let_table(24) := l;
		l.ukr_num := '22'; l.ukr_let := chr(209);  l.eng_let := chr(67); g_let_table(25) := l;
		l.ukr_num := '22'; l.ukr_let := chr(209);  l.eng_let := chr(83); g_let_table(26) := l;
		l.ukr_num := '23'; l.ukr_let := chr(210);  l.eng_let := chr(84); g_let_table(27) := l;
		l.ukr_num := '24'; l.ukr_let := chr(211);  l.eng_let := chr(85); g_let_table(28) := l;
		l.ukr_num := '24'; l.ukr_let := chr(211);  l.eng_let := chr(89); g_let_table(29) := l;
		l.ukr_num := '25'; l.ukr_let := chr(212);  l.eng_let := chr(70); g_let_table(30) := l;
		l.ukr_num := '26'; l.ukr_let := chr(213);  l.eng_let := chr(88); g_let_table(31) := l;
		l.ukr_num := '27'; l.ukr_let := chr(214);  l.eng_let := '';  	 g_let_table(32) := l;
		l.ukr_num := '28'; l.ukr_let := chr(215);  l.eng_let := '';  	 g_let_table(33) := l;
		l.ukr_num := '29'; l.ukr_let := chr(216);  l.eng_let := '';  	 g_let_table(34) := l;
		l.ukr_num := '30'; l.ukr_let := chr(217);  l.eng_let := '';  	 g_let_table(35) := l;
		l.ukr_num := '31'; l.ukr_let := chr(220);  l.eng_let := '';  	 g_let_table(36) := l;
		l.ukr_num := '32'; l.ukr_let := chr(222);  l.eng_let := '';  	 g_let_table(37) := l;
		l.ukr_num := '33'; l.ukr_let := chr(223);  l.eng_let := '';  	 g_let_table(38) := l;

		bars_audit.trace('%s: succ end', p);
    end;

    -----------------------------------------------------------
    -- ��������� ������������� ����� �������� � ���������� �������
    -- ����������, �� ����������� ����������
    --     @p_serial - ����� �������� �� ����
    --     @p_result - ����� �������� �� �����
    --     @p_errmsg - ����� ������ ��� ������ (SUCCESS, PASSPORT_SERIAL_NULL, PASSPORT_SERIAL_LENGTH, PASSPORT_SERIAL_ERROR)
    --
    procedure recode_passport_serial_silent(
		p_serial     in  person.ser%type,
        p_result     out person.ser%type,
        p_errmsg     out varchar2
	)
    is
    	p         constant varchar2(100)        := 'kl.recode_passport_serial_silent';
    	l_serial  person.ser%type;
    begin
		if logger.trace_enabled() then
        	bars_audit.trace('%s: entry point par[0]=>%s', p, p_serial);
		end if;
		p_result := null;
        -- ��������� ������� ��������
        if (p_serial is null) then
			if logger.trace_enabled() then
            	bars_audit.trace('%s: error detected - serial null', p);
			end if;
			p_errmsg := 'PASSPORT_SERIAL_NULL';
            return;
        elsif (length(p_serial) != 2) then
			if logger.trace_enabled() then
            	bars_audit.trace('%s: error detected - serial length is invalid', p);
			end if;
			p_errmsg := 'PASSPORT_SERIAL_LENGTH';
			return;
        else
            -- �������� � ������� �������
            l_serial := upper(p_serial);
            -- ��������� ���������� �������
            for i in 1..length(l_serial)
            loop
                if instr( chr(65)||chr(66)||chr(67)||chr(68)||chr(69)||chr(70)||chr(71)||chr(72)||chr(73)||chr(74)||chr(75)||chr(76)||chr(77)||chr(78)||chr(79)||chr(80)||chr(81)||chr(82)||chr(83)||chr(84)||chr(85)||chr(86)||chr(87)||chr(88)||chr(89)||chr(90)||
                          chr(192)||chr(193)||chr(194)||chr(195)||chr(165)||chr(196)||chr(197)||chr(170)||chr(198)||chr(199)||chr(200)||chr(178)||chr(175)||chr(201)||chr(202)||chr(203)||chr(204)||chr(205)||chr(206)||chr(207)||chr(208)||chr(209)||chr(210)||chr(211)||chr(212)||chr(213)||chr(214)||chr(215)||chr(216)||chr(217)||chr(222)||chr(223)||chr(220) , substr(l_serial, i, 1)) = 0 then
					if logger.trace_enabled() then
                    	bars_audit.trace('%s: error detected - invalid serial symbol pos: %s', p, to_char(i));
					end if;
					p_errmsg := 'PASSPORT_SERIAL_ERROR';
					return;
                end if;
            end loop;
            -- �������� � ���� ���������
            for k in 1..length(l_serial)
            loop
                for i in 0..g_let_table.count-1
                loop
                    if (g_let_table(i).ukr_let = substr(l_serial, k, 1) or
                        g_let_table(i).eng_let = substr(l_serial, k, 1)   ) then
                        p_result := p_result || g_let_table(i).ukr_let;
                        exit;
                    end if;
                end loop;
            end loop;
			if logger.trace_enabled() then
            	bars_audit.trace('%s: succ end with result %s', p, p_result);
			end if;
            p_errmsg := 'SUCCESS';
        end if;
    end recode_passport_serial_silent;

    -----------------------------------------------------------
    -- ������� ������������� ����� �������� � ���������� �������
    --
    --     @p_serial - ����� ��������
    --
    function recode_passport_serial(p_serial in person.ser%type) return person.ser%type
    is
		l_result	person.ser%type;
		l_errmsg	varchar2(128);
    begin
		recode_passport_serial_silent(p_serial, l_result, l_errmsg);
		if l_errmsg='SUCCESS'
        then
			return l_result;
		else
			bars_error.raise_nerror(g_modcode, l_errmsg);
		end if;
    end recode_passport_serial;

    -----------------------------------------------------------
    -- ������� ������������� ������ ��������
    --
    --     @p_number - ����� ��������
    --
    function recode_passport_number(p_number in person.numdoc%type) return person.numdoc%type
    is
    p         constant varchar2(100)        := 'kl.recode_passport_number';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, p_number);
        -- ��������� ������� ��������
        if (p_number is null) then
            bars_audit.trace('%s: error detected - number null', p);
            bars_error.raise_nerror(g_modcode, 'PASSPORT_NUMBER_NULL');
        elsif (length(p_number) != 6) then
            bars_audit.trace('%s: error detected - number length is invalid', p);
            bars_error.raise_nerror(g_modcode, 'PASSPORT_NUMBER_LENGTH');
        else
            -- ��������� ��������� �������
            for i in 1..length(p_number)
            loop
                if (substr(p_number, i, 1) not in ('0','1','2','3','4','5','6','7','8','9')) then
                    bars_audit.trace('%s: error detected - invalid number symbol', p);
                    bars_error.raise_nerror(g_modcode, 'PASSPORT_NUMBER_ERROR', to_char(i));
                end if;
            end loop;
        end if;
        bars_audit.trace('%s: succ end');
        return p_number;
    end recode_passport_number;


    -----------------------------------------------------------
    -- ��������� ���������(���������) ���� ������� � ���������� ���������� �� CardMake
    --
    --
    procedure set_cutomer_image(p_rnk number, p_imgage_type  varchar2, p_image blob)
    is
       p         constant varchar2(100)        := 'kl.set_cutomer_image';
    begin
       begin
          insert into customer_images (rnk, type_img, date_img, image) values (p_rnk, p_imgage_type, sysdate, p_image);
       exception when dup_val_on_index then
          update customer_images set date_img = sysdate, image = p_image where rnk = p_rnk and type_img = p_imgage_type;
       end;
       --���������� ���������� �� CardMake �� ������ �� ��������� ������ �� �������
        bars.ow_utl.get_nd (p_rnk);
    end ;

    -----------------------------------------------------------
    -- �-��� ��������� ������ ����
    --
    -- @p_rnk - ��� �������
    --
    function generate_dkbo_number(p_rnk customer.rnk%type) return varchar2
      is
      begin
        return p_rnk||to_char(sysdate, 'YYMMDDHH24MISS');
        end generate_dkbo_number;


 procedure RESURRECT_CUSTOMER
  ( p_rnk     in     customer.rnk%type
  , p_err_msg    out varchar2
  ) is
    title  constant  varchar2(64) := $$PLSQL_UNIT||'.RESURRECT_CUSTOMER';
  begin
    
    bars_audit.trace( '%s: Entry with ( p_rnk=%s ).', title, to_char(p_rnk) );
    
    begin

      update CUSTOMER
         set DATE_OFF = null
       where RNK = p_rnk;

      begin
        -- COBUSUPABS-5726 - ����������� ���� ������ �����������
        FM_SET_RIZIK( p_rnk );
      exception
        when others then
          p_err_msg := sqlerrm;
          bars_audit.error( title ||': '||chr(10)|| p_err_msg ||chr(10)|| dbms_utility.format_error_backtrace() );
          p_err_msg := '������� ����������� ���� ������: ' || substr( p_err_msg, 1, 150 );
      end;

    exception
      when others then
        p_err_msg := substr( sqlerrm, 1, 200 );
    end;

    bars_audit.trace( '%s: Exit with ( p_err_msg=%s ).', title, p_err_msg );

  end RESURRECT_CUSTOMER;


BEGIN

  -- �������������� ������ ������������ ���� �������� � ��������� ��� ������������� ����� ��������
  fill_let_table();

END KL;
/
 show err;
 
PROMPT *** Create  grants  KL ***
grant EXECUTE                                                                on KL              to ABS_ADMIN;
grant EXECUTE                                                                on KL              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KL              to CUST001;
grant EXECUTE                                                                on KL              to WR_ALL_RIGHTS;
grant EXECUTE                                                                on KL              to WR_CUSTREG;
grant EXECUTE                                                                on KL              to WR_TOBO_ACCOUNTS_LIST;
grant EXECUTE                                                                on KL              to WR_USER_ACCOUNTS_LIST;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kl.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 