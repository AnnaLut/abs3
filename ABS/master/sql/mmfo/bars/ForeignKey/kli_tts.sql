

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLI_TTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLI_TTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLI_TTS ADD CONSTRAINT FK_KLI_TTS_TTS FOREIGN KEY (TTS)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLI_TTS.sql =========*** End *** 
PROMPT ===================================================================================== 
