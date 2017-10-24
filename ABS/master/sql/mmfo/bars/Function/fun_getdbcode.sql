
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fun_getdbcode.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FUN_GETDBCODE (p_nazn IN VARCHAR2) RETURN VARCHAR2
IS
    tmp_     VARCHAR2(200);
    L_       NUMBER;
    DBCODE_  VARCHAR2(200);
BEGIN
    L_      := instr (p_nazn, ';');
    tmp_    := substr(p_nazn, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    DBCODE_ := substr(tmp_, 1, L_-1);

    RETURN  DBCODE_;
END fun_GetDBCODE;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fun_getdbcode.sql =========*** End 
 PROMPT ===================================================================================== 
 