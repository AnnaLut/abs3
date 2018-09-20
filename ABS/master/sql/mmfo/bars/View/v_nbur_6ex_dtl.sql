PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6ex_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_6ex_dtl ***

create or replace view v_nbur_6ex_dtl as
  select p.REPORT_DATE
         , p.KF
         , V.VERSION_ID
         , p.NBUC
         , p.EKP || p.R030 as FIELD_CODE
         , p.EKP
         , p.R030
         , p.T100
         , p.T100_PCT
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
         , null as REF
         , p.BRANCH
    from nbur_log_f6ex p
         join NBUR_REF_FILES f on ( f.FILE_CODE = '#6E' )
         join NBUR_LST_FILES v on (
                                    v.REPORT_DATE = p.REPORT_DATE
                                    and v.KF = p.KF
                                    and v.FILE_ID     = f.ID
				    AND v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
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
    where ekp not in (select ekp from bars.nbur_dct_f6ex_ekp where constant_value =0);

comment on table V_NBUR_6EX_DTL is 'Детальний протокол файлу 6EX';
comment on column V_NBUR_6EX_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_6EX_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_6EX_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_6EX_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_6EX_DTL.FIELD_CODE is 'Код показника';
comment on column V_NBUR_6EX_DTL.EKP is 'Код показника';
comment on column V_NBUR_6EX_DTL.R030 is 'Валюта';
comment on column V_NBUR_6EX_DTL.T100 is 'Сума/процент';
comment on column V_NBUR_6EX_DTL.T100_PCT is 'Процент урахування у агрегованому показнику';
comment on column V_NBUR_6EX_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_6EX_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_6EX_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_6EX_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_6EX_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_6EX_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_6EX_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_6EX_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_6EX_DTL.ND is 'Ід. договору';
comment on column V_NBUR_6EX_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_6EX_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_6EX_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_6EX_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_6EX_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6ex_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 