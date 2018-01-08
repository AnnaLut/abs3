

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_TT_TTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWTTTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_TTS ADD CONSTRAINT FK_SWTTTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWTTTTS_SWTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_TTS ADD CONSTRAINT FK_SWTTTTS_SWTT FOREIGN KEY (SWTT)
	  REFERENCES BARS.SW_TT (SWTT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_TT_TTS.sql =========*** End **
PROMPT ===================================================================================== 
