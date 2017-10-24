

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_TV_NBS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_TV_NBS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_TV_NBS 
  BEFORE INSERT OR UPDATE ON "BARS"."TV_NBS"
  REFERENCING FOR EACH ROW
  DECLARE
  err_ Varchar2(240);
BEGIN

   if length(trim(:new.NBS))<>4 then
      err_:='Длина балансового счёта должна быть равна 4';
      RAISE_APPLICATION_ERROR(-20371,err_);
   end if;

END;



/
ALTER TRIGGER BARS.TIU_TV_NBS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_TV_NBS.sql =========*** End *** 
PROMPT ===================================================================================== 
