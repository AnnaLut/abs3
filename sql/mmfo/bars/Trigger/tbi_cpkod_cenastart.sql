

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CPKOD_CENASTART.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CPKOD_CENASTART ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CPKOD_CENASTART 
  BEFORE INSERT ON "BARS"."CP_KOD"
  REFERENCING FOR EACH ROW
begin
  If :new.CENA_start is null and :new.CENA is not null then
     :new.CENA_start := :new.CENA;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_CPKOD_CENASTART ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CPKOD_CENASTART.sql =========***
PROMPT ===================================================================================== 
