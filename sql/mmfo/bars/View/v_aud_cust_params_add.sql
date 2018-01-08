

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_AUD_CUST_PARAMS_ADD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_AUD_CUST_PARAMS_ADD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_AUD_CUST_PARAMS_ADD ("BRANCH", "RNK", "OKPO", "NMK", "UUCG", "UUDV") AS 
  SELECT c.branch,
          c.rnk,
          c.okpo,
          c.nmk,
          substr(p1.VALUE,1,10) UUCG,
          substr(p2.VALUE,1,10) UUDV
     FROM  customer c, customerw p1, customerw p2
    WHERE     c.date_off  IS NULL
          AND c.rnk = p1.rnk(+)
          AND c.rnk = p2.rnk(+)
          AND p1.tag(+)='UUCG'
          and p2.tag(+)='UUDV'
          and c.custtype=2;

PROMPT *** Create  grants  V_AUD_CUST_PARAMS_ADD ***
grant SELECT,UPDATE                                                          on V_AUD_CUST_PARAMS_ADD to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_AUD_CUST_PARAMS_ADD to CUST001;
grant SELECT,UPDATE                                                          on V_AUD_CUST_PARAMS_ADD to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_AUD_CUST_PARAMS_ADD.sql =========*** 
PROMPT ===================================================================================== 
