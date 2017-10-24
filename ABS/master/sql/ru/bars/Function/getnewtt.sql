-- Псевдо ф-ция щоб не переписувати код
CREATE OR REPLACE FUNCTION BARS.GetNewTT(p_mfo varchar2, p_tt tts.tt%type) RETURN char IS
BEGIN
  if p_tt is null then
    return null;
  end if;
   --
  return p_tt;
  -- 
END;
/