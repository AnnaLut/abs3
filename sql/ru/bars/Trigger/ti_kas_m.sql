

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_KAS_M.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_KAS_M ***

  CREATE OR REPLACE TRIGGER BARS.TI_KAS_M 
  before insert on KAS_M
  for each row
begin
   --
   -- Модифицировано для поддержки уникальности идентификатора
   --
   select s_KAS_M.nextval into :new.idm from dual;

end ti_KAS_M;
/
ALTER TRIGGER BARS.TI_KAS_M ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_KAS_M.sql =========*** End *** ==
PROMPT ===================================================================================== 
