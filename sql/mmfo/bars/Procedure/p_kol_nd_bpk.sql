

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_BPK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KOL_ND_BPK ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND_BPK (p_dat01 date, p_mode integer) IS

/* Версия 4.4  23-10-2018  26-03-2018 08-02-2017   24-01-2017  03-10-2016
   К_льк_сть дн_в прострочки по договорам БПК
   -------------------------------------
 8) 23-10-2018(4.4) - Проверка: если клас не определен и в договоре только 9129 - клас =1, иначе самый плохой
 7) 26-03-2018(4.3) - если фін.класс не определен для физ.=5, для юр. =10  (Письмо Коваленко Светланы 23-03-2018)
 6) 24-10-2017(4.2) - 2625,2627 - и нет др. задолженности - fin = 5, VKR = 'ГГГ', PD = 1
 5) 08-02-2017 - Изменено условие пересчета к-ва дней по БПК
 4) 08-02-2017 - Портфельный метод через функцию f_get_port (k.nd, k.rnk);
 3) 08-02-2017 - if l_fin = 0 THEN  l_fin:= null; end if;  --  фин. стан не определен - по l_fin:= null, будет определен по переходным полож.
 2) 24-01-2017 - Добавлен параметр S080 в p_get_nd_val
 1) 03-10-2016 - В p_get_nd_val добавлен РНК
*/


 l_rnk   accounts.rnk%type; l_custtype customer.custtype%type; l_s080  specparam.s080%type; l_s250 w4_acc.s250%type;

 KOL_    integer; l_fin    integer; l_f    integer; OPEN_    integer; l_TIP    integer; l_vidd  integer;
 l_fin23 integer; l_grp    integer; l_cls  integer; l_nd     integer;
 PR_     number ; FL_      NUMBER ;

 DATSP_  varchar2(30); DASPN_   varchar2(30); l_txt  varchar2(1000);
 DATP_   date        ; l_dat31  date  ;

 --TYPE CurTyp IS REF CURSOR;
 --c0   CurTyp;

begin
   if p_mode = 0 THEN
      begin
         select 1 into fl_ from rez_log
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt ='Конец К-во дней БПК 351' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;

   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней БПК 351');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца

   begin

      FOR k in (select nd, rnk, max(kol) kol, fin23, custtype,tipa
                from (select r.nd, r.fin23, r.rnk, r.nbs, r.nls, r.kv, r.tip,c.custtype, r.tip_kart tipa,
                             case WHEN r.tip in ('SS ', 'CR9', 'SK0', 'SN ') THEN 0
                             else f_days_past_due(p_DAT01, r.acc,decode(c.custtype,3,25000,50000))
                             end  kol
                      from  rez_w4_bpk r, customer c
                      where  --r.tip in  ('SP ', 'SPN', 'SK9', 'SL ', 'CR9', 'SS ', 'SK0', 'SN ')   and
                             r.rnk = c.rnk --and ost_korr(a.acc,l_dat31,null,a.nbs) < 0
                             and r.NBS not in ('3570','3578','3579','3550','3551')
                     )
                group by nd, rnk, custtype,fin23,tipa )
      loop
         l_fin   := null;
         l_fin23 := k.fin23;

         if k.custtype = 2 THEN l_vidd := 1 ; l_tip := 2; l_f := 56;
         else                   l_vidd := 11; l_tip := 1; l_f := 60;
         end if;

         l_grp   := f_get_port (k.nd, k.rnk);
         if  l_grp <>0 THEN  l_s250 := '8';
         else                l_s250 := null; l_grp := null;
         end if;

         IF l_S250 = 8 THEN
            l_fin := f_fin_pd_grupa (1, k.kol);
         else
            l_cls := nvl(fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, k.rnk),0);
            if l_cls = 0 THEN
               begin
                  select nd into l_nd from rez_w4_bpk where nd = k.nd and nbs in ('2625','2627','2620','2203','2208') and rownum=1;   --COBUMMFO-5208
                  l_fin := 5;
                  FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ГГГ');
               EXCEPTION WHEN NO_DATA_FOUND THEN  
                  begin
                     select nd into l_nd from rez_w4_bpk where nd = k.nd and nbs in ('9129') and rownum=1;   --COBUMMFO-5208
                     l_fin := 1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN  l_fin := NULL;
                  end;
               end;
            else
               if l_f = 56 THEN
                  Case
                     when k.kol between 31 and 60 then  l_fin := greatest(l_cls,  5 );
                     when k.kol between 61 and 90 then  l_fin := greatest(l_cls,  8 );
                     when k.kol >  90             then  l_fin := greatest(l_cls, 10 );
                  else                                  l_fin := l_cls;
                  end case;
                  --fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, k.rnk); -- ф_н.стан зкоригований на к-ть дн_в прострочки
               else
                  Case
                     when k.kol between  8 and 30 then  l_fin := greatest(l_cls,  2 );
                     when k.kol between 31 and 60 then  l_fin := greatest(l_cls,  3 );
                     when k.kol between 61 and 90 then  l_fin := greatest(l_cls,  4 );
                     when k.kol >  90             then  l_fin := greatest(l_cls,  5 );
                  else                                  l_fin := l_cls;
                  end case;
               end if;
            end if;
         end if;
         if l_fin = 0 THEN  l_fin:= null; end if;  -- надо фин. стан не определен
         if (l_fin is null or l_fin = 0) and k.custtype = 2 THEN
            l_txt := 'ЮО.';
            p_error_351( P_dat01, k.nd, user_id, 15, null, k.custtype, null, null, l_txt, k.rnk, NULL);
            l_fin := 10;
         ELSIF (l_fin is null or l_fin = 0) and k.custtype = 3  THEN l_fin := 5; -- фін.класс не определен  (Письмо Коваленко Светланы 23-03-2018)
            --l_fin := nvl(l_fin,f_fin23_fin351(l_fin23,k.kol));
         END IF;
         if l_fin is null or l_fin=0 THEN
            l_fin := 5; -- фін.класс не определен  (Письмо Коваленко Светланы 23-03-2018)  l_fin := nvl(l_fin23,1);
         end if;
         fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, k.rnk); -- ф_н.стан зкоригований на к-ть дн_в прострочки
         l_s080 := f_get_s080(p_dat01, l_tip, l_fin);
         p_get_nd_val(p_dat01, k.nd, k.tipa, k.kol, k.rnk, l_tip, l_fin, l_s080);
      end LOOP;
      z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней БПК 351');
   end;
end;
/
show err;

PROMPT *** Create  grants  P_KOL_ND_BPK ***
grant EXECUTE                                                                on P_KOL_ND_BPK    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KOL_ND_BPK    to RCC_DEAL;
grant EXECUTE                                                                on P_KOL_ND_BPK    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_BPK.sql =========*** End 
PROMPT ===================================================================================== 
