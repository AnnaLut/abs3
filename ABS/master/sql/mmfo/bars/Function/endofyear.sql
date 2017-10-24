
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/endofyear.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ENDOFYEAR (dat date := sysdate)
/* 
   ВОЗВРАТ ПОСЛЕДНЕГО ДНЯ ГОДА
   ===========================
   Если параметр dat не задан, возвращается последний день текущего года,
   в противном случае - последний день указанного года

-- Макаренко И.В. 29/01/2013 --
-- Модернизировано Толмачёв А.С. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN to_date('31/12/'||to_char(extract(year from dat),'9999'),'DD/MM/YYYY');
END;
/
 show err;
 
PROMPT *** Create  grants  ENDOFYEAR ***
grant EXECUTE                                                                on ENDOFYEAR       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/endofyear.sql =========*** End *** 
 PROMPT ===================================================================================== 
 