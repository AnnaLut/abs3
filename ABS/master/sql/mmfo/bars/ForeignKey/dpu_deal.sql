

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUDEAL_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_FREQ FOREIGN KEY (FREQV)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_DPTSTOP FOREIGN KEY (ID_STOP)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_BANKS2 FOREIGN KEY (MFO_P)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_DPUVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_DPUVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPU_VIDD (VIDD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_ACCOUNTS3 FOREIGN KEY (KF, ACC2)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_DPUDEAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_DPUDEAL2 FOREIGN KEY (KF, DPU_GEN)
	  REFERENCES BARS.DPU_DEAL (KF, DPU_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_BANKS FOREIGN KEY (MFO_D)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUDEAL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT FK_DPUDEAL_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_DEAL.sql =========*** End ***
PROMPT ===================================================================================== 
