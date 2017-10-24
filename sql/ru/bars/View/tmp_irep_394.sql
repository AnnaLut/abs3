

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_IREP_394.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_IREP_394 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_IREP_394 ("COL_P1", "COL_P2", "COL_P3", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,1,4) COL_P1, substr(kodp,5,4) COL_P2, znap COL_P3,  TMP_IREP."KODP",TMP_IREP."DATF",TMP_IREP."KODF",TMP_IREP."ZNAP",TMP_IREP."NBUC",TMP_IREP."KF",TMP_IREP."ERR_MSG",TMP_IREP."FL_MOD" from TMP_IREP;

PROMPT *** Create  grants  TMP_IREP_394 ***
grant SELECT                                                                 on TMP_IREP_394    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_IREP_394    to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_IREP_394.sql =========*** End *** =
PROMPT ===================================================================================== 
