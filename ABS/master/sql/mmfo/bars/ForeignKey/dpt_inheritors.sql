

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_INHERITORS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTINHERIT_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT FK_DPTINHERIT_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTINHERIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT FK_DPTINHERIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTINHERIT_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT FK_DPTINHERIT_CUSTOMER FOREIGN KEY (INHERIT_CUSTID)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTINHERIT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT FK_DPTINHERIT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_INHERITORS.sql =========*** E
PROMPT ===================================================================================== 
