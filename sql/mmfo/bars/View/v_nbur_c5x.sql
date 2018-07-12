PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_c5x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_c5x ***

create or replace view v_nbur_c5x 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.A012 || t.T020 || t.R020 || t.R011 || t.R013 || t.R030_1 
         || t.R030_2 || t.R017 || t.K077 || t.S245 || t.S580 as FIELD_CODE
       , t.EKP
       , t.A012
       , t.T020
       , t.R020
       , t.R011
       , t.R013
       , t.R030_1
       , t.R030_2
       , t.R017
       , t.K077
       , t.S245
       , t.S580
       , t.T070
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/A012' ) as A012
               , extractValue( COLUMN_VALUE, 'DATA/T020'  ) as T020
               , extractValue( COLUMN_VALUE, 'DATA/R020'  ) as R020
               , extractValue( COLUMN_VALUE, 'DATA/R011'  ) as R011
               , extractValue( COLUMN_VALUE, 'DATA/R013'  ) as R013
               , extractValue( COLUMN_VALUE, 'DATA/R030_1'  ) as R030_1
               , extractValue( COLUMN_VALUE, 'DATA/R030_2'  ) as R030_2
               , extractValue( COLUMN_VALUE, 'DATA/R017'  ) as R017
               , extractValue( COLUMN_VALUE, 'DATA/K077'  ) as K077
               , extractValue( COLUMN_VALUE, 'DATA/S245'  ) as S245
               , extractValue( COLUMN_VALUE, 'DATA/S580'  ) as S580
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'C5X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_C5X is 'C5X Додаткові дані для розрахунку економічних нормативів';
comment on column V_NBUR_C5X.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_C5X.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_C5X.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_C5X.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_C5X.FIELD_CODE is 'Код показника';
comment on column V_NBUR_C5X.EKP is 'Код показника';
comment on column V_NBUR_C5X.A012 is 'Код місцезнаходження території';
comment on column V_NBUR_C5X.T020 is 'Код елементу даних за рахунком';
comment on column V_NBUR_C5X.R020 is 'Номер баланс./позабаланс. рахунку';
comment on column V_NBUR_C5X.R011 is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_C5X.R013 is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column V_NBUR_C5X.R030_1 is 'Код валюти';
comment on column V_NBUR_C5X.R030_2 is 'Код валюти індексації';
comment on column V_NBUR_C5X.R017 is 'Код розподілу фінансових інструментів щодо індексації';
comment on column V_NBUR_C5X.K077 is 'Код агрегованого сектору економіки';
comment on column V_NBUR_C5X.S245 is 'Код узагальненого кінцевого строку погашення';
comment on column V_NBUR_C5X.S580 is 'Код розподілу активів за групами ризику';
comment on column V_NBUR_C5X.T070 is 'Сума';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_c5x.sql =========*** End *** =
PROMPT ===================================================================================== 