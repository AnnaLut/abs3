
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/calc_md5.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CALC_MD5 (p_buffer in varchar2) return varchar2 is
begin
  return
    dbms_obfuscation_toolkit.MD5(
      input => utl_raw.cast_to_raw(c => p_buffer)
    );
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/calc_md5.sql =========*** End *** =
 PROMPT ===================================================================================== 
 