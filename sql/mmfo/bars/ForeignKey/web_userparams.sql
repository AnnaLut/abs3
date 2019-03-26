

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WEB_USERPARAMS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WEB_USERPARAMS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_USERPARAMS ADD CONSTRAINT FK_WEB_USERPARAMS_STAFF FOREIGN KEY (USRID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WEB_USERPARAMS.sql =========*** E
PROMPT ===================================================================================== 