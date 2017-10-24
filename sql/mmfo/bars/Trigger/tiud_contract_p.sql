

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_CONTRACT_P.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_CONTRACT_P ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_CONTRACT_P 
  AFTER INSERT OR DELETE OR UPDATE OF REF, PID, ID ON "BARS"."CONTRACT_P"
  REFERENCING FOR EACH ROW
  DECLARE
  l_impexp NUMBER;
  l_pid    NUMBER;
BEGIN

     IF :NEW.pid IS NOT NULL THEN l_pid := :NEW.pid;
  ELSIF :OLD.pid IS NOT NULL THEN l_pid := :OLD.pid;
  ELSE  RETURN;
  END IF;

  -- ��� ���������
  l_impexp := :NEW.impexp;

  -- ���� ��������-�������� �� ���������
  IF INSERTING THEN

    INSERT INTO contracts_journalN (dat, userid, action_id, impexp, pid, idp)
    VALUES (bankdate, user_id, 1, l_impexp, :NEW.pid, :NEW.idp);

  -- �������� ������� � �� (�� ������ ������������� ���-���)
  -- �������� ������� � ��������� (�����)
  -- �������� ��������� �� � ��������� (�� "������ ������������� ��������")
  ELSIF UPDATING
    AND :OLD.pid IS NULL AND :NEW.pid IS NOT NULL THEN

    INSERT INTO contracts_journalN (dat, userid, action_id, impexp, pid, idp)
    VALUES (bankdate, user_id, 1, l_impexp, :NEW.pid, :NEW.idp);

  -- ������������ ������� �� ������ ��������� � ������� (�����)
  ELSIF UPDATING
    AND :NEW.ref IS NOT NULL
    AND :OLD.pid<>:NEW.pid
    AND :OLD.pid IS NOT NULL AND :NEW.pid IS NOT NULL
    AND :OLD.id  IS NULL     AND :NEW.id IS NULL      THEN

    UPDATE contracts_journalN SET action_id=-1 WHERE idp=:NEW.idp;
    UPDATE contracts_journal  SET action_id=-1 WHERE idp=:NEW.idp;

    INSERT INTO contracts_journalN (dat, userid, action_id, impexp, pid, idp)
    VALUES (bankdate, user_id, 1, l_impexp, :NEW.pid, :NEW.idp);

  -- ������� � ����� �� ������� ������������ � �� �������
  -- ������� ��������� ������� �� ��������� � ����� �� �������
  ELSIF UPDATING
    AND :OLD.pid IS NOT NULL AND :NEW.pid IS NULL THEN

    UPDATE contracts_journalN SET action_id=-1 WHERE idp=:NEW.idp;
    UPDATE contracts_journal  SET action_id=-1 WHERE idp=:NEW.idp;

  -- ������� ������� (�������� ��������)
  ELSIF DELETING THEN

    UPDATE contracts_journalN SET action_id=-1 WHERE idp=:OLD.idp;
    UPDATE contracts_journal  SET action_id=-1 WHERE idp=:OLD.idp;

  END IF;

END tiud_contract_p;



/
ALTER TRIGGER BARS.TIUD_CONTRACT_P ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_CONTRACT_P.sql =========*** End
PROMPT ===================================================================================== 
