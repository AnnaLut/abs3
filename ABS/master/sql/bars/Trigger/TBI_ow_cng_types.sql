

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OW_CNG_TYPES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OW_CNG_TYPES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OW_CNG_TYPES 
  before insert on BARS.ow_cng_types
  for each row
  begin
   select bars_sqnc.get_nextval('S_OW_CNG_TYPES') into :new.id from dual;
end;
/
ALTER TRIGGER BARS.TBI_OW_CNG_TYPES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OW_CNG_TYPES.sql =========*** En
PROMPT ===================================================================================== 
