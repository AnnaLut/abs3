
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_rnk_okpo.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RNK_OKPO ( p_rnk accounts.rnk%type )  return varchar2 is

/* Версия 1.0 29-12-2016
   Бранч по ACC
*/

   l_OKPO customer.OKPO%type := null ;

begin

   begin
      select OKPO into l_OKPO from customer where rnk = p_rnk;
   exception when no_data_found then null;
   end;
   return l_OKPO;
end;
/
 show err;
 
PROMPT *** Create  grants  F_RNK_OKPO ***
grant EXECUTE                                                                on F_RNK_OKPO      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_RNK_OKPO      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_rnk_okpo.sql =========*** End ***
 PROMPT ===================================================================================== 
 