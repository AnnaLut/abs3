

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/DPT_TBI_SERVICE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger DPT_TBI_SERVICE ***

  CREATE OR REPLACE TRIGGER BARS.DPT_TBI_SERVICE 
  BEFORE INSERT ON "BARS"."DPT_SERVICE"
  REFERENCING FOR EACH ROW
  begin
   select
         dpt_s_service.nextval
   into
        :new.serv_id
   from dual;
end;



/
ALTER TRIGGER BARS.DPT_TBI_SERVICE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/DPT_TBI_SERVICE.sql =========*** End
PROMPT ===================================================================================== 
