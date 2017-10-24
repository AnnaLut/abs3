

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_XML_GATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_XML_GATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_XML_GATE 
before insert  on bars.xml_gate for each row
begin
   if :new.id is null or :new.id = 0 then
       select s_xml_gate.nextval into :new.id from dual;
  end if;
end;




/
ALTER TRIGGER BARS.TBI_XML_GATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_XML_GATE.sql =========*** End **
PROMPT ===================================================================================== 
