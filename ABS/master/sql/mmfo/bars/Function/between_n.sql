
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/between_n.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BETWEEN_N (NUM1_ NUMBER, NUM2_ NUMBER, NUM_R  NUMBER)
RETURN NUMBER IS
BEGIN
  IF NUM_R BETWEEN NUM1_ AND NUM2_ THEN
    RETURN NUM_R;
  ELSE
    RETURN NULL;
  END IF;
END BETWEEN_N;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/between_n.sql =========*** End *** 
 PROMPT ===================================================================================== 
 