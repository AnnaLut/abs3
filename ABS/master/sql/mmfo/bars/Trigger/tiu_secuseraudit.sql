

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SECUSERAUDIT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SECUSERAUDIT ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SECUSERAUDIT 
before insert or update on sec_useraudit for each row
begin
	:new.update_time := sysdate;
end;



/
ALTER TRIGGER BARS.TIU_SECUSERAUDIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SECUSERAUDIT.sql =========*** En
PROMPT ===================================================================================== 
