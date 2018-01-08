

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_989917_REF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC989917REF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_989917_REF ADD CONSTRAINT FK_CC989917REF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CC989917REF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_989917_REF ADD CONSTRAINT FK_CC989917REF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_989917_REF.sql =========*** En
PROMPT ===================================================================================== 
