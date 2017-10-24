

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOUNTSW_SHTAR.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_ACCOUNTSW_SHTAR ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_ACCOUNTSW_SHTAR 
  before insert or update or delete
 ON BARS.ACCOUNTSW for each row
begin

   if    deleting  then
      If :old.tag = 'SHTAR'  then
         delete from acc_tarif where acc= :old.acc;
      End if;

   elsif inserting then
      If :new.tag = 'SHTAR'  then
         delete from acc_tarif where acc= :new.acc;
         :new.value := replace(:new.value,',','.');
      End if;

   else
      If :new.tag = 'SHTAR' and :new.VALUE<>:old.VALUE then
         delete from acc_tarif where acc= :new.acc;
         :new.value := replace(:new.value,',','.');
      end if;
   end if;

end taiud_accountsw_SHTAR;
/
ALTER TRIGGER BARS.TAIUD_ACCOUNTSW_SHTAR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_ACCOUNTSW_SHTAR.sql =========*
PROMPT ===================================================================================== 
