
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_zal_accs.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ZAL_ACCS (p_dat01 date, p_nd integer, p_accs integer) RETURN number is

/* Версия 2.0   25-01-2017   24-10-2016
   Сумма залога зважена на коеф. ліквід. по ACC

  1) 25-01-2017 - KL_351 через функцію f_kl_351
*/

l_sz number;

begin
   begin
   select sum(sz) into l_sz
   from (select  round(sall * f_kl_351 (t.accs, t.pawn) ,0) sz  from   tmp_rez_obesp23 t
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
 