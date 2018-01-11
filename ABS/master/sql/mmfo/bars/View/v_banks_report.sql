

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_REPORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_REPORT ("NBUC", "KODP", "ZNAP", "DATF", "KODF", "FILE_ID", "FILE_NAME") AS 
  SELECT TO_NUMBER (r.nbucode), r.parameter, r.VALUE,
          TO_DATE (f.last_date, 'ddmmyyyy') datf,
          SUBSTR (f.file_name, 2, 2) kodf, f.file_id, f.file_name
     FROM rnbu_in_files f, rnbu_in_inf_records r
    WHERE f.file_id = r.file_id AND f.mfo IN (SELECT mfo
                                                FROM v_branch)
   UNION ALL
   SELECT TO_NUMBER (nbuc), kodp, znap, datf, kodf, 0, NULL
     FROM tmp_nbu
 ;

PROMPT *** Create  grants  V_BANKS_REPORT ***
grant SELECT                                                                 on V_BANKS_REPORT  to BARSREADER_ROLE;
grant SELECT                                                                 on V_BANKS_REPORT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_REPORT  to RPBN002;
grant SELECT                                                                 on V_BANKS_REPORT  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_REPORT  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_REPORT.sql =========*** End ***
PROMPT ===================================================================================== 
