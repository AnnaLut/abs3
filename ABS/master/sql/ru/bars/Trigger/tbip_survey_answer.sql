

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIP_SURVEY_ANSWER.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIP_SURVEY_ANSWER ***

  CREATE OR REPLACE TRIGGER BARS.TBIP_SURVEY_ANSWER 
BEFORE INSERT ON BARS.SURVEY_ANSWER FOR EACH ROW
BEGIN

  IF :new.SESSION_ID is null THEN
     :NEW.SESSION_ID :=
     to_number(substr(pul.Get_Mas_Ini_Val('SES_ID'  ),1,10));
  END IF;
  
  IF :new.QUEST_ID   is     null AND
     :new.QUEST_ID_P is not null then
     begin
       select    q.QUEST_ID
       into   :new.QUEST_ID
       from SURVEY_QUEST   q,
            SURVEY_SESSION s
       where  :new.QUEST_ID_P =  q.QUEST_ID_P
         and  :new.SESSION_ID =  s.SESSION_ID
         and      s.SURVEY_ID  = q.SURVEY_ID;
     exception when NO_DATA_FOUND THEn
       null;
     end;
  end if;
END tbiP_SURVEY_ANSWER; 
/
ALTER TRIGGER BARS.TBIP_SURVEY_ANSWER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIP_SURVEY_ANSWER.sql =========*** 
PROMPT ===================================================================================== 
