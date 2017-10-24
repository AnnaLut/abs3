

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_TARIF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_TARIF ***

  CREATE OR REPLACE TRIGGER BARS.TBU_TARIF before update of kod on tarif for each row
begin
  if :old.kod<>:new.kod then
  	raise_application_error(-20000, 'Запрещено изменение кода тарифа', true);
  end if;
end; 
/
ALTER TRIGGER BARS.TBU_TARIF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_TARIF.sql =========*** End *** =
PROMPT ===================================================================================== 
