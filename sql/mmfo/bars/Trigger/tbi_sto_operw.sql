

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_OPERW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_STO_OPERW ***

  CREATE OR REPLACE TRIGGER BARS.TBI_STO_OPERW 
      BEFORE INSERT ON BARS.STO_OPERW FOR EACH ROW
   WHEN (
NEW.idd IS NULL
      ) BEGIN

	if web_utl.is_web_user = 1 then
	     null;
	else
	   :NEW.idd := pul.get_mas_ini_val ( 'STO_OPERW');
	end if;

END;


/
ALTER TRIGGER BARS.TBI_STO_OPERW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STO_OPERW.sql =========*** End *
PROMPT ===================================================================================== 
