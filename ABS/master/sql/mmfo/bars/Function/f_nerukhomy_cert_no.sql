
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nerukhomy_cert_no.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NERUKHOMY_CERT_NO return VARCHAR2 
/* =============================================================================
-- Функция возвращает список отсутствующих сертификатов для последующей отправки 
-- по почте Администраторам АБС (Макаренко И.В., Хихлуха Д.В.) и в 
-- Службу Безопасности (Туркалов С.В., Шевченко Я.В.)
--
-- 28.08.2015
-- =============================================================================*/
IS
  Result VARCHAR2(1000);
  CRLF   CONSTANT CHAR(2) := CHR(13)||CHR(10); -- Carriage Return+Line Feed
BEGIN
  Result:='';
  FOR i IN (SELECT key_id||' - '||region as msg
              FROM v_NERUKHOMY_cert_no
             ORDER BY key_id)
  LOOP
    Result:=Result || i.msg || CRLF;
  END LOOP;
  IF Length(Result) > 0 THEN
    Result := 'Відсутні сертифікати по ЦРНВ на наступні ключі операціоністів:' || CRLF || CRLF || Result;
  END IF; 
  RETURN Result;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nerukhomy_cert_no.sql =========**
 PROMPT ===================================================================================== 
 