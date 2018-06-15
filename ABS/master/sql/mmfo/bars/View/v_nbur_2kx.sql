PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_2kx.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_2kx ***

create or replace view v_nbur_2kx as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , K020_1 || Q003_1 as FIELD_CODE
       , t.EKP
       , t.Q003_1
       , t.Q001_1
       , t.Q002
       , t.K020_1
       , t.K021_1
       , t.Q003_2
       , t.Q003_3
       , t.Q030
       , t.Q006
       , t.F086
       , t.Q003_4
       , t.R030_1
       , t.Q007_1
       , t.Q007_2
       , t.Q031_1
       , t.T070_1
       , t.T070_2
       , t.F088
       , t.Q007_3
       , t.Q003_5
       , t.Q001_2
       , t.K020_2
       , t.K021_2
       , t.Q001_3
       , t.T070_3
       , t.R030_2
       , t.Q032
       , t.Q031_2
from   (
         select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/Q003_1'  ) as Q003_1
               , extractValue( COLUMN_VALUE, 'DATA/Q001_1'  ) as Q001_1
               , extractValue( COLUMN_VALUE, 'DATA/Q002'  ) as Q002
               , extractValue( COLUMN_VALUE, 'DATA/K020_1'  ) as K020_1
               , extractValue( COLUMN_VALUE, 'DATA/K021_1'  ) as K021_1
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2'  ) as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q003_3'  ) as Q003_3
               , extractValue( COLUMN_VALUE, 'DATA/Q030'  ) as Q030
               , extractValue( COLUMN_VALUE, 'DATA/Q006'  ) as Q006
               , extractValue( COLUMN_VALUE, 'DATA/F086'  ) as F086
               , extractValue( COLUMN_VALUE, 'DATA/Q003_4'  ) as Q003_4
               , extractValue( COLUMN_VALUE, 'DATA/R030_1'  ) as R030_1
               , extractValue( COLUMN_VALUE, 'DATA/Q007_1'  ) as Q007_1
               , extractValue( COLUMN_VALUE, 'DATA/Q007_2'  ) as Q007_2
               , extractValue( COLUMN_VALUE, 'DATA/Q031_1'  ) as Q031_1
               , extractValue( COLUMN_VALUE, 'DATA/T070_1'  ) as T070_1
               , extractValue( COLUMN_VALUE, 'DATA/T070_2'  ) as T070_2
               , extractValue( COLUMN_VALUE, 'DATA/F088'  ) as F088
               , extractValue( COLUMN_VALUE, 'DATA/Q007_3'  ) as Q007_3
               , extractValue( COLUMN_VALUE, 'DATA/Q003_5'  ) as Q003_5
               , extractValue( COLUMN_VALUE, 'DATA/Q001_2'  ) as Q001_2
               , extractValue( COLUMN_VALUE, 'DATA/K020_2'  ) as K020_2
               , extractValue( COLUMN_VALUE, 'DATA/K021_2'  ) as K021_2
               , extractValue( COLUMN_VALUE, 'DATA/Q001_3'  ) as Q001_3
               , extractValue( COLUMN_VALUE, 'DATA/T070_3'  ) as T070_3
               , extractValue( COLUMN_VALUE, 'DATA/R030_2'  ) as R030_2
               , extractValue( COLUMN_VALUE, 'DATA/Q032'  ) as Q032
               , extractValue( COLUMN_VALUE, 'DATA/Q031_2'  ) as Q031_2
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '2KX'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_2KX is '2KX - Дані про банківські рахунки та залишки коштів на них ФО та ЮО(санкції)';
comment on column V_NBUR_2KX.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_2KX.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_2KX.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_2KX.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_2KX.FIELD_CODE is 'Код показника';
comment on column V_NBUR_2KX.EKP is 'Код показника';
comment on column V_NBUR_2KX.Q003_1 is 'Умовний порядковий номер запису у звітному файлі';
comment on column V_NBUR_2KX.Q001_1 is 'Найменування / ПІБ санкційної особи, зазначеної в додатку до рішення РНБО України';
comment on column V_NBUR_2KX.Q002 is 'Місцезнаходження/місце проживання, перебування санкційної особи';
comment on column V_NBUR_2KX.K020_1 is 'Код за ЄДРПОУ/ІПН';
comment on column V_NBUR_2KX.K021_1 is 'Ознака коду за ЄДРПОУ/ІПН';
comment on column V_NBUR_2KX.Q003_2 is 'Номер позиції згідно із відповідним додатком до рішення РНБО України';
comment on column V_NBUR_2KX.Q003_3 is 'Номер указу Президента України, згідно з яким введено в дію рішення РНБО України';
comment on column V_NBUR_2KX.Q030 is 'Санкція відповідно до рішення РНБО України';
comment on column V_NBUR_2KX.Q006 is 'Примітка';
comment on column V_NBUR_2KX.F086 is 'Стан рахунку санкційної особи';
comment on column V_NBUR_2KX.Q003_4 is 'Номер рахунку санкційної особи';
comment on column V_NBUR_2KX.R030_1 is 'Код валюти рахунку санкційної особи';
comment on column V_NBUR_2KX.Q007_1 is 'Дата відкриття рахунку санкційної особи';
comment on column V_NBUR_2KX.Q007_2 is 'Дата закриття рахунку санкційної особи';
comment on column V_NBUR_2KX.Q031_1 is 'Стан застосування санкції щодо рахунку санкційної особи';
comment on column V_NBUR_2KX.T070_1 is 'Залишок коштів на рахунку санкційної особи станом на дату введення в дію рішення РНБО України';
comment on column V_NBUR_2KX.T070_2 is 'Залишок коштів на рахунку санкційної особи станом на звітну дату';
comment on column V_NBUR_2KX.F088 is 'Код виду фінансової операції, яку мали намір провести';
comment on column V_NBUR_2KX.Q007_3 is 'Дата спроби проведення фінансової операції';
comment on column V_NBUR_2KX.Q003_5 is 'Номер рахунку отримувача / платника';
comment on column V_NBUR_2KX.Q001_2 is 'Найменування / прізвище, ім’я, по батькові отримувача / платника';
comment on column V_NBUR_2KX.K020_2 is 'Код за ЄДРПОУ / код ІПН отримувача / платника';
comment on column V_NBUR_2KX.K021_2 is 'Ознака коду за ЄДРПОУ/ІПН';
comment on column V_NBUR_2KX.Q001_3 is 'Найменування банку отримувача / платника';
comment on column V_NBUR_2KX.T070_3 is 'Сума фінансової операції';
comment on column V_NBUR_2KX.R030_2 is 'Код валюти фінансової операції при спробі проведення фінансової операції';
comment on column V_NBUR_2KX.Q032 is 'Призначення платежу при спробі проведення фінансової операції';
comment on column V_NBUR_2KX.Q031_2 is 'Дії банку при спробі проведення фінансової операції';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_2kx.sql =========*** End *** =
PROMPT ===================================================================================== 