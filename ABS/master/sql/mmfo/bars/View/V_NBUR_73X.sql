PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_73x.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_73x ***

CREATE OR REPLACE VIEW V_NBUR_73X AS
SELECT p.REPORT_DATE
         , p.KF
         , p.VERSION_ID
         , p.NBUC
         , p.FIELD_CODE
         , substr(p.FIELD_CODE, 1, 6) as EKP
         , substr(p.field_code, 7, 3) as R030
         , p.FIELD_VALUE as T100
  FROM   NBUR_AGG_PROTOCOLS_ARCH p
         JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
         JOIN NBUR_LST_FILES v ON (v.REPORT_DATE = p.REPORT_DATE)
                                  AND (v.KF = p.KF)
                                  AND (v.VERSION_ID = p.VERSION_ID)
                                  AND (v.FILE_ID = f.ID)
  WHERE  p.REPORT_CODE = '73X'
         and f.FILE_FMT  = 'XML'
         AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED');
comment on table V_NBUR_73X is 'Файл 73X - Оборот готівкової іноземної валюти та фізичних обсягів банківських металів';
comment on column V_NBUR_73X.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_73X.KF is 'Фiлiя';
comment on column V_NBUR_73X.VERSION_ID is 'Номер версії файлу';
comment on column V_NBUR_73X.NBUC is 'Код області управління розрізу юридичної особи';
comment on column V_NBUR_73X.FIELD_CODE is 'Зведений код показника';
comment on column V_NBUR_73X.EKP is 'Код показника';
comment on column V_NBUR_73X.R030 is 'Код валюти';
comment on column V_NBUR_73X.T100 is 'Сума в іноземній валюті/Кількість ПОВ';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_73x.sql =========*** End *** =
PROMPT ===================================================================================== 