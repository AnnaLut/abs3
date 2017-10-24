
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bankdate.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BANKDATE return date is
begin
  return gl.bd;
end;
 
/
 show err;
 
PROMPT *** Create  grants  BANKDATE ***
grant EXECUTE                                                                on BANKDATE        to ABS_ADMIN;
grant EXECUTE                                                                on BANKDATE        to AUDIT_ROLE;
grant EXECUTE                                                                on BANKDATE        to BARSAQ with grant option;
grant EXECUTE                                                                on BANKDATE        to BARSAQ_ADM;
grant EXECUTE                                                                on BANKDATE        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BANKDATE        to BASIC_INFO;
grant EXECUTE                                                                on BANKDATE        to DPT_ROLE;
grant EXECUTE                                                                on BANKDATE        to RCC_DEAL;
grant EXECUTE                                                                on BANKDATE        to START1;
grant EXECUTE                                                                on BANKDATE        to TOSS;
grant EXECUTE                                                                on BANKDATE        to WEB_BALANS;
grant EXECUTE                                                                on BANKDATE        to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BANKDATE        to WR_CHCKINNR_ALL;
grant EXECUTE                                                                on BANKDATE        to WR_CHCKINNR_SELF;
grant EXECUTE                                                                on BANKDATE        to WR_CREDIT;
grant EXECUTE                                                                on BANKDATE        to WR_CUSTLIST;
grant EXECUTE                                                                on BANKDATE        to WR_CUSTREG;
grant EXECUTE                                                                on BANKDATE        to WR_DEPOSIT_U;
grant EXECUTE                                                                on BANKDATE        to WR_KP;
grant EXECUTE                                                                on BANKDATE        to WR_ND_ACCOUNTS;
grant EXECUTE                                                                on BANKDATE        to WR_RATES;
grant EXECUTE                                                                on BANKDATE        to WR_TOBO_ACCOUNTS_LIST;
grant EXECUTE                                                                on BANKDATE        to WR_USER_ACCOUNTS_LIST;
grant EXECUTE                                                                on BANKDATE        to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bankdate.sql =========*** End *** =
 PROMPT ===================================================================================== 
 