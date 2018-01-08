

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_W4ACC_DATCLOSE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_W4ACC_DATCLOSE ***

  CREATE OR REPLACE TRIGGER BARS.TBU_W4ACC_DATCLOSE BEFORE UPDATE OF "DAT_CLOSE" ON "BARS"."W4_ACC" FOR EACH ROW 
  WHEN ( old.DAT_CLOSE is Null AND new.DAT_CLOSE is Not Null ) declare
  l_qty pls_integer;
begin

  select count(1)
    into l_qty -- к-ть незакритих рахунків по договору
    from BARS.ACCOUNTS
   where ACC in  ( :new.ACC_PK,    :new.ACC_9129, :new.ACC_OVR,   :new.ACC_2203,
                   :new.ACC_2207,  :new.ACC_2208, :new.ACC_2209,  :new.ACC_2625D,
                   :new.ACC_2625X, :new.ACC_2627, :new.ACC_2627X, :new.ACC_2628,
                   :new.ACC_3570,  :new.ACC_3579 )
     and DAZS is Null;

  if ( l_qty > 0 )
  then
    raise_application_error( -20444, 'Заборонено закриття договору БПК (наявні незакриті рахунки)!', true );
  else
    null;
  end if;

end TBU_W4ACC_DATCLOSE;



/
ALTER TRIGGER BARS.TBU_W4ACC_DATCLOSE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_W4ACC_DATCLOSE.sql =========*** 
PROMPT ===================================================================================== 
