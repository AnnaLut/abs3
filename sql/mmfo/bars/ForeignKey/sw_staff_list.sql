

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_STAFF_LIST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWSTAFFLIST_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STAFF_LIST ADD CONSTRAINT FK_SWSTAFFLIST_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_STAFF_LIST.sql =========*** En
PROMPT ===================================================================================== 
