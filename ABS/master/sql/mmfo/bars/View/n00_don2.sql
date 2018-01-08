

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N00_DON2.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view N00_DON2 ***

  CREATE OR REPLACE FORCE VIEW BARS.N00_DON2 ("DAT1", "DAT2", "KV", "NLS", "OKPO", "NMK", "S240", "OST1", "DOS", "KOS", "OST2") AS 
  select dat1, dat2, kv,NLS, OKPO, NMK, S240, OST1, dos, kos, ost2
from (SELECT d.dat1, d.dat2, a.kv, a.nls, c.okpo, c.nmk, s.s240,
             fost(a.acc,d.dat1-1)/100       ost1,
             fdos(a.acc,d.dat1, d.dat2)/100 dos,
             fkos(a.acc,d.dat1, d.dat2)/100 kos,
             fost(a.acc,d.dat2  )/100       ost2
      FROM accounts a, customer c, specparam s,
    (select val OKPO from params$base where par='OKPO') p ,
    (select NVL(TO_DATE (pul.get_mas_ini_val ('sFdat1'),'dd.mm.yyyy'),gl.bd ) DAT1,
            NVL(TO_DATE (pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy'),gl.bd ) DAT2
     from dual) d
      WHERE a.nbs in ('3902','3903' ) and a.ob22='04'
        and c.rnk = a.rnk
        and c.okpo <> p.okpo
        and a.acc = s.acc (+) )
where (ost1<> 0 or dos<>0 or kos<>0 or ost2<>0)
        ;

PROMPT *** Create  grants  N00_DON2 ***
grant SELECT                                                                 on N00_DON2        to BARS014;
grant SELECT                                                                 on N00_DON2        to BARSREADER_ROLE;
grant SELECT                                                                 on N00_DON2        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N00_DON2        to SALGL;
grant SELECT                                                                 on N00_DON2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N00_DON2.sql =========*** End *** =====
PROMPT ===================================================================================== 
