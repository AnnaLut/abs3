

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DRAPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DRAPS ***

  CREATE OR REPLACE PROCEDURE BARS.DRAPS 
( dat_    in     DATE
) IS
  i              number(1):= 0;
  l_prev_bnk_dt  date;
BEGIN
  l_prev_bnk_dt := DAT_NEXT_U( GL.GBD(), -1);
  FOR x IN ( select FDAT
               from FDAT
              where FDAT between dat_ and l_prev_bnk_dt
              order by FDAT )
  LOOP
    DDRAPS( x.FDAT, i );
    i:= 1;
  END LOOP;
END DRAPS;
/
show err;

PROMPT *** Create  grants  DRAPS ***
grant EXECUTE                                                                on DRAPS           to ABS_ADMIN;
grant EXECUTE                                                                on DRAPS           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DRAPS           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DRAPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
