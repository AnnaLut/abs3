

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FUL_BAK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FUL_BAK ***

  CREATE OR REPLACE PROCEDURE BARS.FUL_BAK ( ref_ NUMBER)  -- Reference number
IS
BEGIN
  gl.bck( ref_, 9);
END;
/
show err;

PROMPT *** Create  grants  FUL_BAK ***
grant EXECUTE                                                                on FUL_BAK         to ABS_ADMIN;
grant EXECUTE                                                                on FUL_BAK         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FUL_BAK         to TEST;
grant EXECUTE                                                                on FUL_BAK         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FUL_BAK.sql =========*** End *** =
PROMPT ===================================================================================== 
