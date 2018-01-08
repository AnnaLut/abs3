------–¿¡Œ◊»≈ ƒŒ√ = œŒ—À≈ ‡‚ÚÓËÁ ----------------------------
create or replace view BARS.v1_ovrn as
select 1 AVT, ISP, Substr(BRANCH,2,6) KF, ND, sos,  RNK, cc_id, sdate, wdate,  lim/100 LIMIT, acc, IR0,   IR1,  OSTC, (lim+OSTC) /100  OST_free, 
       KV, nls8,  metr, idr, kol ,  NLS, day, PD, DT_SOS 
from 
(
select ISP, BRANCH, ND, sos, RNK, cc_id, sdate, wdate, lim, acc, KV, nls8, decode (x.metr,7,1,0 ) metr, idr ,
        acrn.fprocn (acc,0, gl.bd) IR0 , acrn.fprocn (acc,1, gl.bd) IR1 ,  OVRN.GetW (acc, 'DT_SOS') DT_SOS, 
       (select Sum(ostC) from accounts where accc = x.acc and ostb < 0          ) OSTC,
       (select count (*) from accounts where accc= x.acc and tip <> 'SP '       ) kol ,  
       (select min(nls)  from accounts where rnk=x.rnk and accc = x.acc         ) NLS ,
       (select to_number(value) from accountsw where acc=x.acc and tag=ovrn.TAGD) day ,
       (select to_number(value) from accountsw where acc=x.acc and tag=ovrn.TAGC) PD 
from (
select d.user_id ISP,d.ND, d.sos, d.RNK, d.cc_id, d.sdate, d.wdate, d.limit, a.lim, a.ostc, a.acc, a.kv,  a.NLS nls8,
             i.metr, i.idr, d.BRANCH 
      from  cc_deal d, accounts a, nd_acc n, int_accn i 
      where d.vidd = 10 and d.nd = n.nd and n.acc = a.acc and a.tip = 'OVN'
        and i.id = 0 and i.acc= a.acc and d.sos >= 10 and d.sos < 14
    ) x
) y ;

grant select on  BARS.v1_ovrn to BARS_ACCESS_DEFROLE;
