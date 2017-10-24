

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCSMSPHONES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCSMSPHONES ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ACCSMSPHONES 
after insert or update on acc_sms_phones for each row
begin
    if not(:new.phone<>:new.phone1 and :new.phone<>:new.phone2 and :new.phone1<>:new.phone2) then
        raise_application_error(-20000, 'Номера основного та додаткових мобільних телефонів повинні відрізнятися', true);
    end if;
end taiu_accsmsphones;
/
ALTER TRIGGER BARS.TAIU_ACCSMSPHONES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCSMSPHONES.sql =========*** E
PROMPT ===================================================================================== 
