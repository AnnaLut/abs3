

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SPECPARAM_INT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SPECPARAMINT_DEMANDFILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT ADD CONSTRAINT FK_SPECPARAMINT_DEMANDFILS FOREIGN KEY (DEMAND_BRN)
	  REFERENCES BARS.DEMAND_FILIALES (CODE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECINT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT ADD CONSTRAINT FK_SPECINT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SPECINT_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_INT ADD CONSTRAINT FK_SPECINT_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SPECPARAM_INT.sql =========*** En
PROMPT ===================================================================================== 