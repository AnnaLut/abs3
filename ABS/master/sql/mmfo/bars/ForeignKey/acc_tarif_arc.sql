

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_TARIF_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCTARIFARC_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT FK_ACCTARIFARC_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTARIFARC_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT FK_ACCTARIFARC_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTARIFARC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_TARIF_ARC ADD CONSTRAINT FK_ACCTARIFARC_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_TARIF_ARC.sql =========*** En
PROMPT ===================================================================================== 
