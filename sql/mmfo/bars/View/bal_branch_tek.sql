

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_TEK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BAL_BRANCH_TEK ***

  CREATE OR REPLACE FORCE VIEW BARS.BAL_BRANCH_TEK ("DAT", "NBS", "BRANCH", "KV", "OB22", "KOD", "DOS", "DOSQ", "KOS", "KOSQ", "OSD", "OSDQ", "OSK", "OSKQ") AS 
  select gl.bd DAT, nbs, branch, kv, ob22, nbs||ob22 kod,
       sum( dos )/100 dos, sum( gl.p_icurval( kv, DOS, gl.bd ) )/100 dosq,
       sum( KOS )/100 KOS, sum( gl.p_icurval( kv, kOS, gl.bd ) )/100 kosq,
       sum( osd )/100 osd, sum( gl.p_icurval( kv, OSd, gl.bd ) )/100 osdq,
       sum( osk )/100 osk, sum( gl.p_icurval( kv, OSk, gl.bd ) )/100 oskq
from (select nbs, branch, kv, ob22,
            decode(dapp, gl.bd,1,0) *dos   DOS, decode(dapp, gl.bd,1,0)*kos  KOS,
            decode(sign(ostc),-1, -ostc,0) osd, decode(sign(ostc),1,ostc, 0) osk
      from v_gl where nbs not like '8%'   )  group by nbs, branch, kv, ob22;

PROMPT *** Create  grants  BAL_BRANCH_TEK ***
grant SELECT                                                                 on BAL_BRANCH_TEK  to BARSREADER_ROLE;
grant SELECT                                                                 on BAL_BRANCH_TEK  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BAL_BRANCH_TEK  to SALGL;
grant SELECT                                                                 on BAL_BRANCH_TEK  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_TEK.sql =========*** End ***
PROMPT ===================================================================================== 
