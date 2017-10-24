

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DEBREGRES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DEBREGRES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DEBREGRES 
before insert on debreg_res for each row
declare
    l_sq    integer;
begin
    select s_debreg_res.nextval
      into l_sq
      from dual;
    :new.rid := l_sq;
end;
/
ALTER TRIGGER BARS.TBI_DEBREGRES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DEBREGRES.sql =========*** End *
PROMPT ===================================================================================== 
