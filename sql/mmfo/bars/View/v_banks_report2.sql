

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT2.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT2 ("NBUC", "KODF", "DATF", "KODP", "ZNAP", "ERR_MSG", "FL_MOD") AS 
  SELECT s.nbuc, s.kodf, s.datf, s.kodp,
       TO_CHAR( SUM( to_number (s.znap) )), null, null
       FROM   v_banks_report s, rnbu_1 r
       WHERE  s.kodf = r.kodf                                 AND
              s.kodp NOT LIKE TRANSLATE(r.kod_maska,'*?','%_')
       GROUP BY s.nbuc, s.kodf, s.datf, s.kodp
UNION
SELECT s.nbuc, s.kodf, s.datf, s.kodp,
       LTRIM(TO_CHAR(ROUND(SUM(to_number(s.znap)*to_number(t.znap))/SUM(to_number(t.znap)),4), '99990D0000')), null, null
       FROM   v_banks_report s, v_banks_report t, rnbu_1 r
       WHERE  s.kodf = r.kodf                                 AND
              s.kodp LIKE TRANSLATE(r.kod_maska,'*?','%_')    AND
              s.nbuc = t.nbuc                                 AND
              s.kodf = t.kodf                                 AND
              s.datf = t.datf                                 AND
              s.file_id = t.file_id                           AND
              SUBSTR(s.kodp,2) = SUBSTR(t.kodp,2)             AND
              t.kodp NOT LIKE TRANSLATE(r.kod_maska,'*?','%_')
       GROUP BY s.nbuc, s.kodf, s.datf, s.kodp;

PROMPT *** Create  grants  V_BANKS_REPORT2 ***
grant SELECT                                                                 on V_BANKS_REPORT2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT2 to RPBN002;
grant SELECT                                                                 on V_BANKS_REPORT2 to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_REPORT2 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT2.sql =========*** End **
PROMPT ===================================================================================== 
