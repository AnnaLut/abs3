
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_vp.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_VP 
(nbs_  accounts.nbs%type,        --3800
 ob22_ accounts.ob22%type,       --OB22
 kv_ accounts.kv%type)           --KV

  return accounts.nls%type is    --3801

 nls_     accounts.nls%type := null ;
 branch_  branch.branch%type;
 acc3800_ accounts.acc%type;
 nls3801_ accounts.nls%type;

/*
Поиск счета 3801 по VP_LIST
для конкретного счета 3800/ОБ22
для бранча пользователя
*/

begin
  --Поиск 3800 по об22
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
  end;
   -- Поиск асс 3800 по указаной валюте
  Begin
   select acc into acc3800_ from accounts
   where nls=nls_ and kv=kv_;
    if acc3800_ is null then
        raise_application_error(
            -20203,
            '\9356 - Не найден счет '|| NLS_||' KV = ' || kv_,
            TRUE);
    end if;
  end;
  begin
   select nls into nls3801_ from accounts
   where acc = (select acc3801 from vp_list where acc3800=acc3800_);
   if nls3801_ is null then
        raise_application_error(
            -20203,
            '\9356 - Не найден счет 3801',
            TRUE);
   end if;
  end;

    return nls3801_;
end nbs_vp;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_vp.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 