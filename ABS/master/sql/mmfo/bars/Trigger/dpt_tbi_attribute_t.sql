

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/DPT_TBI_ATTRIBUTE_T.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger DPT_TBI_ATTRIBUTE_T ***

  CREATE OR REPLACE TRIGGER BARS.DPT_TBI_ATTRIBUTE_T 
  BEFORE INSERT ON "BARS"."DPT_ATTRIBUTE_T"
  REFERENCING FOR EACH ROW
  begin
 select dpt_s_attribute_t.nextval
 into  :new.attr_id
 from dual;
end;



/
ALTER TRIGGER BARS.DPT_TBI_ATTRIBUTE_T ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/DPT_TBI_ATTRIBUTE_T.sql =========***
PROMPT ===================================================================================== 
