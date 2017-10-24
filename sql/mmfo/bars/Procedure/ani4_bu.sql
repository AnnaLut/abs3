

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ANI4_BU.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ANI4_BU ***

  CREATE OR REPLACE PROCEDURE BARS.ANI4_BU (TERM_ int, MODE_ int, YYYY_MM varchar2) IS
begin
 ANI4_bU_ex (TERM_ , MODE_ , YYYY_MM );
end ANI4_bU;
 
/
show err;

PROMPT *** Create  grants  ANI4_BU ***
grant EXECUTE                                                                on ANI4_BU         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ANI4_BU         to SALGL;
grant EXECUTE                                                                on ANI4_BU         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ANI4_BU.sql =========*** End *** =
PROMPT ===================================================================================== 
