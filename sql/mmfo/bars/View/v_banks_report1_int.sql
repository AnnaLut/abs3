

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT1_INT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT1_INT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT1_INT ("NBUC", "KODF", "DATF", "KODP", "ZNAP", "ERR_MSG", "FL_MOD") AS 
  SELECT s.nbuc,
            s.kodf,
            s.datf,
            s.kodp,
            TO_CHAR (SUM (TO_NUMBER (TRIM (s.znap)))),
            NULL,
            NULL
       FROM v_banks_report_int s
      WHERE s.kodf NOT IN (  SELECT kodf FROM rnbu_1_int) AND s.kodp IS NOT NULL
   GROUP BY s.nbuc,
            s.kodf,
            s.datf,
            s.kodp;

PROMPT *** Create  grants  V_BANKS_REPORT1_INT ***
grant SELECT                                                                 on V_BANKS_REPORT1_INT to BARSREADER_ROLE;
grant SELECT                                                                 on V_BANKS_REPORT1_INT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT1_INT to RPBN002;
grant SELECT                                                                 on V_BANKS_REPORT1_INT to START1;
grant SELECT                                                                 on V_BANKS_REPORT1_INT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_REPORT1_INT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT1_INT.sql =========*** En
PROMPT ===================================================================================== 
