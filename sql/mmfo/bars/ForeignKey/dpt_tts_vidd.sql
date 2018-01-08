

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TTS_VIDD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTTTSVIDD_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD ADD CONSTRAINT FK_DPTTTSVIDD_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTTTSVIDD_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TTS_VIDD ADD CONSTRAINT FK_DPTTTSVIDD_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_TTS_VIDD.sql =========*** End
PROMPT ===================================================================================== 
