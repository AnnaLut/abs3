PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_X2X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_X2X ***

create or replace view v_nbur_X2X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/F099') as F099
          , extractValue(COLUMN_VALUE, 'DATA/Q003_4') as Q003_4
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = 'X2X'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_X2X is 'Файл X2X - Дані про концетрацію ризиків за пасивними операціями банку';
comment on column V_NBUR_X2X.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_X2X.KF is 'Фiлiя';
comment on column V_NBUR_X2X.VERSION_ID is 'Номер версії файлу';
comment on column V_NBUR_X2X.EKP    is 'Код показника';
comment on column V_NBUR_X2X.F099   is 'Код даних для розрахунку економічних нормативів';
comment on column V_NBUR_X2X.Q003_4 is 'Умовний порядковий номер контрагента';
comment on column V_NBUR_X2X.T070   is 'Сума';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_X2X.sql =========*** End *** =
PROMPT ===================================================================================== 