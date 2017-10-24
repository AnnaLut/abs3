

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_USERMESS_DONE_DATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_USERMESS_DONE_DATE ***

  CREATE OR REPLACE TRIGGER BARS.TU_USERMESS_DONE_DATE 
BEFORE UPDATE OF MSG_DONE	ON USER_MESSAGES_BAK FOR EACH ROW
DECLARE
  l_i  number;
BEGIN
	if (:new.MSG_DONE = 1) then
		:new.MSG_DONE_DATE := sysdate;
	else
		:new.MSG_DONE_DATE := null;
	end if;
END TU_USERMESS_DONE_DATE;
/
ALTER TRIGGER BARS.TU_USERMESS_DONE_DATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_USERMESS_DONE_DATE.sql =========*
PROMPT ===================================================================================== 
