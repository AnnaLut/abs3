-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 18.04.2018
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

prompt -- ======================================================
prompt -- create view V_NBUR_02X_DTL
prompt -- ======================================================

create or replace force view V_NBUR_02X_DTL
( REPORT_DATE
, KF
, VERSION_ID
, EKP
, KU
, R020
, T020
, R030
, K040
, T070
, T071
, ACC_ID
, ACC_NUM
, KV
, BRANCH
, CUST_ID
, CUST_CODE
, CUST_NAME
) as
select l.REPORT_DATE
     , l.KF
     , l.VERSION_ID
     , l.EKP
     , l.KU
     , l.R020
     , l.T020
     , l.R030
     , l.K040
     , l.T070
     , l.T071
     , l.ACC_ID
     , l.ACC_NUM
     , l.KV
     , l.BRANCH
     , l.CUST_ID
     , c.CUST_CODE
     , c.CUST_NAME
  from NBUR_LOG_F02X  l
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
 where f.FILE_CODE = '02X'
   and f.FILE_FMT = 'XML'
   and v.FILE_STATUS in ( 'FINISHED', 'BLOCKED' );

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  V_NBUR_02X_DTL         is 'Файл 02X - Щомісячні знімки балансу РУ на звітну дату  (архів версій)';

comment on column V_NBUR_02X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_02X_DTL.KF          is 'Код фiлiалу (МФО)';
comment on column V_NBUR_02X_DTL.VERSION_ID  is 'Ід. версії файлу';
comment on column V_NBUR_02X_DTL.EKP         is 'Код показника';
comment on column V_NBUR_02X_DTL.KU          is 'Код областi розрiзу юридичної особи';
comment on column V_NBUR_02X_DTL.R020        is 'Номер рахунку';
comment on column V_NBUR_02X_DTL.T020        is 'Код елементу даних за рахунком';
comment on column V_NBUR_02X_DTL.R030        is 'Код валюти';
comment on column V_NBUR_02X_DTL.K040        is 'Код країни';
comment on column V_NBUR_02X_DTL.T070        is 'Сума в гривневому еквіваленті';
comment on column V_NBUR_02X_DTL.T071        is 'Сума в іноземній валюті';
comment on column V_NBUR_02X_DTL.ACC_ID      is 'Iдентифiкатор рахунку';
comment on column V_NBUR_02X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_02X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_02X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_02X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_02X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_02X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_02X_DTL.BRANCH is 'Код підрозділу';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON V_NBUR_02X_DTL TO BARSREADER_ROLE;
GRANT SELECT ON V_NBUR_02X_DTL TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON V_NBUR_02X_DTL TO UPLD;
