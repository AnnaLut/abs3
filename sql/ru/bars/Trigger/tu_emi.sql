

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_EMI.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_EMI ***

  CREATE OR REPLACE TRIGGER BARS.TU_EMI 
  BEFORE INSERT OR UPDATE OF RNK ON "BARS"."CP_KOD"
  REFERENCING FOR EACH ROW
 WHEN (
NEW.RNK<>OLD.RNK OR OLD.RNK IS NULL
      ) DECLARE
 NMK_ VARCHAR2(70);

BEGIN
   BEGIN
      SELECT NMK INTO NMK_ FROM CUSTOMER WHERE RNK=:NEW.RNK;
      :NEW.NAME:=NMK_;
    --  UPDATE CP_KOD SET NAME=NMK_ WHERE ID=:NEW.ID;
   EXCEPTION WHEN NO_DATA_FOUND THEN NMK_:='';
   END;

END TU_EMI;
/
ALTER TRIGGER BARS.TU_EMI ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_EMI.sql =========*** End *** ====
PROMPT ===================================================================================== 
