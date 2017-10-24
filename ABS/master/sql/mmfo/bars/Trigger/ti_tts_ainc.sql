

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_TTS_AINC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_TTS_AINC ***

  CREATE OR REPLACE TRIGGER BARS.TI_TTS_AINC 
before insert on tts
for each row
declare
begin
    if (:new.id is null) then
        :new.id := s_tts.nextval;
    end if;
end;

/
ALTER TRIGGER BARS.TI_TTS_AINC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_TTS_AINC.sql =========*** End ***
PROMPT ===================================================================================== 
