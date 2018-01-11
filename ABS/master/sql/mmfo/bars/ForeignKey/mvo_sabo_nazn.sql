

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MVO_SABO_NAZN.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MVO_SABO_NAZN_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVO_SABO_NAZN ADD CONSTRAINT FK_MVO_SABO_NAZN_TT FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MVO_SABO_NAZN_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.MVO_SABO_NAZN ADD CONSTRAINT FK_MVO_SABO_NAZN_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MVO_SABO_NAZN.sql =========*** En
PROMPT ===================================================================================== 
