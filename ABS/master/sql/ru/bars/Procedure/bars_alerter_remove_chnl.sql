

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_REMOVE_CHNL.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_ALERTER_REMOVE_CHNL ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_ALERTER_REMOVE_CHNL (
    ret_          OUT INTEGER,
    chnl_name_     IN VARCHAR2)
IS
    pipenm VARCHAR2(30);
    sid_   INTEGER;

BEGIN

    SELECT userenv('SESSIONID') INTO sid_ FROM dual;
    pipenm := TRANSLATE(chnl_name_, '$', 'S') || '$' || TO_CHAR(sid_) || '$' || USER;

    ret_ := dbms_pipe.remove_pipe( pipenm );

END BARS_ALERTER_REMOVE_CHNL;
/
show err;

PROMPT *** Create  grants  BARS_ALERTER_REMOVE_CHNL ***
grant EXECUTE                                                                on BARS_ALERTER_REMOVE_CHNL to ABS_ADMIN;
grant EXECUTE                                                                on BARS_ALERTER_REMOVE_CHNL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ALERTER_REMOVE_CHNL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_REMOVE_CHNL.sql =====
PROMPT ===================================================================================== 
