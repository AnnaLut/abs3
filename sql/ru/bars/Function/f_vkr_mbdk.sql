
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_vkr_mbdk.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_VKR_MBDK (p_rnk INTEGER) RETURN VARCHAR2 is
/* Версия 1.0 08-02-2017
   Определение ВКР по МБДК
   -------------------------------------
*/

 l_vkr VARCHAR2(3);

begin
   begin
      SELECT value into l_vkr FROM customerw WHERE  tag='VNCRR' and rnk = p_RNK;
   EXCEPTION WHEN NO_DATA_FOUND THEN  l_vkr := NULL;
   END;
   return(l_vkr);
end;
/
 show err;
 
PROMPT *** Create  grants  F_VKR_MBDK ***
grant EXECUTE                                                                on F_VKR_MBDK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_VKR_MBDK      to RCC_DEAL;
grant EXECUTE                                                                on F_VKR_MBDK      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_vkr_mbdk.sql =========*** End ***
 PROMPT ===================================================================================== 
 