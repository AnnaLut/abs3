
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vbr_debet.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VBR_DEBET 
(dk IN NUMBER, s1 IN NUMBER, s2 IN NUMBER )
RETURN NUMBER
IS
BEGIN
  IF dk=0 THEN
 IF s1 <= s2 THEN
   RETURN s1;
 ELSE
   RETURN s2;
 END IF;
  ELSE
    RETURN NULL;
  END IF;
END VBR_DEBET;
/
 show err;
 
PROMPT *** Create  grants  VBR_DEBET ***
grant EXECUTE                                                                on VBR_DEBET       to ABS_ADMIN;
grant EXECUTE                                                                on VBR_DEBET       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VBR_DEBET       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vbr_debet.sql =========*** End *** 
 PROMPT ===================================================================================== 
 