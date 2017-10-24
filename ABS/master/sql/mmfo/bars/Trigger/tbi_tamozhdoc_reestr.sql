

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_TAMOZHDOC_REESTR.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_TAMOZHDOC_REESTR ***

  CREATE OR REPLACE TRIGGER BARS.TBI_TAMOZHDOC_REESTR 
  BEFORE INSERT ON "BARS"."TAMOZHDOC_REESTR"
  REFERENCING FOR EACH ROW
  declare
  l_idr number;
begin

  if (:new.idr = 0 or :new.idr is null) then

    select s_tamozhdoc_reestr.nextval into l_idr from dual;

    :new.idr := l_idr;

  end if;

end;



/
ALTER TRIGGER BARS.TBI_TAMOZHDOC_REESTR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_TAMOZHDOC_REESTR.sql =========**
PROMPT ===================================================================================== 
