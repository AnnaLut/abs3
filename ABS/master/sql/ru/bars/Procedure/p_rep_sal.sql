

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REP_SAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REP_SAL ***

  CREATE OR REPLACE PROCEDURE BARS.P_REP_SAL (
  p_nlsmask varchar2,
  p_branch  varchar2,
  p_dat date)
is
begin
/*
   24.03.2010   Заявка 14/2-01/348
   Для 43 отчета предоставляем возможность задания маски длиной <4
   заодно и для других сальдовок, которые исп. эту процедуру
*/
  bars_report.validate_nlsmask(p_nlsmask,1);
  if p_branch is null then
     bars_error.raise_nerror('REP', 'BRANCH_IS_NULL');
  end if;
  if p_dat is not null then
     bars_accm_sync.sync_snap('BALANCE', p_dat);
  end if;
end;
/
show err;

PROMPT *** Create  grants  P_REP_SAL ***
grant EXECUTE                                                                on P_REP_SAL       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REP_SAL       to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REP_SAL.sql =========*** End ***
PROMPT ===================================================================================== 
