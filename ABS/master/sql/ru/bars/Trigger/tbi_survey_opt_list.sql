

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_OPT_LIST.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SURVEY_OPT_LIST ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SURVEY_OPT_LIST 
BEFORE INSERT ON survey_opt_list
FOR EACH ROW
BEGIN
  IF (:new.list_id IS NULL) OR (:new.list_id = 0) THEN
     SELECT s_survey_opt_list.nextval INTO :new.list_id FROM dual;
  END IF;
END tbi_survey_opt_list;

/
ALTER TRIGGER BARS.TBI_SURVEY_OPT_LIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_OPT_LIST.sql =========***
PROMPT ===================================================================================== 
