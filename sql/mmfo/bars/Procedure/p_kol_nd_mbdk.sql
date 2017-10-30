PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_MBDK.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** Create  procedure P_KOL_ND_MBDK ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND_MBDK (p_dat01 date, p_mode integer) IS 

/* Версия 3.1 24-01-2017  03-10-2016
   Кількість днів прострочки по договорам МБДК + коррахунки
   -------------------------------------
 3) 17-10-2017(3.1) - Счета через REZ_DEB
 2) 24-01-2017 - Добавлен параметр S080 в p_get_nd_val
 1) 03-10-2016 - В p_get_nd_val добавлен РНК
*/

  l_s080   specparam.s080%type;
  
  KOL_     integer; l_idf    integer;  KOL_N    integer; l_fin23  integer;  OPEN_    integer; l_fin    integer; 
  PR_      number ; FL_      NUMBER ;  
  DATP_    date   ;
  l_dat31  date   ;                       
           
  l_TIP    varchar2(50);  DATSP_  varchar2(30);  DASPN_  varchar2(30);  l_txt   varchar2(1000);

begin
   if p_mode = 0 THEN 
      begin
         select 1 into fl_ from rez_log 
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt ='Конец К-во дней МБДК 351 ' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;

   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней МБДК 351 ');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   for k in (SELECT d.nd, d.wdate, d.fin_351, d.fin23, c.custtype, c.rnk, 5 tipa
             FROM (select * from accounts where  nbs >'1500' and nbs < '1600') a, 
                  (select e.* from cc_deal e,nd_open n  
                   where n.fdat = p_dat01 and e.nd = n.nd and (e.vidd> 1500  and e.vidd<  1600 ) and e.sdate< p_dat01 and e.vidd<>1502 and  
                         (e.sos>9 and e.sos< 15 or e.wdate >= l_dat31 )) d, cc_add ad,customer c
             WHERE a.acc = ad.accs  and d.nd = ad.nd and a.rnk=c.rnk  and ad.adds = 0  and  ost_korr(a.acc,l_dat31,null,a.nbs)<0  and 
                   d.nd=(select max(n.nd) from nd_acc n,cc_deal d1  where n.acc=a.acc and n.nd=d1.nd and (d1.vidd> 1500  and d1.vidd<  1600 ) 
                   and d1.vidd<>1502 and d1.sdate< p_dat01 and  (sos>9 and sos< 15 or d1.wdate >= l_dat31 ) )
             union all                   
             select d.nd, d.wdate, d.fin_351, d.fin23, c.custtype, c.rnk, 6 tipa from  cc_deal d, customer c, nd_open n  
             where vidd = 150 and n.fdat = p_dat01 and d.nd = n.nd  and d.rnk = c.rnk               
            )
   LOOP
      kol_n := 0; kol_  := 0;
/*
      if (k.wdate <= p_DAT01) and  then 
         KOL_  := p_DAT01-k.wdate;  
         KOL_n := greatest(kol_n,kol_);
         GOTO M1; 
      end if;  
*/
      begin
         select nvl(max(kol),0) into kol_ 
         from  (select a.acc, a.nls, a.kv, nvl(f_days_past_due(p_DAT01, a.acc,decode(k.custtype,3,25000,50000)),0) kol 
                from  nd_acc n, accounts a 
                where n.nd=k.nd and n.acc=a.acc 
                  and (a.nbs     in (select nbs from rez_deb  where grupa = 3 and ( d_close is null or d_close > p_DAT01 )) or a.tip in ('SP ','SPN')) --('1517','1527','1529','1509') 
                  and  a.nbs not in (select nbs from rez_deb  where grupa = 2 and ( d_close is null or d_close > p_DAT01 ))                             --('1500','1502') 
                  and ost_korr(a.acc,l_dat31,null,a.nbs) <0);
      EXCEPTION WHEN NO_DATA_FOUND THEN  kol_ := 0;
      END;
      --if    s.RZ =2 THEN l_idf := 81;
      --else               l_idf := 80;   
      --end if;
      << m1 >> NULL;
      l_idf   := 80;   
      l_fin23 := k.fin23;
      l_fin   := k.fin_351;
      if l_fin is null THEN
         l_fin   := fin_nbu.zn_p_nd('CLS', l_idf, p_dat01, k.nd, k.rnk);
         if l_fin is null or l_fin = 0 THEN 
            --begin
            --   select error_txt into l_txt from SREZERV_ERROR_TYPES where error_type=15; -- Нет фин.стана
            --EXCEPTION  WHEN NO_DATA_FOUND  THEN l_txt := null;
            --end; 
            --p_error_351( P_dat01, k.nd, user_id, 15, null, k.custtype, null, null, l_txt, k.rnk, NULL); 
            l_fin := l_fin23;
         end if;
         --l_fin := nvl(l_fin,f_fin23_fin351(l_fin23,l_kol));
      end if; 
      KOL_n := greatest(kol_n,kol_);
      l_s080 := f_get_s080(p_dat01, 1, l_fin);
      p_get_nd_val(p_dat01, k.nd, k.tipa, kol_n, k.rnk, 1, l_fin, l_s080);
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней МБДК 351 ');
end;
/
show err;

PROMPT *** Create  grants  P_KOL_ND_MBDK ***
grant EXECUTE                                                                on P_KOL_ND_MBDK   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KOL_ND_MBDK   to RCC_DEAL;
grant EXECUTE                                                                on P_KOL_ND_MBDK   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_MBDK.sql =========*** End
PROMPT ===================================================================================== 
