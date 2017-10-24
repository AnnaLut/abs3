
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_rav.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_RAV 
 (nbs_   accounts.nbs%type,  ob22_ accounts.ob22%type, kv_ accounts.kv%type )
  return accounts.nls%type is
  ---------------------------
  NLS_    accounts.NLS%type := null ;
  branch_ accounts.tobo%type:= NVL(sys_context('bars_context','user_branch'),'0');

begin
  
  begin
    select a.nls into NLS_ from accounts a
    where a.ob22  =OB22_   and a.nbs = NBS_  and a.kv = kv_ and a.dazs is null
      and a.tobo=Branch_ and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;

  return NLS_;

end nbs_ob22_RAV;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_rav.sql =========*** End *
 PROMPT ===================================================================================== 
 