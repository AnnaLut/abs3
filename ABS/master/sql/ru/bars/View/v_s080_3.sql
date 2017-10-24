

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_S080_3.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_S080_3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_S080_3 ("KV", "VIDD", "NMK", "BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "S080", "R080", "M080", "C080", "OTM", "ISP", "FIN", "OBS") AS 
  SELECT a.kv,d.vidd,c.nmk,d.branch,d.nd,d.cc_id,d.sdate,d.wdate,s.s080,
       NVL(m.m080,f.s080) r080, m.m080, f.s080 c080, u.adds otm, d.user_id,
       DECODE(NVL(d.fin,c.crisk),1,'1=À',2,'2=Á',3,'3=Â',4,'4=Ã',5,'5=Ä','   '),
       DECODE (d.obs,1, '1=Äáð', 2, '2=Ñëá', 3, '3=Íçä', '    ')
FROM cc_deal D,customer C,fin_obs_s080 F,cc_add U,specparam S,nd_acc N,accounts A,
     (SELECT TO_NUMBER (nd) nd, mfoa m080 FROM tmp_cck_rep) M
WHERE d.rnk  = c.rnk
  and a.tip  = 'LIM'    and a.acc  = n.acc    and n.nd  = d.nd
  AND d.nd   = u.nd     AND u.adds = 0        AND a.acc  = s.acc(+)
  AND d.sos >= 10       AND d.sos  < 15
  AND d.obs  = f.obs    AND nvl(d.fin,c.crisk) = f.fin
  AND (NVL (s.s080,' ') <> f.s080 OR m.m080 IS NOT NULL)
  AND d.vidd IN (11,12,13) AND d.nd   = m.nd (+) ;

PROMPT *** Create  grants  V_S080_3 ***
grant SELECT,UPDATE                                                          on V_S080_3        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_S080_3        to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_S080_3.sql =========*** End *** =====
PROMPT ===================================================================================== 
