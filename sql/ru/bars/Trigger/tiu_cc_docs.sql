

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CC_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CC_DOCS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CC_DOCS 
before insert or update of version, state on cc_docs
for each row
begin
  :new.doneby := user_name;
end;
/
ALTER TRIGGER BARS.TIU_CC_DOCS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CC_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
