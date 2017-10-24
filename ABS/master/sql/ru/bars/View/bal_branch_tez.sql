

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_TEZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view BAL_BRANCH_TEZ ***

  CREATE OR REPLACE FORCE VIEW BARS.BAL_BRANCH_TEZ ("DAT", "NBS", "BRANCH", "DOSQ", "KOSQ", "OSDQ", "OSKQ") AS 
  select gl.bd DAT,nbs, branch,
       sum( gl.p_icurval( kv, decode (dapp, gl.bd,1,0) * dos, gl.bd ) )/100 dosq,
       sum( gl.p_icurval( kv, decode (dapp, gl.bd,1,0) * kos, gl.bd ) )/100 kosq,
       sum( gl.p_icurval( kv, decode (sign(ostc),-1,-ostc,0), gl.bd ) )/100 osdq,
       sum( gl.p_icurval( kv, decode (sign(ostc), 1, ostc,0), gl.bd ) )/100 oskq
from v_gl where nbs not like '8%' group by nbs, branch;

PROMPT *** Create  grants  BAL_BRANCH_TEZ ***
grant SELECT                                                                 on BAL_BRANCH_TEZ  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BAL_BRANCH_TEZ  to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BAL_BRANCH_TEZ.sql =========*** End ***
PROMPT ===================================================================================== 
