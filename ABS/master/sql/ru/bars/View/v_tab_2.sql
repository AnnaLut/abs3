

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TAB_2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TAB_2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TAB_2 ("ACC", "TIP_ZAL", "REZQ23", "REZ23_RQ", "REZ39_RQ", "EADQ", "LGD", "CRQ", "S250", "X6", "X7", "X8", "X9", "X10", "X11") AS 
  select  acc,tip_zal,rezq23, rez23_rq,  rez39_rq, eadq,lgd, crq, s250,
         round(eadq * x6 ,2) *100 x6,
         round(eadq * x7 ,2) *100 x7,
         round(eadq * x8 ,2) *100 x8,
         round(eadq * x9 ,2) *100 x9,
         round(eadq * x10,2) *100 x10,
         round(eadq * x11,2) *100 x11
  from (
 select  r.acc,tip_zal,n.rezq23,decode (r.ead,0,0,round (rezq23*r.ead / sum(r.ead) over  (partition by r.acc), 2)) rez23_rq,
                                decode (r.ead,0,0,round (rezq39*r.ead / sum(r.ead) over  (partition by r.acc), 2)) rez39_rq,
          r.eadq,r.lgd, r.crq,  decode (n.s250,'8',1,0) s250,
          case when r.kpz<= 0.2                THEN (1-r.lgd)  else 0 end x6,
          case when r.kpz>  0.2 and r.kpz<=0.4 THEN (1-r.lgd)  else 0 end x7,
          case when r.kpz>  0.4 and r.kpz<=0.6 THEN (1-r.lgd)  else 0 end x8,
          case when r.kpz>  0.6 and r.kpz<=0.8 THEN (1-r.lgd)  else 0 end x9,
          case when r.kpz>  0.8 and r.kpz<=1   THEN (1-r.lgd)  else 0 end x10,
          case when r.kpz>  1                  THEN (1-r.lgd)  else 0 end x11
   from rez_cr r, nbu23_REz n
   where  n.fdat=TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy')  and r.acc=n.acc);

PROMPT *** Create  grants  V_TAB_2 ***
grant SELECT                                                                 on V_TAB_2         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TAB_2         to RCC_DEAL;
grant SELECT                                                                 on V_TAB_2         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TAB_2.sql =========*** End *** ======
PROMPT ===================================================================================== 
