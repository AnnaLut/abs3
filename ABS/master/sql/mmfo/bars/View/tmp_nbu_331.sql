

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_331.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_331 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_331 ("COL_P2", "COL_P1", "COL_P3", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,3,3) COL_P2, substr(kodp,1,2) COL_P1, znap COL_P3,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_331 ***
grant SELECT                                                                 on TMP_NBU_331     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NBU_331     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_331     to RPBN002;
grant SELECT                                                                 on TMP_NBU_331     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_331.sql =========*** End *** ==
PROMPT ===================================================================================== 
