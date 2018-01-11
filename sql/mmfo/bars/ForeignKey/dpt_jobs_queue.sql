

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_JOBS_QUEUE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTJOBSQUEUE_DPTJOBSJRNL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_DPTJOBSJRNL FOREIGN KEY (RUN_ID)
	  REFERENCES BARS.DPT_JOBS_JRNL (RUN_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSQUEUE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSQUEUE_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_DPTJOBSLIST FOREIGN KEY (JOB_ID)
	  REFERENCES BARS.DPT_JOBS_LIST (JOB_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSQUEUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_QUEUE ADD CONSTRAINT FK_DPTJOBSQUEUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_JOBS_QUEUE.sql =========*** E
PROMPT ===================================================================================== 
