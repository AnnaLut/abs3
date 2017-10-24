

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TUD_T902_KB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TUD_T902_KB ***

  CREATE OR REPLACE TRIGGER BARS.TUD_T902_KB 
after update or delete on t902 for each row
begin
  pul.rck_hq := :old.rec;
end;




/
ALTER TRIGGER BARS.TUD_T902_KB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TUD_T902_KB.sql =========*** End ***
PROMPT ===================================================================================== 
