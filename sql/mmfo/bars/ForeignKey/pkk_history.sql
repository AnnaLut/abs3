

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PKK_HISTORY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PKKHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY ADD CONSTRAINT FK_PKKHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PKKHISTORY_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_HISTORY ADD CONSTRAINT FK_PKKHISTORY_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PKK_HISTORY.sql =========*** End 
PROMPT ===================================================================================== 
