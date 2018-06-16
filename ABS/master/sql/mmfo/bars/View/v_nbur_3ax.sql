PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3ax.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_3ax ***

create or replace view v_nbur_3ax 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.KU || t.T020 || t.R020 || t.R011 
         || t.D020 || t.S180 || t.R030 || t.K030 as FIELD_CODE
       , t.EKP
       , t.KU
       , t.T020
       , t.R020
       , t.R011
       , t.D020
       , t.S180
       , t.R030
       , t.K030
       , t.T070
       , t.T090
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
               , extractValue( COLUMN_VALUE, 'DATA/D020'  ) as D020
               , extractValue( COLUMN_VALUE, 'DATA/S180'  ) as S180
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/K030'  ) as K030
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
               , extractValue( COLUMN_VALUE, 'DATA/T090'  ) as T090
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '3AX'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_3AX is '3AX Суми та вартість кредитів та депозитів';
comment on column V_NBUR_3AX.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_3AX.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_3AX.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_3AX.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_3AX.FIELD_CODE is 'Код показника';
comment on column V_NBUR_3AX.EKP is 'Код показника';
comment on column V_NBUR_3AX.KU is 'Код території';
comment on column V_NBUR_3AX.T020 is 'Елемент рахунку';
comment on column V_NBUR_3AX.R020 is 'Номер рахунку';
comment on column V_NBUR_3AX.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_3AX.D020 is 'Код розподілу оборотів за рахунком';
comment on column V_NBUR_3AX.S180 is 'Код початкового строку погашення';
comment on column V_NBUR_3AX.R030 is 'Код валюти';
comment on column V_NBUR_3AX.K030 is 'Код резидентності';
comment on column V_NBUR_3AX.T070 is 'Сума';
comment on column V_NBUR_3AX.T090 is 'Розмір процентної ставки';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3ax.sql =========*** End *** =
PROMPT ===================================================================================== 