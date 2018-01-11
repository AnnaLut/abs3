

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BARSWEB_SESSION_DATA.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BARSWEB_SESSION_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSWEB_SESSION_DATA ADD CONSTRAINT FK_BARSWEB_SESSION_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BARSWEB_SESSION_DATA.sql ========
PROMPT ===================================================================================== 
