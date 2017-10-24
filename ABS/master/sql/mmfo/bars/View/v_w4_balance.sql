

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_BALANCE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_BALANCE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_BALANCE ("BALANCE_DATE", "BRANCH", "NLS", "LCV", "NMK", "PK_OST", "OST", "W4_OST", "DELTA_OST", "MOB_NLS", "MOB_OST", "W4_MOB_OST", "DELTA_MOB", "LIM_NLS", "LIM_OST", "W4_LIM_OST", "DELTA_LIM", "W4_SEC_OST", "W4_VIRT_OST") AS 
  select (select val from ow_params where par = 'CNGDATE') balance_date,
       branch, nls, lcv, nmk, pk_ost,
       ost, w4_ost, ost-w4_ost delta_ost,
       mob_nls, nvl2(mob_nls,mob_ost,null) mob_ost, w4_mob_ost, mob_ost-w4_mob_ost delta_mob,
       lim_nls, nvl2(lim_nls,lim_ost,null) lim_ost, w4_lim_ost, lim_ost-w4_lim_ost delta_lim,
       w4_sec_ost, w4_virt_ost
  from ( select t.branch, t.nmk, t.acc, t.nls, w.contract_currency lcv, t.pk_ost,
                (t.pk_ost+t.ovr_ost+t.a2208_ost+t.a2627_ost+t.a2207_ost+t.a2209_ost+t.a3570_ost+t.a3579_ost+t.a2628_ost) ost,
                t.mob_nls, t.mob_ost, nvl(w.mob_amount,0) w4_mob_ost,
                t.lim_acc, t.lim_nls, abs(t.lim_ost+t.ovr_ost) lim_ost,
                (nvl(w.own_amount,0) + nvl(w.sec_amount,0) + nvl(w.ad_amount,0)+ nvl(w.virtual_amount, 0)) w4_ost,
                nvl(w.cr_amount,0) w4_lim_ost,
                nvl(w.sec_amount,0) w4_sec_ost,
                nvl(w.virtual_amount, 0) w4_virt_ost
           from ow_cng_data w,
                ( select a.branch, c.nmk, a.acc acc, a.nls nls, fost(a.acc, d.dat)/100 pk_ost,
                         decode(o.acc_ovr, null,0,fost(o.acc_ovr, d.dat))/100 ovr_ost,
                         decode(o.acc_2208,null,0,fost(o.acc_2208,d.dat))/100 a2208_ost,
                         decode(o.acc_2627,null,0,fost(o.acc_2627,d.dat))/100 a2627_ost,
                         decode(o.acc_2207,null,0,fost(o.acc_2207,d.dat))/100 a2207_ost,
                         decode(o.acc_2209,null,0,fost(o.acc_2209,d.dat))/100 a2209_ost,
                         decode(o.acc_3570,null,0,fost(o.acc_3570,d.dat))/100 a3570_ost,
                         decode(o.acc_3579,null,0,fost(o.acc_3579,d.dat))/100 a3579_ost,
                         decode(o.acc_2628,null,0,fost(o.acc_2628,d.dat))/100 a2628_ost,
                         m.nls mob_nls, decode(o.acc_2625d,null,0,fost(m.acc,d.dat))/100 mob_ost,
                         s.acc lim_acc, s.nls lim_nls, decode(o.acc_9129,null,0,fost(s.acc,d.dat))/100 lim_ost
                    from w4_acc o, accounts a, customer c, accounts m, accounts s,
                         (select nvl(to_date(val,'dd.mm.yyyy'),bankdate) dat from ow_params where par = 'CNGDATE') d
                   where o.acc_pk = a.acc
                     and a.tip like 'W4%'
                     and a.branch like sys_context ('bars_context', 'user_branch_mask')
                     and a.rnk = c.rnk
                     and o.acc_2625d = m.acc(+)
                     and o.acc_9129 = s.acc(+) ) t
          where w.acc = t.acc and w.acc is not null )
 where ost <> w4_ost
    or lim_nls is not null and lim_ost <> w4_lim_ost
    or mob_nls is not null and mob_ost <> w4_mob_ost
    or pk_ost < w4_sec_ost;

PROMPT *** Create  grants  V_W4_BALANCE ***
grant SELECT                                                                 on V_W4_BALANCE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_BALANCE    to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_BALANCE.sql =========*** End *** =
PROMPT ===================================================================================== 
