

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OTD_USER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OTDUSER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER ADD CONSTRAINT FK_OTDUSER_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTDUSER_OTDEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER ADD CONSTRAINT FK_OTDUSER_OTDEL FOREIGN KEY (OTD)
	  REFERENCES BARS.OTDEL (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OTD_USER.sql =========*** End ***
PROMPT ===================================================================================== 
