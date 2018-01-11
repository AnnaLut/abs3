

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INT_ACCN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INTACCN_INTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_INTION FOREIGN KEY (IO)
	  REFERENCES BARS.INT_ION (IO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_ACCOUNTS FOREIGN KEY (ACRA)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_ACCOUNTS2 FOREIGN KEY (ACRB)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_ACCOUNTS4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_ACCOUNTS4 FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_TABVAL FOREIGN KEY (KVB)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_INTMETR ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_INTMETR FOREIGN KEY (METR)
	  REFERENCES BARS.INT_METR (METR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_BASEM ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_BASEM FOREIGN KEY (BASEM)
	  REFERENCES BARS.BASEM (BASEM) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_TTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_TTS2 FOREIGN KEY (TTB)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INTACCN_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT FK_INTACCN_INTIDN FOREIGN KEY (ID)
	  REFERENCES BARS.INT_IDN (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INT_ACCN.sql =========*** End ***
PROMPT ===================================================================================== 
