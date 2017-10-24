

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_CREATE_CHNL.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_ALERTER_CREATE_CHNL ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_ALERTER_CREATE_CHNL (
    ret_          OUT INTEGER,
    chnl_name_     IN VARCHAR2,
    chnl_size_     IN NUMBER DEFAULT 10240)
IS
    pipenm VARCHAR2(30);
    sid_   INTEGER;

BEGIN

    SELECT userenv('SESSIONID') INTO sid_ FROM dual;
    pipenm := TRANSLATE(chnl_name_, '$', 'S') || '$' || TO_CHAR(sid_) || '$' || USER;

    ret_ := dbms_pipe.create_pipe( pipenm, chnl_size_ );

END BARS_ALERTER_CREATE_CHNL;
 
/
show err;

PROMPT *** Create  grants  BARS_ALERTER_CREATE_CHNL ***
grant EXECUTE                                                                on BARS_ALERTER_CREATE_CHNL to ABS_ADMIN;
grant EXECUTE                                                                on BARS_ALERTER_CREATE_CHNL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ALERTER_CREATE_CHNL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_CREATE_CHNL.sql =====
PROMPT ===================================================================================== 
