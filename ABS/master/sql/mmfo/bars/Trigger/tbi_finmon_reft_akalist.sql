

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_FINMON_REFT_AKALIST.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_FINMON_REFT_AKALIST ***

  CREATE OR REPLACE TRIGGER BARS.TBI_FINMON_REFT_AKALIST 
before insert on finmon_reft_akalist for each row
declare
  l_value   number;
begin
  select s_finmon_reft_akalist.nextval into l_value from dual;
  :new.id := l_value;
end;



/
ALTER TRIGGER BARS.TBI_FINMON_REFT_AKALIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_FINMON_REFT_AKALIST.sql ========
PROMPT ===================================================================================== 
