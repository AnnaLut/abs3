
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_acc_branch.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ACC_BRANCH ( p_acc accounts.acc%type )  return varchar2 is

/* Версия 1.0 29-12-2016
   Бранч по ACC
*/

   l_br accounts.BRANCH%type := null ;

begin

   begin
      select branch into l_br from accounts where acc = p_acc;
   exception when no_data_found then null;
   end;
   return l_br;
end f_acc_branch;
/
 show err;
 
PROMPT *** Create  grants  F_ACC_BRANCH ***
grant EXECUTE                                                                on F_ACC_BRANCH    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ACC_BRANCH    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_acc_branch.sql =========*** End *
 PROMPT ===================================================================================== 
 