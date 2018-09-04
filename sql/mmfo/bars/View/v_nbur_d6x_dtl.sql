PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_D6X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_D6X_dtl ***

create or replace view v_nbur_D6X_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , null as FIELD_CODE
         , p.EKP
         , p.KU
         , p.T020
         , p.R020
         , p.R011
         , p.R030
         , p.K040
         , p.K072
         , p.K111
         , p.S183
         , p.S241
         , p.F048
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
    from NBUR_LOG_FD6X p
         join NBUR_REF_FILES f on (f.FILE_CODE = 'D6X' )
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

comment on table V_NBUR_D6X_DTL is 'Детальний протокол файлу D6X';
comment on column V_NBUR_D6X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_D6X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_D6X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_D6X_DTL.FIELD_CODE is 'Зведений код показника';
comment on column V_NBUR_D6X_DTL.EKP is 'Код показника';
comment on column V_NBUR_D6X_DTL.KU is 'Код території';
comment on column V_NBUR_D6X_DTL.T020 is 'Елемент рахунку';
comment on column V_NBUR_D6X_DTL.R020 is 'Номер рахунку';
comment on column V_NBUR_D6X_DTL.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_D6X_DTL.R030 is 'Код валюти';
comment on column V_NBUR_D6X_DTL.K040 is 'Код країни';
comment on column V_NBUR_D6X_DTL.K072 is 'Код сектору економіки';
comment on column V_NBUR_D6X_DTL.K111 is 'Код роздiлу виду економiчної дiяльностi';
comment on column V_NBUR_D6X_DTL.S183 is 'Узагальнений код початкових строків погашення';
comment on column V_NBUR_D6X_DTL.S241 is 'Узагальнений код строків до погашення';
comment on column V_NBUR_D6X_DTL.F048 is 'Код типу процентної ставки';
comment on column V_NBUR_D6X_DTL.T070 is 'Сума';
comment on column V_NBUR_D6X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_D6X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_D6X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_D6X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_D6X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_D6X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_D6X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_D6X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_D6X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_D6X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_D6X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_D6X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_D6X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_D6X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_D6X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 