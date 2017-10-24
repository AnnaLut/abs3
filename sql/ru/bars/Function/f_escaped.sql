
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_escaped.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ESCAPED (p_values varchar2, p_separator varchar2) return varchar2
as
l_value varchar2(4000);
begin
	-- удаляем неподходящие символы + заменяем кавычки на одинарные (?)
	select replace(regexp_replace(p_values, '[^][A-Za-zА-Яа-я0-9\\''!"#$%&()*+,./:;<=>?@^_`{|}‚„…‹‘’”›ЁҐЄ«ЇІіґё№є»ї-]', ' '), '"', '''''')
	into l_value
	from dual;

    --Values containing the separator, a double quote, or a new line must be quoted.
    if    instr(l_value, p_separator) > 0
       or instr(l_value, '''''') > 0
       or instr(l_value, ',') > 0
       or instr(l_value, chr(10)) > 0 then
      l_value := '"' || l_value || '"';
    end if;

  return  l_value;

end;
/
 show err;
 PROMPT *** Create  grants  F_ESCAPED ***
grant EXECUTE                                                                on F_ESCAPED       to BARS_ACCESS_DEFROLE;grant EXECUTE                                                                on F_ESCAPED       to START1; 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_escaped.sql =========*** End *** 
 PROMPT ===================================================================================== 
 