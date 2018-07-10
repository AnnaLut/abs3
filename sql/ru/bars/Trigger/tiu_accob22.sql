

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOB22.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACCOB22 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACCOB22 
AFTER INSERT OR UPDATE OF OB22 ON BARS.SPECPARAM_INT
FOR EACH ROW
BEGIN
  
  if ( InStr(dbms_utility.format_call_stack(),'TAIU_ACCOUNTS_OB22') > 0 )
  then
    bars_audit.trace( $$PLSQL_UNIT ||': allowed sync OB22.' );
  else
    
    update BARS.ACCOUNTS
       set OB22 = :new.OB22
     where ACC  = :new.ACC;
    
    bars_audit.error( $$PLSQL_UNIT ||': '|| dbms_utility.format_call_stack() );
    
    -- raise_application_error( -20666, 'Заборонено вставку OB22 в табл. SPECPARAM_INT (переїхав в табл. ACCOUNTS)', true );
    
  end if;
  
end TIU_ACCOB22;
/
ALTER TRIGGER BARS.TIU_ACCOB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACCOB22.sql =========*** End ***
PROMPT ===================================================================================== 
