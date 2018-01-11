
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/mbdk_tip.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MBDK_TIP (p_vidd varchar2) RETURN number is

/* Версия 1.0 25-04-2017
   Определение типа МБДК
*/
 l_tip number;

begin
   begin
      select tipp into l_tip from V_MBDK_PRODUCT where vidd = p_vidd;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_tip := 0;
   END;
   return l_tip;
end;
/
 show err;
 
PROMPT *** Create  grants  MBDK_TIP ***
grant EXECUTE                                                                on MBDK_TIP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MBDK_TIP        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/mbdk_tip.sql =========*** End *** =
 PROMPT ===================================================================================== 
 