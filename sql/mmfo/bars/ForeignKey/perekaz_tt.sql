

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PEREKAZ_TT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PEREKAZ_TT_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKAZ_TT ADD CONSTRAINT FK_PEREKAZ_TT_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PEREKAZ_TT.sql =========*** End *
PROMPT ===================================================================================== 
