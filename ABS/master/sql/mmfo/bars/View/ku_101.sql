

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_101.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_101 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_101 ("KV", "LCV", "ID", "NLS", "NMK", "S", "PR", "DATN", "DATP") AS 
  SELECT t.kv,t.lcv,k.nd,a.nls,c.nmk,d.s, acrn.fproc(d.accs,d.wdate),d.wdate,k.wdate
FROM tabval t,cc_deal k, accounts a, customer c,cc_add d
WHERE a.acc =d.accs AND
      a.kv=t.kv    AND
      d.nd=k.nd    AND
      d.adds=0     AND
      k.rnk=c.rnk  AND
      c.custtype<>3;

PROMPT *** Create  grants  KU_101 ***
grant SELECT                                                                 on KU_101          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_101          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_101.sql =========*** End *** =======
PROMPT ===================================================================================== 
