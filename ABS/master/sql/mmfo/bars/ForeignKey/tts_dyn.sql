

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TTS_DYN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TTSDYN_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_DYN ADD CONSTRAINT FK_TTSDYN_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSDYN_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_DYN ADD CONSTRAINT FK_TTSDYN_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TTS_DYN.sql =========*** End *** 
PROMPT ===================================================================================== 
