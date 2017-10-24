
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fun_getdatid.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FUN_GETDATID (p_nazn IN VARCHAR2) RETURN  date
IS
    tmp_     VARCHAR2(200);
    L_       NUMBER;
    DATID_ date := null;
BEGIN
    L_      := instr (p_nazn, ';');    tmp_    := substr(p_nazn, L_+1,200);
    L_      := instr (tmp_, ';');      tmp_    := substr(tmp_, L_+1,200);
    L_      := instr (tmp_, ';');      tmp_    := substr(tmp_, L_+1,200);
    L_      := instr (tmp_, ';');      tmp_    := substr(tmp_, L_+1,200);
    L_      := instr (tmp_, ';');      tmp_    := substr(tmp_, L_+1,200);
    L_      := instr (tmp_, ';');      tmp_    := substr(tmp_, L_+1,200);
    L_      := instr (tmp_, ';');      TMP_ := substr(tmp_, 1, L_-1);
    begin
       DATID_:= to_date(TMP_,'dd-mm-yyyy');
    EXCEPTION  WHEN OTHERS THEN null;
    end;
    RETURN  DATID_;
END fun_GetDATID;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fun_getdatid.sql =========*** End *
 PROMPT ===================================================================================== 
 