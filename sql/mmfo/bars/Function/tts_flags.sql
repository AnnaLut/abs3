
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/tts_flags.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.tts_flagS (str_ VARCHAR2) RETURN varchar2_list PIPELINED IS
BEGIN
   IF str_ IS NULL THEN RETURN; END IF;
   FOR i IN 1..LENGTH(str_) LOOP
      IF SUBSTR(str_,i,1)<>'0' OR i IN (1,2,38) THEN
         PIPE ROW (SUBSTR(str_,i,1)||TO_CHAR(i-1));
      END IF;
   END LOOP;
   RETURN;
END;
 
/
 show err;
 
PROMPT *** Create  grants  tts_flagS ***
grant EXECUTE                                                                on tts_flagS       to ABS_ADMIN;
grant EXECUTE                                                                on tts_flagS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on tts_flagS       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/tts_flags.sql =========*** End *** 
 PROMPT ===================================================================================== 
 