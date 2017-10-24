

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_SKRYNKA_TIP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_SKRYNKA_TIP ***

  CREATE OR REPLACE TRIGGER BARS.TAI_SKRYNKA_TIP 
before INSERT ON SKRYNKA_TIP
FOR EACH ROW
BEGIN

 --if :new.o_sk is null  then

       select S_SKRYNKA_TIP.nextval
         into :New.o_sk
         from dual;

 --end if;

END ;
/
ALTER TRIGGER BARS.TAI_SKRYNKA_TIP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_SKRYNKA_TIP.sql =========*** End
PROMPT ===================================================================================== 
