
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/beginofweek.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BEGINOFWEEK (dat date := sysdate)
/* 
   ВОЗВРАТ НАЧАЛА НЕДЕЛИ
   =====================
   Если параметр dat не задан, возвращается начало текущей недели,
   в противном случае - начало недели для указанной даты

-- Макаренко И.В. 03/04/2015 --
*/
RETURN date
IS
BEGIN
  RETURN trunc(dat, 'DAY')+1;
END;
/
 show err;
 
PROMPT *** Create  grants  BEGINOFWEEK ***
grant EXECUTE                                                                on BEGINOFWEEK     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/beginofweek.sql =========*** End **
 PROMPT ===================================================================================== 
 