

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SET_FDAT_STATUS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SET_FDAT_STATUS ***

  CREATE OR REPLACE PROCEDURE BARS.P_SET_FDAT_STATUS (p_fdat date, p_stat number)
is
begin
update fdat set stat=case p_stat when 1 then 9 when 0 then 0 else -1 end
where fdat=p_fdat;
end;
/
show err;

PROMPT *** Create  grants  P_SET_FDAT_STATUS ***
grant EXECUTE                                                                on P_SET_FDAT_STATUS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_FDAT_STATUS.sql =========***
PROMPT ===================================================================================== 
