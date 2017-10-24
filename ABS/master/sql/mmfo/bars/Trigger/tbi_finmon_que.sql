

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_FINMON_QUE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_FINMON_QUE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_FINMON_QUE 
before insert on finmon_que
for each row
begin
 if :new.id is null then
   select bars_sqnc.get_nextval('s_finmon_que', :new.kf) into :new.id from dual;
 end if;
end;



/
ALTER TRIGGER BARS.TBI_FINMON_QUE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_FINMON_QUE.sql =========*** End 
PROMPT ===================================================================================== 
