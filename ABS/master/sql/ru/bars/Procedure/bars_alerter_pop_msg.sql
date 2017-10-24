

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_POP_MSG.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_ALERTER_POP_MSG ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_ALERTER_POP_MSG (
    ret_       OUT INTEGER,
    chnl_name_ IN  VARCHAR2,
    msgn_      OUT INTEGER,
    msg_       OUT VARCHAR2,
    param1_    OUT VARCHAR2,
    param2_    OUT VARCHAR2,
    param3_    OUT VARCHAR2  )
IS
    res    INTEGER;
    marker VARCHAR2(30);
    sid_   INTEGER;
    pipenm VARCHAR2(30);

BEGIN
    SELECT userenv('SESSIONID') INTO sid_ FROM dual;
    pipenm := TRANSLATE(chnl_name_, '$', 'S') || '$' || TO_CHAR(sid_) || '$' || USER;

    res := dbms_pipe.receive_message(pipenm, 0);
    IF res <> 0 THEN
        ret_ := 0;
        RETURN;
    END IF;
    dbms_pipe.unpack_message(marker);
    IF marker <> 'BARSALERTER' THEN
        ret_ := 0;
        RETURN;
    END IF;
    dbms_pipe.unpack_message(msgn_);
    dbms_pipe.unpack_message(msg_);
    dbms_pipe.unpack_message(param1_);
    dbms_pipe.unpack_message(param2_);
    dbms_pipe.unpack_message(param3_);
    ret_ := 1;

END BARS_ALERTER_POP_MSG;
/
show err;

PROMPT *** Create  grants  BARS_ALERTER_POP_MSG ***
grant EXECUTE                                                                on BARS_ALERTER_POP_MSG to ABS_ADMIN;
grant EXECUTE                                                                on BARS_ALERTER_POP_MSG to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ALERTER_POP_MSG to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_POP_MSG.sql =========
PROMPT ===================================================================================== 
