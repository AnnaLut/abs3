

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_B.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PEREKRB_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_PEREKRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_PEREKRS FOREIGN KEY (KF, IDS)
	  REFERENCES BARS.PEREKR_S (KF, IDS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_PEREKRR ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_PEREKRR FOREIGN KEY (KF, IDR)
	  REFERENCES BARS.PEREKR_R (KF, IDR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_B.sql =========*** End ***
PROMPT ===================================================================================== 
