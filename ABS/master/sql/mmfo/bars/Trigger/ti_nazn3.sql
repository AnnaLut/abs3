

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN3.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_NAZN3 ***

  CREATE OR REPLACE TRIGGER BARS.TI_NAZN3 
  BEFORE INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
SUBSTR(NEW.fn_a,2,1)='A'
       AND ( (NEW.MFOB='300249' AND NEW.NLSB='260070409100') OR
             (NEW.MFOB='386241') )
      ) DECLARE
-- 1) �������� ���������� ������� ��� ������ ���������� ���������� ��������
--    ��� 300249, � ����� 260070409100
-- 2) ������ ����������� �������� �� ��� 386241
--    (������������ ������ "��� ����")
   ern  CONSTANT POSITIVE := 338; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80);
BEGIN

   IF :NEW.mfob = '386241' THEN
      erm := '0904 - ������ �� ������ ����� � ���������';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;

   IF :NEW.nazn NOT LIKE '/=___ __ __ ______ __ %=/'
   OR INSTR(:NEW.nazn,'���')=0 THEN
      erm := '0614 - ������� ����������� ������� ��� ��������';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;

END;


/
ALTER TRIGGER BARS.TI_NAZN3 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN3.sql =========*** End *** ==
PROMPT ===================================================================================== 
