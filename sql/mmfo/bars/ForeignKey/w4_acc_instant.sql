

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/W4_ACC_INSTANT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_W4ACCINSTANT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INSTANT ADD CONSTRAINT FK_W4ACCINSTANT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/W4_ACC_INSTANT.sql =========*** E
PROMPT ===================================================================================== 
