CREATE OR REPLACE VIEW BARS.V_EBKC_QUEUE_UPDCARD_PRIVATE
as
select v.kf,
       case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(v.RNK/100)
         else v.RNK
       end as RNK,
       v.lastchangedt,
       v.date_off        as dateOff,
       v.date_on         as dateOn,
       v.nmk             as fullName,
       v.nmkv            as fullNameInternational,
       v.nmkk            as fullNameAbbreviated,
       v.k014,
       v.country         as k040,
       v.tgr             as buildStateRegister,
       v.okpo,
       v.OKPO_EXCLUSION  as isOkpoExclusion,
       v.prinsider       as k060,
       v.k010,
       v.ise             as k070,
       v.fs              as k080,
       v.ved             as k110,
       v.k050,
       v.sed             as k051,
       v.au_zip          as la_index,
       v.au_terid        as la_territoryCode,
       v.au_region       as la_region,
       v.au_area         as la_area,
       v.au_locality     as la_settlement,
       v.au_adress       as la_street,
       v.au_home         as la_houseNumber,
       v.au_homepart     as la_sectionNumber,
       v.au_room         as la_apartmentsNumber,
       v.au_comm         as la_notes,
       v.af_zip          as aa_index,
       v.af_terid        as aa_territoryCode,
       v.af_region       as aa_region,
       v.af_area         as aa_area,
       v.af_locality     as aa_settlement,
       v.af_adress       as aa_street,
       v.af_home         as aa_houseNumber,
       v.af_homepart     as aa_sectionNumber,
       v.af_room         as aa_apartmentsNumber,
       v.af_comm         as aa_notes,
       v.c_reg           as regionalPi,
       v.c_dst           as areaPi,
       v.adm             as admRegAuthority,
       v.datea           as admRegDate,
       v.datet           as piRegDate,
       v.rgadm           as admRegNumber,
       v.rgtax           as piRegNumber,
       v.pcod_k050       as tp_k050,
       v.passp           as docType,
       v.ser             as docSer,
       v.numdoc          as docNumber,
       v.organ           as docOrgan,
       v.pdate           as docIssueDate,
       v.actual_date     as actualDate,
       v.eddr_id         as eddrid,
       v.bday            as birthDate,
       v.bplace          as birthPlace,
       v.sex,
       v.cellphone       as mobilePhone,
       v.crisk           as borrowerClass,
       v.mb              as smallBusinessBelonging,
       v.k013,
       v.ms_gr           as groupAffiliation,
       v.email,
       v.cigpo           as employmentStatus,
       v.RNK             as CUST_ID
  from V_EBKC_PRIVATE_ENT v
 where exists ( select null from ebkc_queue_updatecard lp 
                 where lp.rnk = v.rnk
                   and lp.cust_type = 'P'
                   and lp.status=0 );

show err

grant select on BARS.V_EBKC_QUEUE_UPDCARD_PRIVATE to BARS_ACCESS_DEFROLE;
