PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_c5x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_c5x_dtl ***

create or replace view v_nbur_c5x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP || p.A012 || p.T020 || p.R020 || p.R011 || p.R013 || p.R030_1 
           || p.R030_2 || p.R017 || p.K077 || p.S245 || p.S580 as FIELD_CODE
         , p.EKP
         , p.A012
         , p.T020
         , p.R020
         , p.R011
         , p.R013
         , p.R030_1
         , p.R030_2
         , p.R017
         , p.K077
         , p.S245
         , p.S580
         , p.T070
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.MATURITY_DATE
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.ND
         , a.AGRM_NUM
         , a.BEG_DT
         , a.END_DT
         , p.REF
         , p.BRANCH
    from NBUR_LOG_FC5X p
         join NBUR_REF_FILES f on (f.FILE_CODE = 'C5X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
         left  join V_NBUR_DM_AGREEMENTS a on (p.REPORT_DATE = a.REPORT_DATE)
                                              and (p.KF = a.KF)
                                              and (p.nd = a.AGRM_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table V_NBUR_C5X_DTL is 'Детальний протокол файлу C5X';
comment on column V_NBUR_C5X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_C5X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_C5X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_C5X_DTL.FIELD_CODE is 'Зведений код показника';
comment on column V_NBUR_C5X_DTL.EKP is 'Код показника';
comment on column V_NBUR_C5X_DTL.A012 is 'Код місцезнаходження території';
comment on column V_NBUR_C5X_DTL.T020 is 'Код елементу даних за рахунком';
comment on column V_NBUR_C5X_DTL.R020 is 'Номер баланс./позабаланс. рахунку';
comment on column V_NBUR_C5X_DTL.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_C5X_DTL.R013 is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column V_NBUR_C5X_DTL.R030_1 is 'Код валюти';
comment on column V_NBUR_C5X_DTL.R030_2 is 'Код валюти індексації';
comment on column V_NBUR_C5X_DTL.R017 is 'Код розподілу фінансових інструментів щодо індексації';
comment on column V_NBUR_C5X_DTL.K077 is 'Код агрегованого сектору економіки';
comment on column V_NBUR_C5X_DTL.S245 is 'Код узагальненого кінцевого строку погашення';
comment on column V_NBUR_C5X_DTL.S580 is 'Код розподілу активів за групами ризику';
comment on column V_NBUR_C5X_DTL.T070 is 'Сума';
comment on column V_NBUR_C5X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_C5X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_C5X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_C5X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_C5X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_C5X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_C5X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_C5X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_C5X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_C5X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_C5X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_C5X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_C5X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_C5X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_c5x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 