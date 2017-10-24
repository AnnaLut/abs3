

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_VIDD_CHECK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_VIDD_CHECK ***

  CREATE OR REPLACE TRIGGER BARS.TU_VIDD_CHECK 
after update ON BARS.CC_DEAL for each row
 WHEN (
old.vidd <> new.vidd
      ) declare
  l_cntacc_ss decimal;
  l_cntacc_sp decimal;
  l_key_mcur decimal;
  erm varchar2 (1024);
begin
  if updating then
    select count(1) into l_cntacc_ss from accounts a, nd_acc na where a.acc = na.acc and na.nd = :old.nd and a.tip = 'SS ';
    select count(1) into l_cntacc_sp from accounts a, nd_acc na where a.acc = na.acc and na.nd = :old.nd and a.tip = 'SP ';
    begin
      select count(1) into l_key_mcur from accounts a, nd_acc na where a.acc = na.acc and na.nd = :old.nd and a.tip in ('SS ','SP ') and rownum = 1 group by a.kv;
    exception
      when no_data_found then
        l_key_mcur := 0;
    end;

    if :old.vidd in (1,2,3,11,12,13) then
      if :new.vidd < :old.vidd and (l_cntacc_ss > 1 or l_cntacc_sp > 1) and l_key_mcur = 1 then
        erm := 'CCK: Не можливо кредитну лінію перевести в стандарт по КД, реф=' || :OLD.ND;
        raise_application_error(-(20000+111),'\' ||erm,TRUE);
      end if;

      if :new.vidd < :old.vidd and (l_cntacc_ss > 1 or l_cntacc_sp > 1) and l_key_mcur > 1 then
        erm := 'CCK: Не можливо мультивалютну кредитну лінію перевести в одновалютну кредитну лінію чи стандарт по КД, реф=' || :OLD.ND;
        raise_application_error(-(20000+111),'\' ||erm,TRUE);
      end if;
    end if;
  end if;
end;
/
ALTER TRIGGER BARS.TU_VIDD_CHECK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VIDD_CHECK.sql =========*** End *
PROMPT ===================================================================================== 
