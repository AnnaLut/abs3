

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_OVER_ARCHIVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCOVERARCHIVE_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_ARCHIVE ADD CONSTRAINT FK_ACCOVERARCHIVE_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVERARCHIVE_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_ARCHIVE ADD CONSTRAINT FK_ACCOVERARCHIVE_ACCOUNTS2 FOREIGN KEY (KF, ACCO)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_OVER_ARCHIVE.sql =========***
PROMPT ===================================================================================== 
