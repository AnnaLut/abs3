

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_STAFF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTSTAFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTAFF_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTAFF_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_STAFF2 FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTAFF_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_STAFF.sql =========*** End **
PROMPT ===================================================================================== 
