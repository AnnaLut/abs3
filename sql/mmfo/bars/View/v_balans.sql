

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS ("TOBO", "ACC", "NBS", "FDAT", "OSTD", "OSTK", "DOSR", "KOSR") AS 
  select a.tobo, a.acc, a.nbs, a.fdat,
       decode(sign(a.ost),-1,-gl.p_icurval(a.kv, a.ost, a.fdat),0) ostd,
       decode(sign(a.ost), 1, gl.p_icurval(a.kv, a.ost, a.fdat),0) ostk,
       gl.p_icurval(a.kv, a.dos, a.fdat) dosr,
       gl.p_icurval(a.kv, a.kos, a.fdat) kosr
from (SELECT a.tobo, a.kv, a.nbs, a.acc, b.fdat,
             decode(s.fdat, B.fdat,  s.dos, 0) dos,
             decode(s.fdat, B.fdat,  s.kos, 0) kos,
             s.ostf - s.dos + s.kos ost
      FROM accounts a, saldoa s, fdat B
      WHERE a.acc=s.acc AND (a.acc,s.fdat) =
            (SELECT c.acc,max(c.fdat) FROM saldoa c
             WHERE a.acc=c.acc AND c.fdat <= B.fdat
             GROUP BY c.acc) ) a
 ;

PROMPT *** Create  grants  V_BALANS ***
grant SELECT                                                                 on V_BALANS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS        to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS.sql =========*** End *** =====
PROMPT ===================================================================================== 
