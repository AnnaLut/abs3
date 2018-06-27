create or replace view V_605 as 
  select 1 MD, d.nd, d.cc_id, d.sdate, d.wdate, d.sos, d.vidd, d.rnk, c.nmk, a.KV, a.NLS 
  from cc_deal d , customer c , accounts a, nd_acc n
  where d.rnk = c.rnk and d.nd = to_number( pul.get ('ND_605')) and d.nd = n.nd and n.acc = a.acc and a.tip = 'SS ' and  to_number( pul.get ('MOD_605') ) in (1,2) 
  union all
  select 3 MD, w.nd, '', a.daos, a.mdate, null, null, a.rnk, c.nmk, a.KV, a.NLS 
  from W4_ACC w , customer c , accounts a
  where a.rnk = c.rnk and w.nd = to_number( pul.get ('ND_605')) and w.acc_OVR = a.acc and  to_number( pul.get ('MOD_605') ) in (3)  ;

  
grant select on  v_605    to BARS_ACCESS_DEFROLE ;