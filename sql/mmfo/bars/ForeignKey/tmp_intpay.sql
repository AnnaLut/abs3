

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TMP_INTPAY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TMPINTPAY_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_ACCOUNTS3 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_ACCOUNTS4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_ACCOUNTS4 FOREIGN KEY (KF, ACCA)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_TABVAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_TABVAL2 FOREIGN KEY (KVB)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_TABVAL FOREIGN KEY (KVA)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TMPINTPAY_DPTDEPOSIT2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_INTPAY ADD CONSTRAINT FK_TMPINTPAY_DPTDEPOSIT2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT (KF, DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TMP_INTPAY.sql =========*** End *
PROMPT ===================================================================================== 
