create or replace view bars.PR_MSFZ9 as 
select d.nd, d.ndG , a.acc, a.nls, a.kv, a.dapp, a.tip,  a.dazs , 
       Bars.fost(a.acc, Bars.gl.bd - 1)/100  ost0,   a.ostc/100  ost,   
       bars.gl.p_icurval(kv, a.ostc, bars.gl.bd)/100 OSTQ ,  bars.acrn.fprocn (a.acc, 0, bars.gl.bd) IR
from bars.cc_deal d, bars.accounts a  , bars.nd_acc_old n  
where a.acc= n.acc and d.nd = n.nd and d.ndG  = bars.pul.get ('ND')  and ( a.dazs is null  or a.dazs > gl.bd) ;

GRANT SELECT ON bars.PR_MSFZ9 TO BARS_ACCESS_DEFROLE;