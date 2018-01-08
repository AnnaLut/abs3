

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/R_MSFZ9.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view R_MSFZ9 ***

  CREATE OR REPLACE FORCE VIEW BARS.R_MSFZ9 ("ND", "NDI", "ACC", "NLS", "KV", "DAPP", "TIP", "OST0", "OST", "DAZS") AS 
  select d.nd, d.ndi , a.acc, a.nls, a.kv, a.dapp, a.tip,    fost(a.acc, gl.bd - 1)  ost0,   fost(a.acc, gl.bd    )  ost,   a.dazs 
from bars.cc_deal d, bars.accounts a  , bars.nd_acc_old n  
where a.acc= n.acc and d.nd = n.nd and d.ndi  = bars.pul.get ('ND');

PROMPT *** Create  grants  R_MSFZ9 ***
grant SELECT                                                                 on R_MSFZ9         to BARSREADER_ROLE;
grant SELECT                                                                 on R_MSFZ9         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/R_MSFZ9.sql =========*** End *** ======
PROMPT ===================================================================================== 
