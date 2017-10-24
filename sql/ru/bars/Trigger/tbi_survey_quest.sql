

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_QUEST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SURVEY_QUEST ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SURVEY_QUEST 
BEFORE INSERT ON survey_quest
FOR EACH ROW
BEGIN
  IF (:new.quest_id IS NULL) OR (:new.quest_id = 0) THEN
     SELECT s_survey_quest.nextval INTO :new.quest_id FROM dual;
  END IF;
END tbi_survey_quest;

/
ALTER TRIGGER BARS.TBI_SURVEY_QUEST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_QUEST.sql =========*** En
PROMPT ===================================================================================== 
