
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_fm_replace_symbols.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_FM_REPLACE_SYMBOLS (p_string in varchar2)
return varchar2
is
p_out_string varchar2(4000);
/* v. 1.0.0 17.05.2017
Для выписок RUHA/RUHC
Проверяет строку на допустимость для отправки в ДСФМ и заменяет неподходящие символы на пробел, двойные кавычки - экранирует (" => "")
*/
begin
  select replace(regexp_replace(p_string, '[^][A-Za-zА-Яа-я0-9\\''!"#$%&()*+,./:;<=>?@^_`{|}‚„…‹‘’”›ЁҐЄ«ЇІіґё№є»ї-]', ' '), '"', '""""')
  into p_out_string
  from dual;
  return p_out_string;
end;
/
 show err;
 
PROMPT *** Create  grants  F_FM_REPLACE_SYMBOLS ***
grant EXECUTE                                                                on F_FM_REPLACE_SYMBOLS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_FM_REPLACE_SYMBOLS to FINMON;
grant EXECUTE                                                                on F_FM_REPLACE_SYMBOLS to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_fm_replace_symbols.sql =========*
 PROMPT ===================================================================================== 
 