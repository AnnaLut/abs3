

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N00_MFO.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view N00_MFO ***

  CREATE OR REPLACE FORCE VIEW BARS.N00_MFO ("FDAT", "MFO", "DOS", "PRD", "KOS", "PRK", "DEL", "DOB", "KOB") AS 
  select FDAT, mfo, DOS, decode( DOSO, 0, 0, DOS*100/DOSO ) PRD,
                  KOS, decode( KOSO, 0, 0, KOS*100/KOSO ) PRK,
                  DOS- KOS,
                  dos*100/(dos+kos),
                  kos*100/(dos+kos)
from
(select FDAT, mfo, DOS, (sum(DOS) over (partition by FDAT) ) DOSO,
                   KOS, (sum(KOS) over (partition by FDAT) ) KOSO
from
(SELECT NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'),gl.bd ) FDAT,
        mfo,
        SUM (sde) DOS, SUM (skr) KOS
FROM (SELECT
       (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%')
             THEN p.s ELSE 0   END ) / 100 sde,
       (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%')
             THEN 0   ELSE p.s END ) / 100 skr,
       (CASE WHEN (p.fn_a LIKE '_B%') THEN p.MFOB ELSE p.MFOA END) MFO
      FROM arc_rrp p, zag_a za, zag_b zb,
          (SELECT acc FROM accounts WHERE tip = 'N00' AND kv = 980) a
      WHERE p.sos >=5
        and p.dk in (0,1)
        AND p.fn_a = za.fn(+) AND p.dat_a = za.dat(+)
        AND p.fn_b = zb.fn(+) AND p.dat_b = zb.dat(+)
        and (p.fn_a is not null or p.fn_b is not null)
        AND EXISTS
         (SELECT 1 FROM opldok WHERE acc = a.acc
             AND REF IN (NVL (za.REF, -1), NVL (zb.REF, -1))
             AND fdat =  NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'),gl.bd )
          )
      )
GROUP BY MFO));

PROMPT *** Create  grants  N00_MFO ***
grant SELECT                                                                 on N00_MFO         to BARS014;
grant SELECT                                                                 on N00_MFO         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N00_MFO         to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N00_MFO.sql =========*** End *** ======
PROMPT ===================================================================================== 
