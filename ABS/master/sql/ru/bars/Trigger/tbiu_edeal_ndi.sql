

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_EDEAL_NDI.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_EDEAL_NDI ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_EDEAL_NDI 
before insert or update ON BARS.E_DEAL$BASE
for each row
begin
  
  IF INSERTING 
  THEN
    
    IF ( :new.ND Is Null OR :NEW.ND = 0 )
    THEN
      :new.ND := S_CC_DEAL.NextVal;
    END IF;
    
    IF ( :new.ACC36 Is Not Null )
    THEN
      :new.NDI := coalesce(BARS.GET_E_DEAL_ND(:NEW.ACC36), :new.ND);
    END IF;
    
  END IF;
  
  IF UPDATING AND ( :new.ACC36 Is Not Null )
              AND ( :old.ACC36 Is Null OR :old.ACC36 <> :new.ACC36 )
  THEN
    :new.NDI := coalesce(BARS.GET_E_DEAL_ND(:NEW.ACC36), :new.ND);
  END IF;
  
end TBIU_EDEAL_NDI;
/
ALTER TRIGGER BARS.TBIU_EDEAL_NDI ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_EDEAL_NDI.sql =========*** End 
PROMPT ===================================================================================== 
