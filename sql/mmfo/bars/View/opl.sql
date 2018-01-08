

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPL.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view OPL ***

  CREATE OR REPLACE FORCE VIEW BARS.OPL ("ACC", "TT", "REF", "KV", "NLS", "NMS", "DK", "S", "SQ", "FDAT", "SOS", "NAZN", "STMT", "TIP") AS 
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
          a.tip
     FROM accounts a, opldok o, oper p
    WHERE a.acc = o.acc AND o.REF = p.REF;

PROMPT *** Create  grants  OPL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OPL             to ABS_ADMIN;
grant SELECT                                                                 on OPL             to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OPL             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPL             to INSPECTOR;
grant SELECT                                                                 on OPL             to PYOD001;
grant SELECT                                                                 on OPL             to RPBN001;
grant SELECT                                                                 on OPL             to START1;
grant SELECT                                                                 on OPL             to TEST;
grant SELECT                                                                 on OPL             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPL             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPL.sql =========*** End *** ==========
PROMPT ===================================================================================== 
