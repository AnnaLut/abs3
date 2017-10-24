

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPDEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CPDEAL_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CPDEAL_UPDATE 
   AFTER INSERT OR UPDATE OR DELETE
   ON BARS.CP_DEAL
   FOR EACH ROW
DECLARE
   L_BANKDATE    DATE;
   L_CHGACTION   CHAR (1);
BEGIN
   SELECT TO_DATE (VAL, 'mm/dd/yyyy')
     INTO L_BANKDATE
     FROM PARAMS$BASE
    WHERE PAR = 'BANKDATE';

   IF DELETING
   THEN
      L_CHGACTION := 'D';

      INSERT INTO CP_DEAL_UPDATE (IDUPD,
                                  CHGACTION,
                                  EFFECTDATE,
                                  CHGDATE,
                                  DONEBY,
                                  ID,
                                  RYN,
                                  ACC,
                                  ACCD,
                                  ACCP,
                                  ACCR,
                                  ACCS,
                                  REF,
                                  ERAT,
                                  ACCR2,
                                  ERATE,
                                  DAZS,
                                  REF_OLD,
                                  REF_NEW,
                                  OP,
                                  DAT_UG,
                                  PF,
                                  ACTIVE,
                                  INITIAL_REF,
                                  DAT_BAY,
                                  ACCEXPN,
                                  ACCEXPR,
                                  ACCR3,
                                  ACCUNREC)
           VALUES (S_CPDEAL_UPDATE.NEXTVAL,
                   L_CHGACTION,
                   L_BANKDATE,
                   SYSDATE,
                   USER_ID,
                   :OLD.ID,
                   :OLD.RYN,
                   :OLD.ACC,
                   :OLD.ACCD,
                   :OLD.ACCP,
                   :OLD.ACCR,
                   :OLD.ACCS,
                   :OLD.REF,
                   :OLD.ERAT,
                   :OLD.ACCR2,
                   :OLD.ERATE,
                   :OLD.DAZS,
                   :OLD.REF_OLD,
                   :OLD.REF_NEW,
                   :OLD.OP,
                   :OLD.DAT_UG,
                   :OLD.PF,
                   :OLD.ACTIVE,
                   :OLD.INITIAL_REF,
                   :OLD.DAT_BAY,
                   :OLD.ACCEXPN,
                   :OLD.ACCEXPR,
                   :OLD.ACCR3,
                   :OLD.ACCUNREC);
   ELSE
      IF UPDATING
      THEN
         L_CHGACTION := 'U';
      ELSE
         L_CHGACTION := 'I';
      END IF;

      INSERT INTO CP_DEAL_UPDATE (IDUPD,
                                  CHGACTION,
                                  EFFECTDATE,
                                  CHGDATE,
                                  DONEBY,
                                  ID,
                                  RYN,
                                  ACC,
                                  ACCD,
                                  ACCP,
                                  ACCR,
                                  ACCS,
                                  REF,
                                  ERAT,
                                  ACCR2,
                                  ERATE,
                                  DAZS,
                                  REF_OLD,
                                  REF_NEW,
                                  OP,
                                  DAT_UG,
                                  PF,
                                  ACTIVE,
                                  INITIAL_REF,
                                  DAT_BAY,
                                  ACCEXPN,
                                  ACCEXPR,
                                  ACCR3,
                                  ACCUNREC)
           VALUES (S_CPDEAL_UPDATE.NEXTVAL,
                   L_CHGACTION,
                   L_BANKDATE,
                   SYSDATE,
                   USER_ID,
                   :NEW.ID,
                   :NEW.RYN,
                   :NEW.ACC,
                   :NEW.ACCD,
                   :NEW.ACCP,
                   :NEW.ACCR,
                   :NEW.ACCS,
                   :NEW.REF,
                   :NEW.ERAT,
                   :NEW.ACCR2,
                   :NEW.ERATE,
                   :NEW.DAZS,
                   :NEW.REF_OLD,
                   :NEW.REF_NEW,
                   :NEW.OP,
                   :NEW.DAT_UG,
                   :NEW.PF,
                   :NEW.ACTIVE,
                   :NEW.INITIAL_REF,
                   :NEW.DAT_BAY,
                   :NEW.ACCEXPN,
                   :NEW.ACCEXPR,
                   :NEW.ACCR3,
                   :NEW.ACCUNREC);
   END IF;
END;
/
ALTER TRIGGER BARS.TAIU_CPDEAL_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPDEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
