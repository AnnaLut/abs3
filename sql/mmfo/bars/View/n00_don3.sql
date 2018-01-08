

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/N00_DON3.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view N00_DON3 ***

  CREATE OR REPLACE FORCE VIEW BARS.N00_DON3 ("IDCODE", "NAME", "NLS", "I_VA", "S240", "BALS", "VSH", "DOS", "KOS", "ISH", "CUR_DATE", "VSHQ", "DOSQ", "KOSQ", "ISHQ") AS 
  select okpo, nmk,NLS, kv,   S240, nbs, ostV,dos, kos, ostI, DAT,
   ostVq,dosq, kosq, ostIq
from (SELECT c.okpo, c.nmk, a.nls, a.kv, s.s240, a.nbs,
            (b.ost +b.dos -b.kos )/100  ostV,
             b.dos /100   dos , b.kos /100   kos ,  b.ost /100   ostI,
             k.CALDT_DATE DAT ,
            (b.ostq+b.dosq-b.kosq)/100  ostVq,
             b.dosq/100   dosq, b.kosq/100   kosq,  b.ostq/100   ostIq
      FROM accounts a, customer c, specparam s, ACCM_SNAP_BALANCES b,
           (select CALDT_ID, CALDT_DATE
            from ACCM_CALENDAR
            where CALDT_DATE >= NVL(TO_DATE(pul.get_mas_ini_val('sFdat1'),
                                           'dd.mm.yyyy'), gl.bd-1 )
              and CALDT_DATE <= NVL(TO_DATE(pul.get_mas_ini_val('sFdat2'),
                                           'dd.mm.yyyy'), gl.bd-1 )
           ) k
      WHERE (a.nbs='3901' OR a.nbs in ('3902','3903' ) and a.ob22='04')
        and a.acc = b.acc
        and a.rnk = c.rnk
        and k.CALDT_ID = b.CALDT_ID
        and (b.dosq<>0 or b.kosq<>0 or b.ostq<>0)
        and a.acc = s.acc (+) ) ;

PROMPT *** Create  grants  N00_DON3 ***
grant SELECT                                                                 on N00_DON3        to BARS014;
grant SELECT                                                                 on N00_DON3        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on N00_DON3        to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/N00_DON3.sql =========*** End *** =====
PROMPT ===================================================================================== 
