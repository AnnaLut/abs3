

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_ADDHDRTAGS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_XMLADDHDR_MESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_ADDHDRTAGS ADD CONSTRAINT FK_XMLADDHDR_MESS FOREIGN KEY (MESSAGE)
	  REFERENCES BARS.XML_MESSTYPES (MESSAGE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_ADDHDRTAGS.sql =========*** E
PROMPT ===================================================================================== 
