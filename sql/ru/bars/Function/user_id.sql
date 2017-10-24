
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/user_id.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.USER_ID RETURN NUMBER
IS
BEGIN
  RETURN gl.aUID;
END USER_ID;
/
 show err;
 
PROMPT *** Create  grants  USER_ID ***
grant EXECUTE                                                                on USER_ID         to ABS_ADMIN;
grant EXECUTE                                                                on USER_ID         to BARSAQ with grant option;
grant EXECUTE                                                                on USER_ID         to BARSAQ_ADM with grant option;
grant EXECUTE                                                                on USER_ID         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on USER_ID         to BASIC_INFO;
grant EXECUTE                                                                on USER_ID         to CHCK;
grant EXECUTE                                                                on USER_ID         to DPT;
grant EXECUTE                                                                on USER_ID         to PYOD001;
grant EXECUTE                                                                on USER_ID         to RPBN001;
grant EXECUTE                                                                on USER_ID         to START1;
grant EXECUTE                                                                on USER_ID         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on USER_ID         to WR_CREDIT;
grant EXECUTE                                                                on USER_ID         to WR_CREPORTS;
grant EXECUTE                                                                on USER_ID         to WR_CUSTLIST;
grant EXECUTE                                                                on USER_ID         to WR_CUSTREG;
grant EXECUTE                                                                on USER_ID         to WR_DEPOSIT_U;
grant EXECUTE                                                                on USER_ID         to WR_DIAGNOSTICS;
grant EXECUTE                                                                on USER_ID         to WR_DOC_INPUT;
grant EXECUTE                                                                on USER_ID         to WR_FILTER;
grant EXECUTE                                                                on USER_ID         to WR_KP;
grant EXECUTE                                                                on USER_ID         to WR_VERIFDOC;
grant EXECUTE                                                                on USER_ID         to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/user_id.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 