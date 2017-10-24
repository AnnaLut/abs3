
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/translatedos2win.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TRANSLATEDOS2WIN (
	szSTR  VARCHAR2
)RETURN VARCHAR2
IS
BEGIN
  RETURN TRANSLATE(szSTR, SEP.DOS_, SEP.WIN_);
END TranslateDos2Win;
/
 show err;
 
PROMPT *** Create  grants  TRANSLATEDOS2WIN ***
grant EXECUTE                                                                on TRANSLATEDOS2WIN to ABS_ADMIN;
grant EXECUTE                                                                on TRANSLATEDOS2WIN to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TRANSLATEDOS2WIN to BASIC_INFO;
grant EXECUTE                                                                on TRANSLATEDOS2WIN to DEB_REG;
grant EXECUTE                                                                on TRANSLATEDOS2WIN to START1;
grant EXECUTE                                                                on TRANSLATEDOS2WIN to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/translatedos2win.sql =========*** E
 PROMPT ===================================================================================== 
 