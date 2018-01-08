

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TTS_VOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TTSVOB_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB ADD CONSTRAINT FK_TTSVOB_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSVOB_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB ADD CONSTRAINT FK_TTSVOB_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TTS_VOB.sql =========*** End *** 
PROMPT ===================================================================================== 
