create or replace view Bars.V_NLS_KRM  as 
   select 0 ok,   a.acc, a.kv, a.nls, a.rnk, c.nmk, c.okpo, a.nms, a.ostc/100 ostc, a.dapp, a.dazs, a.ostb/100 ostb,
          t.ref , t.nls_2903, (select acc from accounts where nls= t.nls_2903 and kv = a.kv) acc_2903 
   from customer c, accounts a, TMP_NLS_KRM  t 
   where a.kv = t.kv and a.nls = t.nls and a.rnk=c.rnk ;
/ 
grant select  on bars.V_NLS_KRM   TO BARS_ACCESS_DEFROLE ;