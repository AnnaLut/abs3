
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vbr_01.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VBR_01 
(cond11 IN VARCHAR2, cond12 IN VARCHAR2, cond21 IN VARCHAR2, cond22 IN VARCHAR2,
 value1 IN VARCHAR2, value2 IN VARCHAR2)
RETURN VARCHAR2
IS
BEGIN
  IF (cond11 = cond12) AND (cond21 <> cond22) THEN
    RETURN value1;
  ELSE
    RETURN value2;
  END IF;
END VBR_01;
/
 show err;
 
PROMPT *** Create  grants  VBR_01 ***
grant EXECUTE                                                                on VBR_01          to ABS_ADMIN;
grant EXECUTE                                                                on VBR_01          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VBR_01          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vbr_01.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 