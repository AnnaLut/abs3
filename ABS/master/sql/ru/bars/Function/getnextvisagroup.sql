
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getnextvisagroup.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETNEXTVISAGROUP ( TT_ VARCHAR2, CVISAG_ VARCHAR2 )
RETURN VARCHAR2
IS
    MAXG_  NUMBER;
    CVIS_  VARCHAR2(2);
    CPRT_  NUMBER;
    CIDC_  NUMBER;
BEGIN

    CVIS_ := SUBSTR('00' || CVISAG_, -2);
    CIDC_ := (INSTR('0123456789ABCDEF',SUBSTR(CVIS_,1,1))-1)*16+
              INSTR('0123456789ABCDEF',SUBSTR(CVIS_,2,1))-1;
    BEGIN
        SELECT IDCHK INTO MAXG_ FROM CHKLIST_TTS
        WHERE TT=TT_ AND PRIORITY =
            (SELECT MAX(PRIORITY) FROM CHKLIST_TTS WHERE TT=TT_);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            MAXG_ := NULL;
    END;

    IF MAXG_ = CIDC_ THEN
        RETURN '!!';
    END IF;

    IF CIDC_ = 0 THEN
	   CPRT_ := 0;
	ELSE
	    BEGIN
            SELECT PRIORITY INTO CPRT_ FROM CHKLIST_TTS WHERE TT=TT_ AND IDCHK=CIDC_;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN '';
        END;
    END IF;

    FOR c IN (SELECT IDCHK FROM CHKLIST_TTS
              WHERE PRIORITY > CPRT_ AND
                    TT = TT_         AND
                    IDCHK <> CIDC_  ORDER BY PRIORITY)
    LOOP
        IF c.IDCHK IS NOT NULL THEN
		    CVIS_ := chk.TO_HEX(c.IDCHK);
            EXIT;
        END IF;
    END LOOP;

    RETURN SUBSTR('00' || CVIS_, -2);

END GetNextVisaGroup;
/
 show err;
 
PROMPT *** Create  grants  GETNEXTVISAGROUP ***
grant EXECUTE                                                                on GETNEXTVISAGROUP to ABS_ADMIN;
grant EXECUTE                                                                on GETNEXTVISAGROUP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETNEXTVISAGROUP to START1;
grant EXECUTE                                                                on GETNEXTVISAGROUP to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getnextvisagroup.sql =========*** E
 PROMPT ===================================================================================== 
 