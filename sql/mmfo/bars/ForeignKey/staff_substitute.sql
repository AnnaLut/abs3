

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_SUBSTITUTE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFSUBS_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_SUBSTITUTE ADD CONSTRAINT FK_STAFFSUBS_STAFF2 FOREIGN KEY (ID_WHOM)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFSUBS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_SUBSTITUTE ADD CONSTRAINT FK_STAFFSUBS_STAFF FOREIGN KEY (ID_WHO)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_SUBSTITUTE.sql =========***
PROMPT ===================================================================================== 
