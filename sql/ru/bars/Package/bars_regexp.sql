
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_regexp.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_REGEXP as
/*
  BARS_REGEXP - пакет для работы с Регулярными Выражениями
                в Oracle 9.2 использует Java класс bars.regexp.REX ($/BARS/SQL/ETALON/JAVA/rex.sql)
                в Oracle 10g использует встроенные регулярные выражения(по макросу ORA10)

  Created :     27.02.2006 SERG

*/

g_header_version  constant varchar2(64)  := 'version 1.2 06/01/2008';

g_awk_header_defs constant varchar2(512) := ''

;

--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

/**
 * match - проверяет строку p_string на соответствие шаблону p_pattern
 * @return 1 - строка соответствует шаблону, 0 - нет
 */
function match(p_pattern in varchar2,p_string in varchar2) return number;

end bars_regexp;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_REGEXP as
/*
  BARS_REGEXP - пакет для работы с Регулярными Выражениями
                в Oracle 9.2 использует Java класс bars.regexp.REX ($/BARS/SQL/ETALON/JAVA/rex.sql)
                в Oracle 10g использует встроенные регулярные выражения(по макросу ORA10)

  Created :     27.02.2006 SERG

*/

g_body_version  constant varchar2(64)  := 'version 1.2 06/01/2008';

g_awk_body_defs constant varchar2(512) := ''

;


--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2 is
begin
  return 'Package header BARS_REGEXP '||g_header_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_header_defs;
end header_version;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
begin
  return 'Package body BARS_REGEXP '||g_body_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_body_defs;
end body_version;


/**
 * match - проверяет строку p_string на соответствие шаблону p_pattern
 * @return 1 - строка соответствует шаблону, 0 - нет
 */
function match(p_pattern in varchar2, p_string in varchar2) return number


is
begin
  if regexp_like(p_string, p_pattern) then
    return 1;
  else
    return 0;
  end if;
end match;


end bars_regexp;
/
 show err;
 
PROMPT *** Create  grants  BARS_REGEXP ***
grant EXECUTE                                                                on BARS_REGEXP     to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_REGEXP     to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_REGEXP     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_regexp.sql =========*** End ***
 PROMPT ===================================================================================== 
 