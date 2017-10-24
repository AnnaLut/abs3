

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TAB_1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TAB_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TAB_1 ("TIPA", "ACC", "NLS", "KV", "FIN", "EAD", "EADQ", "BV", "BVQ", "ND", "EAD_SN", "EAD_SNQ", "EAD_CCF", "EAD_CCFQ", "ZAL", "ZALQ", "RC", "RCQ", "CR", "CRQ", "REZ39", "REZQ39", "REZ23", "REZQ23", "ISTVAL", "CCF", "G6", "DEL", "S250", "CUSTTYPE", "DD", "DDD", "NBS", "RZ", "PD_0", "TIP", "RPB", "X6", "X7", "X8", "X9", "X10", "X11") AS 
  select n.TIP_351 TIPA,
          n.acc,
          n.nls,
          n.kv,
          decode (n.pd_0,1,1,nvl(n.fin_351,1)) FIN,
          decode(f_nbs_tip ( n.NBS ), 9, n.bv ,nvl(n.ead ,0) ) ead ,
          decode(f_nbs_tip ( n.NBS ), 9, n.bvq,nvl(n.eadq,0) ) eadq,
          n.bv BV,
          n.BVQ BVQ,
          n.nd,
          decode(f_nbs_tip ( n.NBS ), 1, n.bv , 2, n.bv , 0) EAD_sn,
          decode(f_nbs_tip ( n.nbs ), 1, n.bvq, 2, n.bvq, 0) EAD_snQ,
          decode(f_nbs_tip ( n.NBS ), 9, nvl(n.ead ,0), 0 ) EAD_CCF,
          decode(f_nbs_tip ( n.NBS ), 9, nvl(n.eadq,0), 0 ) EAD_CCFQ,
          nvl(n.zal_351,0) zal, nvl(n.zalq_351,0) zalq,
          nvl(n.RC     ,0) rc , nvl(n.rcq     ,0) rcq ,
          n.CR  cr,
          n.CRQ crq,
          nvl(n.rez39,n.rez) rez39,
          nvl(n.rezq39,n.rezq) rezq39,
          n.rez23,n.rezq23,
          n.istval,
          n.ccf,
          n.zalq_351 + n.RCq G6,
          n.crq - nvl(n.rezq39,n.rezq) DEL,
          decode(n.nbs,'9129', 0, decode(f_get_port(nd, rnk),8,1, decode(n.s250_23,'8',1,0))) s250,
          n.custtype ,
          n.dd,
          n.ddd,
          n.nbs,
          n.rz,
          N.PD_0,
          n.tip,
          n.rpb,
          case  when nvl(rpb,0)<20                      then ZALQ_351 else 0 end x6,
          case  when nvl(rpb,0)>20 and  nvl(rpb,0)<40   then ZALQ_351 else 0 end x7,
          case  when nvl(rpb,0)>40 and  nvl(rpb,0)<60   then ZALQ_351 else 0 end x8,
          case  when nvl(rpb,0)>60 and  nvl(rpb,0)<80   then ZALQ_351 else 0 end x9,
          case  when nvl(rpb,0)>80 and  nvl(rpb,0)<100  then ZALQ_351 else 0 end x10,
          case  when nvl(rpb,0)>100                     then ZALQ_351 else 0 end x11
   from   nbu23_rez n
   where  --substr(id,1,3) not in ('NEW') and
          n.fdat=TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy');

PROMPT *** Create  grants  V_TAB_1 ***
grant SELECT                                                                 on V_TAB_1         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TAB_1         to RCC_DEAL;
grant SELECT                                                                 on V_TAB_1         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TAB_1.sql =========*** End *** ======
PROMPT ===================================================================================== 
