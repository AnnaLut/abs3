
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_bv_sna.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BV_SNA (p_dat01 date, p_nd integer, p_acc integer, p_kv integer) RETURN number is

/* Версия 1.1 01-12-2017  28-10-2016
   РАСПРЕДЕЛЕНИЕ SNA (невизнанні доходи)
   -------------------------------------
   01-12-2017(1.1) Добавила 9129
   28-10-2016(1.0) Убрала SDI  EAD не уменьшается на SDI
*/

L_dat31  date;

begin
   l_dat31 := Dat_last_work (p_dat01 -1 );  -- последний рабочий день месяца
   for k in (select tip, nls, acc, kv,  nbs,  S, ss,  nvl(SD,0), s - sd bv
             from  (select tip, nls, acc, kv,  nbs,  S, ss, round(ss * s / sum(s) over  (partition by 1),0) SD
                    from (select a.tip, a.nls, a.acc, a.kv,  a.nbs, - ost_korr(a.acc,l_dat31,null,a.nbs) S,
                                (select nvl(sum(ost_korr(a.acc,l_dat31,null,a.nbs) ),0)  from   nd_acc n, accounts a
                                 where  n.nd = p_nd and a.kv = p_kv and n.acc = a.acc and a.nls not like '3%' and a.nbs<>'2620' and  a.tip in  ('SNA')
                                        and  ost_korr(a.acc,l_dat31,null,a.nbs) >0) ss
                          from   nd_acc n, accounts a
                          where  n.nd = p_nd and a.kv = p_kv and n.acc = a.acc and nls not like '3%' and a.nbs<>'2620' and
                                 ( a.tip in  ('SN ','SL ','SLN','SPN','SNO','SS ','SP ','SK9','SK0') or a.nbs like '15%' or a.nbs in ('2600','2607','9129')) and
                                 ost_korr(a.acc,l_dat31,null,a.nbs) < 0))
             )

   LOOP
      if k.acc = p_acc THEN return (k.bv); end if;
   end LOOP;
   return (0);
end;
/
 show err;
 
PROMPT *** Create  grants  F_BV_SNA ***
grant EXECUTE                                                                on F_BV_SNA        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BV_SNA        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_bv_sna.sql =========*** End *** =
 PROMPT ===================================================================================== 
 