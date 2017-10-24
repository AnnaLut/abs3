

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_QUE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAY_QUE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAY_QUE 
after insert or update on zayavka
for each row
begin
  if (inserting) or (updating and :new.sos < 2 and :old.sos = 2) then
     begin
       insert into zay_queue (id) values (:new.id);
     exception
       when no_data_found then null;
     end;
  elsif (updating and :new.sos = 2 and :old.sos < 2) then
     delete from zay_queue where id=:new.id;
  elsif (updating and :new.sos = -1) then
     delete from zay_queue where id=:new.id;
  else
     null;
  end if;
end;



/
ALTER TRIGGER BARS.TBI_ZAY_QUE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_QUE.sql =========*** End ***
PROMPT ===================================================================================== 
