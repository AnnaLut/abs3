

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W ("ID", "ND", "CC_ID", "RNK", "AIM", "KV", "S", "DSDATE", "GPK", "DWDATE", "S080", "PR", "OSTC", "NLS", "ACC", "SROK", "SOS", "OBS", "NAMK", "ACC8", "DAY", "DAZS", "OKPO", "SDOG", "BRANCH") AS 
  SELECT
       d.user_id, d.nd, d.cc_id, d.rnk, ad.aim,
       a8.kv, d.LIMIT/100, d.sdate,decode(a8.vid,2,'Рiвними частками',4,'Аннуiтет','Iндивiдуальний')GPK,
       d.wdate, p.s080, acrn.fprocn (ac.acc, 0, ''),
       -a8.ostc/100, ac.nls, ac.acc,abs(round(MONTHS_BETWEEN( d.wdate, ad.wdate))),
       d.sos, d.obs, c.nmk, a8.acc,
       i.s, a8.dazs, c.okpo, d.sdog,d.branch
  FROM cc_deal d,
       accounts ac,
       specparam p,
       customer c,
       accounts a8,
       int_accn i,
       cc_add ad,
       nd_acc n
 WHERE ad.nd = d.nd
   AND ad.adds = 0
   AND n.nd = d.nd
   AND c.rnk = d.rnk
   AND ad.accs = ac.acc(+)
   AND ad.accs = p.acc(+)
   AND i.acc(+) = a8.acc
   AND i.ID(+) = 0
   AND n.acc = a8.acc
   AND a8.tip = 'LIM'
   AND d.vidd IN (1, 2, 3, 11, 12, 13)
 ;

PROMPT *** Create  grants  CC_W ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_W            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_W            to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_W            to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_W            to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_W            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W.sql =========*** End *** =========
PROMPT ===================================================================================== 
