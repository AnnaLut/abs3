
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bankdate_g.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BANKDATE_G return DATE IS
 curdate_G DATE;
BEGIN
 beGIN
   SELECT TO_DATE(val,'MM-DD-YYYY')  INTO curdate_G  fROM params
   WHERE par = 'BANKDATE';
 EXCEPTION WHEN NO_DATA_FOUND THEN curdate_G := NULL;
 END;
 RETURN curdate_G;
END bankdate_G;
/
 show err;
 
PROMPT *** Create  grants  BANKDATE_G ***
grant EXECUTE                                                                on BANKDATE_G      to ABS_ADMIN;
grant EXECUTE                                                                on BANKDATE_G      to AUDIT_ROLE;
grant EXECUTE                                                                on BANKDATE_G      to BARSAQ with grant option;
grant EXECUTE                                                                on BANKDATE_G      to BARSAQ_ADM;
grant EXECUTE                                                                on BANKDATE_G      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BANKDATE_G      to BASIC_INFO;
grant EXECUTE                                                                on BANKDATE_G      to DPT;
grant EXECUTE                                                                on BANKDATE_G      to DPT_ROLE;
grant EXECUTE                                                                on BANKDATE_G      to RCC_DEAL;
grant EXECUTE                                                                on BANKDATE_G      to START1;
grant EXECUTE                                                                on BANKDATE_G      to TOSS;
grant EXECUTE                                                                on BANKDATE_G      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BANKDATE_G      to WR_CUSTLIST;
grant EXECUTE                                                                on BANKDATE_G      to WR_CUSTREG;
grant EXECUTE                                                                on BANKDATE_G      to WR_KP;
grant EXECUTE                                                                on BANKDATE_G      to WR_QDOCS;
grant EXECUTE                                                                on BANKDATE_G      to WR_TOBO_ACCOUNTS_LIST;
grant EXECUTE                                                                on BANKDATE_G      to WR_USER_ACCOUNTS_LIST;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bankdate_g.sql =========*** End ***
 PROMPT ===================================================================================== 
 