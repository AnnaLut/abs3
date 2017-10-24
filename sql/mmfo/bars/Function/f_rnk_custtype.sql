
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rnk_custtype.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RNK_CUSTTYPE ( p_rnk customer.custtype%type )  return number is

/* Версия 1.0 03-01-2017
   Тип клиента по РНК
*/

l_cust number;

begin
   begin
      select custtype into l_cust from customer  where rnk = p_rnk;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_cust := null;
   end;
   return l_cust;
end;
/
 show err;
 
PROMPT *** Create  grants  F_RNK_CUSTTYPE ***
grant EXECUTE                                                                on F_RNK_CUSTTYPE  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_RNK_CUSTTYPE  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rnk_custtype.sql =========*** End
 PROMPT ===================================================================================== 
 