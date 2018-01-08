

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_135.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_135 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_135 ("COL_P1", "COL_P2", "COL_P8", "COL_P4", "COL_P3", "COL_P5", "COL_P6", "COL_P7", "COL_P9", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,4) COL_P2, substr(kodp,11,3) COL_P8, substr(kodp,7,1) COL_P4, substr(kodp,6,1) COL_P3, substr(kodp,8,1) COL_P5, substr(kodp,9,1) COL_P6, substr(kodp,10,1) COL_P7, znap COL_P9,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_135 ***
grant SELECT                                                                 on TMP_NBU_135     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_135     to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_135.sql =========*** End *** ==
PROMPT ===================================================================================== 
