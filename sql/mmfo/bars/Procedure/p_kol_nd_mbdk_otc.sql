PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_MBDK_OTC.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** Create  procedure P_KOL_ND_MBDK_OTC ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND_MBDK_OTC (p_dat01 date, p_mode integer) IS 

/* Версия 1.0 10-01-2018
   Кількість днів прострочки по договору на дату (МБДК)- звітність
   -------------------------------------
*/

  l_s080   specparam.s080%type;
  
  KOL_     integer; l_idf    integer;  KOL_N    integer; l_fin23  integer;  OPEN_    integer; l_fin    integer; l_OPEN    integer;
  PR_      number ; FL_      NUMBER ;  l_kor    INTEGER; l_di     integer;
  DATP_    date   ;
  l_dat31  date   ;                       
           
  l_TIP    varchar2(50);  DATSP_  varchar2(30);  DASPN_  varchar2(30);  l_txt   varchar2(1000);

begin
   if p_mode = 0 THEN 
      begin
         select 1 into fl_ from rez_log 
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt ='Конец К-во дней МБДК (OTC)' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;
   delete from kol_nd_dat where  dat = p_dat01 and tipa IN (5, 6);
   select to_char ( p_DAT01, 'J' ) - 2447892 into l_di from dual;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней МБДК (OTC)');
   begin
      select 1 into l_open from nd_open  where fdat = p_dat01 and rownum=1;
   EXCEPTION WHEN NO_DATA_FOUND THEN p_nd_open(p_dat01); 
   end;
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   if trunc(p_dat01,'MM') = p_dat01   THEN l_kor := 1; 
   elsif  p_dat01 >= trunc(sysdate)   THEN l_kor := 2;
   else                                    l_kor := 0;
   end if;
   for k in (SELECT d.nd, c.custtype, c.rnk, 5 tipa
             FROM (select * from accounts where  nbs >'1500' and nbs < '1600') a, 
                  (select e.* from cc_deal e,nd_open n  
                   where n.fdat = p_dat01 and e.nd = n.nd and (e.vidd> 1500  and e.vidd<  1600 ) and e.sdate< p_dat01 and e.vidd<>1502 and  
                         (e.sos>9 and e.sos< 15 or e.wdate >= l_dat31 )) d, cc_add ad,customer c
             WHERE a.acc = ad.accs  and d.nd = ad.nd and a.rnk=c.rnk  and ad.adds = 0  and  decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, snp.FOST( a.acc,l_DI,0,7)) < 0  and 
                   d.nd=(select max(n.nd) from nd_acc n,cc_deal d1  where n.acc=a.acc and n.nd=d1.nd and (d1.vidd> 1500  and d1.vidd<  1600 ) 
                   and d1.vidd<>1502 and d1.sdate< p_dat01 and  (sos>9 and sos< 15 or d1.wdate >= l_dat31 ) )
             union all                   
             select d.nd, c.custtype, c.rnk, 6 tipa from  cc_deal d, customer c, nd_open n  
             where vidd = 150 and n.fdat = p_dat01 and d.nd = n.nd  and d.rnk = c.rnk               
            )
   LOOP
      kol_n := 0; kol_  := 0;
      begin
         select nvl(max(kol),0) into kol_ 
         from  (select a.acc, a.nls, a.kv, nvl(f_days_past_due(p_DAT01, a.acc,decode(k.custtype,3,25000,50000)),0) kol 
                from  nd_acc n, accounts a 
                where n.nd=k.nd and n.acc=a.acc 
                  and (a.nbs     in (select nbs from rez_deb  where grupa = 3 and ( d_close is null or d_close > p_DAT01 )) or a.tip in ('SP ','SPN')) --('1517','1527','1529','1509') 
                  and  a.nbs not in (select nbs from rez_deb  where grupa = 2 and ( d_close is null or d_close > p_DAT01 ))                             --('1500','1502') 
                  and decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, snp.FOST( a.acc,l_DI,0,7) ) < 0);
      EXCEPTION WHEN NO_DATA_FOUND THEN  kol_ := 0;
      END;
      p_set_kol_nd( p_dat01, k.nd, k.tipa, kol_ );
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней МБДК (OTC)');
end;
/
show err;

PROMPT *** Create  grants  P_KOL_ND_MBDK_OTC ***
grant EXECUTE  on P_KOL_ND_MBDK_OTC   to BARS_ACCESS_DEFROLE;
grant EXECUTE  on P_KOL_ND_MBDK_OTC   to RCC_DEAL;
grant EXECUTE  on P_KOL_ND_MBDK_OTC   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_MBDK_OTC.sql =========*** End
PROMPT ===================================================================================== 
