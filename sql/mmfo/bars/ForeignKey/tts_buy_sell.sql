

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TTS_BUY_SELL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TTSBUYSELL_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_BUY_SELL ADD CONSTRAINT FK_TTSBUYSELL_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TTS_BUY_SELL.sql =========*** End
PROMPT ===================================================================================== 
