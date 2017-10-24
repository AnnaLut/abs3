
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_bpk_params.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_BPK_PARAMS (p_nd w4_acc.nd%type, par_ IN VARCHAR2) RETURN VARCHAR2 IS
/* Âåðñèÿ 1.0 17-02-2017
   ÂÊÐ ïî ÁÏÊ

*/

  val_ BPK_PARAMETERS.value%TYPE;
BEGIN
   BEGIN
      select trim(value) into val_ from BPK_PARAMETERS where nd = p_nd and tag = par_;
   EXCEPTION WHEN NO_DATA_FOUND THEN val_ := NULL;
   END;

   RETURN val_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_GET_BPK_PARAMS ***
grant EXECUTE                                                                on F_GET_BPK_PARAMS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_BPK_PARAMS to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_bpk_params.sql =========*** E
 PROMPT ===================================================================================== 
 