

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_3KX.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_3KX ***

CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_3KX
( "REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "FIELD_VALUE" )
AS
   SELECT p.REPORT_DATE,
          p.KF,
          p.VERSION_ID,
          p.NBUC,
          p.FIELD_CODE,
          SUBSTR (p.FIELD_CODE, 1, 4) AS SEG_01,
          SUBSTR (p.FIELD_CODE, 5, 3) AS SEG_02,
          p.FIELD_VALUE
     FROM NBUR_AGG_PROTOCOLS_ARCH p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
          JOIN
          NBUR_LST_FILES v
             ON (    v.REPORT_DATE = p.REPORT_DATE
                 AND v.KF = p.KF
                 AND v.VERSION_ID = p.VERSION_ID
                 AND v.FILE_ID = f.ID)
    WHERE p.REPORT_CODE = '#3K' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
    order by SUBSTR (p.FIELD_CODE, 5, 3);

COMMENT ON TABLE BARS.V_NBUR_3KX IS '3KX - Дані про купівлю, продаж безготівкової іноземної валюти';

COMMENT ON COLUMN BARS.V_NBUR_3KX.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.V_NBUR_3KX.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.V_NBUR_3KX.VERSION_ID IS 'Ід. версії файлу';
COMMENT ON COLUMN BARS.V_NBUR_3KX.NBUC IS 'Код розрізу даних у звітному файлі';
COMMENT ON COLUMN BARS.V_NBUR_3KX.FIELD_CODE IS 'Код показника';
COMMENT ON COLUMN BARS.V_NBUR_3KX.SEG_01 IS 'Елемент';
COMMENT ON COLUMN BARS.V_NBUR_3KX.SEG_02 IS 'Умовний номер';
COMMENT ON COLUMN BARS.V_NBUR_3KX.FIELD_VALUE IS 'Значення показника';


GRANT SELECT ON BARS.V_NBUR_3KX TO BARSREADER_ROLE;
GRANT SELECT ON BARS.V_NBUR_3KX TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_NBUR_3KX TO UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_3KX.sql =========*** End *** ===
PROMPT ===================================================================================== 

