

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_DESTRUCT_PASSP_SER.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_DESTRUCT_PASSP_SER ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_DESTRUCT_PASSP_SER 
before insert or update ON BARS.DESTRUCT_PASSP
for each row
declare
   l_ser varchar2(10);
begin
  select trim(translate(:new.ser,'ABCDEFGHIKLMNOPQRSTVXYZ','                       ')) into l_ser from dual;

  if (l_ser <> :new.ser or l_ser is null) then
    raise_application_error(-20001, 'Серію паспорта необхідно вводити на кирилиці!!!');
  end if;
end;
/
ALTER TRIGGER BARS.TBIU_DESTRUCT_PASSP_SER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_DESTRUCT_PASSP_SER.sql ========
PROMPT ===================================================================================== 
