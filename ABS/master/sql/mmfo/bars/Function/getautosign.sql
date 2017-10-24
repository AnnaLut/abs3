
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getautosign.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETAUTOSIGN 
RETURN VARCHAR2
IS
BEGIN
    RETURN '4155544F5452414E53414354494F4E';  --'AUTOTRANSACTION';
END;
 
/
 show err;
 
PROMPT *** Create  grants  GETAUTOSIGN ***
grant EXECUTE                                                                on GETAUTOSIGN     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETAUTOSIGN     to RCC_DEAL;
grant EXECUTE                                                                on GETAUTOSIGN     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getautosign.sql =========*** End **
 PROMPT ===================================================================================== 
 