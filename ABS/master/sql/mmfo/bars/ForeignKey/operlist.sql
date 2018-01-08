

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OPERLIST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OPERLIST_ROLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST ADD CONSTRAINT FK_OPERLIST_ROLES FOREIGN KEY (ROLENAME)
	  REFERENCES BARS.ROLES$BASE (ROLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERLIST_FRONTEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPERLIST ADD CONSTRAINT FK_OPERLIST_FRONTEND FOREIGN KEY (FRONTEND)
	  REFERENCES BARS.FRONTEND (FID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OPERLIST.sql =========*** End ***
PROMPT ===================================================================================== 
