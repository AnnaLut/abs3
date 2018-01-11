

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_I84_EDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_I84_EDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_I84_EDIT ("DATF", "SEG_01", "ZNAP", "FL_MOD") AS 
  SELECT p.datf,
          SUBSTR (p.KODP, 1, 2) AS SEG_01,
          p.znap,
          p.fl_mod
     FROM tmp_irep p
    WHERE p.kodf = '84' and
          p.datf >= to_date('17032017','ddmmyyyy');

PROMPT *** Create  grants  V_NBUR_I84_EDIT ***
grant SELECT                                                                 on V_NBUR_I84_EDIT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NBUR_I84_EDIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_I84_EDIT to UPLD;
grant FLASHBACK,SELECT                                                       on V_NBUR_I84_EDIT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_I84_EDIT.sql =========*** End **
PROMPT ===================================================================================== 
