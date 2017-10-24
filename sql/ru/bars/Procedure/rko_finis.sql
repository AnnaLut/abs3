

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RKO_FINIS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RKO_FINIS ***

  CREATE OR REPLACE PROCEDURE BARS.RKO_FINIS (dat_ date) IS
BEGIN

----   Погашення заборгованностi за РО:  2600 - 3579,3570  (аналог кнопки "2"):

       rko.PAY('2',dat_, ' and  a.ACC  not in  (select ACC from RKO_3570) ');

END;
/
show err;

PROMPT *** Create  grants  RKO_FINIS ***
grant EXECUTE                                                                on RKO_FINIS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RKO_FINIS       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RKO_FINIS.sql =========*** End ***
PROMPT ===================================================================================== 
