
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/is_date.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IS_DATE (p_str_in IN VARCHAR2, p_fmt IN VARCHAR2) RETURN NUMBER DETERMINISTIC PARALLEL_ENABLE IS
   l_dat date;
BEGIN
   l_dat := TO_date(p_str_in, p_fmt);

   RETURN 1;
EXCEPTION
   WHEN others THEN
      RETURN 0;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/is_date.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 