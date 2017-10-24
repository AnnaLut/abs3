
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/iif_d.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IIF_D 
(cond1 IN DATE, cond2 IN DATE, value1 IN VARCHAR2, value2 IN VARCHAR2, value3 VARCHAR2)
RETURN VARCHAR2
IS
   vcRet VARCHAR2(254);
BEGIN
  IF (cond1 < cond2) THEN
    vcRet := value1;
    RETURN vcRet;
  ELSIF (cond1 = cond2) THEN
    vcRet := value2;
    RETURN vcRet;
  ELSE
    vcRet := value3;
    RETURN vcRet;
  END IF;
END iif_d;
/
 show err;
 
PROMPT *** Create  grants  IIF_D ***
grant EXECUTE                                                                on IIF_D           to ABS_ADMIN;
grant EXECUTE                                                                on IIF_D           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IIF_D           to START1;
grant EXECUTE                                                                on IIF_D           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/iif_d.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 