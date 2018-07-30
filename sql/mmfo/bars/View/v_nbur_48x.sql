PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_48x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_48x ***

create or replace view v_nbur_48x 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , t.Q003 as FIELD_CODE
       , t.EKP
       , t.Q003
       , t.Q001
       , t.Q002
       , t.Q008
       , t.Q029
       , t.K020
       , t.K021
       , t.K040
       , t.K110
       , t.T070
       , t.T080
       , t.T090_1
       , t.T090_2
       , t.T090_3
from   (
         select
                v.REPORT_DATE
                , v.KF
                , v.version_id
                , extractValue( COLUMN_VALUE, 'DATA/EKP'  ) as EKP
                , extractValue( COLUMN_VALUE, 'DATA/Q003'  ) as Q003
                , extractValue( COLUMN_VALUE, 'DATA/Q001'  ) as Q001
                , extractValue( COLUMN_VALUE, 'DATA/Q002'  ) as Q002
                , extractValue( COLUMN_VALUE, 'DATA/Q008'  ) as Q008
                , extractValue( COLUMN_VALUE, 'DATA/Q029'  ) as Q029
                , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020
                , extractValue( COLUMN_VALUE, 'DATA/K021'  ) as K021
                , extractValue( COLUMN_VALUE, 'DATA/K040'  ) as K040
                , extractValue( COLUMN_VALUE, 'DATA/K110'  ) as K110
                , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070
                , extractValue( COLUMN_VALUE, 'DATA/T080'  ) as T080
                , extractValue( COLUMN_VALUE, 'DATA/T090_1'  ) as T090_1
                , extractValue( COLUMN_VALUE, 'DATA/T090_2'  ) as T090_2
                , extractValue( COLUMN_VALUE, 'DATA/T090_3'  ) as T090_3
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '48X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;
comment on table V_NBUR_48X is '48X Двадцять найбільших учасників банку';
comment on column V_NBUR_48X.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_48X.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_48X.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_48X.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_48X.FIELD_CODE is 'Код показника';
comment on column V_NBUR_48X.EKP is 'Код показника';
comment on column V_NBUR_48X.Q003 is 'Умовний порядковий номер учасника банку';
comment on column V_NBUR_48X.Q001 is 'Повне найменування юридичної особи або прізвище, ім’я, по батькові фізичної особи учасника банку';
comment on column V_NBUR_48X.Q002 is 'Адреса юридичної особи або адреса постійного місця проживання фізичної особи';
comment on column V_NBUR_48X.Q008 is 'Платіжні реквізити юридичної особи або паспортні дані фізичної особи';
comment on column V_NBUR_48X.Q029 is 'Код учасника банку нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини';
comment on column V_NBUR_48X.K020 is 'Код учаснику банку';
comment on column V_NBUR_48X.K021 is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column V_NBUR_48X.K040 is 'Код країни учасника банку';
comment on column V_NBUR_48X.K110 is 'Код виду економічної діяльності учасника банку';
comment on column V_NBUR_48X.T070 is 'Вартість акцій (паїв)';
comment on column V_NBUR_48X.T080 is 'Кількість акцій (паїв)';
comment on column V_NBUR_48X.T090_1 is 'Відсоток прямої участі у статутному капіталі';
comment on column V_NBUR_48X.T090_2 is 'Відсоток опосередкованої участі у статутному капіталі';
comment on column V_NBUR_48X.T090_3 is 'Відсоток загальної участі у статутному капіталі';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_48x.sql =========*** End *** =
PROMPT ===================================================================================== 