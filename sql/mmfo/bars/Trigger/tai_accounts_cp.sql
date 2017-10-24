

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_ACCOUNTS_CP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_ACCOUNTS_CP ***

  CREATE OR REPLACE TRIGGER BARS.TAI_ACCOUNTS_CP 
   AFTER INSERT
   ON ACCOUNTS
   REFERENCING FOR EACH ROW
declare
  n_ int;
begin
   if :new.nbs like '31__'    or
      :new.nbs like '32__'    or
      :new.nbs like '14__'    or
      :new.nbs like '605_'    then

      insert into SPECPARAM_CP_OB (acc) values ( :new.ACC);

   end if;
end;



/
ALTER TRIGGER BARS.TAI_ACCOUNTS_CP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_ACCOUNTS_CP.sql =========*** End
PROMPT ===================================================================================== 
