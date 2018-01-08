

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OPLDOK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_OPLDOK_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK ADD CONSTRAINT R_OPLDOK_OPER FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPLDOK_OPER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK ADD CONSTRAINT FK_OPLDOK_OPER2 FOREIGN KEY (KF, REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPLDOK_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK ADD CONSTRAINT FK_OPLDOK_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPLDOK_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK ADD CONSTRAINT FK_OPLDOK_SOS FOREIGN KEY (SOS)
	  REFERENCES BARS.SOS (SOS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPLDOK_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK ADD CONSTRAINT FK_OPLDOK_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPLDOK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK ADD CONSTRAINT FK_OPLDOK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_DK_OPLDOK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPLDOK ADD CONSTRAINT R_DK_OPLDOK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OPLDOK.sql =========*** End *** =
PROMPT ===================================================================================== 
