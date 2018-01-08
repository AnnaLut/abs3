

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT3_INT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT3_INT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT3_INT ("NBUC", "KODF", "DATF", "KODP", "ZNAP", "ERR_MSG", "FL_MOD") AS 
  SELECT s.nbuc,
          s.kodf,
          s.datf,
          s.kodp,
          s.znap,
          NULL,
          NULL
     FROM v_banks_report_int s, rnbu_1_int r
    WHERE s.kodf = r.kodf AND r.kod = 3 AND s.kodp IS NOT NULL;

PROMPT *** Create  grants  V_BANKS_REPORT3_INT ***
grant SELECT                                                                 on V_BANKS_REPORT3_INT to BARSREADER_ROLE;
grant SELECT                                                                 on V_BANKS_REPORT3_INT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT3_INT to RPBN002;
grant SELECT                                                                 on V_BANKS_REPORT3_INT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_REPORT3_INT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT3_INT.sql =========*** En
PROMPT ===================================================================================== 
