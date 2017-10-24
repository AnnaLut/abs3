

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SECUSERIO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SECUSERIO ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SECUSERIO 
before insert on sec_user_io
for each row
begin
    if (:new.rec_id is null) then
        select s_secuserio.nextval into :new.rec_id from dual;
	end if;
end;

/
ALTER TRIGGER BARS.TBI_SECUSERIO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SECUSERIO.sql =========*** End *
PROMPT ===================================================================================== 
