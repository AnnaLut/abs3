

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/VIP_MGR_USR_LST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_VIPMGRUSRLST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_MGR_USR_LST ADD CONSTRAINT FK_VIPMGRUSRLST_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VIPMGRUSRLST_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_MGR_USR_LST ADD CONSTRAINT FK_VIPMGRUSRLST_STAFF FOREIGN KEY (USR_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/VIP_MGR_USR_LST.sql =========*** 
PROMPT ===================================================================================== 
