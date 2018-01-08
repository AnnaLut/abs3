

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_B_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_PRKRB_UPD_R ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE ADD CONSTRAINT R_PRKRB_UPD_R FOREIGN KEY (KF, IDR)
	  REFERENCES BARS.PEREKR_R (KF, IDR) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PRKRB_UPD_S ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE ADD CONSTRAINT R_PRKRB_UPD_S FOREIGN KEY (KF, IDS)
	  REFERENCES BARS.PEREKR_S (KF, IDS) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRBUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE ADD CONSTRAINT FK_PEREKRBUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PEREKR_B_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
