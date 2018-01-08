

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KL_F13_ZBSK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLF13ZBSK_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F13_ZBSK ADD CONSTRAINT FK_KLF13ZBSK_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KL_F13_ZBSK.sql =========*** End 
PROMPT ===================================================================================== 
