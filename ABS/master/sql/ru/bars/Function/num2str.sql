
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/num2str.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NUM2STR (
  p_number in number,
  p_delim in varchar2 := '.'
) return varchar2
is
  l_res varchar2(128);
begin
  return
    replace(
      replace(
        to_char (p_number, 'fm999999999999990.00999999'),
      ',', p_delim),
    '.', p_delim);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/num2str.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 