PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_d4x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_d4x ***

create or replace view v_nbur_d4x as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.R030 || t.F025 || t.B010  as FIELD_CODE
       , t.EKP
       , t.R030
       , t.F025
       , t.B010
       , t.Q006
       , t.T071
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/F025'  ) as F025
               , extractValue( COLUMN_VALUE, 'DATA/B010'  ) as B010
               , extractValue( COLUMN_VALUE, 'DATA/Q006'  ) as Q006
               , extractValue( COLUMN_VALUE, 'DATA/T071'  ) as T071
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'D4X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_D4X is 'D4X - Рух коштів на коррахунках іноземних банків';
comment on column V_NBUR_D4X.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_D4X.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_D4X.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_D4X.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_D4X.FIELD_CODE is 'Код показника';
comment on column V_NBUR_D4X.EKP is 'Код показника';
comment on column V_NBUR_D4X.R030 is 'Валюта';
comment on column V_NBUR_D4X.F025 is 'Код змісту операції';
comment on column V_NBUR_D4X.B010 is 'Код іноземного банку';
comment on column V_NBUR_D4X.Q006 is 'Примітка';
comment on column V_NBUR_D4X.T071 is 'Сума';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_d4x.sql =========*** End *** =
PROMPT ===================================================================================== 