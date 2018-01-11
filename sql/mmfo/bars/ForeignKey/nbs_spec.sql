

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NBS_SPEC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_NBSSPEC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT FK_NBSSPEC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSSPEC_PEREKRG ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT FK_NBSSPEC_PEREKRG FOREIGN KEY (KF, IDG)
	  REFERENCES BARS.PEREKR_G (KF, IDG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSSPEC_PEREKRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT FK_NBSSPEC_PEREKRS FOREIGN KEY (KF, IDS)
	  REFERENCES BARS.PEREKR_S (KF, IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBSSPEC_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_SPEC ADD CONSTRAINT FK_NBSSPEC_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NBS_SPEC.sql =========*** End ***
PROMPT ===================================================================================== 
