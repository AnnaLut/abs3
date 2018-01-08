

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KLP_ZVIDM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLPZVIDM_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZVIDM ADD CONSTRAINT FK_KLPZVIDM_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZVIDM_FL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZVIDM ADD CONSTRAINT FK_KLPZVIDM_FL FOREIGN KEY (FL)
	  REFERENCES BARS.KLP_FL (FL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KLP_ZVIDM.sql =========*** End **
PROMPT ===================================================================================== 
