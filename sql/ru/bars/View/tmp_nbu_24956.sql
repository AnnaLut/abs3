

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_24956.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_24956 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_24956 ("COL_P1", "COL_P2", "COL_P3", "COL_P4", "COL_P5", "COL_P6", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,1,1) COL_P1, substr(kodp,2,3) COL_P2, substr(kodp,5,3) COL_P3, substr(lpad(nbuc,14,'0'),1,2) COL_P4, substr(lpad(nbuc,14,'0'),3,12) COL_P5, znap COL_P6,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_24956 ***
grant SELECT                                                                 on TMP_NBU_24956   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_24956.sql =========*** End *** 
PROMPT ===================================================================================== 
