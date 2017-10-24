

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_LINESP_ID.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_LINESP_ID ***

  CREATE OR REPLACE TRIGGER BARS.TBI_LINESP_ID 
before insert on lines_p for each row
declare
  l_id number;
begin
  select s_linesp.nextval into l_id from dual;
  :new.id := l_id;
end;



/
ALTER TRIGGER BARS.TBI_LINESP_ID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_LINESP_ID.sql =========*** End *
PROMPT ===================================================================================== 
