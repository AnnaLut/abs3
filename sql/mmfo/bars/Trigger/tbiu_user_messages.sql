

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_USER_MESSAGES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_USER_MESSAGES ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_USER_MESSAGES 
BEFORE INSERT OR UPDATE OF USER_COMMENT	ON USER_MESSAGES_BAK FOR EACH ROW
DECLARE
  l_i  number;
BEGIN
  If getglobaloption('BMS')='1' and getglobaloption('RI')='1' then
    begin
      l_i := to_number(substr(:new.msg_text,2,instr(:new.msg_text,')')-2));
    exception when others then
      l_i := null;
    end;
    if l_i is not null then
       update RI_MESSAGES
       set    comm=:new.user_comment
       where  key=l_i;
    end if;
  End If;
END TBIU_USER_MESSAGES;


/
ALTER TRIGGER BARS.TBIU_USER_MESSAGES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_USER_MESSAGES.sql =========*** 
PROMPT ===================================================================================== 
