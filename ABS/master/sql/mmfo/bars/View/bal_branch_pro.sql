

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_PRO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BAL_BRANCH_PRO ***

  CREATE OR REPLACE FORCE VIEW BARS.BAL_BRANCH_PRO ("DAT", "NBS", "BRANCH", "KV", "OB22", "KOD", "DOS", "DOSQ", "KOS", "KOSQ", "OSD", "OSDQ", "OSK", "OSKQ") AS 
  select caldt_date DAT, nbs, branch, kv, ob22, nbs||ob22 kod,
 sum( dos )/100 dos, sum(DOSq)/100 dosq, sum(KOS)/100 KOS, sum( kOSq )/100 kosq,
 sum( osd )/100 osd, sum(OSdq)/100 osdq, sum(osk)/100 osk, sum( OSkq )/100 oskq
from (select c.caldt_date,a.nbs,a.branch,a.kv,a.ob22,m.DOS,m.KOS,m.DOSq, m.KOSq,
       decode(sign(m.ost),-1, -m.ost, 0) osd, decode(sign(m.ost), 1,m.ost, 0) osk,
       decode(sign(m.ostq),-1,-m.ostq,0) osdq,decode(sign(m.ostq),1,m.ostq,0) oskq
      from v_gl a, ACCM_CALENDAR c, ACCM_SNAP_BALANCES m
      where a.nbs not like '8%'  and a.acc = m.acc and m.caldt_id = c.caldt_id
        and c.caldt_date = Dat_Next_U ( gl.bd, -1) )
group by caldt_date, nbs, branch, kv, ob22;

PROMPT *** Create  grants  BAL_BRANCH_PRO ***
grant SELECT                                                                 on BAL_BRANCH_PRO  to BARSREADER_ROLE;
grant SELECT                                                                 on BAL_BRANCH_PRO  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BAL_BRANCH_PRO  to SALGL;
grant SELECT                                                                 on BAL_BRANCH_PRO  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_PRO.sql =========*** End ***
PROMPT ===================================================================================== 
