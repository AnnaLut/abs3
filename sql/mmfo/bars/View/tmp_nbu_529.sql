

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_529.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_529 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_529 ("COL_P3", "COL_P2", "COL_P4", "COL_P1", "COL_P5", "KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select substr(kodp,4,10) COL_P3, substr(kodp,2,2) COL_P2, substr(kodp,14,3) COL_P4, substr(kodp,1,1) COL_P1, znap COL_P5,  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_529 ***
grant SELECT                                                                 on TMP_NBU_529     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_529     to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_529.sql =========*** End *** ==
PROMPT ===================================================================================== 
