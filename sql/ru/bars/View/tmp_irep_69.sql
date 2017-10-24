

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_IREP_69.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_IREP_69 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_IREP_69 ("KODP", "DATF", "KODF", "ZNAP", "NBUC", "KF", "ERR_MSG", "FL_MOD") AS 
  select  TMP_IREP."KODP",TMP_IREP."DATF",TMP_IREP."KODF",TMP_IREP."ZNAP",TMP_IREP."NBUC",TMP_IREP."KF",TMP_IREP."ERR_MSG",TMP_IREP."FL_MOD" from TMP_IREP;

PROMPT *** Create  grants  TMP_IREP_69 ***
grant SELECT                                                                 on TMP_IREP_69     to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_IREP_69.sql =========*** End *** ==
PROMPT ===================================================================================== 
