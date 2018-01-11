

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TTSCHK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TTSCHK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TTSCHK ("TT", "NAME") AS 
  SELECT DISTINCT X4.TT, X4.NAME
       FROM STAFF X0, STAFF_CHK X1, CHKLIST X2, CHKLIST_TTS X3, TTS X4
       WHERE (((((x0.id =  x1.id) AND (x1.chkid =  x2.idchk)) AND (x2.idchk =  x3.idchk)) AND (x3.tt =  x4.tt)) AND (x0.id =  (SELECT x5.id FROM staff x5 WHERE (upper(x5.logname) =  USER))));

PROMPT *** Create  grants  V_TTSCHK ***
grant SELECT                                                                 on V_TTSCHK        to BARSREADER_ROLE;
grant SELECT                                                                 on V_TTSCHK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TTSCHK        to START1;
grant SELECT                                                                 on V_TTSCHK        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TTSCHK.sql =========*** End *** =====
PROMPT ===================================================================================== 
