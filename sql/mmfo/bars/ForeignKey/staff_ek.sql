

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_EK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFEK_STAFF$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_EK ADD CONSTRAINT FK_STAFFEK_STAFF$BASE FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_EK.sql =========*** End ***
PROMPT ===================================================================================== 
