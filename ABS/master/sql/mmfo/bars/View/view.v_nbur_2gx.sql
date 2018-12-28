PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_2gx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_2GX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP   
       , p.F091
       , p.D100
       , p.Q024
       , p.T070
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/F091'  ) as F091
               , extractValue( COLUMN_VALUE, 'DATA/D100'  ) as D100
               , extractValue( COLUMN_VALUE, 'DATA/Q024'  ) as Q024
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '2GX'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by 2,5,6,7;

comment on table  v_nbur_2GX is 'Файл 2GX -Інформація за операціями з купівлі/продажу іноземної валюти';
comment on column v_nbur_2GX.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_2GX.KF is 'Фiлiя';
comment on column v_nbur_2GX.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_2GX.EKP    is 'Код показника';                           
comment on column v_nbur_2GX.F091   is 'Код операції';
comment on column v_nbur_2GX.D100   is 'Умови валютної операції';
comment on column v_nbur_2GX.Q024   is 'Тип контрагента';
comment on column v_nbur_2GX.T070   is 'Сума в нац.валюті';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_2gx.sql =========*** End *** ===
PROMPT ===================================================================================== 

