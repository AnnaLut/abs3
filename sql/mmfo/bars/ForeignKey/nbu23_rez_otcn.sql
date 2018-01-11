

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBU23_REZ_OTCN.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBU23REZOTCN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_REZ_OTCN ADD CONSTRAINT FK_NBU23REZOTCN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBU23_REZ_OTCN.sql =========*** E
PROMPT ===================================================================================== 
