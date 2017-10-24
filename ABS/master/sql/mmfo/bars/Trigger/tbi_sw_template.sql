

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SW_TEMPLATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SW_TEMPLATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SW_TEMPLATE 
before insert on sw_template for each row
begin
 if (:new.rec_id is null) then
     select s_sw_template.nextval into :new.rec_id from dual;
 end if;
 if (:new.user_id is null) then
     :new.user_id := bars.user_id;
 end if;
end;


/
ALTER TRIGGER BARS.TBI_SW_TEMPLATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SW_TEMPLATE.sql =========*** End
PROMPT ===================================================================================== 
