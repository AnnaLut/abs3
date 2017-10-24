
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/safe_to_number.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SAFE_TO_NUMBER (p varchar2) return number is
    v number;
  begin
    v := to_number(p);
    return v;
  exception when others then return 999;
end;
/
 show err;
 
PROMPT *** Create  grants  SAFE_TO_NUMBER ***
grant EXECUTE                                                                on SAFE_TO_NUMBER  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/safe_to_number.sql =========*** End
 PROMPT ===================================================================================== 
 