

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPLDOV.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view OPLDOV ***

  CREATE OR REPLACE FORCE VIEW BARS.OPLDOV ("REF", "TT", "DK", "ACC", "FDAT", "S", "SQ", "TXT", "STMT", "SOS") AS 
  SELECT o.REF,
          o.TT,
          o.DK,
          o.ACC,
          o.FDAT,
          o.S,
          o.SQ,
          o.TXT,
          o.STMT,
          o.SOS
     FROM opldok o, accounts a
    WHERE o.acc = a.acc AND a.nbs IS NOT NULL
   UNION ALL
   SELECT o.REF,
          o.TT,
          o.DK,
          a.ACCC,
          o.FDAT,
          o.S,
          o.SQ,
          o.TXT,
          o.STMT,
          o.SOS
     FROM opldok o, accounts a
    WHERE o.acc = a.acc AND a.nbs IS NULL AND a.accc IS NOT NULL;

PROMPT *** Create  grants  OPLDOV ***
grant SELECT                                                                 on OPLDOV          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPLDOV          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPLDOV          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OPLDOV          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPLDOV.sql =========*** End *** =======
PROMPT ===================================================================================== 
