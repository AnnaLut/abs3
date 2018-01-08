

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INFLATION_ACC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INFLATION_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INFLATION_ACC ("ACC", "NLS", "KV", "ND", "CC_ID", "RNK", "NMK", "TYP", "TYP_KOD", "URL") AS 
  select a.acc,
                     a.nls,
                     a.kv,
                    (case when d.nd is not null then d.nd
                              when  coalesce(w4_2207.nd,w4_2209.nd) is not null then coalesce(w4_2207.nd,w4_2209.nd)
                              else null end) nd,
                     d.cc_id,
                     a.rnk,
                     c.nmk,
                    (case when d.nd is not null then 'Кредит'
                             when coalesce(w4_2207.acc_2207,w4_2209.acc_2209) is not null then 'БПК'
                             else 'Без. дог.' end) typ,
                    (case when d.nd is not null then 1
                             when coalesce(w4_2207.acc_2207,w4_2209.acc_2209) is not null then 2
                             else 0 end) typ_kod,
                     make_url('/barsroot/barsweb/references/refbook.aspx', 'Обороти по рах.','tabname','V_INFLATION_SALDOA','mode','RW','force','0','code','ACC','mtpar_N_acc', to_char(a.acc)) url
                     from saldo a inner join customer c on (a.rnk=C.RNK)
                     left join nd_acc n on (n.acc=a.acc)
                     left join cc_deal d on (d.nd=n.nd)
                     left join w4_acc w4_2207 on (a.acc=w4_2207.acc_2207)
                     left join w4_acc w4_2209 on (a.acc=w4_2209.acc_2209)
                     where a.nbs in ('2207','2209','2237','2239') and a.dazs is null;

PROMPT *** Create  grants  V_INFLATION_ACC ***
grant SELECT                                                                 on V_INFLATION_ACC to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_INFLATION_ACC to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_INFLATION_ACC to RCC_DEAL;
grant SELECT                                                                 on V_INFLATION_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INFLATION_ACC.sql =========*** End **
PROMPT ===================================================================================== 
