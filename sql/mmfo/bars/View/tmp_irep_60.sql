

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_IREP_60.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_IREP_60 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_IREP_60 ("COL_P1", "COL_P2", "COL_P8", "COL_P4", "COL_P3", "COL_P5", "COL_P6", "COL_P7", "COL_P9", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,4) COL_P2, substr(kodp,11,3) COL_P8, substr(kodp,7,1) COL_P4, substr(kodp,6,1) COL_P3, substr(kodp,8,1) COL_P5, substr(kodp,9,1) COL_P6, substr(kodp,10,1) COL_P7, znap COL_P9,  TMP_IREP."KODP",TMP_IREP."DATF",TMP_IREP."KODF",TMP_IREP."ZNAP",TMP_IREP."NBUC",TMP_IREP."KF",TMP_IREP."ERR_MSG",TMP_IREP."FL_MOD" from TMP_IREP;

PROMPT *** Create  grants  TMP_IREP_60 ***
grant SELECT                                                                 on TMP_IREP_60     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_IREP_60     to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_IREP_60.sql =========*** End *** ==
PROMPT ===================================================================================== 
