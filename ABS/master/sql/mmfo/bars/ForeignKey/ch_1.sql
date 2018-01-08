

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CH_1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CH_1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_1 ADD CONSTRAINT FK_CH_1 FOREIGN KEY (IDS)
	  REFERENCES BARS.CH_1S (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CH_1_MFOA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_1 ADD CONSTRAINT FK_CH_1_MFOA FOREIGN KEY (MFOA)
	  REFERENCES BARS.CH_1A (MFOA) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CH_1.sql =========*** End *** ===
PROMPT ===================================================================================== 
