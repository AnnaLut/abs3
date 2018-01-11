

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_REPLINES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_SURV_REPL_QUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_REPLINES ADD CONSTRAINT XFK_SURV_REPL_QUEST FOREIGN KEY (QUEST_ID)
	  REFERENCES BARS.SURVEY_QUEST (QUEST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_REPLINES.sql =========*** 
PROMPT ===================================================================================== 
