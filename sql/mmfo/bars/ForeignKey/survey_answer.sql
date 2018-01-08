

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_ANSWER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURVEYANSWER_SURVEYANSWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT FK_SURVEYANSWER_SURVEYANSWOPT FOREIGN KEY (ANSWER_OPT)
	  REFERENCES BARS.SURVEY_ANSWER_OPT (OPT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYANSWER_SURVEYQUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT FK_SURVEYANSWER_SURVEYQUEST FOREIGN KEY (QUEST_ID)
	  REFERENCES BARS.SURVEY_QUEST (QUEST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYANSWER_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT FK_SURVEYANSWER_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYANSWER_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT FK_SURVEYANSWER_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYANSWER_SURVEYSESSION2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER ADD CONSTRAINT FK_SURVEYANSWER_SURVEYSESSION2 FOREIGN KEY (KF, SESSION_ID)
	  REFERENCES BARS.SURVEY_SESSION (KF, SESSION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_ANSWER.sql =========*** En
PROMPT ===================================================================================== 
