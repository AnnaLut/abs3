

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SOLVENCY_QUESTIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOLVQUESTIONS_QID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SOLVENCY_QUESTIONS ADD CONSTRAINT FK_SOLVQUESTIONS_QID_QUESTS_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOLVQUESTIONS_SID_SCORS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SOLVENCY_QUESTIONS ADD CONSTRAINT FK_SOLVQUESTIONS_SID_SCORS_ID FOREIGN KEY (SOLVENCY_ID)
	  REFERENCES BARS.WCS_SOLVENCIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SOLVENCY_QUESTIONS.sql ======
PROMPT ===================================================================================== 
