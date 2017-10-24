

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/T_IOF_USER_MESSAGES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger T_IOF_USER_MESSAGES ***

  CREATE OR REPLACE TRIGGER BARS.T_IOF_USER_MESSAGES 
instead of insert or update or delete
on user_messages
declare
begin
    if (inserting) then
        raise_application_error(-20000, 'Пряма вставка повідомлень зоборонена - використовуйте пакет BMS');
    elsif (deleting) then
        raise_application_error(-20000, 'Пряме видалення повідомлень зоборонено - використовуйте пакет BMS');
    elsif (updating) then
        if (:new.msg_done = 1 and :old.msg_done = 0) then
            bms.done_msg(:new.msg_id, :new.user_comment);
        else
            raise_application_error(-20000, 'Пряма модифікація повідомлень заборонена - використовуйте пакет BMS');
        end if;
    end if;
end;
/
ALTER TRIGGER BARS.T_IOF_USER_MESSAGES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/T_IOF_USER_MESSAGES.sql =========***
PROMPT ===================================================================================== 
