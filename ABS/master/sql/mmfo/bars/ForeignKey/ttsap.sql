

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TTSAP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TTSAP_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP ADD CONSTRAINT FK_TTSAP_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSAP_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP ADD CONSTRAINT FK_TTSAP_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSAP_TTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP ADD CONSTRAINT FK_TTSAP_TTS2 FOREIGN KEY (TTAP)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TTSAP.sql =========*** End *** ==
PROMPT ===================================================================================== 
