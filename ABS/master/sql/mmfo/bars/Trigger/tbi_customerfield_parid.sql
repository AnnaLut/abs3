

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMERFIELD_PARID.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CUSTOMERFIELD_PARID ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CUSTOMERFIELD_PARID 
before insert on customer_field for each row
declare
  l_id number;
begin
  if :new.parid is null then
     select parid + 1 into l_id
       from customer_field o1
      where not exists ( select parid from customer_field
                          where parid=o1.parid + 1 )
        and rownum = 1;
     :new.parid := l_id;
  end if;
end;


/
ALTER TRIGGER BARS.TBI_CUSTOMERFIELD_PARID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMERFIELD_PARID.sql ========
PROMPT ===================================================================================== 
