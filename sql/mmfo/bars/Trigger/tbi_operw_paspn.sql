

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPERW_PASPN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPERW_PASPN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPERW_PASPN 
  before insert ON BARS.OPERW
  for each row
     WHEN (
new.tag in('PASPN') and (new.tag ='NAMET' and new.value not like '%іншої країни')
      ) begin
    :new.value:=case when TRANSLATE(substr(replace(:new.value,' ',''),1,2),chr(0)||'0123456789',chr(0)) is null
           then :new.value
         else
           recode_passport_serial_noex(substr(replace(:new.value,' ',''),1,2))||substr(replace(:new.value,' ',''),3,length(replace(:new.value,' ','')))
         end;
end TBI_OPERW_PASPN;


/
ALTER TRIGGER BARS.TBI_OPERW_PASPN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPERW_PASPN.sql =========*** End
PROMPT ===================================================================================== 
