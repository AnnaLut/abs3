

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DOC_TEMPLATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DOC_TEMPLATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DOC_TEMPLATE 
  BEFORE INSERT ON "BARS"."DOC_TEMPLATE"
  REFERENCING FOR EACH ROW
  begin
 if (:new.template_id is null) then
     select s_doc_template.nextval into :new.template_id from dual;
 end if;
end;



/
ALTER TRIGGER BARS.TBI_DOC_TEMPLATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DOC_TEMPLATE.sql =========*** En
PROMPT ===================================================================================== 
