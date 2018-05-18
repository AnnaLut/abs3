

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3_SNO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V3_SNO ***

  CREATE OR REPLACE FORCE VIEW BARS.V3_SNO ("REF", "STMT", "ND", "NLS", "KV", "FDAT", "S") AS 
  SELECT o.ref, o.stmt, ad.nd, a.nls, a.kv, o.fdat, o.s / 100 s
  FROM cc_add ad, opldok o, (SELECT * FROM accounts WHERE tip = 'SNO') a
 WHERE o.tt = 'GPP'
   AND ad.refp = o.ref
   AND o.dk = 1
   AND o.acc = a.acc;

PROMPT *** Create  grants  V3_SNO ***
grant SELECT                                                                 on V3_SNO          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3_SNO          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3_SNO.sql =========*** End *** =======
PROMPT ===================================================================================== 
