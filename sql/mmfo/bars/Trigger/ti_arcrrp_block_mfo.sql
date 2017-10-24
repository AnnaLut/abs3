

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_BLOCK_MFO.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ARCRRP_BLOCK_MFO ***

  CREATE OR REPLACE TRIGGER BARS.TI_ARCRRP_BLOCK_MFO 
  AFTER INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
new.kv=980 and new.fn_a like '$A%'
      ) DECLARE
  l_mfo_b     banks.mfo%type;
BEGIN
  --
  -- ������� ������ ��� ��������� �������� �� ��������� ���
  --
  IF :new.mfob = 334970 THEN -- ���������� --
    raise_application_error(-20000, '\0977 - ���������� ���������� �� �������� ��������� ��� �����', TRUE);
  END IF;
END;


/
ALTER TRIGGER BARS.TI_ARCRRP_BLOCK_MFO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ARCRRP_BLOCK_MFO.sql =========***
PROMPT ===================================================================================== 
