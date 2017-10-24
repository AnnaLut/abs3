
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/translateex.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TRANSLATEEX (
	szSTR  VARCHAR2
)RETURN VARCHAR2
IS

BEGIN

	RETURN TRANSLATE(szSTR, sep.WIN_, sep.DOS_);

END TranslateEx;
/
 show err;
 
PROMPT *** Create  grants  TRANSLATEEX ***
grant EXECUTE                                                                on TRANSLATEEX     to DEB_REG;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/translateex.sql =========*** End **
 PROMPT ===================================================================================== 
 