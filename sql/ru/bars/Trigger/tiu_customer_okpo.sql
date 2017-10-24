

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSTOMER_OKPO.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CUSTOMER_OKPO ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CUSTOMER_OKPO 
before insert or update of okpo on customer
for each row
DECLARE
  i_  NUMBER;
  o_  customer.okpo%type;
begin
  if length(nvl(:new.okpo,''))>0 then
    o_ := '';
    for i_ in 1..length(:new.okpo)
    loop
      if substr(:new.okpo,i_,1)>='0' and
         substr(:new.okpo,i_,1)<='9' then
        o_ := o_||substr(:new.okpo,i_,1);
      end if;
    end loop;
    :new.okpo := o_;
  end if;
end;
/
ALTER TRIGGER BARS.TIU_CUSTOMER_OKPO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSTOMER_OKPO.sql =========*** E
PROMPT ===================================================================================== 
