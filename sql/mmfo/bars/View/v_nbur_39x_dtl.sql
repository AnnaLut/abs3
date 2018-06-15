PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_39x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_39x_dtl ***

create or replace view v_nbur_39x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.VERSION_ID
         , substr(p.FIELD_CODE, 2) as FIELD_CODE --Код для связки с мастер-представлением
         , SUBSTR(p.FIELD_CODE, 2, 6) as EKP --Код показника
         , p.NBUC
         , SUBSTR(p.FIELD_CODE, 8, 3) as R030 --Код валюти
         , p.FIELD_VALUE as T071 --Сума в iноземнiй валютi
         , p1.FIELD_VALUE as T075 --Середньозважений курс
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
         --Приклеиваем справа данные по курсам
         left  join NBUR_DETAIL_PROTOCOLS_ARCH p1 on (p.report_date = p1.report_date)
                                                     and (p.kf = p1.kf)
                                                     and (p.version_id = p1.version_id)
                                                     and (p.report_code = p1.report_code)
                                                     and (p.nbuc = p1.nbuc)
                                                     and (p.ref = p1.ref)
                                                     and (p1.field_code like '4%')
   where p.REPORT_CODE = '39X' --Берем инофрмацию по нашим файлам
         and p.field_code like '1%' --Отбираем как основу данные по суммам
         and v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
;
comment on table V_NBUR_39X_DTL is 'Детальний протокол файлу #39';
comment on column V_NBUR_39X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_39X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_39X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_39X_DTL.FIELD_CODE is 'Код показника';
comment on column V_NBUR_39X_DTL.EKP is 'A39001 - Купівля, A39002 - Продаж';
comment on column V_NBUR_39X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_39X_DTL.R030 is 'Код валюти';
comment on column V_NBUR_39X_DTL.T071 is 'Сума в iноземнiй валютi';
comment on column V_NBUR_39X_DTL.T075 is 'Середньозважений курс';
comment on column V_NBUR_39X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_39X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_39X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_39X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_39X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_39X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_39X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_39X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_39X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_39X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_39X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_39X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_39X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_39X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_39x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 