

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CC_DEAL_BRANCH.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CC_DEAL_BRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CC_DEAL_BRANCH before insert or update
  ON BARS.CC_DEAL for each row
DECLARE
begin


  if length(:NEW.BRANCH)=8 then
     :NEW.BRANCH:=:NEW.BRANCH||'000000/';
  end if;
  if inserting and (trim(:NEW.cc_id)='0' or :NEW.cc_id is null) then
     :NEW.cc_id:=:NEW.nd;
  end if;

end tiu_cc_DEAL_BRANCH;



/
ALTER TRIGGER BARS.TIU_CC_DEAL_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CC_DEAL_BRANCH.sql =========*** 
PROMPT ===================================================================================== 
