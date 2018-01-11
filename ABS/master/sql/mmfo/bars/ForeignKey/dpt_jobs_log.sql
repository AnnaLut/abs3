

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_JOBS_LOG.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTJOBSLOG_DPTDPTALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_DPTDPTALL FOREIGN KEY (DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSLOG_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSLOG_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSLOG_DPTJOBSJRNL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_DPTJOBSJRNL FOREIGN KEY (RUN_ID)
	  REFERENCES BARS.DPT_JOBS_JRNL (RUN_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSLOG_DPTJOBSLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_DPTJOBSLIST FOREIGN KEY (JOB_ID)
	  REFERENCES BARS.DPT_JOBS_LIST (JOB_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSLOG_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSLOG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTJOBSLOG_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_JOBS_LOG ADD CONSTRAINT FK_DPTJOBSLOG_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_JOBS_LOG.sql =========*** End
PROMPT ===================================================================================== 
