

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/RESOUR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_RESOUR_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.RESOUR ADD CONSTRAINT FK_RESOUR_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RESOUR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.RESOUR ADD CONSTRAINT FK_RESOUR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/RESOUR.sql =========*** End *** =
PROMPT ===================================================================================== 
