PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_1px_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_1px_dtl ***

create or replace view v_nbur_1px_dtl as
  select p.REPORT_DATE
         , p.KF
         , V.VERSION_ID
         , p.NBUC
         , p.Q003_1 as FIELD_CODE
         , p.EKP
         , p.K040_1
         , p.RCBNK_B010
         , p.RCBNK_NAME
         , p.K040_2
         , p.R030
         , p.R020
         , p.R040
         , p.T023
         , p.RCUKRU_GLB_2
         , p.K018
         , p.K020
         , p.Q001
         , p.RCUKRU_GLB_1
         , p.Q003_1
         , p.Q004
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
    from nbur_log_f1px p
         join NBUR_REF_FILES f on ( f.FILE_CODE = '1PX' )
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
                                             );

comment on table V_NBUR_1PX_DTL is 'Детальний протокол файлу 1PX';
comment on column V_NBUR_1PX_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_1PX_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_1PX_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_1PX_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_1PX_DTL.FIELD_CODE is 'Код показника';
comment on column V_NBUR_1PX_DTL.EKP is 'Код показника';
comment on column V_NBUR_1PX_DTL.K040_1 is 'Код країни банка-кореспондента';
comment on column V_NBUR_1PX_DTL.RCBNK_B010	is 'Код іноземного банку';
comment on column V_NBUR_1PX_DTL.RCBNK_NAME	is 'Назва іноземного банку';
comment on column V_NBUR_1PX_DTL.K040_2 is 'Код країни-платника/одержувача платежу';
comment on column V_NBUR_1PX_DTL.R030 is 'Валюта';
comment on column V_NBUR_1PX_DTL.R020 is 'План рахунків';
comment on column V_NBUR_1PX_DTL.R040 is 'Статті платіжного баланса';
comment on column V_NBUR_1PX_DTL.T023 is 'Код операції';
comment on column V_NBUR_1PX_DTL.RCUKRU_GLB_2 is 'Код банка-учасника';
comment on column V_NBUR_1PX_DTL.K018 is 'Код типу клієнта';
comment on column V_NBUR_1PX_DTL.K020 is 'Код клієнта';
comment on column V_NBUR_1PX_DTL.Q001 is 'Назва клієнта';
comment on column V_NBUR_1PX_DTL.RCUKRU_GLB_1 is 'Код банка-декларанта';
comment on column V_NBUR_1PX_DTL.Q003_1 is 'Умовний номер рядка';
comment on column V_NBUR_1PX_DTL.Q004 is 'Опис операції';
comment on column V_NBUR_1PX_DTL.T071 is 'Сума в іноземнiй валютi';
comment on column V_NBUR_1PX_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_1PX_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_1PX_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_1PX_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_1PX_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_1PX_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_1PX_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_1PX_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_1PX_DTL.ND is 'Ід. договору';
comment on column V_NBUR_1PX_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_1PX_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_1PX_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_1PX_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_1PX_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_1px_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 