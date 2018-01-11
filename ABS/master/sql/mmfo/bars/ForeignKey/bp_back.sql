

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BP_BACK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BPBACK_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPBACK_BPREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_BPREASON FOREIGN KEY (ID)
	  REFERENCES BARS.BP_REASON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPBACK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BP_BACK ADD CONSTRAINT FK_BPBACK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BP_BACK.sql =========*** End *** 
PROMPT ===================================================================================== 
