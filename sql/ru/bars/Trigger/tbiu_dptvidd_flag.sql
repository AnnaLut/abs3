

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPTVIDD_FLAG.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_DPTVIDD_FLAG ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_DPTVIDD_FLAG 
BEFORE INSERT OR UPDATE OF FLAG, TYPE_ID ON BARS.DPT_VIDD
FOR EACH ROW
FOLLOWS TBI_DPT_VIDD
DECLARE
  l_active   dpt_types.fl_active%type;
BEGIN

  l_active := to_number( trim( PUL.GET('DPT_TYPE_ACTIVE') ) );

  If (l_active is Null) then
    select fl_active
      into l_active
      from dpt_types
     where type_id = :new.type_id;
  End If;

  -- якщо ативується вид для неактивного типу (продукту)
  If ((:new.type_id  = :old.type_id) AND (:new.flag > l_active)) Then
     raise_application_error( -20911, 'Заборонено активувати вид який належить недіючому продукту!', True );
  End If;

  -- якщо змінюється підпорядкування виду договору
  If ((:new.type_id <> :old.type_id) AND (:new.flag > l_active)) Then
    :new.flag := l_active;
  End If;

  -- технічний вид вкладу
  If ((:new.vidd < 0) AND (:new.flag = 1)) Then
    -- 'Активация технического вида вклада запрещена!'
    bars_error.raise_error('DPT', 130);
  End If;

END TBIU_DPTVIDD_FLAG;
/
ALTER TRIGGER BARS.TBIU_DPTVIDD_FLAG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPTVIDD_FLAG.sql =========*** E
PROMPT ===================================================================================== 
