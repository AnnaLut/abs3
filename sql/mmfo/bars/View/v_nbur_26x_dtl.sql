PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_26X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_26X_dtl ***

create or replace view v_nbur_26X_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.T020
     , p.R020
     , p.R011
     , p.R013
     , p.R030
     , p.K040
     , p.Q001
     , p.K020
     , p.K021
     , p.K180
     , p.K190
     , p.S181
     , p.S245
     , p.S580
     , p.F033
     , p.T070
     , p.T071
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_F26X p
       join NBUR_REF_FILES f on (f.FILE_CODE = '26X')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by ekp, k020, r020, t020, acc_num, kv;
   
comment on table V_NBUR_26X_DTL is 'Детальний протокол файлу 26X';
comment on column V_NBUR_26X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_26X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_26X_DTL.KU is 'Код регіону';
comment on column V_NBUR_26X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_26X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_26X_DTL.EKP    is 'Код показника';
comment on column V_NBUR_26X_DTL.T020   is 'Код елементу даних за рахунком';
comment on column V_NBUR_26X_DTL.R020   is 'Номер баланс./позабаланс. рахунку';
comment on column V_NBUR_26X_DTL.R011   is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_26X_DTL.R013   is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column V_NBUR_26X_DTL.R030   is 'Код валюти';
comment on column V_NBUR_26X_DTL.K040   is 'Код країни учасника банку';
comment on column V_NBUR_26X_DTL.Q001   is 'Назва банку-резидента/банку-нерезидента';
comment on column V_NBUR_26X_DTL.K020   is 'Код учаснику банку';
comment on column V_NBUR_26X_DTL.K021   is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column V_NBUR_26X_DTL.K180   is 'Код належності банку до інвестиційного класу';
comment on column V_NBUR_26X_DTL.K190   is 'Код рівня надійності';
comment on column V_NBUR_26X_DTL.S181   is 'Код початкового строку погашення';
comment on column V_NBUR_26X_DTL.S245   is 'Код узагальненого кінцевого строку погашення';
comment on column V_NBUR_26X_DTL.S580   is 'Код розподілу активів за групами ризик';
comment on column V_NBUR_26X_DTL.F033   is 'Код ознаки обтяженості коштів';
comment on column V_NBUR_26X_DTL.T070   is 'Сума в національній валюті (грн.екв.)';
comment on column V_NBUR_26X_DTL.T071   is 'Сума в іноземній валюті';
comment on column V_NBUR_26X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_26X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_26X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_26X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_26X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_26X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_26X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_26X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 