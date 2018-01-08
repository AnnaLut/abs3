

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_JOBS_JRNL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUJOBSJRNL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT FK_DPUJOBSJRNL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSJRNL_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT FK_DPUJOBSJRNL_DPTJOBSLIST FOREIGN KEY (JOB_ID)
	  REFERENCES BARS.DPT_JOBS_LIST (JOB_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSJRNL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_JRNL ADD CONSTRAINT FK_DPUJOBSJRNL_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_JOBS_JRNL.sql =========*** En
PROMPT ===================================================================================== 
