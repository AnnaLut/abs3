

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_REFREQV_PAR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLREFREQV ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFREQV_PAR ADD CONSTRAINT XFK_XMLREFREQV FOREIGN KEY (KLTABLE_NAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_REFREQV_PAR.sql =========*** 
PROMPT ===================================================================================== 
