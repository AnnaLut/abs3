

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_91.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_91 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_91 ("COL_P1", "COL_P3", "COL_P2", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,1,2) COL_P1, znap COL_P3, substr(nbuc,1,12) COL_P2,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_91 ***
grant SELECT                                                                 on TMP_NBU_91      to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_91.sql =========*** End *** ===
PROMPT ===================================================================================== 
