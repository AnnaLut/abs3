

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REZ_KPZ.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REZ_KPZ ***

  CREATE OR REPLACE PROCEDURE BARS.P_REZ_KPZ (p_dat01 date ) IS

/* Версия 1.0 21-12-2016
   Розрахунок коеф. покриття боргу + рівень покриття боргу
   -------------------------------------
 1) 21-12-2016 Добавлен rpb - рівень покриття боргу
*/


 l_dat31 date  ;  l_bv    number;
 l_kpz   number;  l_rpb   number;

begin
   l_dat31 := Dat_last_work (P_dat01 - 1 );
   update tmp_rez_obesp23 set kpz = null, rpb = null  where dat=p_dat01 and kpz is not null or rpb is not null;

   for n in (select distinct t.nd  from   tmp_rez_obesp23 t, v23_pawn p where  t.dat = p_dat01 and t.pawn = p.pawn and p.kpz_351<>0)
   LOOP

      for p in (select kv,nd,sum(z) z, sum(zal_l) zal_l
                from ( select t.kv,t.nd, t.pawn, f_pawn_kpz(t.pawn) kpzi,decode (f_pawn_kpz(t.pawn),0,0,
                              round (sum(t.sall) * f_pawn_kl(t.pawn)/f_pawn_kpz(t.pawn),0)) z, sum(t.sall) sp, f_pawn_kl(t.pawn) kl,
                              round (sum(t.sall) * f_pawn_kl(t.pawn),0) zal_l
                       from   tmp_rez_obesp23 t
                       where  t.dat = p_dat01 and nd = n.nd
                       group by  t.kv,t.nd,t.pawn,f_pawn_kpz(t.pawn))
                group by kv,nd

               )
      LOOP
         l_rpb := 0;
         select sum(bv)*100 into l_bv from nbu23_rez
         where  fdat = p_dat01 and kv=p.kv and acc in (select accs from tmp_rez_obesp23 t where  t.dat = p_dat01  and t.nd = n.nd);
         if l_bv > 0 THEN l_kpz := round(p.z / l_bv,2); l_rpb := round(p.zal_l / l_bv,2) *100;
         else             l_kpz := 0; l_rpb := 0;
         end if;
         update tmp_rez_obesp23 set kpz = l_kpz, rpb = l_rpb where dat = p_dat01 and nd = n.nd and kv = p.kv;
      end loop;
   end LOOP;
   for f in (select distinct t.nd,t.accs, a.rnk, t.kpz, c.custtype cus, a.nbs,DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ
             from tmp_rez_obesp23 t, accounts a, customer c
             where dat = p_dat01 and kpz is not null and kpz <> 0 and t.accs = a.acc and a.rnk = c.rnk)
   LOOP
      l_kpz := f.kpz;
      if substr(f.nbs,1,2)='21' THEN
         if  1.3 <= l_kpz                 then   fin_nbu.record_fp_nd('IP2', 1, 70, p_dat01,f.nd,f.rnk);
         elsif 1 <= l_kpz and l_kpz < 1.3 then   fin_nbu.record_fp_nd('IP2', 2, 70, p_dat01,f.nd,f.rnk);
         else                                    fin_nbu.record_fp_nd('IP2', 3, 70, p_dat01,f.nd,f.rnk);
         end if;
      elsif f.cus = 2 THEN
         if  1.3 <= l_kpz                 then   fin_nbu.record_fp_nd('IP2', 1, 50, p_dat01,f.nd,f.rnk);
         elsif 1 <= l_kpz and l_kpz < 1.3 then   fin_nbu.record_fp_nd('IP2', 2, 50, p_dat01,f.nd,f.rnk);
         else                                    fin_nbu.record_fp_nd('IP2', 3, 50, p_dat01,f.nd,f.rnk);
         end if;
      elsif f.cus = 3 THEN
         if  1.3 <= l_kpz                 then   fin_nbu.record_fp_nd('IP2', 1, 60, p_dat01,f.nd,f.rnk);
         elsif 1 <= l_kpz and l_kpz < 1.3 then   fin_nbu.record_fp_nd('IP2', 2, 60, p_dat01,f.nd,f.rnk);
         else                                    fin_nbu.record_fp_nd('IP2', 3, 60, p_dat01,f.nd,f.rnk);
         end if;
      elsif f.cus = 1 and f.rz = 1 THEN
         if  1.3 <= l_kpz                 then   fin_nbu.record_fp_nd('IP2', 1, 80, p_dat01,f.nd,f.rnk);
         elsif 1 <= l_kpz and l_kpz < 1.3 then   fin_nbu.record_fp_nd('IP2', 2, 80, p_dat01,f.nd,f.rnk);
         else                                    fin_nbu.record_fp_nd('IP2', 3, 80, p_dat01,f.nd,f.rnk);
         end if;
      else
         if  1.3 <= l_kpz                 then   fin_nbu.record_fp_nd('IP2', 1, 81, p_dat01,f.nd,f.rnk);
         elsif 1 <= l_kpz and l_kpz < 1.3 then   fin_nbu.record_fp_nd('IP2', 2, 81, p_dat01,f.nd,f.rnk);
         else                                    fin_nbu.record_fp_nd('IP2', 3, 81, p_dat01,f.nd,f.rnk);
         end if;
      end if;
   end LOOP;
end ;
/
show err;

PROMPT *** Create  grants  P_REZ_KPZ ***
grant EXECUTE                                                                on P_REZ_KPZ       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REZ_KPZ       to RCC_DEAL;
grant EXECUTE                                                                on P_REZ_KPZ       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REZ_KPZ.sql =========*** End ***
PROMPT ===================================================================================== 
