

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKAND_SOS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SKRYNKAND_SOS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SKRYNKAND_SOS 
before insert or update of sos on skrynka_nd for each row
begin
	if inserting then
		:new.deal_created := bankdate;
	elsif updating then
		if :new.sos != :old.sos and :new.deal_created is null then
			:new.deal_created := bankdate;
		end if;
	end if;
end;
/
ALTER TRIGGER BARS.TIU_SKRYNKAND_SOS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKAND_SOS.sql =========*** E
PROMPT ===================================================================================== 
