

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_TAMOZHDOC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_TAMOZHDOC ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_TAMOZHDOC 
  AFTER INSERT OR DELETE OR UPDATE OF PID, ID, IDR ON "BARS"."TAMOZHDOC"
  REFERENCING FOR EACH ROW
  DECLARE
  l_impexp NUMBER;
  l_pid    NUMBER;
BEGIN

  IF UPDATING AND :OLD.id IS NOT NULL AND :NEW.id IS NULL THEN
    l_pid := :OLD.pid;
  ELSE
    l_pid := :NEW.pid;
  END IF;

  -- Тип контракта
  l_impexp := :NEW.impexp;

  -- Авансовые ТД по контракту / Прием ТД из MC* в аванс по клиенту
  IF INSERTING THEN

    INSERT INTO contracts_journalN (dat, userid, action_id, impexp, pid, idt)
    VALUES (bankdate,USER_ID, 1, l_impexp, :NEW.pid, :NEW.idt);

  -- Привязка авансовой ТД (по клиенту) к контракту/платежу
  ELSIF UPDATING AND (
        :OLD.idr IS NULL AND :NEW.idr IS NOT NULL
     OR
        :OLD.pid IS NULL AND :NEW.pid IS NOT NULL AND
        :OLD.id  IS NULL AND :NEW.id  IS NOT NULL     ) THEN

    DELETE FROM contracts_journalN
    WHERE dat = bankdate AND impexp = l_impexp AND idt = :NEW.idt;

    INSERT INTO contracts_journalN (dat, userid, action_id, impexp, pid, idt)
    VALUES (bankdate, USER_ID, 1, l_impexp, :NEW.pid, :NEW.idt);

  -- Отвязка ТД от контракта в аванс по клиенту
  ELSIF UPDATING
    AND :OLD.pid IS NOT NULL AND :NEW.pid IS NULL
    AND :OLD.id  IS NOT NULL AND :NEW.id  IS NULL THEN

    UPDATE contracts_journalN SET action_id = -1 WHERE idt = :NEW.idt;
    UPDATE contracts_journal  SET action_id = -1 WHERE idt = :NEW.idt;

  -- Удаление ТД
  ELSIF DELETING THEN

    UPDATE contracts_journalN SET action_id = -1 WHERE idt = :OLD.idt;
    UPDATE contracts_journal  SET action_id = -1 WHERE idt = :OLD.idt;

  END IF;

END tiud_tamozhdoc;



/
ALTER TRIGGER BARS.TIUD_TAMOZHDOC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_TAMOZHDOC.sql =========*** End 
PROMPT ===================================================================================== 
