

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REV.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REV ***

  CREATE OR REPLACE PROCEDURE BARS.P_REV (kv_ int, dat_ DATE  DEFAULT gl.BDATE) IS

begin
   declare
   x  SMALLINT :=0;
   begin
     if kv_=840 then
       select 1 into x from params where par='SNAP_ALG' AND val='ALGORITMIK';
       bars_accm_snap.snap_balance( DAT_, 0);
     else
       return;
     end if;
   exception when no_data_found then
       --p_rev_OB ( DAT_);
       null;
   end;
end p_rev;
/
show err;

PROMPT *** Create  grants  P_REV ***
grant EXECUTE                                                                on P_REV           to ABS_ADMIN;
grant EXECUTE                                                                on P_REV           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REV           to RPBN001;
grant EXECUTE                                                                on P_REV           to TECH005;
grant EXECUTE                                                                on P_REV           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REV.sql =========*** End *** ===
PROMPT ===================================================================================== 
