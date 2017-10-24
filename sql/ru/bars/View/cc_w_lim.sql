

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W_LIM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W_LIM ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W_LIM ("ND", "FDAT", "LIM2", "SUMG", "SUMP", "SUMK", "SUMO", "OST", "OTM", "NOT_9129", "SUMP1", "SUMO1") AS 
  SELECT nd, fdat, LIM2/100, SUMG/100, sump/100, SUMK/100, SUMO/100, fOST_h(acc,fdat)/100, otm, not_9129, SUMP1/100,  (SUMO+sump1)/100
 FROM (SELECT acc, ND, FDAT, LIM2, NVL(SUMG,0) sumg, NVL(sumo,0)-NVL(sumg,0)-NVL(sumk,0) sump, NVL(SUMK,0) sumk, NVL(SUMO,0) sumo,
               NVL(otm,0) otm, NVL(not_9129,0) not_9129 ,
              NVL( (select o.s
                    FROM cc_add ad, opldok o,  (SELECT acc FROM accounts  WHERE tip = 'SNO') a
                   WHERE  o.tt = 'GPP' AND ad.refp = o.REF  AND o.dk = 1 AND o.acc = a.acc and last_day(o.fdat) = trunc(l.fdat,'MM')-1 and ad.nd = l.nd
                   ),0) sump1
       FROM cc_lim  L
       );

PROMPT *** Create  grants  CC_W_LIM ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_W_LIM        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_W_LIM        to RCC_DEAL;
grant SELECT                                                                 on CC_W_LIM        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_W_LIM        to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_W_LIM        to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_W_LIM        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W_LIM.sql =========*** End *** =====
PROMPT ===================================================================================== 
