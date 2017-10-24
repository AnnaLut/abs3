

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_REFAPP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_REFAPP ***

  CREATE OR REPLACE TRIGGER BARS.TBU_REFAPP 
before update on refapp for each row
begin
  if :new.acode  = '1' then
     :new.acode := 'RW';
  elsif :new.acode  = '0' then
     :new.acode := 'RO';
  end if;
end;
/
ALTER TRIGGER BARS.TBU_REFAPP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_REFAPP.sql =========*** End *** 
PROMPT ===================================================================================== 
