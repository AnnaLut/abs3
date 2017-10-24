

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_PUSH_MSG.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_ALERTER_PUSH_MSG ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_ALERTER_PUSH_MSG (
    ret_       OUT INTEGER,
    chnl_name_ IN  VARCHAR2,
    msgn_      IN  INTEGER,
    msg_       IN  VARCHAR2,
    param1_    IN  VARCHAR2,
    param2_    IN  VARCHAR2,
    param3_    IN  VARCHAR2  )
IS
    pipenm_    VARCHAR2(64);
    res        INTEGER;
    brk1       INTEGER;
    brk2       INTEGER;
    user_      VARCHAR2(40);
    sesid_     NUMBER;
    exist_     INTEGER;

CURSOR PipeList IS
    SELECT name FROM v$db_pipes
    WHERE name like TRANSLATE(chnl_name_,'$','S')||'%';

BEGIN

    OPEN PipeList;
    LOOP
        FETCH PipeList INTO pipenm_;
        EXIT WHEN PipeList%NOTFOUND;

        brk1 := INSTR(pipenm_,'$', 1, 1);
        brk2 := INSTR(pipenm_,'$', 1, 2);

        user_  := SUBSTR(pipenm_, brk2+1);
        sesid_ := TO_NUMBER(SUBSTR(pipenm_, brk1+1, brk2-brk1-1));

        BEGIN
            SELECT count(*) INTO exist_ FROM v$session
            WHERE audsid = sesid_ AND username = user_;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            exist_ := 0;
        END;

        IF exist_ <> 0 THEN
            dbms_pipe.pack_message('BARSALERTER');  -- protocol version
            dbms_pipe.pack_message(msgn_);
            dbms_pipe.pack_message(msg_);
            dbms_pipe.pack_message(param1_);
            dbms_pipe.pack_message(param2_);
            dbms_pipe.pack_message(param3_);

            res := dbms_pipe.send_message(pipenm_, 1);
            IF res <> 0 THEN
                -- Error: '||to_char(res)||' sending on pipe
                bars_error.raise_error('SVC', 3, to_char(res));
            END IF;
        END IF;
    END LOOP;
    ret_:=1;
END BARS_ALERTER_PUSH_MSG; 
 
/
show err;

PROMPT *** Create  grants  BARS_ALERTER_PUSH_MSG ***
grant EXECUTE                                                                on BARS_ALERTER_PUSH_MSG to ABS_ADMIN;
grant EXECUTE                                                                on BARS_ALERTER_PUSH_MSG to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ALERTER_PUSH_MSG to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER_PUSH_MSG.sql ========
PROMPT ===================================================================================== 
