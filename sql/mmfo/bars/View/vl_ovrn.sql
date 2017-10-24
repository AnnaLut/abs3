
-----Установка лимитов

create or replace view BARS.vL_ovrn as 
select Substr(BRANCH,2,6) KF, ND, cc_id ,  sdate, wdate, sos, nls, NMK, RNK, OKPO, NK, LIMIT,  LIM_OLD, CHKO3 ,CHKO13, LIM_NEW, 
       round( div0( LIM_OLD-LIM_NEW, LIM_OLD ) *100,2)  DEL10,
       OVRN.GetAL( acc, gl.bd) AL,
       acc,   accc, FDAT, DATM, DATX , 'Друк' PRINT , to_char(DATX, 'dd.mm.yyyy') DATXS,
       PD, DONOR
from (select d.ND  , d.cc_id, d.sdate, d.wdate, d.sos, d.BRANCH,
             (select lim from ovr_lim where acc = a.acc and fdat = d.sdate)/100  LIMIT, 
             a.accc, a.acc, a.nls, decode (a.accc, null, '', c.nmk ) nmk,  a.rnk,  decode (a.accc, null, '', c.okpo) okpo, 
             (select to_number(value) from accountsw where acc = a.acc and tag = ovrn.TAGK ) NK, ---- Новый Клиент (Да/Нет)
             (select to_number(value) from accountsw where acc = a.acc and tag = ovrn.TAGN ) DONOR,
             (select to_number(value) from accountsw where acc = a.acc and tag = ovrn.TAGC ) PD,
             a.lim/100 LIM_OLD ,  CHKO3, CHKO13,
             (select lim from ovr_lim where acc = a.acc and fdat = l.fdat)/100  LIM_NEW, 
             l.FDAT, o.DATM, o.DATX 
      from cc_deal d, nd_acc n, accounts a, customer c, 
           (select acc, sum(s)/100 CHKO13, 
                        sum (CASE WHEN DATM >= add_months(trunc(gl.BD,'MM'),-1) THEN s ELSE 0 END) /100 CHKO3, 
                        min (DATM) DATM, max(DATM) DATX  
            from OVR_CHKO where DATM >=  add_months ( trunc(gl.BD,'MM'), -3)  and DATM < trunc( gl.BD,'MM') 
            group by acc
            ) o,
           (select acc, min(fdat)  FDAT from ovr_lim where fdat >= trunc(gl.bd,'MM') +20  group by acc)  l 
      where ( a.nbs in ('2600','2650' ) or a.tip = ovrn.tip )
        and a.acc = n.acc   and n.nd = d.nd  and d.vidd = ovrn.vidd  and d.sos >= 10 and d.vidd < 15 and a.rnk = c.rnk
        and a.acc = o.acc (+) 
        and a.acc = l.acc (+) 
);
 
grant select on  BARS.vL_ovrn to BARS_ACCESS_DEFROLE;
