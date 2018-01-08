

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBK_ARC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view MBK_ARC ***

  CREATE OR REPLACE FORCE VIEW BARS.MBK_ARC ("ZDATE", "CC_ID", "SDATE", "WDATE", "VIDD", "KV", "LIMIT", "NMK", "ND", "NLS", "ACC", "DK", "RNK", "OKPO", "USERID", "KPROLOG", "DIG", "NLSN", "RATE", "GRP", "SUMP") AS 
  select mbd_k_a.zdate, mbd_k_a.cc_id, mbd_k_a.sdate, mbd_k_a.wdate, mbd_k_a.vidd, t.kv,
       mbd_k_a.limit, mbd_k_a.nmk, mbd_k_a.nd, mbd_k_a.nls, mbd_k_a.acc,
       mbd_k_a.dk, mbd_k_a.rnk, mbd_k_a.okpo, mbd_k_a.userid, mbd_k_a.kprolog, t.dig,
       n.nls,
       acrn.fprocn(mbd_k_a.acc,mbd_k_a.dk,mbd_k_a.sdate),
       n.grp,
       ( select nvl(sum(s),0) from opldok
          where acc = n.acc
            and fdat >= mbd_k_a.bdate
            and fdat <= mbd_k_a.wdate
            and (tipd = 1 and dk = 1 or tipd = 2 and dk = 0)
            and sos>=4  ) sump
  from mbd_k_a, tabval t, int_accn i, accounts n
 where mbd_k_a.kv = t.kv
   and mbd_k_a.acc = i.acc
   and mbd_k_a.dk = i.id
   and i.acra = n.acc;

PROMPT *** Create  grants  MBK_ARC ***
grant SELECT                                                                 on MBK_ARC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK_ARC         to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBK_ARC.sql =========*** End *** ======
PROMPT ===================================================================================== 
