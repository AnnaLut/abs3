
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/scn2ts.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SCN2TS (p_scn in number)
return timestamp
is
begin
    return scn_to_timestamp(p_scn);
exception when others then
    return null;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/scn2ts.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 