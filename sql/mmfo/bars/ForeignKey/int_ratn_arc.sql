

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INT_RATN_ARC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INTRATNARC_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC ADD CONSTRAINT FK_INTRATNARC_STAFF FOREIGN KEY (IDU)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATNARC_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC ADD CONSTRAINT FK_INTRATNARC_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATNARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC ADD CONSTRAINT FK_INTRATNARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTRATNARC_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RATN_ARC ADD CONSTRAINT FK_INTRATNARC_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INT_RATN_ARC.sql =========*** End
PROMPT ===================================================================================== 
