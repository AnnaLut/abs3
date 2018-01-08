

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N00_HH.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view N00_HH ***

  CREATE OR REPLACE FORCE VIEW BARS.N00_HH ("FDAT", "HH", "DOS", "PRD", "KOS", "PRK", "DEL", "DOB", "KOB") AS 
  select FDAT, HH, DOS, decode( DOSO, 0, 0, DOS*100/DOSO ) PRD,
                 KOS, decode( KOSO, 0, 0, KOS*100/KOSO ) PRK,
                 DOS- KOS,
                 dos*100/(dos+kos),
                 kos*100/(dos+kos)
from (select FDAT, HH, DOS, (sum(DOS) over (partition by FDAT) ) DOSO,
             KOS, (sum(KOS) over (partition by FDAT) ) KOSO
      from ( select  o.FDAT,
                     to_char(p.pdat,'HH24') HH,
                     sum(decode (o.dk, 0, o.s, 0))/100 dos ,
                     sum(decode (o.dk, 1, o.s, 0))/100 kos
             from opldok o, oper p,
                  (SELECT acc FROM accounts WHERE tip = 'N00' AND kv = 980) a
             where o.acc  = a.acc
               AND fdat = NVL(TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'),gl.bd)
               and o.ref=p.ref
             group by o.FDAT,  to_char(p.pdat,'HH24')
             )
       )             ;

PROMPT *** Create  grants  N00_HH ***
grant SELECT                                                                 on N00_HH          to BARS014;
grant SELECT                                                                 on N00_HH          to BARSREADER_ROLE;
grant SELECT                                                                 on N00_HH          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N00_HH          to SALGL;
grant SELECT                                                                 on N00_HH          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N00_HH.sql =========*** End *** =======
PROMPT ===================================================================================== 
