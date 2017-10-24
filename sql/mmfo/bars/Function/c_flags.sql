
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/c_flags.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.C_FLAGS ( tt_ VARCHAR2)
RETURN VARCHAR2 IS
  flags_ VARCHAR2(64);
BEGIN
  flags_ := RPAD('0',64,'0');

  FOR f IN (SELECT fcode,value
              FROM tts_flags
             WHERE tt=tt_ AND fcode BETWEEN 0 AND 63) LOOP

     IF f.fcode=0 THEN
        flags_ := TO_CHAR(NVL(f.value,0))||SUBSTR(flags_,f.fcode+2);
     ELSIF f.fcode=63 THEN
        flags_ := SUBSTR(flags_,1,f.fcode)||TO_CHAR(NVL(f.value,0));
     ELSE
        flags_ := SUBSTR(flags_,1,f.fcode)||TO_CHAR(NVL(f.value,0))||
                  SUBSTR(flags_,f.fcode+2);
     END IF;

  END LOOP;

  RETURN flags_;
END C_FLAGS;

 
/
 show err;
 
PROMPT *** Create  grants  C_FLAGS ***
grant EXECUTE                                                                on C_FLAGS         to ABS_ADMIN;
grant EXECUTE                                                                on C_FLAGS         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on C_FLAGS         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/c_flags.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 