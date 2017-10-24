

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_SESSION.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SURVEY_SESSION ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SURVEY_SESSION 
BEFORE INSERT ON survey_session
FOR EACH ROW
BEGIN
  IF Nvl(:new.session_id,0) = 0 THEN
     SELECT s_survey_session.nextval INTO :new.session_id FROM dual;
  END IF;    
  :NEW.USER_ID:= gl.aUID;
  PUL.Set_Mas_Ini( 'SES_ID', to_char(:new.session_id), 'Для анкеты' );
END tbi_survey_session; 
/
ALTER TRIGGER BARS.TBI_SURVEY_SESSION ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SURVEY_SESSION.sql =========*** 
PROMPT ===================================================================================== 
