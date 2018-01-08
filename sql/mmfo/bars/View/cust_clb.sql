

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_CLB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_CLB ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_CLB ("RNK", "OKPO", "NMK", "ACC", "NLS", "NMS", "CLBID", "NAME") AS 
  SELECT
      C.RNK,
      C.OKPO,
      C.NMK,
      A.ACC,
      A.NLS,
      A.NMS,
      CL.CLBID,
      CL.NAME
   FROM
      BARS.CUSTOMER C,
      BARS.ACCOUNTS A,
      BARS.CLBANKS  CL,
      BARS.CUST_ACC CA,
      BARS.ACC_CLB  AC
   WHERE
      AC.CLBID = CL.CLBID AND
      AC.ACC   = CA.ACC   AND
      A.ACC    = CA.ACC   AND
      C.RNK    = CA.RNK
   WITH READ ONLY;

PROMPT *** Create  grants  CUST_CLB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_CLB        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_CLB        to CUST_CLB;
grant FLASHBACK,SELECT                                                       on CUST_CLB        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_CLB.sql =========*** End *** =====
PROMPT ===================================================================================== 
