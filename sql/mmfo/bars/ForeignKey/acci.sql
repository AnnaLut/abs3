

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCI.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCI_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCI ADD CONSTRAINT FK_ACCI_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCI_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCI ADD CONSTRAINT FK_ACCI_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCI.sql =========*** End *** ===
PROMPT ===================================================================================== 
