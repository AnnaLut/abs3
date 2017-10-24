

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_MONEXR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_MONEXR ***

  CREATE OR REPLACE TRIGGER BARS.TBI_MONEXR 
   BEFORE INSERT
   ON BARS.MONEXR
   FOR EACH ROW
begin
/*по 95й системе никогда не может быть комиссии*/
   if trim(:new.KOD_NBU)='95' 
   and :new.K_2809<>0 
      then
   :new.K_2809:=0;

   end if;
end;
/
ALTER TRIGGER BARS.TBI_MONEXR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_MONEXR.sql =========*** End *** 
PROMPT ===================================================================================== 
