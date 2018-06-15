PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_73x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_73x_dtl ***

create or replace view v_nbur_73x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.VERSION_ID
         , p.Field_Code --Код для связки с мастер-представлением
         , SUBSTR(p.FIELD_CODE, 1, 6) as EKP --Код показника
         , p.NBUC
         , SUBSTR(p.FIELD_CODE, 7, 3) as R030 --Код валюти
         , p.FIELD_VALUE as T100
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
    from NBUR_DETAIL_PROTOCOLS_ARCH p
         join NBUR_REF_FILES f on (f.FILE_CODE = p.REPORT_CODE )
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
   where p.REPORT_CODE = '73X' --Берем инофрмацию по нашим файлам
         and v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table V_NBUR_73X_DTL is 'Детальний протокол файлу 73X';
comment on column V_NBUR_73X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_73X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_73X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_73X_DTL.FIELD_CODE is 'Зведений код показника';
comment on column V_NBUR_73X_DTL.EKP is 'Код показника';
comment on column V_NBUR_73X_DTL.NBUC is 'Код області управління розрізу юридичної особи';
comment on column V_NBUR_73X_DTL.R030 is 'Код валюти';
comment on column V_NBUR_73X_DTL.T100 is 'Сума в іноземній валюті/Кількість ПОВ';
comment on column V_NBUR_73X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_73X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_73X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_73X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_73X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_73X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_73X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_73X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_73X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_73X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_73X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_73X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_73X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_73X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_73x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 