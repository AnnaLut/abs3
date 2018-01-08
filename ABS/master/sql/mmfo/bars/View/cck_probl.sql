

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CCK_PROBL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CCK_PROBL ***

  CREATE OR REPLACE FORCE VIEW BARS.CCK_PROBL ("BRANCH", "VIDD", "PROD", "RNK", "NMK", "ND", "CC_ID", "KV", "DAT1", "DAT4", "SDOG", "SDOGQ", "SS", "SN", "SP", "SL", "SPN", "SPN_30", "SLN", "DAT_SP", "DAT_SPN", "DNI_SP", "DNI_SPN") AS 
  SELECT d.BRANCH, d.VIDD, d.PROD, d.RNK, c.NMK, d.ND, d.CC_ID, p.KV, d.sdate DAT1, d.wdate DAT4, d.SDOG,
       gl.p_icurval(p.kv,d.sdog*100,gl.bd)/100 SDOGQ,   gl.p_icurval(p.kv, p.ss,  gl.bd)        SS,
       gl.p_icurval(p.kv, p.sn,  gl.bd)        SN,      gl.p_icurval(p.kv, p.sp,  gl.bd)        SP,
       gl.p_icurval(p.kv, p.sl,  gl.bd)        SL,      gl.p_icurval(p.kv, p.spn, gl.bd)        SPN,
       gl.p_icurval(p.kv, p.spn_30,gl.bd)      SPN_30,  gl.p_icurval(p.kv, p.sln, gl.bd)        SLN,
       F_GET_CCK_SPDAT (gl.BD, d.ND, 0)        DAT_SP,  /* Дата виникнення простроченої заборгованості за основним боргом. */
       F_GET_CCK_SPDAT (gl.BD, d.ND, 1)        DAT_SPN, /*---- Дата виникнення простроченої заборгованості за процентним боргом;*/
       gl.BD - F_GET_CCK_SPDAT (gl.BD,d.ND,0)  DNI_SP, 	/*---- Кількість днів простроченої заборгованості за основним боргом;*/
       gl.BD - F_GET_CCK_SPDAT (gl.BD,d.ND,1)  DNI_SPN  /*---- Кількість днів простроченої заборгованості за процентним боргом;*/
FROM cc_deal d,    customer c,
    (SELECT a.kv, n.nd,
           -NVL(SUM(DECODE(a.tip,'SS ',a.ostc, 0))       ,0)/100 ss , -NVL(SUM(DECODE(a.tip,'SN ',a.ostc ,0)),0)/100 sn,
           -NVL(SUM(DECODE(a.tip,'SP ',a.ostc, 0))       ,0)/100 sp , -NVL(SUM(DECODE(a.tip,'SL ',a.ostc ,0)),0)/100 sl,
           -NVL(SUM(DECODE(a.tip,'SLN',a.ostc, 0))       ,0)/100 sln, -NVL(SUM(DECODE(a.tip,'SPN',a.ost30,0)),0)/100 spn_30,
           -NVL(SUM(DECODE(a.tip,'SPN',a.ostc-a.ost30,0)),0)/100 spn
    FROM (SELECT kv,acc,tip,ostc,DECODE(tip,'SPN', -rez.f_get_rest_over_30 (acc, gl.bd), ostc) ost30
          FROM saldo  WHERE tip IN ('SS ', 'SP ', 'SL ', 'SN ', 'SPN', 'SLN')
          ) a,
         nd_acc n
    WHERE n.acc = a.acc
    GROUP BY a.kv, n.nd
    ) p
WHERE d.vidd IN (1,2,3,11,12,13) AND d.nd=p.nd AND c.rnk=d.rnk AND (p.sp<>0 OR p.spn<>0 OR p.spn_30<>0 OR p.sl<>0 OR p.sln<>0);

PROMPT *** Create  grants  CCK_PROBL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_PROBL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_PROBL       to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_PROBL       to WR_ALL_RIGHTS;
grant SELECT                                                                 on CCK_PROBL       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CCK_PROBL.sql =========*** End *** ====
PROMPT ===================================================================================== 
