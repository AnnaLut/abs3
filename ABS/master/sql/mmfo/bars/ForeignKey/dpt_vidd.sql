

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPT_VIDD_KODZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPT_VIDD_KODZ FOREIGN KEY (KODZ)
	  REFERENCES BARS.ZAPROS (KODZ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DPTTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.DPT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DPTVIDDEXTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DPTVIDDEXTYPES FOREIGN KEY (EXTENSION_ID)
	  REFERENCES BARS.DPT_VIDD_EXTYPES (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTION FOREIGN KEY (TIP_OST)
	  REFERENCES BARS.INT_ION (IO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_FREQ2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_FREQ2 FOREIGN KEY (FREQ_K)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTMETR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTMETR FOREIGN KEY (METR)
	  REFERENCES BARS.INT_METR (METR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTOP FOREIGN KEY (BR_OP)
	  REFERENCES BARS.INT_OP (OP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DOCSCHEME FOREIGN KEY (SHABLON)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_FREQ FOREIGN KEY (FREQ_N)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_PS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PS2 FOREIGN KEY (BSN)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PS FOREIGN KEY (BSD)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DPTSTOP FOREIGN KEY (ID_STOP)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTMETR2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTMETR2 FOREIGN KEY (AMR_METR)
	  REFERENCES BARS.INT_METR (METR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_PS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PS3 FOREIGN KEY (BSA)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_ZAPROSFMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_ZAPROSFMT FOREIGN KEY (FMT)
	  REFERENCES BARS.ZAPROS_FMT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD.sql =========*** End ***
PROMPT ===================================================================================== 
