

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_RKOLST_ND.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_RKOLST_ND ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_RKOLST_ND 
before insert or update ON BARS.RKO_LST
for each row
 WHEN ( new.ACC1 Is Not Null ) begin

  IF INSERTING OR
     UPDATING AND ( :old.ACC1 Is Null OR :old.ACC1 <> :new.ACC1 )
  THEN
    :new.ND := BARS.GET_RKO_DEAL_ND(:NEW.ACC1);
  END IF;

end TBIU_RKOLST_ND;
/
ALTER TRIGGER BARS.TBIU_RKOLST_ND ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_RKOLST_ND.sql =========*** End 
PROMPT ===================================================================================== 
