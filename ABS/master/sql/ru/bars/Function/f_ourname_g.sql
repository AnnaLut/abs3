
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ourname_g.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OURNAME_G RETURN VARCHAR2 IS
  N_NAME VARCHAR2(250);
BEGIN
  begin
    SELECT VAL
    INTO   N_NAME
    FROM   PARAMS$GLOBAL
    WHERE  PAR = 'GLB-NAME';
  exception when others then
    N_NAME := getbankname(f_ourmfo_g);
  end;
  RETURN N_NAME;
END;
/
 show err;
 
PROMPT *** Create  grants  F_OURNAME_G ***
grant EXECUTE                                                                on F_OURNAME_G     to ABS_ADMIN;
grant EXECUTE                                                                on F_OURNAME_G     to BARSAQ;
grant EXECUTE                                                                on F_OURNAME_G     to BARSAQ_ADM;
grant EXECUTE                                                                on F_OURNAME_G     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OURNAME_G     to START1;
grant EXECUTE                                                                on F_OURNAME_G     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ourname_g.sql =========*** End **
 PROMPT ===================================================================================== 
 