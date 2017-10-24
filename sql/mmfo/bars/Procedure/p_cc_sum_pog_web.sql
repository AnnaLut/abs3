

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CC_SUM_POG_WEB.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CC_SUM_POG_WEB ***

  CREATE OR REPLACE PROCEDURE BARS.P_CC_SUM_POG_WEB (DAT1_ date, DAT2_ date, nTip_Kl int ) IS
-- Расчет Прогноз суммы погашения за период работает НЕ  НА ВРЕМЕННой  ТАБЛИЦе
 CCK_NBU_ char(1) := GetGlobalOption('CCK_NBU');
 l_rec_id varchar2(32):= sys_guid();
BEGIN

delete from  cck_Sum_POG_web;

for k in ( SELECT a.acc, d.nd, a.kv, c.rnk,
                  substr(decode(CCK_NBU_,'1',c.nmkk,c.nmk),1,38) NMK,
                  substr(d.cc_id,1,20) CC_ID,
                  a.ostx-a.ostc G2
           FROM accounts a, customer c, cc_deal d, cc_vidd v, nd_acc n
           WHERE v.vidd=d.vidd and v.custtype=nTip_Kl
             AND a.rnk =c.rnk AND c.custtype in (1, 2,3)
             AND d.rnk =c.rnk
             AND a.acc =n.acc and n.nd=d.nd and a.tip='LIM'
             and a.ostc<0)
loop

  --1) + Просрочка
  --2) + Плановое пог
  --3) - Досрочное
  insert into CCK_SUM_POG_WEB (ACC,ND,KV,RNK,NMK,CC_ID,G1, G2, rec_id)
   select k.acc,k.nd,k.kv,k.rnk,k.nmk,to_char(fdat,'dd/mm/yyyy'),SUMG,0, l_rec_id
   FROM cc_lim
   WHERE nd=k.nd and sumg<>0 and fdat>=DAT1_ and fdat<=DAT2_  and not exists (select nd from nd_acc n, cc_trans t where n.nd = k.nd and n.acc = t.acc)
   union all
   select k.acc,k.nd,k.kv,k.rnk,k.nmk,to_char(gl.Bdate,'dd/mm/yyyy'),0,k.g2, l_rec_id
   from dual where k.g2<>0
   union all
   select k.acc,k.nd,k.kv,k.rnk,k.nmk,to_char(t.d_plan,'dd/mm/yyyy'),t.sv-t.sz,0, l_rec_id
   FROM cc_trans t, nd_acc n
   WHERE n.nd = k.nd and n.acc = t.acc and t.d_plan >= DAT1_ and t.d_plan <= DAT2_ and t.sv <> t.sz and t.d_fakt is null;

end loop;

pul.set_mas_ini('REC_ID', l_rec_id, '');

end;
/
show err;

PROMPT *** Create  grants  P_CC_SUM_POG_WEB ***
grant EXECUTE                                                                on P_CC_SUM_POG_WEB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CC_SUM_POG_WEB.sql =========*** 
PROMPT ===================================================================================== 
