create or replace view v_clientfo2 as
select
CHANGENUMBER,
CAST (LAST_NAME as VARCHAR2(50)) AS LAST_NAME,
CAST (FIRST_NAME as VARCHAR2(50)) AS FIRST_NAME,
CAST (MIDDLE_NAME as VARCHAR2(60)) AS MIDDLE_NAME,
CAST (BDAY as DATE) AS BDAY,
CAST (GR as VARCHAR2(30)) AS GR,
CAST (PASSP as NUMBER(22)) AS PASSP,
CAST (SER as VARCHAR2(10)) AS SER,
CAST (NUMDOC as VARCHAR2(20)) AS NUMDOC,
CAST (PDATE as DATE) AS PDATE,
CAST (ORGAN as VARCHAR2(150)) AS ORGAN,
CAST (PASSP_EXPIRE_TO as DATE) AS PASSP_EXPIRE_TO,
CAST (PASSP_TO_BANK as DATE) AS PASSP_TO_BANK,
CAST (KF as VARCHAR2(6)) AS KF,
CAST (trunc(RNK/100) as NUMBER(22)) AS RNK,
CAST (OKPO as VARCHAR2(14)) AS OKPO,
CAST (CUST_STATUS as VARCHAR2(20)) AS CUST_STATUS,
CAST (trunc(CUST_ACTIVE/100) as NUMBER(22)) AS CUST_ACTIVE,
CAST (TELM as VARCHAR2(20)) AS TELM,
CAST (TELW as VARCHAR2(20)) AS TELW,
CAST (TELD as VARCHAR2(20)) AS TELD,
CAST (TELADD as VARCHAR2(20)) AS TELADD,
CAST (EMAIL as VARCHAR2(100)) AS EMAIL,
CAST (ADR_POST_COUNTRY as VARCHAR2(55)) AS ADR_POST_COUNTRY,
CAST (ADR_POST_DOMAIN as VARCHAR2(30)) AS ADR_POST_DOMAIN,
CAST (ADR_POST_REGION as VARCHAR2(30)) AS ADR_POST_REGION,
CAST (ADR_POST_LOC as VARCHAR2(30)) AS ADR_POST_LOC,
CAST (ADR_POST_ADR as VARCHAR2(100)) AS ADR_POST_ADR,
CAST (ADR_POST_ZIP as VARCHAR2(20)) AS ADR_POST_ZIP,
CAST (ADR_FACT_COUNTRY as VARCHAR2(55)) AS ADR_FACT_COUNTRY,
CAST (ADR_FACT_DOMAIN as VARCHAR2(30)) AS ADR_FACT_DOMAIN,
CAST (ADR_FACT_REGION as VARCHAR2(30)) AS ADR_FACT_REGION,
CAST (ADR_FACT_LOC as VARCHAR2(30)) AS ADR_FACT_LOC,
CAST (ADR_FACT_ADR as VARCHAR2(100)) AS ADR_FACT_ADR,
CAST (ADR_FACT_ZIP as VARCHAR2(20)) AS ADR_FACT_ZIP,
CAST (ADR_WORK_COUNTRY as VARCHAR2(55)) AS ADR_WORK_COUNTRY,
CAST (ADR_WORK_DOMAIN as VARCHAR2(30)) AS ADR_WORK_DOMAIN,
CAST (ADR_WORK_REGION as VARCHAR2(30)) AS ADR_WORK_REGION,
CAST (ADR_WORK_LOC as VARCHAR2(30)) AS ADR_WORK_LOC,
CAST (ADR_WORK_ADR as VARCHAR2(100)) AS ADR_WORK_ADR,
CAST (ADR_WORK_ZIP as VARCHAR2(20)) AS ADR_WORK_ZIP,
CAST (BRANCH as VARCHAR2(30)) AS BRANCH,
CAST (NEGATIV_STATUS as VARCHAR2(10)) AS NEGATIV_STATUS,
CAST (REESTR_MOB_BANK as VARCHAR2(10)) AS REESTR_MOB_BANK,
CAST (REESTR_INET_BANK as VARCHAR2(10)) AS REESTR_INET_BANK,
CAST (REESTR_SMS_BANK as VARCHAR2(10)) AS REESTR_SMS_BANK,
CAST (MONTH_INCOME as NUMBER(22, 2)) AS MONTH_INCOME,
CAST (SUBJECT_ROLE as VARCHAR2(10)) AS SUBJECT_ROLE,
CAST (REZIDENT as VARCHAR2(10)) AS REZIDENT,
CAST (MERRIED as VARCHAR2(500)) AS MERRIED,
CAST (EMP_STATUS as VARCHAR2(10)) AS EMP_STATUS,
CAST (SUBJECT_CLASS as VARCHAR2(10)) AS SUBJECT_CLASS,
CAST (INSIDER as VARCHAR2(10)) AS INSIDER,
CAST (SEX as CHAR(1)) AS SEX,
CAST (VIPK as NUMBER(22)) AS VIPK,
CAST (VIP_FIO_MANAGER as VARCHAR2(250)) AS VIP_FIO_MANAGER,
CAST (VIP_PHONE_MANAGER as VARCHAR2(30)) AS VIP_PHONE_MANAGER,
CAST (DATE_ON as DATE) AS DATE_ON,
CAST (DATE_OFF as DATE) AS DATE_OFF,
CAST (EDDR_ID as VARCHAR2(20)) AS EDDR_ID,
CAST (actual_date as DATE) AS IDCARD_VALID_DATE,
CAST (IDDPL as VARCHAR2(500)) AS IDDPL,
CAST (BPLACE as VARCHAR2(70)) AS BPLACE,
CAST (SUBSD as VARCHAR2(500)) AS SUBSD,
CAST (SUBSN as VARCHAR2(500)) AS SUBSN,
CAST (ELT_N as VARCHAR2(500)) AS ELT_N,
CAST (ELT_D as VARCHAR2(500)) AS ELT_D,
CAST (GCIF as VARCHAR2(30)) AS GCIF,
CAST (NOMPDV as VARCHAR2(9)) AS NOMPDV,
CAST (NOM_DOG as VARCHAR2(10)) AS NOM_DOG,
CAST (SW_RN as VARCHAR2(500)) AS SW_RN,
CAST (Y_ELT as VARCHAR2(500)) AS Y_ELT,
CAST (ADM as VARCHAR2(70)) AS ADM,
CAST (FADR as VARCHAR2(500)) AS FADR,
CAST (ADR_ALT as VARCHAR2(70)) AS ADR_ALT,
CAST (BUSSS as VARCHAR2(500)) AS BUSSS,
CAST (PC_MF as VARCHAR2(500)) AS PC_MF,
CAST (PC_Z4 as VARCHAR2(500)) AS PC_Z4,
CAST (PC_Z3 as VARCHAR2(500)) AS PC_Z3,
CAST (PC_Z5 as VARCHAR2(500)) AS PC_Z5,
CAST (PC_Z2 as VARCHAR2(500)) AS PC_Z2,
CAST (PC_Z1 as VARCHAR2(500)) AS PC_Z1,
CAST (AGENT as VARCHAR2(500)) AS AGENT,
CAST (PC_SS as VARCHAR2(500)) AS PC_SS,
CAST (STMT as VARCHAR2(500)) AS STMT,
CAST (VIDKL as VARCHAR2(500)) AS VIDKL,
CAST (VED as CHAR(5)) AS VED,
CAST (TIPA as VARCHAR2(500)) AS TIPA,
CAST (PHKLI as VARCHAR2(500)) AS PHKLI,
CAST (AF1_9 as VARCHAR2(500)) AS AF1_9,
CAST (IDDPD as VARCHAR2(500)) AS IDDPD,
CAST (DAIDI as VARCHAR2(500)) AS DAIDI,
CAST (DATVR as VARCHAR2(500)) AS DATVR,
CAST (DATZ as VARCHAR2(500)) AS DATZ,
CAST (DATE_PHOTO as DATE) AS DATE_PHOTO,
CAST (IDDPR as VARCHAR2(500)) AS IDDPR,
CAST (ISE as CHAR(5)) AS ISE,
CAST (OBSLU as VARCHAR2(500)) AS OBSLU,
CAST (CRSRC as VARCHAR2(500)) AS CRSRC,
CAST (DJOTH as VARCHAR2(500)) AS DJOTH,
CAST (DJAVI as VARCHAR2(500)) AS DJAVI,
CAST (DJ_TC as VARCHAR2(500)) AS DJ_TC,
CAST (DJOWF as VARCHAR2(500)) AS DJOWF,
CAST (DJCFI as VARCHAR2(500)) AS DJCFI,
CAST (DJ_LN as VARCHAR2(500)) AS DJ_LN,
CAST (DJ_FH as VARCHAR2(500)) AS DJ_FH,
CAST (DJ_CP as VARCHAR2(500)) AS DJ_CP,
CAST (CHORN as VARCHAR2(500)) AS CHORN,
CAST (CRISK_KL as VARCHAR2(1)) AS CRISK_KL,
CAST (BC as NUMBER(22)) AS BC,
CAST (SPMRK as VARCHAR2(500)) AS SPMRK,
CAST (K013 as VARCHAR2(500)) AS K013,
CAST (KODID as VARCHAR2(500)) AS KODID,
CAST (COUNTRY as NUMBER(22)) AS COUNTRY,
CAST (MS_FS as VARCHAR2(500)) AS MS_FS,
CAST (MS_VD as VARCHAR2(500)) AS MS_VD,
CAST (MS_GR as VARCHAR2(500)) AS MS_GR,
CAST (LIM_KASS as NUMBER(22)) AS LIM_KASS,
CAST (LIM as NUMBER(22)) AS LIM,
CAST (LICO as VARCHAR2(500)) AS LICO,
CAST (UADR as VARCHAR2(500)) AS UADR,
CAST (MOB01 as VARCHAR2(500)) AS MOB01,
CAST (MOB02 as VARCHAR2(500)) AS MOB02,
CAST (MOB03 as VARCHAR2(500)) AS MOB03,
CAST (SUBS as VARCHAR2(500)) AS SUBS,
CAST (K050 as CHAR(3)) AS K050,
CAST (DEATH as VARCHAR2(500)) AS DEATH,
CAST (NO_PHONE as NUMBER(22)) AS NO_PHONE,
CAST (NSMCV as VARCHAR2(500)) AS NSMCV,
CAST (NSMCC as VARCHAR2(500)) AS NSMCC,
CAST (NSMCT as VARCHAR2(500)) AS NSMCT,
CAST (NOTES as VARCHAR2(140)) AS NOTES,
CAST (SAMZ as VARCHAR2(500)) AS SAMZ,
CAST (OREP as VARCHAR2(500)) AS OREP,
CAST (OVIFS as VARCHAR2(500)) AS OVIFS,
CAST (AF6 as VARCHAR2(500)) AS AF6,
CAST (FSKRK as VARCHAR2(500)) AS FSKRK,
CAST (FSOMD as VARCHAR2(500)) AS FSOMD,
CAST (FSVED as VARCHAR2(500)) AS FSVED,
CAST (FSZPD as VARCHAR2(500)) AS FSZPD,
CAST (FSPOR as VARCHAR2(500)) AS FSPOR,
CAST (FSRKZ as VARCHAR2(500)) AS FSRKZ,
CAST (FSZOP as VARCHAR2(500)) AS FSZOP,
CAST (FSKPK as VARCHAR2(500)) AS FSKPK,
CAST (FSKPR as VARCHAR2(500)) AS FSKPR,
CAST (FSDIB as VARCHAR2(500)) AS FSDIB,
CAST (FSCP as VARCHAR2(500)) AS FSCP,
CAST (FSVLZ as VARCHAR2(500)) AS FSVLZ,
CAST (FSVLA as VARCHAR2(500)) AS FSVLA,
CAST (FSVLN as VARCHAR2(500)) AS FSVLN,
CAST (FSVLO as VARCHAR2(500)) AS FSVLO,
CAST (FSSST as VARCHAR2(500)) AS FSSST,
CAST (FSSOD as VARCHAR2(500)) AS FSSOD,
CAST (FSVSN as VARCHAR2(500)) AS FSVSN,
CAST (DOV_P as VARCHAR2(500)) AS DOV_P,
CAST (DOV_A as VARCHAR2(500)) AS DOV_A,
CAST (DOV_F as VARCHAR2(500)) AS DOV_F,
CAST (NMKV as VARCHAR2(70)) AS NMKV,
CAST (SN_GC as VARCHAR2(500)) AS SN_GC,
CAST (NMKK as VARCHAR2(38)) AS NMKK,
CAST (PRINSIDER as NUMBER(22)) AS PRINSIDER,
CAST (NOTESEC as VARCHAR2(256)) AS NOTESEC,
CAST (MB as CHAR(1)) AS MB,
CAST (PUBLP as VARCHAR2(500)) AS PUBLP,
CAST (WORKB as VARCHAR2(500)) AS WORKB,
CAST (C_REG as NUMBER(22)) AS C_REG,
CAST (C_DST as NUMBER(22)) AS C_DST,
CAST (RGADM as VARCHAR2(30)) AS RGADM,
CAST (RGTAX as VARCHAR2(30)) AS RGTAX,
CAST (DATEA as DATE) AS DATEA,
CAST (DATET as DATE) AS DATET,
CAST (RNKP as NUMBER(22)) AS RNKP,
CAST (CIGPO as VARCHAR2(500)) AS CIGPO,
CAST (COUNTRY_NAME as VARCHAR2(70)) AS COUNTRY_NAME,
CAST (TARIF as VARCHAR2(500)) AS TARIF,
CAST (AINAB as VARCHAR2(500)) AS AINAB,
CAST (TGR as NUMBER(22)) AS TGR,
CAST (CUSTTYPE as NUMBER(22)) AS CUSTTYPE,
CAST (RIZIK as VARCHAR2(500)) AS RIZIK,
CAST (SNSDR as VARCHAR2(500)) AS SNSDR,
CAST (IDPIB as VARCHAR2(500)) AS IDPIB,
CAST (FS as CHAR(2)) AS FS,
CAST (SED as CHAR(4)) AS SED,
CAST (DJER as VARCHAR2(500)) AS DJER,
CAST (CODCAGENT as NUMBER(22)) AS CODCAGENT,
CAST (SUTD as VARCHAR2(500)) AS SUTD,
CAST (RVDBC as VARCHAR2(500)) AS RVDBC,
CAST (RVIBA as VARCHAR2(500)) AS RVIBA,
CAST (RVIDT as VARCHAR2(500)) AS RVIDT,
CAST (RV_XA as VARCHAR2(500)) AS RV_XA,
CAST (RVIBR as VARCHAR2(500)) AS RVIBR,
CAST (RVIBB as VARCHAR2(500)) AS RVIBB,
CAST (RVRNK as VARCHAR2(500)) AS RVRNK,
CAST (RVPH1 as VARCHAR2(500)) AS RVPH1,
CAST (RVPH2 as VARCHAR2(500)) AS RVPH2,
CAST (RVPH3 as VARCHAR2(500)) AS RVPH3,
CAST (SAB as VARCHAR2(6)) AS SAB,
CAST (VIP_ACCOUNT_MANAGER as VARCHAR2(500)) AS VIP_ACCOUNT_MANAGER
FROM
(
    select (select changenumber from imp_object_mfo where object_name = 'CLIENTFO2' and kf = c.kf) as changenumber
    ,last_name
    ,first_name
    ,middle_name
    ,bday
    ,gr
    ,passp
    ,ser
    ,numdoc
    ,pdate
    ,organ
    ,passp_expire_to
    ,passp_to_bank
    ,c.kf
    ,rnk
    ,okpo
    ,cust_status
    ,cust_active
    ,telm
    ,telw
    ,teld
    ,teladd
    ,email
    ,adr_post_country
    ,adr_post_domain
    ,adr_post_region
    ,adr_post_loc
    ,adr_post_adr
    ,adr_post_zip
    ,adr_fact_country
    ,adr_fact_domain
    ,adr_fact_region
    ,adr_fact_loc
    ,adr_fact_adr
    ,adr_fact_zip
    ,adr_work_country
    ,adr_work_domain
    ,adr_work_region
    ,adr_work_loc
    ,adr_work_adr
    ,adr_work_zip
    ,branch
    ,negativ_status
    ,reestr_mob_bank
    ,reestr_inet_bank
    ,reestr_sms_bank
    ,month_income
    ,subject_role
    ,rezident
    ,merried
    ,emp_status
    ,subject_class
    ,insider
    ,sex
    ,vipk
    ,vip_fio_manager
    ,vip_phone_manager
    ,date_on
    ,date_off
    ,eddr_id
    ,actual_date
    ,iddpl
    ,bplace
    ,subsd
    ,subsn
    ,elt_n
    ,elt_d
    ,gcif
    ,nompdv
    ,nom_dog
    ,sw_rn
    ,y_elt
    ,adm
    ,fadr
    ,adr_alt
    ,busss
    ,pc_mf
    ,pc_z4
    ,pc_z3
    ,pc_z5
    ,pc_z2
    ,pc_z1
    ,agent
    ,pc_ss
    ,stmt
    ,vidkl
    ,ved
    ,tipa
    ,phkli
    ,af1_9
    ,iddpd
    ,daidi
    ,datvr
    ,datz
    ,date_photo
    ,iddpr
    ,ise
    ,obslu
    ,crsrc
    ,djoth
    ,djavi
    ,dj_tc
    ,djowf
    ,djcfi
    ,dj_ln
    ,dj_fh
    ,dj_cp
    ,chorn
    ,crisk_kl
    ,bc
    ,spmrk
    ,k013
    ,kodid
    ,country
    ,ms_fs
    ,ms_vd
    ,ms_gr
    ,lim_kass
    ,lim
    ,lico
    ,uadr
    ,mob01
    ,mob02
    ,mob03
    ,subs
    ,k050
    ,death
    ,no_phone
    ,nsmcv
    ,nsmcc
    ,nsmct
    ,notes
    ,samz
    ,orep
    ,ovifs
    ,af6
    ,fskrk
    ,fsomd
    ,fsved
    ,fszpd
    ,fspor
    ,fsrkz
    ,fszop
    ,fskpk
    ,fskpr
    ,fsdib
    ,fscp
    ,fsvlz
    ,fsvla
    ,fsvln
    ,fsvlo
    ,fssst
    ,fssod
    ,fsvsn
    ,dov_p
    ,dov_a
    ,dov_f
    ,nmkv
    ,sn_gc
    ,nmkk
    ,prinsider
    ,notesec
    ,mb
    ,publp
    ,workb
    ,c_reg
    ,c_dst
    ,rgadm
    ,rgtax
    ,datea
    ,datet
    ,rnkp
    ,cigpo
    ,country_name
    ,tarif
    ,ainab
    ,tgr
    ,custtype
    ,rizik
    ,snsdr
    ,idpib
    ,fs
    ,sed
    ,djer
    ,codcagent
    ,sutd
    ,rvdbc
    ,rviba
    ,rvidt
    ,rv_xa
    ,rvibr
    ,rvibb
    ,rvrnk
    ,rvph1
    ,rvph2
    ,rvph3
    ,sab
    ,vip_account_manager
    from bars_dm.customers_plt c
    where c.per_id = bars_dm.dm_import.get_period_id('MONTH', trunc(sysdate))
    and bars_intgr.xrm_import.get_import_mode('CLIENTFO2') = 'FULL'
    union all
    select
    changenumber
    ,last_name
    ,first_name
    ,middle_name
    ,bday
    ,gr
    ,passp
    ,ser
    ,numdoc
    ,pdate
    ,organ
    ,passp_expire_to
    ,passp_to_bank
    ,kf
    ,rnk
    ,okpo
    ,cust_status
    ,cust_active
    ,telm
    ,telw
    ,teld
    ,teladd
    ,email
    ,adr_post_country
    ,adr_post_domain
    ,adr_post_region
    ,adr_post_loc
    ,adr_post_adr
    ,adr_post_zip
    ,adr_fact_country
    ,adr_fact_domain
    ,adr_fact_region
    ,adr_fact_loc
    ,adr_fact_adr
    ,adr_fact_zip
    ,adr_work_country
    ,adr_work_domain
    ,adr_work_region
    ,adr_work_loc
    ,adr_work_adr
    ,adr_work_zip
    ,branch
    ,negativ_status
    ,reestr_mob_bank
    ,reestr_inet_bank
    ,reestr_sms_bank
    ,month_income
    ,subject_role
    ,rezident
    ,merried
    ,emp_status
    ,subject_class
    ,insider
    ,sex
    ,vipk
    ,vip_fio_manager
    ,vip_phone_manager
    ,date_on
    ,date_off
    ,eddr_id
    ,idcard_valid_date
    ,iddpl
    ,bplace
    ,subsd
    ,subsn
    ,elt_n
    ,elt_d
    ,gcif
    ,nompdv
    ,nom_dog
    ,sw_rn
    ,y_elt
    ,adm
    ,fadr
    ,adr_alt
    ,busss
    ,pc_mf
    ,pc_z4
    ,pc_z3
    ,pc_z5
    ,pc_z2
    ,pc_z1
    ,agent
    ,pc_ss
    ,stmt
    ,vidkl
    ,ved
    ,tipa
    ,phkli
    ,af1_9
    ,iddpd
    ,daidi
    ,datvr
    ,datz
    ,date_photo
    ,iddpr
    ,ise
    ,obslu
    ,crsrc
    ,djoth
    ,djavi
    ,dj_tc
    ,djowf
    ,djcfi
    ,dj_ln
    ,dj_fh
    ,dj_cp
    ,chorn
    ,crisk_kl
    ,bc
    ,spmrk
    ,k013
    ,kodid
    ,country
    ,ms_fs
    ,ms_vd
    ,ms_gr
    ,lim_kass
    ,lim
    ,lico
    ,uadr
    ,mob01
    ,mob02
    ,mob03
    ,subs
    ,k050
    ,death
    ,no_phone
    ,nsmcv
    ,nsmcc
    ,nsmct
    ,notes
    ,samz
    ,orep
    ,ovifs
    ,af6
    ,fskrk
    ,fsomd
    ,fsved
    ,fszpd
    ,fspor
    ,fsrkz
    ,fszop
    ,fskpk
    ,fskpr
    ,fsdib
    ,fscp
    ,fsvlz
    ,fsvla
    ,fsvln
    ,fsvlo
    ,fssst
    ,fssod
    ,fsvsn
    ,dov_p
    ,dov_a
    ,dov_f
    ,nmkv
    ,sn_gc
    ,nmkk
    ,prinsider
    ,notesec
    ,mb
    ,publp
    ,workb
    ,c_reg
    ,c_dst
    ,rgadm
    ,rgtax
    ,datea
    ,datet
    ,rnkp
    ,cigpo
    ,country_name
    ,tarif
    ,ainab
    ,tgr
    ,custtype
    ,rizik
    ,snsdr
    ,idpib
    ,fs
    ,sed
    ,djer
    ,codcagent
    ,sutd
    ,rvdbc
    ,rviba
    ,rvidt
    ,rv_xa
    ,rvibr
    ,rvibb
    ,rvrnk
    ,rvph1
    ,rvph2
    ,rvph3
    ,sab
    ,vip_account_manager
    from bars_intgr.clientfo2
    where bars_intgr.xrm_import.get_import_mode('CLIENTFO2') = 'DELTA'
);
