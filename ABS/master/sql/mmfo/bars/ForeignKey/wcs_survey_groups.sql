

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURGROUPS_SID_SURVEYS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUPS ADD CONSTRAINT FK_SURGROUPS_SID_SURVEYS_ID FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.WCS_SURVEYS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURGROUPS_RQID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUPS ADD CONSTRAINT FK_SURGROUPS_RQID_QUESTS_ID FOREIGN KEY (RESULT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 
