

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N00_NBS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view N00_NBS ***

  CREATE OR REPLACE FORCE VIEW BARS.N00_NBS ("FDAT", "NBS", "DOS", "PRD", "KOS", "PRK", "DEL", "DOB", "KOB") AS 
  select FDAT, nbs, DOS, decode( DOSO, 0, 0, DOS*100/DOSO ) PRD,
                  KOS, decode( KOSO, 0, 0, KOS*100/KOSO ) PRK,
                  DOS- KOS,
                  dos*100/(dos+kos),
                  kos*100/(dos+kos)
from
(select FDAT, nbs, DOS, (sum(DOS) over (partition by FDAT) ) DOSO,
                   KOS, (sum(KOS) over (partition by FDAT) ) KOSO
from
(SELECT NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'),gl.bd ) FDAT,
        nbs,
        SUM (sde) DOS, SUM (skr) KOS
FROM (SELECT
       (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%')
             THEN p.s ELSE 0   END ) / 100 sde,
       (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%')
             THEN 0   ELSE p.s END ) / 100 skr,
        SUBSTR (CASE WHEN (p.fn_a LIKE '_B%') THEN p.nlsb ELSE p.nlsa END,1,4) nbs
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
GROUP BY nbs));

PROMPT *** Create  grants  N00_NBS ***
grant SELECT                                                                 on N00_NBS         to BARS014;
grant SELECT                                                                 on N00_NBS         to BARSREADER_ROLE;
grant SELECT                                                                 on N00_NBS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N00_NBS         to SALGL;
grant SELECT                                                                 on N00_NBS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N00_NBS.sql =========*** End *** ======
PROMPT ===================================================================================== 