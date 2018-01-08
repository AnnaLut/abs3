

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_REFDEPPAR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_XMLREFDEPPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEPPAR ADD CONSTRAINT XFK_XMLREFDEPPAR FOREIGN KEY (KLTABLE_NAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_XMLREFDEPSPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEPPAR ADD CONSTRAINT XFK_XMLREFDEPSPAR FOREIGN KEY (KLTABLE_NAME, SRCPAR)
	  REFERENCES BARS.XML_REFREQV_PAR (KLTABLE_NAME, PARNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_XMLREFDEPDPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEPPAR ADD CONSTRAINT XFK_XMLREFDEPDPAR FOREIGN KEY (KLTABLE_DEPNAME, DESTPAR)
	  REFERENCES BARS.XML_REFREQV_PAR (KLTABLE_NAME, PARNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_REFDEPPAR.sql =========*** En
PROMPT ===================================================================================== 
