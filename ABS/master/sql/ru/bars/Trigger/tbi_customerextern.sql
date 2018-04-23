PROMPT *** Create  trigger TBI_CUSTOMEREXTERN ***

CREATE OR REPLACE TRIGGER BARS.TBI_CUSTOMEREXTERN 
before insert on customer_extern
for each row
declare
    l_id number;
begin
    if :new.id is null then
        select s_customer.nextval into l_id from dual;
        :new.id := l_id;
    end if;
end;
/
ALTER TRIGGER BARS.TBI_CUSTOMEREXTERN ENABLE;
