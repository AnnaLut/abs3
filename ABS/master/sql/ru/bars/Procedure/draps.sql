

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DRAPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DRAPS ***

  CREATE OR REPLACE PROCEDURE BARS.DRAPS (dat_ DATE) IS
i smallint := 0;
BEGIN
   FOR x IN (SELECT fdat FROM fdat
              WHERE fdat BETWEEN dat_ AND gl.BDATE ORDER BY fdat) LOOP
       dbms_application_info.set_client_info ('Формування знімку DRAPS за '||to_char(x.fdat,'dd-mm-yyyy'));
       ddraps (x.fdat,i); i:= 1;
   END LOOP;
END;
/
show err;

PROMPT *** Create  grants  DRAPS ***
grant EXECUTE                                                                on DRAPS           to ABS_ADMIN;
grant EXECUTE                                                                on DRAPS           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DRAPS           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DRAPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
