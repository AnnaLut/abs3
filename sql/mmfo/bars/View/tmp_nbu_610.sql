

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_610.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_610 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_610 ("COL_P3", "COL_P8", "COL_P6", "COL_P7", "COL_P9", "COL_P10", "COL_P11", "COL_P12", "COL_P1", "COL_P2", "COL_P4", "COL_P5", "COL_P14", "COL_P13", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,3,2) COL_P3, substr(kodp,19,3) COL_P8, substr(kodp,7,10) COL_P6, substr(kodp,17,2) COL_P7, substr(kodp,22,3) COL_P9, substr(kodp,25,3) COL_P10, substr(kodp,28,3) COL_P11, substr(kodp,31,3) COL_P12, substr(kodp,1,1) COL_P1, substr(kodp,2,1) COL_P2, substr(kodp,5,1) COL_P4, substr(kodp,6,1) COL_P5, substr(kodp,34) COL_P14, znap COL_P13,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_610 ***
grant SELECT                                                                 on TMP_NBU_610     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NBU_610     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_610     to RPBN002;
grant SELECT                                                                 on TMP_NBU_610     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_610.sql =========*** End *** ==
PROMPT ===================================================================================== 
