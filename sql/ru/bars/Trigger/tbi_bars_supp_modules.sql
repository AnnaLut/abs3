

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_BARS_SUPP_MODULES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_BARS_SUPP_MODULES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_BARS_SUPP_MODULES 
   before insert on bars_supp_modules
   for each row
begin
   if length(:new.mod_code) < 3 then
      bars_error.raise_error('SVC', 132);
   end if;
end;
/
ALTER TRIGGER BARS.TBI_BARS_SUPP_MODULES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_BARS_SUPP_MODULES.sql =========*
PROMPT ===================================================================================== 
