

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_103.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_103 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_103 ("KV", "LCV", "ID", "NLS", "NMK", "ADR", "OKPO", "S", "DOS", "KOS", "PR", "DATN", "DATP", "NAME", "FDAT") AS 
  SELECT t.kv,t.lcv, k.nd, s.nls, c.nmk, c.adr, c.okpo,
       -s.ost, s.dos, s.kos, acrn.fproc(d.accs,d.wdate),
       d.wdate, k.wdate, n.name, s.fdat
FROM tabval t,
     cc_deal k,
     customer c,
     cc_add d,
     sal s,
     cc_sos n
WHERE s.acc=d.accs  AND
      s.kv=t.kv     AND
      d.nd=k.nd     AND
      k.rnk=c.rnk   AND
      c.prinsider not in(0,99)   AND
      n.sos=k.sos;

PROMPT *** Create  grants  KU_103 ***
grant SELECT                                                                 on KU_103          to BARSREADER_ROLE;
grant SELECT                                                                 on KU_103          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_103          to START1;
grant SELECT                                                                 on KU_103          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_103.sql =========*** End *** =======
PROMPT ===================================================================================== 
