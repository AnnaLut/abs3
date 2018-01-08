

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACCM_SNAP_BALANCES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view ACCM_SNAP_BALANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.ACCM_SNAP_BALANCES ("CALDT_ID", "ACC", "RNK", "OST", "OSTQ", "DOS", "DOSQ", "KOS", "KOSQ") AS 
  SELECT x.caldt_id, b.acc, b.rnk, b.ost, b.ostq, b.dos, b.dosq, b.kos,
          b.kosq
     FROM snap_balances b,
          (SELECT     LEVEL - 1 caldt_id
                 FROM DUAL
           CONNECT BY LEVEL < 100000) x
    WHERE b.fdat = TO_DATE (x.caldt_id + 2447892, 'J');

PROMPT *** Create  grants  ACCM_SNAP_BALANCES ***
grant SELECT                                                                 on ACCM_SNAP_BALANCES to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCM_SNAP_BALANCES to BARSREADER_ROLE;
grant SELECT                                                                 on ACCM_SNAP_BALANCES to BARSUPL;
grant SELECT                                                                 on ACCM_SNAP_BALANCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_SNAP_BALANCES to START1;
grant SELECT                                                                 on ACCM_SNAP_BALANCES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACCM_SNAP_BALANCES.sql =========*** End
PROMPT ===================================================================================== 
