
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/eqv.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.EQV (kv_ NUMBER,S_ NUMBER) RETURN DECIMAL IS
SE_ NUMBER;
BEGIN
  SELECT kurs*S_ INTO SE_ FROM KURS1 WHERE kv=kv_;
  RETURN SE_;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN gl.p_icurval(kv_,S_,gl.BD);
END EQV ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/eqv.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 