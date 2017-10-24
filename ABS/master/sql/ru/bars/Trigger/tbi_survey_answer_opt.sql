

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_ANSWER_OPT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SURVEY_ANSWER_OPT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SURVEY_ANSWER_OPT 
BEFORE INSERT ON survey_answer_opt
FOR EACH ROW
BEGIN
  IF (:new.opt_id IS NULL) OR (:new.opt_id = 0) THEN
     SELECT s_survey_answer_opt.nextval INTO :new.opt_id FROM dual;
  END IF;
END tbi_survey_answer_opt;

/
ALTER TRIGGER BARS.TBI_SURVEY_ANSWER_OPT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_ANSWER_OPT.sql =========*
PROMPT ===================================================================================== 
