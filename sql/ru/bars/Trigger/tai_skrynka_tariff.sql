

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_SKRYNKA_TARIFF.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_SKRYNKA_TARIFF ***

  CREATE OR REPLACE TRIGGER BARS.TAI_SKRYNKA_TARIFF 
before INSERT ON SKRYNKA_TARIFF
FOR EACH ROW
BEGIN

 --if :new.tariff is null  then

       select S_SKRYNKA_TARIFF.nextval
         into :New.tariff
         from dual;

 --end if;

END ;
/
ALTER TRIGGER BARS.TAI_SKRYNKA_TARIFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_SKRYNKA_TARIFF.sql =========*** 
PROMPT ===================================================================================== 
