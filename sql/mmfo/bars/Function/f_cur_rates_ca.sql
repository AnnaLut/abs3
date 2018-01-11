
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cur_rates_ca.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CUR_RATES_CA return VARCHAR2 
/* =============================================================================
-- Функция возвращает курсы валют ЦА 
-- и отправляет письмо-уведомление указанным лицам 
--
-- 20/04/2017 Макаренко И.В.
-- =============================================================================*/
IS
  CurrDate VARCHAR2(10);
  Result VARCHAR2(1500);
  CRLF   CONSTANT CHAR(2) := CHR(13)||CHR(10); -- Carriage Return+Line Feed
BEGIN
  bc.go('300465');
  select to_char(trunc(sysdate),'dd/mm/yyyy') into CurrDate from dual;
  Result:='';
  FOR i IN (SELECT '* '  || LPAD(trim(to_char(kv,'999')),3,' ') || 
                   ' * ' || lcv || 
                   ' * ' || RPAD(trim(kv_name),20,' ') || 
--                   ' * ' || LPAD(trim(to_char(base_sum,'9999')),4,' ') ||
                   ' * ' || '1' || 
                   ' * ' || LPAD(trim(to_char(rate_official/base_sum,'990.9999999')),10,' ') || 
                   ' * ' || LPAD(trim(to_char(rate_buy/base_sum,'990.9999')),7,' ') ||
                   ' * ' || LPAD(trim(to_char(rate_sale/base_sum,'990.9999')),7,' ') || ' *' as msg
              FROM V_CUR_RATES_CA)
  LOOP
    Result:=Result || i.msg || CRLF;
  END LOOP;
  IF Length(Result) > 0 THEN
    Result := 'На сьогодні (' || CurrDate || ') встановлені наступні курси валют :' || CRLF || CRLF || 
              '*************************************************************************' || CRLF ||
              '*              Валюта              *   *  Курс НБУ  * Покупка * Продажа *' || CRLF ||
              '*************************************************************************' || CRLF || 
              Result ||
              '*************************************************************************' || CRLF;
  END IF; 
  bc.home;
  RETURN Result;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cur_rates_ca.sql =========*** End
 PROMPT ===================================================================================== 
 