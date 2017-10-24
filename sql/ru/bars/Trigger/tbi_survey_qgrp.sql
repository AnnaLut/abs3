

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_QGRP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SURVEY_QGRP ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SURVEY_QGRP 
BEFORE INSERT ON survey_qgrp
FOR EACH ROW
BEGIN
  IF (:new.grp_id IS NULL) OR (:new.grp_id = 0) THEN
     SELECT s_survey_qgrp.nextval INTO :new.grp_id FROM dual;
  END IF;
END tbi_survey_qgrp;
/
ALTER TRIGGER BARS.TBI_SURVEY_QGRP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_QGRP.sql =========*** End
PROMPT ===================================================================================== 
