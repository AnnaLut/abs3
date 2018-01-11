
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/encode_base.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ENCODE_BASE (par varchar2) return varchar2 is
begin
      return utl_encode.text_encode(par, encoding => utl_encode.base64);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/encode_base.sql =========*** End **
 PROMPT ===================================================================================== 
 