

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_950.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SW950_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_ACCOUNTS2 FOREIGN KEY (KF, NOSTRO_ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SW950_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_950 ADD CONSTRAINT FK_SW950_SWJOURNAL FOREIGN KEY (SWREF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_950.sql =========*** End *** =
PROMPT ===================================================================================== 
