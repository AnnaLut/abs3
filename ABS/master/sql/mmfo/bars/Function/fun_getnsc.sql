
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fun_getnsc.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FUN_GETNSC (p_nazn IN VARCHAR2) RETURN VARCHAR2
IS
    tmp_   VARCHAR2(200);
    L_     NUMBER;
    NSC_   VARCHAR2(200);
BEGIN
    L_      := instr (p_nazn, ';');
    tmp_    := substr(p_nazn, L_+1,200);

    L_      := instr (tmp_, ';');
    NSC_    := substr(tmp_, 1, L_-1);

    RETURN NSC_;
END fun_GetNSC;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fun_getnsc.sql =========*** End ***
 PROMPT ===================================================================================== 
 