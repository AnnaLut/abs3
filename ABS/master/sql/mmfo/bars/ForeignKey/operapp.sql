

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OPERAPP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OPERAPP_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT FK_OPERAPP_STAFF FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERAPP_OPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT FK_OPERAPP_OPERLIST FOREIGN KEY (CODEOPER)
	  REFERENCES BARS.OPERLIST (CODEOPER) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERAPP_APPLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERAPP ADD CONSTRAINT FK_OPERAPP_APPLIST FOREIGN KEY (CODEAPP)
	  REFERENCES BARS.APPLIST (CODEAPP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OPERAPP.sql =========*** End *** 
PROMPT ===================================================================================== 
