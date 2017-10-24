

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SNP_SALDOA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SNP_SALDOA ***

  CREATE OR REPLACE PROCEDURE BARS.SNP_SALDOA (p_mode varchar2 )is

  --1 = ACCM_SNAP_BALANCES
  --    из SALDOA (по-старому) установить на ACCM_SNAP_BALANCES (по-новому)
  --2 = SALDOA+SALDOB
  --    из ACCM_SNAP_BALANCES (по-новому) вернуть  на  SALDOA (по-старому)
begin

  if p_mode = '1' then

     --31 отчет
     UPDATE zapros
        set FORM_PROC= 'P_BAL_SNP( 0, to_date (:sFdat1,''dd-mm-yyyy''),'''' ,'''', '''' )'
      where kodz=15;

     --#01
   --  update REP_PROC set name     = 'P_F01_SNP' where procc = 2;

     -- сальдовка
     update reports set param='125,3,sFdat,sFdat,"",TRUE,FALSE' where id=125;

     --#02
  --   update REP_PROC set name     = 'P_F02_SNP' where procc = 3;

     commit;

  Elsif p_mode = '2' then

     --31 отчет
     UPDATE zapros   set FORM_PROC= 'P_BAL( USER_ID, :sFdat1)' where kodz=15;

     --#01
  --   update REP_PROC set name     = 'P_F01_NG' where procc = 2;

     -- сальдовка
     update reports set param='2381,3,sFdat,sFdat,"",TRUE,FALSE' where id=125;

     --#02
 --    update REP_PROC set name     = 'P_F02_NG' where procc = 3;

  end if;

end  SNP_SALDOA;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SNP_SALDOA.sql =========*** End **
PROMPT ===================================================================================== 
