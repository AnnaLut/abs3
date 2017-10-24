

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TID_CC_ACCP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TID_CC_ACCP ***

  CREATE OR REPLACE TRIGGER BARS.TID_CC_ACCP 
  AFTER INSERT OR DELETE ON "BARS"."CC_ACCP"
  REFERENCING FOR EACH ROW
BEGIN
  IF INSERTING THEN
     INSERT INTO CC_ACCP_ARC (ACC,ACCS,ND, DATI ) VALUES
     ( :NEW.ACC, :NEW.ACCS, :NEW.ND,GL.BDATE );
  ELSE
     UPDATE CC_ACCP_ARC SET DATD = GL.BDATE
     WHERE ND=:OLD.ND AND ACC=:OLD.ACC AND ACCS = :OLD.ACCS AND DATD IS NULL;
  END IF;
END TID_CC_ACCP;
/
ALTER TRIGGER BARS.TID_CC_ACCP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TID_CC_ACCP.sql =========*** End ***
PROMPT ===================================================================================== 
