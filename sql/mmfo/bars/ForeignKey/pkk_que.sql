

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PKK_QUE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PKKQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE ADD CONSTRAINT FK_PKKQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PKKQUE_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_QUE ADD CONSTRAINT FK_PKKQUE_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PKK_QUE.sql =========*** End *** 
PROMPT ===================================================================================== 