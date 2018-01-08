

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMERW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMERW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMERW ("RNK", "TAG", "VALUE", "ISP") AS 
  SELECT c.RNK,
          c.TAG,
          c.VALUE,
          c.ISP
     FROM customerw c
   UNION ALL
   SELECT cc.RNK,
          cc.TAG,
          cc.VALUE,
          0 AS ISP
     FROM clv_customerw cc, clv_request q
    WHERE cc.rnk = q.rnk AND q.req_type IN (0, 2);

PROMPT *** Create  grants  V_CUSTOMERW ***
grant SELECT                                                                 on V_CUSTOMERW     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMERW     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMERW     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMERW.sql =========*** End *** ==
PROMPT ===================================================================================== 
