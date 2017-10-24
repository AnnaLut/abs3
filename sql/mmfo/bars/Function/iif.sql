
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/iif.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IIF 
(cond1 IN VARCHAR2, cond2 IN VARCHAR2, value1 IN VARCHAR2, value2 IN VARCHAR2, value3 VARCHAR2)
RETURN VARCHAR2
IS
   vcRet VARCHAR2(50);
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
END iif;



 
/
 show err;
 
PROMPT *** Create  grants  IIF ***
grant EXECUTE                                                                on IIF             to ABS_ADMIN;
grant EXECUTE                                                                on IIF             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IIF             to START1;
grant EXECUTE                                                                on IIF             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/iif.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 