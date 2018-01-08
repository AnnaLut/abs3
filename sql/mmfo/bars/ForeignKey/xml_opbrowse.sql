

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_OPBROWSE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLOPBROWSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_OPBROWSE ADD CONSTRAINT XFK_XMLOPBROWSE FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_OPBROWSE.sql =========*** End
PROMPT ===================================================================================== 
