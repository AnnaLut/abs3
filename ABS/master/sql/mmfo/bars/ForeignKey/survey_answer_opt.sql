

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_ANSWER_OPT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURVEYANSWOPT_SURVEYOPTLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_ANSWER_OPT ADD CONSTRAINT FK_SURVEYANSWOPT_SURVEYOPTLIST FOREIGN KEY (LIST_ID)
	  REFERENCES BARS.SURVEY_OPT_LIST (LIST_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_ANSWER_OPT.sql =========**
PROMPT ===================================================================================== 
