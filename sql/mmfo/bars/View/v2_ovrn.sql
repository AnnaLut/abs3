create or replace view v2_ovrn as
select x.ND, x.cc_id, x.sdate, x.wdate, x.kv, x.RNK, x.sos, x.nls, x.RNK1, x.mdate, x.IRA, x.IRP, x.IRB, x.NMK1, x.okpo, x.DATVZ, x.TERM,
       x.DATSP, x.SP, x.SPN, x.RLIM, x.PK , x.DONOR, x.NK,  x.OSTC, x.OST_free, x.accc, x.acc ,  '¬вести' TARIF ,
 decode (x.sos, 0,
               (select lim/100 from ovr_lim where acc=x.acc and fdat=(select min(fdat) from ovr_lim where acc=x.acc)) ,
                x.lim
         ) LIM,
         '¬вести' ACC_ADD
from ( select d.ND, d.cc_id,  d.sdate, d.wdate,  a.kv, d.RNK, d.sos, a.nls, a.rnk RNK1 , a.mdate, acrn.fprocn (a.acc,0, gl.bd) IRA,                                                          --       acrn.fprocn (a.accc,1, gl.bd) IR1,
              acrn.fprocn (a.acc,1, gl.bd) IRP,  acrn.fprocn (a.acc,1, (d.sdate-1 )) IRB,
              a.lim/100 lim,  a.ostc/100 OSTC, (A.lim+A.ostc)/100 OST_free,       a.accc, a.acc ,
              C.NMK NMK1 , C.okpo,
              (select max(fdat) from saldoa where acc = a.acc and ostf >= 0 and ostf-dos+kos < 0 and a.ostc <0) DATVZ,
              (select to_number(value) from accountsw where acc = a.acc and tag = ovrn.TAG ) TERM ,
              (select min(DATSP) from OVR_TERM_TRZ where acc = a.acc ) DATSP,
              OVRN.SP(7, d.nd, a.rnk)  SP,  OVRN.SP(9, d.nd, a.rnk)  SPN ,
              (select min(fdat) from ovr_lim where acc = a.acc and fdat > gl.bd) RLIM ,
              (select to_number(value) from accountsw where acc = a.acc and tag = ovrn.TAGC ) PK ,
              (select to_number(value) from accountsw where acc = a.acc and tag = ovrn.TAGN ) DONOR,
              (select to_number(value) from accountsw where acc = a.acc and tag = ovrn.TAGK ) NK
       from  (select * from cc_deal where nd = to_number(pul.Get_Mas_Ini_Val('ND')) and vidd = ovrn.vidd )  d,
             (select * from nd_acc  where nd = to_number(pul.Get_Mas_Ini_Val('ND'))  ) n,
              accounts a, CUSTOMER C
       where  d.nd = n.nd and n.acc = a.acc and a.tip <>ovrn.tip  and accc is not null  and a.nbs in ('2600','2650') AND A.RNK = C.RNK
     ) x
;

grant select on  BARS.v2_ovrn  to start1 ;
grant select on  BARS.v2_ovrn  to BARS_ACCESS_DEFROLE ; 