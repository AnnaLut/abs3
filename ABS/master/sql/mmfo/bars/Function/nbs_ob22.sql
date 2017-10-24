
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22 
(nbs_  accounts.nbs%type,
 ob22_ accounts.ob22%type)

  return accounts.nls%type is

 nls_    accounts.nls%type := null ;
 branch_ branch.branch%type;

/*
   24-01-2011 Sta перевод ОБ22 в accounts
   вызов nbs_ob22_null() +
   єксепшен, если счет не найден
*/

begin
    branch_ := sys_context('bars_context','user_branch');
    if length(branch_) = 8 then
        branch_:= branch_||'000000/';
    end if;
    nls_ := nbs_ob22_null(nbs_, ob22_, branch_);
    -------------------
    if nls_ is null then
        raise_application_error(
            -20203,
            '\9356 - Не найден счет Бал='|| NBS_||' OB22='||OB22_||' для уровня = ' || BRANCH_,
            TRUE);
    end if;
    return nls_;
end nbs_ob22;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22 ***
grant EXECUTE                                                                on NBS_OB22        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_OB22        to START1;
grant EXECUTE                                                                on NBS_OB22        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22.sql =========*** End *** =
 PROMPT ===================================================================================== 
 