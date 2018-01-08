

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT_INT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT_INT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT_INT ("NBUC", "KODP", "ZNAP", "DATF", "KODF", "FILE_ID", "FILE_NAME") AS 
  SELECT TO_NUMBER (nbuc),
          kodp,
          znap,
          datf,
          kodf,
          0,
          NULL
     FROM tmp_irep;

PROMPT *** Create  grants  V_BANKS_REPORT_INT ***
grant SELECT                                                                 on V_BANKS_REPORT_INT to BARSREADER_ROLE;
grant SELECT                                                                 on V_BANKS_REPORT_INT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT_INT to RPBN002;
grant SELECT                                                                 on V_BANKS_REPORT_INT to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_REPORT_INT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT_INT.sql =========*** End
PROMPT ===================================================================================== 
