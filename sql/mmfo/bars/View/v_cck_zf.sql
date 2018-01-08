

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ZF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ZF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ZF ("ISP", "ND", "CC_ID", "VIDD", "RNK", "KV", "S", "GPK", "DSDATE", "DWDATE", "PR", "OSTC", "SOS", "NAMK", "ACC8", "DAZS", "BRANCH", "CUSTTYPE", "PROD", "SDOG", "NDI", "TR") AS 
  SELECT x.ISP, x.ND, x.CC_ID, x.VIDD, x.RNK, x.KV, x.S, x.GPK,
       x.DSDATE, x.DWDATE, x.PR, x.OSTC, x.SOS, x.NAMK, x.ACC8, x.DAZS, x.BRANCH, x.CUSTTYPE,
       x.PROD, x.SDOG, x.NDI,  CASE WHEN VIDD in (12,13) and PR_TR='1' THEN  1 else  0  END TR
from ( SELECT d.user_id ISP, d.ND, d.CC_ID, d.VIDD, d.RNK, a8.KV, d.LIMIT S, a8.vid GPK, d.sdate DSDATE, D.wdate DWDATE,
          acrN.FPROCN (a8.ACC, 0, gl.bd) PR, -a8.ostc / 100 OSTC, d.SOS, C.NMK NAMK, a8.acc ACC8, a8.DAZS, d.BRANCH,
          DECODE (d.vidd,  1, 2,  2, 2,  3, 2,  3) CUSTTYPE,
          d.PROD, d.SDOG, d.NDI, (select txt from nd_txt where nd = d.ND and tag = 'PR_TR' )  PR_TR
       FROM CC_DEAL D, CUSTOMER C, ACCOUNTS A8, nd_acc N
       WHERE n.nd=d.nd AND C.RNK=D.RNK AND c.RNK=a8.rnk AND n.acc=a8.acc AND a8.tip='LIM'
         AND d.vidd IN (11,12,13 )     AND d.sos > 13
   ) x;

PROMPT *** Create  grants  V_CCK_ZF ***
grant SELECT                                                                 on V_CCK_ZF        to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_ZF        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ZF        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ZF.sql =========*** End *** =====
PROMPT ===================================================================================== 
