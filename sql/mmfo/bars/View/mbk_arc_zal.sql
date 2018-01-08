

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBK_ARC_ZAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view MBK_ARC_ZAL ***

  CREATE OR REPLACE FORCE VIEW BARS.MBK_ARC_ZAL ("ZDATE", "CC_ID", "SDATE", "WDATE", "KV", "LIMIT", "NMK", "OKPO", "ND", "NLS", "ACC", "DK", "RNK", "USERID", "KPROLOG", "DIG", "NLSN", "RATE", "GRP", "SUMP") AS 
  select mbd_k_a.zdate, mbd_k_a.cc_id, mbd_k_a.sdate, mbd_k_a.wdate, t.kv,
       mbd_k_a.limit, mbd_k_a.nmk, mbd_k_a.nd, mbd_k_a.nls, mbd_k_a.acc,
       mbd_k_a.dk, mbd_k_a.rnk, mbd_k_a.okpo, mbd_k_a.userid, mbd_k_a.kprolog, t.dig,
       n.nls, acrn.fprocn(mbd_k_a.acc,mbd_k_a.dk,mbd_k_a.sdate), n.grp,
       ( select nvl(sum(s),0) from opldok
          where acc = n.acc
            and fdat >= mbd_k_a.bdate
            and fdat <= mbd_k_a.wdate
            and (tipd = 1 and dk = 1 or tipd = 2 and dk = 0)
            and sos>=4) sump
  from mbd_k_a, tabval t, int_accn i, accounts n,
       cc_accp c, pawn_acc p, accounts a
 where mbd_k_a.kv = t.kv
   and mbd_k_a.acc = i.acc
   and mbd_k_a.dk = i.id
   and i.acra = n.acc
   and mbd_k_a.acc = a.acc
   and a.acc = c.accs
   and c.acc = p.acc
   and (c.nd = mbd_k_a.nd and fost_h(c.acc,mbd_k_a.wdate) <> 0
     or c.nd is null      and fost_h(c.acc,a.mdate) <> 0)
   and fost_h(c.acc,bankdate) <> 0
   and mbd_k_a.nd not in (select nd from mbd_k)
   and exists (select nd from cc_accp where acc=c.acc and nd>mbd_k_a.nd);

PROMPT *** Create  grants  MBK_ARC_ZAL ***
grant SELECT                                                                 on MBK_ARC_ZAL     to BARSREADER_ROLE;
grant SELECT                                                                 on MBK_ARC_ZAL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK_ARC_ZAL     to FOREX;
grant SELECT                                                                 on MBK_ARC_ZAL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBK_ARC_ZAL.sql =========*** End *** ==
PROMPT ===================================================================================== 
