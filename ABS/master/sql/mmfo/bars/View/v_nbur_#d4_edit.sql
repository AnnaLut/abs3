

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#D4_EDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#D4_EDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#D4_EDIT ("DATF", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "ZNAP", "FL_MOD") AS 
  SELECT p.datf,
          SUBSTR (p.KODP, 1, 1) AS SEG_01,
          SUBSTR (p.KODP, 2, 2) AS SEG_02,
          SUBSTR (p.KODP, 4, 10) AS SEG_03,
          SUBSTR (p.KODP, 14, 3) AS SEG_04,
          p.znap,
          p.fl_mod
     FROM TMP_NBU p
    WHERE p.kodf = 'D4' and
          p.datf >= to_date('17032017','ddmmyyyy');

PROMPT *** Create  grants  V_NBUR_#D4_EDIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NBUR_#D4_EDIT to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on V_NBUR_#D4_EDIT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#D4_EDIT.sql =========*** End **
PROMPT ===================================================================================== 
