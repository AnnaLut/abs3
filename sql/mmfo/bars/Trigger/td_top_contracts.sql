

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_TOP_CONTRACTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_TOP_CONTRACTS ***

  CREATE OR REPLACE TRIGGER BARS.TD_TOP_CONTRACTS 
  BEFORE DELETE ON "BARS"."TOP_CONTRACTS"
  REFERENCING FOR EACH ROW
  begin

  -- ������� �������������
  delete from contracts where pid = :old.pid;

  -- ������� �������� ��
  delete from tamozhdoc_reestr where pid = :old.pid;

  -- ������� ������ �� ������� ������
  update zayavka
     set pid = to_number(null)
   where pid = :old.pid;

end;



/
ALTER TRIGGER BARS.TD_TOP_CONTRACTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_TOP_CONTRACTS.sql =========*** En
PROMPT ===================================================================================== 
