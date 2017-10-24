
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vbr_credit.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VBR_CREDIT 
(dk IN NUMBER, s1 IN NUMBER, s2 IN NUMBER )
RETURN NUMBER
IS
BEGIN
  IF dk=1 THEN
 IF s1 <= s2 THEN
   RETURN s1;
 ELSE
   RETURN s2;
 END IF;
  ELSE
    RETURN NULL;
  END IF;
END VBR_CREDIT;
/
 show err;
 
PROMPT *** Create  grants  VBR_CREDIT ***
grant EXECUTE                                                                on VBR_CREDIT      to ABS_ADMIN;
grant EXECUTE                                                                on VBR_CREDIT      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VBR_CREDIT      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vbr_credit.sql =========*** End ***
 PROMPT ===================================================================================== 
 