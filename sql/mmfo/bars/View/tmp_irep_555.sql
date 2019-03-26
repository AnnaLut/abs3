

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_IREP_555.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_IREP_555 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_IREP_555 ("COL_P2", "COL_P3", "COL_P1", "COL_P4", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,2,3) COL_P2, substr(kodp,5,3) COL_P3, substr(kodp,1,1) COL_P1, znap COL_P4,  TMP_IREP."KODP",TMP_IREP."DATF",TMP_IREP."KODF",TMP_IREP."ZNAP",TMP_IREP."NBUC",TMP_IREP."KF",TMP_IREP."ERR_MSG",TMP_IREP."FL_MOD" from TMP_IREP;

PROMPT *** Create  grants  TMP_IREP_555 ***
grant SELECT                                                                 on TMP_IREP_555    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_IREP_555    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_IREP_555    to RPBN002;
grant SELECT                                                                 on TMP_IREP_555    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_IREP_555.sql =========*** End *** =
PROMPT ===================================================================================== 