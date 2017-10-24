
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_acc_zal.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ACC_ZAL ( p_dat01 date, p_acc accounts.acc%type )  return varchar2 is

/* Версия 1.0 03-01-2017
   Залог по ACC
*/

l_zal  number;

begin
   begin
      SELECT SUM(t.S) into l_zal FROM  TMP_REZ_OBESP23 t WHERE dat = p_dat01 and t.accs = p_acc and t.s >0 ;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_Zal :=0;
   end;
   return(l_zal);
end;
/
 show err;
 
PROMPT *** Create  grants  F_ACC_ZAL ***
grant EXECUTE                                                                on F_ACC_ZAL       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ACC_ZAL       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_acc_zal.sql =========*** End *** 
 PROMPT ===================================================================================== 
 