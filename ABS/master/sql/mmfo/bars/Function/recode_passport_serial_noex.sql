
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/recode_passport_serial_noex.sql ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RECODE_PASSPORT_SERIAL_NOEX (p_serial in person.ser%type) return person.ser%type is
  -- оптимизировано SERG  29/09/2010
  l_result  person.ser%type;
  l_errmsg  varchar2(128);
begin
  kl.recode_passport_serial_silent(p_serial, l_result, l_errmsg);
  if l_errmsg='SUCCESS'
  then
      return l_result;
  else
	  return null;
  end if;
end recode_passport_serial_noex;
/
 show err;
 
PROMPT *** Create  grants  RECODE_PASSPORT_SERIAL_NOEX ***
grant EXECUTE                                                                on RECODE_PASSPORT_SERIAL_NOEX to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RECODE_PASSPORT_SERIAL_NOEX to PYOD001;
grant EXECUTE                                                                on RECODE_PASSPORT_SERIAL_NOEX to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/recode_passport_serial_noex.sql ===
 PROMPT ===================================================================================== 
 