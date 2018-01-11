

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VX_OVRN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VX_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.VX_OVRN ("RNK", "KV", "NMS", "NLS", "ACR_DAT", "DAT1", "DAT2", "ACC8", "ACC", "PR", "IP8", "IA8", "IP2", "IA2", "ID", "NLSA", "NAM_A", "VN", "NLSB", "NAM_B", "NAZN") AS 
  select  t.rnk, t.kv,  t.nms, t.NLS, i.acr_dat,  y.dat1, y.dat2, x.acc8, x.acc,  round( abs(x.pr) ,0) PR,
        decode ( x.vn, 70, acrn.fprocn(x.acc8,1,y.dat2) , null) ip8,
        decode ( x.vn, 60, acrn.fprocn(x.acc8,0,y.dat2) , null) ia8,
        decode ( x.vn, 70, acrn.fprocn(x.acc ,1,y.dat2) , null) ip2,
        decode ( x.vn, 60, acrn.fprocn(x.acc ,0,y.dat2) , null) ia2,
        1- i.id ID , aa.nls NLSA, aa.nms NAM_a , x.vn,
        Substr( CASE WHEN aa.tip in ('SPN'      ) THEN CASE WHEN OVRN.F2017 = 1 THEN nbs_ob22_null ( '6025', '17', t.branch)  else nbs_ob22_null ( '6026', '17', t.branch)   end
                     WHEN x.vn   in (60,61,62,63) THEN nbs_ob22_null ( '6020', '06', t.branch)
                     WHEN x.vn   in (70         ) THEN nbs_ob22_null ( '7020', '06', t.branch)
                     else null
                     end ,  1, 15 ) NLSB,
        Decode ( x.vn, 70, 'Проц.витрати за пас.зал.', 'Проц.та коміс.дох.' ) || ' по дог.ОВР'  NAM_B ,
        Substr( decode ( x.vn, 60, 'Нар.%% дох.за ОВР ',
                               70, 'Нар.%% витр.',
                               61, 'Нар.ком за ОВР 1 дн',
                               62, 'Нар.ком за ОВР Холд.',
                               63, 'Нар.ком за посл NPP',
                                   null
                        ),   1,38)  NAzn
from int_accn i, accounts aa, accounts t,
     (select acc, min(cdat) dat1, max(cdat) dat2 from ovr_intx where mod1=1 group by        acc     ) y,
     (select acc8, acc, VN,       sum(pr) pr     from ovr_intx where mod1=1 group by acc8,  acc, VN ) x
where x.acc = y.acc and x.acc = t.acc and t.acc = i.acc and i.id = decode ( sign(x.pr),1 ,1,0 )  and aa.acc = i.acra ;

PROMPT *** Create  grants  VX_OVRN ***
grant SELECT                                                                 on VX_OVRN         to BARSREADER_ROLE;
grant SELECT                                                                 on VX_OVRN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VX_OVRN         to START1;
grant SELECT                                                                 on VX_OVRN         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VX_OVRN.sql =========*** End *** ======
PROMPT ===================================================================================== 
