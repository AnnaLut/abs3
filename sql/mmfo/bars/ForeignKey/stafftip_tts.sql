

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_TTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFTIPTTS_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_TTS ADD CONSTRAINT FK_STAFFTIPTTS_STAFFTIPS FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_TTS ADD CONSTRAINT FK_STAFFTIPTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_TTS.sql =========*** End
PROMPT ===================================================================================== 
