

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBOR40.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBOR40 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBOR40 ("REF", "DATD", "ND", "FDAT", "NLSD", "OB40", "NLSK", "OB40D", "S", "NAZN") AS 
  SELECT p.REF, p.DATD, p.ND, o.FDAT, ad.NLS, wd.OB40, ak.NLS, wk.OB40D, o.s/100,p.nazn
FROM oper p, accounts ad, accounts ak,
   (SELECT fdat,REF, s, SUM (DECODE (dk, 0, acc, 0)) accd, SUM (DECODE (dk, 1, acc, 0)) acck
    FROM opldok
    WHERE sos >= 4
      and fdat >= nvl ( TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'), gl.bd)
      and fdat <= nvl ( TO_DATE (pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy'), gl.bd)
    GROUP BY fdat, REF, stmt, s) o,
   (select ref, value OB40  from operw where tag='OB40' ) wd,
   (select ref, value OB40D from operw where tag='OB40D') wk
WHERE p.REF = o.REF AND o.accd = ad.acc AND o.acck = ak.acc
  and (ad.nls like '4%' or ak.nls like '4%')
  and p.ref =wd.ref(+) and p.ref=wk.ref(+);

PROMPT *** Create  grants  V_OBOR40 ***
grant SELECT                                                                 on V_OBOR40        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OBOR40        to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBOR40.sql =========*** End *** =====
PROMPT ===================================================================================== 
