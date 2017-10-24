
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getchr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETCHR (digit NUMBER)
RETURN VARCHAR2
IS
-- Возвращает для числа строковое значение (формат СЭП)
BEGIN

IF  digit < 0 OR  digit > 35 THEN
    RETURN '?';
ELSE
   IF digit <= 9 THEN
       RETURN CHR(digit+48);
   ELSE
       RETURN CHR(digit+55);
   END IF;

END IF;

END;

 
/
 show err;
 
PROMPT *** Create  grants  GETCHR ***
grant EXECUTE                                                                on GETCHR          to ABS_ADMIN;
grant EXECUTE                                                                on GETCHR          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETCHR          to RPBN001;
grant EXECUTE                                                                on GETCHR          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getchr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 