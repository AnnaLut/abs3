

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIREWALL_USER_MODULE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FIREWALL_USER_MODULE_USRID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_MODULE ADD CONSTRAINT FK_FIREWALL_USER_MODULE_USRID FOREIGN KEY (USRID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FIREWALL_USER_MODULE_ACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_MODULE ADD CONSTRAINT FK_FIREWALL_USER_MODULE_ACTION FOREIGN KEY (ACTION)
	  REFERENCES BARS.FIREWALL_USER_ACTION (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIREWALL_USER_MODULE.sql ========
PROMPT ===================================================================================== 
