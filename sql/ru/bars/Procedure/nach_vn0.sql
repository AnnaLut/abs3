

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NACH_VN0.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NACH_VN0 ***

  CREATE OR REPLACE PROCEDURE BARS.NACH_VN0 ( p_MFO varchar2 ) is

/*  22-02-2011 Sta Уже ничего делать не надо. */

begin
  --Переключение на печать баланса по SALDOA+SALDOB(2)
  SUDA;
  UPDATE zapros set FORM_PROC= 'P_BAL( USER_ID, :sFdat1)' where kodz=15;
---- Уже ничего делать не надо. -----
  RETURN;

end NACH_VN0  ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NACH_VN0.sql =========*** End *** 
PROMPT ===================================================================================== 
