PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_OVER.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** Create  procedure P_KOL_ND_OVER ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND_OVER (p_dat01 date, p_mode integer) IS

/* Версия 4.0  22-06-2017  24-01-2017 18-01-2017  10-10-2016
   Кількість днів прострочки по договорам ОВЕРДРАФТА
   -------------------------------------
  3) 22-06-2017 - NVL при определении фин.класа
  2) 24-01-2017 - Добавлен параметр S080 в p_get_nd_val
  1) 18-01-2017 - Уточнение фин.стана
*/

 l_s080 specparam.s080%type;

 l_kol   integer; l_rnk  integer; l_custtype  integer;  l_fin  integer; l_f    integer; l_fin23     integer;
 l_tip   integer; fl_    integer; l_cls       integer;

 l_dat31 date   ; l_txt  varchar2(1000);

begin
   if p_mode = 0 THEN
      begin
         select 1 into fl_ from rez_log
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt ='Конец К-во дней ОВЕРДРАФТЫ 351 ' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней ОВЕРДРАФТЫ 351 ');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   for k in ( select o.* from acc_over o, nd_open n where n.fdat= p_dat01 and o.nd = n.nd )
   LOOP
      l_kol  := 0;
      select c.rnk, c.custtype into l_rnk,l_custtype from accounts a, customer c where acc = k.acco and a.rnk = c.rnk;
      if l_custtype=2 THEN l_tip := 2; l_f := 56;
      else                 l_tip := 1; l_f := 60;
      end if;
      for s in (select max(nvl(f_days_past_due(p_DAT01, acc,decode(custtype,3,25000,50000)),0)) kol
                from  (select ost_korr(a.acc,l_dat31,null,a.nbs) ost, acc, custtype
                       from accounts a, customer c
                       where a.acc in (select acco from acc_over where nd=k.nd) AND NBS IN ('2067','2069') and a.rnk=c.rnk
                       union all
                       select ost_korr(acc,l_dat31,null,nbs) ost, acc, custtype from accounts a  , customer c
                       where NBS IN ('2067','2069') and a.rnk=c.rnk
                         AND acc in (select acra from int_accn
                                     where id=0 and acc in (select acco from acc_over  where nd=k.nd)) and nbs not like '8%')
                where ost<0
               )
      LOOP
         l_fin23 := k.fin23;
         l_kol := greatest(l_kol,s.kol);
         if l_f = 56 THEN
            l_cls := fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, l_rnk);
            Case
               when l_kol between 31 and 60 then  l_fin := greatest(l_cls,  5 );
               when l_kol between 61 and 90 then  l_fin := greatest(l_cls,  8 );
               when l_kol >  90             then  l_fin := greatest(l_cls, 10 );
            else                                  l_fin := l_cls;
            end case;
            --fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, l_rnk); -- фін.стан зкоригований на к-ть днів прострочки
            --l_fin := fin_nbu.zn_p_nd('CLSP',  l_f, p_dat01, k.nd, k.rnk);
         else
            l_fin := fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, l_rnk);
         end if;
         if l_fin is null or l_fin = 0 and l_custtype = 2 THEN
            l_txt := 'ОВЕР.';
            p_error_351( P_dat01, k.nd, user_id,15, k.acco, l_custtype,  null, NULL, l_txt, l_rnk, NULL);
            l_fin := l_fin23;
         elsif l_custtype = 3 THEN
            l_fin := nvl(l_fin,f_fin23_fin351(l_fin23,l_kol));
         end if;
         if l_fin is null or l_fin=0 THEN
            l_fin := nvl(l_fin23,1);
         end if;
         fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, l_rnk); -- фін.стан зкоригований на к-ть днів прострочки
         l_s080 := f_get_s080(p_dat01, l_tip, l_fin);
         p_get_nd_val( p_dat01, k.nd, 10, l_kol, l_rnk, l_tip, l_fin, l_s080 );
      END LOOP;
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней ОВЕРДРАФТЫ 351 ');
end;
/
show err;

PROMPT *** Create  grants  P_KOL_ND_OVER ***
grant EXECUTE                                                                on P_KOL_ND_OVER   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KOL_ND_OVER   to RCC_DEAL;
grant EXECUTE                                                                on P_KOL_ND_OVER   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_OVER.sql =========*** End
PROMPT ===================================================================================== 
