
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_birthday_staff_ca.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BIRTHDAY_STAFF_CA return VARCHAR2 
/* =============================================================================
-- Функция возвращает список сотрудников ЦА, у которых сегодня День Рождения 
-- и отправляет письмо-уведомление указанным лицам 
--
-- 12/04/2017
-- =============================================================================*/
IS
  Result VARCHAR2(4000);
  CRLF   CONSTANT CHAR(2) := CHR(13)||CHR(10); -- Carriage Return+Line Feed
BEGIN
  Result:='';
  FOR i IN (SELECT '* ' || to_char(birthday,'DD/MM/YYYY') || ' * ' || RPAD( fio, 50,' ') || ' * ' || trim(to_char(age,'99')) || ' *' as msg
              FROM V_BIRTHDAY_STAFF_CA
             ORDER BY age DESC)
  LOOP
    Result:=Result || i.msg || CRLF;
  END LOOP;
  IF Length(Result) > 0 THEN
    Result := 'Сьогодні день народження святкує :' || CRLF || CRLF || Result;
  END IF; 
  RETURN Result;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_birthday_staff_ca.sql =========**
 PROMPT ===================================================================================== 
 