

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_A.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PEREKRA_PEREKRG ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A ADD CONSTRAINT FK_PEREKRA_PEREKRG FOREIGN KEY (KF, IDG)
	  REFERENCES BARS.PEREKR_G (KF, IDG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A ADD CONSTRAINT FK_PEREKRA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRA_PEREKRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_A ADD CONSTRAINT FK_PEREKRA_PEREKRS FOREIGN KEY (KF, IDS)
	  REFERENCES BARS.PEREKR_S (KF, IDS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_A.sql =========*** End ***
PROMPT ===================================================================================== 
