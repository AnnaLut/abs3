
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rnk_not_uudv.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RNK_NOT_UUDV (p_rnk INTEGER) RETURN INTEGER is
/* Версия 1.0 08-02-2017
   Определение ВКР по МБДК
   -------------------------------------
*/

 l_rnk integer;

begin
   begin
      SELECT 1 into l_rnk FROM rnk_not_uudv  WHERE  rnk = p_RNK;
   EXCEPTION WHEN NO_DATA_FOUND THEN  l_rnk := 0;
   END;
   return(l_rnk);
end;
/
 show err;
 
PROMPT *** Create  grants  F_RNK_NOT_UUDV ***
grant EXECUTE                                                                on F_RNK_NOT_UUDV  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_RNK_NOT_UUDV  to RCC_DEAL;
grant EXECUTE                                                                on F_RNK_NOT_UUDV  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rnk_not_uudv.sql =========*** End
 PROMPT ===================================================================================== 
 