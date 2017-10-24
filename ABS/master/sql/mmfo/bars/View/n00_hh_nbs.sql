

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N00_HH_NBS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view N00_HH_NBS ***

  CREATE OR REPLACE FORCE VIEW BARS.N00_HH_NBS ("FDAT", "HH", "NBS", "DOS", "PRD", "KOS", "PRK", "DEL", "DOB", "KOB") AS 
  SELECT fdat, HH, nbs, dos, DECODE (doso, 0, 0, dos * 100 / doso) prd, kos,
          DECODE (koso, 0, 0, kos * 100 / koso) prk, dos - kos,
          dos * 100 / (dos + kos), kos * 100 / (dos + kos)
   FROM (SELECT fdat, HH, nbs, dos, (SUM (dos) OVER (PARTITION BY fdat, HH)) doso,
                               kos, (SUM (kos) OVER (PARTITION BY fdat, HH)) koso
         FROM (SELECT NVL(TO_DATE(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'),gl.bd) fdat,
                      HH,nbs, SUM (sde) dos, SUM (skr) kos
               FROM (SELECT
                      to_char(NVL(za.datk, zb.datk),'hh24') HH,
                      (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%' ) THEN p.s
                            ELSE 0   END ) / 100 sde,
                      (CASE WHEN (p.dk=1 AND p.fn_a LIKE '_B%' OR p.dk=0 AND p.fn_b LIKE '_A%' ) THEN 0
                            ELSE p.s END ) / 100 skr,
                      SUBSTR (CASE WHEN (p.fn_a LIKE '_B%') THEN p.nlsb
                                   ELSE p.nlsa END, 1, 4  ) nbs
                     FROM arc_rrp p, zag_a za, zag_b zb,
                         (SELECT acc FROM accounts WHERE tip = 'N00' AND kv = 980) a
                     WHERE p.sos >= 5
                       AND p.dk IN (0, 1)
                       AND p.fn_a = za.fn(+)
                       AND p.dat_a = za.dat(+)
                       AND p.fn_b = zb.fn(+)
                       AND p.dat_b = zb.dat(+)
                       AND (p.fn_a IS NOT NULL OR p.fn_b IS NOT NULL )
                       AND EXISTS (SELECT 1 FROM opldok
                                   WHERE acc = a.acc
                                     AND REF IN (NVL (za.REF, -1), NVL (zb.REF, -1) )
                                     AND fdat =
                           NVL(TO_DATE(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'),gl.bd)
                                    )
                    )
               GROUP BY HH,nbs
               )
           );

PROMPT *** Create  grants  N00_HH_NBS ***
grant SELECT                                                                 on N00_HH_NBS      to BARS014;
grant SELECT                                                                 on N00_HH_NBS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N00_HH_NBS      to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N00_HH_NBS.sql =========*** End *** ===
PROMPT ===================================================================================== 
