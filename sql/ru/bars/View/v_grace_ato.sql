

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRACE_ATO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRACE_ATO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRACE_ATO ("ND", "RNK", "SDATE", "WDATE", "CC_ID", "KK1", "GPP", "OTM1", "OTM2", "ADD3", "P_DAT", "REFP", "ACC", "NLS", "KV", "OSTC", "OSTB", "OSTF") AS 
  select d.nd, d.rnk, d.sdate, d.wdate, d.cc_id,
       0 KK1 ,   -- KK1~Виконати~згорнення зал
       0 GPP ,   -- GPP~Виконати~побудову ГПП
       0 OTM1,   -- Сократить~на переплату~ГПП
       0 OTM2,   -- Отменить~остаток~ГПП
       0 ADD3,    -- Добавить переплату равными долями
 (select to_date(txt, 'dd/mm/yyyy' ) from nd_txt where nd = d.nd and tag = 'GRACE') p_dat   ,
 (select refp  from cc_add where adds =0 and nd = d.nd) REFP ,
 x.acc, x.nls, x.kv, x.ostc, x.ostb, x.ostf
from cc_deal d ,
     (select a.acc, a.nls, a.kv, a.ostc/100 ostc, a.ostb/100 ostb, (a.ostb+a.ostf)/100 ostf, n.nd
       from nd_acc n, accounts a  where tip = 'SNO' and n.acc= a.acc) x
where d.sos < 15 and d.vidd  = 11 and d.wdate > ( gl.bd +31)   and d.nd = x.nd (+) ;

PROMPT *** Create  grants  V_GRACE_ATO ***
grant SELECT                                                                 on V_GRACE_ATO     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRACE_ATO.sql =========*** End *** ==
PROMPT ===================================================================================== 
