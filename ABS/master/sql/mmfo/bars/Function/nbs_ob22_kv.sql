
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_ob22_kv.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_OB22_KV 
 (nbs_     accounts.nbs%type,
  ob22_ accounts.ob22%type,
  kv_ accounts.KV%type
  )
  return accounts.nls%type   is

  l_ob22  accounts.ob22%type := ob22_ ;
  l_nls   accounts.nls%type  ;
begin
 If KV_ in (959,961,962) and ob22_ = '10' then l_ob22 := '09' ; end if ;
 ------------------------------------------------------------------------
  l_nls := nbs_ob22 (nbs_, l_ob22);
  RETURN l_nls  ;
end nbs_ob22_KV ;
/
 show err;
 
PROMPT *** Create  grants  NBS_OB22_KV ***
grant EXECUTE                                                                on NBS_OB22_KV     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_OB22_KV     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_ob22_kv.sql =========*** End **
 PROMPT ===================================================================================== 
 