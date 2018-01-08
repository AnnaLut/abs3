

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_DOCDREC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLDOCDREC ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCDREC ADD CONSTRAINT XFK_XMLDOCDREC FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_DOCDREC.sql =========*** End 
PROMPT ===================================================================================== 
