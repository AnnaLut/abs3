

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_950D.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SW950D_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_ACCOUNTS2 FOREIGN KEY (KF, CONTRA_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_SWTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_SWTT FOREIGN KEY (SWTT)
	  REFERENCES BARS.SW_TT (SWTT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950D_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950D ADD CONSTRAINT FK_SW950D_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_950D.sql =========*** End *** 
PROMPT ===================================================================================== 
