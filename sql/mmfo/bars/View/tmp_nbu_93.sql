

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_93.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_93 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_93 ("COL_P1", "COL_P2", "COL_P3", "COL_P4", "COL_P5", "COL_P6", "COL_P7", "COL_P8", "COL_P9", "COL_P10", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,4) COL_P2, substr(kodp,6,1) COL_P3, substr(kodp,7,2) COL_P4, substr(kodp,9,2) COL_P5, substr(kodp,11,1) COL_P6, substr(kodp,12,1) COL_P7, substr(kodp,13,1) COL_P8, substr(kodp,14,3) COL_P9, znap COL_P10,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_93 ***
grant SELECT                                                                 on TMP_NBU_93      to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NBU_93      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_93      to RPBN002;
grant SELECT                                                                 on TMP_NBU_93      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_93.sql =========*** End *** ===
PROMPT ===================================================================================== 
