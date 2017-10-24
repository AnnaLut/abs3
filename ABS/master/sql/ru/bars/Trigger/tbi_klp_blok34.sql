

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_BLOK34.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KLP_BLOK34 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KLP_BLOK34 
before insert ON klp for each row
begin
  if trunc(sysdate)>=to_date('01/08/2015','DD/MM/YYYY') then
    :new.fl   := 1;
    :new.prwo := '*Документ заблокований (наказ №34 від 26.01.2015 р.)';
  end if;
end;
/
ALTER TRIGGER BARS.TBI_KLP_BLOK34 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KLP_BLOK34.sql =========*** End 
PROMPT ===================================================================================== 
