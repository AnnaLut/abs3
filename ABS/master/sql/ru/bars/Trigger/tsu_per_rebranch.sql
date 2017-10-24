

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TSU_PER_REBRANCH.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TSU_PER_REBRANCH ***

  CREATE OR REPLACE TRIGGER BARS.TSU_PER_REBRANCH 
INSTEAD OF UPDATE OR DELETE ON BARS.PER_rebranch FOR EACH ROW
DECLARE
  sos_ NUMBER;
BEGIN
   null;
END;
/
ALTER TRIGGER BARS.TSU_PER_REBRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TSU_PER_REBRANCH.sql =========*** En
PROMPT ===================================================================================== 
