

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NLS_2017.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NLS_2017 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NLS_2017 ("BRANCH", "ACC", "KV", "NLS", "OB22", "NMS", "DAOS", "OSTC", "RNK", "TIP", "NLSALT", "R020_NEW", "OB_NEW", "NLS_NEW") AS 
  select a.branch, a.acc, a.kv, a.nls, a.ob22, a.nms, a.daos, a.ostc/100 ostc, a.rnk, a.tip , a.nlsalt, t.r020_new, t.ob_new,
        (select nls_new from nls_2017 where nls_old = a.nls and kf = a.kf ) nls_new
 from (select * from accounts      where dazs is null ) a ,
      (select * from TRANSFER_2017 where r020_old <> r020_new OR ob_old<> ob_new )  t
 where a.nbs = t.r020_old and a.ob22 = t.ob_old;

PROMPT *** Create  grants  V_NLS_2017 ***
grant SELECT                                                                 on V_NLS_2017      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NLS_2017.sql =========*** End *** ===
PROMPT ===================================================================================== 
