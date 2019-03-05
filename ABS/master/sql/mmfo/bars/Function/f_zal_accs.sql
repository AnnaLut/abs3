
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_zal_accs.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ZAL_ACCS (p_dat01 date, p_nd number, p_accs number, p_rnk number default 0, p_kol_fin_max number default 0) RETURN number is

/* Версия 2.1   21-02-2019  25-01-2017   24-10-2016
   Сумма залога зважена на коеф. ліквід. по ACC та коеф. прийняття
  2) 21-02-2019(2.1) - Добавлен коеф. прийняття забезпечення (F_K_ZAL)
  1) 25-01-2017(2.0) - KL_351 через функцію f_kl_351
*/

l_sz number;

begin
   begin
   select sum(sz) into l_sz
   from (select  round(sall * f_kl_351 (t.accs, t.pawn) * F_K_ZAL (p_rnk, p_nd, F_PAWN_KOD351 ( t.pawn ), p_kol_fin_max) ,0) sz  from   tmp_rez_obesp23 t
         where  dat = p_dat01 and t.sall<>0 and t.nd = p_nd and t.accs = p_accs);
   EXCEPTION WHEN NO_DATA_FOUND THEN l_SZ := 0;
   END;

   return l_sz;

end;
/
 show err;
 
PROMPT *** Create  grants  F_ZAL_ACCS ***
grant EXECUTE                                                                on F_ZAL_ACCS      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ZAL_ACCS      to RCC_DEAL;
grant EXECUTE                                                                on F_ZAL_ACCS      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_zal_accs.sql =========*** End ***
 PROMPT ===================================================================================== 
 