PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_OVER_OTC.sql =========*** Run
PROMPT ===================================================================================== 
PROMPT *** Create  procedure P_KOL_ND_OVER_OTC ***

CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND_OVER_OTC (p_dat01 date, p_mode integer) IS

/* Версия 1.0 10-01-2018
   Кількість днів прострочки по договору на дату (овердрафти)- звітність
   -------------------------------------
*/

 l_s080 specparam.s080%type;

 l_kol   integer; l_custtype  integer;  l_fin      integer; l_f    integer; l_fin23     integer;
 l_tip   integer; fl_         integer;  l_cls      integer; l_kor  integer; 
 l_dat31 date   ; l_txt  varchar2(1000);

 TYPE CurTyp IS REF CURSOR;
 c0   CurTyp;
 c1   CurTyp;

begin
   if p_mode = 0 THEN
      begin
         select 1 into fl_ from rez_log
         where fdat = p_dat01  and  txt ='Конец К-во дней ОВЕРДРАФТЫ (OTC)' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней ОВЕРДРАФТЫ (OTC)');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   delete from kol_nd_dat where  dat = p_dat01 and tipa IN (10);
   if trunc(p_dat01,'MM') = p_dat01   THEN l_kor := 1; 
   elsif  p_dat01 >= trunc(sysdate)   THEN l_kor := 2;
   else                                    l_kor := 0;
   end if;
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
               from  (select decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) ost, acc, custtype
                      from accounts a, customer c
                      where a.acc in (select acco from acc_over where nd=k.nd) 
                        AND ( NBS IN (select nbs from rez_deb  where grupa = 4 and ( d_close is null or d_close > p_dat01)) or a.tip in ('SP ','SPN') ) and a.rnk=c.rnk   --2067, 2069
                      union all
                      select decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) ost, acc, custtype from accounts a  , customer c
                      where ( NBS IN (select nbs from rez_deb  where grupa = 4 and ( d_close is null or d_close > p_dat01 )) or a.tip in ('SP ','SPN') ) and a.rnk=c.rnk  --2067, 2069
                        AND acc in (select acra from int_accn
                                    where id=0 and acc in (select acco from acc_over  where nd=k.nd)) and nbs not like '8%')
               where ost<0;
            end if;
            p_set_kol_nd( p_dat01, k.nd, 10, l_kol );  
         end;
      end LOOP;
   end; 
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней ОВЕРДРАФТЫ (OTC)');
end;
/
show err;

PROMPT *** Create  grants  P_KOL_ND_OVER_OTC ***
grant EXECUTE  on P_KOL_ND_OVER_OTC   to BARS_ACCESS_DEFROLE;
grant EXECUTE  on P_KOL_ND_OVER_OTC   to RCC_DEAL;
grant EXECUTE  on P_KOL_ND_OVER_OTC   to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND_OVER.sql =========*** End
PROMPT ===================================================================================== 
