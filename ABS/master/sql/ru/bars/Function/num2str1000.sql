
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/num2str1000.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NUM2STR1000 (
  p_number in number,
  p_delim in varchar2 := '.',
  p_delim1000 in varchar2 :=' '
) return varchar2
is
  l_res varchar2(128);
begin
  return
    replace(
      replace(
        to_char (p_number, 'fm999,999,999,999,990.00999999'),
      ',', p_delim1000),
    '.', p_delim);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/num2str1000.sql =========*** End **
 PROMPT ===================================================================================== 
 