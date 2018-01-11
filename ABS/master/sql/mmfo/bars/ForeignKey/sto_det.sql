

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_DET.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STODET_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_STOLST ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_STOLST FOREIGN KEY (IDS)
	  REFERENCES BARS.STO_LST (IDS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_USER_MADE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_USER_MADE FOREIGN KEY (USERID_MADE)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_BRANCHMADE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_BRANCHMADE FOREIGN KEY (BRANCH_MADE)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_BRANCH_CARD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_BRANCH_CARD FOREIGN KEY (BRANCH_CARD)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STATUS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STATUS_ID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.STO_STATUS (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DISCLAIM_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_DISCLAIM_ID FOREIGN KEY (DISCLAIM_ID)
	  REFERENCES BARS.STO_DISCLAIMER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STODET_STOLST2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT FK_STODET_STOLST2 FOREIGN KEY (KF, IDS)
	  REFERENCES BARS.STO_LST (KF, IDS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_DET.sql =========*** End *** 
PROMPT ===================================================================================== 
