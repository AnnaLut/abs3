

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REZ_SPN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REZSPN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_SPN ADD CONSTRAINT FK_REZSPN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REZ_SPN.sql =========*** End *** 
PROMPT ===================================================================================== 
