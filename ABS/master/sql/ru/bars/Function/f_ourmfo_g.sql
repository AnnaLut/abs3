

 PROMPT =====================================================================================
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ourmfo_g.sql =========*** Run ***
 PROMPT =====================================================================================

  CREATE OR REPLACE FUNCTION BARS.F_OURMFO_G RETURN VARCHAR2 IS
  N_MFO NUMBER;
BEGIN
  begin
    SELECT TO_NUMBER (VAL)
    INTO   N_MFO
    FROM   PARAMS$GLOBAL
    WHERE  PAR = 'GLB-MFO';
  exception when others then
    N_MFO := f_ourmfo;
  end;
  RETURN N_MFO;
END;
/
 show err;

PROMPT *** Create  grants  F_OURMFO_G ***
grant EXECUTE                                                                on F_OURMFO_G      to ABS_ADMIN;
grant EXECUTE                                                                on F_OURMFO_G      to BARSAQ with grant option;
grant EXECUTE                                                                on F_OURMFO_G      to BARSAQ_ADM;
grant EXECUTE                                                                on F_OURMFO_G      to BARSUPL;
grant EXECUTE                                                                on F_OURMFO_G      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OURMFO_G      to BARS_DM;
grant EXECUTE                                                                on F_OURMFO_G      to BARS_SUP;
grant EXECUTE                                                                on F_OURMFO_G      to START1;
grant EXECUTE                                                                on F_OURMFO_G      to UPLD;
grant EXECUTE                                                                on F_OURMFO_G      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_OURMFO_G      to BARS_INTGR;



 PROMPT =====================================================================================
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ourmfo_g.sql =========*** End ***
 PROMPT =====================================================================================
