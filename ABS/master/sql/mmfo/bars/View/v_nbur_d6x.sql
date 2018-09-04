PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_D6X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_D6X ***

create or replace view v_nbur_D6X 
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
       , t.R030
       , t.K040
       , t.K072
       , t.K111
       , t.S183
       , t.S241
       , t.F048
       , t.T070
from   (select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/KU'  ) as KU
               , extractValue( COLUMN_VALUE, 'DATA/T020'  ) as T020
               , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
               , extractValue( COLUMN_VALUE, 'DATA/R011'  ) as R011
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/K040'  ) as K040
               , extractValue( COLUMN_VALUE, 'DATA/K072'  ) as K072    		   
               , extractValue( COLUMN_VALUE, 'DATA/K111'  ) as K111    		   
               , extractValue( COLUMN_VALUE, 'DATA/S183'  ) as S183
               , extractValue( COLUMN_VALUE, 'DATA/S241'  ) as S241
               , extractValue( COLUMN_VALUE, 'DATA/F048'  ) as F048
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'D6X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
       
comment on table  V_NBUR_D6X is 'D6X Дані про депозити (за класифікаціями видів депозитів та контрагентів)';
comment on column V_NBUR_D6X.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_D6X.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_D6X.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_D6X.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_D6X.FIELD_CODE is 'Код показника';
comment on column V_NBUR_D6X.EKP is 'Код показника';
comment on column V_NBUR_D6X.KU is 'Код території';
comment on column V_NBUR_D6X.T020 is 'Елемент рахунку';
comment on column V_NBUR_D6X.R020 is 'Номер рахунку';
comment on column V_NBUR_D6X.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_D6X.R030 is 'Код валюти';
comment on column V_NBUR_D6X.K040 is 'Код країни';
comment on column V_NBUR_D6X.K072 is 'Код сектору економіки';
comment on column V_NBUR_D6X.K111 is 'Код роздiлу виду економiчної дiяльностi';
comment on column V_NBUR_D6X.S183 is 'Узагальнений код початкових строків погашення';
comment on column V_NBUR_D6X.S241 is 'Узагальнений код строків до погашення';
comment on column V_NBUR_D6X.F048 is 'Код типу процентної ставки';
comment on column V_NBUR_D6X.T070 is 'Сума';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_D6X.sql =========*** End *** =
PROMPT ===================================================================================== 