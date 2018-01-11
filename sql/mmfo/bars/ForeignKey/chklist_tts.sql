

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CHKLIST_TTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CHKLISTTTS_CHKLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT FK_CHKLISTTTS_CHKLIST FOREIGN KEY (IDCHK)
	  REFERENCES BARS.CHKLIST (IDCHK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CHKLISTTTS_INCHARGELIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT FK_CHKLISTTTS_INCHARGELIST FOREIGN KEY (F_IN_CHARGE)
	  REFERENCES BARS.IN_CHARGE_LIST (IN_CHARGE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CHKLISTTTS_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKLIST_TTS ADD CONSTRAINT FK_CHKLISTTTS_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CHKLIST_TTS.sql =========*** End 
PROMPT ===================================================================================== 
