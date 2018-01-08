

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PROC_DR$BASE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PROC_DR$BASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE ADD CONSTRAINT FK_PROC_DR$BASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PROC_DR$BASE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PROC_DR$BASE ADD CONSTRAINT FK_PROC_DR$BASE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PROC_DR$BASE.sql =========*** End
PROMPT ===================================================================================== 
