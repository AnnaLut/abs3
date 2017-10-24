

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_JOB_INV_CCK_FL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_JOB_INV_CCK_FL ***

  CREATE OR REPLACE PROCEDURE BARS.P_JOB_INV_CCK_FL (p_type number, p_dat date default trunc(sysdate))
IS
-- Процедура вызова JOBа для выполнения процедуры инвентаризации ФЛ
   l_dat  date;
   g_mfo  varchar2(6);
BEGIN

  select getglobaloption('GLB-MFO') into g_mfo from dual;

  if p_type = 0 then-- ежемесячная ведомость
    -- датой формирования берем последнюю неоткрытую банковскую дату (fdat.stat = 9 или null)
     select max(fdat) into l_dat
       from fdat
      where fdat < trunc(p_dat)
        and nvl(stat,0) in (0, 9);
  elsif p_type = 1 then
    -- датой формирования берем последнюю неоткрытую банковскую дату (fdat.stat = 9 или null) в пред.месяце
     select max(fdat) into l_dat
       from fdat
      where fdat <= last_day(add_months(trunc(p_dat),-1))
        and nvl(stat,0) in (0, 9);
  end if;

  bc.subst_mfo(g_mfo);

   begin
     p_inv_cck_fl (l_dat, 1, p_type);
   end;

  bc.set_context;

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_JOB_INV_CCK_FL.sql =========*** 
PROMPT ===================================================================================== 
