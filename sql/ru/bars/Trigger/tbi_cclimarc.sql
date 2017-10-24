

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CCLIMARC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CCLIMARC ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CCLIMARC 
      BEFORE INSERT ON BARS.CC_LIM_ARC FOR EACH ROW
 WHEN (
NEW.MDAT IS NULL
      ) BEGIN
 :NEW.MDAT := gl.bdate;
END tbi_CCLIMARC ;
/
ALTER TRIGGER BARS.TBI_CCLIMARC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CCLIMARC.sql =========*** End **
PROMPT ===================================================================================== 
