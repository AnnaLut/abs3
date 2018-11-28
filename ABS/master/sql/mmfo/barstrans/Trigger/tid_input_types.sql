

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Trigger/TID_INPUT_TYPES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TID_INPUT_TYPES ***

  CREATE OR REPLACE TRIGGER BARSTRANS.TID_INPUT_TYPES 
before insert on input_types
for each row
begin
    :new.id := s_input_types.nextval;
end;
/
ALTER TRIGGER BARSTRANS.TID_INPUT_TYPES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Trigger/TID_INPUT_TYPES.sql =========**
PROMPT ===================================================================================== 

