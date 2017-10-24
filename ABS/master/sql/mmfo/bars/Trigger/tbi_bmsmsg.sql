

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BMSMSG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BMSMSG ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BMSMSG 
before insert on bms_msg
for each row
declare
  l_code number;
begin
  if :new.code is null then
     select s_bmsmsg.nextval into l_code from dual;
     :new.code := 'CODE_'||to_char(l_code);
  end if;
end;


/
ALTER TRIGGER BARS.TBI_BMSMSG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BMSMSG.sql =========*** End *** 
PROMPT ===================================================================================== 
