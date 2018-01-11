

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_SKRYNKA_STAFF_MODE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_SKRYNKA_STAFF_MODE ***

  CREATE OR REPLACE TRIGGER BARS.TI_SKRYNKA_STAFF_MODE BEFORE INSERT or UPDATE  ON BARS.SKRYNKA_STAFF    FOR EACH ROW
DECLARE
BEGIN

case 
  when :new.mode_time is null or :new.mode_time =  '__:__-__:__' then  :new.mode_time :=  '__:__-__:__';
  when regexp_like(:new.mode_time, '\d{2}:\d{2}-\d{2}:\d{2}') then null;
  else  raise_application_error  (- (20000), '\'|| 'Не вірно введено режим роботи відділення (Формат 00:00-00:00)', TRUE );
End case;

case 
  when :new.weekend is null or :new.weekend =  '__________________' then  :new.weekend :=  '__________________';
  else   null;
End case;



case 
  when :new.activ in  (0,1) then null;
  else :new.activ := 1;
End case;



END;
/
ALTER TRIGGER BARS.TI_SKRYNKA_STAFF_MODE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_SKRYNKA_STAFF_MODE.sql =========*
PROMPT ===================================================================================== 
