

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_VIDD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUVIDD_FREQ_FREQN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_FREQ_FREQN FOREIGN KEY (FREQ_N)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_FREQ_FREQV ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_FREQ_FREQV FOREIGN KEY (FREQ_V)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_INTMETR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_INTMETR FOREIGN KEY (METR)
	  REFERENCES BARS.INT_METR (METR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_PS_BSD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_PS_BSD FOREIGN KEY (BSD)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_PS_BSN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_PS_BSN FOREIGN KEY (BSN)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_DPUTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_DPUTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.DPU_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDD_DPTVIDDEXTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD ADD CONSTRAINT FK_DPUVIDD_DPTVIDDEXTYPES FOREIGN KEY (EXN_MTH_ID)
	  REFERENCES BARS.DPT_VIDD_EXTYPES (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_VIDD.sql =========*** End ***
PROMPT ===================================================================================== 
