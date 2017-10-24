

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_TAMOZHDOC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_TAMOZHDOC ***

  CREATE OR REPLACE TRIGGER BARS.TBI_TAMOZHDOC 
  BEFORE INSERT ON "BARS"."TAMOZHDOC"
  REFERENCING FOR EACH ROW
  declare
  l_idt number;
begin

   :new.dat := gl.bdate;

   if (:new.idt = 0 or :new.idt is null) then

     select s_tamozhdoc.nextval into l_idt from dual;
     :new.idt := l_idt;

   end if;

end;



/
ALTER TRIGGER BARS.TBI_TAMOZHDOC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_TAMOZHDOC.sql =========*** End *
PROMPT ===================================================================================== 
