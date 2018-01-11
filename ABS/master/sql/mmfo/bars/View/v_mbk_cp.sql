

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBK_CP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBK_CP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBK_CP ("ND", "ID", "KOL", "SASIN", "REF", "KVZ", "NLSZ", "ACCZ", "SZ", "RNKZ", "NMKZ", "CP_ID", "KVM", "NLSM", "ACCM", "SM", "RNKM", "NMKM", "CC_ID", "CP_BLK", "CP_ALL") AS 
  select mz.ND, mz.ID,  mz.KOL, mz.SASIN,  mz.REF,
       az.kv kvz, az.nls nlsz, az.acc accz ,  am.ostc/100 Sz, az.rnk rnkz, cz.nmk nmkz, cp_id,
       am.kv kvm, am.nls nlsm, am.acc accm ,  am.ostc/100 SM, am.rnk rnkm, cm.nmk nmkm, dd.cc_id,
      (select nvl(sum(GET_ACCW(d.acc,0,null,0,'CP_ZAL',gl.bd)),0) from cp_deal d where d.id=kz.id and d.dazs is null )          cp_blk,
      (select -nvl(sum(a.ostb),0) from cp_deal d, accounts a where d.id=kz.id and d.dazs is null and d.acc=a.acc)/(kz.cena*100) cp_all
from mbk_cp mz, cp_kod kz, accounts az, customer cz,
                cc_add dm, accounts am, customer cm, cc_deal dd
where mz.nd = dm.nd  and dm.adds = 0 and dm.accs = am.acc and am.rnk = cm.rnk and dd.nd = mz.nd
  and mz.id = kz.id                  and mz.acc  = az.acc and kz.rnk = cz.rnk  (+);

PROMPT *** Create  grants  V_MBK_CP ***
grant SELECT                                                                 on V_MBK_CP        to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBK_CP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBK_CP        to START1;
grant SELECT                                                                 on V_MBK_CP        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBK_CP.sql =========*** End *** =====
PROMPT ===================================================================================== 
