

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_QUEST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEYOPTLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEYOPTLIST FOREIGN KEY (LIST_ID)
	  REFERENCES BARS.SURVEY_OPT_LIST (LIST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEYQGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEYQGRP FOREIGN KEY (SURVEY_ID, QGRP_ID)
	  REFERENCES BARS.SURVEY_QGRP (SURVEY_ID, GRP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEYQFMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEYQFMT FOREIGN KEY (QFMT_ID)
	  REFERENCES BARS.SURVEY_QFMT (FMT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEYQUEST_SURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QUEST ADD CONSTRAINT FK_SURVEYQUEST_SURVEY FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.SURVEY (SURVEY_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_QUEST.sql =========*** End
PROMPT ===================================================================================== 
