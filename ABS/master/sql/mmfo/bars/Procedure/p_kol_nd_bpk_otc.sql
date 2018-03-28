PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_BPK_OTC.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** Create  procedure P_KOL_ND_BPK_OTC ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND_BPK_OTC (p_dat01 date, p_mode integer) IS 

/* Версия 1.0 10-01-2018
   Кількість днів прострочки по договору на дату (БПК)- звітність
   -------------------------------------
*/


 l_rnk   accounts.rnk%type; l_custtype customer.custtype%type; l_s080  specparam.s080%type; l_s250 w4_acc.s250%type; 

 KOL_    integer; l_fin    integer; l_f    integer; OPEN_    integer; l_TIP    integer; l_vidd  integer; 
 l_fin23 integer; l_grp    integer; l_cls  integer; l_nd     integer; l_kor    INTEGER; l_di    integer;
 PR_     number ; FL_      NUMBER ;  

 DATSP_  varchar2(30); DASPN_   varchar2(30); l_txt  varchar2(1000); 
 DATP_   date        ; l_dat31  date  ;

 --TYPE CurTyp IS REF CURSOR;
 --c0   CurTyp;
  
begin

   if p_mode = 0 THEN 
      begin
         select 1 into fl_ from rez_log 
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt ='Конец К-во дней БПК (OTC)' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;
   delete from kol_nd_dat where  dat = p_dat01 and tipa IN (41, 42);
   select to_char ( p_DAT01, 'J' ) - 2447892 into l_di from dual;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней БПК 351 (OTC)');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   if trunc(p_dat01,'MM') = p_dat01   THEN l_kor := 1; 
   elsif  p_dat01 >= trunc(sysdate)   THEN l_kor := 2;
   else                                    l_kor := 0;
   end if;
   begin
      FOR k in (select nd, rnk, max(kol) kol, tipa 
                from (select b.*,a.rnk, f_days_past_due(p_DAT01, a.acc, decode(c.custtype,3,25000,50000)) kol
                      from (select  42 tipa, nd, acc_pk ACC from w4_acc where not_use_rez23 is null union all                 
                            select  42 tipa, nd, acc_2209   from w4_acc where acc_2209 is not null and not_use_rez23 is null union all 
                            select  42 tipa, nd, acc_2207   from w4_acc where acc_2207 is not null and not_use_rez23 is null union all
                            select  42 tipa, nd, acc_2627   from w4_acc where acc_2627 is not null and not_use_rez23 is null union all
                            select  41 tipa, nd, acc_pk     from bpk_acc where dat_end is null union all                 
                            select  41 tipa, nd, acc_2209   from bpk_acc where acc_2209 is not null and dat_end is null union all 
                            select  41 tipa, nd, acc_2207   from bpk_acc where acc_2207 is not null and dat_end is null) b,accounts a, customer c
                where b.acc = a.acc and decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, snp.FOST( a.acc,l_DI,0,7) ) < 0 and a.NBS not in ('3550','3551') and a.rnk = c.rnk )
                group by nd, rnk, tipa )
      loop
       p_set_kol_nd( p_dat01, k.nd, k.tipa, k.kol );  
      end LOOP;
      z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней БПК (OTC)');
   end;
end;
/
show err;

PROMPT *** Create  grants  P_KOL_ND_BPK_OTC ***
grant EXECUTE                                                                on P_KOL_ND_BPK_OTC    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KOL_ND_BPK_OTC    to RCC_DEAL;
grant EXECUTE                                                                on P_KOL_ND_BPK_OTC    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_BPK_OTC.sql =========*** End 
PROMPT ===================================================================================== 
