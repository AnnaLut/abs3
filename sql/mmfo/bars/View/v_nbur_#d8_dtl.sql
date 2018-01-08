

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#D8_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#D8_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#D8_DTL ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "SEG_06", "SEG_07", "SEG_08", "SEG_09", "FIELD_VALUE", "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "MATURITY_DATE", "CUST_ID", "CUST_CODE", "CUST_NAME", "ND", "AGRM_NUM", "BEG_DT", "END_DT", "REF", "BRANCH") AS 
  SELECT p.REPORT_DATE,
          p.KF,
          p.VERSION_ID,
          p.NBUC,
          p.FIELD_CODE,
          SUBSTR (p.FIELD_CODE, 1, 3) AS SEG_01,
          SUBSTR (p.FIELD_CODE, 4, 10) AS SEG_02,
          SUBSTR (p.FIELD_CODE, 14, 4) AS SEG_03,
          SUBSTR (p.FIELD_CODE, 18, 4) AS SEG_04,
          SUBSTR (p.FIELD_CODE, 22, 3) AS SEG_05,
          SUBSTR (p.FIELD_CODE, 25, 2) AS SEG_06,
          SUBSTR (p.FIELD_CODE, 27, 1) AS SEG_07,
          SUBSTR (p.FIELD_CODE, 28, 1) AS SEG_08,
          SUBSTR (p.FIELD_CODE, 29, 2) AS SEG_09,
          p.FIELD_VALUE,
          p.DESCRIPTION,
          p.ACC_ID,
          p.ACC_NUM,
          p.KV,
          p.MATURITY_DATE,
          p.CUST_ID,
          c.CUST_CODE,
          c.CUST_NAME,
          p.ND,
          a.CC_ID,
          a.SDATE,
          a.WDATE,
          p.REF,
          p.BRANCH
     FROM NBUR_DETAIL_PROTOCOLS_ARCH p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
          JOIN NBUR_LST_FILES v
             ON (    v.REPORT_DATE = p.REPORT_DATE
                 AND v.KF = p.KF
                 AND v.VERSION_ID = p.VERSION_ID
                 AND v.FILE_ID = f.ID)
          LEFT OUTER JOIN V_NBUR_DM_CUSTOMERS c
             ON (    p.REPORT_DATE = c.REPORT_DATE
                 AND p.KF = c.KF
                 AND p.CUST_ID = c.CUST_ID)
          LEFT OUTER JOIN CC_DEAL a -- V_NBUR_DM_AGREEMENTS
             ON ( p.KF = a.KF AND p.ND = a.ND )
    WHERE p.REPORT_CODE = '#D8' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

PROMPT *** Create  grants  V_NBUR_#D8_DTL ***
grant SELECT                                                                 on V_NBUR_#D8_DTL  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#D8_DTL.sql =========*** End ***
PROMPT ===================================================================================== 
