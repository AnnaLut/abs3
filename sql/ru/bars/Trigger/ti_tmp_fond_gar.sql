

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_TMP_FOND_GAR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_TMP_FOND_GAR ***

  CREATE OR REPLACE TRIGGER BARS.TI_TMP_FOND_GAR 
BEFORE INSERT ON tmp_fond_gar
FOR EACH ROW
BEGIN
   IF :new.rec_id IS NULL OR :new.rec_id = 0 THEN
      SELECT s_tmp_fond_gar.nextval INTO :new.rec_id FROM dual;
   END IF;
END;
/
ALTER TRIGGER BARS.TI_TMP_FOND_GAR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_TMP_FOND_GAR.sql =========*** End
PROMPT ===================================================================================== 
