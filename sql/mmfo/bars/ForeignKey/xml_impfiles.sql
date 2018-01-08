

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_IMPFILES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLIMPFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES ADD CONSTRAINT XFK_XMLIMPFILES FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_IMPFILES.sql =========*** End
PROMPT ===================================================================================== 
