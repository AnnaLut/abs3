CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#F4
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   NBUC,
   FIELD_CODE,
   SEG_01,
   SEG_02,
   SEG_03,
   SEG_04,
   SEG_05,
   SEG_06,
   SEG_07,
   SEG_08,
   SEG_09,
   SEG_10,
   SEG_11,   
   FIELD_VALUE
)
AS
   SELECT p.REPORT_DATE,
          p.KF,
          p.VERSION_ID,
          p.NBUC,
          p.FIELD_CODE,
          SUBSTR (p.FIELD_CODE, 1, 1) AS SEG_01,
          SUBSTR (p.FIELD_CODE, 2, 1) AS SEG_02,
          SUBSTR (p.FIELD_CODE, 3, 4) AS SEG_03,
          SUBSTR (p.FIELD_CODE, 7, 1) AS SEG_04,
          SUBSTR (p.FIELD_CODE, 8, 1) AS SEG_05,
          SUBSTR (p.FIELD_CODE, 9, 1) AS SEG_06,
          SUBSTR (p.FIELD_CODE, 10, 1) AS SEG_07,
          SUBSTR (p.FIELD_CODE, 11, 1) AS SEG_08,
          SUBSTR (p.FIELD_CODE, 12, 2) AS SEG_09,
          SUBSTR (p.FIELD_CODE, 14, 3) AS SEG_10,
          SUBSTR (p.FIELD_CODE, 17, 1) AS SEG_11,
          p.FIELD_VALUE
     FROM NBUR_AGG_PROTOCOLS_ARCH p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
          JOIN
          NBUR_LST_FILES v
             ON (    v.REPORT_DATE = p.REPORT_DATE
                 AND v.KF = p.KF
                 AND v.VERSION_ID = p.VERSION_ID
                 AND v.FILE_ID = f.ID)
    WHERE p.REPORT_CODE = '#F4' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

COMMENT ON TABLE BARS.V_NBUR_#F4 IS '#F4 - Звіт про суми та процентні ставки за наданими кредитами та залученими';

COMMENT ON COLUMN BARS.V_NBUR_#F4.REPORT_DATE IS 'Звітна дата';

COMMENT ON COLUMN BARS.V_NBUR_#F4.KF IS 'Код фiлiалу (МФО)';

COMMENT ON COLUMN BARS.V_NBUR_#F4.VERSION_ID IS 'Ід. версії файлу';

COMMENT ON COLUMN BARS.V_NBUR_#F4.NBUC IS 'Код розрізу даних у звітному файлі';

COMMENT ON COLUMN BARS.V_NBUR_#F4.FIELD_CODE IS 'Код показника';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_01 IS '1 - сума, 2 - %% ставка';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_02 IS '5-Дт оборот 6-Кт оборот';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_03 IS 'Бал. рах.';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_04 IS 'Параметр R013';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_05 IS 'Код секцii виду економ. дiяльностi';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_06 IS 'Код сектора економiки';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_07 IS 'Код початкового строку погашення';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_08 IS 'Резиден тнiсть';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_09 IS 'Параметр D020';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_10 IS 'Код валюти';

COMMENT ON COLUMN BARS.V_NBUR_#F4.SEG_11 IS 'Код розміру суб.госп-ня';

COMMENT ON COLUMN BARS.V_NBUR_#F4.FIELD_VALUE IS 'Значення показника';



GRANT SELECT ON BARS.V_NBUR_#F4 TO BARSREADER_ROLE;

GRANT SELECT ON BARS.V_NBUR_#F4 TO BARS_ACCESS_DEFROLE;
