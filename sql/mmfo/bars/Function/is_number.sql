
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/is_number.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IS_NUMBER (str_in IN VARCHAR2) RETURN NUMBER DETERMINISTIC PARALLEL_ENABLE IS
   n NUMBER;
BEGIN
   n := TO_NUMBER(str_in);

   RETURN 1;
EXCEPTION
   WHEN VALUE_ERROR THEN
      RETURN 0;
END;
/
 show err;
 
PROMPT *** Create  grants  IS_NUMBER ***
grant EXECUTE                                                                on IS_NUMBER       to BARSUPL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/is_number.sql =========*** End *** 
 PROMPT ===================================================================================== 
 