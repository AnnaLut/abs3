-- ======================================================================================
-- Module : CDM (ªÁÊ)
-- Author : BAA
-- Date   : 12.02.2018
-- ======================================================================================
-- create view V_EBKC_QUEUE_UPDCARD_LEGAL
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_EBKC_QUEUE_UPDCARD_LEGAL
prompt -- ======================================================

create or replace force view V_EBKC_QUEUE_UPDCARD_LEGAL
( KF
, RNK
, LASTCHANGEDT
, DATEOFF
, DATEON
, FULLNAME
, FULLNAMEINTERNATIONAL
, FULLNAMEABBREVIATED
, K014
, K040
, BUILDSTATEREGISTER
, OKPO
, ISOKPOEXCLUSION
, K060
, K030
, OFFBALANCEDEPCODE
, OFFBALANCEDEPNAME
, K070
, K080
, K110
, K050
, K051
, LA_INDEX
, LA_TERRITORYCODE
, LA_REGION
, LA_AREA
, LA_SETTLEMENT
, LA_K040
, LA_FULLADDRESS
, AA_INDEX
, AA_TERRITORYCODE
, AA_REGION
, AA_AREA
, AA_SETTLEMENT
, AA_K040
, AA_FULLADDRESS
, REGIONALPI
, AREAPI
, ADMREGAUTHORITY
, ADMREGDATE
, PIREGDATE
, DPAREGNUMBER
, DPIREGDATE
, VATDATA
, VATCERTNUMBER
, NAMEBYSTATUS
, BORROWERCLASS
, REGIONALHOLDINGNUMBER
, K013
, GROUPAFFILIATION
, INCOMETAXPAYERREGDATE
, SEPARATEDIVCORPCODE
, ECONOMICACTIVITYTYPE
, FIRSTACCDATE
, INITIALFORMFILLDATE
, EVALUATIONREPUTATION
, AUTHORIZEDCAPITALSIZE
, RISKLEVEL
, REVENUESOURCESCHARACTER
, ESSENCECHARACTER
, NATIONALPROPERTY
, VIPSIGN
, NOTAXPAYERSIGN
, CUST_ID
, GCIF
, RCIF
) AS
select v.kf,
       case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(v.RNK/100)
         else v.RNK
       end as RNK,
       v.lastchangedt,
       v.date_off       as dateOff,
       v.date_on        as dateOn,
       v.full_Name      as fullName,
       v.full_Name_International as fullNameInternational,
       v.full_Name_Abbreviated   as fullNameAbbreviated,
       v.k014,
       v.k040  as k040,
       v.build_State_Register    as buildStateRegister,
       v.okpo,
       v.is_Okpo_Exclusion       as isOkpoExclusion,
       v.k060    as k060,
       v.k030    as k030,
       v.off_Balance_Dep_Code as offBalanceDepCode,
       v.off_Balance_Dep_Name as offBalanceDepName,
       v.k070,
       v.k080,
       v.k110,
       v.k050,
       v.k051,
       v.au_zip    as la_index,
       v.au_terid  as la_territoryCode,
       v.au_region as la_region,
       v.au_area   as la_area,
       v.au_locality as la_settlement,
       v.au_contry as la_k040,
       v.au_adress as la_fullAddress,
       v.af_zip    as aa_index,
       v.af_terid  as aa_territoryCode,
       v.af_region as aa_region,
       v.af_area   as aa_area,
       v.af_locality as aa_settlement,
       v.af_contry as aa_k040,
       v.af_adress as aa_fullAddress,
       v.regional_Pi as regionalPi,
       v.area_Pi   as areaPi,
       v.adm_Reg_Authority as admRegAuthority,
       v.adm_Reg_Date      as admRegDate,
       v.pi_Reg_Date       as piRegDate,
       v.dpa_Reg_Number    as dpaRegNumber,
       v.dpi_Reg_Date      as dpiRegDate,
       v.vat_Data          as vatData,
       v.vat_Cert_Number   as vatCertNumber,
       v.name_By_Status    as nameByStatus,
       v.borrower_Class    as borrowerClass,
       v.regional_Holding_Number   as regionalHoldingNumber,
       v.k013,
       v.group_Affiliation         as groupAffiliation,
       v.income_Tax_Payer_Reg_Date as incomeTaxPayerRegDate,
       v.separate_Div_Corp_Code    as separateDivCorpCode,
       v.economic_Activity_Type    as economicActivityType,
       v.first_Acc_Date            as firstAccDate,
       v.initial_Form_Fill_Date    as initialFormFillDate,
       v.evaluation_Reputation     as evaluationReputation,
       v.authorized_Capital_Size   as authorizedCapitalSize,
       v.risk_Level                as riskLevel,
       v.revenue_Sources_Character as revenueSourcesCharacter,
       v.essence_Character         as essenceCharacter,
       v.national_Property         as nationalProperty,
       v.vip_Sign                  as vipSign,
       v.no_Taxpayer_Sign          as noTaxpayerSign,
       v.RNK                       as CUST_ID,
       g.GCIF,
       cast( null as number ) as RCIF
  from ( select KF, RNK
           from EBKC_QUEUE_UPDATECARD
          where CUST_TYPE = 'L'
            and STATUS    = 0
          order by ROWID
       ) q
  join V_EBKC_LEGAL_PERSON v
    on ( v.RNK = q.RNK )
  left outer
  join EBKC_GCIF g
    on ( g.RNK = q.RNK )
;

show errors;

grant SELECT on V_EBKC_QUEUE_UPDCARD_LEGAL to BARS_ACCESS_DEFROLE;
grant SELECT on V_EBKC_QUEUE_UPDCARD_LEGAL to BARSREADER_ROLE;
