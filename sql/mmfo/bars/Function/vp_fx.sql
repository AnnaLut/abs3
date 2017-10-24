
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vp_fx.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VP_FX ( kv_ accounts.kv%type )   return accounts.nls%type  result_cache  is
 nls_ varchar2(15); ob22_ char(2);
  begin  if kv_ in ( 959, 961) then ob22_ := '09'; else ob22_ := '25'; end if ;
     nls_  :=   Nbs_ob22_null  ( '3800', ob22_) ;  
   RETURN nls_ ;
end  VP_FX ;
/
 show err;
 
PROMPT *** Create  grants  VP_FX ***
grant EXECUTE                                                                on VP_FX           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VP_FX           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vp_fx.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 