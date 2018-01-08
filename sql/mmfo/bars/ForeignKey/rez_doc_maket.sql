

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/REZ_DOC_MAKET.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REZ6_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DOC_MAKET ADD CONSTRAINT FK_REZ6_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REZDOCMAKET_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DOC_MAKET ADD CONSTRAINT FK_REZDOCMAKET_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/REZ_DOC_MAKET.sql =========*** En
PROMPT ===================================================================================== 
