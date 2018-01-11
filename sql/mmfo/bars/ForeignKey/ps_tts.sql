

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PS_TTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PSTTS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT FK_PSTTS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PSTTS_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT FK_PSTTS_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PSTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS_TTS ADD CONSTRAINT FK_PSTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PS_TTS.sql =========*** End *** =
PROMPT ===================================================================================== 
