

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_IMPDOCSW.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLIMPDOCSW ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPDOCSW ADD CONSTRAINT XFK_XMLIMPDOCSW FOREIGN KEY (IMPREF)
	  REFERENCES BARS.XML_IMPDOCS (IMPREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_IMPDOCSW.sql =========*** End
PROMPT ===================================================================================== 
