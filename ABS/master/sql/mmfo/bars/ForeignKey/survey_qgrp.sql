

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_QGRP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURVEYQGRP_SURVEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY_QGRP ADD CONSTRAINT FK_SURVEYQGRP_SURVEY FOREIGN KEY (SURVEY_ID)
	  REFERENCES BARS.SURVEY (SURVEY_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY_QGRP.sql =========*** End 
PROMPT ===================================================================================== 
