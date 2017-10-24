

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KAS_U.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KAS_U ***

  CREATE OR REPLACE TRIGGER BARS.TI_KAS_U 
  before insert on KAS_u
  for each row
begin
   --
   -- Модифицировано для поддержки уникальности идентификатора
   --
   select s_KAS_u.nextval into :new.idS from dual;

end ti_KAS_u;
/
ALTER TRIGGER BARS.TI_KAS_U ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KAS_U.sql =========*** End *** ==
PROMPT ===================================================================================== 
