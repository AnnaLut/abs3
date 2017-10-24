
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_swift_bank_code.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_SWIFT_BANK_CODE (p_ref in number) return varchar2
is
begin
    return f_get_swift_country(p_ref,  2);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_swift_bank_code.sql =========
 PROMPT ===================================================================================== 
 