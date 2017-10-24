

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPL_ACC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view OPL_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.OPL_ACC ("ACC", "TT", "REF", "KV", "NLS", "NMS", "DK", "S", "SQ", "FDAT", "SOS", "NAZN", "STMT", "TIP") AS 
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
          o.txt nazn,
          o.stmt,
          a.tip
     FROM accounts a, opldok o
    WHERE a.acc = o.acc;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPL_ACC.sql =========*** End *** ======
PROMPT ===================================================================================== 
