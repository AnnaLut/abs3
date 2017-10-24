

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAUD_CUSTOMERREL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAUD_CUSTOMERREL ***

  CREATE OR REPLACE TRIGGER BARS.TAUD_CUSTOMERREL 
after update or delete on customer_rel
for each row
begin
  if   deleting and :old.sign_id is not null
    or updating and :old.sign_id is not null and :new.sign_id is null
  then
    delete from customer_bin_data where id=:old.sign_id;
  end if;
end;





/
ALTER TRIGGER BARS.TAUD_CUSTOMERREL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAUD_CUSTOMERREL.sql =========*** En
PROMPT ===================================================================================== 
