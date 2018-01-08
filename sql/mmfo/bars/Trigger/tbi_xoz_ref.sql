

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_XOZ_REF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_XOZ_REF ***

  CREATE OR REPLACE TRIGGER BARS.TBI_XOZ_REF 
BEFORE INSERT ON XOZ_REF
FOR EACH ROW
 WHEN ( new.id IS NULL OR new.id = 0 ) BEGIN
  :new.ID := BARS_SQNC.GET_NEXTVAL('S_CC_DEAL');
END TBI_XOZ_REF;
/
ALTER TRIGGER BARS.TBI_XOZ_REF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_XOZ_REF.sql =========*** End ***
PROMPT ===================================================================================== 
