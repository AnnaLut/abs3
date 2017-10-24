

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS_TOBO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS_TOBO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS_TOBO ("TOBO", "NBS", "FDAT", "DOSR", "KOSR", "DOSQ", "KOSQ", "OSTD", "OSTK") AS 
  SELECT BRANCH, nbs, FDAT,
   SUM(dosr) dosr,  SUM(kosr) kosr, SUM(dosQ) dosq, SUM(kosQ) kosq,
   SUM(decode(zn,1, OSTQ,0)) OSTD,    SUM(decode(zn,1,0,-OSTQ)) OSTK
FROM (select a.BRANCH, a.nbs, d.caldt_DATE fdat,
         gl.p_icurval(a.kv,b.dos, d.caldt_DATE) dosr,
         gl.p_icurval(a.kv,b.kos, d.caldt_DATE) kosr,
         b.dosQ, b.kosQ, sign(b.OST) ZN,
         decode(d.caldt_DATE,gl.BD,gl.p_icurval(a.kv,b.OST,d.caldt_DATE),
                                   b.OSTQ) OSTQ
      FROM accm_calendar d,  accm_snap_balances b, accounts a
      where b.acc=a.acc and d.caldt_ID=b.caldt_ID    and a.nbs not like '8%'
        and a.BRANCH LIKE SYS_CONTEXT('bars_context','user_branch_mask')
        and (b.ost<>0 or b.dos <>0 or b.kos<>0)
      )
GROUP BY BRANCH, nbs, FDAT
 ;

PROMPT *** Create  grants  V_BALANS_TOBO ***
grant SELECT                                                                 on V_BALANS_TOBO   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS_TOBO   to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS_TOBO   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS_TOBO.sql =========*** End *** 
PROMPT ===================================================================================== 
