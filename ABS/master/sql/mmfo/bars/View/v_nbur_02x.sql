-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 18.04.2018
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

prompt -- ======================================================
prompt -- create view V_NBUR_02X
prompt -- ======================================================

create or replace force view V_NBUR_02X
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
) as
select V.REPORT_DATE
     , V.KF
     , V.VERSION_ID
     , extractvalue( column_value, 'DATA/EKP'  ) as EKP
     , extractvalue( column_value, 'DATA/KU'   ) as KU
     , extractvalue( column_value, 'DATA/R020' ) as R020
     , extractvalue( column_value, 'DATA/T020' ) as T020
     , extractvalue( column_value, 'DATA/R030' ) as R030
     , extractvalue( column_value, 'DATA/K040' ) as K040
     , extractvalue( column_value, 'DATA/T070' ) as T070
     , extractvalue( column_value, 'DATA/T071' ) as T071
  from NBUR_REF_FILES F
     , NBUR_LST_FILES V
     , table( xmlsequence( XMLTYPE( V.FILE_BODY ).extract( '/NBUSTATREPORT/DATA' ) ) ) T
 where F.ID = V.FILE_ID
   and F.FILE_CODE = '02X'
   and F.FILE_FMT = 'XML'
   and V.FILE_STATUS in ( 'FINISHED', 'BLOCKED' );

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  V_NBUR_02X             is 'Файл 02X - Щомісячні знімки балансу РУ на звітну дату  (архів версій)';

comment on column V_NBUR_02X.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_02X.KF          is 'Код фiлiалу (МФО)';
comment on column V_NBUR_02X.VERSION_ID  is 'Ід. версії файлу';
comment on column V_NBUR_02X.EKP         is 'Код показника';
comment on column V_NBUR_02X.KU          is 'Код областi розрiзу юридичної особи';
comment on column V_NBUR_02X.R020        is 'Номер рахунку';
comment on column V_NBUR_02X.T020        is 'Код елементу даних за рахунком';
comment on column V_NBUR_02X.R030        is 'Код валюти';
comment on column V_NBUR_02X.K040        is 'Код країни';
comment on column V_NBUR_02X.T070        is 'Сума в гривневому еквіваленті';
comment on column V_NBUR_02X.T071        is 'Сума в іноземній валюті';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON V_NBUR_02X TO BARSREADER_ROLE;
GRANT SELECT ON V_NBUR_02X TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON V_NBUR_02X TO UPLD;
