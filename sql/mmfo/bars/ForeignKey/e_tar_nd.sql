

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/E_TAR_ND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_E_TAR_ND_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND ADD CONSTRAINT FK_E_TAR_ND_ID FOREIGN KEY (KF, ID)
	  REFERENCES BARS.E_TARIF (KF, ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ETARND_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND ADD CONSTRAINT FK_ETARND_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ETARND_EDEAL$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TAR_ND ADD CONSTRAINT FK_ETARND_EDEAL$BASE FOREIGN KEY (KF, ND)
	  REFERENCES BARS.E_DEAL$BASE (KF, ND) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/E_TAR_ND.sql =========*** End ***
PROMPT ===================================================================================== 
