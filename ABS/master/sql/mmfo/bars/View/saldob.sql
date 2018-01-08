

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDOB.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDOB ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDOB ("ACC", "FDAT", "PDAT", "OSTF", "DOS", "KOS") AS 
  SELECT b.acc,
          b.fdat,
          b.fdat - 1,
          b.ostq + b.dosq - b.kosq,
          b.dosq,
          b.kosq
     FROM snap_balances b, accounts a
    WHERE a.acc = b.acc AND kv <> 980;

PROMPT *** Create  grants  SALDOB ***
grant SELECT                                                                 on SALDOB          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on SALDOB          to BARSREADER_ROLE;
grant SELECT                                                                 on SALDOB          to DM;
grant SELECT                                                                 on SALDOB          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDOB.sql =========*** End *** =======
PROMPT ===================================================================================== 
