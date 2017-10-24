CREATE OR REPLACE FORCE VIEW BARS.V_CORR_ACC
(
   KV,
   LCV,
   NLS,
   BIC,
   NAME,
   ACC,
   NLS3739,
   TRANSIT_ACC,
   THEIR_ACC
)
AS
   SELECT an.KV,
          t.LCV,
          an.NLS,
          bic_acc.BIC,
          s.NAME,
          bic_acc.ACC,
          at.NLS nls3739,
          bic_acc.TRANSIT TRANSIT_ACC,
          bic_acc.THEIR_ACC
     FROM accounts an,
          accounts at,
          tabval t,
          bic_acc,
          sw_banks s
    WHERE     an.acc = bic_acc.acc
          AND an.kv = t.kv
          AND bic_acc.BIC = s.BIC
          AND at.acc(+) = bic_acc.TRANSIT;
grant select, insert, update, delete on V_CORR_ACC to bars_access_defrole
/
CREATE OR REPLACE TRIGGER TIUD_V_CORR_ACC
INSTEAD OF INSERT OR UPDATE OR DELETE ON BARS.V_CORR_ACC
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    INSERT INTO bic_acc (BIC,ACC,TRANSIT,THEIR_ACC ) VALUES 
    (:NEW.BIC,:NEW.ACC,:NEW.TRANSIT_ACC,:NEW.THEIR_ACC);
  ELSIF UPDATING THEN
    raise_application_error(-20000, 'Видаліть рядок та вставте новий!');
  ELSIF DELETING THEN
    DELETE FROM bic_acc WHERE ACC=:OLD.ACC and bic= :OLD.BIC;
  END IF;
END;
/