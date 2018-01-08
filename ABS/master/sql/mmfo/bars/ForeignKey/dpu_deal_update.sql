

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUDEALUPD_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_ACCOUNTS3 FOREIGN KEY (KF, ACC2)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_DPTSTOP FOREIGN KEY (ID_STOP)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_BANKS2 FOREIGN KEY (MFO_P)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_BANKS FOREIGN KEY (MFO_D)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_FREQ FOREIGN KEY (FREQV)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_STAFF2 FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_STAFF FOREIGN KEY (USERU)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEALUPD_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT FK_DPUDEALUPD_DPUDEAL FOREIGN KEY (KF, DPU_ID)
	  REFERENCES BARS.DPU_DEAL (KF, DPU_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
