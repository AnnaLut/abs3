

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_BPKPARAMETERS_CHECKS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_BPKPARAMETERS_CHECKS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_BPKPARAMETERS_CHECKS 
before insert or update on BARS.BPK_PARAMETERS
for each row
 WHEN ( new.tag in ('VNCRR','VNCRP') ) declare
  l_value cck_rating.code%type := 0;
begin
  select code into l_value from cck_rating where code = :new.value and rownum =1;
  exception
    when NO_DATA_FOUND then
         raise_application_error(-20001,'Не допустиме значення "'||nvl(:new.VALUE,'null')||'" для параметру ВКР!',true);
    when others then
         raise;
end TBIU_BPKPARAMETERS_CHECKS;
/
ALTER TRIGGER BARS.TBIU_BPKPARAMETERS_CHECKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_BPKPARAMETERS_CHECKS.sql ======
PROMPT ===================================================================================== 
