PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6kx.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_6kx ***

create or replace view v_nbur_6kx as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.R030 as FIELD_CODE
       , t.EKP
       , t.R030
       , t.T100
from   (
         select
                v.REPORT_DATE
                , v.KF
                , v.version_id
                , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
                , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
                , extractValue( COLUMN_VALUE, 'DATA/T100'  ) as T100
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6K'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_6EX is '6EX Дані для розрахунку коефіцієнта покриття ліквідністю (LCR)';
comment on column V_NBUR_6EX.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_6EX.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_6EX.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_6EX.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_6EX.FIELD_CODE is 'Код показника';
comment on column V_NBUR_6EX.EKP is 'Код показника';
comment on column V_NBUR_6EX.R030 is 'Валюта';
comment on column V_NBUR_6EX.T100 is 'Сума/процент';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6ex.sql =========*** End *** =
PROMPT ===================================================================================== 