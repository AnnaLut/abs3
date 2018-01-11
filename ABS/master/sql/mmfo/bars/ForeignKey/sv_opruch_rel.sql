

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SV_OPRUCH_REL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SVOPRUCHREL_ID_TO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_OPRUCH_REL ADD CONSTRAINT FK_SVOPRUCHREL_ID_TO FOREIGN KEY (OWNER_ID_TO)
	  REFERENCES BARS.SV_OWNER (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SV_OPRUCH_REL.sql =========*** En
PROMPT ===================================================================================== 
