

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/KLP_ID.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger KLP_ID ***

  CREATE OR REPLACE TRIGGER BARS.KLP_ID 
before insert on klp
for each row
declare
  bars  number;
begin
  select s_klp.nextval
  into   bars
  from   dual;
  :new.id := bars;
--:new.daval  := null;
--:new.noauto := '1';
end;
/
ALTER TRIGGER BARS.KLP_ID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/KLP_ID.sql =========*** End *** ====
PROMPT ===================================================================================== 
