
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getnewtt.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETNEWTT (p_mfo varchar2, p_tt tts.tt%type) RETURN char IS
BEGIN
  if p_tt is null then
    return null;
  end if;
   --
  return p_tt;
  --
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getnewtt.sql =========*** End *** =
 PROMPT ===================================================================================== 
 