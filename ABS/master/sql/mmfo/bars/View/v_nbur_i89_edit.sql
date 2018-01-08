

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_I89_EDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_I89_EDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_I89_EDIT ("DATF", "SEG_01", "SEG_02", "ZNAP", "FL_MOD") AS 
  SELECT p.datf,
          SUBSTR (p.KODP, 1, 4) AS SEG_01,
          SUBSTR (p.KODP, 5, 4) AS SEG_02,
          p.znap,
          p.fl_mod
     FROM tmp_irep p
    WHERE p.kodf = '89' and
          p.datf >= to_date('17032017','ddmmyyyy');

PROMPT *** Create  grants  V_NBUR_I89_EDIT ***
grant SELECT                                                                 on V_NBUR_I89_EDIT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NBUR_I89_EDIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_I89_EDIT to UPLD;
grant FLASHBACK,SELECT                                                       on V_NBUR_I89_EDIT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_I89_EDIT.sql =========*** End **
PROMPT ===================================================================================== 
