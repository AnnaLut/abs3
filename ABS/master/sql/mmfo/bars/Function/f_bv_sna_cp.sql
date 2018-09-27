
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_bv_sna_cp.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BV_SNA_CP (p_dat01 date, p_nd integer, p_acc integer) RETURN number is

/* Версия 2.1   10-04-2018  22-02-2017  13-02-2017
   Залог по ACC

10-04-2018(2.1) - убрала l_accunrec - счет SNA	
22-02-2017 - Убрала  cp_accp_ счет премии ,
13-02-2017 - Добавила рахунок l_accexpn
*/

cp_acc_   number ; cp_accp_   number; cp_accd_   number; cp_accs_  number ; cp_accr_   number; cp_accr2_  number;
l_accexpr number ; l_accunrec number; l_accr3    number; l_accexpn number ;

L_dat31  date;

begin
   l_dat31 := Dat_last_work (p_dat01 -1 );  -- последний рабочий день месяца

   select  acc ,    accp ,    accd ,    accs ,    accr ,    accr2 ,   accr3,   accexpr,   accunrec,   accexpn
   into cp_acc_, cp_accp_, cp_accd_, cp_accs_, cp_accr_, cp_accr2_, l_accr3, l_accexpr, l_accunrec, l_accexpn
   from cp_deal where ref = p_nd;

   begin      
      select  cp_acc into cp_accp_  from cp_accounts c  where  CP_ACCTYPE in ('S2') and cp_ref = p_nd;
   EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
   end;  

   for k in ( select nls, acc,  ba, ss,  nvl(SD,0), greatest(BA - sd,0) bv
              from (select acc, nls, ba, ss, round( ss * BA/ sum(BA) over (partition by 1),2) sd
                    from ( select acc, nls, -ost_korr (acc,l_dat31,null,nbs) BA,
                                 (select  nvl(sum(ost_korr (acc,l_dat31,null,nbs)),0) from  accounts
                                  where acc in (select cp_acc from cp_accounts c where c.cp_ref = p_nd and c.cp_acctype in ('N','EXPN','EXPR','P','R','RD','R2','R3','S','S2') )
                                    and f_get_tip (substr(nls,1,4), tip) <> 'SPI' and nls not like '8%' and  ost_korr (acc,l_dat31,null,nbs)>0) ss
                           from  accounts where acc in (select cp_acc from cp_accounts c where c.cp_ref = p_nd and c.cp_acctype in ('N','EXPN','EXPR','P','R','RD','R2','R3','S','S2','UNREC')) 
                                            and f_get_tip (substr(nls,1,4), tip) <> 'SPI'  and  nls not like '8%' and ost_korr (acc,l_dat31,null,nbs)<0
                         )
                   )
             )
   LOOP
      if k.acc = p_acc THEN return (k.bv); end if;
   end LOOP;
   return (0);
end;
/
 show err;
 
PROMPT *** Create  grants  F_BV_SNA_CP ***
grant EXECUTE                                                                on F_BV_SNA_CP     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BV_SNA_CP     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_bv_sna_cp.sql =========*** End **
 PROMPT ===================================================================================== 
 