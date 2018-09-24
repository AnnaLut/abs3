PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_26X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_26X ***

create or replace view v_nbur_26X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/T020') as T020
          , extractValue(COLUMN_VALUE, 'DATA/R020') as R020
          , extractValue(COLUMN_VALUE, 'DATA/R011') as R011
          , extractValue(COLUMN_VALUE, 'DATA/R013') as R013
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/K040') as K040
          , extractValue(COLUMN_VALUE, 'DATA/Q001') as Q001
          , extractValue(COLUMN_VALUE, 'DATA/K020') as K020
          , extractValue(COLUMN_VALUE, 'DATA/K021') as K021
          , extractValue(COLUMN_VALUE, 'DATA/K180') as K180
          , extractValue(COLUMN_VALUE, 'DATA/K190') as K190
          , extractValue(COLUMN_VALUE, 'DATA/S181') as S181
          , extractValue(COLUMN_VALUE, 'DATA/S245') as S245
          , extractValue(COLUMN_VALUE, 'DATA/S580') as S580
          , extractValue(COLUMN_VALUE, 'DATA/F033') as F033
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
          , extractValue(COLUMN_VALUE, 'DATA/T071') as T071
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '26X'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_26X is 'Файл 26X - Дані про концетрацію ризиків за пасивними операціями банку';
comment on column V_NBUR_26X.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_26X.KF is 'Фiлiя';
comment on column V_NBUR_26X.VERSION_ID is 'Номер версії файлу';
comment on column V_NBUR_26X.EKP    is 'Код показника';
comment on column V_NBUR_26X.T020   is 'Код елементу даних за рахунком';
comment on column V_NBUR_26X.R020   is 'Номер баланс./позабаланс. рахунку';
comment on column V_NBUR_26X.R011   is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_26X.R013   is 'Код за параметром розподілу аналітичного рахунку R013';
comment on column V_NBUR_26X.R030   is 'Код валюти';
comment on column V_NBUR_26X.K040   is 'Код країни учасника банку';
comment on column V_NBUR_26X.Q001   is 'Назва банку-резидента/банку-нерезидента';
comment on column V_NBUR_26X.K020   is 'Код учаснику банку';
comment on column V_NBUR_26X.K021   is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column V_NBUR_26X.K180   is 'Код належності банку до інвестиційного класу';
comment on column V_NBUR_26X.K190   is 'Код рівня надійності';
comment on column V_NBUR_26X.S181   is 'Код початкового строку погашення';
comment on column V_NBUR_26X.S245   is 'Код узагальненого кінцевого строку погашення';
comment on column V_NBUR_26X.S580   is 'Код розподілу активів за групами ризик';
comment on column V_NBUR_26X.F033   is 'Код ознаки обтяженості коштів';
comment on column V_NBUR_26X.T070   is 'Сума в національній валюті (грн.екв.)';
comment on column V_NBUR_26X.T071   is 'Сума в іноземній валюті';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_26X.sql =========*** End *** =
PROMPT ===================================================================================== 

