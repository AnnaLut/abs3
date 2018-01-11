

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_QUEST_DEP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURVEYQDEP_SURVEYANSWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP ADD CONSTRAINT FK_SURVEYQDEP_SURVEYANSWOPT FOREIGN KEY (OPT_ID)
	  REFERENCES BARS.SURVEY_ANSWER_OPT (OPT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQDEP_SURVEYQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP ADD CONSTRAINT FK_SURVEYQDEP_SURVEYQUEST FOREIGN KEY (QUEST_ID)
	  REFERENCES BARS.SURVEY_QUEST (QUEST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQDEP_SURVEYQUEST2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST_DEP ADD CONSTRAINT FK_SURVEYQDEP_SURVEYQUEST2 FOREIGN KEY (CHILD_ID)
	  REFERENCES BARS.SURVEY_QUEST (QUEST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_QUEST_DEP.sql =========***
PROMPT ===================================================================================== 
