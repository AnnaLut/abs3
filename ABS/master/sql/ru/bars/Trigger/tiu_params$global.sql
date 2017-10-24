

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$GLOBAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_PARAMS$GLOBAL ***

  CREATE OR REPLACE TRIGGER BARS.TIU_PARAMS$GLOBAL 
BEFORE INSERT OR UPDATE ON PARAMS$GLOBAL
FOR EACH ROW
DECLARE
  PAR_ PARAMS$BASE.PAR%TYPE;
BEGIN
  -- Соблюдение уникальности параметров
  SELECT MAX(PAR) INTO PAR_ FROM PARAMS$BASE WHERE PAR=:NEW.PAR;
  IF PAR_ IS NOT NULL THEN
    -- 'Создаваемый глобальный параметр уже существует как локальный!',TRUE);
    --bars_error.raise_error('SVC', 13);
    raise_application_error(-20000, 'Создаваемый глобальный параметр уже существует как локальный!', true);
  END IF;
END; 
/
ALTER TRIGGER BARS.TIU_PARAMS$GLOBAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$GLOBAL.sql =========*** E
PROMPT ===================================================================================== 
