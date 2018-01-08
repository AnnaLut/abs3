

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/UNIVERSAL_BOX.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_UNIVERSALBOX_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.UNIVERSAL_BOX ADD CONSTRAINT FK_UNIVERSALBOX_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/UNIVERSAL_BOX.sql =========*** En
PROMPT ===================================================================================== 
