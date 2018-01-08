

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/VP_LIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS FOREIGN KEY (KF, ACC3801)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS2 FOREIGN KEY (KF, ACC6204)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS3 FOREIGN KEY (KF, ACC_RRD)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS4 FOREIGN KEY (KF, ACC_RRR)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS5 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS5 FOREIGN KEY (KF, ACC_RRS)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VPLIST_ACCOUNTS7 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP_LIST ADD CONSTRAINT FK_VPLIST_ACCOUNTS7 FOREIGN KEY (KF, ACC3800)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/VP_LIST.sql =========*** End *** 
PROMPT ===================================================================================== 
