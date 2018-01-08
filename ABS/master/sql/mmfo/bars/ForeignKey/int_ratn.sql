

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INT_RATN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INTRATN_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_ACCOUNTS2 FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_STAFF FOREIGN KEY (IDU)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_BRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_BRATES FOREIGN KEY (BR)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_INTACCN_INTRATN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT R_INTACCN_INTRATN FOREIGN KEY (ACC, ID)
	  REFERENCES BARS.INT_ACCN (ACC, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATN_INTACCN2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN ADD CONSTRAINT FK_INTRATN_INTACCN2 FOREIGN KEY (KF, ACC, ID)
	  REFERENCES BARS.INT_ACCN (KF, ACC, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INT_RATN.sql =========*** End ***
PROMPT ===================================================================================== 
