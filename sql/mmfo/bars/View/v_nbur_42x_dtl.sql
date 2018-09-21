PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_42X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_42X_dtl ***

create or replace view v_nbur_42X_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.F099
     , p.Q003_4
     , p.T070
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_F42X p
       join NBUR_REF_FILES f on (f.FILE_CODE = '42X')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by F099, Q003_4, acc_num, kv;
   
comment on table V_NBUR_42X_DTL is 'Детальний протокол файлу 42X';
comment on column V_NBUR_42X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_42X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_42X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_42X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_42X_DTL.EKP is 'Код показника';
comment on column V_NBUR_42X_DTL.KU is 'Код області';
comment on column V_NBUR_42X_DTL.F099   is 'Код даних для розрахунку економічних нормативів';
comment on column V_NBUR_42X_DTL.Q003_4 is 'Умовний порядковий номер контрагента';
comment on column V_NBUR_42X_DTL.T070   is 'Сума';
comment on column V_NBUR_42X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_42X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_42X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_42X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_42X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_42X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_42X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_42X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 