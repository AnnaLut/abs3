PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f1x.sql =========*** Run *** ===
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_f1x ***

CREATE OR REPLACE VIEW v_nbur_f1x AS
SELECT p.REPORT_DATE
         , p.KF
         , p.VERSION_ID
         , p.NBUC
         , p.FIELD_CODE
         , substr(p.field_code, 1, 6)  as EKP
         , substr(p.field_code, 7, 1)  as K030
         , substr(p.field_code, 8, 3)  as R030
         , substr(p.field_code, 11, 3) as K040
         , p.FIELD_VALUE as T071
  FROM   NBUR_AGG_PROTOCOLS_ARCH p
         JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
         JOIN NBUR_LST_FILES v ON (v.REPORT_DATE = p.REPORT_DATE)
                                  AND (v.KF = p.KF)
                                  AND (v.VERSION_ID = p.VERSION_ID)
                                  AND (v.FILE_ID = f.ID)
  WHERE  p.REPORT_CODE = 'F1X'
         and f.FILE_FMT  = 'XML'
         AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED');
comment on table v_nbur_f1x is 'Файл F1X - Дані про перекази та надходження іноземної валюти фіз.осіб';
comment on column v_nbur_f1x.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_f1x.KF is 'Фiлiя';
comment on column v_nbur_f1x.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_f1x.NBUC is 'Код області управління розрізу юридичної особи';
comment on column v_nbur_f1x.FIELD_CODE is 'Зведений код показника';
comment on column v_nbur_f1x.EKP is 'Код показника';
comment on column v_nbur_f1x.K030 is 'Резидентнiсть';
comment on column v_nbur_f1x.R030 is 'Код валюти';
comment on column v_nbur_f1x.K040 is 'Код країни';
comment on column v_nbur_f1x.T071 is 'Сума у валюті';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f1x.sql =========*** End *** ===
PROMPT ===================================================================================== 