

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TRUSTEE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPT_TRUSTEE_UNDO_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPT_TRUSTEE_UNDO_ID FOREIGN KEY (UNDO_ID)
	  REFERENCES BARS.DPT_TRUSTEE (ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTRUSTEE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPTTRUSTEE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTRUSTEE_CUSTOMER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPTTRUSTEE_CUSTOMER2 FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTRUSTEE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPTTRUSTEE_CUSTOMER FOREIGN KEY (RNK_TR)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTRUSTEE_DPTTRUSTEETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPTTRUSTEE_DPTTRUSTEETYPE FOREIGN KEY (TYP_TR)
	  REFERENCES BARS.DPT_TRUSTEE_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTRUSTEE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPTTRUSTEE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTRUSTEE_DPTTRUSTEE2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPTTRUSTEE_DPTTRUSTEE2 FOREIGN KEY (KF, UNDO_ID)
	  REFERENCES BARS.DPT_TRUSTEE (KF, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTRUSTEE_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE ADD CONSTRAINT FK_DPTTRUSTEE_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TRUSTEE.sql =========*** End 
PROMPT ===================================================================================== 
