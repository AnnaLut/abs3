

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACR_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACRDOCS_INTACCN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACR_DOCS ADD CONSTRAINT FK_ACRDOCS_INTACCN FOREIGN KEY (ACC, ID)
	  REFERENCES BARS.INT_ACCN (ACC, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACR_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
