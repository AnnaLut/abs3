
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rukey.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RUKEY (p_key varchar2)
return varchar2
is
begin
    return mgr_utl.rukey(p_key);
end rukey;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rukey.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 