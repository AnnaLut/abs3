

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTS_OB22.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_ACCOUNTS_OB22 ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_ACCOUNTS_OB22 
AFTER INSERT OR UPDATE OF OB22 ON BARS.ACCOUNTS
-- Version 1.2 09.11.2016 BAA (репликація OB22 в SPECPARAM_INT)
FOR EACH ROW
DECLARE
  e_deadlock  exception;
  pragma exception_init( e_deadlock, -00060 );
  l_stack     varchar2(2000);
BEGIN
  
  l_stack := dbms_utility.format_call_stack();
  
  if ( InStr(l_stack,'TIU_ACCOB22') > 0 )
  then
    null;
  else
    
    begin
      
      update BARS.SPECPARAM_INT
         set OB22 = :new.OB22
       where ACC  = :new.ACC;
      
      if (sql%rowcount = 0)
      then
        insert into BARS.SPECPARAM_INT
          ( KF, ACC, OB22 )
        values
          ( :new.KF, :new.ACC, :new.OB22 );
      end if;
      
    exception
      when e_deadlock then
        -- фіксуємо хто ініціатор 
        bars_audit.error( $$PLSQL_UNIT || ':ACC=' || to_char(:new.ACC)
                                       || CHR(10) || l_stack );
    end;
    
  end if;
  
END TAIU_ACCOUNTS_OB22;
/
ALTER TRIGGER BARS.TAIU_ACCOUNTS_OB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_ACCOUNTS_OB22.sql =========*** 
PROMPT ===================================================================================== 
