

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_ACC_1.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_ZAL_ACC_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_ZAL_ACC_1 ("FDAT", "ACC", "SUM_ZAL", "DAT_ZAL") AS 
  SELECT x.B FDAT,
          a.acc,
          ROUND (
             fost (a.acc, x.B) * z.kolz / (-fost (e.acc, x.B) / k.cena / 100),
             0),
          NVL (z.datz, a.mdate)
     FROM cp_deal e,
          cp_kod k,
          accounts a,
          cp_zal z,
          (SELECT NVL (
                     TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'),
                     gl.bd)
                     B
             FROM DUAL) x
    WHERE     e.REF = z.REF
          AND e.id = k.id
          AND a.acc IN (e.acc, e.accd, e.accp, e.accr, e.accr2, e.accs)
          AND a.nls LIKE '14%'
          AND fost (e.acc, x.B) < 0;

PROMPT *** Create  grants  CP_V_ZAL_ACC_1 ***
grant SELECT                                                                 on CP_V_ZAL_ACC_1  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_V_ZAL_ACC_1  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_ACC_1.sql =========*** End ***
PROMPT ===================================================================================== 
