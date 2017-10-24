

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFTTS_015.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STAFFTTS_015 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STAFFTTS_015 
   BEFORE INSERT  ON staff_tts
   FOR EACH ROW
DECLARE
   l_id1    tts.tt%TYPE;
  -- l_id2   NUMBER;
BEGIN
   l_id1 := '015';
   --�������� ������ �������� ������������� ���, �� ����������� �� ��� ���
   IF (:new.tt in ('012', '013', '015', '215','315','515' ))
      AND f_check_staff_015 (:new.id) = 1
   THEN
      raise_application_error (
         -20000,
         '��������! �������� '||:new.tt||' �������� ����� ��� 1 �� 2 ����!!!');
   END IF;
END;
/
ALTER TRIGGER BARS.TBI_STAFFTTS_015 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFTTS_015.sql =========*** En
PROMPT ===================================================================================== 
