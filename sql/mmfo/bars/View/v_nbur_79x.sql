PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_79X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_79X ***

create or replace view v_nbur_79X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/K030') as K030
          , extractValue(COLUMN_VALUE, 'DATA/Q001') as Q001
          , extractValue(COLUMN_VALUE, 'DATA/K020') as K020
          , extractValue(COLUMN_VALUE, 'DATA/K021') as K021
          , extractValue(COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
          , extractValue(COLUMN_VALUE, 'DATA/Q007_2') as Q007_2
          , extractValue(COLUMN_VALUE, 'DATA/Q007_3') as Q007_3
          , extractValue(COLUMN_VALUE, 'DATA/Q007_4') as Q007_4
          , extractValue(COLUMN_VALUE, 'DATA/Q003_1') as Q003_1
          , extractValue(COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
          , extractValue(COLUMN_VALUE, 'DATA/Q003_3') as Q003_3
          , extractValue(COLUMN_VALUE, 'DATA/T070_1') as T070_1
          , extractValue(COLUMN_VALUE, 'DATA/T070_2') as T070_2
          , extractValue(COLUMN_VALUE, 'DATA/T070_3') as T070_3
          , extractValue(COLUMN_VALUE, 'DATA/T070_4') as T070_4
          , extractValue(COLUMN_VALUE, 'DATA/T090_1') as T090_1
          , extractValue(COLUMN_VALUE, 'DATA/T090_2') as T090_2
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '79X'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_79X is 'Файл 79X - Дані про концетрацію ризиків за пасивними операціями банку';
comment on column V_NBUR_79X.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_79X.KF is 'Фiлiя';
comment on column V_NBUR_79X.VERSION_ID is 'Номер версії файлу';
comment on column V_NBUR_79X.EKP    is 'Код показника';
comment on column V_NBUR_79X.R030   is 'Код валюти субординованого боргу';
comment on column V_NBUR_79X.K030   is 'Код резидентності інвестора';
comment on column V_NBUR_79X.Q001   is 'Повне найменування юридичної особи або прізвище, ім’я, по батькові фізичної особи інвестора';
comment on column V_NBUR_79X.K020   is 'Код інвестора';
comment on column V_NBUR_79X.K021   is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column V_NBUR_79X.Q007_1 is 'Дата укладення угоди про субординований борг';
comment on column V_NBUR_79X.Q007_2 is 'Дата закінчення дії угоди про субординований борг';
comment on column V_NBUR_79X.Q007_3 is 'Дата рішення Комітету з питань нагляду та регулювання діяльності банків про включення до капіталу';
comment on column V_NBUR_79X.Q007_4 is 'Дата реєстрації договору';
comment on column V_NBUR_79X.Q003_1 is 'Номер рішення Комітету з питань нагляду та регулювання діяльності банків про включення до капіталу';
comment on column V_NBUR_79X.Q003_2 is 'Номер реєстрації договору';
comment on column V_NBUR_79X.Q003_3 is 'Умовний порядковий номер боргу для конкретного інвестора';
comment on column V_NBUR_79X.T070_1 is 'Сума залученого субординованого боргу для врахування до капіталу банку за б/р 3660,3661';
comment on column V_NBUR_79X.T070_2 is 'Сума, на яку отримано дозвіл на врахування залучених коштів на умовах субординованого боргу до капіталу банку';
comment on column V_NBUR_79X.T070_3 is 'Сума субординованого боргу, яка враховується в розрахунку регулятивного капіталу банку';
comment on column V_NBUR_79X.T070_4 is 'Сума перевищення обмеження, установленого пунктом 3.10 глави 3 розділу III Інструкції № 368';
comment on column V_NBUR_79X.T090_1 is 'Процент, який береться до розрахунку суми субординованого боргу';
comment on column V_NBUR_79X.T090_2 is 'Розмір процентної ставки, яка встановлюється за субординованим боргом, згідно з угодою';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_79X.sql =========*** End *** =
PROMPT ===================================================================================== 

