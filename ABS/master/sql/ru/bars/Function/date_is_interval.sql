
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/date_is_interval.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DATE_IS_INTERVAL (begin_date    DATE,
                                                  end_date      DATE)
   RETURN NUMBER
   DETERMINISTIC
IS
   result number;
BEGIN
   result := 0;

   BEGIN
      SELECT 1
        INTO result
        FROM DUAL
       WHERE TRUNC (SYSDATE) BETWEEN begin_date AND end_date;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         result := 0;
   END;

   RETURN result;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/date_is_interval.sql =========*** E
 PROMPT ===================================================================================== 
 