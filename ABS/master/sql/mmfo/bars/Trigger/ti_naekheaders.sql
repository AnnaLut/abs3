

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_NAEKHEADERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_NAEKHEADERS ***

  CREATE OR REPLACE TRIGGER BARS.TI_NAEKHEADERS before insert on naek_headers for each row
  begin
    if :new.kf is null then
      :new.kf := sys_context('bars_context','user_mfo');
    end if;
  end;




/
ALTER TRIGGER BARS.TI_NAEKHEADERS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_NAEKHEADERS.sql =========*** End 
PROMPT ===================================================================================== 
