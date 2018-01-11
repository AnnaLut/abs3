

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KP_TTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint SYS_C0014957 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KP_TTS ADD FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KP_TTS.sql =========*** End *** =
PROMPT ===================================================================================== 
