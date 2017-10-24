

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_POS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_POS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_POS 
   BEFORE INSERT OR UPDATE OF pos
   ON accounts
   FOR EACH ROW
     WHEN (NEW.pos = 2 AND NEW.nbs NOT IN ('9809', '9910')) BEGIN
   raise_application_error (
      - (20000 + 1),
      'Недопустимый признак переоценки',
      TRUE);
END tiu_pos;



/
ALTER TRIGGER BARS.TIU_POS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_POS.sql =========*** End *** ===
PROMPT ===================================================================================== 
