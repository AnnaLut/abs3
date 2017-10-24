

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Trigger/TBI_DOCIMPORT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DOCIMPORT ***

  CREATE OR REPLACE TRIGGER BARSAQ.TBI_DOCIMPORT 
before insert on doc_import for each row
begin
  if :new.userid is null then
    :new.userid := bars.user_id;
  end if;
end;



/
ALTER TRIGGER BARSAQ.TBI_DOCIMPORT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Trigger/TBI_DOCIMPORT.sql =========*** End
PROMPT ===================================================================================== 
