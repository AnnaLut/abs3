
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ruuser.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RUUSER (p_user varchar2)
return varchar2
is
begin
    return mgr_utl.ruuser(p_user);
end ruuser;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ruuser.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 