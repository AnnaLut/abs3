-----НОВыЕ дог = ДО АВТОРИЗАЦИИ-----------------------------
create or replace view BARS.v0_ovrn as
select Decode (sos,0,0,1) AVT, ISP, Substr(BRANCH,2,6) KF,
       ND, sos, RNK, cc_id,  sdate, wdate,    
       limit   LIMIT,
--     lim/100 LIMIT, 
       acc, acrn.fprocn(acc,0, gl.bd) IR0,  
       acrn.fprocn (acc,1, gl.bd) IR1, 
       ostc/100 OSTC, (lim+ostc)/100 OST_free, KV, nls8,  decode (x.metr,7,1,0 ) metr, x.idr ,
    (select count (*) from accounts where accc= x.acc) kol,  
    (select min(nls)  from accounts where rnk=x.rnk and accc = x.acc) NLS,
    (select to_number(value) from accountsw where acc = x.acc and tag = 'TERM_DAY' ) day, ---'TERM_DAY' -- Термiн(день мiс) для сплати %%
    (select to_number(value) from accountsw where acc = x.acc and tag = 'PCR_CHKO' ) PD , ---'PCR_CHKO' -- Розмiр лiмiту (% вiд ЧКО)
    (select to_number(value) from accountsw where acc = x.acc and tag = 'NOT_ZAL'  ) NZ     -- Без обеспечения 
from (select d.BRANCH,d.user_id ISP,d.ND, d.sos, d.RNK, d.cc_id, d.sdate, d.wdate, d.limit, a.lim, a.ostc, a.acc, a.kv,  a.NLS nls8 , i.metr, i.idr
      from  cc_deal d, accounts a, nd_acc n, int_accn i
      where d.vidd = ovrn.vidd and d.nd = n.nd and n.acc = a.acc and a.tip = ovrn.tip
       and i.id = 0 and i.acc= a.acc and d.sos < 10 
     ) x ;
grant select on  BARS.v0_ovrn to BARS_ACCESS_DEFROLE;
