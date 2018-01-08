

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBS_PROF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBS_PROF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROF ADD CONSTRAINT FK_NBS_PROF FOREIGN KEY (KF, NBS, NP)
	  REFERENCES BARS.NBS_PROFNAM (KF, NBS, NP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSPROF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_PROF ADD CONSTRAINT FK_NBSPROF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBS_PROF.sql =========*** End ***
PROMPT ===================================================================================== 
