
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_nbur_dm_customers.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_DM_CUSTOMERS ("REPORT_DATE", "KF", "CUST_ID", "CUST_TYPE", "CUST_CODE", "CUST_NAME", "OPEN_DATE", "CLOSE_DATE", "BRANCH", "TAX_REG_ID", "TAX_DST_ID", "CRISK", "K030", "K040", "K051", "K060", "K070", "K072", "K074", "K080", "K081", "K110", "K111", "K112") AS 
  SELECT /*+ leading(o v) full(c) no_push_pred */
         v.REPORT_DATE,
          v.KF,
          c.CUST_ID,
          c.CUST_TYPE,
          c.CUST_CODE,
          c.CUST_NAME,
          c.OPEN_DATE,
          c.CLOSE_DATE,
          c.BRANCH,
          c.TAX_REG_ID,
          c.TAX_DST_ID,
          c.CRISK,
          c.K030,
          c.K040,
          c.K051,
          c.K060,
          c.K070,
          c.K072,
          c.K074,
          c.K080,
          c.K081,
          c.K110,
          c.K111,
          c.K112
     FROM NBUR_REF_OBJECTS o
          JOIN NBUR_LST_OBJECTS v ON (v.OBJECT_ID = o.ID)
          JOIN NBUR_DM_CUSTOMERS_ARCH c
             ON (    c.REPORT_DATE = v.REPORT_DATE
                 AND c.KF = v.KF
                 AND c.VERSION_ID = v.VERSION_ID)
    WHERE o.OBJECT_NAME = 'NBUR_DM_CUSTOMERS' AND V.VLD = 0
;
 show err;
 
PROMPT *** Create  grants  V_NBUR_DM_CUSTOMERS ***
grant SELECT                                                                 on V_NBUR_DM_CUSTOMERS to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_DM_CUSTOMERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_DM_CUSTOMERS to RPBN002;
grant SELECT                                                                 on V_NBUR_DM_CUSTOMERS to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_nbur_dm_customers.sql =========*** En
 PROMPT ===================================================================================== 
 