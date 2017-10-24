

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_BALANCE_CHANGES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACC_BALANCE_CHANGES ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACC_BALANCE_CHANGES 
AFTER DELETE ON ACC_BALANCE_CHANGES FOR EACH ROW
DECLARE
   ID    NUMBER;

BEGIN

INSERT INTO ACC_BALANCE_CHANGES_UPDATE (ACC, CHANGE_TIME, DOS_DELTA, ID, KOS_DELTA, NLSB, OSTC, REF, RNK, TT, NLSA )
VALUES (:OLD.ACC,:OLD.CHANGE_TIME, :OLD.DOS_DELTA, :OLD.ID, :OLD.KOS_DELTA, :OLD.NLSB,
:OLD.OSTC, :OLD.REF, :OLD.RNK, :OLD.TT , :OLD.NLSA );
exception when others then
  if sqlcode = -955 then null; end if;

END TIU_ACC_BALANCE_CHANGES;
/
ALTER TRIGGER BARS.TIU_ACC_BALANCE_CHANGES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_BALANCE_CHANGES.sql ========
PROMPT ===================================================================================== 
