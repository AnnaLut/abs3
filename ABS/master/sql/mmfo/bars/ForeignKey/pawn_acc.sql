

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PAWN_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PAWN_ACC_IDZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC ADD CONSTRAINT FK_PAWN_ACC_IDZ FOREIGN KEY (IDZ)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAWN_ACC_MPAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC ADD CONSTRAINT FK_PAWN_ACC_MPAWN FOREIGN KEY (MPAWN)
	  REFERENCES BARS.CC_MPAWN (MPAWN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAWN_ACC_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC ADD CONSTRAINT FK_PAWN_ACC_PAWN FOREIGN KEY (PAWN)
	  REFERENCES BARS.CC_PAWN (PAWN) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAWNACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC ADD CONSTRAINT FK_PAWNACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAWNACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC ADD CONSTRAINT FK_PAWNACC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PAWN_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
