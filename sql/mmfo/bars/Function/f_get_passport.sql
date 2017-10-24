
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_passport.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_PASSPORT (p_nazn in varchar2) return varchar2 is
  l_pos   integer;
  l_end   integer;
begin
  l_pos := instr(p_nazn,';');
  l_pos := instr(p_nazn,';',l_pos+1);
  l_pos := instr(p_nazn,';',l_pos+1);
  l_end := instr(p_nazn,';',l_pos+1);
  return substr(p_nazn,l_pos+1,l_end-l_pos-1);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_passport.sql =========*** End
 PROMPT ===================================================================================== 
 