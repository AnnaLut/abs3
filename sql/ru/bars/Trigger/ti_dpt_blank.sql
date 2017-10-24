

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_DPT_BLANK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_DPT_BLANK ***

  CREATE OR REPLACE TRIGGER BARS.TI_DPT_BLANK 
before insert on dpt_blank
for each row
 WHEN (
new.staff_id is null
      ) begin

   :new.staff_id := user_id;

end;
/
ALTER TRIGGER BARS.TI_DPT_BLANK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_DPT_BLANK.sql =========*** End **
PROMPT ===================================================================================== 
