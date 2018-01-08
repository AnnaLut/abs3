

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_S080.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_S080 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_S080 ("KV", "VIDD", "NMK", "BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "S080", "R080", "OTM", "ISP", "FIN", "OBS") AS 
  SELECT u.kv, d.vidd, c.nmk, d.branch, d.nd, d.cc_id, d.sdate, d.wdate,
          s.s080, f.s080 r080, u.adds otm, D.user_id ,
          decode(c.crisk, 1,'1=À',
                          2,'2=Á',
                          3,'3=Â',
                          4,'4=Ä',
                          5,'5=Ã',
                            '   '),
          decode(d.obs, 1,'1=Äáð',
                        2,'2=Ñëá',
                        3,'3=Íçä',
                          '    ')
     FROM cc_deal d, customer c, fin_obs_s080 f, cc_add u, specparam s
    WHERE d.vidd IN (1, 2, 3, 11, 12, 13)
      AND d.rnk = c.rnk
      AND d.nd = u.nd
      AND u.adds = 0
      AND u.accs = s.acc(+)
      AND c.crisk = f.fin
      AND d.obs = f.obs
      AND NVL (s.s080, ' ') <> f.s080
      AND d.sos >= 10
      AND d.sos < 15
 ;

PROMPT *** Create  grants  V_S080 ***
grant SELECT,UPDATE                                                          on V_S080          to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_S080          to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_S080.sql =========*** End *** =======
PROMPT ===================================================================================== 
