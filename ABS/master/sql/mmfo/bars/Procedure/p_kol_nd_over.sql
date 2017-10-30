PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_OVER.sql =========*** Run
PROMPT ===================================================================================== 
PROMPT *** Create  procedure P_KOL_ND_OVER ***

CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND_OVER (p_dat01 date, p_mode integer) IS

/* Версия 4.1  17-10-2017 22-06-2017  24-01-2017 18-01-2017  10-10-2016
   Кількість днів прострочки по договорам ОВЕРДРАФТА
   -------------------------------------
  4) 17-10-2017(4.1) - Овердрафт холдинга + бал.счета через REZ_DEB
  3) 22-06-2017 - NVL при определении фин.класа
  2) 24-01-2017 - Добавлен параметр S080 в p_get_nd_val
  1) 18-01-2017 - Уточнение фин.стана
*/

 l_s080 specparam.s080%type;

 l_kol   integer; l_custtype  integer;  l_fin      integer; l_f    integer; l_fin23     integer;
 l_tip   integer; fl_    integer; l_cls       integer;  
 l_dat31 date   ; l_txt  varchar2(1000);

 TYPE CurTyp IS REF CURSOR;
 c0   CurTyp;
 c1   CurTyp;

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

   DECLARE
      TYPE r0Typ IS RECORD
         ( nd        acc_over.nd%type,
           rnk       accounts.rnk%type,
           fin23     acc_over.fin23%type
          );
   k r0Typ;
   begin
      if F_MMFO THEN
         OPEN c0 FOR
         SELECT c.nd, c.rnk, c.fin23  FROM  cc_deal c, nd_open n  where vidd = 110 and c.nd = n.nd and n.fdat = p_dat01;
      else 
         OPEN c0 FOR
         select o.nd, a.rnk, o.fin23  from acc_over o, nd_open n, accounts a where n.fdat = p_dat01 and o.nd = n.nd and o.acco = a.acc; 
      end if;
      LOOP
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;
         l_kol  := 0;
         select c.custtype into l_custtype from  customer c where c.rnk = k.rnk;
         --DECLARE
         --   TYPE r1Typ IS RECORD
         --   ( kol       number );
         --s r1Typ;
         begin
            if F_MMFO THEN
            --OPEN c1 FOR
               SELECT max(nvl(f_days_past_due(p_DAT01, a.acc,decode(c.custtype,3,25000,50000)),0)) into l_kol  FROM  nd_acc d, accounts a, customer c  
               where d.nd = k.nd and d.acc = a.acc and a.rnk=c.rnk  and a.tip in ('SP ','SPN');
            else 
            --OPEN c1 FOR
               select max(nvl(f_days_past_due(p_DAT01, acc,decode(custtype,3,25000,50000)),0)) into l_kol
               from  (select ost_korr(a.acc,l_dat31,null,a.nbs) ost, acc, custtype
                      from accounts a, customer c
                      where a.acc in (select acco from acc_over where nd=k.nd) 
                        AND ( NBS IN (select nbs from rez_deb  where grupa = 4 and ( d_close is null or d_close > p_dat01)) or a.tip in ('SP ','SPN') ) and a.rnk=c.rnk   --2067, 2069
                      union all
                      select ost_korr(acc,l_dat31,null,nbs) ost, acc, custtype from accounts a  , customer c
                      where ( NBS IN (select nbs from rez_deb  where grupa = 4 and ( d_close is null or d_close > p_dat01 )) or a.tip in ('SP ','SPN') ) and a.rnk=c.rnk  --2067, 2069
                        AND acc in (select acra from int_accn
                                    where id=0 and acc in (select acco from acc_over  where nd=k.nd)) and nbs not like '8%')
               where ost<0;
            end if;
            --LOOP
               --FETCH c1 INTO s;
               --EXIT WHEN c0%NOTFOUND;
            logger.info('OVER  1 : nd = ' || k.nd || ' k.rnk = '|| k.rnk || ' l_kol = '|| l_kol  ) ;
            if l_custtype=2 THEN l_tip := 2; l_f := 56;
            else                 l_tip := 1; l_f := 60;
            end if;
            l_fin23 := k.fin23;
            --l_kol := greatest(l_kol,s.kol);
            logger.info('OVER  2 : nd = ' || k.nd || ' k.rnk = '|| k.rnk || ' l_f = '|| l_f  ) ;
            if l_f = 56 THEN
               l_cls := fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, k.rnk);
               logger.info('OVER  3 : nd = ' || k.nd || ' k.rnk = '|| k.rnk || ' l_cls = '|| l_cls  ) ;
               Case
                  when l_kol between 31 and 60 then  l_fin := greatest(l_cls,  5 );
                  when l_kol between 61 and 90 then  l_fin := greatest(l_cls,  8 );
                  when l_kol >  90             then  l_fin := greatest(l_cls, 10 );
               else                                  l_fin := l_cls;
               end case;
               --fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, l_rnk); -- фін.стан зкоригований на к-ть днів прострочки
               --l_fin := fin_nbu.zn_p_nd('CLSP',  l_f, p_dat01, k.nd, k.rnk);
            else
               l_fin := fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, k.rnk);
            end if;
               logger.info('OVER  4 : nd = ' || k.nd || ' k.rnk = '|| k.rnk || ' l_fin = '|| l_fin  ) ;
            if l_fin is null or l_fin = 0 and l_custtype = 2 THEN
               l_txt := 'ОВЕР.';
               p_error_351( P_dat01, k.nd, user_id,15, k.nd, l_custtype,  null, NULL, l_txt, k.rnk, NULL);
               l_fin := l_fin23;
            elsif l_custtype = 3 THEN
               l_fin := nvl(l_fin,f_fin23_fin351(l_fin23,l_kol));
            end if;
            logger.info('OVER  5 : nd = ' || k.nd || ' k.rnk = '|| k.rnk || ' l_fin = '|| l_fin  ) ;
            if l_fin is null or l_fin=0 THEN  l_fin := nvl(l_fin23,1);  end if;
            logger.info('OVER  6 : nd = ' || k.nd || ' k.rnk = '|| k.rnk || ' l_fin = '|| l_fin  ) ;
            fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, k.rnk); -- фін.стан зкоригований на к-ть днів прострочки
            l_s080 := f_get_s080(p_dat01, l_tip, l_fin);
            p_get_nd_val( p_dat01, k.nd, 10, l_kol, k.rnk, l_tip, l_fin, l_s080 );
            --END LOOP;
         end;
      end LOOP;
   end; 
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
