
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/iif_n.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IIF_N 
(cond1 IN NUMBER, cond2 IN NUMBER, value1 IN VARCHAR2, value2 IN VARCHAR2, value3 VARCHAR2)
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
END iif_n;
/
 show err;
 
PROMPT *** Create  grants  IIF_N ***
grant EXECUTE                                                                on IIF_N           to ABS_ADMIN;
grant EXECUTE                                                                on IIF_N           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IIF_N           to START1;
grant EXECUTE                                                                on IIF_N           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/iif_n.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 