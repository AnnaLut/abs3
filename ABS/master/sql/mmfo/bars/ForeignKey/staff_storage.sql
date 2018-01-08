

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_STORAGE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFSTG_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_STORAGE ADD CONSTRAINT FK_STAFFSTG_STAFF2 FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFSTG_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_STORAGE ADD CONSTRAINT FK_STAFFSTG_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_STORAGE.sql =========*** En
PROMPT ===================================================================================== 
