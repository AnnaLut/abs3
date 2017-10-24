

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_PERSON_DESTRUCT_PASSP.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_PERSON_DESTRUCT_PASSP ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_PERSON_DESTRUCT_PASSP 
before insert or update ON BARS.PERSON
for each row
declare
   l_p number;
begin
  select check_destruct_passp(:new.ser, :new.numdoc) into l_p from dual;

  if l_p=1 then
    raise_application_error(-20001, 'ѕаспорт кл≥Їнта п≥дл€гаЇ вилученню та знищенню зг≥дно листа ЌЅ” в≥д 15.04.2015 р. є47-411/25195');
  end if;
end;


/
ALTER TRIGGER BARS.TBIU_PERSON_DESTRUCT_PASSP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_PERSON_DESTRUCT_PASSP.sql =====
PROMPT ===================================================================================== 
