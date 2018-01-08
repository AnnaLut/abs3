

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TTS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TTS_INTERBANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT FK_TTS_INTERBANK FOREIGN KEY (FLI)
	  REFERENCES BARS.INTERBANK (FLI) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT FK_TTS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT FK_TTS_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT FK_TTS_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTS_TABVAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT FK_TTS_TABVAL2 FOREIGN KEY (KVK)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TTS.sql =========*** End *** ====
PROMPT ===================================================================================== 
