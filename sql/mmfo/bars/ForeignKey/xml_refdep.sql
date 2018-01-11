

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_REFDEP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLREFDEP ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEP ADD CONSTRAINT XFK_XMLREFDEP FOREIGN KEY (KLTABLE_NAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_XMLREFDEPTAB ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEP ADD CONSTRAINT XFK_XMLREFDEPTAB FOREIGN KEY (KLTABLE_DEPNAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_REFDEP.sql =========*** End *
PROMPT ===================================================================================== 
