

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_IREP_NAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_IREP_NAL ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_IREP_NAL ("KODP", "DATF", "KODF", "ZNAP") AS 
  select KODP,   DATF,  KODF,  to_numE(ZNAP) ZNAP
 from tmp_irep where kodf in ('67','87')
 ;

PROMPT *** Create  grants  TMP_IREP_NAL ***
grant SELECT                                                                 on TMP_IREP_NAL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_IREP_NAL    to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_IREP_NAL.sql =========*** End *** =
PROMPT ===================================================================================== 
