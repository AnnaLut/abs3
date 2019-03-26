

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INV_CCK_FL_23.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INVCCKFL23_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INV_CCK_FL_23 ADD CONSTRAINT FK_INVCCKFL23_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INV_CCK_FL_23.sql =========*** En
PROMPT ===================================================================================== 