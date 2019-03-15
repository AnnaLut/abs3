

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SPS_UNION.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SPS_UNION ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SPS_UNION 
BEFORE INSERT ON BARS.SPS_UNION FOR EACH ROW
 WHEN (NEW.UNION_ID IS NULL) BEGIN
  :NEW.UNION_ID := S_SPS_UNION.NEXTVAL;
END;

/
ALTER TRIGGER BARS.TBI_SPS_UNION ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SPS_UNION.sql =========*** End *
PROMPT ===================================================================================== 
