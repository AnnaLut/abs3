PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6bx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_6BX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.F083
       , p.F082
       , p.S083
       , p.S080
       , p.S031
       , p.K030
       , p.R030
       , p.T070
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/F083'  ) as F083
               , extractValue( COLUMN_VALUE, 'DATA/F082'  ) as F082
               , extractValue( COLUMN_VALUE, 'DATA/S083'  ) as S083
               , extractValue( COLUMN_VALUE, 'DATA/S080'  ) as S080
               , extractValue( COLUMN_VALUE, 'DATA/S031'  ) as S031
               , extractValue( COLUMN_VALUE, 'DATA/K030'  ) as K030
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '6BX'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by 2,11,4,5;

comment on table  v_nbur_6bx is 'Файл 6BX - ані про розмір кредитного ризику за активними банківськими операціями';
comment on column v_nbur_6bx.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_6bx.KF is 'Фiлiя';
comment on column v_nbur_6bx.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_6bx.EKP is 'Код показника';
comment on column v_nbur_6bx.T070 is 'Сума';
comment on column v_nbur_6bx.F083 is 'Код значення коефіцієнта кредитної конверсії, рівня покриття боргу заставою, складової балансової вартості';
comment on column v_nbur_6bx.F082 is 'Код типу боржника';
comment on column v_nbur_6bx.S083 is 'Код типу оцінки кредитного ризику';
comment on column v_nbur_6bx.S080 is 'Код класу боржника/контрагента';
comment on column v_nbur_6bx.S031 is 'Код виду забезпечення кредиту';
comment on column v_nbur_6bx.K030 is 'Код резидентності';
comment on column v_nbur_6bx.R030 is 'Код валюти';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6bx.sql =========*** End *** ===
PROMPT ===================================================================================== 

