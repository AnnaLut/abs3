create or replace force view V_EBKC_LEGAL_PERSON_REL
( KF, RNK, REL_RNK, NAME, K014, K040, REGIONCODE, K110, K051, K070, OKPO, ISOKPOEXCLUSION, TELEPHONE
, EMAIL, K080, ADDRESS, DOCTYPE, DOCSER, DOCNUMBER, DOCISSUEDATE, DOCORGAN, ACTUALDATE, EDDRID, BIRTHDAY
, BIRTHPLACE, SEX, NOTES, RELSIGN, CUST_ID
) AS 
  select c.KF,                                                 -- Код РУ (код МФО)
       case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(c.RNK/100)
         else c.RNK
       end as RNK,                                                   --Реєстр. №
       decode(r.rel_intext, 1, r.rel_rnk, to_number(null))
         as rel_rnk,                                       --РНК повязаної особи
       r.name,                                   --Назва або ПІБ повязаної особи
       r.custtype as k014,                                  --Тип клієнта (К014)
       to_char(r.country) as k040,                       --Країна клієнта (К040)
       r.region as regionCode,                          --Код Регіона
       r.ved  as k110,                                --Вид ек. діяльності(К110)
       r.sed  as k051,                             --Форма господарювання (К051)
       r.ise  as k070,                           --Інст. сектор економіки (К070)
       r.okpo,                                      --Ідент. Код / Код за ЕДРПОУ
       ( SELECT cw.VALUE FROM customerw cw
          WHERE cw.tag = 'EOKPO' AND r.rel_rnk = cw.rnk
       ) as isOkpoExclusion,                     -- Ознака виключення Ідент. Код
       r.tel  as telephone,                                            --Телефон
       r.email,                                                         --e-mail
       r.fs  as k080,                                   --Форма власності (K080)
       r.adr as address,                                                --Адреса
       r.doc_type   as docType,                                  --Тип документу
       r.doc_serial as docSer,                                 --Серія документу
       r.doc_number as docNumber,                              --Номер документу
       r.doc_date   as docIssueDate,                     --Дата видачі документу
       r.doc_issuer as docOrgan,                        --Місце видачі документу
       (select actual_date from person p1 where p1.rnk=r.rel_rnk)
         as actualDate,                                            --Дійсний до
       (select eddr_id from person p1 where p1.rnk=r.rel_rnk)
         as eddrId,                              --Унікальний номер запису ЄДДР
       r.birthday,                                             --Дата народження
       r.birthplace,                                          --Місце народження
       r.sex,                                                            --Стать
       '' as notes,                                        --Коментар (примітки)
       r.rel_id as relSign,                                --Ознака пов’язаності
       c.RNK as CUST_ID
 from CUSTOMER c
    , CORPS p
    , V_CUSTOMER_REL r
where c.custtype = 2
  and c.rnk = r.rnk
  and c.rnk = p.rnk;

show errors;

grant SELECT on V_EBKC_LEGAL_PERSON_REL to BARS_ACCESS_DEFROLE;
grant SELECT on V_EBKC_LEGAL_PERSON_REL to BARSREADER_ROLE;
