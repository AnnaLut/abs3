

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KAS_F.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KAS_F ***

  CREATE OR REPLACE TRIGGER BARS.TI_KAS_F 
  before insert on KAS_F
  for each row
begin
   --
   -- Модифицировано для поддержки уникальности идентификатора
   --
   select s_KAS_F.nextval into :new.id from dual;

end ti_KAS_F;
/
ALTER TRIGGER BARS.TI_KAS_F ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KAS_F.sql =========*** End *** ==
PROMPT ===================================================================================== 
