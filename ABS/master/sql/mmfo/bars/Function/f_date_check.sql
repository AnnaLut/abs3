
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_date_check.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DATE_CHECK (in_date varchar2) RETURN NUMBER IS
  RESULT NUMBER;
sdate  DATE;
BEGIN
  BEGIN
    SELECT to_date(in_date,'dd/mm/yyyy') INTO sdate FROM dual;
EXCEPTION
    WHEN OTHERS THEN
        RESULT := 1;
END;
RETURN(RESULT);
END f_date_check;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_date_check.sql =========*** End *
 PROMPT ===================================================================================== 
 