

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_MAIN.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_MAIN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_MAIN ("REF", "ND", "NAZN", "DATD", "VDAT", "DK", "VBNAME", "MFOA", "NB_A", "ID_A", "NLSA", "NAM_A", "S", "KV_A", "LCV_A", "DIG_A", "GENDER_A", "MFOB", "NB_B", "ID_B", "NLSB", "NAM_B", "S2", "KV_B", "LCV_B", "DIG_B", "GENDER_B") AS 
  select  opr.ref, opr.nd, opr.nazn, opr.datd, opr.vdat, opr.dk, (select vb.name from vob vb where vb.vob = opr.vob),
        opr.mfoa, (select bnka.nb from banks bnka where bnka.mfo = opr.mfoa), opr.id_a, opr.nlsa, opr.nam_a, opr.s, kva.kv, kva.lcv, kva.dig, kva.gender,
        opr.mfob, (select bnkb.nb from banks bnkb where bnkb.mfo = opr.mfob), opr.id_b, opr.nlsb, opr.nam_b, opr.s2, kvb.kv, kvb.lcv, kvb.dig, kvb.gender
from    oper opr, tabval kva, tabval kvb
where opr.kv = kva.kv and opr.kv2 = kvb.kv(+);

PROMPT *** Create  grants  V_DOCUMENTVIEW_MAIN ***
grant SELECT                                                                 on V_DOCUMENTVIEW_MAIN to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_MAIN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_MAIN to START1;
grant SELECT                                                                 on V_DOCUMENTVIEW_MAIN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_MAIN.sql =========*** En
PROMPT ===================================================================================== 
