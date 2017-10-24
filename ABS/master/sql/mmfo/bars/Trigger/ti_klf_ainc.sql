

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KLF_AINC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KLF_AINC ***

  CREATE OR REPLACE TRIGGER BARS.TI_KLF_AINC 
before insert on kl_f00$global
for each row
declare
begin
    if (:new.id is null) then
        :new.id := s_tts.nextval;
    end if;
end;

/
ALTER TRIGGER BARS.TI_KLF_AINC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KLF_AINC.sql =========*** End ***
PROMPT ===================================================================================== 
