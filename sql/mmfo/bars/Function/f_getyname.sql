
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getyname.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETYNAME (p_nazn IN VARCHAR2) RETURN  VARCHAR2  IS
    tmp_     VARCHAR2(200);  L_ NUMBER;
    Y_       VARCHAR2(12);
BEGIN
    L_   := instr (p_nazn, ';');   tmp_   := substr(p_nazn, L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , ';');   tmp_   := substr(tmp_  , L_+1,200 );
    L_   := instr (tmp_  , 'Y');
    If L_>0 then    Y_:= substr(tmp_, L_, 12);
    else           Y_:= to_char(null);
    end if;
    RETURN  Y_;
END f_GetYname;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getyname.sql =========*** End ***
 PROMPT ===================================================================================== 
 