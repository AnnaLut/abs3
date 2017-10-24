
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/translate_vob.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TRANSLATE_VOB (p_vob in number) return number is
begin
  bars_audit.trace('bars.translate_vob');
  return 33;
end;
/
 show err;
 
PROMPT *** Create  grants  TRANSLATE_VOB ***
grant EXECUTE                                                                on TRANSLATE_VOB   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/translate_vob.sql =========*** End 
 PROMPT ===================================================================================== 
 