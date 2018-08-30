PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_d5x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_d5x ***

create or replace view v_nbur_d5x 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , null as FIELD_CODE
       , t.EKP
       , t.KU
       , t.T020
       , t.R020
       , t.R011
       , t.R013
       , t.R030
       , t.K040
       , t.K072
       , t.K111
       , t.K140
       , t.F074
       , t.S032
       , t.S080
       , t.S183
       , t.S190
       , t.S241
       , t.S260
       , t.F048
       , t.T070
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as KU
               , extractValue( COLUMN_VALUE, 'DATA/T020'  ) as T020
               , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
               , extractValue( COLUMN_VALUE, 'DATA/R011'  ) as R011
               , extractValue( COLUMN_VALUE, 'DATA/R013'  ) as R013
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/K040'  ) as K040
               , extractValue( COLUMN_VALUE, 'DATA/K072'  ) as K072
               , extractValue( COLUMN_VALUE, 'DATA/K111'  ) as K111
               , extractValue( COLUMN_VALUE, 'DATA/K140'  ) as K140
               , extractValue( COLUMN_VALUE, 'DATA/F074'  ) as F074
               , extractValue( COLUMN_VALUE, 'DATA/S032'  ) as S032
               , extractValue( COLUMN_VALUE, 'DATA/S080'  ) as S080
               , extractValue( COLUMN_VALUE, 'DATA/S183'  ) as S183
               , extractValue( COLUMN_VALUE, 'DATA/S190'  ) as S190
               , extractValue( COLUMN_VALUE, 'DATA/S241'  ) as S241
               , extractValue( COLUMN_VALUE, 'DATA/S260'  ) as S260
               , extractValue( COLUMN_VALUE, 'DATA/F048'  ) as F048
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
         from  NBUR_REF_FILES f
               , NBUR_LST_FILES v
               , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where f.ID        = v.FILE_ID
               and f.FILE_CODE = 'D5X'
               and f.FILE_FMT  = 'XML'
               and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_D5X is 'D5X Кредити та процентні ставки';
comment on column V_NBUR_D5X.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_D5X.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_D5X.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_D5X.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_D5X.FIELD_CODE is 'Код показника';
comment on column V_NBUR_D5X.EKP is 'Код показника';
comment on column V_NBUR_D5X.KU is 'Код території';
comment on column V_NBUR_D5X.T020 is 'Елемент рахунку';
comment on column V_NBUR_D5X.R020 is 'Номер рахунку';
comment on column V_NBUR_D5X.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_D5X.R013 is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column V_NBUR_D5X.R030 is 'Код валюти';
comment on column V_NBUR_D5X.K040 is 'Код країни';
comment on column V_NBUR_D5X.K072 is 'Код сектору економіки';
comment on column V_NBUR_D5X.K111 is 'Код роздiлу виду економiчної дiяльностi';
comment on column V_NBUR_D5X.K140 is 'Код розміру суб’єкта господарювання';
comment on column V_NBUR_D5X.F074 is 'Код щодо належності контрагента/пов’язаної з банком особи до групи юридичних осіб під спільним контролем або до групи по';
comment on column V_NBUR_D5X.S032 is 'Узагальнений код виду забезпечення кредиту';
comment on column V_NBUR_D5X.S080 is 'Код класу боржника/контрагента';
comment on column V_NBUR_D5X.S183 is 'Узагальнений код початкових строків погашення';
comment on column V_NBUR_D5X.S190 is 'Код строку прострочення погашення боргу';
comment on column V_NBUR_D5X.S241 is 'Узагальнений код строків до погашення';
comment on column V_NBUR_D5X.S260 is 'Код індивідуального споживання за цілями';
comment on column V_NBUR_D5X.F048 is 'Код типу процентної ставки';
comment on column V_NBUR_D5X.T070 is 'Сума';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_d5x.sql =========*** End *** =
PROMPT ===================================================================================== 