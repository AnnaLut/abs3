
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_clear_str.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CLEAR_STR (p_str in varchar2) return varchar2 is
  l_str  varchar2(4000);
begin
  l_str := p_str;
  -- убираем непечатные символы
  if l_str is not null then
      for i in 1..length(l_str) loop
        if ascii(substr(l_str, i,1))<32 then
            l_str := substr(l_str,1,i-1)||'_'||substr(l_str,i+1);
        end if;
      end loop;
  end if;
  return l_str;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_clear_str.sql =========*** End **
 PROMPT ===================================================================================== 
 