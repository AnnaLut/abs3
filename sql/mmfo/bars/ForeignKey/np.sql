

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NP ADD CONSTRAINT FK_NP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NP_STAFF$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NP ADD CONSTRAINT FK_NP_STAFF$BASE FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NP.sql =========*** End *** =====
PROMPT ===================================================================================== 
