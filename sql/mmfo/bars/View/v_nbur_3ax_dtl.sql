PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3ax_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_3ax_dtl ***

create or replace view v_nbur_3ax_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP || p.KU || p.T020 || p.R020 || p.R011 
           || p.D020 || p.S180 || p.R030 || p.K030 as FIELD_CODE
         , p.EKP
         , p.KU
         , p.T020
         , p.R020
         , p.R011
         , p.D020
         , p.S180
         , p.R030
         , p.K030
         , p.T070
         , p.T090
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
    from NBUR_LOG_F3AX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '3AX' )
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

comment on table V_NBUR_3AX_DTL is 'Детальний протокол файлу 3AX';
comment on column V_NBUR_3AX_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_3AX_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_3AX_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_3AX_DTL.FIELD_CODE is 'Зведений код показника';
comment on column V_NBUR_3AX_DTL.EKP is 'Код показника';
comment on column V_NBUR_3AX_DTL.KU is 'Код території';
comment on column V_NBUR_3AX_DTL.T020 is 'Елемент рахунку';
comment on column V_NBUR_3AX_DTL.R020 is 'Номер рахунку';
comment on column V_NBUR_3AX_DTL.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_3AX_DTL.D020 is 'Код розподілу оборотів за рахунком';
comment on column V_NBUR_3AX_DTL.S180 is 'Код початкового строку погашення';
comment on column V_NBUR_3AX_DTL.R030 is 'Код валюти';
comment on column V_NBUR_3AX_DTL.K030 is 'Код резидентності';
comment on column V_NBUR_3AX_DTL.T070 is 'Сума';
comment on column V_NBUR_3AX_DTL.T090 is 'Розмір процентної ставки';
comment on column V_NBUR_3AX_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_3AX_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_3AX_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_3AX_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_3AX_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_3AX_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_3AX_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_3AX_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_3AX_DTL.ND is 'Ід. договору';
comment on column V_NBUR_3AX_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_3AX_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_3AX_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_3AX_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_3AX_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3ax_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 