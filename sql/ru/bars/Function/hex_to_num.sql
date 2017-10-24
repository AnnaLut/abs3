
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/hex_to_num.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.HEX_TO_NUM (HEX_ IN VARCHAR2) RETURN NUMBER
IS
    RET_   NUMBER;
    CSTR_  VARCHAR2(1);
    LSTR_  NUMBER;
    CPOS_  NUMBER;
    i      NUMBER;
BEGIN
    IF HEX_ IS NULL THEN
        RETURN 0;
    END IF;

    LSTR_ := LENGTH(HEX_);

    RET_  := 0;
    FOR i IN 1..LSTR_ LOOP
        CSTR_ := UPPER(SUBSTR(HEX_, -i, 1));
        CPOS_ := INSTR('0123456789ABCDEF',CSTR_);
        IF CPOS_ > 0 THEN
            RET_  := RET_ + (CPOS_-1) * POWER(16, i-1);
        END IF;
    END LOOP;

    RETURN RET_;
END HEX_TO_NUM;
/
 show err;
 
PROMPT *** Create  grants  HEX_TO_NUM ***
grant EXECUTE                                                                on HEX_TO_NUM      to ABS_ADMIN;
grant EXECUTE                                                                on HEX_TO_NUM      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on HEX_TO_NUM      to START1;
grant EXECUTE                                                                on HEX_TO_NUM      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/hex_to_num.sql =========*** End ***
 PROMPT ===================================================================================== 
 