
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/beginofmonth.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BEGINOFMONTH (dat date := sysdate)
/* 
   ВОЗВРАТ ПЕРВОГО ДНЯ МЕСЯЦА
   ==========================
   Если параметр dat не задан, возвращается первый день текущего месяца,
   в противном случае - первый день указанного месяца

-- Макаренко И.В. 29/01/2013 --
-- Модернизировано Толмачёв А.С. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN trunc(dat,'MM');
END;
/
 show err;
 
PROMPT *** Create  grants  BEGINOFMONTH ***
grant EXECUTE                                                                on BEGINOFMONTH    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/beginofmonth.sql =========*** End *
 PROMPT ===================================================================================== 
 