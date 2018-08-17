PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_4px.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_4px ***

create or replace view v_nbur_4px as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.EKP || t.R030_1 || t.K020 || t.Q003_3 || t.Q006 || t.Q007_2 as FIELD_CODE
       , t.B040
       , t.EKP               
       , t.R020
       , t.R030_1
       , t.R030_2
       , t.K040
       , t.S050
       , t.S184
       , t.F028
       , t.F045
       , t.F046
       , t.F047
       , t.F048
       , t.F049                                                                                          
       , t.F050
       , t.F052               
       , t.F053
       , t.F054
       , t.F055
       , t.F056
       , t.F057
       , t.F070
       , t.K020
       , t.Q001_1
       , t.Q001_2
       , t.Q003_1
       , t.Q003_2
       , t.Q003_3               
       , t.Q006
       , t.Q007_1
       , t.Q007_2
       , t.Q007_3
       , t.Q010_1
       , t.Q010_2                
       , t.Q012
       , t.Q013
       , t.Q021
       , t.Q022
       , t.T071       
from   (
         select
                v.REPORT_DATE
                , v.KF
                , v.version_id               
                , extractValue(COLUMN_VALUE, 'DATA/B040') as B040
                , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP               
                , extractValue(COLUMN_VALUE, 'DATA/R020') as R020
                , extractValue(COLUMN_VALUE, 'DATA/R030_1') as R030_1
                , extractValue(COLUMN_VALUE, 'DATA/R030_2') as R030_2
                , extractValue(COLUMN_VALUE, 'DATA/K040') as K040
                , extractValue(COLUMN_VALUE, 'DATA/S050') as S050
                , extractValue(COLUMN_VALUE, 'DATA/S184') as S184
                , extractValue(COLUMN_VALUE, 'DATA/F028') as F028
                , extractValue(COLUMN_VALUE, 'DATA/F045') as F045
                , extractValue(COLUMN_VALUE, 'DATA/F046') as F046
                , extractValue(COLUMN_VALUE, 'DATA/F047') as F047
                , extractValue(COLUMN_VALUE, 'DATA/F048') as F048
                , extractValue(COLUMN_VALUE, 'DATA/F049') as F049                                                                                          
                , extractValue(COLUMN_VALUE, 'DATA/F050') as F050
                , extractValue(COLUMN_VALUE, 'DATA/F052') as F052               
                , extractValue(COLUMN_VALUE, 'DATA/F053') as F053
                , extractValue(COLUMN_VALUE, 'DATA/F054') as F054
                , extractValue(COLUMN_VALUE, 'DATA/F055') as F055
                , extractValue(COLUMN_VALUE, 'DATA/F056') as F056
                , extractValue(COLUMN_VALUE, 'DATA/F057') as F057
                , extractValue(COLUMN_VALUE, 'DATA/F070') as F070
                , extractValue(COLUMN_VALUE, 'DATA/K020') as K020
                , extractValue(COLUMN_VALUE, 'DATA/Q001_1') as Q001_1
                , extractValue(COLUMN_VALUE, 'DATA/Q001_2') as Q001_2
                , extractValue(COLUMN_VALUE, 'DATA/Q003_1') as Q003_1
                , extractValue(COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
                , extractValue(COLUMN_VALUE, 'DATA/Q003_3') as Q003_3               
                , extractValue(COLUMN_VALUE, 'DATA/Q006') as Q006
                , extractValue(COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
                , extractValue(COLUMN_VALUE, 'DATA/Q007_2') as Q007_2
                , extractValue(COLUMN_VALUE, 'DATA/Q007_3') as Q007_3
                , extractValue(COLUMN_VALUE, 'DATA/Q010_1') as Q010_1
                , extractValue(COLUMN_VALUE, 'DATA/Q010_2') as Q010_2                
                , extractValue(COLUMN_VALUE, 'DATA/Q012') as Q012
                , extractValue(COLUMN_VALUE, 'DATA/Q013') as Q013
                , extractValue(COLUMN_VALUE, 'DATA/Q021') as Q021
                , extractValue(COLUMN_VALUE, 'DATA/Q022') as Q022
                , extractValue(COLUMN_VALUE, 'DATA/T071') as T071
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#4P'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_4PX is '4PX Дані про стан заборгованості, розрахунки та планові операції за кредитами та іншими зобов''язаннями з нерезидентами';
comment on column V_NBUR_4PX.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_4PX.KF is 'Фiлiя';
comment on column V_NBUR_4PX.VERSION_ID is 'Номер версії файлу';
comment on column V_NBUR_4PX.NBUC is 'Код областi розрiзу юридичної особи';
comment on column V_NBUR_4PX.FIELD_CODE is 'Код показника';
comment on column V_NBUR_4PX.B040 is 'Структурний підрозділ';
comment on column V_NBUR_4PX.EKP is 'Код показника';
comment on column V_NBUR_4PX.R020 is 'Балансовий рахунок';
comment on column V_NBUR_4PX.R030_1 is 'Валюта кредиту';
comment on column V_NBUR_4PX.R030_2 is 'Валюта розрахунку за кредитом';
comment on column V_NBUR_4PX.K040 is 'Країни';
comment on column V_NBUR_4PX.S050 is 'Код типу строковості';
comment on column V_NBUR_4PX.S184 is 'Узагальнені коди';
comment on column V_NBUR_4PX.F028 is 'Вид заборгованості';
comment on column V_NBUR_4PX.F045 is 'Ознака кредита';
comment on column V_NBUR_4PX.F046 is 'Стан розрахунків за кредитом';
comment on column V_NBUR_4PX.F047 is 'Узагальнений тип позичальника';
comment on column V_NBUR_4PX.F048 is 'Тип відсоткової ставки за кредитом';
comment on column V_NBUR_4PX.F049 is 'Код пояснення щодо внесення змін до договору';                                                                                   
comment on column V_NBUR_4PX.F050 is 'Цілі використання кредиту';
comment on column V_NBUR_4PX.F052 is 'Тип кредитора';
comment on column V_NBUR_4PX.F053 is 'Можливості дострокового погашення заборгованості';
comment on column V_NBUR_4PX.F054 is 'Періодичність здійснення платежів';
comment on column V_NBUR_4PX.F055 is 'Тип кредиту (інструмент кредитування)';
comment on column V_NBUR_4PX.F056 is 'Підстави подання звіту';
comment on column V_NBUR_4PX.F057 is 'Вид запозичення';
comment on column V_NBUR_4PX.F070 is 'Код типу реорганізації';
comment on column V_NBUR_4PX.K020 is 'Код позичальника';
comment on column V_NBUR_4PX.Q001_1 is 'назва позичальника/клієнта банку';
comment on column V_NBUR_4PX.Q001_2 is 'назва кредитора/кредитної лінії для гарантованих, негарантованих кредитів і кредитів у гривнях від ЄБРР';
comment on column V_NBUR_4PX.Q003_1 is 'номер кредитної угоди';
comment on column V_NBUR_4PX.Q003_2 is 'номер реєстрації договору Національним банком україни';
comment on column V_NBUR_4PX.Q003_3 is 'порядковий номер траншу в межах відновлювальної кредитної лінії';        
comment on column V_NBUR_4PX.Q006 is 'примітка, що містить додаткову інформацію стосовно внесення змін до договору';
comment on column V_NBUR_4PX.Q007_1 is 'дата підписання кредитної угоди';
comment on column V_NBUR_4PX.Q007_2 is 'дата реєстрації договору Національним банком України';
comment on column V_NBUR_4PX.Q007_3 is 'строк погашення кредиту';
comment on column V_NBUR_4PX.Q010_1 is 'період по місяцях, на які надається прогноз платежів за заборгованістю перед нерезидентами';
comment on column V_NBUR_4PX.Q010_2 is 'період по роках, на які надається прогноз платежів за заборгованістю перед нерезидентами';         
comment on column V_NBUR_4PX.Q012 is 'база для обчислення плаваючої ставки за кредитом';
comment on column V_NBUR_4PX.Q013 is 'розмір маржі процентної ставки за кредитом';
comment on column V_NBUR_4PX.Q021 is 'загальна сума кредиту за договором з нерезидентом';
comment on column V_NBUR_4PX.Q022 is 'величина процентної ставки за основною сумою боргу';
comment on column V_NBUR_4PX.T071 is 'сума';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_4px.sql =========*** End *** =
PROMPT ===================================================================================== 