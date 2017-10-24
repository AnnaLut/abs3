

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ZAY_CLOSETYPE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ZAY_CLOSETYPE ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ZAY_CLOSETYPE 
before update on zayavka
for each row
   WHEN ( old.sos = 0 and new.sos = 0.5  ) begin
  -- не даем обработать дилером заявку, если не проставлен тип закрытия заявки
  if :new.close_type is null then
     raise_application_error(-(20000+999),'Невозможно сохранение без указания типа закрытия заявки!',TRUE);
  end if;
end;


/
ALTER TRIGGER BARS.TBU_ZAY_CLOSETYPE DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ZAY_CLOSETYPE.sql =========*** E
PROMPT ===================================================================================== 
