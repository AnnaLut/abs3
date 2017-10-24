

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$BASE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_PARAMS$BASE ***

  CREATE OR REPLACE TRIGGER BARS.TIU_PARAMS$BASE 
BEFORE INSERT OR UPDATE ON "BARS"."DEPRICATED_PARAMS$BASE"
FOR EACH ROW
DECLARE
  PAR_ PARAMS$GLOBAL.PAR%TYPE;
BEGIN
  -- Соблюдение уникальности параметров
  SELECT MAX(PAR) INTO PAR_ FROM PARAMS$GLOBAL WHERE PAR=:NEW.PAR;
  IF PAR_ IS NOT NULL THEN
    -- 'Создаваемый локальный параметр уже существует как глобальный!',TRUE);
    bars_error.raise_error('SVC', 12);
  END IF;
END;





/
ALTER TRIGGER BARS.TIU_PARAMS$BASE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$BASE.sql =========*** End
PROMPT ===================================================================================== 
