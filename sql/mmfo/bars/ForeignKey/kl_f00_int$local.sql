

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/KL_F00_INT$LOCAL.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_KLFINTLOC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT$LOCAL ADD CONSTRAINT FK_KLFINTLOC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLFINTLOC_POLICYGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT$LOCAL ADD CONSTRAINT FK_KLFINTLOC_POLICYGRP FOREIGN KEY (POLICY_GROUP)
	  REFERENCES BARS.POLICY_GROUPS (POLICY_GROUP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLFINTLOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT$LOCAL ADD CONSTRAINT FK_KLFINTLOC FOREIGN KEY (KODF, A017)
	  REFERENCES BARS.KL_F00_INT$GLOBAL (KODF, A017) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLF00INT$LOCAL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00_INT$LOCAL ADD CONSTRAINT FK_KLF00INT$LOCAL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/KL_F00_INT$LOCAL.sql =========***
PROMPT ===================================================================================== 
