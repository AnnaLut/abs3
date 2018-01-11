

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCORINGS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SCORINGS_RQID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SCORINGS ADD CONSTRAINT FK_SCORINGS_RQID_QUESTS_ID FOREIGN KEY (RESULT_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_SCORINGS.sql =========*** End
PROMPT ===================================================================================== 
