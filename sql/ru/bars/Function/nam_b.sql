
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nam_b.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NAM_B 
  RETURN VARCHAR2 IS
  nam_b_  VARCHAR2(38);

BEGIN

 Select NAM_B into nam_b_ from ARC_RRP where REC=sep.g_rec ;

 RETURN nam_b_;

END NAM_B ;
/
 show err;
 
PROMPT *** Create  grants  NAM_B ***
grant EXECUTE                                                                on NAM_B           to BARS014;
grant EXECUTE                                                                on NAM_B           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAM_B           to TOSS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nam_b.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 