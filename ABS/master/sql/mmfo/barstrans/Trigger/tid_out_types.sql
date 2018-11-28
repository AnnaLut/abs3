

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Trigger/TID_OUT_TYPES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TID_OUT_TYPES ***

  CREATE OR REPLACE TRIGGER BARSTRANS.TID_OUT_TYPES 
before insert on out_types
for each row
begin
    :new.id := s_out_types.nextval;
end;
/
ALTER TRIGGER BARSTRANS.TID_OUT_TYPES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Trigger/TID_OUT_TYPES.sql =========*** 
PROMPT ===================================================================================== 

