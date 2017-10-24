
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/if_between_n.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IF_BETWEEN_N (NUM1_ NUMBER, NUM2_ NUMBER, NUM_R  NUMBER)
RETURN NUMBER IS
BEGIN
  IF NUM_R BETWEEN NUM1_ AND NUM2_ THEN
    RETURN 1;
  ELSE
    RETURN 0;
  END IF;
END IF_BETWEEN_N;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/if_between_n.sql =========*** End *
 PROMPT ===================================================================================== 
 