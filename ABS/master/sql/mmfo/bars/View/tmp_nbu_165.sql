

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_165.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_165 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_165 ("COL_P2", "COL_P1", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select znap COL_P2, substr(kodp,1,8) COL_P1,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_165 ***
grant SELECT                                                                 on TMP_NBU_165     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_165     to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_165.sql =========*** End *** ==
PROMPT ===================================================================================== 
