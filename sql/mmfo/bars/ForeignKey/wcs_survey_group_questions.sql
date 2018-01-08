

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SURVEY_GROUP_QUESTIONS.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SGRPQUESTS_SURVEYGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT FK_SGRPQUESTS_SURVEYGROUPS FOREIGN KEY (SURVEY_ID, SGROUP_ID)
	  REFERENCES BARS.WCS_SURVEY_GROUPS (SURVEY_ID, ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGRPQUESTS_RTID_SGRPRTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT FK_SGRPQUESTS_RTID_SGRPRTS_ID FOREIGN KEY (RECTYPE_ID)
	  REFERENCES BARS.WCS_SURVEY_GROUP_RECTYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SGRPQUESTS_QID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SURVEY_GROUP_QUESTIONS ADD CONSTRAINT FK_SGRPQUESTS_QID_QUEST_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SURVEY_GROUP_QUESTIONS.sql ==
PROMPT ===================================================================================== 
