

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_CUSTW_CHECKS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_CUSTW_CHECKS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_CUSTW_CHECKS 
before insert or update ON BARS.CUSTOMERW
for each row
 WHEN ( NEW.TAG in ( 'BUSSL', 'BUSSS' ) ) begin

  case :NEW.TAG
    when 'BUSSL'
    then -- value in ('1','2')
      if Not RegExp_Like(:new.VALUE,'^(1|2)$')
      then
        bars_audit.trace( SubStr('TBIU_CUSTW_CHECKS: ' || dbms_utility.format_error_backtrace(), 1, 4000 ) );
        raise_application_error(-20666,'Не допустиме значення "'||nvl(:new.VALUE,'null')||'" для параметру '||:new.TAG||'!',true);
      End If;
    when 'BUSSS'
    then -- value in ('11','12','21','22','23')
      if Not RegExp_Like(:new.VALUE,'^([1][1,2])|([2][1,2,3])$')
      then
        bars_audit.trace(  SubStr('TBIU_CUSTW_CHECKS: ' || dbms_utility.format_error_backtrace(), 1, 4000 ) );
        raise_application_error(-20666,'Не допустиме значення "'||nvl(:new.VALUE,'null')||'" для параметру '||:new.TAG||'!',true);
      End If;
    else
      null;
  end case;

end TBIU_CUSTW_CHECKS;
/
ALTER TRIGGER BARS.TBIU_CUSTW_CHECKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_CUSTW_CHECKS.sql =========*** E
PROMPT ===================================================================================== 
