

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBOR40.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBOR40 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBOR40 ("REF", "DATD", "ND", "FDAT", "NLSD", "OB40", "NLSK", "OB40D", "S", "NAZN") AS 
  select /*+ leading(ad) */
          unique p.REF,
          p.DATD,
          p.ND,
          od.FDAT,
          decode(od.dk, 0, ad.NLS, ak.nls) nlsd,
          wd.value OB40,
          decode(od.dk, 1, ad.NLS, ak.nls) nlsk,
          wk.value OB40D,
          od.s / 100,
          p.nazn
from accounts ad, opldok od, opldok ok, accounts ak, oper p, operw wd, operw wk
where ad.nls like '4%' and
    ad.acc = od.acc and
    od.fdat = any (select fdat from fdat where fdat >=
                           NVL (
                              TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                       'dd.mm.yyyy'),
                              gl.bd)
                    AND fdat <=
                           NVL (
                              TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                       'dd.mm.yyyy'),
                              gl.bd)) and
    od.sos >= 4 and
    od.ref = p.ref and
    od.ref = ok.ref and
    od.stmt = ok.stmt and
    OD.DK <> ok.dk and
    ok.acc = ak.acc and
    p.REF = wd.REF(+) and
    nvl(wd.tag(+), 'OB40') = 'OB40' and
    p.REF = wk.REF(+) and
    nvl(wk.tag(+), 'OB40D') = 'OB40D';

PROMPT *** Create  grants  V_OBOR40 ***
grant SELECT                                                                 on V_OBOR40        to BARSREADER_ROLE;
grant SELECT                                                                 on V_OBOR40        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OBOR40        to SALGL;
grant SELECT                                                                 on V_OBOR40        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBOR40.sql =========*** End *** =====
PROMPT ===================================================================================== 
