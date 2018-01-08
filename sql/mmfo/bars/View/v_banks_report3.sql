

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT3.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT3 ("NBUC", "KODF", "DATF", "KODP", "ZNAP", "ERR_MSG", "FL_MOD") AS 
  SELECT s.nbuc, s.kodf, s.datf, s.kodp, s.znap, null, null
       FROM   v_banks_report s, rnbu_1 r
       WHERE  s.kodf = r.kodf  AND
              r.kod = 3        AND
              s.kodp IS NOT NULL;

PROMPT *** Create  grants  V_BANKS_REPORT3 ***
grant SELECT                                                                 on V_BANKS_REPORT3 to BARSREADER_ROLE;
grant SELECT                                                                 on V_BANKS_REPORT3 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT3 to RPBN002;
grant SELECT                                                                 on V_BANKS_REPORT3 to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_REPORT3 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT3.sql =========*** End **
PROMPT ===================================================================================== 
