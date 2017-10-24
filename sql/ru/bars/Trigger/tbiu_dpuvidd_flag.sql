

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPUVIDD_FLAG.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_DPUVIDD_FLAG ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_DPUVIDD_FLAG 
BEFORE INSERT OR UPDATE OF FLAG, TYPE_ID ON BARS.DPU_VIDD
FOR EACH ROW
FOLLOWS TBI_DPU_VIDD
DECLARE
  l_active   dpu_types.fl_active%type;
BEGIN

  l_active := to_number( trim( PUL.GET('DPU_TYPE_ACTIVE') ) );

  If (l_active is Null) then
    select fl_active
      into l_active
      from BARS.dpu_types
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

END TBIU_DPUVIDD_FLAG;
/
ALTER TRIGGER BARS.TBIU_DPUVIDD_FLAG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPUVIDD_FLAG.sql =========*** E
PROMPT ===================================================================================== 
