PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_73x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_73x_dtl ***

create or replace view v_nbur_73x_dtl as
select l.REPORT_DATE
     , l.KF
     , l.VERSION_ID
     , l.EKP
     , l.KU
     , l.R030
     , l.T100
     , l.ACC_ID
     , l.ACC_NUM
     , l.KV
     , l.CUST_ID
     , c.CUST_CODE
     , c.CUST_NAME
     , l.REF
     , l.BRANCH
  from NBUR_LOG_F73X  l
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = l.REPORT_DATE and
         v.KF          = l.KF )
  join NBUR_REF_FILES f
    on ( f.ID = v.FILE_ID )
left outer
join V_NBUR_DM_CUSTOMERS c
  on ( c.REPORT_DATE = l.REPORT_DATE and
       c.KF          = l.KF          and
       c.CUST_ID     = l.CUST_ID )
 where f.FILE_CODE = '73X'
   and f.FILE_FMT = 'XML'
   and v.FILE_STATUS in ( 'FINISHED', 'BLOCKED' );

comment on table V_NBUR_73X_DTL is 'Детальний протокол файлу 73X';
comment on column V_NBUR_73X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_73X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_73X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_73X_DTL.EKP is 'Код показника';
comment on column V_NBUR_73X_DTL.R030 is 'Код валюти';
comment on column V_NBUR_73X_DTL.T100 is 'Сума в іноземній валюті/Кількість ПОВ';
comment on column V_NBUR_73X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_73X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_73X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_73X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_73X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_73X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_73X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_73X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_73x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 