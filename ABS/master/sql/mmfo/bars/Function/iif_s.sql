
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/iif_s.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IIF_S 
(cond1 IN VARCHAR2, cond2 IN VARCHAR2, value1 IN VARCHAR2, value2 IN VARCHAR2, value3 VARCHAR2)
RETURN VARCHAR2
IS
   vcRet VARCHAR2(254);
BEGIN
  IF (cond1 < cond2) THEN
    vcRet := substr(value1,1,254);
    RETURN vcRet;
  ELSIF (cond1 = cond2) THEN
    vcRet := substr(value2,1,254);
    RETURN vcRet;
  ELSE
    vcRet := substr(value3,1,254);
    RETURN vcRet;
  END IF;
END iif_s;
/
 show err;
 
PROMPT *** Create  grants  IIF_S ***
grant EXECUTE                                                                on IIF_S           to ABS_ADMIN;
grant EXECUTE                                                                on IIF_S           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IIF_S           to START1;
grant EXECUTE                                                                on IIF_S           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/iif_s.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 