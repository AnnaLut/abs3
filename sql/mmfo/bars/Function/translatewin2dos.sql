
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/translatewin2dos.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TRANSLATEWIN2DOS (
  szSTR  VARCHAR2
)RETURN VARCHAR2
IS

BEGIN

  RETURN TRANSLATE(szSTR, sep.WIN_, sep.DOS_);

END TranslateWin2Dos;
 
/
 show err;
 
PROMPT *** Create  grants  TRANSLATEWIN2DOS ***
grant EXECUTE                                                                on TRANSLATEWIN2DOS to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/translatewin2dos.sql =========*** E
 PROMPT ===================================================================================== 
 