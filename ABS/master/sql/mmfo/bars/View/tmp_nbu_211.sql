

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_NBU_211.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_NBU_211 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_NBU_211 ("KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select  TMP_NBU."KODP",TMP_NBU."DATF",TMP_NBU."KODF",TMP_NBU."ZNAP",TMP_NBU."NBUC",TMP_NBU."KF",TMP_NBU."ERR_MSG",TMP_NBU."FL_MOD" from TMP_NBU;

PROMPT *** Create  grants  TMP_NBU_211 ***
grant SELECT                                                                 on TMP_NBU_211     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NBU_211     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU_211     to RPBN002;
grant SELECT                                                                 on TMP_NBU_211     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_NBU_211.sql =========*** End *** ==
PROMPT ===================================================================================== 
