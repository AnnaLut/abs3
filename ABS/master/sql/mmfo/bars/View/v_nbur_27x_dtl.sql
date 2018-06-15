PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_27x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_27x_dtl ***

create or replace view v_nbur_27x_dtl as
select p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , p.NBUC
       , p.FIELD_CODE
       , SUBSTR(p.FIELD_CODE, 7, 1) as F091
       , SUBSTR(p.FIELD_CODE, 8, 4) as R020
       , SUBSTR(p.FIELD_CODE, 12, 3) as R030
       , p.FIELD_VALUE
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
         join NBUR_REF_FILES f on ( f.FILE_CODE = p.REPORT_CODE )
         join NBUR_LST_FILES v on (
                                    v.REPORT_DATE = p.REPORT_DATE
                                    and v.KF = p.KF
                                    and v.VERSION_ID  = p.VERSION_ID
                                    and v.FILE_ID     = f.ID
                                  )
         left join V_NBUR_DM_CUSTOMERS c on (
                                              p.REPORT_DATE = c.REPORT_DATE
                                              and p.KF = c.KF
                                              and p.CUST_ID    = c.CUST_ID )
         left join V_NBUR_DM_AGREEMENTS a on (
                                               p.REPORT_DATE = a.REPORT_DATE
                                               and p.KF          = a.KF
                                               and p.nd          = a.AGRM_ID
                                             )
   where p.REPORT_CODE = '27X'
     and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
comment on table V_NBUR_27X_DTL is 'Детальний протокол файлу 27X';
comment on column V_NBUR_27X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_27X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_27X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_27X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_27X_DTL.FIELD_CODE is 'Код показника';
comment on column V_NBUR_27X_DTL.F091 is 'Код операції';
comment on column V_NBUR_27X_DTL.R020 is 'Балансовий рахунок';
comment on column V_NBUR_27X_DTL.R030 is 'Код валюти';
comment on column V_NBUR_27X_DTL.FIELD_VALUE is 'Значення показника';
comment on column V_NBUR_27X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_27X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_27X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_27X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_27X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_27X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_27X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_27X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_27X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_27X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_27X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_27X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_27X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_27X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_27x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 