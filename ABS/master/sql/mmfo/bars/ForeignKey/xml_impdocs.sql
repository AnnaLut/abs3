

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_IMPDOCS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLIMPDOCS_STAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPDOCS ADD CONSTRAINT XFK_XMLIMPDOCS_STAT FOREIGN KEY (STATUS)
	  REFERENCES BARS.XML_IMPSTATUS (STATUS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_IMPDOCS.sql =========*** End 
PROMPT ===================================================================================== 
