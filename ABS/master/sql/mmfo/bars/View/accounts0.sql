

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACCOUNTS0.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view ACCOUNTS0 ***

  CREATE OR REPLACE FORCE VIEW BARS.ACCOUNTS0 ("CL", "ACC", "DAOS", "DAPP", "ISP", "KV", "MDATE", "NLS", "NMS", "PAP", "RNK", "BRANCH", "TIP", "OB22", "PROD") AS 
  select 0 CL, a.ACC, a.DAOS, a.DAPP, a.ISP, a.KV, a.MDATE, a.NLS, a.NMS, a.PAP, a.RNK, a.BRANCH, a.TIP, a.OB22,
       (select txt from sb_ob22 where r020 = a.nbs and ob22= a.ob22) PROD
from accounts a
where  dazs is null and (dapp is null or dapp < gl.bd) and ostc=0 and ostb =0 and ostf =0 and
       exists (select 1 from customer where okpo = f_ourokpo and rnk = a.rnk ) ;

PROMPT *** Create  grants  ACCOUNTS0 ***
grant SELECT                                                                 on ACCOUNTS0       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS0       to START1;
grant SELECT                                                                 on ACCOUNTS0       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACCOUNTS0.sql =========*** End *** ====
PROMPT ===================================================================================== 
