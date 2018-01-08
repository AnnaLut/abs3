

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_STMT_INFO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWSTMTINFO_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO ADD CONSTRAINT FK_SWSTMTINFO_SWJOURNAL FOREIGN KEY (LAST_MESSAGE_REF)
	  REFERENCES BARS.SW_JOURNAL (SWREF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSTMTINFO_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO ADD CONSTRAINT FK_SWSTMTINFO_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSTMTINFO_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_INFO ADD CONSTRAINT FK_SWSTMTINFO_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_STMT_INFO.sql =========*** End
PROMPT ===================================================================================== 
