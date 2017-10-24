
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_arcrrp_nazn.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ARCRRP_NAZN ( rec_  INTEGER )
  RETURN VARCHAR2 IS
  nazn_  VARCHAR2(160);

BEGIN

 Select NAZN into nazn_ from ARC_RRP where REC=rec_;

 RETURN nazn_;

END F_ARCRRP_NAZN ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_arcrrp_nazn.sql =========*** End 
 PROMPT ===================================================================================== 
 