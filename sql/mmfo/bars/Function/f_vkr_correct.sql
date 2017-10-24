
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_vkr_correct.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_VKR_CORRECT (p_vkr varchar2) RETURN integer is
/* Версия 1.0 12-10-2016
   Проверка ВКР
   -------------------------------------
*/

 l_corr integer;

begin
   begin
      SELECT 1 into l_corr FROM CCK_RATING WHERE  code = p_VKR;
   EXCEPTION WHEN NO_DATA_FOUND THEN  l_corr := 0;
   END;
   return(l_corr);
end;
/
 show err;
 
PROMPT *** Create  grants  F_VKR_CORRECT ***
grant EXECUTE                                                                on F_VKR_CORRECT   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_VKR_CORRECT   to RCC_DEAL;
grant EXECUTE                                                                on F_VKR_CORRECT   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_vkr_correct.sql =========*** End 
 PROMPT ===================================================================================== 
 