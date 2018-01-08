

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_110.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_110 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_110 ("KV", "LCV", "ID", "NLS", "NMK", "S", "PR", "DATN", "DATP", "MES", "OST", "DOS", "KOS", "FDAT") AS 
  SELECT t.kv,t.lcv, k.nd, s.nls, c.nmk, d.s, acrn.fproc(d.accs,s.fdat),
       d.wdate, k.wdate, fsrok(k.nd), -s.ost, s.dos, s.kos, s.fdat
FROM tabval   t,
     cc_deal  k,
     customer c,
     cc_add   d,
     sal      s
WHERE s.acc=d.accs  AND
      s.kv=t.kv     AND
      d.nd=k.nd     AND
      k.rnk=c.rnk   AND
      c.custtype<>3;

PROMPT *** Create  grants  KU_110 ***
grant SELECT                                                                 on KU_110          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_110          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_110.sql =========*** End *** =======
PROMPT ===================================================================================== 
