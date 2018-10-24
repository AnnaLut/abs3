PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_4bx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_4BX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP   
       , p.F058
       , p.Q003_2
       , p.T070
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2'  ) as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/F058'    ) as F058
               , extractValue( COLUMN_VALUE, 'DATA/T070'    ) as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#4B'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p;

comment on table  v_nbur_4bx is '4BX Дані про дотримання вимог щодо достатності регулятивного капіталу та економічних нормативів';
comment on column v_nbur_4bx.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_4bx.KF is 'Фiлiя';
comment on column v_nbur_4bx.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_4bx.EKP    is 'Код показника';                           
comment on column v_nbur_4bx.F058   is 'Код підгрупи банківської групи';
comment on column v_nbur_4bx.Q003_2 is 'Порядковий номер підгрупи';
comment on column v_nbur_4bx.T070   is 'Сума';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_4bx.sql =========*** End *** ===
PROMPT ===================================================================================== 

