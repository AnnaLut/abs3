
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/beginofyear.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BEGINOFYEAR (dat date := sysdate)
/* 
   ВОЗВРАТ ПЕРВОГО ДНЯ ГОДА
   ========================
   Если параметр dat не задан, возвращается первый день текущего года,
   в противном случае - первый день указанного года

-- Макаренко И.В. 29/01/2013 --
-- Модернизировано Толмачёв А.С. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN trunc(dat,'YYYY');
END;
/
 show err;
 
PROMPT *** Create  grants  BEGINOFYEAR ***
grant EXECUTE                                                                on BEGINOFYEAR     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/beginofyear.sql =========*** End **
 PROMPT ===================================================================================== 
 