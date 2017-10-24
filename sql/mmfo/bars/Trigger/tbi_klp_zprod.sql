

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_ZPROD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KLP_ZPROD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KLP_ZPROD 
BEFORE INSERT ON KLP_ZPROD FOR EACH ROW
DECLARE
  id_ NUMBER;
BEGIN
--�������������
  IF (:NEW.ID=0 OR :NEW.ID IS NULL) THEN
    SELECT s_KLP_ZPROD.NEXTVAL INTO id_ FROM dual;
    :NEW.ID := id_;
  END IF;
-- ���� ����������� ������
   if :new.datedokkb is null then
      :new.datedokkb := sysdate;
   end if;
END;



/
ALTER TRIGGER BARS.TBI_KLP_ZPROD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_ZPROD.sql =========*** End *
PROMPT ===================================================================================== 
