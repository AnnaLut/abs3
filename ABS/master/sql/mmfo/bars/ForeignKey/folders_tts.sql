

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FOLDERS_TTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FOLDERSTTS_FOLDERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS_TTS ADD CONSTRAINT FK_FOLDERSTTS_FOLDERS FOREIGN KEY (IDFO)
	  REFERENCES BARS.FOLDERS (IDFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FOLDERSTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS_TTS ADD CONSTRAINT FK_FOLDERSTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FOLDERS_TTS.sql =========*** End 
PROMPT ===================================================================================== 
