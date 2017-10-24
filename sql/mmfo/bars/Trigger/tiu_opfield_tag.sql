

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_OPFIELD_TAG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_OPFIELD_TAG ***

  CREATE OR REPLACE TRIGGER BARS.TIU_OPFIELD_TAG 
before insert or update of tag on bars.op_field for each row
begin
  if :new.tag like '%$%' then
      bars_error.raise_nerror('DOC', 'INCORRECT_TAG',:new.tag);
  end if;
end;




/
ALTER TRIGGER BARS.TIU_OPFIELD_TAG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_OPFIELD_TAG.sql =========*** End
PROMPT ===================================================================================== 
