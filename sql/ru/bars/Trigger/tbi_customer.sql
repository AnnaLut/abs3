

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CUSTOMER ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CUSTOMER 
before insert on customer
for each row
begin
   if (:new.tobo is null) then
       select tobopack.GetTobo into :new.tobo from dual;
   end if;
   PUL.Set_Mas_Ini( 'NEW_RNK', to_char(:new.RNK), 'Новый клиент' );

end tbi_customer;
/
ALTER TRIGGER BARS.TBI_CUSTOMER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMER.sql =========*** End **
PROMPT ===================================================================================== 
