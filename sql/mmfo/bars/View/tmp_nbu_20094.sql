

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_20094.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_20094 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_20094 ("COL_P2", "COL_P3", "COL_P4", "COL_P5", "COL_P1", "COL_P6", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,2,2) COL_P2, substr(kodp,4,3) COL_P3, substr(kodp,7,8) COL_P4, substr(kodp,15,6) COL_P5, substr(kodp,1,1) COL_P1, znap COL_P6,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_20094 ***
grant SELECT                                                                 on TMP_NBU_20094   to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NBU_20094   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_20094   to RPBN002;
grant SELECT                                                                 on TMP_NBU_20094   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_20094.sql =========*** End *** 
PROMPT ===================================================================================== 
