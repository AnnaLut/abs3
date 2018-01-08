

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#D9_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#D9_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#D9_DTL ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "FIELD_VALUE", "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "MATURITY_DATE", "CUST_ID", "CUST_CODE", "CUST_NAME", "ND", "AGRM_NUM", "BEG_DT", "END_DT", "REF", "BRANCH") AS 
  SELECT p.REPORT_DATE,
          p.KF,
          p.VERSION_ID,
          p.NBUC,
          p.FIELD_CODE,
          SUBSTR (p.FIELD_CODE, 1, 3) AS SEG_01,
          SUBSTR (p.FIELD_CODE, 4, 10) AS SEG_02,
          SUBSTR (p.FIELD_CODE, 14, 10) AS SEG_03,
          SUBSTR (p.FIELD_CODE, 24, 1) AS SEG_04,
          SUBSTR (p.FIELD_CODE, 25, 1) AS SEG_05,
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
          a.AGRM_NUM,
          a.BEG_DT,
          a.END_DT,
          p.REF,
          p.BRANCH
     FROM NBUR_DETAIL_PROTOCOLS_ARCH p
          JOIN NBUR_REF_FILES f ON (f.FILE_CODE = p.REPORT_CODE)
          JOIN
          NBUR_LST_FILES v
             ON (    v.REPORT_DATE = p.REPORT_DATE
                 AND v.KF = p.KF
                 AND v.VERSION_ID = p.VERSION_ID
                 AND v.FILE_ID = f.ID)
          LEFT OUTER JOIN
          V_NBUR_DM_CUSTOMERS c
             ON (    p.REPORT_DATE = c.REPORT_DATE
                 AND p.KF = c.KF
                 AND p.CUST_ID = c.CUST_ID)
          LEFT OUTER JOIN
          V_NBUR_DM_AGREEMENTS a
             ON (    p.REPORT_DATE = a.REPORT_DATE
                 AND p.KF = a.KF
                 AND p.nd = a.AGRM_ID)
    WHERE p.REPORT_CODE = '#D9' AND v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

PROMPT *** Create  grants  V_NBUR_#D9_DTL ***
grant SELECT                                                                 on V_NBUR_#D9_DTL  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#D9_DTL.sql =========*** End ***
PROMPT ===================================================================================== 
