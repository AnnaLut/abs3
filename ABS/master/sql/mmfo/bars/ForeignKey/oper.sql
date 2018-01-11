

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/OPER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_OPER_OPER ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_OPER FOREIGN KEY (KF, REFL)
	  REFERENCES BARS.OPER (KF, REF) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_TABVAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_TABVAL2 FOREIGN KEY (KV2)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_TABVAL3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_TABVAL3 FOREIGN KEY (KVQ)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_OPSOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_OPSOS FOREIGN KEY (SOS)
	  REFERENCES BARS.OP_SOS (SOS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_SK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_SK FOREIGN KEY (SK)
	  REFERENCES BARS.SK (SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_BRANCH3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_BRANCH3 FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_BANKS2 FOREIGN KEY (MFOA)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OPER_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OPER ADD CONSTRAINT FK_OPER_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/OPER.sql =========*** End *** ===
PROMPT ===================================================================================== 
