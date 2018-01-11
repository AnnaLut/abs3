

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SURVEY_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY ADD CONSTRAINT FK_SURVEY_DOCSCHEME FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SURVEY_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SURVEY ADD CONSTRAINT FK_SURVEY_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SURVEY.sql =========*** End *** =
PROMPT ===================================================================================== 
