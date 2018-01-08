

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#1P_EDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#1P_EDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#1P_EDIT ("DATF", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "SEG_06", "SEG_07", "SEG_08", "SEG_09", "ZNAP", "FL_MOD") AS 
  SELECT p.datf,
          SUBSTR (p.KODP, 1, 2) AS SEG_01,
          SUBSTR (p.KODP, 3, 1) AS SEG_02,
          SUBSTR (p.KODP, 4, 3) AS SEG_03,
          SUBSTR (p.KODP, 7, 10) AS SEG_04,
          SUBSTR (p.KODP, 17, 4) AS SEG_05,
          SUBSTR (p.KODP, 21, 3) AS SEG_06,
          SUBSTR (p.KODP, 24, 4) AS SEG_07,
          SUBSTR (p.KODP, 28, 3) AS SEG_08,
          SUBSTR (p.KODP, 31, 3) AS SEG_09,
          p.znap,
          p.fl_mod
     FROM TMP_NBU p
    WHERE p.kodf = '1P';

PROMPT *** Create  grants  V_NBUR_#1P_EDIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NBUR_#1P_EDIT to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on V_NBUR_#1P_EDIT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#1P_EDIT.sql =========*** End **
PROMPT ===================================================================================== 
