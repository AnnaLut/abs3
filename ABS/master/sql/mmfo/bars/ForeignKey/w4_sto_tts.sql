

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_STO_TTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_STO_TTS ADD CONSTRAINT FK_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_STO_TTS.sql =========*** End *
PROMPT ===================================================================================== 
