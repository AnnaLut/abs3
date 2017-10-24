

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPUVIDD_FLAG.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_DPUVIDD_FLAG ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_DPUVIDD_FLAG 
BEFORE INSERT OR UPDATE OF FLAG, TYPE_ID
ON BARS.DPU_VIDD
FOR EACH ROW
FOLLOWS TBI_DPU_VIDD
DECLARE
  l_active   dpu_types.fl_active%type;
BEGIN

  l_active := to_number( trim( PUL.GET('DPU_TYPE_ACTIVE') ) );

  If (l_active is Null)
  then

    begin
      select FL_ACTIVE
        into l_active
        from BARS.DPU_TYPES
       where TYPE_ID = :new.type_id;
    exception
      when NO_DATA_FOUND then
        l_active := 0;
        bars_audit.error( $$PLSQL_UNIT||': Not found TYPE_ID='||to_char(:new.TYPE_ID) );
    end;

  End If;

  -- якщо ативується вид для неактивного типу (продукту)
  If ((:new.TYPE_ID = :old.TYPE_ID) AND (:new.flag > l_active))
  Then
    raise_application_error( -20911, 'Заборонено активувати вид який належить недіючому продукту!', True );
  End If;

  -- якщо змінюється підпорядкування виду договору
  If ((:new.type_id <> :old.type_id) AND (:new.flag > l_active))
  Then
    :new.flag := l_active;
  End If;

END TBIU_DPUVIDD_FLAG;
/
ALTER TRIGGER BARS.TBIU_DPUVIDD_FLAG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPUVIDD_FLAG.sql =========*** E
PROMPT ===================================================================================== 
