
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/secure_groups_approved.sql ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SECURE_GROUPS_APPROVED (
    chk NUMBER,
    ad1 DATE,
    ad2 DATE,
    rd1 DATE,
    rd2 DATE) RETURN NUMBER
IS
    SecureMode  NUMBER;
    ItsOk       NUMBER;

BEGIN
    BEGIN
        SELECT TO_NUMBER(val) INTO SecureMode FROM params WHERE par = 'LOSECURE';
    EXCEPTION WHEN NO_DATA_FOUND THEN
        SecureMode := 0;
    END;

    IF SecureMode = 1 THEN
        ItsOk := 1;
    ELSE
        ItsOk := chk * DATE_IS_VALID(ad1, ad2, rd1, rd2);
    END IF;

    RETURN ItsOk;
END;
/
 show err;
 
PROMPT *** Create  grants  SECURE_GROUPS_APPROVED ***
grant EXECUTE                                                                on SECURE_GROUPS_APPROVED to ABS_ADMIN;
grant EXECUTE                                                                on SECURE_GROUPS_APPROVED to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SECURE_GROUPS_APPROVED to START1;
grant EXECUTE                                                                on SECURE_GROUPS_APPROVED to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/secure_groups_approved.sql ========
 PROMPT ===================================================================================== 
 