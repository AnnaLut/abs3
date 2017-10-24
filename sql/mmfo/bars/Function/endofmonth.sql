
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/endofmonth.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ENDOFMONTH (dat date := sysdate)
/* 
   ВОЗВРАТ ПОСЛЕДНЕГО ДНЯ МЕСЯЦА
   =============================
   Если параметр dat не задан, возвращается последний день текущего месяца,
   в противном случае - последний день указанного месяца

-- Макаренко И.В. 29/01/2013 --
-- Модернизировано Толмачёв А.С. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN TRUNC(LAST_DAY(dat));
END;
/
 show err;
 
PROMPT *** Create  grants  ENDOFMONTH ***
grant EXECUTE                                                                on ENDOFMONTH      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/endofmonth.sql =========*** End ***
 PROMPT ===================================================================================== 
 