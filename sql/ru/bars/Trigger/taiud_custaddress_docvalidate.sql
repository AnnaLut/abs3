

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTADDRESS_DOCVALIDATE.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_CUSTADDRESS_DOCVALIDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_CUSTADDRESS_DOCVALIDATE 
after insert or update or delete
ON CUSTOMER_ADDRESS
for each row
 WHEN ( new.TYPE_ID = 1 Or old.TYPE_ID = 1 ) declare
  -----------------------------------------------------------------------------
  -- Деактуалізація стану документів при зміні адреси реєстрації клієнта
  -----------------------------------------------------------------------------
  l_rnk   person.rnk%type;
begin

  if (deleting) then
    l_rnk := :old.rnk;
  else
    l_rnk := :new.rnk;
  end if;

  EBP.SET_VERIFIED_STATE( l_rnk, 0 );

end;
/
ALTER TRIGGER BARS.TAIUD_CUSTADDRESS_DOCVALIDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_CUSTADDRESS_DOCVALIDATE.sql ==
PROMPT ===================================================================================== 
