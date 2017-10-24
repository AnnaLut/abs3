

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V11_SNO_FL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V11_SNO_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V11_SNO_FL ("REFP", "VDAT", "ND", "NDI", "SDATE", "WDATE", "SOS", "RNK", "BRANCH", "CC_ID", "KV", "NLS", "TIP", "ACC", "SNO", "LIM", "SNOB", "OTM1", "OTM2") AS 
  SELECT c.refp, o.vdat , d.ND, d.NDI, d.SDATE, d.WDATE, d.SOS, d.RNK, d.BRANCH, d.CC_ID, a.KV, a.NLS, a.TIP, a.ACC,  -a.OSTC/100 SNO,
          (SELECT -ostc/100 FROM accounts aa, nd_acc nn WHERE nn.nd=d.nd AND nn.acc=aa.acc AND aa.tip='LIM')   LIM,
          (a.ostf + a.ostc)/100  SNOB,  0 OTM1, 0 OTM2
 FROM accounts a,  cc_deal d,  nd_acc n,  cc_add c,  oper o
 WHERE d.nd=c.nd AND c.adds=0  AND c.refp =o.REF AND o.REF > 0  AND A.ACC = N.ACC   AND A.TIP = 'SNO' AND N.ND = D.ND
   AND D.VIDD IN (11, 12, 13)  AND (A.OSTC <> 0 OR a.ostf <> 0) AND d.branch LIKE SYS_CONTEXT('bars_context','user_branch')||'%';

PROMPT *** Create  grants  V11_SNO_FL ***
grant SELECT                                                                 on V11_SNO_FL      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V11_SNO_FL.sql =========*** End *** ===
PROMPT ===================================================================================== 
