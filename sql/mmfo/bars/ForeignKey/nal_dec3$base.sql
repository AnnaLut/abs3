

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NAL_DEC3$BASE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NALDEC3$BASE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NAL_DEC3$BASE ADD CONSTRAINT FK_NALDEC3$BASE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NAL_DEC3$BASE.sql =========*** En
PROMPT ===================================================================================== 
