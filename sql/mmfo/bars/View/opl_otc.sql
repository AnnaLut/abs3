

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPL_OTC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view OPL_OTC ***

  CREATE OR REPLACE FORCE VIEW BARS.OPL_OTC ("ACC", "TT", "REF", "KV", "NLS", "NMS", "DK", "S", "SQ", "FDAT", "SOS", "NAZN", "STMT", "TIP", "PSOS", "PTT", "PDK", "PNLSA", "PNLSB", "PKV", "PSK") AS 
  SELECT o.acc,
          o.tt,
          o.REF,
          a.kv,
          a.nls,
          a.nms,
          o.dk,
          o.s,
          o.sq,
          o.fdat,
          o.sos,
          p.nazn,
          o.stmt,
          a.tip,
          p.sos,
          p.tt,
          p.dk,
          p.nlsa,
          p.nlsb,
          p.kv,
          p.sk
     FROM accounts a, opldok o, oper p
    WHERE a.acc = o.acc AND o.REF = p.REF;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPL_OTC.sql =========*** End *** ======
PROMPT ===================================================================================== 
