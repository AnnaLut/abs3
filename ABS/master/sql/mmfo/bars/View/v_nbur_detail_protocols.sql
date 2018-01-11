

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_DETAIL_PROTOCOLS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_DETAIL_PROTOCOLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_DETAIL_PROTOCOLS ("REPORT_DATE", "KF", "VERSION_ID", "REPORT_CODE", "NBUC", "FIELD_CODE", "FIELD_VALUE", "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "MATURITY_DATE", "CUST_ID", "CUST_CODE", "CUST_NMK", "ND", "AGRM_NUM", "BEG_DT", "END_DT", "REF", "BRANCH") AS 
  SELECT p.REPORT_DATE,
          p.KF,
          p.VERSION_ID,
          p.REPORT_CODE,
          p.NBUC,
          p.FIELD_CODE,
          p.FIELD_VALUE,
          p.DESCRIPTION,
          NVL (p.ACC_ID, b.acc),
          NVL (p.ACC_NUM, b.nls),
          NVL (p.KV, b.kv),
          NVL (p.MATURITY_DATE, b.mdate),
          NVL (p.CUST_ID, b.rnk),
          c.okpo CUST_CODE,
          c.nmk CUST_NMK,
          a.nd ND,
          a.CC_ID AGRM_NUM,
          a.sdate BEG_DT,
          a.wdate END_DT,
          p.REF,
          NVL (TRIM (p.branch), b.BRANCH)
     FROM NBUR_DETAIL_PROTOCOLS_ARCH p
          LEFT OUTER JOIN
          accounts b
             ON (   p.kf = b.kf AND P.ACC_ID = b.acc
                 OR p.kf = b.kf AND p.acc_num = b.nls AND p.kv = b.kv)
          LEFT OUTER JOIN customer c ON (p.kf = c.kf AND P.CUST_ID = c.rnk)
          LEFT OUTER JOIN cc_deal a ON (p.kf = a.kf AND P.nd = a.nd);

PROMPT *** Create  grants  V_NBUR_DETAIL_PROTOCOLS ***
grant SELECT                                                                 on V_NBUR_DETAIL_PROTOCOLS to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_DETAIL_PROTOCOLS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_DETAIL_PROTOCOLS to RPBN002;
grant SELECT                                                                 on V_NBUR_DETAIL_PROTOCOLS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_DETAIL_PROTOCOLS.sql =========**
PROMPT ===================================================================================== 
