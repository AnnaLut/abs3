

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_INFOQUERY_QUESTIONS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_IQQUESTIONS_IQID_IQS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERY_QUESTIONS ADD CONSTRAINT FK_IQQUESTIONS_IQID_IQS_ID FOREIGN KEY (IQUERY_ID)
	  REFERENCES BARS.WCS_INFOQUERIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_IQQUESTIONS_QID_QUEST_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERY_QUESTIONS ADD CONSTRAINT FK_IQQUESTIONS_QID_QUEST_ID FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_INFOQUERY_QUESTIONS.sql =====
PROMPT ===================================================================================== 
