

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT1 ("NBUC", "KODF", "DATF", "KODP", "ZNAP", "ERR_MSG", "FL_MOD") AS 
  SELECT   s.nbuc, s.kodf, s.datf, s.kodp,
            TO_CHAR (SUM (TO_NUMBER (trim(s.znap)))), null, null
       FROM v_banks_report s
      WHERE s.kodf NOT IN (SELECT kodf
                             FROM rnbu_1) AND s.kodp IS NOT NULL
   GROUP BY s.nbuc, s.kodf, s.datf, s.kodp;

PROMPT *** Create  grants  V_BANKS_REPORT1 ***
grant SELECT                                                                 on V_BANKS_REPORT1 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT1 to RPBN002;
grant SELECT                                                                 on V_BANKS_REPORT1 to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_REPORT1 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT1.sql =========*** End **
PROMPT ===================================================================================== 
