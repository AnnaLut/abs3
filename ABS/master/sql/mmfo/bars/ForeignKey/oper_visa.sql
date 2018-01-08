

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OPER_VISA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OPERVISA_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_CHKLIST FOREIGN KEY (GROUPID)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_BPREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_BPREASON FOREIGN KEY (PASSIVE_REASONID)
	  REFERENCES BARS.BP_REASON (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_INCHARGELIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_INCHARGELIST FOREIGN KEY (F_IN_CHARGE)
	  REFERENCES BARS.IN_CHARGE_LIST (IN_CHARGE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPERVISA_STAFF$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER_VISA ADD CONSTRAINT FK_OPERVISA_STAFF$BASE FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OPER_VISA.sql =========*** End **
PROMPT ===================================================================================== 
