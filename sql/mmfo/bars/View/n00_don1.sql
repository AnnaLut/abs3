

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N00_DON1.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view N00_DON1 ***

  CREATE OR REPLACE FORCE VIEW BARS.N00_DON1 ("NBS", "DOS", "KOS", "OSTC", "REC", "REF", "MFOA", "NLSA", "MFOB", "NLSB", "FDAT") AS 
  SELECT SUBSTR (CASE WHEN (p.fn_a LIKE '_B%') THEN p.nlsb ELSE p.nlsa END,  1, 4)                          NBS,
      (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%') THEN p.s ELSE 0 END)/100  sde,
      (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%') THEN 0 ELSE p.s END)/100  skr,
      A.OSTC, p.ref, p.rec, P.MFOA, P.NLSA,P.MFOB,P.NLSB, TO_CHAR (SYSDATE, 'dd.mm.yyyy hh24:mm:ss')
FROM  arc_rrp p,    zag_a za,    zag_b zb, (SELECT acc, -ostc / 100 OSTC  FROM accounts    WHERE tip = 'N00' AND kv = 980) a
WHERE p.sos >= 5
  AND p.dk IN (0, 1)
  AND p.s >= 1000000
  AND p.REF IS NOT NULL
  AND p.fn_a = za.fn(+)
  AND p.dat_a = za.dat(+)
  AND p.fn_b = zb.fn(+)
  AND p.dat_b = zb.dat(+)
  AND (p.fn_a IS NOT NULL OR p.fn_b IS NOT NULL)
  AND EXISTS
    (SELECT 1 FROM opldok WHERE acc = a.acc  AND REF IN (NVL (za.REF, -1), NVL (zb.REF, -1))
        AND fdat = NVL ( TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'),GL.BD)
     );

PROMPT *** Create  grants  N00_DON1 ***
grant SELECT                                                                 on N00_DON1        to BARS014;
grant SELECT                                                                 on N00_DON1        to BARSREADER_ROLE;
grant SELECT                                                                 on N00_DON1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N00_DON1        to SALGL;
grant SELECT                                                                 on N00_DON1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N00_DON1.sql =========*** End *** =====
PROMPT ===================================================================================== 
