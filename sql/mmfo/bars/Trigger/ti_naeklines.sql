

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_NAEKLINES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_NAEKLINES ***

  CREATE OR REPLACE TRIGGER BARS.TI_NAEKLINES before insert on naek_lines for each row
  begin
    if :new.kf is null then
      :new.kf := sys_context('bars_context','user_mfo');
    end if;
  end;




/
ALTER TRIGGER BARS.TI_NAEKLINES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_NAEKLINES.sql =========*** End **
PROMPT ===================================================================================== 
