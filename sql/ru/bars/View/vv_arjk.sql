

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VV_ARJK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VV_ARJK ***

  CREATE OR REPLACE FORCE VIEW BARS.VV_ARJK ("B", "E", "KOL", "KV", "BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "RNK", "DAT1", "DAT2", "OST8", "IR", "ACC", "ARJK", "SN", "SK0", "IRS", "NMK", "OKPO") AS 
  SELECT i.B, i.E, i.KOL, i.KV, i.BRANCH, i.ND, i.CC_ID, i.SDATE, i.WDATE, i.RNK, i.DAT1, i.DAT2, i.OST8,
            i.IR, i.ACC, i.ARJK, i.SN, i.SK0,
       CASE WHEN i.OST8 = 0                     THEN 0
            WHEN mod(to_char(i.E,'yyyy'),4) = 0 THEN round( (i.SN+i.SK0) * (36600/i.kol) /i.OST8,2)
            ELSE                                     round( (i.SN+i.SK0) * (36500/i.kol) /i.OST8,2)
       END                                                                                         IRS,
                                                                                         c.NMK, c.OKPO
FROM customer c,
    (select v.b, v.e, (v.e-v.b) +1 KOL,  x.kv, x.branch, x.nd, x.cc_id, x.sdate, x.wdate, x.rnk,  x.dat1,
                                                                                                  x.dat2,
                                                                          -OSTS8(x.acc,v.b,v.e)/100 ost8,
                                                                             acrn.fprocn(x.acc,0,v.b) IR,
                                                                                                   x.acc,
                                                                                                  x.ARJK,
                            nvl((select sum(sn.dos)/100 from saldoa sn, accounts an, nd_acc nn
                                 where nn.nd  = x.ND   and nn.acc  = an.acc and  an.tip   = 'SN '
                                   and an.acc = sn.acc and sn.fdat >= v.B   and  sn.fdat <= v.E),0)   SN,
                            nvl((select sum(sk.dos)/100 from saldoa sk, accounts ak, nd_acc nk
                                 where nk.nd  = x.ND   and nk.acc  = ak.acc and  ak.tip   = 'SK0'
                                   and ak.acc = sk.acc and sk.fdat >= v.B   and  sk.fdat <= v.E),0)  SK0
     FROM V_SFDAT v,
          (SELECT d.branch, d.nd, d.cc_id, d.sdate, d.wdate, d.rnk, a.kv,  a.acc, to_number(t.txt)  ARJK,
                   to_date(cck_app.get_nd_txt (d.nd, 'DINDU'),'dd.mm.yyyy') dat1,
                   to_date(cck_app.get_nd_txt (d.nd, 'DO_DU'),'dd.mm.yyyy') dat2
            FROM nd_acc n,
                (select * from nd_txt   where tag = 'ARJK'       ) t,
                (select * from cc_deal  where vidd IN (11,12,13) ) d,
                (select * from accounts where tip = 'LIM'        ) a
            WHERE d.nd = n.nd and d.nd = t.nd AND n.acc = a.acc
           ) x
     ) i
WHERE i.rnk = c.rnk;

PROMPT *** Create  grants  VV_ARJK ***
grant SELECT                                                                 on VV_ARJK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VV_ARJK         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VV_ARJK.sql =========*** End *** ======
PROMPT ===================================================================================== 
