
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ourmfo.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OURMFO return varchar2 is
  l_mfo  banks.mfo%type;
begin
  l_mfo := gl.kf;
  if l_mfo is null then
  	raise_application_error(-20000, 'МФО банка не определено', true);
  end if;
  return l_mfo;
end; 
/
 show err;
 
PROMPT *** Create  grants  F_OURMFO ***
grant EXECUTE                                                                on F_OURMFO        to ABS_ADMIN;
grant EXECUTE                                                                on F_OURMFO        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OURMFO        to DEP_SKRN;
grant EXECUTE                                                                on F_OURMFO        to J_EXE;
grant EXECUTE                                                                on F_OURMFO        to RCC_DEAL;
grant EXECUTE                                                                on F_OURMFO        to RPBN001;
grant EXECUTE                                                                on F_OURMFO        to START1;
grant EXECUTE                                                                on F_OURMFO        to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_OURMFO        to WR_CREDIT;
grant EXECUTE                                                                on F_OURMFO        to WR_CREPORTS;
grant EXECUTE                                                                on F_OURMFO        to WR_DEPOSIT_U;
grant EXECUTE                                                                on F_OURMFO        to WR_KP;
grant EXECUTE                                                                on F_OURMFO        to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ourmfo.sql =========*** End *** =
 PROMPT ===================================================================================== 
 