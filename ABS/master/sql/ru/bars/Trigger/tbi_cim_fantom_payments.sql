

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_FANTOM_PAYMENTS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_FANTOM_PAYMENTS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CIM_FANTOM_PAYMENTS 
before insert on cim_fantom_payments
for each row
declare
  l_fantom_id number;
begin
  :new.bank_date := gl.bdate;

  if (:new.fantom_id = 0 or :new.fantom_id is null) then
     select s_cim_fantom_payments.nextval into l_fantom_id from dual;
     :new.fantom_id := l_fantom_id;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CIM_FANTOM_PAYMENTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_FANTOM_PAYMENTS.sql ========
PROMPT ===================================================================================== 
