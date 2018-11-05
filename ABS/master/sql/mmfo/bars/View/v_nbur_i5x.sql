PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_I5X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_I5X ***

create or replace view v_nbur_I5X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/KU') as KU
          , extractValue(COLUMN_VALUE, 'DATA/T020') as T020
          , extractValue(COLUMN_VALUE, 'DATA/R020') as R020
          , extractValue(COLUMN_VALUE, 'DATA/R011') as R011
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/K040') as K040
          , extractValue(COLUMN_VALUE, 'DATA/K072') as K072
          , extractValue(COLUMN_VALUE, 'DATA/K111') as K111
          , extractValue(COLUMN_VALUE, 'DATA/K140') as K140
          , extractValue(COLUMN_VALUE, 'DATA/F074') as F074
          , extractValue(COLUMN_VALUE, 'DATA/S032') as S032
          , extractValue(COLUMN_VALUE, 'DATA/S183') as S183
          , extractValue(COLUMN_VALUE, 'DATA/S241') as S241
          , extractValue(COLUMN_VALUE, 'DATA/S260') as S260
          , extractValue(COLUMN_VALUE, 'DATA/F048') as F048
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
          , extractValue(COLUMN_VALUE, 'DATA/T090') as T090
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = 'I5X'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_I5X              is 'Файл I5X - Дані про концетрацію ризиків за пасивними операціями банку';
comment on column V_NBUR_I5X.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_I5X.KF          is 'Фiлiя';
comment on column V_NBUR_I5X.VERSION_ID  is 'Номер версії файлу';
comment on column V_NBUR_I5X.EKP         is 'Код показника';
comment on column V_NBUR_I5X.KU          is 'Код областi розрiзу юридичної особи';
comment on column V_NBUR_I5X.T020        is 'Елемент рахунку';
comment on column V_NBUR_I5X.R020        is 'Номер рахунку';
comment on column V_NBUR_I5X.R011        is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_I5X.R030        is 'Код валюти';
comment on column V_NBUR_I5X.K040        is 'Код країни';
comment on column V_NBUR_I5X.K072        is 'Код сектору економіки';
comment on column V_NBUR_I5X.K111        is 'Код роздiлу виду економiчної дiяльностi';
comment on column V_NBUR_I5X.K140        is 'Код розміру суб’єкта господарювання';
comment on column V_NBUR_I5X.F074        is 'Код щодо належності контрагента/пов’язаної з банком особи до групи юридичних осіб під спільним контролем або до групи по';
comment on column V_NBUR_I5X.S032        is 'Узагальнений код виду забезпечення кредиту';
comment on column V_NBUR_I5X.S183        is 'Узагальнений код початкових строків погашення';
comment on column V_NBUR_I5X.S241        is 'Узагальнений код строків до погашення';
comment on column V_NBUR_I5X.S260        is 'Код індивідуального споживання за цілями';
comment on column V_NBUR_I5X.F048        is 'Код типу процентної ставки';
comment on column V_NBUR_I5X.T070        is 'Сума';
comment on column V_NBUR_I5X.T090        is 'Процентна ставка';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_
I5X.sql =========*** End *** =
PROMPT ===================================================================================== 

