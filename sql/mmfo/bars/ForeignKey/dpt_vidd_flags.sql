

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_FLAGS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTVIDDFLAGS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS ADD CONSTRAINT FK_DPTVIDDFLAGS_TTS FOREIGN KEY (MAIN_TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDFLAGS_DPTREQTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_FLAGS ADD CONSTRAINT FK_DPTVIDDFLAGS_DPTREQTYPES FOREIGN KEY (REQUEST_TYPECODE)
	  REFERENCES BARS.DPT_REQ_TYPES (REQTYPE_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_VIDD_FLAGS.sql =========*** E
PROMPT ===================================================================================== 
