

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_102.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_102 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_102 ("KV", "LCV", "ID", "NLS", "NMK", "S", "DOS", "KOS", "PR", "DATN", "DATP", "FDAT") AS 
  SELECT t.kv,t.lcv, k.nd, s.nls, c.nmk, -s.ost, s.dos, s.kos,
       acrn.fproc(d.accs,d.wdate), d.wdate, k.wdate, s.fdat
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

PROMPT *** Create  grants  KU_102 ***
grant SELECT                                                                 on KU_102          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_102          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_102.sql =========*** End *** =======
PROMPT ===================================================================================== 
