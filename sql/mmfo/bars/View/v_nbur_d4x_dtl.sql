PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_d4x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_d4x_dtl ***

create or replace view v_nbur_d4x_dtl as
select p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , p.NBUC
       , p.EKP || p.R030 || p.F025 || p.B010 as FIELD_CODE
       , p.EKP
       , p.R030
       , p.F025
       , p.B010
       , p.Q006
       , p.T071
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
    from NBUR_LOG_FD4X p
         join NBUR_REF_FILES f on ( f.FILE_CODE = 'D4PX' )
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
   where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
comment on table V_NBUR_D4X_DTL is 'Детальний протокол файлу D4X';
comment on column V_NBUR_D4X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_D4X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_D4X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_D4X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_D4X_DTL.FIELD_CODE is 'Код показника';
comment on column V_NBUR_D4X_DTL.EKP is 'Код показника';
comment on column V_NBUR_D4X_DTL.R030 is 'Валюта';
comment on column V_NBUR_D4X_DTL.F025 is 'Код змісту операції';
comment on column V_NBUR_D4X_DTL.B010 is 'Код іноземного банку';
comment on column V_NBUR_D4X_DTL.Q006 is 'Примітка';
comment on column V_NBUR_D4X_DTL.T071 is 'Сума';
comment on column V_NBUR_D4X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_D4X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_D4X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_D4X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_D4X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_D4X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_D4X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_D4X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_D4X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_D4X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_D4X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_D4X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_D4X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_D4X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_d4x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 