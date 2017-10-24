
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nam_a.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NAM_A 
  RETURN VARCHAR2 IS
  nam_a_  VARCHAR2(38);

BEGIN

 Select NAM_A into nam_a_ from ARC_RRP where REC=sep.g_rec ;

 RETURN nam_a_;

END NAM_A ;
/
 show err;
 
PROMPT *** Create  grants  NAM_A ***
grant EXECUTE                                                                on NAM_A           to BARS014;
grant EXECUTE                                                                on NAM_A           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAM_A           to TOSS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nam_a.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 