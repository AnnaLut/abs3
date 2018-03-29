PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_CP_OTC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KOL_CP_OTC ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_CP_OTC (p_dat01 date,  p_mode integer) IS 

/* Версия 1.0 10-01-2018
   Кількість днів прострочки по договору на дату (цінні папери)- звітність
   -------------------------------------
*/
  l_s080    specparam.s080%type;

  L_KOL     integer; l_fIN_351 INTEGER; l_fin     INTEGER;  l_idf     integer; l_tip     INTEGER;   
  l_accexpr INTEGER; l_fin23   INTEGER;   

  l_txt     varchar2(1000);                                         

begin
   delete from kol_nd_dat where  dat = p_dat01 and tipa IN (15);
   for k in ( select 15 tipa, f_days_past_due (p_dat01,accexpr,0) kol, c.*  from cp_deal c where  c.ACCEXPR IS NOT NULL )
   LOOP
       p_set_kol_nd( p_dat01, k.ref, k.tipa, k.kol );  
   end LOOP;
end ;
/
show err;

PROMPT *** Create  grants  P_KOL_CP_OTC ***
grant EXECUTE  on P_KOL_CP_OTC  to BARS_ACCESS_DEFROLE;
grant EXECUTE  on P_KOL_CP_OTC  to RCC_DEAL;
grant EXECUTE  on P_KOL_CP_OTC  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_CP_OTC.sql =========*** End *** 
PROMPT ===================================================================================== 
