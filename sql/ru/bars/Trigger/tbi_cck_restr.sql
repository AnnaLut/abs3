

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CCK_RESTR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CCK_RESTR ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CCK_RESTR 
before insert ON BARS.CCK_RESTR
for each row
begin
    if (:NEW.restr_id is null) then
        select S_CCK_RESTR.NEXTVAL into :NEW.restr_id from dual;
    end if;
end;
/
ALTER TRIGGER BARS.TBI_CCK_RESTR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CCK_RESTR.sql =========*** End *
PROMPT ===================================================================================== 
