

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SECLOGINS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SECLOGINS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SECLOGINS 
before insert or update of secid on sec_logins
for each row
begin
   :new.secid:= upper(:new.secid);
end;
/
ALTER TRIGGER BARS.TBI_SECLOGINS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SECLOGINS.sql =========*** End *
PROMPT ===================================================================================== 
