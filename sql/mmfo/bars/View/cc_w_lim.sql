

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W_LIM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W_LIM ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W_LIM ("ND", "FDAT", "OTM", "NOT_9129", "LIM2", "SUMG", "SUMP", "SUMK", "SUMO", "SUMP1", "OST", "SUMO1", "SN") AS 
  SELECT nd, fdat, otm, NOT_9129,   LIM2/100 LIM2,  SUMG/100 SUMG,  sump/100 SUMP,  SUMK/100 SUMK,  SUMO/100 SUMO,  SUMP1/100 SUMP1,
         fOST_h(acc,fdat)/100 OST,  (SUMO+sump1)/100 SUMO1   , not_sn SN
   FROM (SELECT acc,ND,FDAT,LIM2, NVL(SUMG,0) sumg, NVL(sumo,0)-NVL(sumg,0)-NVL(sumk,0) sump, NVL(SUMK,0) sumk, NVL(SUMO,0) sumo,
                0 sump1, NVL(otm,0) otm, NVL(not_9129,0) not_9129 , not_sn
         FROM cc_lim
      UNION ALL
         SELECT a.acc, ad.nd, o.fdat, 0, 0, 0, 0, 0, o.s sump1, 0, 0 , null
         FROM cc_add ad,  opldok o,  (SELECT * FROM accounts WHERE tip = 'SNO') a
         WHERE  o.tt = 'GPP'  AND ad.refp = o.REF  AND o.dk = 1  AND o.acc = a.acc
         );

PROMPT *** Create  grants  CC_W_LIM ***
grant SELECT                                                                 on CC_W_LIM        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_W_LIM        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_W_LIM        to RCC_DEAL;
grant SELECT                                                                 on CC_W_LIM        to START1;
grant SELECT                                                                 on CC_W_LIM        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_W_LIM        to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_W_LIM        to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_W_LIM        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W_LIM.sql =========*** End *** =====
PROMPT ===================================================================================== 
