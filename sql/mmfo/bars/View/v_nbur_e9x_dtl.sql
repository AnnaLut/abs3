PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_e9x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_e9x_dtl ***

create or replace view v_nbur_e9x_dtl as
SELECT REPORT_DATE
         , KF
         , VERSION_ID
         , FIELD_CODE
         ,   (case when ekp_2='1' and ekp_8='804' and ekp_10='804'   then 'AE9001'
                  when ekp_2='1' and ekp_8!='804' and ekp_10='804'  then 'AE9002'
                  when ekp_2='1' and ekp_8='804' and ekp_10!='804'  then 'AE9003'
                  when ekp_2='2' and ekp_8!='804' and ekp_10='804'
                                 and d060_2 is not null             then 'AE9004'
                  when ekp_2='2' and ekp_8!='804' and ekp_10='804'  then 'AE9005'
                  when ekp_2='2' and ekp_8='804' and ekp_10!='804'
                                 and d060_2 is not null             then 'AE9006'
                  when ekp_2='2' and ekp_8='804' and ekp_10!='804'  then 'AE9007'
                  when ekp_2='0'                                    then 'AE9008'
                  else 'AE9000'
               end)  as ekp,
             ekp_3   as d060_1,
             ekp_6   as k020,
             ekp_5   as k021,
             ekp_4   as f001,
             decode(ekp_7,'000','#',ekp_7)   as r030,
             decode(ekp_8,'000','#',ekp_8)             as k040_1,
             decode(ekp_9,'000','#',ltrim(ekp_9,'0'))  as ku_1,
             decode(ekp_10,'000','#',ekp_10)             as k040_2,
             decode(ekp_11,'000','#',ltrim(ekp_11,'0'))  as ku_2,
             nvl(t071,0)   as  t071,
             nvl(t080,0)   as  t080,
             decode(d060_2, null,'#', d060_2)  d060_2,
             q001
         , DESCRIPTION
         , ACC_ID
         , ACC_NUM
         , KV
         , MATURITY_DATE
         , CUST_ID
         , CUST_CODE
         , CUST_NAME
         , nd
         , REF
         , BRANCH
   from (  
select  report_date
         , kf
         , version_id
         , ekp_2    as field_code
         , substr(ekp_2,1,1) ekp_2
         , substr(ekp_2,2,2) ekp_3
         , substr(ekp_2,4,1) ekp_4
         , substr(ekp_2,5,1) ekp_5
         , substr(ekp_2,6,10) ekp_6
         , substr(ekp_2,16,3) ekp_7
         , substr(ekp_2,19,3) ekp_8
         , substr(ekp_2,22,3) ekp_9
         , substr(ekp_2,25,3) ekp_10
         , substr(ekp_2,28,3) ekp_11
         , t071
         , t080
         , d060_2
         , q001
         , DESCRIPTION
         , ACC_ID
         , ACC_NUM
         , KV
         , MATURITY_DATE
         , CUST_ID
         , CUST_CODE
         , CUST_NAME
         , nd
         , REF
         , BRANCH
          from ( SELECT p.REPORT_DATE
                         , p.KF
                         , p.VERSION_ID
                         , substr(p.field_code,1,1) ekp_1
                         , substr(p.field_code,2) ekp_2
                         , p.field_value
                         , p.DESCRIPTION
                         , p.ACC_ID
                         , p.ACC_NUM
                         , p.KV
                         , p.MATURITY_DATE
                         , p.CUST_ID
                         , c.CUST_CODE
                         , c.CUST_NAME
                         , p.nd
                         , p.REF
                         , p.BRANCH
                   FROM NBUR_DETAIL_PROTOCOLS_ARCH p
                   JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
                   JOIN NBUR_LST_FILES v ON    (v.REPORT_DATE = p.REPORT_DATE)
                                           AND (v.KF = p.KF)
                                           AND (v.VERSION_ID = p.VERSION_ID)
                                           AND (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c ON    (p.REPORT_DATE = c.REPORT_DATE)
                                           and (p.KF = c.KF)
                                           and (p.CUST_ID    = c.CUST_ID)
                  WHERE p.REPORT_CODE = 'E9X'
                    and f.FILE_FMT  = 'XML'
                    AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
               )
                pivot
               ( max(trim(field_value))
                    for ekp_1 in ( '1' as T071, '3' as T080,
                                   '8' as D060_2, '9' as Q001 )
               )
        )
  order by field_code;

comment on table v_nbur_e9x_DTL is 'Детальний протокол файлу E9X';
comment on column v_nbur_e9x_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_e9x_DTL.KF is 'Код фiлiалу (МФО)';
comment on column v_nbur_e9x_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_e9x_DTL.FIELD_CODE is 'Зведений код показника';
comment on column v_nbur_e9x_DTL.EKP is 'Код показника';
comment on column v_nbur_e9x_DTL.D060_1 is 'Код системи переказу коштів';
comment on column v_nbur_e9x_DTL.K020 is 'Код відправника/отримувача';
comment on column v_nbur_e9x_DTL.K021 is 'Код ознаки ідентифікаційного коду';
comment on column v_nbur_e9x_DTL.F001 is 'Умовний код учасників';
comment on column v_nbur_e9x_DTL.R030 is 'Код валюти';
comment on column v_nbur_e9x_DTL.K040_1 is 'Код країни установи-відправника';
comment on column v_nbur_e9x_DTL.KU_1 is 'Область відправника';
comment on column v_nbur_e9x_DTL.K040_2 is 'Код країни установи-отримувача';
comment on column v_nbur_e9x_DTL.KU_2 is 'Область отримувача';
comment on column v_nbur_e9x_DTL.T071 is 'Сума';
comment on column v_nbur_e9x_DTL.T080 is 'Кількість';
comment on column v_nbur_e9x_DTL.D060_2 is 'Код міжнародної системи переказу коштів';
comment on column v_nbur_e9x_DTL.Q001 is 'Найменування банку кореспондента-нерезидента';
comment on column v_nbur_e9x_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column v_nbur_e9x_DTL.ACC_ID is 'Ід. рахунка';
comment on column v_nbur_e9x_DTL.ACC_NUM is 'Номер рахунка';
comment on column v_nbur_e9x_DTL.KV is 'Ід. валюти';
comment on column v_nbur_e9x_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column v_nbur_e9x_DTL.CUST_ID is 'Ід. клієнта';
comment on column v_nbur_e9x_DTL.CUST_CODE is 'Код клієнта';
comment on column v_nbur_e9x_DTL.CUST_NAME is 'Назва клієнта';
comment on column v_nbur_e9x_DTL.ND is 'Ід. договору';
comment on column v_nbur_e9x_DTL.REF is 'Ід. платіжного документа';
comment on column v_nbur_e9x_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_e9x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
