

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CUSTOMER_SAB.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CUSTOMER_SAB ***

  CREATE OR REPLACE TRIGGER BARS.TU_CUSTOMER_SAB 
before update of SAB on customer
for each row
begin
  if trim(:new.SAB) is null then
--  delete
--  from   acce
--  where  acc in (select acc
--                 from   accounts
--                 where  rnk=:old.rnk);
--  delete
--  from   acci
--  where  acc in (select acc
--                 from   accounts
--                 where  rnk=:old.rnk);
    if :old.SAB is not null then
      delete
      from   klpoow
      where  sab=:old.SAB;
    end if;
  end if;
end tu_customer_SAB;


/
ALTER TRIGGER BARS.TU_CUSTOMER_SAB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CUSTOMER_SAB.sql =========*** End
PROMPT ===================================================================================== 
