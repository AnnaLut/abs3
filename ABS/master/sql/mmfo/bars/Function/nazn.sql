
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nazn.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NAZN 
  RETURN VARCHAR2 IS
  nazn_  VARCHAR2(160);

BEGIN

 Select NAZN into nazn_ from ARC_RRP where REC=sep.g_rec ;

 RETURN nazn_;

END NAZN ;
/
 show err;
 
PROMPT *** Create  grants  NAZN ***
grant EXECUTE                                                                on NAZN            to BARS014;
grant EXECUTE                                                                on NAZN            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAZN            to TOSS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nazn.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 