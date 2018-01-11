

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_105.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_105 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_105 ("KV", "LCV", "ID", "NLS", "NMK", "S", "SZ", "PR", "DATN", "DATP", "FDAT") AS 
  SELECT t.kv, t.lcv, k.nd, s.nls, c.nmk, d.s, -s.ost,
        acrn.fproc(d.accs,d.wdate), d.wdate,  k.wdate,  s.fdat
FROM tabval   t,
     cc_deal  k,
     customer c,
     cc_add   d,
     sal      s
WHERE s.acc=d.accs  AND
      s.kv=t.kv     AND
      d.nd=k.nd     AND
      k.rnk=c.rnk   AND
      c.custtype<>3 AND
      s.ost<0;

PROMPT *** Create  grants  KU_105 ***
grant SELECT                                                                 on KU_105          to BARSREADER_ROLE;
grant SELECT                                                                 on KU_105          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_105          to START1;
grant SELECT                                                                 on KU_105          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_105.sql =========*** End *** =======
PROMPT ===================================================================================== 
