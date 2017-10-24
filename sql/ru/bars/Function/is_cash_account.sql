
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/is_cash_account.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IS_CASH_ACCOUNT 
  (p_nls accounts.nls%type,
   p_kv  accounts.kv%type)
RETURN number
IS
  l_acc accounts.acc%type;
BEGIN

  SELECT acc
    INTO l_acc
    FROM accounts
   WHERE nls = p_nls
     AND kv = p_kv
     AND kf = sys_context('BARS_CONTEXT','USER_MFO')
     AND tip IN ('KAS', 'KAV');

  RETURN 1;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;
/
 show err;
 
PROMPT *** Create  grants  IS_CASH_ACCOUNT ***
grant EXECUTE                                                                on IS_CASH_ACCOUNT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on IS_CASH_ACCOUNT to DPT_ROLE;
grant EXECUTE                                                                on IS_CASH_ACCOUNT to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/is_cash_account.sql =========*** En
 PROMPT ===================================================================================== 
 