

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_JOBS_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUJOBSLOG_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_DPTJOBSLIST FOREIGN KEY (JOB_ID)
	  REFERENCES BARS.DPT_JOBS_LIST (JOB_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_BANKS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_BANKS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUJOBSLOG_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_JOBS_LOG ADD CONSTRAINT FK_DPUJOBSLOG_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_JOBS_LOG.sql =========*** End
PROMPT ===================================================================================== 
