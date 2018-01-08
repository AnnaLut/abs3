

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_FORM_REVERS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_FORM_REVERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_FORM_REVERS ("REF", "TT", "NLSA", "NLSB", "S", "KV", "NAZN", "PDAT") AS 
  SELECT t.REF,
          t.tt,
          t.nlsa,
          t.nlsb,
          t.s,
          t.kv,
          t.nazn,
          t.pdat
     FROM oper t
    WHERE t.tt IN ('WO5', 'WO6') AND t.vdat = TRUNC (SYSDATE) AND t.sos in(0,1);

PROMPT *** Create  grants  V_OW_FORM_REVERS ***
grant SELECT                                                                 on V_OW_FORM_REVERS to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_OW_FORM_REVERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_FORM_REVERS to START1;
grant SELECT                                                                 on V_OW_FORM_REVERS to UPLD;
grant FLASHBACK,SELECT                                                       on V_OW_FORM_REVERS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_FORM_REVERS.sql =========*** End *
PROMPT ===================================================================================== 
