
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/date_is_valid.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DATE_IS_VALID (
    ad1 DATE,
    ad2 DATE,
    rd1 DATE,
    rd2 DATE) RETURN NUMBER
IS
    cdate    DATE;
BEGIN

    cdate := TRUNC(sysdate);

    IF ad1 IS NOT NULL AND cdate < ad1 THEN
        return 0;
    END IF;

    IF ad2 IS NOT NULL AND cdate > ad2 THEN
        return 0;
    END IF;

    IF rd1 IS NOT NULL AND cdate >= rd1 AND
	   (rd2 IS NULL OR (rd2 IS NOT NULL AND cdate <= rd2)) THEN
        return 0;
    END IF;

    IF rd2 IS NOT NULL AND cdate <= rd2 AND
	   (rd1 IS NULL OR (rd1 IS NOT NULL AND cdate >= rd1)) THEN
        return 0;
    END IF;

    RETURN 1;

END;
/
 show err;
 
PROMPT *** Create  grants  DATE_IS_VALID ***
grant EXECUTE                                                                on DATE_IS_VALID   to ABS_ADMIN;
grant EXECUTE                                                                on DATE_IS_VALID   to BARSAQ with grant option;
grant EXECUTE                                                                on DATE_IS_VALID   to BARSAQ_ADM with grant option;
grant EXECUTE                                                                on DATE_IS_VALID   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DATE_IS_VALID   to START1;
grant EXECUTE                                                                on DATE_IS_VALID   to WR_ALL_RIGHTS;
grant EXECUTE                                                                on DATE_IS_VALID   to WR_CHCKINNR_ALL;
grant EXECUTE                                                                on DATE_IS_VALID   to WR_CHCKINNR_SELF;
grant EXECUTE                                                                on DATE_IS_VALID   to WR_DOC_INPUT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/date_is_valid.sql =========*** End 
 PROMPT ===================================================================================== 
 