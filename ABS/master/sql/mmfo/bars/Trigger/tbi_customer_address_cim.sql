

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMER_ADDRESS_CIM.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CUSTOMER_ADDRESS_CIM ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CUSTOMER_ADDRESS_CIM 
before update on customer_address
for each row
declare
  l_n number;
begin
  if :new.zip != :old.zip or :new.domain != :old.domain or :new.region != :old.region
      or :new.locality != :old.locality or :new.address != :old.address then
    select count(*) into l_n from cim_contracts c where c.contr_type<2 and c.status_id != 1 and c.rnk=:new.rnk;
    if l_n > 0 then
      update cim_customer_upd cu set cu.modify_date  = bankdate  where cu.rnk = :new.rnk and cu.modify_date= bankdate;
      if sql%rowcount = 0 then
        insert into cim_customer_upd (rnk, modify_date) values (:new.rnk, bankdate);
      end if;
    end if;
  end if;
end;


/
ALTER TRIGGER BARS.TBI_CUSTOMER_ADDRESS_CIM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMER_ADDRESS_CIM.sql =======
PROMPT ===================================================================================== 