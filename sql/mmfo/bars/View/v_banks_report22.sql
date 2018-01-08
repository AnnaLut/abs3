

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT22.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT22 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT22 ("NBUC", "KODF", "DATF", "KODP", "ZNAP") AS 
  SELECT s.nbuc, s.kodf, s.datf, s.kodp,
       SUM(iif_s(SUBSTR(s.kodp,1,1), '2', to_number (s.znap),
           to_number(s.znap)*to_number(t.znap), to_number (s.znap)) )
       FROM   v_banks_report s, v_banks_report t
       WHERE  s.kodf = t.kodf          AND
              s.datf = t.datf          AND
              SUBSTR(s.kodp,2,8) = SUBSTR(t.kodp,2,8)          AND
              s.kodp <> t.kodp          AND
              s.kodf = '03'
       GROUP BY s.nbuc, s.kodf, s.datf, s.kodp;

PROMPT *** Create  grants  V_BANKS_REPORT22 ***
grant SELECT                                                                 on V_BANKS_REPORT22 to BARSREADER_ROLE;
grant SELECT                                                                 on V_BANKS_REPORT22 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT22 to START1;
grant SELECT                                                                 on V_BANKS_REPORT22 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT22.sql =========*** End *
PROMPT ===================================================================================== 
