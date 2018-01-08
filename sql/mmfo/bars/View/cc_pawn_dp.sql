

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_PAWN_DP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_PAWN_DP ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_PAWN_DP ("KP", "PW_ACC", "PW_BR", "PW_RNK", "PW_NMK", "PW_OB22", "PW_KV", "PW_NLS", "PW_OST", "PAWN", "NAME", "PW_MDATE", "DP_ACC", "DP_BR", "DP_RNK", "DP_NMK", "DP_OB22", "DP_KV", "DP_NLS", "DP_OST", "ID", "KOD", "MDATE", "BLKD", "ND", "CC_ID", "CC_BR", "CC_RNK", "CC_NMK", "SDATE", "WDATE", "VIDD", "CUSTTYPE") AS 
  select  dd.KP            ,   a9.acc    PW_ACC,  a9.branch PW_BR,  a9.rnk PW_RNK,  (select nmk from customer where rnk = a9.rnk) PW_NMK, 
        a9.ob22   PW_OB22,   a9.kv     PW_KV ,  a9.nls PW_NLS  ,  a9.ostc/100 PW_ost,       pw.pawn,    nw.name, a9.mdate PW_MDATE, 
        dp.acc    dp_ACC ,   dp.branch dp_BR ,  dp.rnk dp_RNK  ,  (select nmk      from customer where rnk = dp.rnk) dp_NMK, 
        dp.ob22   dp_OB22,   dp.kv     dp_KV ,  dp.nls dp_NLS  ,  dp.ostc/100 dp_ost, dp.id,dp.kod,     dp.mdate, dp.blkd, 
        dd.ND  , dd.cc_id,   dd.branch cc_br ,  dd.rnk cc_RNK  ,  (select nmk      from customer where rnk = dd.rnk) cc_NMK,
        dd.sdate, dd.wdate , dd.vidd,                             (select custtype from customer where rnk = dd.rnk) custtype 
from pawn_acc pw,   (select * from accounts where dazs is null) a9,  (select * from cc_pawn where s031_279 ='15') nw,  (select distinct nd, acc from cc_accp) zz,    
 (select 'йо '||decode(vidd,1,'чн',2,'чн',3,'чн','тн') KP,vidd,nd,cc_id,branch,rnk,sdate,wdate from cc_deal where vidd in (1,2,3,11,12,13) and sos<15    union all
  select 'ой W4' KP,to_number(a.nbs) vidd, b.nd, a.nls, a.branch,a.rnk,a.daos,a.mdate from W4_ACC b , accounts a where b.acc_pk=a.acc and a.dazs is null union all
  select 'ой Co' KP,to_number(a.nbs) vidd, b.nd, a.nls, a.branch,a.rnk,a.daos,a.mdate from BPK_ACC b, accounts a where b.acc_pk=a.acc and a.dazs is null
  ) dd, 
 (select 'DPT' kod, a.acc,a.kv,a.nls,a.rnk,a.ostc,a.ob22,a.mdate,a.blkd,d.Deposit_id id, d.branch from DPT_DEPOSIT d, accounts a where d.acc=a.acc and a.dazs is null union all
  select 'DPU' kod, a.acc,a.kv,a.nls,a.rnk,a.ostc,a.ob22,a.mdate,a.blkd,d.Dpu_id     id, d.branch from DPU_DEAL    d, accounts a where d.acc=a.acc and a.dazs is null 
  ) dp
where a9.acc = pw.acc  and pw.pawn = nw.pawn and a9.acc = zz.acc and zz.nd = dd.nd    and pw.DEPOSIT_ID  = dp.id  (+);

PROMPT *** Create  grants  CC_PAWN_DP ***
grant SELECT                                                                 on CC_PAWN_DP      to BARSREADER_ROLE;
grant SELECT                                                                 on CC_PAWN_DP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PAWN_DP      to START1;
grant SELECT                                                                 on CC_PAWN_DP      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_PAWN_DP.sql =========*** End *** ===
PROMPT ===================================================================================== 
