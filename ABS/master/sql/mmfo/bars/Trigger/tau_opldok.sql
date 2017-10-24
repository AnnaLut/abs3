

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPLDOK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPLDOK ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPLDOK 
  AFTER UPDATE ON "BARS"."OPLDOK"
  REFERENCING FOR EACH ROW
    WHEN (
old.otm<>new.otm
      ) declare
    l_msg    varchar2(4000);
  begin
-- ������������ ������ � ������ ������
-- �� ���������� opldok.otm
  if  updating then
          l_msg:='���i�� � opldok.otm �����'||
                   'OTM  = '||:old.OTM||' �� '||:new.OTM||
                   ' ��� ref= '||:old.REF||' stmt= '||:old.STMT;
  end if;
  bars_audit.info(l_msg);
end;


/
ALTER TRIGGER BARS.TAU_OPLDOK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPLDOK.sql =========*** End *** 
PROMPT ===================================================================================== 
