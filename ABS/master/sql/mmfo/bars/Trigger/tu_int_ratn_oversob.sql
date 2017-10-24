

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_INT_RATN_OVERSOB.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_INT_RATN_OVERSOB ***

  CREATE OR REPLACE TRIGGER BARS.TU_INT_RATN_OVERSOB 
  BEFORE INSERT OR UPDATE ON "BARS"."INT_RATN"
  REFERENCING FOR EACH ROW
  DECLARE
 nd_   acc_over.nd%type;
 ndoc_ acc_over.ndoc%type;
BEGIN

   begin
    select distinct nd,ndoc
    into nd_,ndoc_
    from acc_over
    where acc = :new.acc
      and nvl(sos,0) <> 1;
   exception when NO_DATA_FOUND then return;
   end;

  null;

EXCEPTION WHEN OTHERS THEN
 return;
END tu_int_ratn_oversob;



/
ALTER TRIGGER BARS.TU_INT_RATN_OVERSOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_INT_RATN_OVERSOB.sql =========***
PROMPT ===================================================================================== 
