

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PR_MSFZ9.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view PR_MSFZ9 ***

  CREATE OR REPLACE FORCE VIEW BARS.PR_MSFZ9 ("ND", "NDI", "ACC", "NLS", "KV", "DAPP", "TIP", "DAZS", "OST0", "OST", "OSTQ", "IR") AS 
  select d.nd, d.ndi , a.acc, a.nls, a.kv, a.dapp, a.tip,  a.dazs , 
       Bars.fost(a.acc, Bars.gl.bd - 1)/100  ost0,   a.ostc/100  ost,   
       bars.gl.p_icurval(kv, a.ostc, bars.gl.bd)/100 OSTQ ,  bars.acrn.fprocn (a.acc, 0, bars.gl.bd) IR
from bars.cc_deal d, bars.accounts a  , bars.nd_acc_old n  
where a.acc= n.acc and d.nd = n.nd and d.ndi  = bars.pul.get ('ND')  and ( a.dazs is null  or a.dazs > gl.bd);

PROMPT *** Create  grants  PR_MSFZ9 ***
grant SELECT                                                                 on PR_MSFZ9        to BARSREADER_ROLE;
grant SELECT                                                                 on PR_MSFZ9        to START1;
grant SELECT                                                                 on PR_MSFZ9        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PR_MSFZ9.sql =========*** End *** =====
PROMPT ===================================================================================== 
